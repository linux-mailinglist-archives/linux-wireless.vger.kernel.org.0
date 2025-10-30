Return-Path: <linux-wireless+bounces-28398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E43DC1E5A9
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 05:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8E21893F8A
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 04:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5AE3191B7;
	Thu, 30 Oct 2025 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPOjkYiz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OV86ghu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7512F291A
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761798719; cv=none; b=l7cTQGewP6O5mqU+VupqvYQVBB8j+/BMYHxnCSPDACdmUlSkq96x0CLPqay8mkqlxHjOKGRifNlBs8YIqI5QJAO7sSyG5XdIjqw9Pbh4n1YCh1/evRk0TvWR0Xawx6s8QsMutnsnZF0+1SUy2D9Wt8aCKZZX5vtwZI6NR+fvAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761798719; c=relaxed/simple;
	bh=8hiFw3AiIgULUbC/SOsyWTzBhmi5BpIKyTQ8JBm5ufg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cigUk0i/sW5PTSbuFkVLr1rQ3uqsF83AWofap1mUlFBOqVmENfCeYluIQd2qHks1Cruu1fSIMdlyE/lwMnlz0/6LA5X+rJK7JtDkQ58ey4iDlsgswZqG2LQYGA/KdBYCTBChxQuHQMnE5hH5ivvBW2aIjqtlmQyLWMxyXQRrB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPOjkYiz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OV86ghu1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TL7BqQ1578937
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=J+oQ43VnLQF
	T+FFdFNj69VT4fG+7G9aphoGdp03TwCo=; b=iPOjkYizbN2tZZcqxT5fM5e9/Z+
	oKxQhD+hnTtVLmGbObJ5t+khW3OIZGITf7oCs/Z0Thfyf4DrRuZBJckeWROMVfY0
	ZG2XVGGdXy1QVuhoDHjZpGM8An2kpN8Eehthl0hyUDaJehRvFUVuksoC3WtWdK2C
	IzXtKBlvdsQOMlEn/jlYqjh2Jb1LiPipu2CnA9B1FjdZMNEjcWOoYZtXwkGuJLzC
	/RjpAlG1DNZ73Wy6jiOVq8LISScuyN+7fMT2NVqlEciGue5TNQ/j7F6bh4rdt25E
	ITLycE0b/o/kRz1/kpa4xEznf5gxuhhNSz0qA+Rbe5FSiscYLP48oXE3j4Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tjeh1c2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 04:31:56 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a675fbd6c7so224112b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 21:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761798716; x=1762403516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+oQ43VnLQFT+FFdFNj69VT4fG+7G9aphoGdp03TwCo=;
        b=OV86ghu1G8S3NycSgHm2QRNpLHFXpZHdvoW/opHMbun6j22PA8uxM+qDhr6G5/u/NG
         hziq/FJljPKP2ZcXi6qqfTvts9PhNdT0hr9Mo9QfT/xF18eksuaCnGcufaVXYjWi+qcy
         XpihWTZqBpDB+vlgmh/D9H4r5bMJQYmEWpNxzuVZIieK0a9H2G5UZmwHyruKFg0YseFh
         kS6qzttWT1757sIY8vYXmsto/7NAHhfsXcNmUjIkY3s6zvStsBgnyu5qrv0yLzsAmcIN
         F8ELqYC3bTm+A+18cQWLWAGjdum1H8F/Oqx6zHboxgdTcClph+R5Qbvd8shv/btkrsVm
         p7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761798716; x=1762403516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+oQ43VnLQFT+FFdFNj69VT4fG+7G9aphoGdp03TwCo=;
        b=dhw4HDoLWhZHyMjXeYpshiDFaR8zGDLSyjmsFLp9eeOMoj8+rYtK7HBpV8ymD97VbI
         ioc4LLheQi3Ao9gbFheIVK6yjbduQyPDE+y70RKs4LBpD8BvWsvX9zCM+TRCOJYFaDSb
         804YjnYLNtmlmqYXQn22HMpWWLqN9U7k6AINDML88GfDGOVxDxWdpatva5dXVsYU3xNm
         70+Zzn55LnOsFAYs1WU2BGqUnz8sGbqh+oeI1ohwYRKm6hbtQOaMu1kyYEFe/1g39p2J
         dMBk7zNruuAv5K5TCEP+Lx2BSvyDp6ngJpezTJqUfUMqqkZNIlHY6/YhEqOQ5XWyOR3t
         Okqg==
