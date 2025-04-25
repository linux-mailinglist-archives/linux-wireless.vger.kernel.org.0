Return-Path: <linux-wireless+bounces-22072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0CC9A9CD8D
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 17:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2B34C8912
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA3728F928;
	Fri, 25 Apr 2025 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfrZc44p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9098928FFD1
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745596014; cv=none; b=oStfo29IDtjqbXiYGhWjKO7fMnabRHtcwnBGxAr7l3Qal1JMaA1mNbSSQGCFcnZKGeVKSfNOuLUskFxpdhBJt02vHXCz7G8Vpyrq8I+tYG26lsvA/cL1T16IfbhDWWrXwiA+G56S4jMT1zaaktxiQhtbhXu27JSmy3E83Aq6GMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745596014; c=relaxed/simple;
	bh=Kk/JlG5jK1EN/Ao+o/0ULLsaxO+jagFbOPk3W6GsDCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3L3TS43FITzBOIm5DdhOUgxNLvCkAnW+U5TJMSQM7UwlmaJo3CosUD5e2HFxYvDtOQmEhY5GC0n/AVVcfNVkWOahhWN18O++rdJm0CrqLHrkwHbMPYKnDXxSGK21RjtkFtx8yye0k8bCCG6NgFmo9jl9wzr0dNdzcKE5YXdchw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TfrZc44p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8TASl007408
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 15:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kk/JlG5jK1EN/Ao+o/0ULLsaxO+jagFbOPk3W6GsDCk=; b=TfrZc44pQ5qia/Do
	aGcsbnHL0gciuxVT/D+zs4PbbtkzCldNl9EQ+03eXtj+GFKrDPZoNzgwzsPO8Kag
	FO21Kac7urCU+S1AFRTzc0NR5q9Rb+wFGfXGPcO78f17XwBEuYWe5hsCTapnq3O0
	inZOddQd62ab1ZZJaYOJTbXUUnGmHHHM/+DimDTGt0FD/88w1zX1Ce3lUD74NeUa
	bECn2csNCybKOMzB+UX9rom5GldCjErxskAyDw75T1hezvYs2cE90TIbsLSI7971
	eaNiu25D3oYk6VMHLU6JzZ569DvIToSdTIcWGruI+NMthQs+EGvMxSZbZ8edY3Qb
	DmVBUw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0sfh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 15:46:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-227ea16b03dso36983355ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 08:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745596009; x=1746200809;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kk/JlG5jK1EN/Ao+o/0ULLsaxO+jagFbOPk3W6GsDCk=;
        b=lkU8lQ5ypDm7RpKvMn5g/GzQ+j39AMz3c9/Z3HklzdZEG+Y+10z542G7UZpvENqZFV
         N+l8b2hoHqwl7qp7Wx4xd4utTgHOA0LCb06JAFAlnV1Vhb9ShRNE9Tx1rm1kAEhGW5By
         kFjTpV55b9GCr836rO5ceG7XSj0TeY55oEvVrCc7hkRnc/dHoRWWCu7JWBJRwwXoSLB6
         4FHOoeq5D3GmJyoU6ZxcpxHIWQ0q4HI3QPq7fkZ78UposIAHFq9dtFt0+48xwp/5ptSs
         zLivl7xiA9CdHHFf6W7xOUoBXRNFySjhrP29/MxukHvPh2+Z2gt5g32RrmBcUN1oVA3Q
         9M8Q==
X-Gm-Message-State: AOJu0YxKOm8OFfloDOWoUwbO2fo4WLJDNUnrF9m8kUVYgZ700dJ+35fN
	76z7juA/ON+ePG27j2nau6Yhq34SjegkxoCTdCa8Ge1Xx0LyEwLuedqlGasMDW3Eqf3Yza5Ubez
	iAALTyJKkLXn9zViz46btaYyz6q8WKXn6lvikFfuzTG0VXVplIV6Ecmx6OUweMId6ow==
