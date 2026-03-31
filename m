Return-Path: <linux-wireless+bounces-34214-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FEpKtTZy2kaMAYAu9opvQ
	(envelope-from <linux-wireless+bounces-34214-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:27:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 894CD36AF17
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 16:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79442303ECEA
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 14:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CC43FB04C;
	Tue, 31 Mar 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P0bsVUfG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LxtIy3dA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BE3FB7FA
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967112; cv=none; b=Sdh5/Pk0YzeHc6+RHASnxjfsOqXpTEn57piDTTG1uJbpTtMWa6Ag4ZXdJSlBpsLlihEOnWNtplQopIl5659FF3PJhReCLiUx3iKi+b5ekhn80wmdLQIgYjRcVaLf5GYibIRL1ee2CojUO2C0Sc0vB/JD3Qdu6yK4tKYnCFMMRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967112; c=relaxed/simple;
	bh=kSMNHqw9tLLZCSzErRCovvyWmss8pe7IHRD7eLKOyDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ocbrZrkFgq0RObFBU2LPzdKHFEigaVgLngL6wo8+xVWYC1nZbAxNvfl8V1XQMqERJJxx+Ag8SPdOcuNdfc0tuIL8QgwzfrfBt5OSGaD7lLpHSFUY7QNjbICp52CGvN+AGg/puB/wcu3amNgYLitEoSGSZkS6N6IP/o+r2D2ecd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P0bsVUfG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LxtIy3dA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V8jq1T2049348
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=s7xvJ1gB+sd
	l0YMJqrTMEyxnDviWTMhymbpIffHmF7c=; b=P0bsVUfGpfbwTpOFRus8JnbDQZD
	T/+kpGNGZc+P9HWEtfxFvxw3puqqk80WigaLf+OntrFLLofhWM7Cr+i3873mudOA
	f8TL91yiW9gKEdBkfnx22mNT8eT5RW9Fgl2/02DpzWWDFtrluMhBCu23bc47YhuO
	SGsNdwVtcmGTUI1d20TX/CQozUmPIkUjAB10y6e+7p+0lURidBimAULNuoHkSGag
	1W7NCzeZluk00iojrS/I+k5MD5ZEmnBgnK/jQcPDQO8u34cSvoUlhfglyICQ/p4L
	jpC8lxdnL4KKc3BBuSD5YXQNKQw5Fq4WCE5vHWs+31gcoM2A1/CDypoYu0g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8b1yscjf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 14:25:09 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b0b0aae381so75527835ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 31 Mar 2026 07:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774967108; x=1775571908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7xvJ1gB+sdl0YMJqrTMEyxnDviWTMhymbpIffHmF7c=;
        b=LxtIy3dA7Eh1zSIQl12diagdlg7Fu7uM3Z7nsqYphPOmoiXZSU619DwozWNm3E1jx1
         dL5LiTLwd4uxb5loBF8FVvP1F+uDCMe25c1ThT6awUvkesjCC7L3FovtRpuEzAyH4BzT
         uktF4/k1lOkMFGT5anp5+DjHQC1kuCF6rjG5FqeI/671sU2BNIekOOKYDXm8AjzVz0Hs
         ivkx/U/BystPPhCe6/clSMHhMO4O6HixubNsDZjznqPQL1+t8IKm7lwqd3bzoqMFLApR
         uCCVjZDdu1QTApI6fvpBYktEMZS20iYwT2q4KT2C3NIEbYK8XH6i23Qp6YwsgqpoaoNM
         giKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774967108; x=1775571908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s7xvJ1gB+sdl0YMJqrTMEyxnDviWTMhymbpIffHmF7c=;
        b=ShJaMpnPo6T7EwFEZrHRIWb6JPmHTOp32k0veO0l14VTDRU8vHseT9hz4rMoOqmH/5
         j0Ppe/hnb5Ycr3ydS8E3AiHh0OYIA42xIpY0LIknsXNHx9LsGFq/cDhGsrH9Wvu9t+1Y
         LB4AfNrrZEkW6ytBXJOGlcwzv7wxdw1P1pdjWlFRgFBzJ4NyjTIHrzo0/6jnqj/Qeju8
         stDVBHWlfrGYiawJ0bWRQPs1bhkz6V1XPNhz1XSPQ9PWON7Uaa1bW636Tf7xeNB+XlLx
         PCvHHiV8fp+1DUTNjIdIF744mRGJ7PkRei5Q0a2WAZlDn1p2vow+GmcDVBqSj+XsQGtK
         ERUw==
X-Gm-Message-State: AOJu0Yzv1QALNxV71GEIVGzy5vdm6usbP21KQJt4+jFOdo5iBbrhBTqK
	ycvShs6xtRJF25fGX/Wtku4cFwKhHOzI1vfu1ncPmMhw+NvCBqWduYlawuaT5J8MYkFvdSrZDtL
	9eCJLMEgceyivlnU6BRgu0mR7j7bZWQZUvHBPpbE7xdC2r9t2ysAxUZk3EzBy4LaYWFbuPX/5Uv
	nMMw==
X-Gm-Gg: ATEYQzwJV3SvN5rCk9Zj1o83FYgo7RGVdmq2giL13YmtRwgDkflqXZdplaBZVznrdKu
	skAUWPYZG6O66wqGBm36dZ22WyzJnE9lvpAQNKbPdd7vs6ygtrSVoftGhCgc4PDz0wb+cPf47DT
	d3PGDZezJsIJjpHA2IgBl6dqYz+Hk7aXL4vH6Oh2RIKdiUklwHfRa3RWLQvbd91PP6PMyHpwbkl
	881uCNG8sEe07sfVKhbhEN3hodzFduiAw+FnGrgT60Uhu7woTpSdrSBjsd0njm0Ser1EzRf/XBK
	JlhWPCl/dFn9VSwwcv62gssZcskkTjoQy6mhyfFw6JfrShKFMjlKAwZ3rmfsJJyCYiXeLvo2Wxc
	IS/1KY+5ZGpbxzHjwyc9m24Dn3rruYebdr6vv+etI0cxEBedjSvwAzO2KuEDpu4IEOD9wXzYlbC
	PmyVv6QcsLpZ0ZVQqYleXVE/+0ype36XCxhUZVDmScadEbncAvKiE=
X-Received: by 2002:a17:902:fc85:b0:2b0:5990:cf1e with SMTP id d9443c01a7336-2b0cdcc8706mr154107665ad.33.1774967108098;
        Tue, 31 Mar 2026 07:25:08 -0700 (PDT)
X-Received: by 2002:a17:902:fc85:b0:2b0:5990:cf1e with SMTP id d9443c01a7336-2b0cdcc8706mr154107275ad.33.1774967107451;
        Tue, 31 Mar 2026 07:25:07 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24276689asm112030225ad.38.2026.03.31.07.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:25:07 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next 2/5] wifi: ath12k: configure firmware thermal throttling via WMI
