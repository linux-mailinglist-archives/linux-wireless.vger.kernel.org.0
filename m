Return-Path: <linux-wireless+bounces-29871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0FCCA04B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7931305D65B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8009A26FA77;
	Thu, 18 Dec 2025 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwwB1kjI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PJuIKhJ5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9DE26FA57
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022927; cv=none; b=OZKxE6RdIbq3sbivrOcTGIcLCNgfOueloVvk9ysh9hK+0NZ8UhLgSTOHMGdrTx049tTY6uxVztM37oY0bAC6AhgpCSQDTFE3SdIH85seOYiqTzRihYe7JD2Dt2i5S08WK5715RyGa6rGh/xYko/HZUyK89veurCPcszGozq096E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022927; c=relaxed/simple;
	bh=PrV0/67mR69ePp50OdRZJmTq4Hx+iY5PBjCgHSQ6RMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rT6IQnnvInej8mR0e1zdpJbB4+TI5Z4cVZrrnt9X3QWlQ901tx+jk8O3Xn8mtaxd4Ne7kHhdZcUdTUGKxSBCzHFrlboMS1bN5J8wTSPYLUTg2LdXt5hqw/+g4QrVgV6Q6cxxq5XHe8UmA7o4fbZ8WVLoGKwnrGNV2l76Qniyuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwwB1kjI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PJuIKhJ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1ZkW32016424
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JmwHcVmezRhrnG8yMV9bsbnLk3k9piD14PfETaftqNE=; b=JwwB1kjImNqM4xRW
	byCvvK5WmnG51xm86sHLF/2VgGaGZbSYZcPu1vcM8xwgeurEkJ59LTfdQ1fL6efj
	WtU3wn7jF6Fvq4a/SPViYWFGpXE+QDLcYoZgdKRbE7hShfov2snVm6gYVhzEax8z
	10iFKM45YviZPY8vZtDjYVzDXD/EgSZIIPiM88TnAyybR6dhwhdmKtOiCQ6ojM4H
	pnH/1u+VwY9Er0MREJ5NsP4BQiL+LMfwufU0WUVNyxTuvYWIIi/Rd8LJP7qbVbN+
	nklMThzN4NuXsseE6DRqdnze9qa1G+c7bE1TWTnd3AMmyix7UMKuVIzOO/Y4/eZd
	SwEJWA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b3t8e2p6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:25 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f27176aa7so2702765ad.2
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022924; x=1766627724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmwHcVmezRhrnG8yMV9bsbnLk3k9piD14PfETaftqNE=;
        b=PJuIKhJ5ut8FcBjg3qj1Ge8KI/jjITzRSCOk/yZaMwqqalJ611+kqyDr0ZNCDXwsca
         WDCUZE2zjbvAh3KLL1Xi6XYVoCtCevJqEc8IPbWzHqbkcb3XG/3qL8TODVaqH0VkbfgZ
         qmXOrhkMH3hGMZHIXR5ChEseoQqtqzuEJvVQddxO/Hzp9ufdsMKdz9xcztKWEVxArbds
         cFAIRValkZx/v7j+JYPggaQEi2L3Yp3CRId8lfovDK5wG3TCtzcAKFyT0oC0M9SE1VNb
         jGjXB1TFeTuZBedo4V3ECLH8xDULmKGLIJ1REQVcRvUYUjzWH7j0QGM/3gFFkeTKS0Dd
         q/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022924; x=1766627724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JmwHcVmezRhrnG8yMV9bsbnLk3k9piD14PfETaftqNE=;
        b=f34YdumCSdw7XNRsnBw+mB7Q3YSxInsVAPfS/TAwc1fd4UT4aFIdhur8dcHyeR1knI
         iDBT5qfseNL6IRlvgyuQ6Oi7w4ENueJXIJq1PkrO5bLagczd73sC8hfUnzds+h/GMgv8
         u4UanaYf6T9mPbXUZInV0XPzy7R70PhfA2aezZSPTbXNbhhItMz2aTMe/ohK7qw+/1c1
         xxaZfMfeR0+5ObGK2IoOUchkSkeAAnH4dszdzbxH7dtYM6DMZgTOZn7XSTuD5C1gN4t+
         4yLy0ryxbbO1e29iatRQv1pQz7svSLS/HDYMnwluBr1MEJYhZFSOoFbZiZmlXdsV3ZV2
         mkCw==
X-Gm-Message-State: AOJu0YyKey/szedwOREyCEvD61ZEUUdkimtkftRkUE2R2IfnXFE/ewpR
	vFSC+u+0ZdOOnhGUOPbjZ+VtEItCNgcN9bXt9Vc84vLsacV1gXM4/MJGfofpx2kFNUkp8evNI1m
	I2kYw8Xfe2uycNt+/wo5BHw8I81/zxLtt025u5GMOQzrqNpTNdrZbEMiWgHynkWVWi3tn+Q==
