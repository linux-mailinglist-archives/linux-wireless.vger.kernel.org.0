Return-Path: <linux-wireless+bounces-23314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B078BAC113B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E7F1753DF
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D2F9DA;
	Thu, 22 May 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jvq9q66R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA52951C0
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931842; cv=none; b=Avgf9RpFYfeiw1zVRgPkMGs1HeAXm9Ouyner+Zs2a5ioZdHD2xuKlxZ0HSFPHk2CdHb/g3ODsC+c78tdQq+m0lxo/OKIze4KgMUP5A7dehCshH/8PdOzRTCYs28rDsN3/x4rnFE0IoJzCEUEHDfBRj2O3cAr1O7gSN9WFk03xH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931842; c=relaxed/simple;
	bh=pPXSpIv7YTXq4UKK33NocN3UXDChQ1jQOWq2fHTsrgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T37v+L66ni2pXBd4VASUw7DX927jUxYPvFer0hLI33T9RBAC9o6v66hXXlXxfNiW9CAcGqVEW7zMI/UmcOPCqFDp34SaWmM/6ZoHy01l2gSY5iSG87/0BIS3Uzt9CPepnc3/S75K7fPV2+owinFxBY+uQTo5CCzqsjxzhXMQ+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jvq9q66R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54MFfxes032698
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 16:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pPXSpIv7YTXq4UKK33NocN3UXDChQ1jQOWq2fHTsrgM=; b=Jvq9q66RUo67qC07
	ryS+1o8dC2/ro8o4vZhiN73oSBTg1pgKYE5kek6/SmVMrvraQFxp7GBL1IgLG7XQ
	j+eEkbGPZ/bZG365cbzzjH7SSMlMOEzVtNm/NAspuqTlyIB1DZQz5Iu5fUllbN/8
	VFDKUKCE4r7IyEONZmnVdGYZsPYtCIAuWmXmF/I1y0rVCi3s5l7rxcxBfRHdGqRF
	h6xBrEc/ZUavPEeiycaqUth3JivHIJy4S8gy6AkFYHNNMJsBMUIyUu58Nkcx6a1q
	0MC5TIhj9+UjmhPlakA7Sji9KAB+knogICidNlQDrxIxDGsQ/ldi6ZydNsymt0bJ
	4lgm5w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c25nqu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 16:37:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742951722b3so7046786b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 09:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747931838; x=1748536638;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPXSpIv7YTXq4UKK33NocN3UXDChQ1jQOWq2fHTsrgM=;
        b=LtCuZMX+J8UPEpr9b5VwuNHcfXRf3LZtsOZCpsfGjLHz301AkjeIFXkyTcIr3/fVNn
         5tJrgH9bTbnZ8tZBP2UXriI9XKNSrIWZhiiRrZkfNWZYPZ/OC3oK/+X/3Ga68JCcE6tU
         u9VrGQPx9WXxP9X64+YKSE+YxoiT9FNBhgS4Khk31q83y2X7VtjfHXM6We4BZrOpW84n
         4WKejT1CRlO39aWOr/do8RnEJLmwKrpAtuHWu5x174eFV/E51GyUhSN3kGWWucsAA/nH
         MBQ2t592H37/B7IJwO4KbGoTiM1IWYokjhAfNfjxcxXUl8TgNALg65xDG+Sr5byutafU
         Jdnw==
X-Forwarded-Encrypted: i=1; AJvYcCUNrIGeqDVyX9F0DgJvR/G9345sgcSNI6dvFGcSXSdDSpindPW0JN1IVtl9xA0pOuQXHHmxzHnXVDUDxKvktg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWx5HXKXBdyKR0xgoRYOkO5UKU7N5nNp/C8ngWOV/F+FRyOJz
	MiGIC/FmSf69I58aZM3kYILtTVhuUQlvFVUtYX045gnUWYGp+B8FIfCGBrucBT9eN9NYQ0tbr92
	0nvcCXN9LnXW9Q0ZSJ8jzX9xGMbLeLu4R6DvqPd3kKdaYoPROe6FkONuqvXaPAoUEKPJnKo4t05
	IDdQ==
