Return-Path: <linux-wireless+bounces-38616-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id O6GgMZe2SGqvswAAu9opvQ
	(envelope-from <linux-wireless+bounces-38616-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 09:30:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE5706F01
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Jul 2026 09:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=MuSf2XYR;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jRq37KXp;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38616-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38616-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA3FB3017245
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2026 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E7C3939BD;
	Sat,  4 Jul 2026 07:30:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0920D39185C
	for <linux-wireless@vger.kernel.org>; Sat,  4 Jul 2026 07:30:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783150224; cv=none; b=TOuf2MGwQkcgT+YrHPMQgbvP2jzuAkTXLjeBZoacVSKnF8C1yE4jmflf97991VgILnCqM5GcsMMjvPTILM4KK092GET/eAndaC/i/9UVBUwWDYPYSCb01+whJGHXC3dtgyWUgH27oL2cpu43XJVY4HhLyIlh5XLYYDpyaKwCEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783150224; c=relaxed/simple;
	bh=Om3w5JLjdUFqa26xxoyNTZtYXJqolsDu1VkKD68+MrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KWpJazP/rSX1OL7RPbP8MhbffMzPARwhBMjSecF98iV+eUguEzfCmXthPUfQ4Drt3nQo64ex5sLF/N6UBAT0IuB8ZcOPbB9pGZ1jTjIpF4XpMC0cVJL96bD+orCz7qDoBI05XoT1KXNNheuJYYFC0Jdf/ehQZzX9AjjqyvMfktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MuSf2XYR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jRq37KXp; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6646hiOn2147079
	for <linux-wireless@vger.kernel.org>; Sat, 4 Jul 2026 07:30:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Sd4tDbffrjX8xEUiZAJ2XIY7OGUcvOCHExa
	GfoHg8G0=; b=MuSf2XYRb087TlmU/WqCcJ2eqakQtYPSeuTw85/9/CrLeq7JjFg
	y3+M4tFfAgiN38mdZ9HgNAif5IAnQgxQVEcDypC4zOGWML72tIO3wzKrXvjC+xsF
	H2nZNnWCLGEYHhg5qhOCdrz6kZEoEWiUkYTp6LjjMGQ/4yyesFmkrsJDdXjYTE0n
	Z7BqO5V8DhFGqeuppOnhIF6GrMBCiAop6fZzKcTjN7dFsCPN6LMc8Na+6WDzj9TJ
	SyZIV0AWJqUHEix0YYgdTK18EDrj2kTpig723doZF/0a61CqTH2HFxDn+SOEx91W
	OVjoUGz6y3ZXJaZDvMtsCrKrT2827dsp6Ug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf808at-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 07:30:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c8018f11fbso12693275ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 04 Jul 2026 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783150208; x=1783755008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sd4tDbffrjX8xEUiZAJ2XIY7OGUcvOCHExaGfoHg8G0=;
        b=jRq37KXpM5TaVH24Kt44L5uXkRNh4Eao3ab8cQHLh1Qmd8kqD4c7ddpsB6jL+dQ0i9
         tVu8dglznxjcR2EEz5nHFP46s916BL5IxS7GQukI8Ukuf7H4vpDZbBrWn5yPO7zZU6mS
         OZ2yyka/kz+vY0RibSfu/OU22moWrGtdhUYaWGjyXUJH1ah7aW8epSqWJ2acY2MO+ZC/
         lUZkVBOrNzZi56okyUwASR6HwVeoR7vqzpCfmvjobxNPI0Wc5iJBAZrcN3qgJOjTj7sL
         efbRZv+XkMGRh+DRIKPswpCQWZ9RcPomLq1tM5FgtMKsqReGDXiNJHPQpFWwub81pebt
         niFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783150208; x=1783755008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sd4tDbffrjX8xEUiZAJ2XIY7OGUcvOCHExaGfoHg8G0=;
        b=dUZn3O18NSx+VLx06xW6fU1QkmZtmZcygTlRK5oGsJdea3iYIyNp42MhuWO6daY56y
         MX+FT5gNlFh5ebM0p6vtQH2F2DLlGTnBZh6I2XbonITQTpejP9YOlInaVwE9kJ35AgIB
         czmQeSTK/K2GZRrq4dvxdHVtH4bQOTkod3otpWtagWZbBy4IHNyYNu7MMw6uYj23hy7s
         WAENHEVhjvreZ5qnNdUNfv9r1TgPaXJ8kEU2klKrW7VbCovJ6V26gfM8i2kLvDTqfadI
         8Yato6dVzk9b2rKI0kjdskqFQkq2W6DBsQsCUEUZxYsst+9HGLw0DLMofU1txInwciGa
         xHAA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9l6ljoSbZfehZTc3GatYsRH+44fIu6+xAZFPJ4yUpHFZMoSXlWbCkNeE7udC2KdbCslBAM01r99YtiatH8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/IxMsxjjkluDCXYwaD71+3/bipMh2UzOldiz4JvWDgCnxdCw
	OmEko9315SLveqpccSk+unyJw+Lk468qdYNvqerY7PwwQGz6hTI6Eu5527uTFIqQcpFflUnVR4L
	YSo5KW7W1y+zLqsUBGE654foSzqc/horgUcjyLzaU13kRaWD6RpAHs9wYgpEZZOEQD/+M5w==
X-Gm-Gg: AfdE7cll6OcnmGp3KbfPLM964TYXdGIxFeIcLhXhh1uoy+uXzfrJTu+a0axgijCZZNZ
	c/K6YZoTgBmssB6a5dcoBXw6uZ3c/UkivS/+LILcKAvn0cyz25JPP5dxrY01SrqxLCTWsdB8YKR
	boblk8ENE9hGZHMBYjkdlZA+azFD1p/uyqhuRfSzVW818tcTE8zVxzz/V/one7joagUlh6XuxsJ
	lHzNav7BEnWBd31dgJhJIJuo2rwJv1Dgyn7KsIgt7wKKQOKSafLI6Ou9t8GL9aHh5aITAldYZZI
	2YdRndEKe3D9NOFAbBNVDdyoy/n/ic02AQOVqyeq/rk/H77ZmZDXqFh3hR5Dw+dV2ATGnsIq2/G
	/hmmxNKZzk88bCkPllFNYgk+AlAAXN67hVsJCT8sXyJTOk9iWWgcvmW8ZZLs333L8c48aYA==
X-Received: by 2002:a17:903:2f8a:b0:2ca:cde5:29c4 with SMTP id d9443c01a7336-2cbb9f37e5amr21183725ad.47.1783150208313;
        Sat, 04 Jul 2026 00:30:08 -0700 (PDT)
X-Received: by 2002:a17:903:2f8a:b0:2ca:cde5:29c4 with SMTP id d9443c01a7336-2cbb9f37e5amr21183285ad.47.1783150207772;
        Sat, 04 Jul 2026 00:30:07 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25f87sm20046425ad.3.2026.07.04.00.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 00:30:06 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: fix ML-STA authentication timeout on QCC2072
Date: Sat,  4 Jul 2026 15:30:00 +0800
Message-Id: <20260704073000.3300099-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HBAyLUkh3PjRqJTvY9af-TbSC6ouQe-Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA3MSBTYWx0ZWRfX9HrVRKJuFfwq
 2KEwNtiTMB+S6FkxDAzQafJIzEUNM5q1uB4uyDphRd8aEj1BosxNniQhsaVI9OlQI2vQSYss5g3
 ZAN2sQTcsf73Te2UalqV0Pemc+hFSfE=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a48b681 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=K4Y5m-lB56W0GsPaBK8A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: HBAyLUkh3PjRqJTvY9af-TbSC6ouQe-Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA3MSBTYWx0ZWRfXz+OSC/66aHsO
 ZjmUVm+9QcmXMAY9JotZI4o84+c502KBKUUwi1EfEXyGP+3u0GU2ITpxfBfnpWhHyymnMfiwtCT
 u/cBu2fdn/X/q59Eu4jvcd6k3vtyBuJ6cXOPSXHFewwTKjtpm/Q0/gsIRsVmUw2wLQ17HI7jUva
 K4gdytZpHuNAVz1UfhERJCevjpvMR3MSVVHe3ATd8aCC22rba+PhBV76jalVC7OwB/YYpQQ/LZC
 lVfS8jS/HS8/YlBym8N/LmpvlY241gjILwkQJGmoWnrGuy6s9L/d5sIZtgVyfB+rO0qriYeee02
 8Rjj0Me/e+n6Xs+Bb7Yv/KN5pxOswmFVT4V+7DN8bm8OrUmTvVXUAAWqhlWewKZ9bAT0zcFY5Uo
 eNgWxQ3xX2dw10LHwTBMGZhfL4YnnMQzNjlwmvnU9odTXBre2e0nJh7knXPvV+syYq/Q6LW7YAE
 sGCNXyjwkdIffEkT6Mw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38616-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miaoqing.pan@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14AE5706F01

QCC2072 firmware interprets the MLO_LINK_ADD and MLO_START_AS_ACTIVE
flags to control the link state during MLO vdev start. MLO_LINK_ADD
indicates that a link is being added, while MLO_START_AS_ACTIVE specifies
that the link should become active during the start.

When an association link is added without setting MLO_START_AS_ACTIVE,
the firmware may transition the link into a suspended state. In this
case, authentication frames transmitted by the host can be dropped,
leading to repeated authentication retries and eventual timeout,
for example:
  wlp1s0: send auth to <AP> (try 1/3)
  wlp1s0: send auth to <AP> (try 2/3)
  wlp1s0: send auth to <AP> (try 3/3)
  wlp1s0: authentication with <AP> timed out

Avoid triggering this behavior by setting the MLO_START_AS_ACTIVE flag
when MLO_ASSOC_LINK is set, which tells the firmware that the current
vdev must not enter suspend mode

Note that this change relies on firmware behavior observed on the QCC2072
platform. The firmware on WCN7850 and QCN9274 does not use the
MLO_START_AS_ACTIVE flag, so this change is effectively a no-op on those
platforms

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: d8e1f4a19310 ("wifi: ath12k: enable QCC2072 support")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 ++
 drivers/net/wireless/ath/ath12k/wmi.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ad739bffcf88..800fa753021b 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1229,6 +1229,8 @@ int ath12k_wmi_vdev_start(struct ath12k *ar, struct wmi_vdev_start_req_arg *arg,
 						    ATH12K_WMI_FLAG_MLO_MCAST_VDEV) |
 				   le32_encode_bits(arg->ml.link_add,
 						    ATH12K_WMI_FLAG_MLO_LINK_ADD) |
+				   le32_encode_bits(arg->ml.assoc_link,
+						    ATH12K_WMI_FLAG_MLO_START_AS_ACTIVE) |
 				   cpu_to_le32(ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID);
 
 		ml_params->ieee_link_id = cpu_to_le32(arg->ml.ieee_link_id);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 51f3426e1fcd..20e3939e8820 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2954,6 +2954,7 @@ struct wmi_vdev_create_mlo_params {
 #define ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT		BIT(6)
 #define ATH12K_WMI_FLAG_MLO_FORCED_INACTIVE		BIT(7)
 #define ATH12K_WMI_FLAG_MLO_LINK_ADD			BIT(8)
+#define ATH12K_WMI_FLAG_MLO_START_AS_ACTIVE		BIT(17)
 #define ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID		BIT(18)
 #define ATH12K_WMI_FLAG_MLO_IEEE_LINK_IDX_VALID_PARTNER	BIT(19)
 

base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
-- 
2.34.1


