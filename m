Return-Path: <linux-wireless+bounces-24887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44D4AFBE48
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 00:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933E218902F0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 22:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD649274B5F;
	Mon,  7 Jul 2025 22:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dAH8uzZo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02087221FAE
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927785; cv=none; b=EppCW0trnyjBHMfRqoh27+VUxcaXAqGzoGfjUtmVmagC/lwvRYrAnKOzIFeciNBB3jt3I+bsc6LNWJBj0goBNHUXw+mce/Isy0ayQo5em8RImALulVMJYkjZPQChFZNjzkQvcWFdWig8txUJ1pIXqXYFAPhOnd1kAB+3JQCjFmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927785; c=relaxed/simple;
	bh=MIuthvYTx8uH4Kc7xYvAqoaDGc+tz80q76HGIVuUgHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DtgChiAyaWmUOPTELBAI2sBoGCKo+tl+8Kn1oYvuS/MuHvRcfu7R2eMWr9DRSXr1EPyHz8vsUdlzmLBzKT0Aqf+/1SiWA65jlgKaIJb5ydMYLKsrOWEpytzlJlXbOWXEDSviCoUUPJO9lnQYjg44mApQyrllCSHNQ5BUdFJd1t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dAH8uzZo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567Iswqx023870
	for <linux-wireless@vger.kernel.org>; Mon, 7 Jul 2025 22:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9kObBHOTy4GemSrwADqjuQYpPPym9U0e2cueEvewwqA=; b=dAH8uzZoSsbI5yBM
	li4RLnOkYtr0PyMckS7IACh6Y+ygocCtb/zaRBCXSBhA7mU0Yeomt0knFEJhzp9C
	v+3HpSavpoIRRWjhq8QBWvJXP0FemWlCTiDS2cKcqFD5KJ4zlRGTpphrgAUur+Up
	30+sbE7W2SYXHQky0PRtQx5pwbAHeeKOSb5jiQLCg0L9FbZ5jUrwYD+k7qCqTA4u
	bZ8quy9D6P8oKR16RY0GoqEXRObmeMWZB5RaMKEYCRmfRMqeIWPoQR0UAycRzf75
	/5aL0E03xcplKkbgZONE8Ty5AE53gPKso4cp46B12hbsrqOYRANb1JQe4rFsT3Yw
	oi0XbQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pv97gpyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 22:36:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2356ce66d7cso57856445ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Jul 2025 15:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751927782; x=1752532582;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9kObBHOTy4GemSrwADqjuQYpPPym9U0e2cueEvewwqA=;
        b=p8w96hkLYTD3kgbQAyzEaw7Cv0HvPOfEe247EOgPnqx1h1zWJP595L++CCdu+90Ydq
         Si9EJY2D0nDQp+qj6WarcG4SpK4YI2AExhFh8cV2e+zEWQDUiGgxCQqOt+Ky5B5Tm8zZ
         tJhQMVvzwkluBMT5bXJkFkVPhw7wNkDHZZCgLXjnwbYWbQWZOhxhnooVAxlCgne+zphm
         GFrjhvlBf50ru7f5izye2p1nfYMneCvBMHefRxuPOy0rxNZDk/bsQfWqbuAog6/OQb7S
         nwxPSVGVXXXyI1IO0OV08fwnI8uULyr8QKwOXEHiiqGil0dJvIORjnTugPnFBsEYRr3Y
         m9Fw==
X-Gm-Message-State: AOJu0YwzAk/g4n9aR0V3F2RCW77tkA0hQ+ptKCyLYjaohmBSWGCkgORb
	VXRG8a9T3SUfQgN899l7g4uYNr+eD399n1C+SpJ9qzsxhpw2tPeEvZpqp4fZLJkxbUYdzJ2gSOF
	QFcR9T0cnwLChH9kLSkqqj5kV63pQbTgvSHuhYXbrvLqxftAb5Z2yII+zsLuK21C9RpKRLVtpyU
	P3gw==
