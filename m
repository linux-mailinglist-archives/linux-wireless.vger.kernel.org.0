Return-Path: <linux-wireless+bounces-21583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9089A8AE1D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 04:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3979F3A92E4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 02:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E4513AD05;
	Wed, 16 Apr 2025 02:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MrJVhLTG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574E51A9B2B
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744769959; cv=none; b=pIThJe4KvLGNfPDIsfc7uW1MdUXNVIuN/jvIFuqXeSYOPYc+hlnn1aKLWT/ybxf02me+1IDqkxLX0jbgZ9C0I4sOZZO243gfOwkhFrxX2gtcUp6rc8UE/itMbNhigT5q6BHFUdnZJmRQJg10n9GF5+tSUFXcoDO531pnNOG0VSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744769959; c=relaxed/simple;
	bh=lyTaOi/T/r2Pb39z6u9V5am1F+nBBIYGJfNUblHOgpA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NRB6LVxbOIdcBrF0pJCeEgQKrDF6QleLSEg2B/cZdKkl0YppkkF03KkxAVCn+RXWCLbSUQS2qCwllYlOoegOeQpzup5lkyndbizyDevyr5g16BjZyfvn0BDunfmRCH17hsjkejig3VrOqCsyEVNsban5/cEmn+lyQGpL5FAXQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MrJVhLTG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FHlvMC022976
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=jAyP5X08tuLy
	Ectt/gIwcX04M/yZMnGfT0a239xb/cc=; b=MrJVhLTGWCde/EAuOV5GkKqJLGNT
	Wr6kclut978Mm9k0Dbfb8OLfYQsDJFE8ArRi5ZIlqeGt0egNuB4SrHeagfT88JpS
	8kOo3+Tx1t5TJxSxXekNsYPHr4hgJ7hYC9YtNPsM1dma/Ot8mscpBR8SJVkHpaBM
	Wd2B2uMzZUeRaGDX/WwWngQi5fYIFHVGk0ui7zM7wV7BfzZhoyD8eiSdTygXmFfC
	ztTqwAEx7rCWnoP4NCpwQ2AhTF3xAMWPtEKOY9uEFWrOCjMhwsfqQ6tFnujpkmsZ
	yeNt9crgDktvifeKUNhWQWFCnG4mzqYzNyJqouWobzwmipqzhs0A7dKU6g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygj99yry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 02:19:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7369c5ed395so6758401b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744769955; x=1745374755;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAyP5X08tuLyEctt/gIwcX04M/yZMnGfT0a239xb/cc=;
        b=MZJ3syS/JrH5LgV1/R7q1v9OD8vqDN0UyPJY/1u+sEW4o5Ufn9yFCoVpP3yIu5yjP1
         avpmSf75TAjC7RDOvLNxiBSNjW9aVsFFBQUvQGKOqwyHBtFKybrJsoGNTmITJejTUxPj
         1yt/5ZuTH9cdzF2obEKMLoc2uOgR4GHNyPS/FttiedrJ7hr2jwat1ezKm5LqDtz0UC2d
         oZu9W4thMCIKqAyv8bMGa/9vreCpGOWQ9tIxUg5g1qTWTPZLVju+dgUU/dOM9AZJ2LDO
         P296ywRv0OsC12RrXIRIpSUrsiZHJjKOUvPCq6H8nQ04PRCTfb5h3wUNeZn42hO2ZnYq
         dlnQ==
X-Gm-Message-State: AOJu0YyVCvPn9v+ryjbjww37oXZd0zn4ivdKP/PFcLBoEZ35+fRmos62
	rkAJzRhRGEy/myjn1IA7VPl+hJQMGenZbDTwccUvCNkSNOilVV/wxIjbF0hcm7xAIUKyk9odsri
	amFVsxHfKn852xwEFY4+h7cmkkNTffe+MctQfrq75tnmSoa+JiDuRfWihDx50lVclWw==
X-Gm-Gg: ASbGncuEHsgDuSoupa0wTtQh41m2VOJ16mK6uVbnQUfavCWSaq2d8LtL13Zu8ICLUrC
	HG2F90vNAmYxrasZsxEyL0Wxaf7ITx6CK4mxLtucQNdYkgciy0TY1IyqdnDNNon+G0L/+lY1xgi
	/vEenBF9OUW4wO0DxJYRqBr1HPIjpP1Fc/4q2mJQvk3KsS+Z680ip3gYr2bmW0al1cIVMTo7Nk6
	Mzqtn97Dg0uzxASGdL+MldQygfkNJRtDZlZr21dbF66RZiFBRYUc5tx+QldW3HOk1RoWsr/Bt6H
	QzLUBB9H0RaJdo9OmlZKERmOSe4BYcU+hdmanSPvSL5tNob8tvWB9q744BA0iNOHoDcXUUUj2Ff
	GRMqTXdxPejjLNDjO7/KY7+Ks4OFCIEiAFHN21RgGghteig==
X-Received: by 2002:a05:6a00:e0f:b0:739:b1df:2410 with SMTP id d2e1a72fcca58-73c267f5565mr101327b3a.20.1744769954592;
        Tue, 15 Apr 2025 19:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHcefSat6xvhJY36JnxMsXYZ7bDRoeCF96m/MWBtasTDKYJTOO9aNLvg+eXHySif43wGU3cQ==
X-Received: by 2002:a05:6a00:e0f:b0:739:b1df:2410 with SMTP id d2e1a72fcca58-73c267f5565mr101297b3a.20.1744769954190;
        Tue, 15 Apr 2025 19:19:14 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f8253sm9559789b3a.93.2025.04.15.19.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:19:13 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Add MSDU length validation for tkip mic error error
Date: Wed, 16 Apr 2025 07:49:03 +0530
Message-Id: <20250416021903.3178962-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: JJWQoZ9a3l63gH8T60DM8RD8szG3MDDX
X-Authority-Analysis: v=2.4 cv=PruTbxM3 c=1 sm=1 tr=0 ts=67ff13a3 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7QbXSr-hkXkeXhD5LnUA:9 a=OpyuDcXvxspvyRM73sMx:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: JJWQoZ9a3l63gH8T60DM8RD8szG3MDDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160017
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: P Praneesh <quic_ppranees@quicinc.com>

In the WBM error path, while processing TKIP MIC errors, MSDU length
is fetched from the hal_rx_desc's msdu_end. This MSDU length is
directly passed to skb_put without validation. In stress test
scenarios, the WBM error ring may receive invalid descriptors, which
could lead to an invalid MSDU length.

To fix this, add a check to drop the skb when the calculated MSDU
length is greater than the skb size.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
v2:
- Signed off mail updated
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 96785d60d671..52ccafefd35e 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -3869,6 +3869,15 @@ static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
 
 	l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
 	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
+
+	if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE) {
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
+			   "invalid msdu len in tkip mic err %u\n", msdu_len);
+		ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", desc,
+				sizeof(*desc));
+		return true;
+	}
+
 	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
 	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
 

base-commit: d0bcc5eaaa611aacbffe6b2cc2fb64bfc3bdfcbc
-- 
2.17.1