Date: Tue, 31 Mar 2026 19:54:43 +0530
Message-Id: <20260331142446.2951809-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TcaWAiUZQCyOL9hMOXsRsGwj6cwogkam
X-Proofpoint-ORIG-GUID: TcaWAiUZQCyOL9hMOXsRsGwj6cwogkam
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDEzOSBTYWx0ZWRfXwPcW7kZeLvLB
 BoiGiZNKDvH0GKeh2HbBvvB2Z3jxGBnF+08WbQn/3kK8v0vH5bJ3gzNyp4Dq03t1w5cBoZgMmvl
 sLg3f7tKmWv7Ig69P5f7gdEDNIYKdoR9GYPbBaibqy6YeA7CcojQZxZoC7VAAtLHGROsR38L/9E
 mJqwfg4EMHQvZFOxv35S7S80GBGBlLtS+ob7Y0kSIHFSHdUw3pBY7Ye81VaAvp2Vt3Ol/jhnqvm
 Zxg7PIpfkiTQijnIGk/5k9HrNaYBGf48TbprhDjdj7lZfAHlxESpjp1CPAZnzIqWcKyO9cdbjue
 2jPlZs/fbKX7Ii3N72mgrG0Ac5ucP/82OvHsDv0VDAIIhcUJ9GNsZFnBIgL1SgfBpzdst6jghJx
 02OPXolvEO18+dE+GsJHDkQbwGT2LuJkoBEvMqlzOeDI9mIUP7jFCTBfGo+XH5gy7kaR+0f/O3Q
 XhNL/GPGEFCBxYIJklg==
