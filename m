Return-Path: <linux-wireless+bounces-28552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC1DC32101
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD8A423B88
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A18333755;
	Tue,  4 Nov 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gse0mVpQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="atu45Jun"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6A23328FF
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762273607; cv=none; b=F8VDpFQOmPnjcf9f//2z1PM5yar9/ClFQowSxAspZe5v7i/gp4ag1P8RvejTPm+IJFc/KQr/6cWgwNFnSGxu5blTPuiFspYEDIq+iA3VJ0J2NVFTHeYLQd9L6KH4uhec9erwNLwpmzgw3VKHdpD/MFIWDillFrD6ne1nPaQp2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762273607; c=relaxed/simple;
	bh=Zfq0tRzBMK/stIqYR/fNd49x0GpwLSnbF3DD/tpTY64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bsPC4dhCtLI/2f6db/xp13I0ZpB31VBG5c/P5bApKrbLelmMrXXgo924jQOsYDY5fA7xag6xJu3iR6dWNOHeNzsVBydJfqAACs35UkfV8tiIPWP0czxSaxEQvl5aTlHzvwKLBU+uEGwI1JUrJAFHdbzF870zxzvVGxt3+HPh5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gse0mVpQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=atu45Jun; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4CfWPV2042631
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 16:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5Vssr73RyQ+
	FszqtmkVaSpa6VDKHA4NdGYdJks1BQS4=; b=gse0mVpQzJ7H9T+CYYVtnNuCqZ3
	lL0KaN3MNnmA7TZnXUucjxWbFtZcRzO2725b25NEQTSTcoAoXxvvQMXDZitcQgrW
	Z715FtQ2U0xCeaHGApns8WfjhWC++EnSbkeu9sFq5SXmbq6L0E0QyCOWs0ltNaRw
	fLvhAKcQicU6oPQrR0o6aRqOZsGOeyW//jVAtEKyGSWl0F3i895EaNx2zr0U9Jbm
	ktUpjiqXKnHYiGmG2jVgUyn4NC8neApJm2BDQ4EbSpprkqN9DIJL0TST7ie6zGK/
	TTzM5dudvkuhpu5DfhL5jPa2pcm/iBtwUifRTqED1HpuFFdW8x0zQZOkyiA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7fgrh0nc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 16:26:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2955f0b8895so34127985ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 08:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762273600; x=1762878400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Vssr73RyQ+FszqtmkVaSpa6VDKHA4NdGYdJks1BQS4=;
        b=atu45Jun46I/xJSNSmcSYMjD5xewq+qpT15HpEIcpRpbHnlkz1FJnVkD6ONFS5+SiV
         YC7dJIJbSWy8Q285VULRi2DtuAqSKfexYBPDzhckx0IjUHg4rspxT7QPTYt/CXjiAZO5
         iqM1XaLZNRLzdhaZwRLFiV6ST4xZy2QOzUq9s7HrMcWLAmdH/kPmkWwVM4U/ybTqUPVz
         /QvyVj49LmTl+14pzMnDrY2VUmbFyXVLKeh34qDRc7uVByZOwfC6h2HqjDhXVuJC4c3C
         yYscJCXBacOJZwpIut8bIv6BxBLWHxiJfwK233xfFDpnNwdEWNmiLGa4Xln318zqqM2E
         614Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762273600; x=1762878400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Vssr73RyQ+FszqtmkVaSpa6VDKHA4NdGYdJks1BQS4=;
        b=JTTDXHfykZgYq0SSeTSm1OoCpZzQQR8933wx5iCyCLagkJ26CpPCQCaEZcalXOdWt4
         mJhDQbDThCCl+IAgfCfIhlYgPaJBdBjlCtzdEw0kujeUSWOKDEFaz31xL75QxKUpnAXX
         DRhrwbwwGUS6HcM8hK0Wy9rgDjv7LN6jjL8J+LlfVDw62SUiCkk9OA7sBBa/NsxKmJ3p
         AahZPmEjM6WUScsVXLX6BGiknp5i4XEDqgatAQp+/8Mv/ketlfb4CpT0MfOn63JzBOk9
         RPseXcVlbZSQ1OgjZsix9jc2V4JWys3pmNvR0AQDgBeRBRq5hUiFUMTWVNiRXZS31Fnn
         xMng==