X-Gm-Gg: ASbGncv30SPUUOil10jpeFMZockzkFQrklCcPtDcd8gWT5wmELPrsaOg8qiAu4BFo47
	5Mfi5bJOC0uCUONzn1N4Ozaw691Zayn3ku9p7XJx5UvRnY0sj+3LDTMq62yJjodIovlChsFyTV/
	1GVj1rm7jrFUyyd+ZiaQXOoAp8k54rz4ancuhv8Ku9j9QduRrQa2sK6dYK0Xq9dSiPg/UP/6Iy8
	0e/G+noekwYW04kYpJ1ZFQLZHHXfAxISi+GRANR+nNraceSrws2DpErnxW1XaZVqMABKBoYuBrl
	UPe70PAmyR8Kcg4ahM4ON7HHW0SBEv3Z2wpXBmoLpv+B3b7dBWYllrTFxl2sF0hl9+OsM1RUuM3
	m0y4w
X-Received: by 2002:a17:903:1aaf:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22dc6a8711cmr858955ad.43.1745596009599;
        Fri, 25 Apr 2025 08:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvHmjNZLntoV8XvGNqIzwDqg8ckNcjVlQeBE1UeRmXlBYhTEON7wSJfvzdebdxlvn8XtjCuQ==
X-Received: by 2002:a17:903:1aaf:b0:224:5a8:ba29 with SMTP id d9443c01a7336-22dc6a8711cmr858595ad.43.1745596009180;
        Fri, 25 Apr 2025 08:46:49 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbe4desm33943545ad.70.2025.04.25.08.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:46:48 -0700 (PDT)
Message-ID: <07c00e98-5280-4563-854f-5c7a457578d0@oss.qualcomm.com>
Date: Fri, 25 Apr 2025 08:46:47 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 00/11] wifi: cfg80211/mac80211: add
 support to handle per link statistics of multi-link station
To: Sarika Sharma <quic_sarishar@quicinc.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nnF9F20noKbcfjFOfYmcHUBHOmOE5jTm
X-Authority-Analysis: v=2.4 cv=ftfcZE4f c=1 sm=1 tr=0 ts=680bae6b cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=WqueRgLFPjDBw-PMjR8A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: nnF9F20noKbcfjFOfYmcHUBHOmOE5jTm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExMiBTYWx0ZWRfXzTqpcijEUjUf ueF6Oh7BJR4toWCvLCmicavgF06QiXdBtP3+I2WDQ5+GLyHUcHd4iIn4/YgeSdIq3HD/SO4ZwIW zKj4gXrox9JiAK48dacI6tbCbkgW7GPNKwWoCayVf1u7uKStwSZR6EfQrM/QWYm+Ir26l1qIeEr
 Ef4PAyjoG5zUgjTChxeanwnpRdwesQeo6EClNTqnaoxROADtJlPkAdXrPHnew8zbCcAN6sfczB+ 8xhMKq+6gx87qjCnMQgCGDSOgmIeh93LUYA1CW0MhzRP/coinVJMZHxyRRwU0SXtkA8Q04qxmtP uMPrLbWZ15yVatF4jZU3sNmuNutZKqeHWpAzXIBAXRwDaHW/WMpwK7FpS1ZG0vzmYm7XZTPGucn
 iUwFs1zz2qE1pIXByrSU8ZALDoG5lLBIQlVQgZpCMU8+NZpvWPVc2HScVxMZERl4yjM6BwdQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=660 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250112

Just a couple of generic points:

The last ath/ath-next pull request was processed. You need to rebase since
this series no longer applies cleanly to wireless-next/main.

When you post v7, please include all parties affected by this series, either
by using scripts/get_maintainer.pl or by using b4. There are a multitude of
driver-specific lists and maintainers have not been directly notified of this
series.

Since ath/ath-next matches wireless-next/main, and since this series has
co-dependent changes, I am freezing ath/ath-next. I'll continue to accumulate
patches in ath/pending.

My hope is that all of the issues in this series can be resolved, and that
Johannes will be able to apply the entire series to wireless-next/main. After
that, I'll fast-forward ath/ath-next to pick up the changes, and then I'll
start applying the accumulated ath/pending patches.

But I'll only hold off for a couple of weeks since I want to issue another
pull request in time for the v6.16 merge window.

/jeff

