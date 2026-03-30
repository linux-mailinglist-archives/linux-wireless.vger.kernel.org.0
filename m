Return-Path: <linux-wireless+bounces-34195-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH2eCqHfymnEAwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34195-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:40:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E38A361085
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 22:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2550C301A420
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8026423FC41;
	Mon, 30 Mar 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPVXb8+b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hQA9yO+K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD639891D
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774903167; cv=none; b=oINfea3qtWk/J85rH8d7TUH/Y1oaou0LkMSBSp48YZy3mUoVZd2MsnMKRspz8HXaqrOIs1SUIAlL/vQSjPweMW3KDl08wG958Cvd9Ig0W71ucZEuin3gBwujn4GX38M60r3kFK8TQddEGVQDGYGlcNUFDFqaQYfEyo6vZ4TcTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774903167; c=relaxed/simple;
	bh=NwRUhlRAtpZ7mb+eclK2BJKeHhhHjFl+FadQlbqFxVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pZNBRAvHvC8yugEKRq6FiT8HeYvzjMa+/3vUizAEg2AHu+XsKUD3sZQewl7WPm3AqXF+gHFNHZIcatH4EuEOZ6lSAX0L+0OhIVvu9hYVmCtfUN1nEw17OsmN2/d69QKTaDhGvjuLX3DXNESfirZFq4wPYjstKLe5u0znbPAt7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BPVXb8+b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hQA9yO+K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UF9Wdn3722154
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sYYhjMFDVSGGdtAN/NncaSVaOw76bJQ6T7loTIJqlLA=; b=BPVXb8+bEFLhr+d5
	SNpnVhcpLCp2Eazj+NWzkllPz3Q284K/qalQl4NjZZ0PdORB8ay7ZCuXTbGd+kf9
	yCX9R70sp3yoeq4FjampkQDkOlSQNwu4i8Hxt5AJ/AiHQkMh9nMdYNP49uvPo376
	AZ8SwDC/B2PJmN2+3zKl40WgdD2PEPerJ3wNDwgRhoM0LvBH5zO3D/dX+Lge++xN
	lURZf1DYsYdwvIsCLdE/QWK9CJ/DHUodrCR/ZKqm5eiev5sjk8Q2GW6BlfHGzdNy
	1BiKntiF9MLSTkPCo9N763V10Pmn5he6qATXgPQF3czLmGybfrxIIz09af5GJ1No
	m/l4Ww==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d7pvmtg4y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 20:39:24 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2523e0299so46996615ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 13:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774903164; x=1775507964; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYYhjMFDVSGGdtAN/NncaSVaOw76bJQ6T7loTIJqlLA=;
        b=hQA9yO+KZtavlgZ3c7VRlzNqNsjJz8SMy//SltnndaBj9AYDDmYDDfDVKeJnKbMarz
         bYCkGodNpEeSJDv9ZiXFBAoKZVnxfg4o7R6pvi8T2UAi2GwMr48u2+PVoshvNopYIX7K
         sR8iHGGt9EU1C7ZB3YK9LHNzAuf6cLK6St53dvQjAPGvm7OKnlnZ9n0M/B6Dn2OjHUNI
         OewQBunqKAC4YYMqEGigM+55HbOI4z6LCd03H/++31GPkl7mhOypusnilvXFkn3H3p3y
         fxLxNNHsB1UJqfl9v14mHaV0AGxKsCOtrLyi1iZ7iMJJPn5fsmh1XtT9cnJm24iisqB9
         Fe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774903164; x=1775507964;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sYYhjMFDVSGGdtAN/NncaSVaOw76bJQ6T7loTIJqlLA=;
        b=CSwr30nd5b61SWrNKaBTv51Yo4L2TGIp+e5lm6PIZBn6cU95JpTfcxUMi5KZ6RDdgw
         UQdvHn50yXyBJvwcZvQ1/nlcW+4vp0f5Bj/Ce1fjcsncsXgYvF1AUnrzRMwXIofza5o+
         fWvM8gEXk8BC+paeOBPvjq+mZlhsvFh6cccTJe9XaQSuoE4kDogUhyA03YnllfdT+XUj
         LNMgb/wUgD/+PxVkGtqGRjLv731lBQcKgp4J3ooUlxaDavq3ENXrSo6pmrAU5PcEEBRq
         TJkmJO+4HcrRiBVRTtgwuYKUWZLdTZc6yzDP0UzFczzd1z+ujl74s2XSLxvZFGnhaJza
         3CqA==
