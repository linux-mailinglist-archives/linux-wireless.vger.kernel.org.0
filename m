Return-Path: <linux-wireless+bounces-30569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40EFD03F94
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9865B310007B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBA738BDA4;
	Thu,  8 Jan 2026 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mhQIfvt/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VPBcnphT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C462834FF5B
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879184; cv=none; b=qTm4OozQMITkbbX1kHSWqXUx9rv/nz98PcBtExqvTOFkjGmY6YqMpiRW4tCUGIlsuzqP6lPAabHin7jedq2gxc/tjJ33FVwj5FaoFmlmAv7FngYlXx8koaxU6hM3JjNKmpK1IN9d8sBFS2+O1oCY7nowf7oBANxeYhKn7aYpVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879184; c=relaxed/simple;
	bh=EyaI5qRW8EGsFwJyRcif9xHlhqMg3KQu8sRfjEHp4eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UboEQ8rpR1ueT5kwU2G1pC5I6KJxLceq2w1Ym2b8N5aI9jtQCiCpqD/tQW5n9tfZwwKcF/0EWYOCHG4qRzoUBpikNwi3Vu+EmJv8GlscQBHwaX0MlubyXg41/IPRg8nigtGKzv85WJulhRXhKsSKGECf+hJN9R/msvTK1LuiaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mhQIfvt/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VPBcnphT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608CJILb3890549
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 13:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=HcIISBP1b6cEtGMiwBv0Pa6M
	x4H0sGl4XAIy0JgephY=; b=mhQIfvt/AolCHOumQ8dBf24bbD8wjs8VDvn61bpv
	BqT597jVo/4N0Vu7pd/jGOByFxddjCfyfl15UWV09sp1zJD3B9T/ap4gNELwV+Ul
	pxNyeKmm6pGGWDTJ95d9t1bRN8GKhcD8L/x0d1U7Rq3OEo0nWP/4ZotvjXEVOPgb
	gVDALYgTkygIVuY2dP4iThSy8cGKz8rnAJuqT5KPQWSJTVDv0J50jyRwlso2x7ti
	oQxn2C/Vh2tmbXb1TqfqFIQ/00Q1XBxTHS2Y4AkZ7kh6Ztk0f/B2CUpRru39HLm7
	ADDaoroPBHuyesUeMGFDbzhc0uNC/T+cTdmfTxrH6+X/Gw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhuy738ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 13:32:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2de6600c0so816668885a.1
        for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 05:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767879178; x=1768483978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcIISBP1b6cEtGMiwBv0Pa6Mx4H0sGl4XAIy0JgephY=;
        b=VPBcnphTg1uTduYxCT4jeq0it00YDspWjfyEmEN7k6MLBEtF891HTocJw9XXzVITi/
         4m9otBr9YomSlbZ5DFxfuBEQbsR9Wm8VdRnfDo/bFat+ZtTR3sT5DDV2VfBCr510tuoC
         KReb94Jn1wvqidPKAXmu+I4teXrbKys367ZR6tkKhRy0onolKHPI4AK/iynlBo8U7HE0
         YwXQbjPaeVIZyRr7gWMeKwED8lgmwdIfNZ4L7oNRXK7voUR38N7Vlp99S5uEivtmiDIR
         ueMofm3cremjq3llNsAp2xI7gfwnTSrxxaAfgP22DsZVf13m5YbaGWVlXdVJvIlYmOC+
         +E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879178; x=1768483978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcIISBP1b6cEtGMiwBv0Pa6Mx4H0sGl4XAIy0JgephY=;
        b=QONk1LIcWvybHue1PQd/HvEuxfmu/x6eG/H8MgZSxwtKYXDY8/K6lGiZv+9anmx2NC
         CRIlOJw9CTyiH8bg8YM1i44S0Fn7xyF2orIcU2ABwQfcawnP6j2lLKaqM7TavrfIeGow
         +JDzPDO4t6h9bMqYyjtV6jQcc5z4aT9UpbgeVz+KJBryVu+zTZpZ8CkDfc15L6Na0uXI
         LdyPSP3Me3YDdzDUxy3T1MQCA51/+dz48T/dZAape5mF5xSgGH3Yt+8TaIAX5w+LrySd
         K1Kv8KWueJaGNn4TZATK66+GOIIfg1IoQTs5jUxXbdXa3ENKYygZA5F9vhpqcJ75RK92
         aXcw==
X-Forwarded-Encrypted: i=1; AJvYcCXi/bWKeF9Ov7yltebbOVO4jgb3sgJiUhY5zRzZC/fT1YMuoQ/SoG9EKsxZZ+WFp95g7DTZXJhaKjDAgxyvkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/kcwe8264Oy1Px+a54hFZuBIpm7u5VF865Ifg1f8WQDHYHbH
	Z+swJuPN7ainxEHuX04HSgGo8JCFEg5iomh/8MMikKFg6az5vPr60VAkX4M2ynSM2u20i+B9JN5
	2CXfCtrAwobVxb8dRzHa+/G9m0+Ylr6TbT2eL+aIXFxx4zjiu7Moq/Jy9QkeV5ymX2FDQwQ==
