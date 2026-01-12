Return-Path: <linux-wireless+bounces-30680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8A3D10EA7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E2EC3055764
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE7D30CD82;
	Mon, 12 Jan 2026 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lBISCZY0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eGxzUSyM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC023191B4
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203432; cv=none; b=qAIa5zAUhpJ6Mnw73BgT/elAzQocrwWhDkbQEBasGrbmJvPMln0j10ZJlR6EH+13uBrMdc22jNzDzzUKoUvp5D6kaOOXgTgzSCC9TJAlQBPy2prHzKKv2a/tZy9MPpyEke75dI6fnOuuwyWLpw+pZfI/wtKIc+YQiDF+l7vAEtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203432; c=relaxed/simple;
	bh=PrV0/67mR69ePp50OdRZJmTq4Hx+iY5PBjCgHSQ6RMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qYQ1dKkmR1Zk1Vrkfm7jR3oH5qknw558fl2Lo5zrwGBfmeLEIQya9csACzfKn3B5o0LyXpT3ue9ItV86grLkXvFU/h248KOpAJMOcAXkGCoPb46Kr3IvMvqPlH1TwPumfgMBmanKZAUTZluQu6Xp4dhg0BfU86BwD2pTk6ZRnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lBISCZY0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eGxzUSyM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C6Ajsg2379680
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JmwHcVmezRhrnG8yMV9bsbnLk3k9piD14PfETaftqNE=; b=lBISCZY04BppSsaV
	mYDaaKPsr/zUVLXGmqzOzRwE7EJcj9xhlgA/847AVuN8JupeehWI7X+eD5aQa5x6
	iOR+mz4u22sAaTCfa0EGBsOETqhKOIq55LUxXehIlfekXy9baX7V61J0YvwW1RLd
	khNvOG6jL6v4WdwJPzJfdPp7YKCfc4cI4BZYdxkCVhy+XNh6XFWBF+XlsyATgB+h
	sNOe9pyY+xUVue4NAF/gVwegi9UQxUTrbwkLSD/TiHuk/D1fnAdWNxHZaab7tRpm
	yQ5q13QjmPtaiA7VYL1I3Qzdp+fPoF2Mfw/VvowUXw/ni5qyZ4ZdGGLtHwd9D7I9
	67dYmg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkjvxumhk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34a9bb41009so8545082a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203430; x=1768808230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmwHcVmezRhrnG8yMV9bsbnLk3k9piD14PfETaftqNE=;
        b=eGxzUSyMAO9caATFVK7TxuLn70REoj3buuCIqqKxmE0KvTo96mhiGs4n0xDjfjsAfO
         6MCJe7JcGauQ6ObRd/ONzbn15TJzrnUH+mH7RQOgEoCgISBhdueRYYw545HsPAkMDz/k
         5Cd7KTi7t8fIsebjJ4mcG2oW5vb44QmkgHFJMi9CPGcCayfAVKDAw5gNuj6zdonrNTIz
         HY/AMv/UE5ZI7p9akh4ViFMpAii48OttBmXkdbCGZC9h1YtOBvlzOZQbxaZY2uFncnHn
         I5DBwPU7eNNJFNdoW+uoOLMpGrjCfr3nLNEcmQ82pcA9BIGvll6cu6yQFYUk3+AZM3L3
         28xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203430; x=1768808230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JmwHcVmezRhrnG8yMV9bsbnLk3k9piD14PfETaftqNE=;
        b=o/rfdyUPlDcTty1BRfe1+wMd/W7GaITnCO482SPO6GL1qGi1ac4uWSUV7NasaIeZ2/
         mYvSbeS9U4xR1phITChKmuTcXo8O9OkAQhdHBid84Zb5ygkEymqIR3VXKoG+AA2/6P80
         w/tIlxdFy97s+eGkZ/+FWKnFtSHDxncjZQjxLksyLiT7shfD6BDysGj3/beoTZC5ooi7
         B7XG4kGK+kZHE2R4OYUk1UbZHdxwmwTByeekIhagBWwNKTvxWN47+tVpc3V6dSfEjCAE
         JvwKubPfu6rYbjahHCpwDBa2gk2ACz2rNdBN4qojt2qEqLjU9TsrwJzmsacQDAKvTupI
         Irgg==