X-Gm-Message-State: AOJu0YxHY4DjIMoOBnoDQlD79cds695+hAmrRx32stFx7trJ7uwJl5wC
	kIjoSrzuKYHI4ZcII6JztcnbrzJfJDv1QNkhnKiOaiGTq/6h+RLJOQ7ZCnnm2Af/JsiraB0kwck
	hKjd1qQFQKT3GNWj7RSr5LxncwqmHX4n5BF6rgxzsAOass65DQUPWsXGPhEbNAndk93MbKg==
X-Gm-Gg: ATEYQzz3ipdBmaCakyGcj9cFeL10dRxTq//0+rk+V7+ohdkD6iY9R/C9xGcBobaOeOx
	UNBecczLWAvXKsVor7S/rCtakXRKT5ZefbqlSUEHD5Wd8Ap8KoZCFAb288yk1r2EyVqLVCER5+h
	Z4WGJ6SO4U6lOXWZn1bHtUv7Bl4gHyNAvqk7n354ffz7Oc4NIt8TEjtsNRPfjkDykXDEAseqcuU
	vlenb7j3p3oInOTk9RzzWtoQoN0G4O6fc9C3Jxxf2ta4K4895Vg1DcPTBz7j90E7wmRrmyHslgD
	Fs3dpuF5QwSgH4804FGW6UcFW0yZAM0g5G9ACxwkelozjGLKxSuQXnW5dDKTCqjGQMg0HaTFU9z
	n3WmeyzbrsmxeEEtD2BJ1+i5hEu8QntTSghuY+1pm5kLv1jtoSmmuR+j554B5vTSB6cBb3LJaKP
	R0ukbK06R3utcinAu/ljCFWHduv/497rGyWxmsk6A=
X-Received: by 2002:a17:903:28f:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2b0cdcb0791mr138534455ad.28.1774903163978;
        Mon, 30 Mar 2026 13:39:23 -0700 (PDT)
X-Received: by 2002:a17:903:28f:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2b0cdcb0791mr138534135ad.28.1774903163479;
        Mon, 30 Mar 2026 13:39:23 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm113517195ad.78.2026.03.30.13.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:39:23 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 02:09:07 +0530
Subject: [PATCH ath-next v3 2/6] wifi: ath12k: Add ath12k_hw_params for
 IPQ5424
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ath12k-ipq5424-v3-2-1455b9cae29c@oss.qualcomm.com>
References: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
In-Reply-To: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>
X-Mailer: b4 0.15.1
X-Proofpoint-GUID: Rv0FIWZ2lDWFTRdbEalBhBX367jikiZ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE3NCBTYWx0ZWRfX2oy/0IrN5MiN
 EA/uvUJJZff8TkOOLxAOLStTunV9a9r8Z8mPa/m8MORe49NkTPf5QjRjLqxizq7o5me390JNlEF
 VcdZJDPnDl4rFD4zfesfROhR0yxckCRmWPeyMg+pQXVjO5nEsZTavwqCnT4Wti/TTG3INt8R/13
 fjceRtTzXvdOyRlmr22H0qXQlxy15fF9VyIsTVgbtXBMwpnRZ81WjhkrTi1I282AZtTx/AwsV3n
 kUcTKEK4AUFBYLjXWloQiQAegcbE16ah7JPgV/UZHeoHUC5j6dh7nobLSqZ801E8XWi1KnE6G76
 9kEHidtK2IiKqQrOxsllntLtmRSPBpPhNi8KHg3O28ItvTS91jSD352BJTz6jjCfbuAjbQKmDQw
 y9Dm83zf2DWFvrH1RnbeflP99UIwvi/XGMVbsjAnYXm+KeDa+lG3U7PnAUmQ2kXGdpCS/lmKjNi
 XfSIN9wdD9AOYLlL9Pw==
