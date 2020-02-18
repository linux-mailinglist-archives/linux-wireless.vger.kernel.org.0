Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1072F1620AC
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Feb 2020 07:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgBRGJR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Feb 2020 01:09:17 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:56797 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726065AbgBRGJQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Feb 2020 01:09:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582006156; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: Cc: To: From: Sender;
 bh=jvUIftSI+puVhxeOsI6JCjPKuws+jgLNARRv+Ta2j9Q=; b=n5MS4s1D5ve3gAy3fMlkNj7v9NdWeDkLLwMaJWAWIqVfdlyvxkn7Eu8mCgWcdOd7a5obxmBb
 7axoqdU4UydJHTKh/k3TBX/C6UXdV4SojymGT//cnUbnFFxEY2hOgsmLfVfBKpBsN+SSyp/H
 8A8ehvH2rfs1+VzIGdtjwvZurP0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4b7f8b.7fb6066db500-smtp-out-n01;
 Tue, 18 Feb 2020 06:09:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 958F1C4479C; Tue, 18 Feb 2020 06:09:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from MURUGANA (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42CA1C43383;
        Tue, 18 Feb 2020 06:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42CA1C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   "Sathishkumar Muruganandam" <murugana@codeaurora.org>
To:     "'Luca Coelho'" <luciano.coelho@intel.com>,
        "'Johannes Berg'" <johannes@sipsolutions.net>
Cc:     <linux-wireless@vger.kernel.org>
Subject: 4addr NDP in HE mode
Date:   Tue, 18 Feb 2020 11:39:09 +0530
Message-ID: <006501d5e621$f21f3b60$d65db220$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdXmIW6IXqNgMYNsTGuVGA+jdzZjxw==
Content-Language: en-us
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Luca, Johannes,

We see that HE STA in 4addr mode is not able to pass traffic since 4addr NDP
frame after successful association is blocked in below commit. There is no
AP/VLAN interface created on the 4addr AP side as well.

commit 41cbb0f5a29592874355 "mac80211: add support for HE"

@@ -929,6 +1020,10 @@ static void ieee80211_send_4addr_nullfunc(struct
ieee80211_local *local,
        if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION))
                return;

+       /* Don't send NDPs when connected HE */
+       if (!(sdata->u.mgd.flags & IEEE80211_STA_DISABLE_HE))
+               return;
+
        skb = dev_alloc_skb(local->hw.extra_tx_headroom + 30);
        if (!skb)
                return;

Since ieee80211_send_4addr_nullfunc() is only called for successful
association of 4addr STA, shall we allow below case alone for HE ?

static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
                                    struct cfg80211_bss *cbss,
                                    struct ieee80211_mgmt *mgmt, size_t len,
                                    struct ieee802_11_elems *elems)
{
..
  /*
         * If we're using 4-addr mode, let the AP know that we're
         * doing so, so that it can create the STA VLAN on its side
         */
        if (ifmgd->use_4addr)
                ieee80211_send_4addr_nullfunc(local, sdata);
..

Whether this 4addr NDP in HE mode will affect any UL-MIMO from the 4addr STA
? Please comment.

Thanks,
Sathishkumar


