Return-Path: <linux-wireless+bounces-24580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66708AEAA4F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3345680FA
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874982264D0;
	Thu, 26 Jun 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jb6U9TMX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E9F226177
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979719; cv=none; b=FpyJye++wFrNoI1LjhpF97U941P/OaI7eKYcN5qRC9G2Jr58ffw5dv8+KwlbscY9ZxLmGiFK8boxOWRcf33L38+JtXOfe7cfN8PfNSAGuNj2HTZx//HHOTcP6rcyIwfoYR9sQOtpA8bGXjOQwkHt5dwncmwVtDdVvOY+UI+9RE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979719; c=relaxed/simple;
	bh=aveueRTbQdMdrNGSej3joup9HDcIGAK8ibNMHhk22ow=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kYz9OkJ9SBytTbrNlA6NGMypBJ3Cd6FNyfoGYe9chNk8umep+6sQraEZ38PSBt45yF1rIyl1eStTh0TWW6+AWsTpBu2jQZLC//Li4ra7iGiiieqKNM6TTLba9YE6RejIZD8vR6DuwZjn4Io7zjOiu1ONoeaWoGTJwRUZFdEERFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jb6U9TMX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QJ4qFs029535
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QNf6psQuaYs1sV2z+eOJEJrYUuj36k6T3cjWzvS/EFE=; b=jb6U9TMXB/Q497gK
	Bvw5kweEaXJVciSI5cJvzQb/BbH0h0Xv3YQY3O1jEHHBUbp5wr5GZ++hoeISz9bn
	EeMf3iWV1T+Pd0/YstoItKt/meYED6KT6EPFFkWAFhuelQ8XU1RPvFryh9AYk6uc
	xb4TMSHn6fIoOYZTn1qUSmmbDEGc2TmcRpLDKZyai2COAwANKcs+YpCer4gTKzOu
	UMB0cuUk3ajzFe58oy0P/m0BCYfebuSdO/k7a4Vi5RuY5+3CqWbhVo/LUxXHiiuw
	356jThXVgYow9WtEivIToWvLDwOCdwyphdzK8WiFfKCinbGc22NJ8Q637AEX4ZIu
	mcuM4Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4x3nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2369dd58602so11741945ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979715; x=1751584515;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNf6psQuaYs1sV2z+eOJEJrYUuj36k6T3cjWzvS/EFE=;
        b=GaDI+cyo1eN24tZ0B7f6ICkivY+ihquEseC17l8Z50a8uvw32pD986O42wW50n0MJa
         iZoj0XbJnuf4uv1jIJDC4TmuTdmwMiFZ8L5Xi5aJcIFbw3IfjVGsbouCcGuqQWeLUh0j
         V3wecCtiSCpFDqT0L5B3l1YTD/6HydI3hE4FYj5ThlnPsVCQCZdPq+AuHcj1A0BVExt0
         L25g80jr43ebGd080hjzc178VtMpzz3uOrzdyv008Twt9hU8wyuY3HHwxIZTCtrBqnvI
         AGv03YgCu1SIo1FCHLmjz2PzyAxrCTr0APwxSIce1HsotxIawQvQ9ZCzOmt3tT1voLUU
         BE9A==
X-Gm-Message-State: AOJu0YxJx7bh7nSUyj4Sl98+NXMC2AoGPUMYkMWUF/XPq4ZV9LIi0sWY
	4AWQSeFVHixvNzHFvsFKTHgQo0R2kuSUh0lpklxuU09RgP0Zkdo0TVfNzAWGJYKUdtbhEc1+Uke
	+rcAqjzo4zelcMYPAyybDV+zoPD0xyK2lEMlQ7onBl/yy8D/01jkPv+trG6rdhBnryum6EA==
