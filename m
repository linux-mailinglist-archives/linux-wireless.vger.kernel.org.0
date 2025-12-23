Return-Path: <linux-wireless+bounces-30086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F085ECD8948
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 10:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F07D33009741
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Dec 2025 09:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084CD322B63;
	Tue, 23 Dec 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FcYVCA1I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FuwRf6zc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF16322B70
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766482070; cv=none; b=Z0JFmyzSO8CZX6gfgaTwb/6SjEDEM2NNd8QbF9IAdOiVJS1ZPQp1CkBsj8TFcJ4Z6FU9XP26J3lbI81BEyoFbYJ8Ua4pwb8ChHPOJ60M+DJ5YJ/oVeYzRqDdxA2Q8VXsvec48udVZKLoFxczCIR0mJxx7P7vhrXBMHhXOjMA07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766482070; c=relaxed/simple;
	bh=tI0dosO1JVKLUN5RcoBS+vDXFcXFJSwPLFnrcy6D15M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FqNX7HEzUTNxarlPgcgrNQWh9rNlQCOtT1yibImLUNQrNY9I/C3dBSqexEI8aayI9evnYiJB4pLJZHmlvGlMikjhGQLwMCCm6hdChyGTbhVbmA06lP/e/canokaPX6c+3nTqt1XKUMvjo53QSUwGCIz1PnAZLWPgCPdYMQNGCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FcYVCA1I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FuwRf6zc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN2QkBn2041149
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hs5288HHVUQ
	Fjrv7CSPivVXMjxMWSBhPiX8zU58z2Y4=; b=FcYVCA1IbdU6G/HptCx/NU67cuQ
	dauj05M7Xg1LBtl6ihZiSn2fBhoLlYA+tLVYIZXQNoMkogqcXHgm5gtVYjKAtIox
	OzG1IhPE97TIXM2TBRYlLjhHkFVbLyb5BIGY+FCk1+k7vtsiQbDmjM4sSxwtGnfG
	2g7Y8i8FxD/I/BkYAXkoXJ94rs5l0utQN1eHGoLR34ahjZxU9l/TAkU8dsM/Ej+T
	9917fxIZ/5yQ0M2ud/yE+Nqcmv78h/i92me7cF/ilaGVegudPubpn3+sD55zZn1t
	ffnYjusQ61Q8JMpsphMHcH0BjBIgPLYsEiHyx6ky0WY12rDF8PuFy/XacGQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b763pk6ms-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 09:27:47 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bdf47c10220so8417404a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 23 Dec 2025 01:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766482066; x=1767086866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs5288HHVUQFjrv7CSPivVXMjxMWSBhPiX8zU58z2Y4=;
        b=FuwRf6zcj/duZt//sw8FNuUgTwdSFqzwUbAGo66KaIiGsAm7JRONLSKauR1nNbTLi3
         S+vYE3J0Uvyjp99V0t6lc8vIRmO7wRwfyo1D//0Q/9coImdEGOPqYZljDzv6FpVko/oy
         K07mnmOp8bA2jgk9pL+1uHHA1ud342aaczIXwCvPw9K7uy7Yw6X//494aXRGWpdpa8yO
         XrbZeJIuK71+vk3cva3KvOHH3S5UUHx2sq44E9XTSv4fqO+hbzEHOagtA1sjds8hIW0l
         XAU6HpmAs31cjauJ7UjKMILw9T/mKv5cXy5T8Aw6t9TEd+d6VHpJXxvZlfegu5jqdBPL
         oXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766482066; x=1767086866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hs5288HHVUQFjrv7CSPivVXMjxMWSBhPiX8zU58z2Y4=;
        b=PRhHGDLytq/RonOFPomS1ZnRFtBfZyWYG44rASvfMJHUa4FBiQiWstzUMkm7pQQ9zC
         k2mknF8TuhateQWh6+GZpRicI2UrjZdXddsaL6um2jxWjLGZvbqpTE1DpGWdIRPkoigc
         asW/68w7Ph3FRmuyamXuZYdWdH8RWP8PWvxtowAIN75SVXYF04Ms573vypyzsqeu5xfY
         SotNvw/D8SHxr3KxIhAnxIcQENm9kupRXUaJqzspmg2eNYAF+Ta4tIsvY9gtslz1GSOH
         AEmUns220S0e9WEZfMNjJsPs/pFutkgdTnmc/lrxRVNnsjfI4iVwOmTI2iUu86qMMLvo
         sgnA==