X-Authority-Analysis: v=2.4 cv=aJT9aL9m c=1 sm=1 tr=0 ts=69cbd945 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=g4SQpinvGPL0G-aSnrwA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310139
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34214-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 894CD36AF17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ath12k firmware supports thermal-throttling but requires the host to explicitly
program throttle levels and mitigation actions via WMI. Without this configuration,
firmware-driven thermal mitigation remains inactive or relies on platform-specific
defaults.

Add host-side support to build and send thermal-throttle configuration using
WMI_THERM_THROT_SET_CONF_CMDID during MAC radio start, ensuring thermal parameters
are programmed before data traffic begins.

Maintain per-radio storage for thermal throttle levels and provide conservative
default level tables for Internal Power Amplifier Device (IPA) and External Power
Amplifier Device or External Front End Module (XFEM) targets. The appropriate
default table is selected based on firmware-advertised service bits, allowing the
host to align with target thermal mitigation capabilities. If the WMI TLV service
WMI_TLV_SERVICE_IS_TARGET_IPA bit is set, then host selects the thermal throttle
values from IPA index from the table and selects values from XFEM index from the
table if this WMI TLV service bit is not set.

Build and send the thermal throttle configuration request with either 4 or
5 levels depending on firmware capability, and populate optional fields
(pout reduction and tx chain mask) only when the corresponding service bits
are advertised.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c     |  8 +++
 drivers/net/wireless/ath/ath12k/thermal.c | 64 +++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/thermal.h | 21 +++++++
 drivers/net/wireless/ath/ath12k/wmi.c     | 69 +++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     | 42 ++++++++++++++
 5 files changed, 204 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 553ec28b6aaa..21430a70aa7c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9673,6 +9673,12 @@ static int ath12k_mac_start(struct ath12k *ar)
 		}
 	}
 
+	ret = ath12k_thermal_throttling_config_default(ar);
+	if (ret) {
+		ath12k_err(ab, "failed to set thermal throttle: %d\n", ret);
+		goto err;
+	}
+
 	rcu_assign_pointer(ab->pdevs_active[ar->pdev_idx],
 			   &ab->pdevs[ar->pdev_idx]);
 
