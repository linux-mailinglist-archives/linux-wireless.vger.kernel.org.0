Return-Path: <linux-wireless+bounces-29015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED0EC6216D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 03:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 241D83ACB43
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 02:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922EA18A6CF;
	Mon, 17 Nov 2025 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuSLJsFd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TFgvzOQU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DD1E3DE5
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 02:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763347012; cv=none; b=IOz5JyihiMfrFzEQJreq6R+Qvo9CHL6A5VKRbh5UbFExLKzZRG+9KzhcLHsFtNa59NmOpSl9gBpEbHINGDI5jINreH5YzqLKyhUPeXUzgibTVf29i6wiEGAhOKikQ6/eIz0QHbHWwxz5hMSoglgkctVoEpJMA9mop6VihLIbk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763347012; c=relaxed/simple;
	bh=tw6Ajn/FDHb+1nEhaIG1ILZ9sF2BneSZ7D4tEaBnBj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJfAVAI9+Kp3vVb3atyK3eK7D79wrXMQHjhyQKpedBrKy+E4gGV68vwSPnBLQyJP8Kxye8kS4m2qbVoqVPPn+dY3taDHNXqHcTb4/u/Vq2sM1Nxil1HQHiivwuTebwivZ7lCRM1lADT+LmtuLvcqOs46qg2+tsoznTXRJlVWIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YuSLJsFd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TFgvzOQU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH0hcF12559538
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 02:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	39pbJS3KgdysbLKFSIpTFsRIixBoour3yJy497186+I=; b=YuSLJsFdOr3BcJNh
	Gj5MugWKswwVd+rbaw1i6qWOK1Bl3HgyKx7UJC4Y8M3tE/xEwX0o5UqFsawE+xc1
	vzFwgTtgDvDYUBd6FChY4pX/Gli7EGaQQlbWgr4RTj7E36Focd+p/d/b4HvXKdrr
	DbUyIh4hq551V4XfpJonhVmQT/LTX6WdmsIgrRncEC/66enyz7mbvtoH4OjTk5kP
	pdV5+dVBMaeB10vGXG1vaozmzZ9XBCD/+md0nWwIHhiXqndxmA5TMSlCnxC/KQbz
	uofUdCsg7rE1GKP5Es17kQW1613Jk2hjbIYFvMPmT0rEsA0ZaRE+SNLXp+C6DpKq
	yb03Vg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aejhr31sx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 02:36:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29846a9efa5so104694225ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 16 Nov 2025 18:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763347007; x=1763951807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39pbJS3KgdysbLKFSIpTFsRIixBoour3yJy497186+I=;
        b=TFgvzOQUACrP9CY1YEi+R+s4/p9lU112DnKoJ7f8BNlsVpn8Uk2jVqvVeKzAgfmWU0
         hsyRRSzmvgDzNdr7nXsT03Qs/2SMwH96DSlot99VbyreFLZ2GLYuIkSzoBG6jsu5GVbX
         r+eVdNbaYtUosepaFG3MPhZXKmpWnRE196WUdhuhdPwTKV47ZGasBo13ykgV4QCl6lud
         zeYj8f8tQvtnCOZrra+Pcdmjh+EXUDFDrZGKfQ1vpWNVZqA8rQu/JX1eVIQ6VujEO670
         cr2OfFr82MMeU7ZCxwa8UWb9WZxOzAzFxvVniabtAkKvzHiPzlFv+b04TNA4FVSs2m/p
         A/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763347007; x=1763951807;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39pbJS3KgdysbLKFSIpTFsRIixBoour3yJy497186+I=;
        b=OsHTI/f70ZM9xbWv050/JqkZd8Chzw/CAAoxQ0qWxb9pasLdtr0rMA0pTOmLf9j7ou
         VH8+ob6yB6olldF3XAZI7g3tyY9v8/kBoociM0Z/+H2nT4YlKvXa5uJvo32n+49wGjQ2
         3eCqSPZVjzQJY/jWmnuygSPr7TJCpS3H3tyriMGMbYt1N4ygeQeGVIn14yQpp4k5jtgo
         yIqmeLGNVtK9430XLZM9pj1PaU3XI/mZENHif5gQxw06gNiu9EtMKI6cWtTRlMhkbebK
         sO2lKYhT5jPLLGpGRnQy8VHs7IcjjtEn8c/6SCSt0sqqPJS3qrJuEq0P6YWNWzMaPkRZ
         pXnw==
X-Gm-Message-State: AOJu0YyIQxO7N54tj5aesAnPMYtYhMXT1W2pjkvp4o04/17n3CtjGdgI
	kv5dthLf1cIe93485/dkLWGY2Z2cCkEkXTn7UDdbVqQlIazpY9WdjlV9gKcTjAEQ+ZaS7gj6lgd
	d8Hg6FTfkJr2jVbMYH3CSeaY+byEfNpUWwnnaXNvQ2BOsV7KYqdQtSMeXL8RScm0GRdatiA==
