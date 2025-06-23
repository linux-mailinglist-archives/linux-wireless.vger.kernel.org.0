Return-Path: <linux-wireless+bounces-24363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77075AE4758
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230CA189DE9C
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD63275864;
	Mon, 23 Jun 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BjpoQH3Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF2A275841
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690135; cv=none; b=njTcxiSFbzaCjoyoZGm753gRZTZh48PYYCmCFdFs3Bn3BiuKmvb+q/3o2UFreao6SaEpaBqh0ufL2zIdaX1UxwS902/KvcXn+t+yTu0dNCB6eDuxJt3l+lEZhvpLh7SEOe3vhSWi/Nz8NBsuCBLyovXgXGcZxAKDvME+br8rBuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690135; c=relaxed/simple;
	bh=JU7VqEtQD+YzP4C5hqHGwNRrRrbuJzO1dclYyEuxkt8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cUfCsh0akW1poa/GvR9sqyhNHs5ZQtVTpU/7oPt4lLzN4GqSj1KZUkxK/fXp8SqAefVpaiqG1wQUY0Ozs5vzcFQ+qkVn/L1WwwxEXfDUzuR4TG6bccEbAeMFueSFiIJcvDHZh3EaUdtR20LqKaH201HLFeT06yzIJcfJBZRbEOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BjpoQH3Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8LjEE006119
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lKFnVpPG8HTPvkKizIt8l+YJVK3KOFx1p+k4g8s7RZ8=; b=BjpoQH3Ygey4coGr
	FvA0GV4PqzefvfTPgj625KJjeD4odA+98j4ukDKo/iMF+Q2lQHvQJ40+9wb3EyF8
	gzC2JfcD5KGCxwE/MS/3UsiR/SELWQ+Psy2JsJVX2DUF5SnHgWJkM9ANjTf1L8Nu
	qSXpokBsv9lVp9+jgkbBy7jdvBtZKJkS643CqXgMBKUiqvLA0k2zPK1q1+zGFN+V
	RYpUWzZMskMwEZPrgtDRfirepOLDdJCJvLL58qcevOVQLQIDP270hJ29t3SsOSq+
	K/UxIIeoUBSjX32QQpKyeHyg6Tizh3I2OlHHXANHhIpJx/cuoAngj7ReiVC67lct
	kbjZAw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bg92xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:52 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748efefedb5so3523139b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690131; x=1751294931;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKFnVpPG8HTPvkKizIt8l+YJVK3KOFx1p+k4g8s7RZ8=;
        b=SesHUlf5VMSXgKEPwel53pbgb/aJeTdpjgN/+HFtKWG6Ep4ShsjoPfhnER/lgjYuAh
         mMGULlGVMWY1VTe+pezwZjjrI0UEtFdJ1JmPSBxq0qIVzzoBDNJ0n6+Te0kPsh8gzeV2
         r9XY7XG2wZSJuKDrmSnkEY7rGlkLv2YOLsNTY2ZYVtPY3ryfzK/jrGHUdNkCkQh0Xp4T
         UTaWgEsQ9ZsH+AxmdbslUucsUmyRS0YB1pwoeSXF09qq7iBB+QA5T1iXr5gW5WEVAm4c
         8VdcG9/6KKam6xoCCbsmnS6IBGijSacsaNOdjOsgcf7PHBzgQHA5sfIrlBROZQShx7Bc
         Vjmw==
X-Gm-Message-State: AOJu0Yyn8MePzL/95o1HUd+asBZCVuINsgINwsu6oWofJxZi3YutcRE1
	a++e5ycZoqwww6ZbK6oXXO2kjLV8RmlsWLQGtIhyYdf5B9s8gfiADeaeVLje0zhZfqGKC6o5AzM
	+gOkNM4Vzd+W2DGBhQjEMnDbemG1Z+y+3DBrIlNyofbcBhwgcdsgOtxFkmfLrQmeLC5RMOZDUIY
	6bpw==
X-Gm-Gg: ASbGncvQAu3tXY0CcfvgFfx7XTASdAQL6lG0710Y9Ok4BGeVVt0TZjowr4dbh9rK7LI
	pLMtbmTz6qCk+HqO/L30vsiDR8Qo7tWB5Uaz8i+9Ryn6WsbKbwNX9qso1yMEoIHuC/kB80F76Rl
	4XTSJwWkknLAlrm6FVd7lZ3xDAqFkaKfVk6XEaUZbYvLQOPNFCEmfhFBJ4N/0bXpT34y17rEbVw
	CHvowQRaBWA1Y2xWXaZg5ba46RZj1Bx3mIN2BKcKFAyH1tS7tZ5cyX7JNw/vwVfBYEcJhlb9uRy
	paCde4r4SStWDsn8vsObjS/lWazwQOO/ZJrXwCL3N2gzaq6NbGuGnb6zQYc=
