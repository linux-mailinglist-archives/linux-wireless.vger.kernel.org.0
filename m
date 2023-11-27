Return-Path: <linux-wireless+bounces-112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033DE7FA632
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 17:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AD71C20B28
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 16:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE533716C;
	Mon, 27 Nov 2023 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jnhv8dez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A2A37166;
	Mon, 27 Nov 2023 16:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6E4C433C9;
	Mon, 27 Nov 2023 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701102031;
	bh=m1Qw8/vtVY4p1/3aRSjL1MDaqIJS0lXW4t1xxd50gVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jnhv8dezDS7gj22Ipkygfaz8Oh01NtpkbtnMvC1YMrOCXFNJ1CjH5uIyPAZ7FCJqH
	 ZpARgkT+/wXCnpCrRqjZlzmDwLGe9IL6mIe6aRQU4W+f3dFjsk/+kzomYkJ8WgUNWf
	 qbF8etvasH+C7FPJF8hLwvJjg8s4+2bmdewlY4NZJFD4YKD7GSj83SOQnX18VxEGfl
	 cO4JcE8W4JNF3r4JKLTDp4X///S6kEsBifJs/+kS2fL3Mi9TaxSx5Slv0WdnzSwo2L
	 L/ACLcete2C36pJW3I740d2d+tBpGDfrlJ56HLTkqAUMl+TnBXlvQpJv7zShxbnxmP
	 d+fLbIKWfzdaQ==
From: Kalle Valo <kvalo@kernel.org>
To: mhi@lists.linux.dev
Cc: ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH RFC v2 5/8] wifi: ath11k: do not dump SRNG statistics during resume
Date: Mon, 27 Nov 2023 18:20:19 +0200
Message-Id: <20231127162022.518834-6-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231127162022.518834-1-kvalo@kernel.org>
References: <20231127162022.518834-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Baochen Qiang <quic_bqiang@quicinc.com>

Both the firmware reset feature and the power management
suspend/resume feature share common power-down and power-up
functionality. One aspect of the power-up functionality is
the handling of the ATH11K_QMI_EVENT_FW_INIT_DONE event.
When this event is received, a call is made to
ath11k_hal_dump_srng_stats(), with the purpose to collect
information that may be useful in debugging the cause of a
firmware reset.

Unfortunately, since this functionality is shared between
both the firmware reset path and the power management
resume path, the kernel log is flooded with messages during
resume. Since these messages are not useful during resume,
and in fact can be confusing and can increase the time it
takes to resume, update the logic to only call
ath11k_hal_dump_srng_stats() during firmware reset.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c270dc46d506..97a74563d4a6 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3249,7 +3249,8 @@ static void ath11k_qmi_driver_event_work(struct work_struct *work)
 		case ATH11K_QMI_EVENT_FW_INIT_DONE:
 			clear_bit(ATH11K_FLAG_QMI_FAIL, &ab->dev_flags);
 			if (test_bit(ATH11K_FLAG_REGISTERED, &ab->dev_flags)) {
-				ath11k_hal_dump_srng_stats(ab);
+				if (ab->is_reset)
+					ath11k_hal_dump_srng_stats(ab);
 				queue_work(ab->workqueue, &ab->restart_work);
 				break;
 			}
-- 
2.39.2


