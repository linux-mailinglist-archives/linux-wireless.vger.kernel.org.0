Return-Path: <linux-wireless+bounces-36455-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEAXNGGOBmoHkwIAu9opvQ
	(envelope-from <linux-wireless+bounces-36455-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 05:09:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E30D548EAF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 05:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B948F300DE2E
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9D93CB91B;
	Fri, 15 May 2026 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XJ6QwQVd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S3hVsGzS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4803CB918
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778814559; cv=none; b=Mngso/cWBuTKkOCe4KFyRN+F/psLIC5U6VlGa1iSLgyvk3hnVjJwZ2AEucgvTuE7oQ7rZltOsI+CQxJtvZdpGdCzVm0JrNXWG+0Wrvs1gcBTHUADfUfhexJqBs3bs6xBXM80U9X2ZAeB9ZBxPxyGbXy7ZKsoFG/ufRniLm8Yy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778814559; c=relaxed/simple;
	bh=8CMp7vVJystfhHyMeILREMKcsg//naGxC9xKPs5O8Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aR1fRYbj3sQ2evWM5I9kx4l7Z4cpsKdIgB6elx26PMe7gNSaSXo8v8uq2uxDg8vEAhzt4zgYMT9fFrfUX79Q8l2oljoYatgNFNl5BZxYPfAgOg3P/2+A0NJjZ/uAUjYGo0L1jdLuCev4aRSMJvigx5yRjUwOFKNAxZitZdSmAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XJ6QwQVd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S3hVsGzS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpF7b3197600
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 03:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xNaSX0ZjZaDQ+ouN6CHQGcgE/bkIh5J7f1J
	mzYdKatM=; b=XJ6QwQVdxuktfDn4I5ew+Z4cuDD7AqDAcl+nAU1ku4gX85NRb5D
	sf6GGEWxEzinZbXY/7zmAtyVJV1pCG5SLaYgn3PRvdqpXFS5FMWuJtbrI7BWPRmg
	4xNSpNZS8nGVaMjclTUZ2AGrHMkGzhNk6uDWxNzXu8hVf0dQZYuyQVLEBZc+6UdN
	O2oGB+YVPFFpXB7lXrppNHUWRLKXL56OAC6ARUlAiU6Sol2/Ti/Y/sdZO9d20AMh
	xJxdtjsVyjxdf9tkexdXgQbrP9N2nlv3SHYEPFIQ5qsxTW52XylwqR43q1vUJQvX
	czWBSCI8nfPDht5b50RH8M68/vrlu5kWu2g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1q9a5r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 03:09:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c8271fb4407so6675845a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2026 20:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778814555; x=1779419355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNaSX0ZjZaDQ+ouN6CHQGcgE/bkIh5J7f1JmzYdKatM=;
        b=S3hVsGzSzAwOni3OnWcn2JObXsfqpJI2qE5tNXX3/i5YzRNmIa+CyDmhlrl9SyFFbw
         vwm7tNY09Sh0CmFXL6gb9ifRLXsktRd3rdMFqCVNMD7pKd6wUfGuYD0UwK+/33Li6xI5
         IN3EBtdkKFMe3Jut0EhUplxcaAmrLGs0kurw3EAtBR8glV6QTYD2jW8TdZnVMfXeJssb
         Li32wyVuNVvc6QBZ3pqHi4/q+r4oAQTxyn7oue0dI9Xdo3xap+3cNhprHKuaynJekqjU
         Gl9l367p/ma3Nd+Huw6iSS1O88Qqhmo4RFay3UFM/O70NYsUiGnh/WtV2fkQrdQTZxz7
         QbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778814555; x=1779419355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNaSX0ZjZaDQ+ouN6CHQGcgE/bkIh5J7f1JmzYdKatM=;
        b=H/vl/ERHw5AByyUyH7g0FR7W3rWuK79JvQhy9VCoqnvUfcunUrX2nGEa4d3XAE+QdK
         tdZn/B/MIk0ENpEZNrCK/jcWzclzNOSsecftnGVdEVorLZl9lzz4ck3vcPLJmEvyR4H6
         tJF1rP1ot3r+xuPryR3++6/DsZuRK9FMls8UYrGEbJ4H8VcMTSOnQeLUQte6PziH/trX
         DIsvV+/EU983EGugfBHoRp7DgCYBSXsDmu+sCLwkh9e68/ZwteD4ytFe9vknzOI5R9O0
         cpXyNFVnU3/pcekLWvvzB9EDJUcNT3iTt0ZJhlSVCLbqLYZ6xhMYvafVR6G00WU238ns
         Q/qA==
X-Gm-Message-State: AOJu0YySQ8OsKBy3ZpYFmk6m7VwRSz3QGoTIIxTL1jJKT2KkByIipR1K
	8J7gXUd3lVakxdgahRbnH0b3rMFpbztUCMwgu56RXdfamUwNxbOXib1UTEUVDyVXjQB1SdrKC2L
	vVbxwX5zWKiZHDdUw2ONIDfK4QIikwwjkBbu+guO36DcbnEwOgOD05tCocpsQegxg45J94Q==
X-Gm-Gg: Acq92OFKvteGEBUfFcM1x09idBpbkWPRA9kc05NBmqjCo/P/3rvR8vyHhIxupCf7jWz
	l1ycxiWbastsd0y6jjtml9TjjazeH8qgu67XYlO25nvZp0xXH5xar8B2Vo/lT6SHV/Mlwc3yMIP
	B28yuLrf9PFcGdtteTE8zOSBwyCFD/fxw8PryaYGeqXeBtmOfztbNS1SC+3Sl5YC5wjfrj6ELFD
	bRHDLLFxMu6RF6cOWPpepWiWsnE81sZoG/BqQDMbXZO0Vy57wWFSaozqTQhZEcbkC1YVk5eqdkp
	l/CAWl+oaGqTK23K71GtTps8vTxaMCKAYMaWTER7ckWk9tDFTS1/OQ8K42CpRDCD9W6w4t71Ua9
	+hkHyzGlLD2O0GfGpPXcd5vKg3QO29fWRF3MTXfHAMfyF58wyNYw/ovwhrihZClgDYnjRH3TcrX
	+jS/L6bAmgHx4wSocn6pMRkD1kLX4k66NzSm0r52zZ7dexZV/CexpxcPA=
X-Received: by 2002:a05:6a00:4b0b:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-83f33dd0695mr2407130b3a.33.1778814554845;
        Thu, 14 May 2026 20:09:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b0b:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-83f33dd0695mr2407092b3a.33.1778814554319;
        Thu, 14 May 2026 20:09:14 -0700 (PDT)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7ed3fsm4205041b3a.45.2026.05.14.20.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 20:09:13 -0700 (PDT)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: add hardware parameters for maximum supported clients
Date: Fri, 15 May 2026 08:39:09 +0530
Message-Id: <20260515030909.3312511-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: a804YfhvRrqTeJoeoPbFeAA7pVR4c51b
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a068e5c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=d6oOGSSlwGQnz5sBqGQA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDAyOCBTYWx0ZWRfX1wuQ37BOingI
 M0QRSB5yq+j6jx2fWehcanh2obiEvFuCTooERDeIgQmqRM9+rYqblfy0Ct7g2AAgZJC/2d0zYyz
 ZeXShlJE4tbWCFqprlR41jllZ0XsbjfbF65xEa7omCZ5v/sF3Zc00PydDP4XYN50kofEtnOF3zj
 aJve44iPRrD+vktS13/YQ9ByIay7uZRb2dNXlUs5sybXYVel+6b9/q/WmoNCtUwNscObhxPa1jV
 VTNrmpx9UeMxLMm1VYJ5lkrkObKhTkIGYx4mgU1ENFYJPph11pf2wlQSq/Uy42TI6EXDC2PK6ko
 opndh5Xr3VExOHZI+SsCGKztGPhLjeelwE9w9YzkOFiz/zE+jVIOkOzeFtzvOTgcuACNCh13dum
 hG6I0UJuW8xJdVeSM3Km/H2EDs/lR8qCXMQfppFqqybM4YPjcnOc5Tv+Hu+dOQicplnnfaDtIEt
 xdqUF5pa3Htm04Mlq8Q==
X-Proofpoint-ORIG-GUID: a804YfhvRrqTeJoeoPbFeAA7pVR4c51b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150028
X-Rspamd-Queue-Id: 2E30D548EAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36455-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Currently, the driver uses memory profile parameters to determine the
maximum number of supported clients, with a default limit of 512 for
single-radio and 128 for DBS and DBS+SBS configurations. However,
some devices have lower hardware limits depending on the radio
configuration. Exceeding these hardware-specific limits can lead to
firmware crashes.

Add hardware parameters in ath12k_hw_params to define the maximum supported
clients for each radio configuration. The driver uses the minimum of the
memory profile limit and the hardware capability limit to prevent exceeding
hardware constraints.

Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hw.h       | 25 +++++++++++++++---
 drivers/net/wireless/ath/ath12k/wifi7/hw.c | 30 ++++++++++++++++++++++
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index a9888e0521a1..d135b2936378 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -19,14 +19,28 @@
 #define TARGET_NUM_VDEVS(ab)    ((ab)->profile_param->num_vdevs)
 
 /* Max num of stations for Single Radio mode */
-#define TARGET_NUM_STATIONS_SINGLE(ab) ((ab)->profile_param->max_client_single)
+#define TARGET_NUM_STATIONS_SINGLE(ab) \
+({ \
+	typeof(ab) _ab = (ab); \
+	min_not_zero(_ab->hw_params->client.max_client_single, \
+		     _ab->profile_param->max_client_single); \
+})
 
 /* Max num of stations for DBS */
-#define TARGET_NUM_STATIONS_DBS(ab)    ((ab)->profile_param->max_client_dbs)
+#define TARGET_NUM_STATIONS_DBS(ab) \
+({ \
+	typeof(ab) _ab = (ab); \
+	min_not_zero(_ab->hw_params->client.max_client_dbs, \
+		     _ab->profile_param->max_client_dbs); \
+})
 
 /* Max num of stations for DBS_SBS */
 #define TARGET_NUM_STATIONS_DBS_SBS(ab) \
-	((ab)->profile_param->max_client_dbs_sbs)
+({ \
+	typeof(ab) _ab = (ab); \
+	min_not_zero(_ab->hw_params->client.max_client_dbs_sbs, \
+		     _ab->profile_param->max_client_dbs_sbs); \
+})
 
 #define TARGET_NUM_STATIONS(ab, x)     TARGET_NUM_STATIONS_##x(ab)
 
@@ -213,6 +227,11 @@ struct ath12k_hw_params {
 
 	/* setup REO queue, frag etc only for primary link peer */
 	bool dp_primary_link_only:1;
+	struct {
+		u32 max_client_single;
+		u32 max_client_dbs;
+		u32 max_client_dbs_sbs;
+	} client;
 };
 
 struct ath12k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hw.c b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
index cb3185850439..98bf9293dd33 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hw.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hw.c
@@ -434,6 +434,11 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.current_cc_support = false,
 
 		.dp_primary_link_only = true,
+		.client = {
+			.max_client_single = 512,
+			.max_client_dbs = 128,
+			.max_client_dbs_sbs = 128,
+		},
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -520,6 +525,11 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.current_cc_support = true,
 
 		.dp_primary_link_only = false,
+		.client = {
+			.max_client_single = 512,
+			.max_client_dbs = 128,
+			.max_client_dbs_sbs = 128,
+		},
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -602,6 +612,11 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.current_cc_support = false,
 
 		.dp_primary_link_only = true,
+		.client = {
+			.max_client_single = 512,
+			.max_client_dbs = 128,
+			.max_client_dbs_sbs = 128,
+		},
 	},
 	{
 		.name = "ipq5332 hw1.0",
@@ -677,6 +692,11 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.bdf_addr_offset = 0xC00000,
 
 		.dp_primary_link_only = true,
+		.client = {
+			.max_client_single = 256,
+			.max_client_dbs = 128,
+			.max_client_dbs_sbs = 128,
+		},
 	},
 	{
 		.name = "qcc2072 hw1.0",
@@ -764,6 +784,11 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.current_cc_support = true,
 
 		.dp_primary_link_only = false,
+		.client = {
+			.max_client_single = 512,
+			.max_client_dbs = 128,
+			.max_client_dbs_sbs = 128,
+		},
 	},
 	{
 		.name = "ipq5424 hw1.0",
@@ -843,6 +868,11 @@ static const struct ath12k_hw_params ath12k_wifi7_hw_params[] = {
 		.current_cc_support = false,
 
 		.dp_primary_link_only = true,
+		.client = {
+			.max_client_single = 512,
+			.max_client_dbs = 128,
+			.max_client_dbs_sbs = 128,
+		},
 	},
 };
 

base-commit: 8b3115499abadba0f4f8408978df0c6d258fe7ea
-- 
2.34.1