X-Gm-Gg: ASbGncvnuthjk+3nidomMcsLzxTeD2tMBKEfwu84U29kwLbRZgFUSoMDSz2QdqG7w2H
	l0A/KIWH1Fz01AmUypUmq1kAdflDzTxbuEpCu0Yajq1C5t49OlAWNewtR8EHKl6p022s7BC6dz+
	+G4KKUCq3L+nnrxCgXUXiZN6efNzTl2ghVfpwoJ0hxZ3AFxDztxrxIJIYQAevv6+DH9XPOPmVuA
	AbFtdDBRbxU/5ztXTUe5wGJFRuzerIdM2RbKUKNg+97gbuNETIOAqYzyHMhPH5z4zupcZEM/MUo
	H62qrzigI5ZplO7bLGY8Px4rwxyrK4DAvjOaRmPG8KjP2g13vrk+Xj8Byom1s743JXuSOZRM8fT
	e6SfF
X-Received: by 2002:a05:6a00:399e:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-742acd726demr35664316b3a.21.1747931838545;
        Thu, 22 May 2025 09:37:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxwkiq8zt00dFf7bFQdPSpNOeWI8h9dPVQQSNE8HY5yd7nKGEFquaXLZuaUL3ohi1T4E/g0Q==
X-Received: by 2002:a05:6a00:399e:b0:736:50d1:fc84 with SMTP id d2e1a72fcca58-742acd726demr35664260b3a.21.1747931838049;
        Thu, 22 May 2025 09:37:18 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970b6a1sm11446277b3a.40.2025.05.22.09.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 09:37:17 -0700 (PDT)
Message-ID: <ed75531b-b518-4543-a4c9-84726718f813@oss.qualcomm.com>
Date: Thu, 22 May 2025 09:37:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: Fix unbalanced IRQ enabling
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, jjohnson@kernel.org
Cc: kvalo@kernel.org, quic_svishnoi@quicinc.com, quic_pillair@quicinc.com,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20250522120954.605722-1-loic.poulain@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250522120954.605722-1-loic.poulain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDE2OSBTYWx0ZWRfXx4mfyOrmDvvO
 E4ti9afaxUvh6tmfPWj5fnzoQgSK+BGCsJip1XyebZbpv6RgJNPmKJ7OTGlpMVvMZfbo0g9iE84
 yCvoJ798fhtSmk9TzBw/Vywf9bFEfWYFTUuF1JyI9h2SzFYGqDQy7ptDwhwNrVbw7BPe8ACXntT
 yYTCzzMYwfRgtxIw6hz73OzU00eiLWwOs4cM4YA9SnuldQWfYHo8Ud4VpaLiRCwtFNxgmDofb8+
 +JnIaKRMNsFDeVUfWQJussVnfWOxKbS+FUgGno6aDI08EjsnBPrStpooA+mhxiKPYGoAeOQ7ApP
 HbZGPp+4fR6Qt3C8fhLji1XYWeTA8DI7eRNYR4AZNAhAtMcR+RRWjiiWPfZsXFrNNvS5W7pylRJ
 s6bYvr4T3FRJEdYx4lDdnC9NAWm0atswvAjr+2OLyTc/XLXjw59CY6hRq1DvLE6Ph9Q7LKVo
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682f52bf cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=B8ldSb-O8b6Fn9ZPg28A:9 a=QEXdDO2ut3YA:10 a=biA1LTKiNYMA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: GKQP097m4LOPf2KoOWfxKioBmrnkaTmr
X-Proofpoint-GUID: GKQP097m4LOPf2KoOWfxKioBmrnkaTmr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_08,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=463 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220169

There is already a fix posted for this issue:

ath10k: snoc: fix unbalanced IRQ enable in crash recovery
https://lore.kernel.org/linux-wireless/20250318205043.1043148-1-caleb.connolly@linaro.org/

Can you supply Reviewed-by/Tested-by for that?

/jeff