X-Gm-Message-State: AOJu0YzwyXJQSQsQTYPLVHAUcBJarRUsmkW+s5BiFeUI6ZPtKoewr1e9
	EB0elOraCfAoe8UAo0WH/CB5KJS/MEbuIanrlm5ctZQstllRAd2j41KgJRdnFPLQho6SMYDuMp+
	49CXBjh5Or8QnQbNdmHtaYXKpvNF5Y1qzQlzgLy78lB6mnNh8bzHs73bMpySTjx1+L0li4Q==
X-Gm-Gg: AY/fxX5WmPebKxyHjKOvKgqFOPnNEFsxcwTY8LUzn3ujCWf0k5vGPrlMvmDtfbDpr32
	VdEYX+6W1U14AHlg9QpKVMpDQGRHBy3GC9hB9AI1wGu5htmMBDvqLcCx/A3d3YeZK7kvXOzG9Uc
	ZTtKphL2sQwfcxEMTvLKRoaccQ/Yyk2N3fmgymzRydXRPTuh3hkrEuuNOELepyqyArJDJ7gQrsr
	qWf8oVD4PLpY0d/WijoNjn8yO7kCeMGIuEpgMw56mmHcnrVNEMNtLa5Yvh3cyS31eWCxLhTCmpZ
	TKp3hQf0dDqDQqgFq1IwtjOMynEcKAtNizL/qRxWe5LI1wfp6FyHU5HBbKTyIQ4KWV0GWw5y5t2
	d7CtJ/CCp2xRHD7ez4lIie+YOo9OShqAP6b0=
X-Received: by 2002:a05:7022:2520:b0:11e:1bc:bd9c with SMTP id a92af1059eb24-121722ddfbdmr13701043c88.28.1766482065892;
        Tue, 23 Dec 2025 01:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAkedPd5CmtDs4i/PLaxntsgRQTIXk68OfaX5mnTr97GNhRxlKNjAXqg3GYFDKF3g2AIRl+w==
X-Received: by 2002:a05:7022:2520:b0:11e:1bc:bd9c with SMTP id a92af1059eb24-121722ddfbdmr13701026c88.28.1766482065304;
        Tue, 23 Dec 2025 01:27:45 -0800 (PST)
Received: from hu-zhangq-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm56130940c88.0.2025.12.23.01.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 01:27:45 -0800 (PST)
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Qian Zhang <qian.zhang@oss.qualcomm.com>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v4 4/6] wifi: ath11k: Register relayfs entries for CFR dump
Date: Tue, 23 Dec 2025 14:57:26 +0530
Message-Id: <20251223092728.1950017-5-qian.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
References: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA3NSBTYWx0ZWRfXwdgAjWR/b5zD
 vdWLHG50B2cbxiIYDl0ivib6Ro8CCSRe6Y+kkqc4SQ7wClCoXZPcrVo969hdsQu+s1dkNOBXPvY
 jqlailteSbu/eiXaEW9Ra26FMI/e2lQ6kC+0DRaJ5SnzV/ZMrSiYwBPdAr21UQ/ORkEayvUt90F
 clwnIX/tDMoJ0E2ElpUgc/H4N2koeEpOE7QYl34ghlIbcg8AYzhnRtoEn7nqNHV2N/EHYfIewGn
 0l+GQ83ZE0Jtzd+NgGnLjiV/QCBAMxVygQmACx0MmHWFfDO0wJcJr+P8Zj3ThYzA/xGUMu3X/he
 j34NubuBxMaqZi/GxURkIiLGcEAvklJI1kOgGaZ3DqmfptlK8x+o0E/5JxIfxOA+A4aYKKxhv3L
 hoCqJvR1aWdwOsfXoYfhHKhvMLU6eRJ2nxPf/LEVfgUaKRD1C43yZENlRHNpqxgKepkL0fWrghF
 N5gWbnsGrDlEGTLo+uw==
X-Proofpoint-ORIG-GUID: suJMplTFq64255DWn9Yrza2tzE2vyVz-
X-Proofpoint-GUID: suJMplTFq64255DWn9Yrza2tzE2vyVz-
X-Authority-Analysis: v=2.4 cv=H6TWAuYi c=1 sm=1 tr=0 ts=694a6093 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6mQ44K8ZfP1dJrZg0vYA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512230075

Provide a relayfs interface to collect the CFR dump from the user space.

'/sys/kernel/debug/ieee80211/phyX/ath11k/cfr_capture' is exposed to user
space to get CFR data.

CFR format to user space:
 ___________________________________________
| CFR header | CFR payload | CFR tail data |
|____________|_____________|_______________|

CFR header contains the following fields,

