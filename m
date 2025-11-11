Return-Path: <linux-wireless+bounces-28853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EDCC4ED24
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 16:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A573B9EDF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B513935F8A7;
	Tue, 11 Nov 2025 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dywgi1ab";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WpFtP+dL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269AD336EF2
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875454; cv=none; b=T0KWN74YPqiDfjkGsGy5UQl5ypo8MpPwTf60lAGP28VJfrTgpxQMHnPuuqLDxxXuYqtyg8LHhRtCX1ehmnnvnUipWXt3wqxT9dg6EGg5aOZSPZhEfgke3vs/dOZ26quqcUNhOPt3pyLSrqjx+b3BhlfRIIxhupF0q+ViBjIpcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875454; c=relaxed/simple;
	bh=4yvh+Zm4v3t5u0rHGqHb1pMSYwXkCR1d8mJIthkI/J4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UhHTBm/pKhyqCTTPoSdvD1Ax2KU8kr5561UoMVwhUuxYZ4XZJ5nGZizzlJJF5HZRlm2pKglrJJUHrAjdMk7yI1E5HF2MDD6jmGaGRgbHfhPHvq+s9Nk313UUrL8JR7Aqddvxg4J5fJALBbAHS5zYdcdLt0y/ngeZhAmmIer6U0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dywgi1ab; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WpFtP+dL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGCqb2250220
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ccMn/uxx/7Gnd3fRnQtGKZrpth+oZobA2BDssVkaPAs=; b=Dywgi1abHKbVlgS1
	hwV7g78eJRd3rwtw7bZr9EmCypYFj3FMWbT5t7rydYBqHG488s+VjnRu6O0n1E6T
	8hKk1foeREzz/iA1ZYZqU3GZD2F2zvJnFVVlx9BjCsx5pTfdDh49Q6X7CJB8hAK9
	u/zHfhAC7M0MlxncPI3fXw/g3v1vvICA5oYDe+TID/L6rMl/bx0ySAT7B+sqXhdF
	NxcYohjebzMsVMsmoA3wtR6upn/duWrBYfG0KB58wlKUZ/k+39nLEgd0PUN9UMXF
	D0vHRIw1SC3rJd/52FO8RozYU4zKTY/eqqJv9etoPZ/UyNFPYihQNkuK1FsFifKW
	TI/oxw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxxu9qj2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 15:37:31 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297f8a2ba9eso84491725ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 07:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762875451; x=1763480251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccMn/uxx/7Gnd3fRnQtGKZrpth+oZobA2BDssVkaPAs=;
        b=WpFtP+dLf8/Rhuprm+P+DSafcw1+yOZg1TH0K9s8AnoCBFbFTLCvWKh3fT5YnGdao5
         0/SaTaeaJ2K1TF3I9AaOwrgD8joTR3uE4hAi6uPgxnuJ4f6ZjIrB1FlQpTc4dk/r1isS
         S7iCtQ0Ey1axaJYzzl1dZagMLQj5uMLPRSGv9ph16rk2px7jx8eh4xHV7OX0EaHvRvWN
         N0XKCVllRBgsWZkU239+yumc6PfXynh2J9IbGEBbY5kfYf2ahF4PhLTYNBBj+jaPj0cW
         iNUhhz2r8hk+4yvBS0HRsrOTIlVZ6X+IqIx293z22sLicf80Yyu/RN+morddre4/GsBD
         sw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762875451; x=1763480251;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ccMn/uxx/7Gnd3fRnQtGKZrpth+oZobA2BDssVkaPAs=;
        b=a+A1Sr74xErv7Xydr/bxxZOx6XC906FvfKR10m3vY+a3sxQq9qP9VDrUz4OYK/eFkq
         Fn8HYhI++UCDggvl8xphmYrmG+lECxA8Q55rPcrOTUV9H56Poh0/tHCt4iYGtrOClb7R
         PDD9+PP+ch9DV0e//9+10Pf+bKLsh3RMpBR65imidfSieAVzL5Ebhx/dZENztcrywtcz
         gZl4ZeueiCVzxPGv+KKWqyxLnIwBS5dGm01YIvRbUakQwJMfLJsKLJZFckwaLtfvCGjX
         0JPOSjql5hLWR/tCxLc8BwYhgC0MzegwrMe0CIo+YMlS2UDFJCvtJvLSEt2H+O8xRZkQ
         ViSg==
X-Gm-Message-State: AOJu0YzzrT8EoYLHscj0EihB8M82k2gXCcgqjdgpGgLDnAHglebPEOS+
	w6x/y1Hw+0iax4Lbon7vAftFWiGwrZVRAEn6X+OM0ZI+oWrVw6MnmjQQAzxNpfHp345KRDw4nEd
	gISJbHzc+1yMfWGcDgaiJM4Zfv0EvK4q4Zfe07ULQt/ip8uW7R2+uZzMxI5QwkUuMVsPVdih0t1
	hpqQ==
X-Gm-Gg: ASbGncu52HXi+7dYCnCI/0v6+ppLjBDJD/GOKmC8ZpC6+YWtTmhb3GWNf7wfrZGb9JM
	JFAJzHm17ntro0W/8fTnikcZBKRETG5+r3HuSdlY7FO8qtnTBU5X3zBOYmKad4X2A6l3of2TsaF
	mHi8qwZ/Q3P0QrlAKcb8I7KVb5BAHYL67oT0QJMFZWxaNaLm+He36GQSbOAx0ssFm85YyefY1YS
	4rnjsyk7zvmJ8VE8y0RtdqTYUhhBNEY1mNPXtKgcSV1nj/ZJHzglOtj3E4AWzC27NNxKFxmX7b3
	2FGhr5kBQHmLCSi/7loz+7zZRodFJfAOZG6Vu4VCE41jcKCYPTvQPn8NUM8WJiGHa9iemGtHue5
	4TrZUyVs2lHO0Ru3ZuGX6aYpyUqYQQ1VmD0w=
