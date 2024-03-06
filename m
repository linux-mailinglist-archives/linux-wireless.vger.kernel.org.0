Return-Path: <linux-wireless+bounces-4446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26B58742BA
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 23:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884D81F25983
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 22:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5781BC39;
	Wed,  6 Mar 2024 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jay5a9Rf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741CC1BF40;
	Wed,  6 Mar 2024 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763927; cv=none; b=BODybQnNJT/NT2uhrOkn2whuoIrwofoEYJoTiw1vnOv6bGUHjyweE8358/zF2YPgxbm5DMEFv0kDXKs22wd5w6XskOMhLvf74Vb5jr2smB9WTA8aO1+l0hEIHGbaRLVNpAFFpaJf9WhuzKdLb26a40Yse77hfuipSMn+K7s+JtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763927; c=relaxed/simple;
	bh=q8tNCPbzCWi+B6Z5twqI6NjUPM2+8unGp6l5/zPPxh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lMEPy1F0qQaxFC58cJsiIZsjcn6gWST2bEZJVX15uUQIzEcxMAao8U8Rb1kkc2hpUiUE9A/GoR0sM+TtRWPVKiA5OWla2AAUt8sWNS2BY4C+pjSpAF5oTMrpZhZgfwXz+0K72aIoVw6I+66bUPzfZ9RYoahH2SCFu/48jue5Sew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jay5a9Rf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426LxtHT031815;
	Wed, 6 Mar 2024 22:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=q8tNCPbzCWi+B6Z5twqI6NjUPM2+8unGp6l5/zPPxh0=; b=ja
	y5a9RfeRivotbNGX9yUq3AbZW/pYWZ8UI8enkQif/FyCT5SBP2zNwTAV/i4bp1zF
	CjxUnjnB8Je5LiGqgK1DvpmB+XBrjan0ZNy7EMQeHaYu/WN/zARW9+ih2iHdko8L
	yC07eVFAa++UIdxt5fcBKpo+/IJ7VpJCxhgEsv3FBaI4lZvbMkU6bj8av6gZxPQW
	KUZYLE61TpL5sx58vbkXtAxIrI5DtDR1KIeHLV9pNkKmLjb2kOaQe1wDe3DUHDrZ
	o3bgHfX6t7s/bF6Zmsv0FsieeimcCqpsFGqYxormZ3HeFdY+aYP4IRgUVwYIiOxH
	wX5Wam2RehUM4hwoBbcw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjqf23vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 22:25:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 426MPDaU021468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Mar 2024 22:25:13 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Mar
 2024 14:25:11 -0800
Message-ID: <baa7a017-ee4b-4e8f-9bb8-1e3857e18855@quicinc.com>
Date: Wed, 6 Mar 2024 14:25:11 -0800
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
	<kvalo@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
 <87plw7hgt4.fsf@kernel.org>
 <CAA8EJpr6fRfY5pNz6cXVTaNashqffy5_qLv9c35nkgjaDuSgyQ@mail.gmail.com>
 <87cys7hard.fsf@kernel.org>
 <CAA8EJpowyEEbXQ4YK-GQ63wZSkJDy04qJsC2uuYCXt+aJ1HSOQ@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAA8EJpowyEEbXQ4YK-GQ63wZSkJDy04qJsC2uuYCXt+aJ1HSOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _QXoaAqIf_VKqQDKLy0jgYj5bG4nTmdp
X-Proofpoint-ORIG-GUID: _QXoaAqIf_VKqQDKLy0jgYj5bG4nTmdp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_12,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060181

On 3/6/2024 6:23 AM, Dmitry Baryshkov wrote:
> After some thought, I'd suggest to follow approach taken by the rest
> of qcom firmware:
> put a default (accepted by non-secured hardware) firmware to SoC dir
> and then put a vendor-specific firmware into subdir. If any of such
> vendors appear, we might even implement structural fallback: first
> look into sdm845/Google/blueline, then in sdm845/Google, sdm845/ and
> finally just under hw1.0.

are there existing examples in linux-firmware?

or is the whole point being only the default firmware is in
linux-firmware and vendors would follow this pattern if they add their
own firmware?


