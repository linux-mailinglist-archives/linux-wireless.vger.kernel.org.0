Return-Path: <linux-wireless+bounces-22573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EC0AAAB02
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88267189FC79
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 01:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6E38AF55;
	Mon,  5 May 2025 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OadaC4z7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA9D38C427;
	Mon,  5 May 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486093; cv=none; b=U3cmiCwTQwx9ouaXWAL7rgqetOy+QQ4wRipsg6RFezGUu/1Iwbvl+KhiVpUrxreecgV7w0vplHpejJMqzXE1sG2TO/F8ExSsvw5HKKJB1jLooFJuq/ztLeWCSZSG9MPIJZpZ27RPJVXDlbHLyxb0TUoLC1bS2JofClW4YzQMQXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486093; c=relaxed/simple;
	bh=qWI4Veu+G4Y/XLuv+c8eCI1sefPk1C68m2Dnv+2qFFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzz6yeYEWRP3AwyRVfvCrtfUbsY/d7vxEag6P9J4GO9Xf9UCSwc9QBPd/S+Ximv8j1YGSdxULvl2hOtkAY2036zc99wX+cB8wQNGFCP+1bjm5fiCks2Mm2qIO+SEo4IhEORpKrHIFIwESZHBgSW1itaVlzjJLeum0ZWG7i1j5VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OadaC4z7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1805C4CEE4;
	Mon,  5 May 2025 23:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486092;
	bh=qWI4Veu+G4Y/XLuv+c8eCI1sefPk1C68m2Dnv+2qFFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OadaC4z7llMYP2/bNPVqJDH0faSTrmnX04gb0YjN/Pmb7zZXAFEFPVfSSyl5ouCiG
	 oI7IfwraQxrlvZ3eix5Gqh5mxzuaznD4FUd8A3AF7/Cy+fflz/wJc3a6PFWKzMubAD
	 GOVcmvUMqNbYYTgcl9wHvhMmg4ZkiRQVnub+4+PdZCxOSM8BmZ9KEOve6DRI3aBH8O
	 hcQ1rBcw/NZX32YrKyo3adlllpOefHNdTswzg2q5xE/K9oS+2LNK7mEpjYjFY3KOS/
	 F6OOvC6Fcls+D0qAP2BXPsQ/TEiRqT2tXGy4Jie/l1iNDvbn62LWZ0+yG/ZC2Q0YQs
	 L2EFktrRze9wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>,
	Roopni Devanathan <quic_rdevanat@quicinc.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>,
	jjohnson@kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 151/294] wifi: ath12k: Improve BSS discovery with hidden SSID in 6 GHz band
Date: Mon,  5 May 2025 18:54:11 -0400
Message-Id: <20250505225634.2688578-151-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>

[ Upstream commit 27d38bdfd416f4db70e09c3bef3b030c86fd235a ]

Currently, sometimes, the station is unable to identify the configured
AP SSID in its scan results when the AP is not broadcasting its name
publicly and has a hidden SSID.

Currently, channel dwell time for an ath12k station is 30 ms. Sometimes,
station can send broadcast probe request to AP close to the end of dwell
time. In some of these cases, before AP sends a response to the received
probe request, the dwell time on the station side would come to an end.
So, the station will move to scan next channel and will not be able to
acknowledge the unicast probe response.

Resolve this issue by increasing station's channel dwell time to 70 ms,
so that the it remains on the same channel for a longer period. This
would increase the station's chance of receiving probe response from the
AP. The station will then send a response acknowledgment back to the AP,
thus leading to successful scan and BSS discovery.

With an increased dwell time, scan would take longer than it takes now.
But, this fix is an improvement for hidden SSID scan issue.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ramasamy Kaliappan <quic_rkaliapp@quicinc.com>
Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Link: https://patch.msgid.link/20250207060005.153835-1-quic_rdevanat@quicinc.com
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index c977dfbae0a46..d87d5980325e8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2115,8 +2115,8 @@ void ath12k_wmi_start_scan_init(struct ath12k *ar,
 	arg->dwell_time_active = 50;
 	arg->dwell_time_active_2g = 0;
 	arg->dwell_time_passive = 150;
-	arg->dwell_time_active_6g = 40;
-	arg->dwell_time_passive_6g = 30;
+	arg->dwell_time_active_6g = 70;
+	arg->dwell_time_passive_6g = 70;
 	arg->min_rest_time = 50;
 	arg->max_rest_time = 500;
 	arg->repeat_probe_time = 0;
-- 
2.39.5


