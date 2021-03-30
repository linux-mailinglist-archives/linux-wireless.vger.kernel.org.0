Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6F034F4FB
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Mar 2021 01:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhC3XYB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 19:24:01 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:51908 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbhC3XXr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 19:23:47 -0400
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0312E13C2B0;
        Tue, 30 Mar 2021 16:23:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0312E13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1617146627;
        bh=K2CmXysb17d8HTR4njnzZrLvXIMta7ith6EHODbM24Q=;
        h=To:From:Subject:Date:From;
        b=hQoSy4KHcBqtu8W2MumAkJVrj/p6gt/6TBeUe5QAafJU3OK/oglvVttGSrFSjeGVC
         5utsc9IP51e7O4lyXJwmYxQnQQj0PD4c8Cp953MDL+sFAlbimYQnV4EJD8Fi3+F141
         S8Iq0beHg/Rakzivs6WnaRPXoOAoYcTOZK15NjLo=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        shay.bar@celeno.com
From:   Ben Greear <greearb@candelatech.com>
Subject: Question on "mac80211: HE STA disassoc due to QOS NULL not sent"
Organization: Candela Technologies
Message-ID: <3c89f6f5-f094-4d1a-f254-6ca7483b54e5@candelatech.com>
Date:   Tue, 30 Mar 2021 16:23:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While debugging a station polling issue.  Should it maybe send
a probe request instead of just not probing at all?

commit f39b07fdfb688724fedabf5507e15eaf398f2500
Author: Shay Bar <shay.bar@celeno.com>
Date:   Wed Jul 3 16:18:48 2019 +0300

     mac80211: HE STA disassoc due to QOS NULL not sent

     In case of HE AP-STA link, ieee80211_send_nullfunc() will not
     send the QOS NULL packet to check if AP is still associated.

     In this case, probe_send_count will be non-zero and
     ieee80211_sta_work() will later disassociate the AP, even
     though no packet was ever sent.

     Fix this by decrementing probe_send_count and not calling
     ieee80211_send_nullfunc() in case of HE link, so that we
     still wait for some time for the AP beacon to reappear and
     don't disconnect right away.

     Signed-off-by: Shay Bar <shay.bar@celeno.com>
     Link: https://lore.kernel.org/r/20190703131848.22879-1-shay.bar@celeno.com
     [clarify commit message]
     Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 225633d9e2d4bd..e89ed800f01259 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2512,7 +2512,10 @@ static void ieee80211_mgd_probe_ap_send(struct ieee80211_sub_if_data *sdata)

         if (ieee80211_hw_check(&sdata->local->hw, REPORTS_TX_ACK_STATUS)) {
                 ifmgd->nullfunc_failed = false;
-               ieee80211_send_nullfunc(sdata->local, sdata, false);
+               if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
+                       ifmgd->probe_send_count--;
+               else
+                       ieee80211_send_nullfunc(sdata->local, sdata, false);
         } else {
                 int ssid_len;


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
