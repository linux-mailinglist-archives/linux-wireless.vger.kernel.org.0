Return-Path: <linux-wireless+bounces-18301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6CA25BC9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 15:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8151884E36
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B51EEF9;
	Mon,  3 Feb 2025 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LKQEsPpM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277A205512
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591525; cv=none; b=XuaGm+ULHl/PEJby8KGVS1P1d2zjwtmjslI1+uF/+d+qyvx4/SMe4KWypxFIRTXs4NgIVsm08TE3wbRkLZAmWPLFjPOeWOSQy6uAiqiiO/bmTc/Y9vJF3fT/w73B+siOk0ApEUvPOoLV4mlhwqflbcFGceEYH0qov2f2gLwa2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591525; c=relaxed/simple;
	bh=RPAiOgWMmu3yPq1VH0P4VD+K44/uVY2H7oc+gcv1Vt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbtOyLgxLQ/UZ+QOttwlhDxJpV3cDFgTVTfnfa3/YyK0jcQ11RnvkoP/NdYzgVYZ9YicA0kpGEIy1kG8akB5RPwk+uwkpEqViAwNfIxZLUJwtn+//DHTfDU28R6cef63sNn56khJNzMAxLsFr9oAuNwSjfXqsXc4s8+rsTsnVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LKQEsPpM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5135NnHV032089
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 14:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SAVn8olU3KNdR11Q8xavIGnX0m9TWIy2i+F3+DqAvuc=; b=LKQEsPpMCvWTpCkn
	C5MMQqEU2PPLyPGS7lV/7Q3GtokmRMzhE5/sLuBTXhY/ggerBlTPFJsDkXmYjgq6
	vo/YUy8/YtkXzLEWhQDiSOqE90rbku/ga5a+oX8VJmM7otILx/hUTOJuBgAohFY8
	4IvvKYOpEkvgBm3Lo6sIILrXyM6kBkJi0KcGe7URfGQUBsShGtl2otJ0LuGFikcy
	pX1R4slNaSTWnUMsYI8bDEIgB8mOdDc0a4xYy3Pwg9UHIqHyGXmkZy9rk/O9/6jI
	qvu6WAqOycQzjelFgAkNEBcQ7wU4BS+NyfheOwjiPRBWOIW2oXm/LnaA+ZuzQPgq
	LnFhKA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jqm419y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 14:05:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6f28dc247so87682385a.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 06:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738591521; x=1739196321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAVn8olU3KNdR11Q8xavIGnX0m9TWIy2i+F3+DqAvuc=;
        b=mTnQn7DekH7EzQcN58heHBaZUm55hHrDjN9S6blb49tOa92GIAIeHTvJMaGuGlELr9
         wNiB1m4bEfQFIa7lSsKgR9NfNRoWGX6woCT1HYsgyCXPNwGrzYyWJ6SSXc4mPc3WZ5hX
         3N3J6MCnL7OaCH6Z9e09uylG/sKjzjWxvVU3T7yymZLksrgogxSBcCP5g/bP+LlAsnWJ
         Ac11lhYhdG9jfFexYMlaJOAx/KUFXxiceYhz/CBMIRpaMBHQNsBCIDI1Sw4tMSkoolCj
         tG+hX41axBwDx6ltzWFol1Ap3BpTwkUlJk2XSdh9HSoMe15fdMfQ1YY+KkSZLs1bA0t7
         04aw==
X-Forwarded-Encrypted: i=1; AJvYcCVNpGDNXaOxM77cVpLponf1OKykfNWMgWg0nsUlAA09hW90OQPzw4Braot+Yd27Ypxnoi9uCjIq4nxN2rT3wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRFRtS5bzZazUQdDo1/WPHeDkJYHHmaLeXAof0BSdxIYTMepw
	qKst+HBiZNxgzcMrLUyB+NkcX/bWBIocMds/lvVgbafo2jebrux9r0czqcCrsgncGVWPfII43Dq
	Bu/1OPcfXQocKu9Q6OzqDgJyeSONJ448wAhxLEZjYZGjPjRu/vRXoPkexZSkTv/qc5w==