X-Proofpoint-ORIG-GUID: Rv0FIWZ2lDWFTRdbEalBhBX367jikiZ3
X-Authority-Analysis: v=2.4 cv=S9rUAYsP c=1 sm=1 tr=0 ts=69cadf7d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=vBmMNsOPyRzkxF6eNBIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300174
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,quicinc.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34195-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E38A361085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Saravanakumar Duraisamy <quic_saradura@quicinc.com>

Add ath12k_hw_params for the ath12k AHB-based WiFi 7 device IPQ5424.
The WiFi device IPQ5424 is similar to IPQ5332. Most of the hardware
parameters like hw_ops, wmi_init, ring_mask, etc., are the same between
IPQ5424 and IPQ5332, hence use these same parameters for IPQ5424.
Some parameters are specific to IPQ5424; initially set these to
0 or NULL, and populate them in subsequent patches.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ5424 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1

Signed-off-by: Saravanakumar Duraisamy <quic_saradura@quicinc.com>
Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/core.h     |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 75 ++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 59c193b24764..68453594eba8 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -157,6 +157,7 @@ enum ath12k_hw_rev {
 	ATH12K_HW_WCN7850_HW20,
 	ATH12K_HW_IPQ5332_HW10,
 	ATH12K_HW_QCC2072_HW10,
+	ATH12K_HW_IPQ5424_HW10,
 };
 
 enum ath12k_firmware_mode {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index ec6dba96640b..9b9ca06a9f45 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -753,6 +753,81 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 
 		.dp_primary_link_only = false,
 	},
+	{
+		.name = "ipq5424 hw1.0",
+		.hw_rev = ATH12K_HW_IPQ5424_HW10,
+		.fw = {
+			.dir = "IPQ5424/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+			.m3_loader = ath12k_m3_fw_loader_remoteproc,
+			.download_aux_ucode = false,
+		},
+		.max_radios = 1,
+		.single_pdev_only = false,
+		.qmi_service_ins_id = ATH12K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ5332,
+		.internal_sleep_clock = false,
+
+		.hw_ops = &qcn9274_ops,
+		.ring_mask = &ath12k_wifi7_hw_ring_mask_ipq5332,
+
+		.host_ce_config = ath12k_wifi7_host_ce_config_ipq5332,
+		.ce_count = 12,
+		.target_ce_config = ath12k_wifi7_target_ce_config_wlan_ipq5332,
+		.target_ce_count = 12,
+		.svc_to_ce_map =
+			ath12k_wifi7_target_service_to_ce_map_wlan_ipq5332,
+		.svc_to_ce_map_len = 18,
+
+		.rxdma1_enable = true,
+		.num_rxdma_per_pdev = 1,
+		.num_rxdma_dst_ring = 0,
+		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
+
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				   BIT(NL80211_IFTYPE_AP) |
+				   BIT(NL80211_IFTYPE_MESH_POINT),
+		.supports_monitor = true,
+
+		.idle_ps = false,
+		.download_calib = true,
+		.supports_suspend = false,
+		.tcl_ring_retry = true,
+		.reoq_lut_support = false,
+		.supports_shadow_regs = false,
+
+		.num_tcl_banks = 48,
+		.max_tx_ring = 4,
+
+		.wmi_init = &ath12k_wifi7_wmi_init_qcn9274,
+
+		.qmi_cnss_feature_bitmap = BIT(CNSS_QDSS_CFG_MISS_V01),
+
+		.rfkill_pin = 0,
+		.rfkill_cfg = 0,
+		.rfkill_on_level = 0,
+
+		.rddm_size = 0,
+
+		.def_num_link = 0,
+		.max_mlo_peer = 256,
+
+		.otp_board_id_register = 0,
+
+		.supports_sta_ps = false,
+
+		.acpi_guid = NULL,
+		.supports_dynamic_smps_6ghz = false,
+		.iova_mask = 0,
+		.supports_aspm = false,
+
+		.ce_ie_addr = NULL,
+		.ce_remap = NULL,
+		.bdf_addr_offset = 0x940000,
+
+		.dp_primary_link_only = true,
+	},
 };
 
 /* Note: called under rcu_read_lock() */

-- 
2.34.1


