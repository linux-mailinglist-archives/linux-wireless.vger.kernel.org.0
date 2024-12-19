Return-Path: <linux-wireless+bounces-16626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD839F82BC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 18:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118297A4AC2
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 17:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8821AAA29;
	Thu, 19 Dec 2024 17:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gW34Mx9S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351D1A2541
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630899; cv=none; b=W0BDYkF0uezm6BKWJ/UXaYzxb6DrmiGxXpv1clVILveF4J9PrIiKoTIVRvVPcq3uS4GKko2vMWe8g1NBdJfftjU3o0ZzUTXCJo3kBvD7qYfrxZj8dvcSj5N7r9UOiNqNu2rK7dWZ5EB2lOj6xt0Op6mAKRwd+eBwM5DwR+YqWXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630899; c=relaxed/simple;
	bh=uP0TIt0oVH+spMx0Q6sBDEZBLMTn9EJ02fFQA/AVQj0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X0MiTlp+8QNXa8G76BKTK+LM2OgpvE+SmNS8ZeMITuKhOVfNdnt9BhfvBNzYX04we4PgGVs1iXmN7URPkAeyRyFvExKyO9fIxyK7Ynk6PGXK6bHVieg9C1mpx3R9oLEa24ibfJ6XKLj9P3TIZsWWdJqlFlfHWV1w82eFs5oKB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gW34Mx9S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJBjd2t016097
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dOnwA6W2GL2HPdIgKiB+P5Wh8IyDu3xLN7C+vWRW0Dw=; b=gW34Mx9SmAnI3UaW
	PkFJYeZ9Dub3Ma4qx1npm6QneUP5jKopjWVr0w4qx+iDUxi68H6aDr6c6kNpuCgN
	h/Kkg6ehFqMGyTEUMxNVV3Fb2dn4fv2ctgP2yGv/Bb/sXHLlitdj3OQSqcwuUjj8
	pDiVGFCsYWrLUzWBPiA/HyLZuEte7j1vqkT4Pd+oPjWFSLQajpWRom3F6B9j41rd
	08eErwCCKfzDhqoXNwA7TDQDkU/407p+Gjh5q0/c+vEQbTquQvfIZ6NZZsl/LVdB
	4gbqAxvZQCPpiv+S0U9s+FFnMs4sKOPlWoF9Kyqja78C6WRWF58rocLUh/abEVEY
	ofx7ig==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mjw810uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so1014372a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 09:54:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630894; x=1735235694;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOnwA6W2GL2HPdIgKiB+P5Wh8IyDu3xLN7C+vWRW0Dw=;
        b=B1LXp9jiHyKD2v5CuzlsDG94GsYfs3yFP6vclRApyfdN2n+p0uGRLm0UkswrU1L35O
         GnhSPK1a1C0W/NoxuqjAMTB/P3IKHSeo7O5dC1l5ZZGN6s5mNB3McgcsL9AGJZ/u72zQ
         xfuw1QdSJmt0xoFN8WWV9I8/KUyQVC0GClZwN3TXTC2IBeaHSO5y4HfHaVrF1mTEEir4
         AngpdDn9b1I+lr0+Egc9KV2+NCeXi/h1cpAz2k+dP0RPOANqsp283nJzFoc5oJ3YBJwk
         FG4Md2HUeohvnTtp2dQmWalj7a3RmkqyGevhD5PvZIXO/vkKsdCNHSE3d7jlwdwX26aA
         YUrA==
X-Gm-Message-State: AOJu0YzonhX/9Fc2P/efNqMJNz2/MrDftW/A3k42x9BLMo0/zvKgNttV
	/FWry6Q83D4rWRCmU0NQqBB/TXM5k5TN3HWWSfd+nJRmdS1QmgXtGFctS4rwsy9DhdGvK5BLhpV
	86lJBQb6FgyspLEP8NTqDZ5ELah8hUEzWsIOQF3N6R9lEPOAqZ+TQpHnzRv0z6hn3h6tODID1ng
	==