X-Gm-Message-State: AOJu0Yys63c6j3SDDK4rXGswEvOMzJfj/ZCYmSFdVsS9T5DfF13ux2cg
	I5zwWRq8c3PqSdpraFCNlTxvbRYp8QvAmh9zUMV+nkAoflMax2b+Njh1gYe0fvPJwgoUrsilqgS
	H4uYi9wXtGBctx/wQ+dKX4E2aJ5QmsRDfsOabum/sDZOfz201Ij5z5qGtIjw3bofdY29vTA==
X-Gm-Gg: AY/fxX7Ti4hKnD37/I1GZdADzn3woHMHh+fpsGUWl0a3AynlIg3c6FIDZyhflBTbgZz
	brDVGm2JMUUdn6E1+k4zQrPDM06HoAbfEgUS9cbyMrRq9sp/oH11Y5MyB3qukYguLeAkSvyb/LJ
	Kq2jN2r97oQRHZfQGgzV2+cGXjLCTxpeZvTOmQJSBLa9jzQSvQXlB4drjsxEmLy0yf/tC2aLrqL
	j4eMG5bewEOSnA9CfCqsgHM/hvsUhlM+lLKeBEt8qYMc40P25z/wjhD9lZdkCIWctHO9XK8gD+Q
	jBLm1eYVIb9odo5GPU1wBz3v4IhK1iC5cCSyNWx+YZRJGL8qwugDOx4RMfc7BvqqsCz0i3wbn8S
	60fFr7d7EeSZaeLWNjIyEfZ82Kfz3zB7wkboX+zAY8U2kjzFZoTrlHn87nAOU5Sc=
X-Received: by 2002:a17:90a:fd0a:b0:34c:904a:d92 with SMTP id 98e67ed59e1d1-34f68d2314emr12688877a91.26.1768203430004;
        Sun, 11 Jan 2026 23:37:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5v59lQXUpgvcDxJQ7s0ilXzqeKdq6qxgtRAAvId3y1WNdyF264oT5Lybh58EhD5UBTpVnUQ==
X-Received: by 2002:a17:90a:fd0a:b0:34c:904a:d92 with SMTP id 98e67ed59e1d1-34f68d2314emr12688854a91.26.1768203429506;
        Sun, 11 Jan 2026 23:37:09 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:09 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:29 +0800
Subject: [PATCH ath-next v2 09/18] wifi: ath12k: support LPASS_SHARED
 target memory type
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-9-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Wrsm8Nfv c=1 sm=1 tr=0 ts=6964a4a6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=aY7nMJUTrloBAr6TJikA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: _5pCeKVq2Fjb0STJLF8eSHcm8AAJ85mm
X-Proofpoint-ORIG-GUID: _5pCeKVq2Fjb0STJLF8eSHcm8AAJ85mm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX77UNHuKUxlQ/
 Xv/q0xo0eWW68sJkptIILIVT5eDDcyLonjmqU5298b5G6NDqUPuzuwFeZXsG3I870QWHDK8t1LW
 njRCb/kbbOqvvi0NiH4BovhFWQ54BK/Qy2OiYTFzuYOpj/NzbJOQsmPBhQyCzYUTnqaUxO6B379
 Wz0wifrMUyHzGIeGS1U2rS4j8QUYMGvWXF2i/kjkKDvJDoFxLOWqhXRY0ohxFs35mzRtdKfdYfn
 N9QKUTdInpRpYdz8t2qC7kyjgcJKC8tAxtJ0EWaRdD16rWb0tOTpMbKQkXroS8uu6CYHykJdEyb
 YB1v99TM3GG0ejFprreRNp70HfPaso7LxpCEalWpCwT0IpGmUz27N7BWA5hlj5hbTQu4Z1KhwRa
 +RCx4eQeqakNHIdWMVQ3Ly/keyENymokFcZ43+Ny0Pv4Mm66eeAU6sYZAbiwn15AeFAQ8Ojp6pL
 2+/lPRvTpvtKhRnS48A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

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


