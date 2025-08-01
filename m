Return-Path: <linux-wireless+bounces-26078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EEDB1806B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 12:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EADB1C232D0
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE01C3306;
	Fri,  1 Aug 2025 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XuYoLeyL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DF2B9A5
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754045381; cv=none; b=Iu1OIbcMHHgNqoR1rMoKOpNFmx7vkqxqHOWX7It6/OouhqIHe4xtFmD0CBUUZcfWf0dI1oAzj4watdqkBbk6j+iIA5EkAwmhbcAPXGFtt6V6FTmKPK9u6b9wLH2cmZfMfTskcwIaFBobxGBl04RfrOlQ4AHAbtUEORFctEoch0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754045381; c=relaxed/simple;
	bh=uc2HD2SiWR92ZbmlZoDDBUPF7rfSmSYOCb11tM1VCEs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XUuSI1MMn6bK4DS4CrYeKdveVw5SJi+3YBabZGCb9vgUrM9PTgpX6U9Up76JY66BCWQZCq7u3Q1+O+WUa1Q/Vj2UYxZ91Up3WY2XPgYkzOIwyZ6hCti1NyD70qN/4lRa8kKjHyda6DdoUBFI61FHyTwnVLy8xwpEqAUOPg1xn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XuYoLeyL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718xg4K018834
	for <linux-wireless@vger.kernel.org>; Fri, 1 Aug 2025 10:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=0zwqu1x1rcnd0XEa/yMRr8onX7Hhz45yypx
	YggbRCbI=; b=XuYoLeyLiAIcvG3bmLK/Qamgq4y8RcludCHj8NUXO5fY/1UCesC
	sfmHHe2xA2U1vuKsaVNgksSspiJ/tbrAUW/54q2kGtk2jVMj0J1lsEB2+9aSXXUm
	rgdFDdEk/7BaClloASXMNqVczYumqUS7p7lTX5jt/YRKpyeWGEiOIoctgLbiHxoH
	qXuziddh3pU/WzAS2ubR9WvHs/knWDkkpiCPVp7RoC8UUvLPGGw3qAf8dsJbx2qF
	O7VYKB/t0AWJsazOuj9DOfnwmiULAoB8KvHejGVlYldPYLU+D+8qIZJepSPGjhco
	s///vzdH/9Zg/qWpyZksFvtxAsBsh4kULiA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qdabf5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 10:49:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23fe984fe57so11432675ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 03:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754045376; x=1754650176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0zwqu1x1rcnd0XEa/yMRr8onX7Hhz45yypxYggbRCbI=;
        b=wH7VGPXTEYO5uqjhXQXz2KIUBXfjTwxMWno62ziSXDm7it8+GDmGJDN46u1WyIqPfk
         jdviztKRmVh7QMQFPnWyexnMyJ/sqc1eN1b/xlTr4nHIHXef5Hyye3xnYeWtQFd1qqz2
         2rmFq2jjEwnuIX52eWGqIKWIV5OSfT2F/QP2mqrbD39Ut9Zl198irCOLpyKpmkh9SZzW
         CO4eQJLRhvaHhGjF+cEt+GJ05mfyskq3Q9njBZjfnsVF9ql7xP9JTYXWsGX4RWJ/H8RJ
         iBr9nMhzrLiljw6ryol0VEke6KnkIaPwI9szF3fvmqd0Pf2y902YfW13OeIOURrLBcpj
         PRzg==
X-Gm-Message-State: AOJu0Yy9SJgli+y8GAOcF4Gs2V92+/n6Kt1GeaTWPVx6zbTun5jd5vHB
	u5Fy9J0bsoney6SZq8SpSzSC3JC2Jg8vcJgpqLWqL850D8rENFCg8CNrsZ8CB6wTpCuvcwBPL5H
	Bz4R00YyvymicO6nqQyfN9KeP0tq9ncaZ6Si6PkiEkRfMWg4iyEIgVGG5dVGHMYWXm2+BXQ==
