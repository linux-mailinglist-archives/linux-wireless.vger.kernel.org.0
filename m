Return-Path: <linux-wireless+bounces-3488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C62851EF7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 21:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442DA1C21D68
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C95481D0;
	Mon, 12 Feb 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QUPIWdUl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90474CDE0;
	Mon, 12 Feb 2024 20:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771425; cv=none; b=DMQe3gUCK07O4OIEtDPjc0qhy54JRXE9E1Cfe2jfdOUKFbBHjFceiyBneAgMXXc4F0YW2YjvibO10OwhJjIHSl+YnSIGzjztPYxV7cAWFoscg6iSUB+jM0EYdVaVqTkDrr2QadJEOVE2dFHSGU1oB3ccf2EZhwdp1XjdrMTBSHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771425; c=relaxed/simple;
	bh=W5I8hgPwwBAyzQHQfZk2G35oMt4b5jINXtjFVACOhvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YUqUrLDC7CIWvAsfe1yka13eLiFNfmZskRCk354TmmD4LhK+qVwiGDxNrRGH+KeB7h78m2M3yCaBvQM7OfJEXiQ00YKCwfDz3LdtcH6KSDJVaVzDWDA2Ymm0HG7mkf/dnxho+QkHSOsZ/g+BSB+YOjeny2BIJLPEooYEYJbtDIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QUPIWdUl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CKNJQD006780;
	Mon, 12 Feb 2024 20:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=OPbrlq1m98uTfCMnFJ6G1tzc5WlIlN1tivo58zQxrRY=; b=QU
	PIWdUlo/uBqS7JVV3AGQO8/TsAlVn/O58VEoVHUjuA6fD+yLfT57yFWdxQv0Ebmb
	Q9F8EYWemmfXPZd1QKhV3oJzgJxCtzCHDsZMRMUxyD6SIrJLxLae51d12uMMBc93
	CopubSGDTgjVZrr6UR8nYI8G9WpQF+XLAaEN67grSswiDZX1uq0MKpRkJUi9NHH/
	JigG3JSSj8lSY1zbJZfFrdU6v8BXbBjpzzu51AwNYrH/kRfnjryul3ZjFzpgvws1
	AxKowcJP1YDJmo/QAmf57EBwmB8AMzLhezuWtUYkE8cRjwItwTRDxyMjEYmwdawv
	Vk/BEJ/k2xYyk6mvBoEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7tanr1pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:56:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41CKuqQ9020216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 20:56:52 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 12:56:51 -0800
Message-ID: <08c312f4-f3d3-4980-b998-b28026b5180f@quicinc.com>
Date: Mon, 12 Feb 2024 12:56:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] wifi: ath10k: support board-specific firmware
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
        <linux-arm-msm@vger.kernel.org>
References: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g4-fB0Y-JmWvy8lcJl8LgKG4GzMQwrSp
X-Proofpoint-ORIG-GUID: g4-fB0Y-JmWvy8lcJl8LgKG4GzMQwrSp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 mlxlogscore=925 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402120162

On 1/30/2024 8:38 AM, Dmitry Baryshkov wrote:
> On WCN3990 platforms actual firmware, wlanmdsp.mbn, is sideloaded to the
> modem DSP via the TQFTPserv. These MBN files are signed by the device
> vendor, can only be used with the particular SoC or device.
> 
> Unfortunately different firmware versions come with different features.
> For example firmware for SDM845 doesn't use single-chan-info-per-channel
> feature, while firmware for QRB2210 / QRB4210 requires that feature.
> 
> Allow board DT files to override the subdir of the fw dir used to lookup
> the firmware-N.bin file decribing corresponding WiFi firmware.
> For example, adding firmware-name = "qrb4210" property will make the
> driver look for the firmware-N.bin first in ath10k/WCN3990/hw1.0/qrb4210
> directory and then fallback to the default ath10k/WCN3990/hw1.0 dir.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (4):
>       dt-bindings: net: wireless: ath10k: describe firmware-name property
>       wifi: ath10k: support board-specific firmware overrides
>       arm64: dts: qcom: qrb2210-rb1: add firmware-name qualifier to WiFi node
>       arm64: dts: qcom: qrb4210-rb1: add firmware-name qualifier to WiFi node
> 
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml         |  6 ++++++
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                      |  1 +
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts                      |  1 +
>  drivers/net/wireless/ath/ath10k/core.c                        | 11 ++++++++++-
>  drivers/net/wireless/ath/ath10k/core.h                        |  2 ++
>  drivers/net/wireless/ath/ath10k/snoc.c                        |  3 +++
>  6 files changed, 23 insertions(+), 1 deletion(-)
> ---
> base-commit: 596764183be8ebb13352b281a442a1f1151c9b06
> change-id: 20240130-wcn3990-firmware-path-7a05a0cf8107
> 
> Best regards,
This series looks OK to me, but would like Kalle to review as well