X-Received: by 2002:a05:6a00:8c04:b0:749:122f:5fe5 with SMTP id d2e1a72fcca58-749122f609bmr17362142b3a.18.1750690131246;
        Mon, 23 Jun 2025 07:48:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1TLoAfsG8g7WQiL1bRBHJ5wcoZJtBujsF7d9kvKZK5IM68dG5hKeC5CPU/pi/AbISDolnQw==
X-Received: by 2002:a05:6a00:8c04:b0:749:122f:5fe5 with SMTP id d2e1a72fcca58-749122f609bmr17362113b3a.18.1750690130813;
        Mon, 23 Jun 2025 07:48:50 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:50 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250606044936.3989400-1-tamizh.raja@oss.qualcomm.com>
References: <20250606044936.3989400-1-tamizh.raja@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Pass ab pointer directly to
 ath12k_dp_tx_get_encap_type()
Message-Id: <175069012970.3758471.16878237237153437687.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: qJHw03DyXek4zxfQqbMpLSwQE83IOo9E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfXzVRK0V6H3g5Q
 DidlahQ3z5Inp5+EA9MD9+O5pcu9KXbqtil94xkqbTNOUTP3+DKtYI1fdhnb5ANpV0bUZELwyip
 bqyxMhI+x9p/DaIhpFfXODaPjcT9LfU00sDfrNP5I6EpuMeSUtmMdU2qHjcnN/qFhiU9M9AXwu1
 P/CbyMwSYrMwqRgf7t/183rPmZTjoEoLQKbuc8rVgjuJ8Es8ymQch1WIk8UFj1U4PKuhFnj6q/e
 mD2imJRO/7PueucQaTDeBd2TBWm6G70qcOVbN79PVP/678TOf12Ru9oSB84NGEtWFTMGjCWBrkv
 wtZWpaJ3nri4Ct3tJpp4sMt6spRPsvfsEv5M/0fZd3fNb8fxTwIiN+MmnHb5tidQweRvo9qoTCm
 MzKDWsWo0WU2a0f/1Y/ifKvJixBWvH/arfznTT1WCCTfz3Mj7W5UOO1PL09QYDubcBkRM5Av
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=68596954 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=pPNxntyw70oWO60yalIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: qJHw03DyXek4zxfQqbMpLSwQE83IOo9E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=840 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230088


On Fri, 06 Jun 2025 10:19:36 +0530, Tamizh Chelvam Raja wrote:
> In ath12k_dp_tx_get_encap_type(), the arvif parameter is only used to
> retrieve the ab pointer. In vdev delete sequence the arvif->ar could
> become NULL and that would trigger kernel panic.
> Since the caller ath12k_dp_tx() already has a valid ab pointer, pass it
> directly to avoid panic and unnecessary dereferencing.
> 
> PC points to "ath12k_dp_tx+0x228/0x988 [ath12k]"
> LR points to "ath12k_dp_tx+0xc8/0x988 [ath12k]".
> The Backtrace obtained is as follows:
> ath12k_dp_tx+0x228/0x988 [ath12k]
> ath12k_mac_tx_check_max_limit+0x608/0x920 [ath12k]
> ieee80211_process_measurement_req+0x320/0x348 [mac80211]
> ieee80211_tx_dequeue+0x9ac/0x1518 [mac80211]
> ieee80211_tx_dequeue+0xb14/0x1518 [mac80211]
> ieee80211_tx_prepare_skb+0x224/0x254 [mac80211]
> ieee80211_xmit+0xec/0x100 [mac80211]
> __ieee80211_subif_start_xmit+0xc50/0xf40 [mac80211]
> ieee80211_subif_start_xmit+0x2e8/0x308 [mac80211]
> netdev_start_xmit+0x150/0x18c
> dev_hard_start_xmit+0x74/0xc0
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Pass ab pointer directly to ath12k_dp_tx_get_encap_type()
      commit: 05062834350f0bf7ad1abcebc2807220e90220eb

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


