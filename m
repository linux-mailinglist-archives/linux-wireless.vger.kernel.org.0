Return-Path: <linux-wireless+bounces-26169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14678B1C4B6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 13:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4671887D3D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Aug 2025 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19DB21D3EC;
	Wed,  6 Aug 2025 11:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TaLexaGA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365024A07C
	for <linux-wireless@vger.kernel.org>; Wed,  6 Aug 2025 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754479084; cv=none; b=EMOPRfIyttigEvt7cQoy5OEQ4Q/IbZFgyeWfI7O3EiVEyjUYDNHrjJ4lDzACKYuaEhSAoN7fH+SR+iEBfucBjvGP3gVzEjPe9opcjv0Xa+YI+n11cDj4fFTVjK8gIrAvJVoA6YdaP73eaL3uEkPACCHW1hUCmc/jgAp5QtGmkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754479084; c=relaxed/simple;
	bh=vO1qRZ9R138Ml8WCKJBdjR5mzpGiRzPTfuetOyEPWsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=F/DjFztw756nOCcdUpptNF68C6FnCDHXoyMsCkaGhFcCKtqwuNamaVr2q5VjEiNcVfpNp1SEcbFXigFH0704qw3ZWhw2uviQoGR7gdadc0XPA49Nen/Z9A7yPoKG1Xeq94TmF83bu6OtSIe/XMQ/MmDwLcQZX3U8avf/rsMcrLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TaLexaGA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5765kFxJ025172
	for <linux-wireless@vger.kernel.org>; Wed, 6 Aug 2025 11:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=8U0iA5v5egIGA6QMrKtKKSRgVKgT6nDYg3PKNpf9CWM=; b=Ta
	LexaGAqMYT44MWanjPnmOXbrvF0Reuy+IQxpukzH9brbfa0o2UfHpVntMKkJAvFZ
	aUvemPHzmbNfpLuv/Aw1MT4RPHguasVnkPiC22m9UYNP0N7B3s+5NxZdR9vftMfq
	BzDJ6RTuLoQ0Va/1SpBC0KaNGL5D1llV3w19poA8OkKa7iLWoAMFJj7Z6zVR4fG9
	KS4ki24VFEduXPk3apMS3hHsNzXHV0JNMZPJp2xTjqeXzRYEH7XtR7TYyYTS0zWU
	dBZKZWZdV522R1VBx1rl0eK9SWCJgF8R4TIPwqNIJVeix6Qw58vMOjXzlVqFyoMq
	1VtJTaTkvgezCjJuNs9A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpvytm9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 11:18:01 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2425364e0b2so51630325ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 06 Aug 2025 04:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754479081; x=1755083881;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8U0iA5v5egIGA6QMrKtKKSRgVKgT6nDYg3PKNpf9CWM=;
        b=VaMycRDgNiO6+DIWzvUGtQe3DUJjsa9qWKQxF+owRvRHZwbLNLUdNh1wyW3wfxBbkR
         fzLH0QgTDF9G/Tjdt+DPZCaLc3YPH2TUBtxPxehFekLJukFmW3+9jvKcINh7zDTW2GGI
         VxCcxrdIsedW7MfH0jfj3s0UECyRnUcOEZaO5GAPPS2Ay1K3H0sKbBolzSoYOhOPqcJ5
         WQFsIOaVW7bmUEnrpdYEjDqhJ1tdjN6LhXw1evuxjw9Aqn5+0tsKwV0v/NmLY7MMcIkf
         L4Pgdz2UnNI7Byg27yZVLmSljge/b/Jov83/H+Kw15UYabjLhc3DrCMGdkJREMBSmVn3
         VBRA==
X-Gm-Message-State: AOJu0YxdcHFNPEV00DKlZ/JEnPRRwRY+Ra5Jqj/c+oONfDCpT+mgl2J2
	wddM8/cQQ3tpj3ogdpvV+dC/2Wozh8811CI71o81B4Aq9I2n8MM9WDaNVsLrF6k1Mb6BVTmA/+Y
	m7Ue+onLwbcMhkPXDlLmo4896UJvJTk3M4BhLOA/HZWiFhg+kueDseR6J2EdMWm1KZPPkTg==
X-Gm-Gg: ASbGncvx6Tr+dPXYxanixaG0PZEtnvc760bCQVD8ba5TRPlM7Mq9DacLnxRUz1NGdBy
	1ofve/DDmDlZfSOUh+3ofrPt21u63yzs2M6LpbeYXlNMkbij32ZyLOX1wSuG/p6hsFz0bTwQOGy
	j78WTmZ5VsYi/JbrcM5Gegj16zC3yinf4oD437bAfTm/jiNt+TLkyunJFTRR9wOKJVsJotswJmr
	CQn7XXnCaskFCYAu+7y7S/2gU7Rk2NabiOra9H2cZEicTRJO+QVz9HzLX0KgPhxLbrTDaRvWdKX
	YK/DynKzzvh543EVw9emMhxfC0w8LefkE89+bv5GTY0zntz+NNHmD2At2WcP1PItjVo3AF8JHom
	t5i0EXsWJRjaneml6X1ppWebmXGz8iN2GBRwuyPt3s97S60xOsV31mV7VfgQC1pZFzxQApujy6A
	==
