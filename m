Return-Path: <linux-wireless+bounces-15893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F79C9E3FB4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 17:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EBCB282AB9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 16:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C6B156C6A;
	Wed,  4 Dec 2024 16:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1m2QM/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD620C48F
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733329941; cv=none; b=gT9Bn368OCAXnc46svVE8y/h74Uufyd4qguU19I7PsO7zIYMc+90pIDwR8mMYH31G8gtG/D5WWlaMvkl6zrvIW9tJqNYFs1aSyMRLOWCZYrPl+ns712c4TDjLj55Xs2zM7B8Dec77HoQRwROY2HRMvcg0F3AQoOa6gd6B1LkaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733329941; c=relaxed/simple;
	bh=5NgdQtgdx9L6DLYrc7Hr1UkgwpKbPHyj9dlHR5lrHxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXWwyFda2yaPPmF/OEIKLNRrhpkUOrCd7eqlGIRNJEzbkXGeROMxufvIpm5pUExK0Pi3smqnAOSrd+zeD1zj3tAEUsMgeFuY2PNhhSLGtF97Xq4wQHquVlBYTOX/8QV3BnMz7BGh+og9rPQa4cBwS4qqrvrsdNJigw1Ns7ZGCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1m2QM/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17390C4CEDF;
	Wed,  4 Dec 2024 16:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733329940;
	bh=5NgdQtgdx9L6DLYrc7Hr1UkgwpKbPHyj9dlHR5lrHxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1m2QM/IYsHu2P2KI6NHqw9tdNSanIGypnbAcJj1LXuOyGN17Et6mduC96xLnUOA6
	 jZwtdB9yDntUULDrPOLY5sbclYcEeIESbQaY5hItdwXSp7GlzWQjKnYeEoXZUZJHTG
	 veIlPpAf+PP+N/eqjcbrPITvRKO3AbxxPKFMoOHJfLtsmgEkLmybmKrmXqsXSNfL4N
	 Yyc1qqhyVVBeh3gq6QcwSBWxlqXTZYN+5QSyXM/m/dLLT85AheOc+yIlNbOWVJKKC4
	 ngrI0cQ7A2lSHKnroavj+ZpbhLBSSmOxwBHqOmPBKLWR9B5h15z0nq/RJ279npM0TF
	 6ARz2WWZXpnOQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/7] wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to ath12k_mac_register()
Date: Wed,  4 Dec 2024 18:32:10 +0200
Message-Id: <20241204163216.433795-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204163216.433795-1-kvalo@kernel.org>
References: <20241204163216.433795-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

When hardware device group abstraction is introduced, a group abstraction is
registered to mac80211 rather than a particular single device.  So we cannot
set the device registered when the QMI firmware ready event is received, only
after all the devices in group have received the event. To do that set and
unset ATH12K_FLAG_REGISTERED flag inside ath12k_mac_register() and
ath12k_mac_unregister() respectively.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++++
 drivers/net/wireless/ath/ath12k/qmi.c | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 129607ac6c1a..1180070278da 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10839,6 +10839,8 @@ int ath12k_mac_register(struct ath12k_base *ab)
 			goto err;
 	}
 
+	set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+
 	return 0;
 
 err:
@@ -10858,6 +10860,8 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 	struct ath12k_hw *ah;
 	int i;
 
+	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
+
 	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 77d8ee14bf33..20382b751829 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3349,11 +3349,9 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 				  &ab->dev_flags);
 			clear_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags);
 			ret = ath12k_core_qmi_firmware_ready(ab);
-			if (!ret) {
+			if (!ret)
 				set_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE,
 					&ab->dev_flags);
-				set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
-			}
 
 			break;
 		default:
-- 
2.39.5