@@ -14461,6 +14467,8 @@ static int ath12k_mac_setup_register(struct ath12k *ar,
 	ar->rssi_info.temp_offset = 0;
 	ar->rssi_info.noise_floor = ar->rssi_info.min_nf_dbm + ar->rssi_info.temp_offset;
 
+	ath12k_thermal_init_configs(ar);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath12k/thermal.c b/drivers/net/wireless/ath/ath12k/thermal.c
index a764d2112a3c..4f76622e8117 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.c
+++ b/drivers/net/wireless/ath/ath12k/thermal.c
@@ -12,6 +12,70 @@
 #include "core.h"
 #include "debug.h"
 
+static const struct ath12k_wmi_tt_level_config_param
+tt_level_configs[ATH12K_TT_CFG_IDX_MAX][ENHANCED_THERMAL_LEVELS] = {
+	[ATH12K_TT_CFG_IDX_IPA] = {
+		[0] = {	.tmplwm = -100, .tmphwm = 115, .dcoffpercent = 0,
+			.pout_reduction_db = 0 },
+		[1] = { .tmplwm = 110, .tmphwm = 120, .dcoffpercent = 0,
+			.pout_reduction_db = 12	},
+		[2] = { .tmplwm = 115, .tmphwm = 125, .dcoffpercent = 50,
+			.pout_reduction_db = 12	},
+		[3] = { .tmplwm = 120, .tmphwm = 130, .dcoffpercent = 90,
+			.pout_reduction_db = 12	},
+		[4] = { .tmplwm = 125, .tmphwm = 130, .dcoffpercent = 100,
+			.pout_reduction_db = 12	},
+	},
+	[ATH12K_TT_CFG_IDX_XFEM] = {
+		[0] = {	.tmplwm = -100,	.tmphwm = 105, .dcoffpercent = 0,
+			.pout_reduction_db = 0 },
+		[1] = { .tmplwm = 100, .tmphwm = 110, .dcoffpercent = 0,
+			.pout_reduction_db = 0 },
+		[2] = { .tmplwm = 105, .tmphwm = 115, .dcoffpercent = 50,
+			.pout_reduction_db = 0 },
+		[3] = {	.tmplwm = 110, .tmphwm = 120, .dcoffpercent = 90,
+			.pout_reduction_db = 0 },
+		[4] = { .tmplwm = 115, .tmphwm = 120, .dcoffpercent = 100,
+			.pout_reduction_db = 0 },
+	},
+};
+
+static enum ath12k_thermal_cfg_idx ath12k_thermal_cfg_index(struct ath12k *ar)
+{
+	if (test_bit(WMI_TLV_SERVICE_IS_TARGET_IPA, ar->ab->wmi_ab.svc_map))
+		return ATH12K_TT_CFG_IDX_IPA;
+
+	return ATH12K_TT_CFG_IDX_XFEM;
+}
+
+int ath12k_thermal_throttling_config_default(struct ath12k *ar)
+{
+	struct ath12k_wmi_thermal_mitigation_arg param = {};
+	int ret;
+
+	if (test_bit(WMI_TLV_SERVICE_THERM_THROT_5_LEVELS, ar->ab->wmi_ab.svc_map))
+		param.num_levels = ENHANCED_THERMAL_LEVELS;
+	else
+		param.num_levels = THERMAL_LEVELS;
+
+	param.levelconf = ar->thermal.tt_level_configs;
+
+	ret = ath12k_wmi_send_thermal_mitigation_cmd(ar, &param);
+	if (ret)
+		ath12k_warn(ar->ab,
+			    "failed to send thermal mitigation cmd for default config: %d\n",
+			    ret);
+	return ret;
+}
+
+void ath12k_thermal_init_configs(struct ath12k *ar)
+{
+	enum ath12k_thermal_cfg_idx cfg_idx;
+
+	cfg_idx = ath12k_thermal_cfg_index(ar);
+	ar->thermal.tt_level_configs = &tt_level_configs[cfg_idx][0];
+}
+
 static ssize_t ath12k_thermal_temp_show(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
diff --git a/drivers/net/wireless/ath/ath12k/thermal.h b/drivers/net/wireless/ath/ath12k/thermal.h
index 9d84056188e1..33231bb3683c 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.h
+++ b/drivers/net/wireless/ath/ath12k/thermal.h
@@ -9,18 +9,31 @@
 
 #define ATH12K_THERMAL_SYNC_TIMEOUT_HZ (5 * HZ)
 
+#define ATH12K_THERMAL_DEFAULT_DUTY_CYCLE 100
+
+enum ath12k_thermal_cfg_idx {
+	/* Internal Power Amplifier Device */
+	ATH12K_TT_CFG_IDX_IPA,
+	/* External Power Amplifier Device or External Front End Module */
+	ATH12K_TT_CFG_IDX_XFEM,
+	ATH12K_TT_CFG_IDX_MAX,
+};
+
 struct ath12k_thermal {
 	struct completion wmi_sync;
 
 	/* temperature value in Celsius degree protected by data_lock. */
 	int temperature;
 	struct device *hwmon_dev;
+	const struct ath12k_wmi_tt_level_config_param *tt_level_configs;
 };
 
 #if IS_REACHABLE(CONFIG_THERMAL)
 int ath12k_thermal_register(struct ath12k_base *ab);
 void ath12k_thermal_unregister(struct ath12k_base *ab);
 void ath12k_thermal_event_temperature(struct ath12k *ar, int temperature);
+int ath12k_thermal_throttling_config_default(struct ath12k *ar);
+void ath12k_thermal_init_configs(struct ath12k *ar);
 #else
 static inline int ath12k_thermal_register(struct ath12k_base *ab)
 {
@@ -36,5 +49,13 @@ static inline void ath12k_thermal_event_temperature(struct ath12k *ar,
 {
 }
 
+static inline int ath12k_thermal_throttling_config_default(struct ath12k *ar)
+{
+	return 0;
+}
+
+static inline void ath12k_thermal_init_configs(struct ath12k *ar)
+{
+}
 #endif
 #endif /* _ATH12K_THERMAL_ */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 34184d0d03ff..b239b436b745 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3384,6 +3384,75 @@ int ath12k_wmi_send_set_current_country_cmd(struct ath12k *ar,
 	return ret;
 }
 
+int
+ath12k_wmi_send_thermal_mitigation_cmd(struct ath12k *ar,
+				       struct ath12k_wmi_thermal_mitigation_arg *arg)
+{
+	struct ath12k_wmi_therm_throt_level_config_param *lvl_conf;
+	struct ath12k_wmi_therm_throt_config_request_cmd *cmd;
+	struct ath12k_wmi_pdev *wmi = ar->wmi;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	int i, ret, len;
+
+	len = sizeof(*cmd) + TLV_HDR_SIZE + (arg->num_levels * sizeof(*lvl_conf));
+
+	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct ath12k_wmi_therm_throt_config_request_cmd *)skb->data;
+	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_THERM_THROT_CONFIG_REQUEST,
+						 sizeof(*cmd));
+	cmd->pdev_id = cpu_to_le32(ar->pdev->pdev_id);
+	cmd->enable = cpu_to_le32(1);
+	cmd->dc = cpu_to_le32(100);
+	cmd->dc_per_event = cpu_to_le32(0xffffffff);
+	cmd->therm_throt_levels = cpu_to_le32(arg->num_levels);
+
+	tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
+	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_STRUCT,
+					 arg->num_levels * sizeof(*lvl_conf));
+
+	lvl_conf = (struct ath12k_wmi_therm_throt_level_config_param *)tlv->value;
+
+	for (i = 0; i < arg->num_levels; i++) {
+		lvl_conf->tlv_header =
+			ath12k_wmi_tlv_cmd_hdr(WMI_TAG_THERM_THROT_LEVEL_CONFIG_INFO,
+					       sizeof(*lvl_conf));
+
+		lvl_conf->temp_lwm = a_cpu_to_sle32(arg->levelconf[i].tmplwm);
+		lvl_conf->temp_hwm = a_cpu_to_sle32(arg->levelconf[i].tmphwm);
+		lvl_conf->dc_off_percent = cpu_to_le32(arg->levelconf[i].dcoffpercent);
+
+		if (test_bit(WMI_TLV_SERVICE_THERM_THROT_POUT_REDUCTION,
+			     ar->ab->wmi_ab.svc_map))
+			lvl_conf->pout_reduction_25db =
+				cpu_to_le32(arg->levelconf[i].pout_reduction_db);
+
+		if (test_bit(WMI_TLV_SERVICE_THERM_THROT_TX_CHAIN_MASK,
+			     ar->ab->wmi_ab.svc_map))
+			lvl_conf->tx_chain_mask = cpu_to_le32(ar->cfg_tx_chainmask);
+
+		lvl_conf->duty_cycle = cpu_to_le32(ATH12K_THERMAL_DEFAULT_DUTY_CYCLE);
+		lvl_conf++;
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_WMI,
+		   "WMI vdev set thermal throt pdev_id %u enable dc 100 dc_per_event 0xffffffff levels %d\n",
+		   ar->pdev->pdev_id, arg->num_levels);
+
+	ret = ath12k_wmi_cmd_send(wmi, skb, WMI_THERM_THROT_SET_CONF_CMDID);
+	if (ret) {
+		ath12k_warn(ar->ab,
+			    "failed to send WMI_THERM_THROT_SET_CONF cmd: %d\n",
+			    ret);
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int ath12k_wmi_send_11d_scan_start_cmd(struct ath12k *ar,
 				       struct wmi_11d_scan_start_arg *arg)
 {
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 8539435c292d..59b2b42161e1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2274,6 +2274,10 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_WMSK_COMPACTION_RX_TLVS = 361,
 
 	WMI_TLV_SERVICE_PEER_METADATA_V1A_V1B_SUPPORT = 365,
+	WMI_TLV_SERVICE_THERM_THROT_POUT_REDUCTION = 410,
+	WMI_TLV_SERVICE_IS_TARGET_IPA = 425,
+	WMI_TLV_SERVICE_THERM_THROT_TX_CHAIN_MASK = 426,
+	WMI_TLV_SERVICE_THERM_THROT_5_LEVELS = 429,
 	WMI_TLV_SERVICE_ETH_OFFLOAD = 461,
 
 	WMI_MAX_EXT2_SERVICE,
@@ -4128,6 +4132,42 @@ struct wmi_therm_throt_stats_event {
 	__le32 therm_throt_levels;
 } __packed;
 
+#define THERMAL_LEVELS  4
+#define ENHANCED_THERMAL_LEVELS 5
+
+struct ath12k_wmi_tt_level_config_param {
+	s32 tmplwm;
+	s32 tmphwm;
+	u32 dcoffpercent;
+	u32 pout_reduction_db;
+};
+
+struct ath12k_wmi_therm_throt_config_request_cmd {
+	__le32 tlv_header;
+	__le32 pdev_id;
+	__le32 enable;
+	__le32 dc;
+	/* After how many duty cycles the firmware sends stats to host */
+	__le32 dc_per_event;
+	__le32 therm_throt_levels;
+} __packed;
+
+struct ath12k_wmi_therm_throt_level_config_param {
+	__le32 tlv_header;
+	a_sle32 temp_lwm;
+	a_sle32 temp_hwm;
+	__le32 dc_off_percent;
+	__le32 prio;
+	__le32 pout_reduction_25db;
+	__le32 tx_chain_mask;
+	__le32 duty_cycle;
+} __packed;
+
+struct ath12k_wmi_thermal_mitigation_arg {
+	int num_levels;
+	const struct ath12k_wmi_tt_level_config_param *levelconf;
+};
+
 struct ath12k_wmi_init_country_arg {
 	union {
 		u16 country_code;
@@ -6522,6 +6562,8 @@ __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len);
 int ath12k_wmi_send_tpc_stats_request(struct ath12k *ar,
 				      enum wmi_halphy_ctrl_path_stats_id tpc_stats_type);
 void ath12k_wmi_free_tpc_stats_mem(struct ath12k *ar);
+int ath12k_wmi_send_thermal_mitigation_cmd(struct ath12k *ar,
+					   struct ath12k_wmi_thermal_mitigation_arg *arg);
 
 static inline u32
 ath12k_wmi_caps_ext_get_pdev_id(const struct ath12k_wmi_caps_ext_params *param)
-- 
2.34.1