X-Gm-Gg: ASbGnctFZ/jEs9fn2bp6esSrfPXSk7EzA2Pkk2nu9Y4lVTP4/1rGfR0nxrq88ZfCHiI
	YHWnzxdk8Ztl95ZefyGPetGAnAOxr1IOU09qhavrtGwWLmzX2jjQBran81Ls3lfLAHY3b0GT5lL
	6rxSyE58oDJrOHFjaQ8W6JS7jNn0dounZEFlsdq1RKofxq7Qaj5JAktIBI3QYcZO6XKAyQlfDyy
	WGa4PR/gCwOdrto68S9Nv/ptrSvq7WaJHMou+6G2cNXUcDrhm+m3WPPyU1Eovvh3T3R7J4G3QRW
	mz+i36kA6f9mevvsgMOJlb2ZwCmxynomk6MUe8amWfGTEjnLsO9u9yXDUcHTbVpItguerCOYpe7
	+I4jP4tGwAn7d9QjmqOiiQFEwhBP4yULEeXgjkZHiQY592QSh7sapQAMAcIIByfkFvSuR
X-Received: by 2002:a17:903:2290:b0:23f:f3e1:7363 with SMTP id d9443c01a7336-24096ad162amr164066685ad.23.1754045375836;
        Fri, 01 Aug 2025 03:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYRXawaJosGiOStHumhD5elD/FU0pTU8c5keF5JRHDkJ+yjdgKA2BiktC1eFfIzCD9+5Ukag==
X-Received: by 2002:a17:903:2290:b0:23f:f3e1:7363 with SMTP id d9443c01a7336-24096ad162amr164066265ad.23.1754045375302;
        Fri, 01 Aug 2025 03:49:35 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aab53dsm40066065ad.170.2025.08.01.03.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 03:49:34 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-current] wifi: ath12k: Set EMLSR support flag in MLO flags for EML-capable stations
Date: Fri,  1 Aug 2025 16:19:20 +0530
Message-Id: <20250801104920.3326352-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YSAkMkIKlWjlRRpy3yq9f_2uakKu4eJK
X-Authority-Analysis: v=2.4 cv=Pfv/hjhd c=1 sm=1 tr=0 ts=688c9bc1 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=c750zNxr8p8rmOZqGt8A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: YSAkMkIKlWjlRRpy3yq9f_2uakKu4eJK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA3OSBTYWx0ZWRfXzD1+u7XS2tsk
 70xs0nmyveuWCyTAxKEBjsa0Pe9a75kvSMQMuj/YWIZ5/h0Xxs95Fgl62qeI+ng0vsf8f3XHNOH
 cwRmY0rm/Jld5SKavhlFQzw1dAIjLxltwOLL5MW5kwkNv//PvgGh/Ot77kqUslonc75gmhOQwDZ
 8Xs7yj2m0xkDHQrK8K3xJ0flwSLikkdUAU7AJuT7JRkPW3EPKRct2FgqkcEpkmcHAbZ9LziFvEP
 +oN+eVqXu6VmUGJ2Fv2u7wk2ehNODXEjkgIi+FzWrKpXRjJCncmyTEpkBIAzM+2AS4s+3nRfTKb
 7AT86Cbs02Ff9tHcuwv3BTz8QfXY6J36tJgYNwgEWKGIJ0z3lMOeKezjkAOq9Zlmzczt9xKYA3J
 CRS8VX7TaJxfPEINsR5v/jNYhHsQ5pGeOT5PlzmO5//Tka175JemO7uqJoJtJYhuNET1URWg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_03,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010079

From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

Currently, when updating EMLSR capabilities of a multi-link (ML) station,
only the EMLSR parameters (e.g., padding delay, transition delay, and
timeout) are sent to firmware. However, firmware also requires the
EMLSR support flag to be set in the MLO flags of the peer assoc WMI
command to properly handle EML operating mode notification frames.

Set the ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT flag in the peer assoc WMI
command when the ML station is EMLSR-capable, so that the firmware can
respond to EHT EML action frames from associated stations.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: 4bcf9525bc49 ("wifi: ath12k: update EMLSR capabilities of ML Station")
Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index da85c28ec355..742ffeb48bce 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2423,6 +2423,7 @@ int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
 
 	eml_cap = arg->ml.eml_cap;
 	if (u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_SUPP)) {
+		ml_params->flags |= cpu_to_le32(ATH12K_WMI_FLAG_MLO_EMLSR_SUPPORT);
 		/* Padding delay */
 		eml_pad_delay = ieee80211_emlsr_pad_delay_in_us(eml_cap);
 		ml_params->emlsr_padding_delay_us = cpu_to_le32(eml_pad_delay);

base-commit: 0f79768f8d665b43b77967d38b5df6ccebe8cb57
-- 
2.34.1