* Start magic number 0xDEADBEAF - 4 bytes
* vendor id - 4 bytes
* cfr metadata version - 1 byte
* cfr data version - 1 byte
* device type - 1 byte
* platform type - 1 byte
* CFR metadata length - 4 bytes
* metadata - 92 bytes
        peer mac - 6 bytes
        capture status - 1 byte (1 for success 0 for failure)
        capture_bw - 1 byte
        channel_bw - 1 byte
        phy_mode - 1 byte
        prim20_chan - 2 bytes
        center_freq1 - 2 bytes
        center_freq2 - 2 bytes
        capture_mode - 1 byte
        capture_type - 1 byte
        sts_count - 1 byte
        num_rx_chain - 1 byte
        timestamp - 4 bytes
        length - 4 bytes
        chain_rssi - 32 bytes (4 bytes for each chain)
        chain_phase - 16 bytes (2 bytes for each chain)
        cfo_measurement - 4 bytes
        agc_gain - 8 bytes (1 bytes for each chain)
        rx_start_ts - 4 bytes

CFR payload:

CFR payload contains 8bytes of ucode header followed by the tone
information. Tone order is positive tones, followed by PHY memory
garbage, followed by negative tones. Dummy tones are uploaded to make
number of tones always integer number of 64. Number of tones is not
preamble type dependent.

Each CFR tone has 14-bit I component and 14-bit Q component and is sign
extended to 16-bit I/Q. Two tones are packed into one 64-bit unit as:

[63:0] = [Tone1_Q(63:48) Tone1_I(47:32) Tone0_Q(31:16) Tone0_I(15:0)]

CFR tail: end magic number 0xBEAFDEAD

Tested-on: IPQ8074 hw2.0 PCI IPQ8074 WLAN.HK.2.5.0.1-00991-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 35 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index e22b0151833c..495b2c6742aa 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.c
+++ b/drivers/net/wireless/ath/ath11k/cfr.c
@@ -416,10 +416,45 @@ static void ath11k_cfr_debug_unregister(struct ath11k *ar)
 	ar->cfr.enable_cfr = NULL;
 	debugfs_remove(ar->cfr.cfr_unassoc);
 	ar->cfr.cfr_unassoc = NULL;
+
+	relay_close(ar->cfr.rfs_cfr_capture);
+	ar->cfr.rfs_cfr_capture = NULL;
 }
 
+static struct dentry *ath11k_cfr_create_buf_file_handler(const char *filename,
+							 struct dentry *parent,
+							 umode_t mode,
+							 struct rchan_buf *buf,
+							 int *is_global)
+{
+	struct dentry *buf_file;
+
+	buf_file = debugfs_create_file(filename, mode, parent, buf,
+				       &relay_file_operations);
+	*is_global = 1;
+	return buf_file;
+}
+
+static int ath11k_cfr_remove_buf_file_handler(struct dentry *dentry)
+{
+	debugfs_remove(dentry);
+
+	return 0;
+}
+
+static const struct rchan_callbacks rfs_cfr_capture_cb = {
+	.create_buf_file = ath11k_cfr_create_buf_file_handler,
+	.remove_buf_file = ath11k_cfr_remove_buf_file_handler,
+};
+
 static void ath11k_cfr_debug_register(struct ath11k *ar)
 {
+	ar->cfr.rfs_cfr_capture = relay_open("cfr_capture",
+					     ar->debug.debugfs_pdev,
+					     ar->ab->hw_params.cfr_stream_buf_size,
+					     ar->ab->hw_params.cfr_num_stream_bufs,
+					     &rfs_cfr_capture_cb, NULL);
+
 	ar->cfr.enable_cfr = debugfs_create_file("enable_cfr", 0600,
 						 ar->debug.debugfs_pdev, ar,
 						 &fops_enable_cfr);
diff --git a/drivers/net/wireless/ath/ath11k/cfr.h b/drivers/net/wireless/ath/ath11k/cfr.h
index e7b69e98cbf5..19f136d34c65 100644
--- a/drivers/net/wireless/ath/ath11k/cfr.h
+++ b/drivers/net/wireless/ath/ath11k/cfr.h
@@ -60,6 +60,7 @@ struct ath11k_cfr {
 	struct ath11k_look_up_table *lut;
 	struct dentry *enable_cfr;
 	struct dentry *cfr_unassoc;
+	struct rchan *rfs_cfr_capture;
 	u8 cfr_enabled_peer_cnt;
 	u32 lut_num;
 	u64 tx_evt_cnt;
-- 
2.34.1