X-Forwarded-Encrypted: i=1; AJvYcCUEL3hUFyAc400H+uzecTJKfoR0qG+0Y8FXf3f1iPjSapJRep9d/XpT0RCZXJygv1Nk3CWzrBaURzZaan85DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YylSUbJ82t9WhaOqYhkXptdQsJI5xONuhN7ukltab5XFjuF4ctC
	qlDrFEmdLs8H9nwaN4k+qMS64lqBRNL6Nkg3rjV1my3c689mo96Qidz5vUbcpHCcSGQypQsw5VZ
	jLKgsdMqICOiRewVXWPBQrR/0RYLeeQXHHByFJEraghJDYXWo0B4rm5iGbYvQ0fc2FSZzgQ==
X-Gm-Gg: ASbGncvP78/oC7H06LwL5qMAGx4PCuukP97soBlJd73MpNuoGf3rsNdNrxXAKsTBg4Y
	Ntf9d95mukYTD4fh1lkRB3xhv+dt8rBGUDut0hpDlaym1uKTCL/s5OjYBr51aePFjJO/K5MHbo7
	RQBrYkCHeVnCZDI03SJLedjGQRwJy7pInYanLZo8cX8CtXJVy/XyUKlnHzXLtwGjM5t6G7tI1Hc
	SykMJz02Lts8prE4dYNTQXn7KHpPQo5zChOK3fLm2M1nO6HmtB38orK8NUeN10bzG6hv42femMp
	kUQVGwXXCT3kt/120MpXat1CgZ1Ec9L0yN1Jyu6oQ6Ljy7YZ7I+UpJa8riVbTneatzNPZm+rfe7
	MKCWG3f8vgSzjpBWI5Z464dQpgqQPFnyui5rnGX4m+RE0
X-Received: by 2002:a17:902:db08:b0:294:fc13:7e8c with SMTP id d9443c01a7336-2962ad41aa1mr3110005ad.13.1762273599579;
        Tue, 04 Nov 2025 08:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNZs7Qx9rkasOM8xWADo/sxz4Q2imfM3mJR8YCwuWSazJuiOsuh4+13f7zKN4iISctrbrl1g==
X-Received: by 2002:a17:902:db08:b0:294:fc13:7e8c with SMTP id d9443c01a7336-2962ad41aa1mr3109615ad.13.1762273599075;
        Tue, 04 Nov 2025 08:26:39 -0800 (PST)
Received: from hu-yuzha-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7a8a9sm31508435ad.107.2025.11.04.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 08:26:38 -0800 (PST)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 4/6] wifi: ath11k: Register relayfs entries for CFR dump
Date: Tue,  4 Nov 2025 08:26:31 -0800
Message-Id: <20251104162633.3007874-5-yu.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
References: <20251104162633.3007874-1-yu.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Qw5I2uZ8c1L7uAA1co6JxvwofzBAOTGx
X-Proofpoint-GUID: Qw5I2uZ8c1L7uAA1co6JxvwofzBAOTGx
X-Authority-Analysis: v=2.4 cv=b7O/I9Gx c=1 sm=1 tr=0 ts=690a2940 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6mQ44K8ZfP1dJrZg0vYA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEzNyBTYWx0ZWRfXyqKlgwfc06oe
 ZgiDMWDc4kiuTftIepq1gM28zMY7SJX+WfmW9/bXLIN8Ee8OGK83J/K9Y4TYnxMQzJKKFYjA1Rm
 wFBgxN4BFWj1gn5StZgqv6dEICczOaXon12beqFqeuGTaY7ZersZCKPd2/a0Mcl4W8hxKrm08AZ
 NzpW1+OD9dYI7HfxqRw/S/y6FGfiS9Enit/r+NgrbN6t2JY8ZGHulYNijHI96FRbsk8QiCgkF9u
 fLUaT6DHIMuVfpdJU56rCygQHJnXgsvnqCDjBarEYXscWOcZQbYq7/kGn56rHVFxU1TkgCmlE+i
 MaO+xeLNCvGg4UvivH6SI7CXlPyBBoKRb0d80B5POpinWchoNkJKrV5AgrjJpJe6T+2Wx31PpR5
 go4uIv5UCjFr1PnU6zavujYTtyd6Gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040137

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
Co-developed-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/cfr.c | 35 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/cfr.c b/drivers/net/wireless/ath/ath11k/cfr.c
index 0fa81c939860..861e457ec5bf 100644
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


