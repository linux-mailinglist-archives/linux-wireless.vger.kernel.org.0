Return-Path: <linux-wireless+bounces-30175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE75DCE9060
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 09:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A94A30378AF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26453043DC;
	Tue, 30 Dec 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZmWGZvx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PbRPDFBW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EBC305046
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767083140; cv=none; b=pTVu48jSzmuKBtSb7UtCsmBjNMj9Q+U5/sHo4PTiKnAKuLfH8uHx+jC1vVYaMOA5h4WR2YI4OkDRNjepZaLJxfGjGfEaea1XdUmJbAusHtb1Nr6U5+Gn5Po9fRn/fREcFPz3ayt9w3oN130SvdLKqqsG2WD3HHfTm9oDvaMCoFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767083140; c=relaxed/simple;
	bh=9oqTuMCiJIZ+90KCUjpFx92ln1PmzXWVFohwqAv4EwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hfkj8RIlYE1voy20gv0bVM8JfsbNa4zMC6UcndD3M1ukZWa10G4ioSdjrjd2QqtOpaoFecZ+XxfSFtMsyWIcKiGF08pS2LoLmDCD/KAKoIrDUq/SYq7P9mmCeag19PWivs9AkcxakyiA6Mfsm18ZjeMUwQh/IlwsCVZ1u843yYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lZmWGZvx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PbRPDFBW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BU16G9o3661918
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ny32iZYA/yl
	4VlYq+DWcLmvo7EGRIFsGEX4pKQk8Fxk=; b=lZmWGZvxeyFWWk5Ajb3qBAsEc8b
	gfgD1mnAb18e+wJxIJqkDB4k3iHMuFC7bGZAREDAfIfb0WfRrqQyHjfhnggxzNIE
	u+/PisAH9c/m82v1apAAO5eZmIAcBwGUz6gY/ch7nubjMu0yTyCsa6xShXXt3Y3r
	Wzfadp4y2r+OGkdfpXZUaoD2k/7Qj/8u2hLX78ARQtl37Q5psYeCmZDxBztE6zRX
	BQTyMrPpF2/887DNv4FoZYLIz9s+PjxC77M+WXmfDiIjzVaeLVLB4nv7dRrOb2Pp
	xlfPov5NNViTlXD5LinvDGxLpVtN8vJtyEoFrEcRvk3i+4AY6F8ASaDWz0Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bbc8yuwp2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 08:25:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c3373f2bd74so2021592a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 00:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767083137; x=1767687937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny32iZYA/yl4VlYq+DWcLmvo7EGRIFsGEX4pKQk8Fxk=;
        b=PbRPDFBWWMwub7Jj+TJSKQ9h5OQV0D9skOFSEqfRQTVKMWilVPtxPbERgVhylUES4o
         Ufv1NpeUGGaDpK3XK6SKyOS5UMuT5DhwXS3aT/QZ/CLWKPWZSK0S0zQtKrsMbJ/qlC6I
         7+xvnE1LhYK3r2o/k0l9BZPueTBCxI3+zLMJaO8mo2e+Z6w23wr2RNoJMgFoJC3eqhXB
         E2miYXPNp/Mtdo9t09hE2y9HAihIZ7xcKDhsO+DEBhd+AUZeReIxctkVk9C1Q84ZSE5V
         emdC5SIBSlgZxTRUzKOGEKH07YOcGJRfqEqzSKIT+GKnAp92q6GIWQuy724R2mw4s4p2
         T3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767083137; x=1767687937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ny32iZYA/yl4VlYq+DWcLmvo7EGRIFsGEX4pKQk8Fxk=;
        b=Q+QxIKHXWjZYgqzh7GfPM8hzVDXSD3O4YzkmeWOaSeiTky+rfi75HRN0rVx5ZJSkYC
         sw7NGg0+h/BziDQZXrj7rRt4VE9Rvq0/HhCQw3gDRSJsuC36fAUJUpwsTsh1oUZwEFxJ
         JcATuWsP2ZtTrN+jMdZmLDgnUGpyNkXLb0KDxuAd138sKlQ3Ba66ZVWbfMLbNzASEmmk
         iFY+KwCpDyjvG7YezW3Ywmyx692Ybn/AdmeYbVi/63iiGxDjbH9PL2CxYxiPUnqCKB7p
         fJsytZlDhhi4o8RPOhHGJykjHnDDrLgoNq4eATBknzimzMjQuRfiRz+4S73x0vM0Xxno
         y5lw==
