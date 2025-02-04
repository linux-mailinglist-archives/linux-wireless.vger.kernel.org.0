Return-Path: <linux-wireless+bounces-18431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3069EA277CA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8F218814DC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D80216391;
	Tue,  4 Feb 2025 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="my25fFqz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47600215F77
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688726; cv=none; b=PY1vcbfXS69vMmvGJ6EPLYauC04xXz/NsbFmN31mVXybfo0tTTgVNsUjLSKcLeSu9X+nxMP9WWUtmShh/IdfmVM5mtkQm8GHfu70ekUJEWpP581KcHk1srsVGRmQbqYflMjcLQvJXK8OxZfFeaYuNnDYip8+b0dTKsaW06MU4ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688726; c=relaxed/simple;
	bh=p2bnHhOqSQIqgPShAaS9ItDs7yJenHwaRLnyeqoEQt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dkm/QWBsMSFrC6lo1DGEUwocC4cijx9i/FoBGvjHgwqlPMHTcr5/UrSjTfESVRu4zceLa52TTsM712BFjNj6vN6mNauwfsfEHB+ONcH3/lVKUmvyGUpWfqwczi1I0IM2Wh0UD4h2pAgsgic4OBwoCKPsHO05N3x86gsSz2g3Z7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=my25fFqz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BYiao010456
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 17:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WrKlYNONBm1r5bugr0RbvCDOyfxt2kBDOYEM2pahFGQ=; b=my25fFqzDZynRTF8
	ZtTiLNJPyBxvtgiqAsyOKWNfPCjzCIv/IX07UbjuhJ/snfG/5buEQwT1CBhE3Jcf
	9R74YKkfk0JeX3e91tdHUGLcJ15zsAvyxDKm+3DcVESp/3Lk1QgQ/BYjM/bgnDkC
	WuI0DX9yTygNeAH18B6GyOtKYabAW07LL0/Y5WlfRh7ScLBuAglCtOkg7SQEh1oW
	9NbhfDMByfutDseivc9BXZzT6+fQLv5hZV8239EL3Ca1OgosqIrb2cKrtPi5k2cu
	pq2kU83PZ7krmU3pwNunafkSMAaO+CH2EQBq0+1TFC68ojyu2L1NgTRGwil5ijVf
	QPByUw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kj4ygsr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 17:05:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2167141e00eso136282745ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 09:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688723; x=1739293523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrKlYNONBm1r5bugr0RbvCDOyfxt2kBDOYEM2pahFGQ=;
        b=wOfd97j+QLEDZHiTLTFbSN9KrxYAmwIDQJb9ZVBnd6dqWCTbsvTyRgt+T/WH1jdsJn
         q3lQE/g0EPyhAP4364xTCh5+yCg8uKilKcPMZg5N53xvHAyqBumxFlQuh4V2aBcCoYvi
         wxfIdmqUyvo8yS8x1Xwap3NEqNpeM33T2bMxQeoNUwyEkF6eviWATQHf3wN4FmGMH1yU
         p5B62CiQZkFm2eyeAbwRzSBoi3SYu/PJ8vs1d//f5ABEfYrdXBDFDcNt2z9dNIQXbrAT
         EDdskNbsWJaQQb1UIepaHUUT9LqQVHT193Xgj6CsYhGNanAG/c8vn5Jqmw1neh9SOLIX
         8aFg==
X-Gm-Message-State: AOJu0YzK9H/cEZ/RJ9rqyRy9nDLvW0Uh+w3quApEMpg18sndkMv50J4r
	m4EATgjQ0U2/rOtgkxPWtMXO/vsKX0U3xG09yvHppX2hRCYzdovNNFkfY8BNA+f8eft9lUc3kdG
	VrmpGijru09no3KPlT9l9eMGYIGsv3IuYJNCZXWdHoUBKvBFIFetSRhgUZT3t33BSdw==
