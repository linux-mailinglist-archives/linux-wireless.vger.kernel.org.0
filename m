Return-Path: <linux-wireless+bounces-28865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 634CAC5156D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 10:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A84474F8FCC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40DF2F0C6E;
	Wed, 12 Nov 2025 09:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3mRdK1R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbEM29D+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248CA2FDC3D
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939113; cv=none; b=cJLqYR+Ex7FLTWly3j0Digz4mWy/jX+To7JCvJ9dlcD1bc2HraYGI/ZYCUe4PY2FtoLpWtE41+Bw0nByxrTNAh5hkqTDV9kvZFhZwzo691mriJ41+UDENSYNX+qKw1o8SEByMc1VimOEHGQkhpLmE58uF1eOurEGuHp22VcM1jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939113; c=relaxed/simple;
	bh=U5QUgzFTz/IvlVLx3nP30IouyyraN4noTBTIRMQEoCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebxZfiHDjX0iW9EiI7jOanDYJ0Ahh4jIgGdIsrLhzOZc265KXlze/HFzskCFC8u9mrq+7ByEXbogPe2z4HbqfdqVTqgvjGlnTUF1loZilIJnIbe+ORlf3Sz8SybdKko6zcE5jN5+7JkJ6wSH04aiB5ttUSLnZ7UfAPldycFQYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3mRdK1R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WbEM29D+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC3H7Jg4052806
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 09:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Z1U6pAv398aa8/5qwHlXbo4iyPjOxFUrccDmf5/HCc=; b=M3mRdK1RR8PQNY60
	GweKj5OB6mJQfS9anE5lEstnPMnkr5UfAh/gaNwnTtqGpmGiCJMT6tcjd7c9qK4B
	n06Npwsl/bcr0LXw40fQGofnf/AHhZzy4R3Tuo9Nrv9nVGG8OyhuFgpjkq/R+UAO
	KzXT50zZ4T9qKdreR4L1xDAObsSajZ01aLywFE2KOmNeIPAZxLAVTeqURbCNphOl
	qWzmmjG2UuQHVbPiA0XF45h6XtmWFTNBcynHdR75QGuTX+UotG+kO2kDbGhw3qwt
	flYPbOPio5XHn4VvNlWJQWhX8hpC1KgIBi30zF+VUTudBNjFM26Gp8qIpij4OZYD
	2+S1ng==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acj6v9098-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 09:18:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ed861df509so1745001cf.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Nov 2025 01:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762939110; x=1763543910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Z1U6pAv398aa8/5qwHlXbo4iyPjOxFUrccDmf5/HCc=;
        b=WbEM29D+xUQc2CZ3jEx9xtILvtC/Aa003eDOM9qVKOimJlUxYNdRcPTzbf/WVO9UXC
         kOUExbWxRvAMODFxpRqU6gRVDdCaJKMi13l2fecb+q28LtLurBarzeGVZoLW4RS724mD
         xUoDkbUjpfLAeJGaWjXb/+w8UN2XwKew3GL6MSoX+86md6yb99aWRPPsRlgWRdnghAEb
         b9TcdA6tFctaehnPASvVsjEDpt4QWSgwtwUM99DKnV6x1TjS/0PKCDw4cecHcLZ/dOR5
         XU+/kK3yzo8XC0ljyY31MhFxLGXknJSKI2OHLKk74at4oBct/fJtwIAKi56/QnbPm33C
         7wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939110; x=1763543910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Z1U6pAv398aa8/5qwHlXbo4iyPjOxFUrccDmf5/HCc=;
        b=I/NHSxxIk+cR0BPhxhGvzVdp/nz/QCeL2z+sazOFjc6tc2Uf9a08Mf7uHz9C8ZD/Ku
         7qAN/RomLVbmFssQYGcaWHXiwm93I5Z6pTt4ohx05ycZQ5ZzKGljQTpsEpiZuB2gy2Sw
         FbzkwhHIoLj1qmXfytCNX3eeIfPl48s+AOCSKMW3EEifzzQhUvxrohMz/60R45MsuZkD
         eWWUo6aQbMrU0A0guFzrHgn8gsEUfk5k0QSS3wq6ByXodZVKS7XBgvveQY4zn/id5qYI
         at8/TP7RJXCAVis7a/PwQxP8bv2IxZRwEbNxKvt07cPEt7YOQIO1Ihc450HCzz0MM6U7
         MuJw==
X-Forwarded-Encrypted: i=1; AJvYcCUn953IqQJTnxzIFdPgBmotJIhvGpBL+YT+8d3rSM84H89HCjrl79ACglY+IBtk3mbGimDmdsswCBkPc+D4BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1dYzGGYO5+yIAP4btaSc+pLoO1nr1Q5GKHadhJnW94HNY7470
	6R8PYybjnAyu751UKYfMptg6v5kOoD9wNX/UJnGzTRIJrIBpaLeX6ttDlqz6nviqlYYE4vUSZ8s
	Z63DZ3uFDSErVUqIcGiyrBqg56+Vm37kRQqtpfb0TQFivLM4fEqcDw9puD5t08PGh3mU5mA==
