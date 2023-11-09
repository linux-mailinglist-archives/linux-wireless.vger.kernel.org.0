Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE837E7152
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Nov 2023 19:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344959AbjKISWK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 13:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjKISWJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 13:22:09 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D603C02
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 10:22:07 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4AD4DC0006B
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 18:22:05 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 7E3F413C2B0;
        Thu,  9 Nov 2023 10:22:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7E3F413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699554124;
        bh=WHqkI/0jIbJVGT7CFO1fNaJmgPnH9gEuI6spPHZD3Ks=;
        h=From:To:Cc:Subject:Date:From;
        b=CHsNZEf78uvXoFzRh/c8M5kEL/3lpx/4kW2dlr1G3CM/cxw5OpOQCKEddtMyL9tmX
         RgKVT/UZjhNT9RxGVCQ/iPd7eeWXL6QHX1tT0spBOR4PUYq8PvxCmUK+UUsgrcRiW0
         /59MHdVPz/7YYGQsVoSDy12qrfdCrRs1gXLKwfoE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211:  Handle 320Mhz in ieee80211_ht_cap_ie_to_sta_ht_cap
Date:   Thu,  9 Nov 2023 10:22:01 -0800
Message-ID: <20231109182201.495381-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1699554126-PFESb0qaqpFJ
X-MDID-O: us5;at1;1699554126;PFESb0qaqpFJ;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

I saw a splat in the switch statement, I think because 320Mhz was
not specified..

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/ht.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 68cea2685224..749f4ecab990 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -271,6 +271,7 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 	case NL80211_CHAN_WIDTH_80:
 	case NL80211_CHAN_WIDTH_80P80:
 	case NL80211_CHAN_WIDTH_160:
+	case NL80211_CHAN_WIDTH_320:
 		bw = ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
 		break;
-- 
2.41.0