X-Gm-Message-State: AOJu0YxSFrm4/VpgUV9D9agecjSYk/luO43VA0q0Xxv1No2O/KBunHqj
	aPjAXaI9oip+znqYi0KC41fqWAhq0IkdUTNwXkI/0d0qJTOc4RJJC1+bZ4I8g6MARCTXBoglSvm
	565OLfyfhg00zcev25imjIaZ02g82oW+WCX9cSSMp8GfiWetCGm7nsHOibNJhscDLjvrtPQ==
X-Gm-Gg: AY/fxX6m3PDlHpkSENFrOTskR7KCZumN1SjKXG2i9JbolgqNuaaFtV3fkEEx4enKEYd
	i2AGEKJG4/thnQmvIdmWbIoaW0/lBKUzCaKZUdotmoj+FjWlMExeCmuc+9oSO/2Gng8IPOsEpck
	oA2oGv+ITMNCmmRLOgyrlFUukOflxStAegZG52NxKPtjCyMn5pjkTzsxkF8sYZep9OxFVWcy2pQ
	/DG/wz7is7F4eqGeECGO0LrKkDHFkyaGmx7lA0qIavpOY/cztjB2dLuO/LHzyZjMOFpNfFq4e4a
	lvedDaGRaWOGvUz5FrmmAZn1ySaIO02KJ4rQQEGuHBLNvei5DfveXBlJ6vIpBUsStR9XiZw3HiY
	8EKnH2ajcFQUO6NgzafcXCEh7BJwuIeNhFAQ=
X-Received: by 2002:a05:7300:ce89:b0:2ae:5d5e:9b1c with SMTP id 5a478bee46e88-2b05ebd0c26mr23527933eec.2.1767083137124;
        Tue, 30 Dec 2025 00:25:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUtaCk85HguGlaof9KgU0N4DhWzNr7qc5liJLhVf0XqQK5wr8V6lSlUSxvKxY2lovcgKfpmQ==
X-Received: by 2002:a05:7300:ce89:b0:2ae:5d5e:9b1c with SMTP id 5a478bee46e88-2b05ebd0c26mr23527922eec.2.1767083136523;
        Tue, 30 Dec 2025 00:25:36 -0800 (PST)
Received: from hu-zhangq-sha.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fcfc1b7sm73275620eec.0.2025.12.30.00.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 00:25:36 -0800 (PST)
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Qian Zhang <qian.zhang@oss.qualcomm.com>
Subject: [PATCH ath-next v5 4/6] wifi: ath11k: Register relayfs entries for CFR dump
Date: Tue, 30 Dec 2025 13:55:18 +0530
Message-Id: <20251230082520.3401007-5-qian.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
References: <20251230082520.3401007-1-qian.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA3NSBTYWx0ZWRfXwK/8pGx/NSgt
 0XTNNJw8QhDsMTIEbRrMDYnC2AS5mwABSOHGouP+pfBpPCTV/njfpTqJF0Yv57c8FYw3PcbWLpX
 rvo+L7czEXpYyGiNPNnHXDniWyFCeRpqRHdldMzvGIj89tPRG2Ls2VRUkzdkEXVnSWh0jAlYbsd
 wnXNQzNztfeihzBNnBd6+dR5GZjNWMVkircbZJoMAtga6ioipfBLXRi+1pTz3q9Lxr4RfIsfwBH
 wYgDJ4PJRypfCtQJcsQg02nn6mEDDHGPOwLvldw3uyJxxVCeVVXbKX+zBhgwgYUgcP5MC1id/+n
 m0Q8X/9GbWiUDbPQijHpwBNaYykaxBCliQ3aJH1LccWmzdy7PgU1KmvcGkfMuMRhzabK2ds/ciE
 eJcGItlnfb4tyiwFXzeTWNhzDaOZJFMDCnDnsDnmJ6VVET1t6sUxga6yhl0b8iKfHXDmf3TBGp6
 Px1OEoGW3JCg2NQlCXA==
X-Authority-Analysis: v=2.4 cv=cP7tc1eN c=1 sm=1 tr=0 ts=69538c82 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=6mQ44K8ZfP1dJrZg0vYA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: WTdk3wyAeGOlAoN6F2uocPUwKoLX9VNq
X-Proofpoint-GUID: WTdk3wyAeGOlAoN6F2uocPUwKoLX9VNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300075

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
Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
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


