Return-Path: <linux-wireless+bounces-29728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF020CBB5F3
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 03:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3ECB300C6FA
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Dec 2025 02:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB352AD2C;
	Sun, 14 Dec 2025 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hjhsmviw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAm1iCWI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CFD23E342
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765678126; cv=none; b=nfUX42B//nDWKlHzIkYhYFiYEPKLSp7Zw03c8rxCr73l90hvkujMY6mlAnkr8E0+HmXcxqqqRB0I87x4vzPOdAE+buTa7VyowvDP9cn9YLSpxWsudjhIzaUe7CY0Tt92pI8w5yyfWkRvV7potP1ozd9LcaX8N1pDUn+zjvAf3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765678126; c=relaxed/simple;
	bh=OAdqQz7ypcVTD0k6RkiJI+vt7QzaLwSBJbY8qto+MS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2dnIGZTGMk0w52Ol+hneJVyDJy5L83lCKc4prLwUXmCdrfDRdM4dsXHS7dJWI/PAtsOwPki0sASpFymT8F2ri/8MxiqGo7s+/3H2OsL/2yqUn/huDZXBvGIFK0Jna/Z1nviIec0SPq8nI2xK9YjjFFKbQZbjCquGD5ZbsmEV6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hjhsmviw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GAm1iCWI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BE1d2CW1059633
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eV2vPS9sJMuGPlbnmOOt4y+RfDf9VGDtbZyjFlLVeeY=; b=hjhsmviw+OH0xEWv
	1DpBs6tGffgn3qzOPshYifYliafhPcx8zqqOYgOOUyWPzF+8u/L8JVFIC3qHQ9J5
	Kjs72sheEQaaKwJW1QxNAfvOzDyw9jciQcDYZKHAohW+H6dx2ByFDe9SEYi9lZcB
	s5HscBxhZJ/NIWdYAd+TAJ7CzCqC2vq/Do1Yu4eTu6lBxBIaKYHDppqmDp46QeSU
	fcBIAXbELp/ft9FSAvSIVlef1d292K58AKVla+KpADovxCVUmL1SgWoWdwkz6ZGQ
	/Rd6wIU2hqrUzYg0ofI42oVb3lNuFV6KfBub4h4B7I6txdQLwKSUNUu+qiIRBsNn
	PNmVRg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b11avha3g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 14 Dec 2025 02:08:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34aa1d06456so5042407a91.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 Dec 2025 18:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765678123; x=1766282923; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eV2vPS9sJMuGPlbnmOOt4y+RfDf9VGDtbZyjFlLVeeY=;
        b=GAm1iCWIXpsZjywarQE+eFgnntKT5jIjADk+TJTTGgl6GrcmeBCU3R/XGqgyW+vbuI
         ZHJbmcurkkKZloD01u8pkTZ6PM3P54RoK66nK1Qby7voyXsYb9ttND+jFMtzAlMfFZsj
         +EHfNGUjL6depBLvvYx9CK1HZnslWNzXCnC3FLEnrwjbLc9C+iwM7I7YFK/l/p/LJYsu
         4dW4Oi6qAim8nPYXxwDY1mSj/ND6b/rsKauAOSMQhQefrCCtDRJpOyOm37QIOKWfB7F7
         q63JqC+wQLqtuaHsDaz7mUhzhwgBmWjOa+ZJhvjr9XQqQdyYSet99T85zil1bUqIIRX7
         mEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765678123; x=1766282923;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eV2vPS9sJMuGPlbnmOOt4y+RfDf9VGDtbZyjFlLVeeY=;
        b=Erhb2q1iNfIJcGU/x2ehlUQ06Y72dqku+raFUqG06OoaroyG/APZgUb1dsZgTAcLll
         aB9VMmnBDD6ePXIxUXwxIAw3KOx4w+526wgO20vJ0ZrNNvrz69428tAl0xAFbNuLxfzn
         hn8TxJy5uEgOGxvb4WDGI/EnGcDhlP/+WoJFL9wda+Ce0pSXE82KrUtO/aftK9r0EHmk
         2CVWHPNRSebC3kN8WVQuUg6L8nRWwhyJoqzEq94N9echiMArTIRpUnUBs5kgCSZRxLPx
         LmC+MUySlYMrIlP5Cb9bejlcBCSUuKva1/+XoRL93QOEkVVc4Fra0YF4cJfkbU9jjPwA
         ikug==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZbbsrOmpKoZa0MB8P9ibBwcVVIm9ToweK2Z4cH4oVqX5SwlFVmnwHR3VAJDuhGZThdBMeHtLwZlw+pmrBg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZeEskAcqOLMyV6KKLcb4bkZpDC52yRF2938kCGGa7VMxLd5+
	OfQPF0kfaC4LNA4zKe0lRXbtdvgJ2n1SeNiPvPPTNvecnAKNeVSoUEwh1Xhew60w8zZCE69vV1d
	fin9GjdKTss2LaTMdQevP6fBUD3dBZRVldZroHPZhsY96JJyUwzcgMMce/Uq0qaa8x/qHaQ==