X-Gm-Gg: ASbGncvx7KX8973sNfFbibFDL14rLH9ANwTyZAW5J7w76ClKhBDcovFvrLqn+vfvGji
	XVy1MgXZj0poXyFgXb/bm+qNKAoHSQh8fVqyggylK19448fQkx8x5PL8GT63bxTJ8zoxMzOGs5P
	ljSSwG0vFF/5vxLR+lqleZL71SXbre/uArXc7/gjvkL6B263/LicGy8r3g06rDLrFmEhWOenK7h
	naHNn4yPK2z8pmOFW8AG77c+GXPg6jI5QubmhWeNcXuOA/yM+r6izC1G0hKBe2J5PHYc3lBiqy0
	mY8uG+NRpVeVMUCxG9pnrGZsZY7j+vMVOhfQpPVEHxAwF+DzA5d+Bp33npc=
X-Received: by 2002:a17:903:2c5:b0:234:bca7:2920 with SMTP id d9443c01a7336-23ac45e262dmr20098925ad.24.1750979715408;
        Thu, 26 Jun 2025 16:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3UyoHUikHjCEajXKJptSGnRA5N5qfhMM6/xXUltul0UA71goc5dUnQg2TIU9Lxbb/GwXUeQ==
X-Received: by 2002:a17:903:2c5:b0:234:bca7:2920 with SMTP id d9443c01a7336-23ac45e262dmr20098145ad.24.1750979714949;
        Thu, 26 Jun 2025 16:15:14 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:14 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <20250623-support_real_noise_floor-v2-0-974bbafa317e@oss.qualcomm.com>
References: <20250623-support_real_noise_floor-v2-0-974bbafa317e@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: use real noise floor
 value
Message-Id: <175097971429.153431.7513339241294145921.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685dd484 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=-iIeHy2jdy7NZ5vI0E0A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: qpTB65F44mKzwfB8olnYmTJlyFdyulyt
X-Proofpoint-ORIG-GUID: qpTB65F44mKzwfB8olnYmTJlyFdyulyt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE5OSBTYWx0ZWRfX+JEFjJvUPfNf
 4bv8f7rW1eG8hjC3MUhUJW0n00ygdqVQGhI9heiAv4FNcBPJ32NzZQielgmrL0RPeq5qTctDXoS
 2cJvW83YEKzc67fI72VxpkYZkGWGEbbcv7D/6LEGl4cVBvEkrMhqN+gAeHpYtkmFkqLIZ3SXYje
 Mm7F0N/Xsq9zbnWbov31jbKrdFiSPm0GyVEf2+lCaPv2pA0OIZWH9tW9FoabmGvIDgXCA/iebpp
 BK4YavRP+G87LGS0A4nape7pbgfo9BPAABYGjDFwpxCWPcOpDqEMyLqhmCiHleti0EM72i4Fal4
 5c84zt/J8ZlkoN+76VuDW3m+k1jFqlHnamYzTAQr6HD3vWAtSZG8fDzb7G+RaSnLPvIKn/I8wc7
 5GRNFw1QnI7TwBY5Nc+2ax55APuNGJZf/NWbGjdwC9z6qRoXqvrwUmbMD9QVY6TRXb/q7w2p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260199


On Mon, 23 Jun 2025 21:19:08 +0530, Aditya Kumar Singh wrote:
> At present, the ATH12K_DEFAULT_NOISE_FLOOR (-95) is used to calculate RSSI
> value, providing an estimated noise floor value. Consequently, the RSSI
> value is also approximate. This works but however, using actual noise floor
> value will enable the reporting of the true RSSI value.
> 
> The firmware possesses the necessary data to determine the actual noise
> floor. This data is provided to the host via the WMI event
> WMI_PDEV_RSSI_DBM_CONVERSION_PARAMS_INFO_EVENTID, which includes the
> runtime parameters needed for calculating the real noise floor in dBm. This
> event is triggered by the firmware during channel changes, temperature
> offset adjustments, and hardware chainmask modifications.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: handle WMI event for real noise floor calculation
      commit: 0314ee81a91d22366e8ec6f5a993d75b246cbea8
[2/2] wifi: ath12k: use real noise floor instead of default value
      commit: 662e9032140fd92662142d4bf394916cf48e426f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


