Return-Path: <linux-wireless+bounces-10358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9BB934F34
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 16:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9581D1C20ED7
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3CE1422B8;
	Thu, 18 Jul 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZrXMuw0u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9B812C7FB;
	Thu, 18 Jul 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313634; cv=none; b=NYww/wM/lPzChXAXmaQEwPl67ODheuC4bzFw7rRj5kVwMhZminyU/PmzD8IFIKep8Pkeh05VtuknyUmNpxGdQzdNNUcOJp1e74ZQFhlR4Ty2tDkZz3sbGNXCcDjlBQAj9DL5JHvsQ+qhSe2dxkoA0iHo7XhWPVR0ZG7pT/jmelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313634; c=relaxed/simple;
	bh=YwZzyUITuCl4ZqII9n1ohNvr2Pwme3YCK721bGwwxXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NBf7yuv2C+FsFEnbpgN7rlphf07Ri6HLWSvPj0AHAwwEviZvlYsDzhlL2QAbB7A572dmZGEefAf5TlvxxgDMWZZSOekNYtAHDaig8I7Gf2Cu+1zXQCEYD5ybD1103mWpIhdL7Q6r4JyvC7LyjsMG9UR/VmpK2w8HV8/983Xv/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZrXMuw0u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I89Hgm029089;
	Thu, 18 Jul 2024 14:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SNT71tPy05ChRz7sis8j+D9KLmuFbuIxE/qs7WYt1fU=; b=ZrXMuw0uLCNZ88mw
	/LdvEFHXGvzh6gHQC3WRx+5f7BoPSa0Lmh75o/4Kmf8jdsyNAY9ZvLay/KJgYJRQ
	u4wTxNWqoYZvGMCNTjjdn3BgDC6cRZTvCNDOKTOd7r8IsGcprJPu3q12gKqmUZnp
	TagXGuNmw1VvXfE2L5VE9h8BX6F1blpudIo9UJepRelPhbCFbH6HhMckHXASeokg
	Kyk+obcfWcUXJSIp+9kSu8hyXty4UrenZjAEvRXwsXS8o9NomtuFy69c+s79grFG
	JcfHMZrYRC1jwYMYI/WFeXMJp2VF+ozi+aD9Ha4mSMz7zO6Qy/prMG+Jt7s6Ugb/
	2h32aQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfs5sdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 14:40:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46IEeJIm029753
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 14:40:19 GMT
Received: from [10.48.247.102] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Jul
 2024 07:40:18 -0700
Message-ID: <d44fdc0b-b4a7-4f36-9961-c5c042ed43df@quicinc.com>
Date: Thu, 18 Jul 2024 07:40:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] arm64: dts: qcom: x1e80100-yoga: add wifi calibration
 variant
Content-Language: en-US
To: Patrick Wildt <patrick@blueri.se>, Kalle Valo <kvalo@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Steev Klimaszewski <steev@kali.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B5AeWhvGDVXLAGUShuXalfOdCrnjVIRi
X-Proofpoint-GUID: B5AeWhvGDVXLAGUShuXalfOdCrnjVIRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_10,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=731
 impostorscore=0 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180095

On 7/15/2024 12:38 PM, Patrick Wildt wrote:
> This series adds the missing calibration variant devicetree property
> which is needed to load the calibration data and use the ath12k wifi
> on the Lenovo Yoga Slim 7x.
> 
> Patrick Wildt (2):
>   dt-bindings: net: wireless: add ath12k pcie bindings
>   arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant
> 
>  .../net/wireless/qcom,ath12k-pci.yaml         | 59 +++++++++++++++++++
>  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  9 +++
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 10 ++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
> 

+ath12k mailing list.

Qualcomm expects, on x86 and Qualcomm-based ARM devices, that this information
come from ACPI.

That support is currently under review:
https://lore.kernel.org/all/20240717111023.78798-1-quic_lingbok@quicinc.com/

/jeff

