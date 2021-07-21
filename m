Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8988B3D18F7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jul 2021 23:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhGUUkj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jul 2021 16:40:39 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64440 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGUUki (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jul 2021 16:40:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626902475; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+0gTMSpTe4VOdR/em1UPwDrws0mGZ8rGLV1xcfNcHsU=; b=g//ZjfPI4v/ybx7rIOOn0Rd+dkXlc/21HERDHGnvO8igU2d8kTWS5+rTatLUyZ9fuI34MKCR
 6akh9qNPDbUddZAfwsGa1VJS8RO2CSVEDscEEPKgZ2SBN0dbOCNhWEvUOfPDrS8etBpTFJrF
 +wg1lwb8DYzzLVDxeyRcXGde1KA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60f88fc51dd16c8788c39398 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 21:21:09
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F5EDC433D3; Wed, 21 Jul 2021 21:21:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F76EC43217;
        Wed, 21 Jul 2021 21:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F76EC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Lavanya Suresh <lavaks@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 11/12] ath11k: Clear auth flag only for actual association in security mode
Date:   Thu, 22 Jul 2021 00:20:28 +0300
Message-Id: <20210721212029.142388-11-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210721212029.142388-1-jouni@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lavanya Suresh <lavaks@codeaurora.org>

AUTH flag is needed when peer assoc command is sent from the host in
security mode for non-assoc cases. The firmware will handle AUTH flag
when the client is associating as AUTH flag will be set after key
exchange. For internally provided peer assoc commands from the host,
there won't be any key exchange, so AUTH flag is expected to be set in
the host.

Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 3 +++
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 drivers/net/wireless/ath/ath11k/wmi.h | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 11276617a11f..5ab42324a564 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2300,6 +2300,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 
 	rcu_read_unlock();
 
+	peer_arg.is_assoc = true;
 	ret = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
@@ -3563,6 +3564,7 @@ static int ath11k_station_assoc(struct ath11k *ar,
 
 	ath11k_peer_assoc_prepare(ar, vif, sta, &peer_arg, reassoc);
 
+	peer_arg.is_assoc = true;
 	ret = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
@@ -3774,6 +3776,7 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 			ath11k_peer_assoc_prepare(ar, arvif->vif, sta,
 						  &peer_arg, true);
 
+			peer_arg.is_assoc = false;
 			err = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 			if (err)
 				ath11k_warn(ar->ab, "failed to run peer assoc for STA %pM vdev %i: %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6d2696db1e07..5e196829ecf3 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1762,7 +1762,7 @@ ath11k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 		cmd->peer_flags |= WMI_PEER_AUTH;
 	if (param->need_ptk_4_way) {
 		cmd->peer_flags |= WMI_PEER_NEED_PTK_4_WAY;
-		if (!hw_crypto_disabled)
+		if (!hw_crypto_disabled && param->is_assoc)
 			cmd->peer_flags &= ~WMI_PEER_AUTH;
 	}
 	if (param->need_gtk_2_way)
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 2587d22f42ce..e831d268db1d 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3617,6 +3617,7 @@ struct peer_assoc_params {
 	u32 peer_he_tx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];
 	bool twt_responder;
 	bool twt_requester;
+	bool is_assoc;
 	struct ath11k_ppe_threshold peer_ppet;
 };
 
-- 
2.25.1

