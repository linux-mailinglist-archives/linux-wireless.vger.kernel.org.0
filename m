Return-Path: <linux-wireless+bounces-26393-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F22B274D9
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 03:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF09172532
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Aug 2025 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F192877DE;
	Fri, 15 Aug 2025 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fd03oLg3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82AB289349
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222329; cv=none; b=eYdmJg13GHx5Ea8Tq0uou0aTlpfhhhzOApuMd3qpB9b38SpyYRIxGUqAiKRyNLKKL98AS2V5A3X/d2ersIj0IZDS5Vr9YiiFJQM2d7sB2H1TJUp1qIcS6b+KBMq/egShqQ71gCsOCMNGEpMsvpfzwUXEK+CVbeUjeFUX2+bqecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222329; c=relaxed/simple;
	bh=rlydFC+d2bX9ULKW8mN9KviQO2RPvRtnZWR6YiURGYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nS/Z6O5kS222mNr9YJYeXzV3VfFiduYv1vLAdlJbKJ8Mk19KFjQHLA2+3aMAY5ZPAhssPZXzC+0Fdrw44fQv9Jx4mogQFPCFCK8RU8pER0nt2mGvGBf/9GmeeIEkGNbPs6yOb+91WYnBFIZoHMmw8cjnHqqOhQq97YboZGMZlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fd03oLg3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHl64q011085
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zlsOJK5oVN3gW0ovDjkscdY5GxIZWuWXxKFxu34qXhg=; b=fd03oLg3y6Izcc+W
	BLyxaO7osrOdVreAQhjHOBb6GhsBuVA4cWyhIk5ocH0aY9b38jRJlIFJkxTuJG6P
	Ee2MKkKfvg2GA0t4Iqkl9/vqJ2K5YvwAOoBzs8WQl7Gl4+i6VPrljH8BXk12iEL5
	xdjBO/ymfts83GSNuHuPILo2TRkSfAzq5+/2s4QjJmxNZ+vIe4qkVhkkgxIE13IA
	KXdh4WxKoHoijmCOME0VmuVRQBhCB2789HTEXBxFZR3X5p8jzSLxJwDlLjXHt5M+
	DSO78aXZBxlYv2pUyuek9y38NV0C2iPJsaKAuOBY4LFbT3QobQruNIJWf8EF+JhL
	bMK+KA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fjxbmu3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 15 Aug 2025 01:45:25 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174c65b0so2354464a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 14 Aug 2025 18:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755222325; x=1755827125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlsOJK5oVN3gW0ovDjkscdY5GxIZWuWXxKFxu34qXhg=;
        b=AAOpc1vvLNahkC8u8ifVTpcaMxLFluVjbhpZ73S/wD3CeZG2aLcMD4Q0uGCljgRMQA
         0FFRCm9hf9p9D5rIy1zGhDzrV8BxlR4EqydtVOCWV6Nf6Z1vFQ7RIFxCBzSSfy0mpbpS
         WkdstYYtD6lkgzrLtEN5jABrDlSG2N1OdwIvOP9SQ1xCY5q51ni9XcY7ci1eelbRJQlS
         hd8rTtKOlOn35+k1yqw82Wo5VWPzjEDdc8AEUO2ua2zLq2Wmgwo9FmpwZrJyBOGOdnXK
         z7oGy7n2zE2bdHQYyx3YA/gn4AY/icb5HeY0Z9mMSsgVquCx6JNyomo28VAWZRVoHBx7
         /ULw==
X-Gm-Message-State: AOJu0Yzdv0wZlad7aRMrQVOQ+QfhtMzGEKizorsUHGFUzs6jmG+ms9h6
	d6Hu2htk7WrltvVOazuYXgpOyM5dY10i0F7Wn2HyCTDY9MHthpmRz1Skowvlyv7o8Tw93GQ1yBj
	rXk/sNiSElERxT9X+5vldgQcMLYA05kYZoOHgcbbengjWCdpUwjTGgxW69IXdcek8RddnGg==
X-Gm-Gg: ASbGncufn3f869IR74LqZZcwWvu5pxi4OEJaRYvj82jc7eNfYnkBZkodUXlrnluH+F2
	VTGAwmZlWlKQjhYmc5I7X7fdtwg3J3vkAN2RPKemG7w+tS61fCPbJIGwMx1tvh6KjAtCeDG+MzW
	EIVVEbY4Dt+F0g/RTOhyfPHVI5JZ2b94rxELYVEuLRYhvsX/0Z0NkHbx2neG0wYi0B6JZQq8j/D
	K9jeLmmsLPfkLPL6WK8mWiOOZ0YmV/SQVCfu9AyA1CsaXdK0KdAQa7gljXHtVLmFrpao39VVgJ/
	5Vz0uaFgtbfUpIvEGitgBslHPxrnmUmB/Vsq/Bj87zNNdsR+HgugBqpQ3qXjpO3fyu3Ct5ac25w
	+s046RZGcRM5pkwq0
