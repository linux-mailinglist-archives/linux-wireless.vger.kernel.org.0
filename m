Return-Path: <linux-wireless+bounces-20395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C00A619E4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 19:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C87463243
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Mar 2025 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66D7202C3D;
	Fri, 14 Mar 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SQRihnTi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374CE1FF601
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 18:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741978572; cv=none; b=SLkfqWCUyrnLHfglv84D4WUMuBaWtNCjDwd0hjw8zh189r7P7VJavSzgCQYs8th469WHLg5+cwok6qrmq3Crj2iTFTJFWK/wrmYz2KEnqJiJBZZ1utyBbg8fop4BVZjw/1Sdl3PFe66+5dw9Fz2gasjpMmaVJQ9dytLEB3zWt5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741978572; c=relaxed/simple;
	bh=IL5JbzLlKW9Gg+4wADM+jKAWOhRbHHK0plp1Ux84wr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LUM3z/Ucoha3gAjDGHim672OgAOar65BLjkVDkfywqZRKnn5lc4pMf+BQBpIcz3C4MgpmGY8jrJpBN2iFe2zWFIkGjWbnbEofBXzY8nBf3+uR6BzRlnr1/CPD1Jf5du9XxnTg2AZI7qVddrQCg0WT4OzqHaXI+/J8PIsMGUfn+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SQRihnTi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E9DCMA022707
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 18:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VyOn1aKiy6D4dgEukUkOVanpfIkyynBBfS6
	GIWtkA6Q=; b=SQRihnTijjjy1k3k0d2tTdow5Ds+Vpl6wFJAmEGKUS5vgtreXUe
	pzMNGMreew+F60xiI8qduaCMvYbMSpda2cBMtiP3gJVjWeIEEE1xJMCXpcpetvt2
	2eV3GXnDPvHVe97qjCNBiAVv0v7LW++wQ2nccw++xXL2u9Y7wgDUCGXk6PMRiaJ2
	tleT1SBH9MLb4n5VA9+0re7dmFxwdmd7Pns5ChH9v/+yd04zAL2lqvZmCaEr3KS+
	bG7yKWvA+k3FmcY0jh2aMSSa4m/UDhF+TkUML8Zth73lYPGuz/NsXxSd6dl/65v5
	aZzewXAzWZTTNnXOtv+cFC2hCZVPyr6kmig==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45chmqsgfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 18:56:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-225974c6272so37930715ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Mar 2025 11:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741978569; x=1742583369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyOn1aKiy6D4dgEukUkOVanpfIkyynBBfS6GIWtkA6Q=;
        b=IEijLDzalfd2vvisYdy9MVf4OuojX+97CpTQtRiRg4QB4nP9II3ClWOq/goM/WLPQ6
         MOu5hUdG9K0sjue0BaheDZ6LneSvloSGqKjUokHEeCcfchF9ZHRyebIUugmiGjBbEp+k
         7gkCNusg8kNpebTl/CBm9IqfL9Dme0TPcIvPr0M8j4MTNNK+gbPTEJnJRtJmxbNm1OVa
         srGomTboDDAjwcdcIUJmfM4oTz81HuuZXD8u6lQIQ2YL8WeIucvqvtRRPZOeV7nlKqMm
         zoj7eAjndD/1SCSyXQO/s0w79vLsMZ4XQ0DOaN/CjLT2TtKvKaKOzrhhB5VixtaI3NNV
         8rag==
X-Gm-Message-State: AOJu0YzTmiGNhpPH4QQAJuPNrGzNpXAGH+c1WwfvbJwiPWlz8Be4//sC
	bPLkMaLoY3F9BEOIdMSJR+tlykGZURX1Nh0z75ALQJkWuWFux746FrWe1Jceb/beYkHpk0MMBGE
	RYCUV+450GaWKR0edN+h/E7LQixOThU3PRqUEY4ZCBHuSsu3KQkcz3zDbJQfG9kfDKnLmQkTDAw
	==
X-Gm-Gg: ASbGncuZZ/1QxL5bSr28CxVMQCGbXoC+pCvnOwwlVayYdL3gdXChNHYca8f7biavvij
	MZglZAjNaXb23jLP/reVEPmub1PM3HzShhqGhJV6uKn4lRufa4AqlLjoq8WJIaDPKVwxt4Sug11
	TOr3lLGpd9dS2qCw7StPMtREBNBuVTAwHzzCWSUAHhR0vKsVoBSpQuN03ZOEdzYLvLgk7M8hAgc
	55ZptqoKHbXC5QSEiFX8bxIxnMgvS+8yuPx2sO/w9ZO7v9zDRuf4iCzvUez7w2a0j+l93L72wUs
	O8XkehrsqRH9Y0tuNk/oqDLVJZlHJLTVZFDYM1STOrX6IieUzukPAo9aBKpNoVhW1POLDyTE
X-Received: by 2002:a17:902:f681:b0:21f:6f33:f96 with SMTP id d9443c01a7336-225c651f518mr92671555ad.6.1741978569122;
        Fri, 14 Mar 2025 11:56:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/GGBWRoSuRKKWXboT1ZxtyS1iodJlSRZgdnr7kSncoS+ebLA7B9IliKWxFY0tpmYCBtMd5g==
X-Received: by 2002:a17:902:f681:b0:21f:6f33:f96 with SMTP id d9443c01a7336-225c651f518mr92671385ad.6.1741978568723;
        Fri, 14 Mar 2025 11:56:08 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd4d61sm31793525ad.242.2025.03.14.11.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 11:56:08 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: remove open parenthesis
Date: Fri, 14 Mar 2025 11:56:05 -0700
Message-Id: <20250314185605.68454-1-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xlx8QINlqsNni3QLWwnm3JcJtvh2dYPT
X-Proofpoint-GUID: xlx8QINlqsNni3QLWwnm3JcJtvh2dYPT
X-Authority-Analysis: v=2.4 cv=d9P1yQjE c=1 sm=1 tr=0 ts=67d47bca cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=pZvEp3DiZLBnWKbc7rQA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_07,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxlogscore=847 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503140147

PMF debug log has an open parenthesis that is not needed.

Remove open parenthesis.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ca50853ef190..84154fc270d0 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7557,7 +7557,7 @@ static int ath12k_mac_start(struct ath12k *ar)
 					1, pdev->pdev_id);
 
 	if (ret) {
-		ath12k_err(ab, "failed to enable PMF QOS: (%d\n", ret);
+		ath12k_err(ab, "failed to enable PMF QOS: %d\n", ret);
 		goto err;
 	}
 

base-commit: 0e28ee106c46c95eb322833c17c33e3c231ccd0d
-- 
2.34.1


