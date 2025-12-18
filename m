Return-Path: <linux-wireless+bounces-29865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A9FCCA030
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A61301EC61
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E6026FA77;
	Thu, 18 Dec 2025 01:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jetQ57GZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hQqQJEnM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A726E6F0
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022915; cv=none; b=im4VS13EPAGs0oYR3l8Gm9m85OohJ1nGLMhG3kzf7cOncfevUoMt58ULOzLtqIfPN3QEuyXECOCDSj5sNy/07EnMlWaqidpWKxuYSr+lKTelgb4didQhMHgGmT5lImXze6A3D/6g4xNCxMnDgSsuXhm/doxJyAhMQvC3uQPkdcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022915; c=relaxed/simple;
	bh=m5QvvqtvFW9/SehJwpTbnJyp0OuOq5MO0HnCfbCoZzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mKnQsySy6DZD6Po7htllCSlr5RwXvRFAvCsj6scEmN2x5rJ1jZjMg9b7rdUO5/gyU/oM1LSphnEvdwt+TUCweyGARfiH8Vay/lhTH+NwLc9uyvywnTwIGS4jh+88ACYZQ+cj0ZRUBrc+gi++E0V52SPeSdVOf4zeNjJj+6Y+4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jetQ57GZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hQqQJEnM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yj8F3717112
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MSFNXmm0LtiuYvbIDgNIlZ919rAec+/ZE2zBI470eJY=; b=jetQ57GZPGMFMJDr
	oWcSBs8DMl5ssBkXT438p/53k/fVjL2BZfaqVT1uEOHCkh6pD4hUxDgxhhWDdkeK
	Hz475B397ijybHs06HRq4bcdDKOU7PjnO9hMARQErNFNJQmkL2lm176AQnT2Q83v
	D4H1CG8eDItKlnEgPgZzxUMDXuPTkxdEAemjElcKvm+9QpYJdnljw5K6OMgUBfac
	p5UOnE8qg1Io/5EH60SeovIgkk0Bvhkcvf+ncegW6IOiLYhdvUEQpeIKqqSi78BL
	6EZ3NbHfcv1A4Qi5cRNzhxcxwA+cGkX4Bke0+lBnIBgrUWMYAoWCLOrPlfDHkKiS
	fITIxw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n79as8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:13 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f25a008dbso1403005ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022913; x=1766627713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MSFNXmm0LtiuYvbIDgNIlZ919rAec+/ZE2zBI470eJY=;
        b=hQqQJEnMm7iEijcOR1IS1qOkLDQKnBKP9XEO3pUg1iQ89S/pcoiwUXR9ZPPlcDROgf
         eICQZ0/XFUCWgb/0+1ijvMrEVdh8cR4+Fy9yYtDRx2j2mA/36vf2dFD5FdS8KVcz8Phg
         8nk8Rv/F8GigZKmwN41W+JGMkSEF23ymEpGbdynDXIx1VU/QI0eYG8te7TAbbvH/PtcC
         5qXAwZX4mosf9svBuqyYDGaa8DaxRcv3juGUvHLOGc+eFLiOO+tP8Av/UTsBkSJtzY0q
         eK+tyzegpPTpLNXwxAjy9IzbDmv3sd+ljmDW5qaTFW1IhZ2ZZXp9JcLKV2WFkLqAB2Pr
         BYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022913; x=1766627713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MSFNXmm0LtiuYvbIDgNIlZ919rAec+/ZE2zBI470eJY=;
        b=fsUqBxsL4C7BoRrxHCNdjwo3rBBxkjZL72c/hSgoGECsgNUR0OA2bwEb3jPY2uOuX9
         sUOl8u+2++0ohKlxVgYPRQuPMHYEG/VVGR0H68/SUN3NLvFp/uklv3GYh8VXdL7Ai+QX
         0xtrRkc4JLHrFNBg9qv7hvQnPh6aoNK6cF3mCFlTGyHQIIgp2TfmmHa0AU6Iu9LeCNki
         CTLzzqcF5jRl9OLgm96nbmH9LQj1AZavftBC4gLvFwuSq2gGl/AZXkxi7xMJypwOyNRN
         dlTDeN/zn/QNZ1W5jUQSUMu8Q7xgJjzKHSEMCALDAR2Asqyq1p09tKCSiY4q3+jAagvM
         TCMQ==
X-Gm-Message-State: AOJu0YwqbfnyB8+L2tVh5x9yhifhlCr2QQ94+n1tLLfi576v2DgsxP2B
	Y4/M3htE4IAN7evHOVpH2LElgAiu0/FCDrFzYQb82naYaBT2XUlRnMO+wQbRwUyGSjH23caKdGA
	sUE/evBj4cIX1hCZUDqGGBLq6+KSY5hJrsLE2bBxuqegwANxyj9kdpTgU8br2AqP/wc02Cw==