X-Received: by 2002:a17:902:f691:b0:240:66ff:b253 with SMTP id d9443c01a7336-2429f55dcfdmr38715915ad.46.1754479080651;
        Wed, 06 Aug 2025 04:18:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH4tLJCCe2fVLYkYJzdC4gxRgEg1QpV+J7Ag2EAOSWFlQ+zJEhvb4jrmaE6UogtAkwFstfBQ==
X-Received: by 2002:a17:902:f691:b0:240:66ff:b253 with SMTP id d9443c01a7336-2429f55dcfdmr38715505ad.46.1754479080155;
        Wed, 06 Aug 2025 04:18:00 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7d9dafsm12984111a12.23.2025.08.06.04.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 04:17:59 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-current 2/7] wifi: ath12k: Refactor RX TID deletion handling into helper function
Date: Wed,  6 Aug 2025 16:47:45 +0530
Message-Id: <20250806111750.3214584-3-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Proofpoint-GUID: FthrMcC8oKy1psuatnzfePdsLPU6p6fe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX/8Svdwz9mukv
 t1znQ1OgKJV0OuiJdw/yVOiEPawtvJ1j6diSizJIckYtENNAlZj9LXDPti1v60LvapQKdEQvdNi
 3Zk1JyDEDk9NmDx00CVJAGr+pK4z2AQfHW4SmdsMZ2arMNteevOd4oThclwNjA/dZJ4N+AU4qaf
 BVk25G922AUDQC3yKQFuhqTf4h5iDtdE3/rI8i3IpECGkhGHbs+IUj1Fa8CFt1pQEeKABnZQVRS
 to+2dyJlpO3Rw5+78laglAqsgMPoRSkBHRYrrCPPBLLNcunvIm4EEMfHlXUjPq3dlLxIynOmEc1
 xScbutlVu2rXJbcc41yyDQg80U9dq9HBaMoWVIii1iDilASF1xftPaFskKPMGYJwm2Rjln2KVmo
 OYMsM4G9
X-Proofpoint-ORIG-GUID: FthrMcC8oKy1psuatnzfePdsLPU6p6fe
X-Authority-Analysis: v=2.4 cv=NsLRc9dJ c=1 sm=1 tr=0 ts=689339ea cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=OHgFB0bDJtoAK5jKpLUA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Refactor RX TID deletion handling by moving the REO command
setup and send sequence into a new helper function:
ath12k_dp_rx_tid_delete_handler().

This improves code readability and modularity, and prepares
the codebase for potential reuse of the REO command logic in
other contexts where RX TID deletion is required.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 27 +++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 8ab91273592c..15097fe9e35e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -21,6 +21,9 @@
 
 #define ATH12K_DP_RX_FRAGMENT_TIMEOUT_MS (2 * HZ)
 
+static int ath12k_dp_rx_tid_delete_handler(struct ath12k_base *ab,
+					     struct ath12k_dp_rx_tid *rx_tid);
+
 static enum hal_encrypt_type ath12k_dp_rx_h_enctype(struct ath12k_base *ab,
 						    struct hal_rx_desc *desc)
 {
@@ -769,6 +772,21 @@ static void ath12k_dp_rx_tid_del_func(struct ath12k_dp *dp, void *ctx,
 	rx_tid->qbuf.vaddr = NULL;
 }
 
+static int ath12k_dp_rx_tid_delete_handler(struct ath12k_base *ab,
+					     struct ath12k_dp_rx_tid *rx_tid)
+{
+	struct ath12k_hal_reo_cmd cmd = {};
+
+	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
+	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
+	cmd.upd0 |= HAL_REO_CMD_UPD0_VLD;
+
+	return ath12k_dp_reo_cmd_send(ab, rx_tid,
+				      HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
+				      ath12k_dp_rx_tid_del_func);
+}
+
 static void ath12k_peer_rx_tid_qref_setup(struct ath12k_base *ab, u16 peer_id, u16 tid,
 					  dma_addr_t paddr)
 {
@@ -828,20 +846,13 @@ static void ath12k_peer_rx_tid_qref_reset(struct ath12k_base *ab, u16 peer_id, u
 void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 				  struct ath12k_peer *peer, u8 tid)
 {
-	struct ath12k_hal_reo_cmd cmd = {};
 	struct ath12k_dp_rx_tid *rx_tid = &peer->rx_tid[tid];
 	int ret;
 
 	if (!rx_tid->active)
 		return;
 
-	cmd.flag = HAL_REO_CMD_FLG_NEED_STATUS;
-	cmd.addr_lo = lower_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.addr_hi = upper_32_bits(rx_tid->qbuf.paddr_aligned);
-	cmd.upd0 = HAL_REO_CMD_UPD0_VLD;
-	ret = ath12k_dp_reo_cmd_send(ar->ab, rx_tid,
-				     HAL_REO_CMD_UPDATE_RX_QUEUE, &cmd,
-				     ath12k_dp_rx_tid_del_func);
+	ret = ath12k_dp_rx_tid_delete_handler(ar->ab, rx_tid);
 	if (ret) {
 		ath12k_err(ar->ab, "failed to send HAL_REO_CMD_UPDATE_RX_QUEUE cmd, tid %d (%d)\n",
 			   tid, ret);
-- 
2.17.1


