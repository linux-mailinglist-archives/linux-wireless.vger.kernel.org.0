Return-Path: <linux-wireless+bounces-36851-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFgaB+KuE2pKEwcAu9opvQ
	(envelope-from <linux-wireless+bounces-36851-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 04:07:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 873935C559F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 04:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AB623008283
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E03261B70;
	Mon, 25 May 2026 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6MtZNKf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FPvplMqQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAC2609E3
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 02:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779674848; cv=none; b=ukQlLEhdiuO3BMf5auiHNdN61yG0JgrzRk7EC0v5Mcm6MfP0KoCVyiJPgLaLlXwOPvYq65wZsoqN6XVHR1ukQ32Rc9rvQO6uzuuPPhzDjR1SvaH7wKTV5LhmSgsBjPy19FDslIvdD14ZapkN6VEfRoLWqwENb1+sslk0vXVg/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779674848; c=relaxed/simple;
	bh=TOUR7sP2eddxxpmFsE1UOWT4EIwrVuGExJ43iLOJyjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSwfFY880bpWy56ARRLIoviBCl8FIFppE2n0hxI+hnz4HkoVFX7D50U4aKibkuJZzHc+kbr4LcDFaS7p6E0bVzf5jBg8/GQlmP3wYtzReLW5OazQvrPKceAJDkS/g6TLlwRu8kU3h1NGZ9GjvhJj+N5f4C98LmGTdEYXw7+HaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C6MtZNKf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FPvplMqQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJ01GX1670648
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 02:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=MsrGpr+YZgbAu3GU1QdDRHiOVznOzwgFXUt
	+yvs6LIY=; b=C6MtZNKfcJnz7/ykQSMFD1uVT83PZnjhgHddpsLQ/Wcxjt9Z/+f
	8pNAbz+pu6YPMXy+JbjjUUncLjKYnept/KK3Gv6CQcBEQfUfbwdAdS4DgNc2wfhu
	rnNoB+9Qjb1Xhloq7yMne4I7NjQnXB/92KUZFMUU8KZ0ZHlR6KF/w+gBZj/AV9Wl
	hnuLC/r5aBEX1Cs8Yu18KGhOYM9NtWKG+1PmNLjH/uAaQtHOZdMo+Ran3dv19YIP
	fwUc26X7vNzRQ6fyJvocoE31HKLi0PRtRxExduOLV8md26VQiogw/QCTpXdHic46
	3oiKsUNgkgq7s3NxB2jI/4aAQpG0e6T6dwA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7mfvg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 02:07:22 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12dece274b1so11863931c88.1
        for <linux-wireless@vger.kernel.org>; Sun, 24 May 2026 19:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779674842; x=1780279642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsrGpr+YZgbAu3GU1QdDRHiOVznOzwgFXUt+yvs6LIY=;
        b=FPvplMqQDZRkOR99z5SBC7p5fJ+5xKDu/kCh1+sbwc1ev8FCuarfELZkw02TIIEToL
         bQblSbS7uVj6V1F/0XdyXurbObq2a6RkM4E5PBHlvvqRCkvbQKSaPfWXIlPVYmQXM8Lc
         Ck1DsGgjhm0oTMPw8JMAuh/WyK7kXCSV4HUSd9z+3V3W8DR64rweG1VGGs5I366lfe/+
         5gopVBBfQeD847zzMM4FF8Cbn+IfYYThdcltPkBT8T4+Ssz97YuvTHuKIDVmQ6Lqs5TM
         /U0t4wtwYRgIfEywJQL3HqtORgNsuyhosCKwr5um0sF82lLu8ERHBJ89nHYWdZtLiXU+
         3A+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779674842; x=1780279642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsrGpr+YZgbAu3GU1QdDRHiOVznOzwgFXUt+yvs6LIY=;
        b=lI08snosqlaaM31WQWLyVF0EWgRP/hc7hD7tPUxELtfR5IJsEeOf27TipjFOC+e9KR
         j4NOgC1ktk5+wnjJKklU+1UdkNBWnJqppzMldkTDNfEgYnhIkKbIYgz8Gc/NWQjmrH64
         3Rf8G0aiSpUWNtv1M7s7jzGAml0ducDQrNjRdN20ui8XIiehuI4HXgai80sl71u9MbhV
         csmOCnjgn6GVqaqkc/3nKHEKzb3T/qZLUQ5MJY5bhMWr8QA4jyhUcX4LvI9GCrj+tAlK
         P4JknAk12BRtjJC8loGa7hMsALXamu+TTCHQl6zJA5lsCt6DFUActaWqAitiU0fSqsbu
         h+cw==
X-Forwarded-Encrypted: i=1; AFNElJ91SGfALVPF8hTAOFFxIXft9wkdP83dYtKs2aOUGXj8VRINkcf0gWvj7ScV/rXx0t85QaBiOTUWGR6JUHj9dg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5tgOmTxUUqRELuL+NHAiz0Oqfq8vLBnjHIY9nOuJ+HgXpscnN
	gp/LpyGATqPoI2jfGFDj/NTNjWHMVcZC9mTIfVTG+qUz+kH6EoXQXE271LUNQwD7zrtNvUWFCPf
	5PqoZOP3fSm9FSDZb3g+BKMCV8rH/yslBIgpvaZe6PvoTPcnYyR8XsQu/+5JVk+/mHE3cfBANT1
	x3fZH2
X-Gm-Gg: Acq92OGXOOe/Zs5Zy9umBJMi5M2H6yJHkIoDxwmHpPU9Fd/6P1QtzUXl2pS8vdS2dNd
	REGPLP/NkZvQqCR3zTtVIuR+o52PYgaBEmbuIEXKWd+9hZt0LiEHt6HW+7uV3kJO6IPsGzwkBIw
	GvVMvZ/HQc/iUGVvjq3pvkccEwXxuqDrXTM1rkRt+tlXDPC8eWfYqUrEir0/WbQEn5M1HWmql9V
	3TCo6R9Z2v/h4kg/JLdzBb5nm6iqg695heJQ1dVWbrRKR37q06TsJf0vNQlr0axFRmqugfxE0/s
	7iFtJMV36aNb4iXfQhMn91dx6dc7snpAQ320Rk6FLO6u0Wc4ZFz7fl7KwGBLZcFVAkanOHWG60I
	jM0n548IuefgEvR1InwkYAygb3f4zVWvIp30J4y07feBShLGO9rhVStC7hG1wqvGP9cyzDWXMfh
	JvGg==
X-Received: by 2002:a05:7022:2528:b0:12d:ca31:f1b6 with SMTP id a92af1059eb24-1365f814439mr4377463c88.18.1779674841792;
        Sun, 24 May 2026 19:07:21 -0700 (PDT)
X-Received: by 2002:a05:7022:2528:b0:12d:ca31:f1b6 with SMTP id a92af1059eb24-1365f814439mr4377453c88.18.1779674841173;
        Sun, 24 May 2026 19:07:21 -0700 (PDT)
Received: from san-w175-na3-01.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88cffsm4839011c88.11.2026.05.24.19.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 19:07:20 -0700 (PDT)
From: Wei Zhang <wei.zhang@oss.qualcomm.com>
To: jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.zhang@oss.qualcomm.com
Subject: [PATCH ath-next] wifi: ath11k: raise max vdevs to 4 on hardware with P2P and dual-station support
Date: Sun, 24 May 2026 19:07:11 -0700
Message-ID: <20260525020711.2590815-1-wei.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HmkmgfvhqoHQYFx316NoVapleBRpylkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDAxOCBTYWx0ZWRfX4EI8tTffPCHk
 cmCTRbVwYiMjTGX94gcSdRXDliPTqJmgZbEZPEPjKdlg2jgs2bpz56NXjikoS5D19zrutHg+/bI
 2ZeVBiaBnlhWndkWlfxZLWjTziZqvBhHBAm9MAcJKysYZOcgbc/SCJ7XdiPVvgwN8vUmihN6Uq6
 CxGRvkx9qNGiv+bNbuvONsGxJxvg05AsUx3TsdmtUXxTbfhUfPbw0kbXpgv026OCgvNalQ5rdoD
 /29WZ2KDUuDjfER+LbxBmzleH+K2EeZLaSby9fU4oQJqafDNHRfjh9hpLDMyGK11s5IX3Og1l0n
 A7lm3k3S1GaEvtJvH1ZfBjvbY4tRue2kHEmFzn2c++4wyq4sJ22ZZ9f0pdk4DLCLBnhCFoHC377
 gtgDFhjrweL6hvGm9VyVguTJA+MgAjDskq5aCqyw9CEySQampid7H1JKno7Q4waqraGbAN5BtoB
 8AzC6ft77tyF5FTpTFA==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a13aeda cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=6dL03X2lIcQah84ha6YA:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: HmkmgfvhqoHQYFx316NoVapleBRpylkA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_07,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250018
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36851-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.zhang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 873935C559F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When P2P support is enabled, wpa_supplicant creates a p2p-device
interface by default, which implicitly consumes one vdev. On systems
managed by NetworkManager, this interface cannot be reliably disabled,
leaving only two usable interfaces for user configurations.

Increase num_vdevs to four for QCA6390 hw2.0, WCN6855 hw2.0/hw2.1,
QCA2066 hw2.1, and QCA6698AQ hw2.1 to account for the implicit
p2p-device and enable common concurrency scenarios such as AP + AP + STA.

This change increases interface concurrency in the two-channel scenario
by raising the maximum vdev limit, while keeping other combination rules
unchanged.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9
Tested-on: QCA6698AQ hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3f6f4db5b7ee..8dacc878c006 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -267,7 +267,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 2 + 1,
+		.num_vdevs = 4,
 		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
@@ -445,7 +445,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 2 + 1,
+		.num_vdevs = 4,
 		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
@@ -535,7 +535,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 2 + 1,
+		.num_vdevs = 4,
 		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
@@ -797,7 +797,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 2 + 1,
+		.num_vdevs = 4,
 		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
@@ -886,7 +886,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.coldboot_cal_ftm = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 2 + 1,
+		.num_vdevs = 4,
 		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),

base-commit: 2e9422a6a2d8bf4036287c2fd3b034392af64048
-- 
2.34.1