X-Gm-Gg: AY/fxX69bNVI+SVMtdU2l8pDf8yi9Y3DkSfFzmlz6au9Q+PbPSEBaO84Ll7v1A9vwZw
	yG8Jj6PKesvDbAUgL4SBrmxoVvkSyIz+6dr0TYELmYsUARMMtpMQmuA7ZQ25uAGtvaeSvmva8v8
	cEMBdLytFImReBRPGACpgi6PuR/aC73gjpQRW3rTzPofWoiSLJlpmFk5Xe9gxDoHLOX8c71cvEj
	cEdWOYDGLxe9BAZ0qp/uCjaRDR9sfU6Ru3R2wJWEH59JyyXE0fSW5sCSRoRbGwHMfJ90P6z0wMG
	0Dg86YTpZ0ergBDggiTcfa4LZ3joD7TmN20pe8vUxIqcejxZMZ9UFCyb2M4O9AvRMt62Gdm7WJM
	KZqUA6GI9TyodO2Mdpwiikefkf6eOQzKr8Cs5MXkfnJv7G7hPMbyz8hw2IS0pPok=
X-Received: by 2002:a17:902:d4cd:b0:2a0:b02b:210c with SMTP id d9443c01a7336-2a0b02b22ecmr136966325ad.1.1766022924395;
        Wed, 17 Dec 2025 17:55:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCHPh2SMBA4kvY2/T6PZDaUUoqMSefKTvhbtsXw6jwvEBIHpKJw+LaKR8K/czXCyST0j7v4w==
X-Received: by 2002:a17:902:d4cd:b0:2a0:b02b:210c with SMTP id d9443c01a7336-2a0b02b22ecmr136966125ad.1.1766022923937;
        Wed, 17 Dec 2025 17:55:23 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:23 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:24 +0800
Subject: [PATCH ath-next 10/19] wifi: ath12k: support LPASS_SHARED target
 memory type
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-10-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX9r51fRnFgr04
 HYxk+lbvuOMYPOdOPmVPOTLsXkcrda3IcV4HfPnxnIZIfk9AvxysIsEvOqAjjoxRcjN5j9rSkiW
 /XbjtT0gzU3nqeV+lmQRF2pLzMCc8CvavG+9hUxcBMEhqI0aoCthDLf39wyp4TVUafCE+ZQb9hd
 FBaxetIfvOc5HMdS6QMLrLsEBCE/ODOrI6j3DPIX/AAd+PEFO16zwO36XT11lMkEPwfAQCzsn7n
 NhAuNW7jTcLyMwafvD/NN+NT1+goYU4xx7jHSUWMB8KrZ0abJIeclWRm79m2suv/m/MHZTrgjsk
 LmgIiSTT6cNQauveiVvMfDnwEqUA4w0ySOuOud4nB8AYuvz9dxkSH+yW/ULNdqXL4B6abbHoe+H
 wWmVoTEwb4EoEDp4SAxMFulZBsd4bw==
X-Proofpoint-GUID: u6zza4mbpok35VHKWBIh9llOo_wS6A3-
X-Proofpoint-ORIG-GUID: u6zza4mbpok35VHKWBIh9llOo_wS6A3-
X-Authority-Analysis: v=2.4 cv=EsHfbCcA c=1 sm=1 tr=0 ts=69435f0d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=aY7nMJUTrloBAr6TJikA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

QCC2072 requires a new type of QMI target memory named LPASS_SHARED_V01,
add support for it.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 1 +
 drivers/net/wireless/ath/ath12k/qmi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index b7c48b6706df..4966697f4e62 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2609,6 +2609,7 @@ static int ath12k_qmi_alloc_target_mem_chunk(struct ath12k_base *ab)
 		case M3_DUMP_REGION_TYPE:
 		case PAGEABLE_MEM_REGION_TYPE:
 		case CALDB_MEM_REGION_TYPE:
+		case LPASS_SHARED_V01_REGION_TYPE:
 			ret = ath12k_qmi_alloc_chunk(ab, chunk);
 			if (ret)
 				goto err;
diff --git a/drivers/net/wireless/ath/ath12k/qmi.h b/drivers/net/wireless/ath/ath12k/qmi.h
index 7a88268aa1e9..050dcaca1cb7 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.h
+++ b/drivers/net/wireless/ath/ath12k/qmi.h
@@ -178,6 +178,7 @@ enum ath12k_qmi_target_mem {
 	CALDB_MEM_REGION_TYPE = 0x4,
 	MLO_GLOBAL_MEM_REGION_TYPE = 0x8,
 	PAGEABLE_MEM_REGION_TYPE = 0x9,
+	LPASS_SHARED_V01_REGION_TYPE = 0xb,
 };
 
 enum qmi_wlanfw_host_build_type {

-- 
2.25.1