X-Gm-Gg: ASbGncsnXYY3o5lcE6Bdzial6yuZk/ED9I+l62hfxBM9QLbn/LDNySJYSSrBA6rBlhN
	n1WmU9MQQ1gDqdL0N73EsDPF+STCYY4ji7GULSSgUML/i8/8bbvoJyDA/Ftlf5fdMIxkkwGq2E6
	lJcuQT/T3HscaEijSqGVkj1alaivaYoQPNYTrwoYi/K0ozsOXFaCVwbkEPo+uBv30Mnf3KlLhQj
	3Hur3fvMqZLBIgs5Tci7ag2apGqP2NGupghamKxiGbO0UD5Plyr9C3xG6joGA6ZDhd5QV0p19qJ
	odEZk47dG4khELZw0bh5Bp/YS8Pii9Nw6xP47j6sAyVFYxrPcJeqRSCOrqJo7pmWo2XTk524faN
	vATAmR1jd3WcLM4M4ywtJKALoAB5vaouT/lpEXKxP7IekKiZqol2NSVQoor+jFBx2Eu9k7iyJ
X-Received: by 2002:a17:902:ec83:b0:297:fec4:1557 with SMTP id d9443c01a7336-2986a7598abmr116773865ad.60.1763347007440;
        Sun, 16 Nov 2025 18:36:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8W+0BgPJEYbjw4FrKmofDfdMKM3fYG9H5M16t+BNUAdPhrbs9j8JpXvNtQsZA+wy9bjNFIg==
X-Received: by 2002:a17:902:ec83:b0:297:fec4:1557 with SMTP id d9443c01a7336-2986a7598abmr116773605ad.60.1763347006931;
        Sun, 16 Nov 2025 18:36:46 -0800 (PST)
Received: from [10.133.33.104] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf11asm121402975ad.90.2025.11.16.18.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 18:36:46 -0800 (PST)
Message-ID: <2fd84ab2-2e3e-4d05-add5-17930a35fedf@oss.qualcomm.com>
Date: Mon, 17 Nov 2025 10:36:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg
 <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDAyMCBTYWx0ZWRfX4B42/aheZ5rK
 nnoTpnG1Zsqr9G4LDnlb9MzGdiuSGDg1Tultd1WFgHO87qxzUys9e3gVWPgGy8XxRcWaQMwDoTM
 HocNtUjX74eoc/4R9IwsJU1NL2l476foYvGgZyiIITo1pCu5WC/bzSCWo82BYekxi0rCGWUt4Mx
 47mYl5+zdVzpcAf4uH7XO+GgZddztqWkf4b1bV5pcunmhHWF6cu1FPZdg3SF6WZMlJyBmAT+r5Z
 STlRwdTYuW52wMyJ3hFpiXw9jAP+1dvfiggUtTyl73lk1pGLNngFJLdN4tWPrMkcFxTgd4BAm1M
 2Zuzi/+cmmw9+TbI5hfqReqd0blcPhghy9n/TI7crXLFZlzcPZdbESvKWcWpFL2C+uHfrdmRRRv
 TlQWimvlq1Fw8fD01DNFSpE0v7xV0A==
X-Proofpoint-GUID: MPAykcAZXB5z-Mpqapi5-O4Ufk_iUdcJ
X-Authority-Analysis: v=2.4 cv=dLCrWeZb c=1 sm=1 tr=0 ts=691a8a40 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=oboMlcojp0BuSSWQvFAA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: MPAykcAZXB5z-Mpqapi5-O4Ufk_iUdcJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170020



On 11/14/2025 6:22 PM, Manivannan Sadhasivam wrote:
> Hi,
> 
> This series aims to deprecate the usage of "qcom,*calibration-variant"
> devicetree property to select the calibration variant for the WLAN devices. This
> is necessary for WLAN devices connected using PCI bus, as hardcoding the device
> specific information in PCI devicetree node causes the node to be updated every
> time when a new device variant is attached to the PCI slot. This approach is not
> scalable and causes bad user experience.

I am not very clear about the problem here: is calibration variant device/module specific,
or platform specific? If it is module specific, why the lookup is based on the machine
'model' property? While if it is platform specific, why do we need to update devicetree
node whenever a new device is attached?

> 
> So to avoid relying on the "qcom,*calibration-variant" property, this series
> introduces a new static calibration variant table based lookup. The newly
> introduced helper, ath_get_calib_variant() will parse the model name from
> devicetree and use it to do the variant lookup during runtime. The
> ath_calib_variant_table[] will hold all the model and calibration variant
> entries for the supported devices.
> 
> Going forward, new entries will be added to this table to support calibration
> variants.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (2):
>       wifi: ath: Use static calibration variant table for devicetree platforms
>       dt-bindings: wireless: ath: Deprecate 'qcom,calibration-variant' property
> 
>  .../bindings/net/wireless/qcom,ath10k.yaml         |  1 +
>  .../bindings/net/wireless/qcom,ath11k-pci.yaml     |  3 +-
>  .../bindings/net/wireless/qcom,ath11k.yaml         |  1 +
>  .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |  6 +-
>  .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  2 +-
>  drivers/net/wireless/ath/ath.h                     | 98 ++++++++++++++++++++++
>  drivers/net/wireless/ath/ath10k/core.c             |  5 ++
>  drivers/net/wireless/ath/ath11k/core.c             |  7 ++
>  8 files changed, 115 insertions(+), 8 deletions(-)
> ---
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
> change-id: 20251114-ath-variant-tbl-22865456a527
> 
> Best regards,