X-Received: by 2002:a17:902:f684:b0:295:9b73:b156 with SMTP id d9443c01a7336-297e56e14a6mr164159315ad.51.1762875450738;
        Tue, 11 Nov 2025 07:37:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRLbT7WM3l5I4OW95pwfUPqD6B7NrLd/aslTSX+CtzBOfFScCDCImSTH1OzHPnRWDmHaTB9g==
X-Received: by 2002:a17:902:f684:b0:295:9b73:b156 with SMTP id d9443c01a7336-297e56e14a6mr164158865ad.51.1762875450112;
        Tue, 11 Nov 2025 07:37:30 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba90307193fsm15950789a12.38.2025.11.11.07.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:37:29 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Alok Singh <quic_aloksing@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Subject: Re: [PATCH ath12k-ng 00/12] wifi: ath12k: Remove the Wi-Fi 7
 header inclusions in common code
Message-Id: <176287544947.356397.15668073680405341294.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 07:37:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEyNiBTYWx0ZWRfX2qiPywqB3f1C
 hqj5Nki6GelW8lNFlpy/9Lkj/NVumP/ROqWWavi05u8hVa6+8HwQBUsg8VlCvnbDynefLHUoUrB
 iKzvSItaALP5trI+thwn8/6C9XnksaVEeiPQ3Zj9kHSXIIuHqlNdV+zflAVw2P6c4MhTtHqdrNG
 v2kRseuohkdg4ewsHhosN7PGF6e3ozA+eC+aduFEs4VAuZUpQ5HcbHffqYPxGI0JyRZpdbBuXuP
 RN2WruOOUhw6NLwwjKZkkD/yqn+v0xBG/AkbKeKAIoNH9TzGWIuW6y6wuXBlgm6N+LXnaVkEsnh
 hIC6QQGgdQ1xrUNlErGR4CrP9lSSmWJeza0vEox9PCaDk+DjpaF81ljaX03RGEOzH6y1m9er2jG
 nZXUFDm8GTvzK3VYLDT5ID9UM1gW/w==
X-Proofpoint-GUID: x71O42UbKFN4SBNh943yrtjmVWGY9z_B
X-Proofpoint-ORIG-GUID: x71O42UbKFN4SBNh943yrtjmVWGY9z_B
X-Authority-Analysis: v=2.4 cv=TfObdBQh c=1 sm=1 tr=0 ts=6913583c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rApeeKJKgo9SdP4gWbgA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110126


On Mon, 10 Nov 2025 16:07:01 +0530, Alok Singh wrote:
> Idea here is to Remove the Wi-Fi 7 header inclusions in common code
> As a precursor to the movement of Wi-Fi 7 specific .c files to
> ath12k_wifi7.ko module, Remove all Wi-Fi 7 header inclusions (`wifi7/*.h`)
> from the common `drivers/net/wireless/ath/ath12k/dp_mon.c`.
> The common monitor functions now compile solely against the core
> ath12k headers and remain part of the `ath12k.ko` module.
> Move Wi-Fi 7 specific monitor implementations to a new
> `drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c`.
> This file is built into the `ath12k_wifi7.ko` module.
> 
> [...]

Applied, thanks!

[01/12] wifi: ath12k: Move monitor ring processing to Wi-Fi 7 module
        commit: 24b21a9be2c999b51aaec50ede4b2ca1dffb0ebd
[02/12] wifi: ath12k: Move monitor status processing to Wi-Fi 7 module
        commit: e00164657ce8a347a24d49a4aa4dd96aaf50a580
[03/12] wifi: ath12k: Move MPDU pop functionality to Wi-Fi 7 module
        commit: 906b5ac9c2b5dd2512a515b0c74a6905973fba04
[04/12] wifi: ath12k: Move RX status TLV parsing to Wi-Fi 7 module
        commit: e475119ba2510c66138261d72d797e63c73eea02
[05/12] wifi: ath12k: Move TX monitor functionality to Wi-Fi 7 module
        commit: 52758ff7b50a7d8b06d23c7f2a42ae85b559f682
[06/12] wifi: ath12k: Move HT/VHT SIG processing to Wi-Fi 7 module
        commit: f4bcbaebf4112c8f6320e208b67b2281dad5d5e1
[07/12] wifi: ath12k: Move HE SIG processing to Wi-Fi 7 module
        commit: dde5748c2940b4b47bba9c42e086a90fbe43b5ea
[08/12] wifi: ath12k: Move EHT SIG processing to Wi-Fi 7 module
        commit: 00b67b7c44b47b6ace2291e903d21ea7b6261179
[09/12] wifi: ath12k: Move remaining SIG TLV parsing to Wi-Fi 7 module
        commit: e5419861e4155ae32d739308e713f7bf6663d632
[10/12] wifi: ath12k: Move MU user processing to Wi-Fi 7 module
        commit: 5db19c48841397c5b5732a1aeb81fc6cdcdfc5c2
[11/12] wifi: ath12k: Move MSDU END TLV processing to Wi-Fi 7 module
        commit: 965aea91545a03cc14439ebe57519497925f5ad4
[12/12] wifi: ath12k: Remove Wi-Fi 7 header dependencies from common ath12k module
        commit: 7cd7392a07782b8ad4aa6360e4be1967af2eab04

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


