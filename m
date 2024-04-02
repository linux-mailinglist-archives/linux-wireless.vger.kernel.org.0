Return-Path: <linux-wireless+bounces-5776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797BC896055
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 01:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3376828679C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Apr 2024 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AD755E72;
	Tue,  2 Apr 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kMXRHgOg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDF52260B;
	Tue,  2 Apr 2024 23:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101273; cv=none; b=ELkNZKzQWMPaAg/2xuO+aHmoUJ8ALszZxZ09gbHNSvOf2vZOf75cEGK16Jtjwv/fPqsD6/nqwwkd8wedm8A7ohluxeJ384rlnRAxp6yWPhFZt23+UbEZgp8wBWpEud0XIb8rEUrxrhoMcyWguxwuFNrN4jhj3QGW++ejw7Q/vPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101273; c=relaxed/simple;
	bh=oEgnkDkHu9ozNB3y7fjXnYoroS28ZNTvCTT5deYyeCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dCljJjDjmM8jynIqoCYY9Y2sUSzkGPB7bRySF/141k+3j7Y0vDDJR0bz9Z3E9eq4w131ozZgw0Nff1HIvMUs93PPo4F56psVGoa+2t3MAkirlZ5ssmerAGBNhg2j6f6oK829K0UHzIL3OFWZ88HqlwEEKrTehQyML4Kw7vRnk1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kMXRHgOg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432Ne2hV031840;
	Tue, 2 Apr 2024 23:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N8wssuiiGnXanF5AzvVhsyzrPiXUkHy55h9qyAcQd5k=; b=kM
	XRHgOgOaDds6cpFMjE7XTvLRyN3CitIhjYJhICCpRhsfbelCWckRk0cFmoNkAxWr
	mUoALWnTF6DpWJZjJhf9Z11ZGa+ALSEKucpvFXpSUIfsvQ55c+zAcp8b9io2qILg
	n2P5bUCgIZeT85A/VtuCasUZTRGkqps0s6u53hl8gp6K2CsLtf5eDeS7Hb1/cNEk
	n2rtswBXwOos2uExprcedpA2mLSSFgLiYdUuHt7oQZTKbfx0lXFK3kjRMJRr977l
	8GeC3I64W92s60UfXJsqEFxexjnIePKB/Oven7y6Wvz670BoguyIOmMJjWymAfX0
	5cgCYjYQQigB94yD+lgw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8ex7t7pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 23:41:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432Nexlh021242
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 23:40:59 GMT
Received: from [10.110.49.129] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 16:40:58 -0700
Message-ID: <c2bd01d1-8ddf-44b8-b5bc-860cc9754b76@quicinc.com>
Date: Tue, 2 Apr 2024 16:40:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 0/4] wifi: ath10k: support board-specific firmware
 overrides
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalle Valo
	<kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>
CC: <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
 <CAA8EJprpmC6+ePxw_G6y9YEszndq1VonS1HP=aP9OVHNm42LLw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAA8EJprpmC6+ePxw_G6y9YEszndq1VonS1HP=aP9OVHNm42LLw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h5QIcBeX7EQGg7FWckzMY_0T6_xTejy_
X-Proofpoint-ORIG-GUID: h5QIcBeX7EQGg7FWckzMY_0T6_xTejy_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_14,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=983 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404020173

On 3/29/2024 9:47 PM, Dmitry Baryshkov wrote:
> On Wed, 6 Mar 2024 at 10:16, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
>> modem DSP via the TQFTPserv. These MBN files are signed by the device
>> vendor, can only be used with the particular SoC or device.
>>
>> Unfortunately different firmware versions come with different features.
>> For example firmware for SDM845 doesn't use single-chan-info-per-channel
>> feature, while firmware for QRB2210 / QRB4210 requires that feature.
>>
>> Allow board DT files to override the subdir of the fw dir used to lookup
>> the firmware-N.bin file decribing corresponding WiFi firmware.
>> For example, adding firmware-name = "qrb4210" property will make the
>> driver look for the firmware-N.bin first in ath10k/WCN3990/hw1.0/qrb4210
>> directory and then fallback to the default ath10k/WCN3990/hw1.0 dir.
>>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> ---
>> Changes in v2:
>> - Fixed the comment about the default board name being NULL (Kalle)
>> - Expanded commit message to provide examples for firmware paths (Kalle)
>> - Added a note regarding board-2.bin to the commit message (Kalle)
>> - Link to v1: https://lore.kernel.org/r/20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org
>>
>> ---
>> Dmitry Baryshkov (4):
>>       dt-bindings: net: wireless: ath10k: describe firmware-name property
>>       wifi: ath10k: support board-specific firmware overrides
>>       arm64: dts: qcom: qrb2210-rb1: add firmware-name qualifier to WiFi node
>>       arm64: dts: qcom: qrb4210-rb1: add firmware-name qualifier to WiFi node
> 
> Kalle, Jeff, is there anything pending on me on this series?
> 
Nothing from me -- this is outside my area of expertise so I'm deferring to Kalle.

Kalle?