X-Forwarded-Encrypted: i=1; AJvYcCUsL1kapteCDs9lJTFcL7jZoMIN9wuHZVFLWBEaJjw4kBzZbdxgFSm4QZhAy906DAHOsZj/hxJlv9VAyQWTVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg0OBcdPu7GR7Oo+eVu15LSxI97LZONyN5YhwgEd8ETAYXmQL+
	ouMwRC+8EPF5P486WSQpJXksFokAWKVBCZQnfzvKqWMvdoV+I+L0TXEA9Pi89hmI1DzqiB5P8GN
	CRjaU/W2NULA0I/jaGqewVGNAzo/pbP1yxf4aLwTRgVSLGHqrX5IK3Ro2cDgNvZW1rAv/lA==
X-Gm-Gg: ASbGnct6hXsCjm8g9kEJU8dv58Sl9o17HWv9BSKGNTPfQ1AO3i2L8a80vYw2q0TF8XA
	0uEQkkkbpXcBYVZEdsd+KgRQTtTn1wn0H06VrNm2P3Rd7yxfWwgkwGh6WSc/wTtarRrWhYZ96ag
	rnHXSYh9ct1dsv1mELF0hA+GD0SDHoP4yypXw4nz3DZlLDkHLX6gSKyFmcKsLI2+uATDrCdQFBP
	Cuhe1mHpIy45ut5MvnV7u4x0NsLXRq64Eq2OjzlhRvcrlG2Gah68m70MdK/1Xdh/NY3PDEentnG
	g/ICv/RQWYo+FPFsqKfc9y0pz4PdHJVpxxqx1nZXmikqAlYPj7jdvCgM8jmiWRxpY8nCcAtPH7J
	yBksYLCWU2c6dBGFu/M1WboSif8gvPAgehaQkmJIiCIeo
X-Received: by 2002:a05:6a00:c95:b0:781:275a:29e9 with SMTP id d2e1a72fcca58-7a4e47257dfmr5858037b3a.16.1761798716109;
        Wed, 29 Oct 2025 21:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPouVDVw2VyvWCm8X0eoZJuWhJoirnxRu7ZoOIPTQ0W4kl7fco+ho3SYmAM7WaEbsmCWOlcQ==
X-Received: by 2002:a05:6a00:c95:b0:781:275a:29e9 with SMTP id d2e1a72fcca58-7a4e47257dfmr5858019b3a.16.1761798715650;
        Wed, 29 Oct 2025 21:31:55 -0700 (PDT)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409e456sm16912161b3a.71.2025.10.29.21.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 21:31:55 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: [PATCH ath-next 4/6] wifi: ath11k: Register relayfs entries for CFR dump
Date: Wed, 29 Oct 2025 21:31:48 -0700
Message-Id: <20251030043150.3905086-5-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
References: <20251030043150.3905086-1-yu.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: G275f9Gx-uwV_MivWdYnrZdnN7GUAQu7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDAzNCBTYWx0ZWRfX71lUT4heaFpL
 FYzm2hOWD8+hYWZ4LsO3qOgs/hoVR9BRpuI8kqF5R+iHat0WV+Omfl8GzFmPMNm7UvRMqqJSrIn
 rNFntk3dnUbt3soqNvGNdU2vWh9X2vk9UjUsHbq6I07E1e/ktWQZT8/c3HsF8zrc5KIVfoSGRSk
 GabzxwTdfV8BhueHdS6oRCxqVjh6c8Mik5RUNjh3qIyfpjp9Q9QZ1SSKa9j9PH2kmYy+DmsbE4q
 aKVNoiag50g9XlTXYi+Rq1fI1m40yX/xQ0iaKtUcU3gNaoe+qZpwDKSEZlWdJ936fnMXkAXX5Lo
 LmoAs7T5O42ebO89B1kul2oPGZyqKI93zHNAXiold7M3S6iXnF8ZyKlVxD0/jOuZIiXucODOaA6
 H50Pj3elvU/Pqx7bcz7J8XDlAIevgw==
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=6902ea3c cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6mQ44K8ZfP1dJrZg0vYA:9
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: G275f9Gx-uwV_MivWdYnrZdnN7GUAQu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300034

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

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
Co-developed-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 35 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index 649675e94bab..0a7dcf7b7793 100644
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
index fa9d98cc72b7..4653b04c30de 100644
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