X-Gm-Gg: ASbGnctnEWOLHd2g38wygiZCXCrgq0IcVHzSrxZ+bTiq3Q7Gd9v0PwEmHdplISRxUeS
	YXf9nzqwgYKQ7y3hAxKZ4G2phWNPnvcZLLhqx5Kp0mhv/AVkQbK1J7Z90qWH7Ji9s4VfSiSRYDF
	YapFD2fM1BkwZavM1OSEQhtrFJaLBlgPFRE74IJjRMX6zaym1l2rcdL1Q9JpHccJcwVYKf9Vjk2
	qDuuQeRP2fFV/Auu2xpCRqZWlhawJ8ORSOP3iw65Y9XOgkGEHQ1LuEUgtCpUPDLOnLnsmUDm3vn
	eNMSQzSjbNSQQSn394GbSQCctLjZcJ2CzsTAIyzjEpfnwipKnxSoBNJDBi2ZE+9N83A1qvKa3vV
	Rxpb4k5Z8RmGlRnHraBPT2qaS70tIfg==
X-Received: by 2002:a05:6a20:9152:b0:1e1:9662:a6f2 with SMTP id adf61e73a8af0-1ed7a6e0b73mr38361975637.35.1738688723444;
        Tue, 04 Feb 2025 09:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTnmMsoLQ66Rol4cur40Q4wmBOZ7g7tduU57E52w28CdMb1zHUBV1eaCLvbB3xc7hYjBqb7g==
X-Received: by 2002:a05:6a20:9152:b0:1e1:9662:a6f2 with SMTP id adf61e73a8af0-1ed7a6e0b73mr38361931637.35.1738688723004;
        Tue, 04 Feb 2025 09:05:23 -0800 (PST)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cddbbsm10772788b3a.125.2025.02.04.09.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:05:22 -0800 (PST)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 04 Feb 2025 22:35:08 +0530
Subject: [PATCH v2 2/8] wifi: ath12k: introduce ath12k_generic_dbg()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-unlink_link_arvif_from_chanctx-v2-2-764fb5973c1a@oss.qualcomm.com>
References: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v2-0-764fb5973c1a@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: -voqNR7AI3SdPk88_ArwMvov0d9sLpau
X-Proofpoint-GUID: -voqNR7AI3SdPk88_ArwMvov0d9sLpau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040132

There might be instances where ath12k_dbg() is needed, but access to
struct ath12k_base (ab) is not readily available. To address this, add
support to print the debug message using printk() when ab is not present.

To avoid the need to explicitly pass NULL each time, introduce a new macro
ath12k_generic_dbg() which resolves to ath12k_dbg() with ab set to NULL.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/debug.c | 5 ++++-
 drivers/net/wireless/ath/ath12k/debug.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/debug.c b/drivers/net/wireless/ath/ath12k/debug.c
index fd9796b5ad3b9feea5c7e78e8a88d361049e08df..5ce100cd9a9d16f7fcc2dc0a5522b341ebbff8a3 100644
--- a/drivers/net/wireless/ath/ath12k/debug.c
+++ b/drivers/net/wireless/ath/ath12k/debug.c
@@ -63,7 +63,10 @@ void __ath12k_dbg(struct ath12k_base *ab, enum ath12k_debug_mask mask,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	dev_printk(KERN_DEBUG, ab->dev, "%pV", &vaf);
+	if (likely(ab))
+		dev_printk(KERN_DEBUG, ab->dev, "%pV", &vaf);
+	else
+		printk(KERN_DEBUG "ath12k: %pV", &vaf);
 
 	/* TODO: trace log */
 
diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index ba0e4da3bb761a49fb81e3efcb61557df8ad1942..48916e4e1f6014055bbd56d5c71ef9182c78f3b6 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -69,4 +69,7 @@ do {								\
 		__ath12k_dbg(ab, mask, fmt, ##__VA_ARGS__);	\
 } while (0)
 
+#define ath12k_generic_dbg(dbg_mask, fmt, ...)			\
+	ath12k_dbg(NULL, dbg_mask, fmt, ##__VA_ARGS__)
+
 #endif /* _ATH12K_DEBUG_H_ */

-- 
2.34.1


