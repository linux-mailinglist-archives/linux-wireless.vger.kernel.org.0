Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2402A1B7109
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 11:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgDXJgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 05:36:22 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:27621 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbgDXJgW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 05:36:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587720981; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=eDppVW3s5KZ+nAtAh38HIss61FKkufNqbyyxT9Qjhsk=; b=wL+zWed5EIRNnjWmLja4H1pfgohSf+dbuaELzbOkmKrarq9iIHxwxdouEXn2vGjg0Tq629r+
 XJnu5/BJ1OSo+GLlIKW28wB9TwxseKhba+KHeAmSf7VNA0+KiPemCmpspLqc043ac7iNgWtb
 HIosjHDydeKv56XR5Ty+G0/MkAw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea2b30a.7f7217f70ae8-smtp-out-n05;
 Fri, 24 Apr 2020 09:36:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61170C433CB; Fri, 24 Apr 2020 09:36:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF1A4C433D2;
        Fri, 24 Apr 2020 09:36:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF1A4C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: [PATCH 1/2] mac80211: enable TKIP when using encapsulation offloading
Date:   Fri, 24 Apr 2020 15:05:50 +0530
Message-Id: <1587720951-9222-2-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
References: <1587720951-9222-1-git-send-email-murugana@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TKIP was disabled on encap offload mode since if TKIP MIC error
reporting is not capable by the driver using encap offload mode,
then TKIP countermeasures wont work.

Enabling back TKIP bring-up in encap offload mode to leave the
control with the driver to disable hw encap when it is not capable
of TKIP MIC error reporting.

Fixes: 50ff477a8639 ("mac80211: add 802.11 encapsulation offloading support")
Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
---
 net/mac80211/iface.c | 7 -------
 net/mac80211/key.c   | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index d069825705d6..68af8acde0f0 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1257,13 +1257,6 @@ bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable)
 	    (local->hw.wiphy->frag_threshold != (u32)-1))
 		enable = false;
 
-	mutex_lock(&sdata->local->key_mtx);
-	list_for_each_entry(key, &sdata->key_list, list) {
-		if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP)
-			enable = false;
-	}
-	mutex_unlock(&sdata->local->key_mtx);
-
 	__ieee80211_set_hw_80211_encap(sdata, enable);
 
 	return enable;
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 8f403c1bb908..25cab6fc127c 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -177,13 +177,6 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 		}
 	}
 
-	/* TKIP countermeasures don't work in encap offload mode */
-	if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP &&
-	    sdata->hw_80211_encap) {
-		sdata_dbg(sdata, "TKIP is not allowed in hw 80211 encap mode\n");
-		return -EINVAL;
-	}
-
 	ret = drv_set_key(key->local, SET_KEY, sdata,
 			  sta ? &sta->sta : NULL, &key->conf);
 
-- 
2.7.4