X-Gm-Gg: AY/fxX6mCJH23t3Ce/Di7ie1wEBFUXUa0pLyx5GFclb81q+DyRuk9WL5Zy7XloPcQnX
	M8lryMIyRiAtHwlSriuPC1UW10VPeAPvp9eX2ePMJ/RcX3cfOLb7SCJWVrhahALJSjor/sLc8oJ
	lIF++7fzATCsIRrr/d+8nNF8xybo4VH5OuwWyP1LSPAyq53ORcrGqbKGmyn86GjVS54C7et3eip
	g9OUfSvi0E1mrklQANaebmVikMLJ6Kh6zGsvi0qFCRXxsa+AGRGCh6oWDV1aHA9NnjMbJs2Q0lc
	zrsej3QOvTPnjwwBi4cew5qg4A/DYexKoiXGRXpTxbYchucwOgHCpxYnICzzZynCIHkU6Gp2F0E
	nNr8GbgRqVXmOkDPvvyfJ9I5fZSVCdCeEcbpR83SbpWg0EnUWIptcNuhsMYmvOAG4VTa5e2clAQ
	tWBncU
X-Received: by 2002:a17:90b:2fc8:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-34abd6c0333mr5843225a91.1.1765678123096;
        Sat, 13 Dec 2025 18:08:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsOx1VFhUEUQ3J0tBD6Ayef24cfl+ErdI1iQ5B8GJP/1C8VdE0n4fCXQfatWXFaprUhwWxzg==
X-Received: by 2002:a17:90b:2fc8:b0:34a:b8e0:dd64 with SMTP id 98e67ed59e1d1-34abd6c0333mr5843197a91.1.1765678122575;
        Sat, 13 Dec 2025 18:08:42 -0800 (PST)
Received: from [10.133.33.35] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c26515d4bsm8486500a12.9.2025.12.13.18.08.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Dec 2025 18:08:42 -0800 (PST)
Message-ID: <271b1c1e-1273-4900-a427-370a94c9688b@oss.qualcomm.com>
Date: Sun, 14 Dec 2025 10:08:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 2/2] dt-bindings: net: wireless: ath11k-pci:
 deprecate 'firmware-name' property
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
 <20251204071100.970518-3-miaoqing.pan@oss.qualcomm.com>
 <f60bc80d-a947-4083-9e14-000a937de412@oss.qualcomm.com>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <f60bc80d-a947-4083-9e14-000a937de412@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE0MDAxNyBTYWx0ZWRfX+vT/3VgC2GUu
 8JQUSPLxVZlwYH0BZS7MItb3vAQ3HsX0rwP7pGGEdv4iyIgHxQUV8mV2aB1VOJJLHeDdikpnHR9
 QZX9rPSM1qi9IEVvkeWylKHeUwsGHz2DaF1M9R/19gY3/Liu6b3nneTHs4yXRfvZ9cU17CM1LNz
 IEk7E/ETfAc7vgYAkBx+pCCjs1Jv8Kl5e8wKCpDW1yxxvVTzy7hjvJDCEt25POqzVoWFCKFaoMO
 1mxgriRvltfpn3APoN9CZ1v2fSx5/pg96CXC3PD+fYJsFs3JYXA3pQR5shV+hpADlOqqrTvB3PK
 BnaeZl/3wpPgm+B11WjrYANpGa9xoSuVeRI+omRgyyIXxS8n2efQbWh28zj5e2QDqoX1sSRPvJE
 YV50AGoN70jHRpTMUw2n4fUctQu7Ug==
X-Proofpoint-GUID: 5-qlUrKNKWSKosiEsuhkAqc1qM5yTdUR
X-Authority-Analysis: v=2.4 cv=PJQCOPqC c=1 sm=1 tr=0 ts=693e1c2c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=8gi6obPNpri618rnpZYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 5-qlUrKNKWSKosiEsuhkAqc1qM5yTdUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_01,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512140017



On 12/12/2025 12:44 AM, Jeff Johnson wrote:
> On 12/3/2025 11:11 PM, Miaoqing Pan wrote:
>> The firmware-name property was introduced to allow end-users and
>> integrators to select usecase specific firmware for the WCN6855.
>> However, specifying firmware for an M.2 WLAN module in the Device
>> Tree is not appropriate. Instead, this functionality will be handled
>> within the ath11k driver.
>>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml        | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> index e34d42a30192..0162e365798b 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
>> @@ -37,6 +37,7 @@ properties:
>>   
>>     firmware-name:
>>       maxItems: 1
>> +    deprecated: true
>>       description:
>>         If present, a board or platform specific string used to lookup
>>         usecase-specific firmware files for the device.
> 
> The driver patch completely removes support for this, so is this really
> considered deprecated? Or should this actually be considered obsolete and
> completely removed?
> 
> Do any DTS files actually reference this?
> 
> /jeff

You are correct — since the driver has already removed all support for
`firmware-name`, marking it as `deprecated` is misleading. The proper
status should be `obsolete`, and the binding should reflect that this
property is no longer supported. Regarding DTS usage: no upstream Device 
Tree files currently reference `firmware-name`.