X-Gm-Gg: AY/fxX4hf14yviam4uM9sMrnOA3H3zqufE92D5p/SvFqAEC26CGPN/Jo79sBUstX7dh
	WVog7DwT1CwVQgPUSdz+fFvZMAHGH5WahWS+TmMFVeycs4E8ZYbV8ER39zcs35wZZmVZo8Bimqm
	qaLf8C9m7S86gpy+oNbY5efez5JKltw9w31MMaIHZhFUFZ/ptO/+udfwIiaso8RoN4f15ZuvPO0
	ZJwYsaeJN7BLyoVbfHeRPcvaF1lgXvNiUrw3ewAJzPfAGjv4EtnOKuzeGoFYm8gUnrdRL8zXqfp
	mOiTmqFP+Rc/EF+xpGWurIcG6j6mC4zpy3rzmXWtyjJO+eNT8ZGU6D8rLZDH/UWBSQxZap2B3pr
	HlKRcyZ4gwsjljGUmMnCS33PDOFc5OGP9S3PQd2VCXIOX9MD7YuVv6FS8w+E4xd4+yWXMVbMkS3
	tc1eu/ID+VrechMzAd1zzwDa8=
X-Received: by 2002:a05:620a:1a18:b0:8ad:32ae:b6c1 with SMTP id af79cd13be357-8c3893eccfbmr949014885a.47.1767879178153;
        Thu, 08 Jan 2026 05:32:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNq0BF8CcWxyGvWA2v3GYPI4BzBH5aF7V5Qo/ygFizqocnefYcuOnB4swoyC/eqGV/Li/c6g==
X-Received: by 2002:a05:620a:1a18:b0:8ad:32ae:b6c1 with SMTP id af79cd13be357-8c3893eccfbmr949007385a.47.1767879177639;
        Thu, 08 Jan 2026 05:32:57 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382eb8a9c39sm17049151fa.23.2026.01.08.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 05:32:56 -0800 (PST)
Date: Thu, 8 Jan 2026 15:32:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Allan Wang <allan.wang@mediatek.com>
Cc: jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Quan Zhou <quan.zhou@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>, Deren Wu <deren.wu@mediatek.com>,
        Michael Lo <michael.lo@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>,
        Jack Kao <jack.kao@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
        Sarick Jiang <sarick.jiang@mediatek.com>,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-firmware: update firmware for MT7920 WiFi device
Message-ID: <yi4rx4ddzn7iyprkklcinnnoup7azhvircgapzahvcexb5glu3@xqcc66cmxffm>
References: <20260108074546.3643110-1-allan.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108074546.3643110-1-allan.wang@mediatek.com>
X-Proofpoint-ORIG-GUID: 9eJ1Ldk9M8wMWuhJBxQm803nEzFdRoZM
X-Proofpoint-GUID: 9eJ1Ldk9M8wMWuhJBxQm803nEzFdRoZM
X-Authority-Analysis: v=2.4 cv=DZEaa/tW c=1 sm=1 tr=0 ts=695fb20a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=mpaa-ttXAAAA:8 a=5dgp0IrvZBRSxfCoof4A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDA5NiBTYWx0ZWRfX/dMpGjZf62et
 kob69/hshaL2r5+fVIPa77AV+WTgLXzHesa6hI3UsXZI6wio50BnzqAqGNEv5mLuNCf+ksOvxUL
 iFYSCkqHI9q7QY0oiHBKqmE9JH6iWKuG0A1yszBHJpzfko9oAaYkQyjPz8Qz1inh9pTWZmHbvk+
 T2xx9B7pYfhhQNTwsv2Rg157edmlf0c1OydEEPqJ38bjidoFCU/0ZJoZG1gheodRoW1rw+oM6cA
 ahVjjoms2fyOEGwdlRh2HWMNT8mF8E4ctXnU1osoxmd1Dk7LgM2mKnC5KH9BqdQayJp5qfigbh2
 yUWt4PQLVkUHi4dK4eVxh+bb4n/HsBvQTM2NFVXg1eMJMny5C9TITqMeXb2EN1RnufadIHAzmcf
 BJJzqOE/Bzu55wDuxQeNJyWw+ytaqcuIxvZiyYkHwr2cDomGSp53LeuGQSAGHhg+xUkuqyDpodl
 cD95IkD6nxmIfP1Y5Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_02,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080096

On Thu, Jan 08, 2026 at 03:45:46PM +0800, Allan Wang wrote:
> Update binary firmware for MT7920 WiFi devices
> 
> File: mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin
> Version: 20260105151012a
> File: mediatek/WIFI_RAM_CODE_MT7961_1a.bin
> Version: 20260105151805
> 
> Signed-off-by: Allan Wang <allan.wang@mediatek.com>
> ---
>  WHENCE                                      |   4 ++--
>  mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin | Bin 100384 -> 100384 bytes
>  mediatek/WIFI_RAM_CODE_MT7961_1a.bin        | Bin 802680 -> 802744 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 

Merged and pushed out, thank you!
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/847

-- 
With best wishes
Dmitry