X-Gm-Gg: ASbGnctqrQkbS3o3+/ru8DQyHLMSXHVPgy9ERCGYRDBn8MOwvIR2Ne3cx5Rvsr2OeQi
	sEaujgLqmNIfa/5Vk+DcAQuJfpUe3qJz8GredDJevIFHEnUQ4itnOZWpon1X9xJByJS+dz453Lx
	7Kr81i4Uu3gM1y3rG2we1V+c16B6sfmQQamQ7wmKpmbd2nVc7jwd+L6O5vrCesXOjwCEIOvB8YB
	9uuCPdl8mGG1L2ZbNhjyKC94whftkpvW9M5PQmMlrK2/HED8upy6ToHPA4rG/TZzCpv84HITXYr
	vMJQ1N9aCg9s5H3CQAXC0SbRSdq1JziX+LNF6fln/xHEziFLkAuCF1aHuis=
X-Received: by 2002:a05:620a:40ce:b0:7b6:d2ca:15b6 with SMTP id af79cd13be357-7bffcc352a0mr1170512785a.0.1738591520418;
        Mon, 03 Feb 2025 06:05:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcEhI9vXikoPJbicfHzVgVexvWitCJUXqJTFDjSt+WZfBiMjT0/ZAvjU0/DTx1rj1mX1GJHA==
X-Received: by 2002:a05:620a:40ce:b0:7b6:d2ca:15b6 with SMTP id af79cd13be357-7bffcc352a0mr1170511085a.0.1738591519966;
        Mon, 03 Feb 2025 06:05:19 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723e9fe4sm7781445a12.26.2025.02.03.06.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 06:05:19 -0800 (PST)
Message-ID: <e037cad2-1462-4be7-81bb-5c41c346f765@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 15:05:17 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: add wifi node for IPQ5332 based
 RDP441
To: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20250130045900.1903927-1-quic_rajkbhag@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250130045900.1903927-1-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zLCXEAxZ2_vdVOzxmVR6Lrej_aiOvmTt
X-Proofpoint-ORIG-GUID: zLCXEAxZ2_vdVOzxmVR6Lrej_aiOvmTt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=910 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030104

On 30.01.2025 5:59 AM, Raj Kumar Bhagat wrote:
> RDP441 is based on IPQ5332. It has inbuilt AHB bus based IPQ5332 WiFi
> device.
> 
> Describe and add WiFi node for RDP441. Also, reserve the memory
> required by IPQ5332 firmware.
> 
> Depends-On: [PATCH V2 0/2] mailbox: tmel-qmp: Introduce QCOM TMEL QMP mailbox driver
> Depends-On: [PATCH V3 0/8] Add new driver for WCSS secure PIL loading
> Link: https://lore.kernel.org/lkml/20241231054900.2144961-1-quic_srichara@quicinc.com/
> Link: https://lore.kernel.org/lkml/20250107101647.2087358-1-quic_gokulsri@quicinc.com/
> 
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---

[...]

>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ5332 MI01.2";
>  	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
> +
> +	/*                 Default Profile
> +	 * +============+==============+=====================+
> +	 * |            |              |                     |
> +	 * | Region     | Start Offset |       Size          |
> +	 * |            |              |                     |
> +	 * +------------+--------------+---------------------+
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * | WLAN Q6    |  0x4A900000  |       43MB          |
> +	 * |            |              |                     |
> +	 * |            |              |                     |
> +	 * +------------+--------------+---------------------+
> +	 * | M3 Dump    |  0x4D400000  |       1MB           |
> +	 * +------------+--------------+---------------------+
> +	 * | Q6 caldb   |  0x4D500000  |       5MB           |
> +	 * +------------+--------------+---------------------+
> +	 * | MLO        |  0x4DB00000  |       18MB          |
> +	 * +============+==============+=====================+
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |            Rest of memory for Linux             |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * |                                                 |
> +	 * +=================================================+
> +	 */

I'm still not super on board with this graph, since this is a very predictable
layout where there's [something for firmware, contiguous] and [free]

Konrad

