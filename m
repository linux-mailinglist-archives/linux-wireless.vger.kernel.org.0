Return-Path: <linux-wireless+bounces-27414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE96B7C607
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5741895DCA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 02:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220AB1AF0C8;
	Wed, 17 Sep 2025 02:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rapfpkez"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F3101F2
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076406; cv=none; b=sAq6WfU3bx4Y/D9lwh/o66cz9VRNbax7FmDwf4Fe5qvUVSFkBB8x9TTvqhrqvZap7VuDRd1ohlM7ZyKtHvqLGaev0Px5TzvfAdpnEDlvHUzfxdZhE5EBYtCwbtpYZpbDnN9xz3CvePmWqvJ1QNFH5BgIQlieSpMZHW4tnfrmdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076406; c=relaxed/simple;
	bh=+6nMC09wokYnKqxKi+C1Adww10DSu4gpDtSpif21o4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsaoCASasNm5D1OyI+VZGp6/vdHVsVQnXUpdZnv+OxRcWFriPsIH4fDvWYBak9iauGzzcSqgi/Oq8Dl6gQn1N5C026jCr4eXTlalbloo187AuUJo2gZ32StI1hoPFgME/uFk8K1gKDnkRukxbmsQwNLXUMGR33QFO1KBavQhw8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rapfpkez; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLZlUe005549
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FrReQTnqljoeNybsCXmGGnr0Q4DAABKRtCC/lOXhvcU=; b=RapfpkezrMRPRQc7
	Rr6+OxIPxf0Z7pDyb6LKKETuNXIIbbOBrtv9FU2ra6mFUl0cWfV/CnVrrclqt0HE
	Sfs1rvT1P6CxPUqC14oFvBKhgwhX8V1I1+XJpGCMeJl0h8/vLKLvGLXF4wYbgUpg
	QTZzzwrBtPSh4lpO4GdC3suxbzUzieTF4UxzrAF1FDOsq8p3Z3aeGWBduhMg4uyt
	iI2t1pmDkbyrPCQ4MkIGESPO7fVvwi2pW7eZFtp/H27YW8HJW5nU77OinTPtfotu
	bS4t5O9JpSSdH8tSYhBSoTedwqqy97dC6eEzfki+NMSVPhvq5UUoUu8aRF0pb0Lt
	Q+hBhA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxu0kq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 02:33:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24ced7cfa07so63543415ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 19:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758076403; x=1758681203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrReQTnqljoeNybsCXmGGnr0Q4DAABKRtCC/lOXhvcU=;
        b=v1UeP3320EFiyjLgFNFhorcNSe8a1xutoHnG1R/vQWRfxzPgBQ1PXfDEZB/xNGgJsl
         tn3KmDljCvuHBGBiyjLoyItxfiwlarC8dq7dCQOLnth6KxeyMo2tjzCFtVAUWc8UnJh8
         u60Mno2qNIm4hLVKkb5jn3x1a7b9BtEbMtHghPVayaiR3ijZhXlF20eYfWgqQxP0R2Je
         qBYyWCpfcfEEPaqeuGAAck0awDeZMHQrjNvpl2CIED4jpefp9WGNRPMrQ7gSlOQrEmj6
         hsK333gkPZ/X22TkPcFNRbQklWL+Ea9yX/6BS7Ief6TL0RnmtvXSWhcfF/faDtQ7aXZj
         QjGQ==
X-Gm-Message-State: AOJu0Yz+QEhc0DijmM6pAmuLxjeM0NxIHpve2dAs7buQgC4un+VjKq+s
	+DiJMJZgvbwU9EhTUaAW5H78DDmDFSSuVpBmhZ85zDI0zseIpntSu3wOyrP9HCdOKKNBVSy2Gay
	N2P9REnI2PSeQstx45MA3q9mhzcMstXm82X/pTJ7scxgezoU+AiE3HTFRte30w+3uvghavFwY80
	ywZA==
