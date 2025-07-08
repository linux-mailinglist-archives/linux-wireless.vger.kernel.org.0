Return-Path: <linux-wireless+bounces-24898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EFDAFC192
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 05:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E613B9D9E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 03:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD2F1E9905;
	Tue,  8 Jul 2025 03:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hRwOreP+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1AA2E36E2
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751947064; cv=none; b=eXQtyNw4DlkmOzie2aOSDksgIxhJnKcV6bdXIA4mOIFxeWPAFGaELWC6LqPgoFjG0foL2MNvGgxs89u80CsBTri9hWAzMOwk3h96T1C55o+xLV7xWpVPG2DOnQ7ALPxrKYzzlID9/Y/NqGYpK6pI9yoVlYaD+uN/EQv9+lgIwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751947064; c=relaxed/simple;
	bh=TKZxLz1hnzB2JHAhYgZl52Th8+jis1zVeSdGUzS54ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAki8LJnve6xKbn2id6mkj7EEKGYQu/g6qzWgbsBl5PSBEtCrN6v0XLqoUm20CEIpxps7zMU9VnCI+RiABEcGzxuDeAI+yiLPbYOMLoDiSTTPKYeaTICeZYU62RwdJ5od2KX0xw2VW39EMmnBfYxeA+kceulLsuX0HUlStH9PeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hRwOreP+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567KDbLs016356
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 03:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yZfoV35nThtD5WqTBfotJ6j0MKZD08wkcUk2S90deLQ=; b=hRwOreP+H1otuFHV
	My4AyvKzoici6rFM+YpqH1Uwnw3Tq2ItSiiFMSyJAaqoftWloKRIeoiFK21UuwOi
	E60e9rtFB+BbEmqorryp5/U1SGBAzJ5+I7z2DBsHuuNvRBD65DjR9l/zYDduy19o
	3BYgFrH4l8JGEMBaaRJU95Xeo71SlCTSX+clw9FzEoQmCBCjZkTahJ8K+4L+ulqW
	MlizQ/7lB5nKtmt4u6gp275npiWnHdyi6L9Kl4MwXKPXoijhL9y2+TtH29KJxYLY
	/6bz3miwbwZn1yQ9XqC0ZQPYinzs7b8quUeEsOehXO6589haFDeCE8mDLoS7grn9
	bLAE7w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvefaqnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 03:57:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b391a561225so1269114a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 20:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751947059; x=1752551859;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZfoV35nThtD5WqTBfotJ6j0MKZD08wkcUk2S90deLQ=;
        b=kMShxRXB0e3VODzDCssyof+EXKmqqwuCQ2rYXzXrnfMY5cna/JCtkedqrwz2777c8K
         suGfVabn7oNZ6gZVLX23UwSge0lVOQXt7XGxlMSW+WTK2ZRBvV79bBJu1srJrEtaRRqp
         XXTgWTaKae0tT19LkHndb+GuDcSQwO/7hqIUya9Q3ejKWjHbFxy+z8ln78Uwzj4KCJB6
         b5y3BG6OoApbUBF4PJNzmNFuDrnTTydVYNpU436vguTuTXBGaFxm9NyVAxHupBKRobVI
         tyiSB9u+B4IJEwHn2TlJOzJVfXbD2dD+8CrzVBNPwB/wxcMe1Y7xqQ/OtCfuP5DqNFuH
         HMlw==
X-Gm-Message-State: AOJu0YwAZ/Z9DHHuIcTio7QuK677p3ozJ9fdV+x7940DCrXhk/1/P5cA
	WOqITZck4pgqh1IxIM/HdHBH8FZQQErU9DP9Ma2dzS/5vbcxVlL2Zn4JonG7QjdFhQLy4MLNSj2
	lYNRhNQVT998hmWn9EduuMr7/GCeOysqGXZEQuODE2+FsGriouXGQWbvTWQYdzcP1UwZxEg==