X-Gm-Gg: ASbGncsnra1oGTZ2mph3RzVonEjUsu0M0kd10xsma/a+KTfQdqymlRZ84phBOQXK3tJ
	d/hGOmG/sH76lF2ho69C651TfiR3UZ7wG5kyZcBvD/ebexeGPmkXcckNDkTwCsOSe9S0fccFn+O
	t+gkY9l3c7J7oYdVMcIAEDDptSY8prt5hOeoly78akb9953yglWN6x5nkyXyYH7GVD55A39vnmG
	4GaTQjwCUSo/zi8JalSmoPeaBrQf0gipSOam+/IeEHLcqOb4fCRNYF/0ilsrwOr5G4p8UtHsju3
	5ivuU39Imjq90CKF1uZrwpTsy5TRofsrVvV6xMOraXh8Qnilafr5DPD3QvCE6VchTOK+slMbsTw
	H+Ts/kYqKN8F+k2I1z0O7EcCVF7SJSTnnX29otYeVlr0vBh6OEqDTUKOs
X-Received: by 2002:ac8:5808:0:b0:4ed:a8f8:307b with SMTP id d75a77b69052e-4eddba75ee9mr19582941cf.0.1762939110387;
        Wed, 12 Nov 2025 01:18:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4l5nO38ZbTUUbjYXNEyin+4V4OUbwvGEdR+rVes2WfMKu7BFS5vDlEA3PIIQEduH3Cw7aqg==
X-Received: by 2002:ac8:5808:0:b0:4ed:a8f8:307b with SMTP id d75a77b69052e-4eddba75ee9mr19582781cf.0.1762939109964;
        Wed, 12 Nov 2025 01:18:29 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d43bsm1618141566b.45.2025.11.12.01.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 01:18:29 -0800 (PST)
Message-ID: <a0c267b3-535a-4f38-9a9b-d7b141b8fc64@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 10:18:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: xiaomi-beryllium: Add firmware-name
 qualifier to WiFi node
To: David Heidelberg <david@ixit.cz>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson
 <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Selvaraj <foss@joelselvaraj.com>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org
References: <20251111-xiaomi-beryllium-firmware-v1-0-836b9c51ad86@ixit.cz>
 <20251111-xiaomi-beryllium-firmware-v1-2-836b9c51ad86@ixit.cz>
 <wxvtfyfdso3ngqvnhvryeo2w6udoolfp46smv2r3qny2cl7n4o@iawxfnj7qtrw>
 <5c6a1434-1f43-4434-b6ed-0c5b98ee8d2b@ixit.cz>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <5c6a1434-1f43-4434-b6ed-0c5b98ee8d2b@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HC7pkMkSd1WqCrvlhAB1HDnp_VrwNn2j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA3MyBTYWx0ZWRfX714ZXkxs3745
 Gytj9m6qZ3z1ZNMv4kQme8Fv+p3BhN2SLR3V9Kb05b+4v4IJSgtgvj12tuu6u/P554Upzohp/d5
 nzKGuH6d37NN38o87+praj3JJh3wxPn7k2CyiImuM98zRBCHZ44WRy0XGxwvYdlty0D3+bLd9Kt
 l0moqGpuGpNCLOZie56TssXBQhBzHTztN9UxCw1rWF2CR9NnHiIJuOImpsayJAjSMJ9nPxUjILp
 Hd+37C73mvSbWxPnFh7esclQMOvzszf1CTW0sREvFizfTwB0dSejRQo+CLW6c6QrdsT5DipVMtS
 +GdkI5as+Lw66Qos1P8BXUFZHvr/g3JYh+GWcJv+PNkPHUO+yTLjAgRMMLuji/Di/u5CbKeXNjb
 L2bdLRxZdQrXWE3DJu3JsjLtVRI0PQ==
X-Authority-Analysis: v=2.4 cv=f8dFxeyM c=1 sm=1 tr=0 ts=691450e7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VEnwf-grGjUPgLEjvqIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: HC7pkMkSd1WqCrvlhAB1HDnp_VrwNn2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120073

On 11/11/25 3:23 PM, David Heidelberg wrote:
> On 11/11/2025 13:46, Dmitry Baryshkov wrote:
>> On Tue, Nov 11, 2025 at 01:34:23PM +0100, David Heidelberg via B4 Relay wrote:
>>> From: David Heidelberg <david@ixit.cz>
>>>
>>> Add firmware-name property to the WiFi device tree node to specify
>>> board-specific lookup directory.
>>>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
>>> index 785006a15e979..9b0b0446f4ad3 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
>>> @@ -631,6 +631,8 @@ &wcd9340 {
>>>   &wifi {
>>>       status = "okay";
>>>   +    firmware-name "sdm845/Xiaomi/beryllium";
>>
>> This wasn't build-tested
> 
> Sorry, I wanted to send it more like RFC to get initial feedback, I got user with Foco F1 who is willing to test the changes, so I should have new version with T-b until EOD.

Nothing in this thread seems to suggest this still awaits testing :/

Konrad