X-Gm-Gg: ASbGncsXLpsbu+Snjy9xtz8cj26LbSr2tVvmde4Izkxh3fqrpaYGdPGodHE3S5Hno8h
	5YgjjhJXIG0bL8YJWmAXZJcuVwC0yX2DQC7qHLSJqUaPFaSvLBslD+aQt0AXiwXcqlw0/exTlTQ
	RNuj234+ZNlrDWL6IjMl/wFlVzHw08O54Kt6VSCK2ngICfZoodHUUWPnL2jL5pVohaQdHDRyI44
	EGM3ryqBhh4jZ/JBUF42IUIIUBJ8wEj468N9ANnkp7IA4j1Q2GG16We40adAPHmJ+Qqy6kbQeHr
	ETMAqZp2hcIyCWIuhvFCyBZvoDtUud3iRVN2uoR0UZGJjXWf5Hf2Q0nOssjtcQfgIltpAp9Tnkq
	oAYJxEfrZRZ2fMqpxMJIn9CMQm6bkFJqK5vZLxA==
X-Received: by 2002:a17:902:ebc5:b0:267:c963:25c2 with SMTP id d9443c01a7336-26813bf2129mr7036635ad.43.1758076402741;
        Tue, 16 Sep 2025 19:33:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG57Qfsb1gzeQ8IKDiMv0+iirbUDwdvmSrbCVzVBMrY/eL0zRy2rcSooGDkkLzEQcHZlj55VQ==
X-Received: by 2002:a17:902:ebc5:b0:267:c963:25c2 with SMTP id d9443c01a7336-26813bf2129mr7036235ad.43.1758076402270;
        Tue, 16 Sep 2025 19:33:22 -0700 (PDT)
Received: from [10.133.33.224] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-261333a972dsm110557595ad.75.2025.09.16.19.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 19:33:21 -0700 (PDT)
Message-ID: <1826dd68-d418-464b-a96f-1a290809e2a8@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 10:33:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/3] wifi: ath12k: monitor mode fixes
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250722095934.67-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXxb4sbKT+qe4v
 /4hh+U8WniyYhva4JTfjdgBh0DZwfaWCbroqw4kQ9YUHi7iMed8tlNAUETz+z39gmd3BBAQZqTI
 qhx7v4pfdfQvYbhgK6i4SxSCb8RZdqrKe2XcsXAhfLZnXlrcTAILd9CetNpKbLunZPVSji25lTG
 eB+m357Z8aN8IWpdw3HhnD0g/KNURTXmgQmZo4npwgGfd8OSeN2cohXM1dIYTB4cj2GggtruAIE
 l4tR8GSOmcgQ0Y1WfjivfobUdBeqSa3nwt6FMrkXE5V+B2Wyc0q7n889B+84bCHNdZDQrwaxKmj
 GCy83AjwAMKdQgxuit4xdPEdxvo+HIHfGGiuNW6h6pW8a4QmQvKki/y2pI8ugIBGNCwRYrW+LNa
 RmC0fnVw
X-Proofpoint-ORIG-GUID: u32sn4i8iWauEqtjeWWqwXmfXLUpDA_E
X-Authority-Analysis: v=2.4 cv=R+UDGcRX c=1 sm=1 tr=0 ts=68ca1df3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=-ZAtyTsNoej9e0GDpi0A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: u32sn4i8iWauEqtjeWWqwXmfXLUpDA_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202



On 7/22/2025 5:59 PM, Kang Yang wrote:
> This patch-set includes three nit fixes for monitor mode.
> 
> Kang Yang (3):
>   wifi: ath12k: fix signal in radiotap for WCN7850
>   wifi: ath12k: fix HAL_PHYRX_COMMON_USER_INFO handling in monitor mode
>   wifi: ath12k: fix the fetching of combined rssi
> 
>  drivers/net/wireless/ath/ath12k/dp_mon.c | 49 +++++++++++++++++++-----
>  drivers/net/wireless/ath/ath12k/hal_rx.h | 12 +++---
>  2 files changed, 46 insertions(+), 15 deletions(-)
> 
> 
> base-commit: e4f11ae0c4b29ca0c133f891412afd5dcddc68ff

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