X-Gm-Gg: ASbGnctFzQExlBtGHbCoU3KhHlEC9MO/ZbCJ041gAxS6qMfRF6slTsZedJBbaeORR7j
	D2p2AnmUM54mI/yt317k45SxRD+qo/8dnBlGt9KAtykiU/cqcZXPUllW9cOObH4WI1an3PtwQF3
	/cG7qjw9vBbPKKaHknJBFGAbZFOKJ/+PP3V955XXvwmRaBNuriqN1UPplpo1O1+shp9EAv5N1/6
	ovse4jA8c3lszF3eVgxOC5UU4j8PPzR2kw9jt5NLGzYweVAGUhBmEEiBB2mJRU4FSkOpl73EYqK
	udOeAJOwy8lfZ5+jx3yNVmeiWz5RlsARdlzvCEWl2OY8SCkoZcEpxpn7v9qAdgFO
X-Received: by 2002:a17:903:22cb:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23c874661bcmr162472235ad.6.1751947059493;
        Mon, 07 Jul 2025 20:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNFICRHa7VZvexK3NXDeEaLhBdYhMsxrimfFDSMc6Y4BPuWgjrSA1CRVsT1lg9P24SCJdd3w==
X-Received: by 2002:a17:903:22cb:b0:234:b41e:37a4 with SMTP id d9443c01a7336-23c874661bcmr162471965ad.6.1751947059035;
        Mon, 07 Jul 2025 20:57:39 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21edab71sm870043a91.43.2025.07.07.20.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 20:57:38 -0700 (PDT)
Message-ID: <4bb50d07-f2e1-42ef-66df-9f7914a3bc31@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 09:27:35 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: update unsupported bandwidth flags
 in reg rules
Content-Language: en-US
To: Amith A <quic_amitajit@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Harshitha Prem <quic_hprem@quicinc.com>
References: <20250701135902.722851-1-quic_amitajit@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250701135902.722851-1-quic_amitajit@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDAyOSBTYWx0ZWRfX2766lkHXKpf4
 Y3Y1wOZ/3zB2Zqt39LcYPauGpRYg4zAMLuXwT0w1uLM2RXnyN3tcee5z8DYzJ6LQtSgXmreL080
 6B9tWg2QkpCJd0BiM/MlFvrIMR1+JNn8J86x05n7c/x5aecg2A0TbZeDlhkR7SVPhChYYCNhAhZ
 7e+WTIOPV8OJ69yHbncnGZ8Qtk0jiADYXkcB3XS4aVaSu/CnQmQ0wd/q1TU1Bqvdz8C4jOeetVW
 +9awFsfCJCjcPGlPRe39it2I3vV97KFppfvge0dyrylQhCbSOuHbi+TDNnrk/40ZlVF7REACrmS
 CNJzA4YrHZE/+71OO+7Sgockt4cQfrhZk//U7O95F2FUbaDbYSPDe3UFOEH3xim9/qAraC+c2T3
 Spl5jDnHfU03hvHp0XmjIHjr+qO6YNJiS7wnl/RelbwwzhOg79QmN35wdvro0fBwRb9CddyP
X-Authority-Analysis: v=2.4 cv=dciA3WXe c=1 sm=1 tr=0 ts=686c9734 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=BowXkJOPuL7utAKXUaEA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5-9g08P6kVVt9kPXr50qlf-b7ZkCNuwU
X-Proofpoint-ORIG-GUID: 5-9g08P6kVVt9kPXr50qlf-b7ZkCNuwU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 mlxscore=0 mlxlogscore=921 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080029



On 7/1/2025 7:29 PM, Amith A wrote:
> From: Harshitha Prem <quic_hprem@quicinc.com>
> 
> The maximum bandwidth an interface can operate in is defined by the
> configured country. However, currently, it is able to operate in
> bandwidths greater than the allowed bandwidth. For example,
> the Central African Republic (CF) supports a maximum bandwidth of 40 MHz
> in both the 2 GHz and 5 GHz bands, but an interface is still able to
> operate in bandwidths higher than 40 MHz. This issue arises because the
> regulatory rules in the regd are not updated with these restrictions
> received from firmware on the maximum bandwidth.
> 
> Hence, update the regulatory rules with unsupported bandwidth flags based
> on the maximum bandwidth to ensure compliance with country-specific
> regulations.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
> Signed-off-by: Amith A <quic_amitajit@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

