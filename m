Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290F41CBBA9
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 02:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgEIANl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 20:13:41 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22985 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728381AbgEIANl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 20:13:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588983220; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WYuQjWhAWvV4B+xX0+ZrAqZxe1/l+4HAU8Fy8l/RZMY=; b=QzOvU1SfUkKcBW0IWEkLa6SodPv854KqXdhzbNLP+LuwNF9kHIlQ6u5aVUMYmhRSNU+okxnG
 lgv+fNhttEklHnlOohDiwvmSOqBzie6GAi7eR+WO2J1R6ZmkfOutCvWAwZhfdg3jJ8SxrqyX
 vdmC0Asom5gehe+zGfy89vMJbZw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb5f5a7.7f2fa0b3e618-smtp-out-n02;
 Sat, 09 May 2020 00:13:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7C5FC433BA; Sat,  9 May 2020 00:13:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 161DDC4478C;
        Sat,  9 May 2020 00:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 161DDC4478C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v3 09/11] mac80211: do not allow HT/VHT IEs in 6 GHz mesh mode
Date:   Fri,  8 May 2020 17:13:03 -0700
Message-Id: <1588983185-5741-9-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588983185-5741-1-git-send-email-rmanohar@codeaurora.org>
References: <1588983185-5741-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As HT/VHT elements are not allowed in 6 GHz band, do not include
them in mesh beacon template formation.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 net/mac80211/mesh.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 0cbe3260c5c1..04d3da733bc8 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -415,6 +415,10 @@ int mesh_add_ht_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return -EINVAL;
 
+	/* HT not allowed in 6 GHz */
+	if (sband->band == NL80211_BAND_6GHZ)
+		return 0;
+
 	if (!sband->ht_cap.ht_supported ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
@@ -452,6 +456,10 @@ int mesh_add_ht_oper_ie(struct ieee80211_sub_if_data *sdata,
 	sband = local->hw.wiphy->bands[channel->band];
 	ht_cap = &sband->ht_cap;
 
+	/* HT not allowed in 6 GHz */
+	if (sband->band == NL80211_BAND_6GHZ)
+		return 0;
+
 	if (!ht_cap->ht_supported ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
@@ -479,6 +487,10 @@ int mesh_add_vht_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return -EINVAL;
 
+	/* VHT not allowed in 6 GHz */
+	if (sband->band == NL80211_BAND_6GHZ)
+		return 0;
+
 	if (!sband->vht_cap.vht_supported ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
@@ -516,6 +528,10 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 	sband = local->hw.wiphy->bands[channel->band];
 	vht_cap = &sband->vht_cap;
 
+	/* VHT not allowed in 6 GHz */
+	if (sband->band == NL80211_BAND_6GHZ)
+		return 0;
+
 	if (!vht_cap->vht_supported ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_20_NOHT ||
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_5 ||
-- 
2.7.4