X-Gm-Gg: AY/fxX6w+lp6pb0fGqInSnuI6tyI6BcWjaFe0Po8uwRyMei4WFv8IucoFKbXN/QnQ7Q
	WMy0BGJ8PxsrW4w8Qq06NXktIB2p9sCgCeE4v8v0DmVkelSnFzAaPjwAlUFNMldWh8EcwCIfJaU
	NcC3TQGXTR40Kz2gEaXB0XT7EzaIgROAf/FvtCc0LyAuliUqlM8P5lVez8bjboTQkrsXhC8YDIv
	Xwb9v/UllhjsQH96AoC4xB3FZY5IbcKF1TMLu5e/iA3a956yEAwkx1yJCnZY5GYZXi2ETe5rmTT
	IRhQOV9i6viVs5hE6OHGinEVOrWqzORpATZsDD8UfQ/danF5HXbY+WxP+3N4EyIgzzFJ+XWLjQY
	tYmoghNdPX+hAythl5TR6ifhxZBaNGlBcYIUOQ0hVjy2yvSfoSYeP2Bok/cWe94A=
X-Received: by 2002:a17:903:388d:b0:29d:9f5a:e0d1 with SMTP id d9443c01a7336-29f23e70d05mr211542735ad.27.1766022912899;
        Wed, 17 Dec 2025 17:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2fG0SxSh7MPfQcvIoBJd6bn8zGv3anKRrLDdDQSdfsSGlMi/5nF5b3CvxiXl3RyooODfiHw==
X-Received: by 2002:a17:903:388d:b0:29d:9f5a:e0d1 with SMTP id d9443c01a7336-29f23e70d05mr211542545ad.27.1766022912446;
        Wed, 17 Dec 2025 17:55:12 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:12 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:18 +0800
Subject: [PATCH ath-next 04/19] wifi: ath12k: fix preferred hardware mode
 calculation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-4-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: G1SVnZ2OWD5gi3Iy_FSd-Whske02o2wE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX1Oql2NO4/Y89
 QKBuishuLAgOovBNjH+0yCE9ZN9nkF5xEMLBq8Sl9DgDAYdCzyUEtEIjXFUFEnwY8oEsgxYQL2V
 ZgvPzfevqf07PPIvl6AXLDlLQJRqfID8pxIqPt4BjAPLWShDxyhNA3cw5/TkTlbopo7LA5qpSnX
 mmZZdE2Ikc5HsEskcq55GPSMcc+YSzDdg4ijumcHYf1M4jn83rUO+EGJU/JWdsmm0ARCBYSCXNT
 Zrj5cnYxxKdqq4h1XZPK+2nKknTegBdBIuaPbhuDT3pJXaoSnfIspJMG+5SdGra7OguHMe1W2M5
 zl1MWiqCXt/dYZgWRO8TJQWfF6aDJj5LcRZec73zW3HW53VBUui0bEYo6yYuYxyJ6zcHPE+n6n5
 4ufBX2zVKHWr9RkdNYJ67K2cfdB1AQ==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=69435f01 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zY3FkhqSlrVAWUjZaU8A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: G1SVnZ2OWD5gi3Iy_FSd-Whske02o2wE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

For single pdev device like WCN7850/QCC2072, preferred_hw_mode is
initialized to WMI_HOST_HW_MODE_SINGLE. Later when firmware sends
supported modes to host, each mode is compared with the initial one
and if the priority of the new mode is higher, update the parameter
and store mode capability.

For WCN7850, this does not result in issue, as one of the supported
mode indeed has a higher priority. However the only available mode of
QCC2072 at this stage is WMI_HOST_HW_MODE_SINGLE, which fails the
comparison, hence mode capability is not stored. Subsequently driver
initialization fails.

Fix it by accepting a mode with the same priority.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 150b04d0a21c..ce2bbf6acb4a 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4449,7 +4449,7 @@ static int ath12k_wmi_hw_mode_caps(struct ath12k_base *soc,
 
 		pref = soc->wmi_ab.preferred_hw_mode;
 
-		if (ath12k_hw_mode_pri_map[mode] < ath12k_hw_mode_pri_map[pref]) {
+		if (ath12k_hw_mode_pri_map[mode] <= ath12k_hw_mode_pri_map[pref]) {
 			svc_rdy_ext->pref_hw_mode_caps = *hw_mode_caps;
 			soc->wmi_ab.preferred_hw_mode = mode;
 		}

-- 
2.25.1