X-Gm-Gg: ASbGnct6lWamW9fSvCFjnYLGNJEYfVG/B6P0ZAVFoM9j9tCAU3SmluoTSGNjeUkDfGH
	pr9ylpxAFtJLN39u3ogXVlH3C09H2jhSkv7hZXP5gREd0ZzNq7GsDjxbHoqWpuRbBBrqc5OgrVL
	ZL9jNoNVMiEKTwcqF0SsL68z86uqXWSJhHpab1sSvEVin5+w0qV82+KHyScnItF+thvcISahrcR
	HiqcAbezcSDadCohmoWEsjpeMcTs1kF30esgOzCkbMJTGjTN0Wum+DRN+4JSW5NyyIOxxwpcKDy
	AqwxRRPIlD1Dyk2aYCTr0vKr4SAfHqd5tH7yyySociFWlfqPvEi8ECmyYz4=
X-Received: by 2002:a17:903:2343:b0:235:f45f:ed55 with SMTP id d9443c01a7336-23c87470019mr251805925ad.1.1751927781857;
        Mon, 07 Jul 2025 15:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW1Bef0ceUwQpnhYjXdX6dtTGeppIizcEogBC6WZz0uiIFGUyIDjkxNhouugTUww4w3XZDJg==
X-Received: by 2002:a17:903:2343:b0:235:f45f:ed55 with SMTP id d9443c01a7336-23c87470019mr251805535ad.1.1751927781443;
        Mon, 07 Jul 2025 15:36:21 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee6358edsm9668064a12.58.2025.07.07.15.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:36:21 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250701105927.803342-1-quic_sarishar@quicinc.com>
References: <20250701105927.803342-1-quic_sarishar@quicinc.com>
Subject: Re: [PATCH ath-next v8 0/5] wifi: ath12k: add support to fill link
 statistics of multi-link station
Message-Id: <175192778075.314276.9132568715963228413.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Jul 2025 15:36:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=FrUF/3rq c=1 sm=1 tr=0 ts=686c4be7 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=zQT3B7j2P7N7IL7r6JwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE1NSBTYWx0ZWRfXzFwIt883qK7R
 YOujJ2Kg+Gk8U5V3rG0FSVOThZNYp417K0Qlpaa7CNjmL0xJD8rWcYjOu/9KrT/VsaRNIYLi5/X
 UHSEit938lTfDQiteEeXQ/FoMmHOdQQlD2xdRwIw+qtaDApng1BsObEQF0Wf8Mmyxd/tJqc4dMM
 OqbaeXvUzowu3ywgC2gmYFnf7iPqGAkd+L9Qxo0mhIh/71MDuk/gw/UWJ0GIZob4Y1NFjF2Aev7
 04qtcAa1jDvjtlmWvZlotxj8SNP7sJRMDpsl2OES34WIr73lFsE/JjzYE9kImLvV5yiHwaxEvym
 xb1e17x1T1rvaGxfbS9HoOA1qUOclURUZKsV0UQpjlSUKTpASqluVlmxn9Myw2eb+Mg2iuJK0V2
 m4DCTpY5e+WAGM+v6VjJc+fCzjsyv2v0Iv5G4bxPu5KY1a5bm6ucBavj2MYdSQCgoQz9ZHDV
X-Proofpoint-GUID: r4kRJi2QbEYeDXoaBgs_VPS82EzreGbp
X-Proofpoint-ORIG-GUID: r4kRJi2QbEYeDXoaBgs_VPS82EzreGbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxlogscore=796 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070155


On Tue, 01 Jul 2025 16:29:22 +0530, Sarika Sharma wrote:
> Currently, station statistics are filled at deflink for both non-ML and
> multi-link(ML) station.
> 
> Hence, add support to fill station statistics for the corresponding
> link of station.
> 
> V8:
>  - Remove unnecessary initialization of bool is_ofdma.
> 
> [...]

Applied, thanks!

[1/5] wifi: ath12k: fill link station statistics for MLO
      commit: ebebe66ec208d37e3368b91e2033907cb5140821
[2/5] wifi: ath12k: add link support for multi-link in arsta
      commit: 3b8aa249d0fce93590888a6ed3d22b458091ecb9
[3/5] wifi: ath12k: add EHT support for TX rate
      commit: ebde0514b4f4e78b5f9629179ca947d98b77da15
[4/5] wifi: ath12k: correctly update bw for ofdma packets
      commit: e0618fca1af294f2e52ec3545d76ee5d937c177e
[5/5] wifi: ath12k: fetch tx_retry and tx_failed from htt_ppdu_stats_user_cmpltn_common_tlv
      commit: a0b963e1da5bff03a43c87b96ae3c0ed78a11960

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