X-Received: by 2002:a05:6a20:430d:b0:238:351a:6437 with SMTP id adf61e73a8af0-240d2f3f71bmr628328637.43.1755222325000;
        Thu, 14 Aug 2025 18:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcAx/TsRQqAm4kbPDgVI2KzEGpjPVvzLo1WQbeY5Z9fq04iIy5aj3QYJ7X0o5DKPHyKP5YAQ==
X-Received: by 2002:a05:6a20:430d:b0:238:351a:6437 with SMTP id adf61e73a8af0-240d2f3f71bmr628291637.43.1755222324516;
        Thu, 14 Aug 2025 18:45:24 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d7735f4sm20273a12.48.2025.08.14.18.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:45:24 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 09:44:58 +0800
Subject: [PATCH ath-next 3/3] wifi: ath12k: downgrade log level for CE
 buffer enqueue failure
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-3-f955ddc3ba7a@oss.qualcomm.com>
References: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
In-Reply-To: <20250815-ath-dont-warn-on-ce-enqueue-fail-v1-0-f955ddc3ba7a@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Carl Huang <quic_cjhuang@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=G6EcE8k5 c=1 sm=1 tr=0 ts=689e9136 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=4avV6w9vhD41MOPHW_EA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA5NyBTYWx0ZWRfX9mlb7t3CbQdi
 oA8/BKPmRg7ARjlIx4QFQLFKfDvV3aEpjVSGhMK9ggPxTHfapNULxjSVKLwIruDjiYtcx5YllYb
 LnpSDqrx1qOzu6GpxVWy2T5PEuLI4PkGVAad3jpIerlFDICC/7UyLFCwEhEYvvWbUdDg6go6zxg
 a8vLfbox31Qqza/GcCh2Iu6CyZHq8axKAZ5A31oUzlSXGshjbkbIcmoTOQyM6x8ty/eS0Xorsg5
 yy003M91siNSOFecJhuAWg//iWdgUQGjKLyBYkeUC8faC4icUSSDQHWqJY2s8MS+mxEVpcFunuS
 /hoCxZE5lGbObkLkCP+9fYFAKa+8kZ1q4hviXHJUq4iFHWmNgRzBXNNH8Cl9AqUEc/eLyxpaEuW
 AMsZW3UR
X-Proofpoint-ORIG-GUID: FtMJpqRxmiBY0Fn9Iy4jpHjxAWJ4DukM
X-Proofpoint-GUID: FtMJpqRxmiBY0Fn9Iy4jpHjxAWJ4DukM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110097

There are two rings involved in the Copy Engine (CE) receive path
handling, the CE status (STS) ring and the CE destination (DST) ring.
Each time CE hardware needs to send an event (e.g. WMI event) to host,
CE hardware finds a buffer (to which the tail pointer (TP) points) in
DST ring and fills it with payload, then hardware fills meta data in
STS ring and fires interrupt to host. Please note the TP of DST ring is
expected to be advanced by CE hardware before interrupting host. While
handling the interrupt, host finds that DST ring buffers are used hence
increases rx_buf_needed to record the number of buffers to be replenished.
Note before that, host compares TP and head pointer (HP) of DST ring to
see if there is available space. Normally rx_buf_needed simply equals
available space. But sometimes CE hardware doesn't (for whatever reason)
update TP timely, making the comparison fails, then enqueue is cancelled
and a warning is logged.

However even enqueue fails this time, rx_buf_needed still records the
numbers of needed buffers. Later when TP gets updated correctly, the
missing buffer will be eventually replenished. And there is no doubt on
the late update, it always comes (or lots of such warnings should be seen).

Since this won't cause any functional issue, downgrade logging level to
avoid misleading.

Compile tested only.

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/ce.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index c5aadbc6367ce0d18080bb0e15a88d3ddf2e34ff..9a63608838ace31587691dd53c1d4aa8f081cb6f 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -392,7 +392,8 @@ static int ath12k_ce_rx_post_pipe(struct ath12k_ce_pipe *pipe)
 
 		ret = ath12k_ce_rx_buf_enqueue_pipe(pipe, skb, paddr);
 		if (ret) {
-			ath12k_warn(ab, "failed to enqueue rx buf: %d\n", ret);
+			ath12k_dbg(ab, ATH12K_DBG_CE, "failed to enqueue rx buf: %d\n",
+				   ret);
 			dma_unmap_single(ab->dev, paddr,
 					 skb->len + skb_tailroom(skb),
 					 DMA_FROM_DEVICE);

-- 
2.25.1