X-Gm-Gg: ASbGnct9wPfxewRaRJiBzW8F0BNvQR9E3rg5W3Kht82cWW3sQttSAyRl/sdsEJAg3Tj
	kWJKNSRb936wncKFVcgMdbNui6du26Mz+JlU7swAZfBuI0ht1KcndKQZGALUiBLbuDhowWLeX8h
	jXjLaQw5qIRdOauBDC2pUuAFssQqhdX0l8ZFwPbro86+kT7kS8ggfVbHKkP89zCx+MLkrAH6q1d
	RQnvjMLhQUSrqwZ5SqxMVgU0LtqBwuXN5h8MpBTeql4OCV5+WAWT/9mnWQ0OzzT5GgRZWGIZEMQ
	1mAFe1jEm+mqA+kosw==
X-Received: by 2002:a17:90b:50c3:b0:2ee:f19b:86e5 with SMTP id 98e67ed59e1d1-2f443ce9ae5mr6635893a91.14.1734630894634;
        Thu, 19 Dec 2024 09:54:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkGZyv5SblMwujUmRbi/VoqJhm/83fCe3NOtmsuZSUKguNM0EEIu5MlyTwFcAn8aF8/xWILw==
X-Received: by 2002:a17:90b:50c3:b0:2ee:f19b:86e5 with SMTP id 98e67ed59e1d1-2f443ce9ae5mr6635869a91.14.1734630894259;
        Thu, 19 Dec 2024 09:54:54 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26fdfdsm3630628a91.52.2024.12.19.09.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 09:54:53 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
Subject: Re: [PATCH v3 0/8] wifi: ath12k: Refactor the monitor status Rx
 path
Message-Id: <173463089358.2609009.17500722670336215744.b4-ty@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 09:54:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: ij9-a6gkwQhWxSWw6ZGTrifAMAj9pYf2
X-Proofpoint-ORIG-GUID: ij9-a6gkwQhWxSWw6ZGTrifAMAj9pYf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=784
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190142


On Tue, 17 Dec 2024 14:15:03 +0530, Karthikeyan Periyasamy wrote:
> Currently, the monitor status Rx path was inherited from ath11k but has
> not been updated for the ath12k 802.11be hardware. Also there is no issue
> at present since the monitor status Rx path is not enabled. However, in
> the future, the monitor status Rx path will be enabled. Therefore, it is
> necessary to update the TLV structures, bitmask definitions, remove the
> unused bitmask, change the Tx monitor SRNG ring ID and refactor the
> monitor status parse handler.
> 
> [...]

Applied, thanks!

[1/8] wifi: ath12k: Add documentation HTT_H2T_MSG_TYPE_RX_RING_SELECTION_CFG
      commit: d506e55fe39bcd6a78bd1f23210cbcd8cee4f844
[2/8] wifi: ath12k: Refactor monitor status TLV structure
      commit: 61a0d9a879c3682391f88855220dd766bb9d6542
[3/8] wifi: ath12k: cleanup Rx peer statistics structure
      commit: 6a6d941a39947c359ed245fca490dcdb09551235
[4/8] wifi: ath12k: Fix the misspelled of hal TLV tag HAL_PHYRX_GENERICHT_SIG
      commit: b79462532cd56119fb409f81f50dc74b12724b5e
[5/8] wifi: ath12k: fix incorrect TID updation in DP monitor status path
      commit: ebee84cc961cd3947015efbf4a5dbea63b11c5d3
[6/8] wifi: ath12k: Remove unused HAL Rx mask in DP monitor path
      commit: 0345f28a122656a4703442a2a97d2dca370c27a0
[7/8] wifi: ath12k: Change the Tx monitor SRNG ring ID
      commit: 61f247a06c3cdeb9093b3d90afd7d51168d089f4
[8/8] wifi: ath12k: Avoid explicit type cast in monitor status parse handler
      commit: 8534c42397ed8f05257dbddcd305a351ad40add1

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


