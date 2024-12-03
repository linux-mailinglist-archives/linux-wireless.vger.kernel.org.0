Return-Path: <linux-wireless+bounces-15848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D88FF9E170D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 10:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3EF281669
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 09:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653721DE4DF;
	Tue,  3 Dec 2024 09:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j/ZyoZ3w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29B33F8F7;
	Tue,  3 Dec 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217556; cv=none; b=aWmJ+8aX5gmnacIGel2NSD2523HVCW5UN/7BlZ5i7U+wr+HtcWu4NZ6Z18ZQyOh+sNQRWv0FCmZaCNrisDecuz1S8ENaYK38FsieBn3L0g6TJwzmbMkgDi++FcS2IEvmLMNC+5lR3rrlKsSeWaxEm0QswaaCIM+ZvsTYt5GCe80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217556; c=relaxed/simple;
	bh=x2vsnah+FQn6F5RImqP2xAcLMZpjRl3druEdJIaaO14=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fKrtNyn/44tVU7hCa5/BYretO2Z8YCeCmo2P9Fh1k7R2CNR/Q6ES0JwUwCY6xBCV/vnGh8jxahFwVZQhWcpsZdYxZvhUB+lrBMwMDuEwDFJTD2TBsZg+mz6XoURqdDrvM4gClreRtIA3Cr5IofB1MWgPDIpzI4AawBMHyslRt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j/ZyoZ3w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B38O3YD028930;
	Tue, 3 Dec 2024 09:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4FmtQeza1CzHNqrTW/NmGRcEE/2b9bklTjsRtN7+/ds=; b=j/ZyoZ3wwk69T1oX
	I+VmYIq1lpIxXpbAuFsg+MPHzSgrKr/lfrpS+ubkueH66xhY8WFt+b/Vv7UuXsbj
	g0G4q8MI1Sef1BhtPuNKZ3BkmYgYbQvBNdsjxoEat/ftcNpELSEuYgaao3PYGsvq
	pjzTCmOa6HmXWHeyjhP6r7kmrowC2VX7lDfOd1uUQbpKVIdHdG3EaaSnMU3Yw7d8
	EdNvAFXp1v6ra5JqfwJ6U2nbP0zhL4Gy4tZtoTbP21wUM2nDBkiRd8ZDTlAxgEEd
	KJd7TWCi1tJUOT6bWD34URQ7UGcRWjN7N/33BmKymETbbd9hF0hV53SwKJ7VAqqD
	smkpvg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437tstfk69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 09:19:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B39J5Ze021551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 09:19:05 GMT
Received: from [10.151.41.184] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 01:19:01 -0800
Message-ID: <0796510c-20bd-4a81-bd60-40aacbcf61c0@quicinc.com>
Date: Tue, 3 Dec 2024 14:48:58 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] wifi: ath12k: add BDF address in hardware
 parameter
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-16-quic_rajkbhag@quicinc.com>
 <142f92d7-72e1-433b-948d-2c7e7d37ecfc@oss.qualcomm.com>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <142f92d7-72e1-433b-948d-2c7e7d37ecfc@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2sj9l3bAucBR50kKxPni91PBON0uv-o0
X-Proofpoint-GUID: 2sj9l3bAucBR50kKxPni91PBON0uv-o0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030079

On 11/4/2024 7:46 PM, Konrad Dybcio wrote:
> On 15.10.2024 8:26 PM, Raj Kumar Bhagat wrote:
>> The Ath2k AHB device (IPQ5332) firmware requests BDF_MEM_REGION_TYPE
>> memory during QMI memory requests. This memory is part of the
>> HOST_DDR_REGION_TYPE. Therefore, add the BDF memory address to the
>> hardware parameter and provide this memory address to the firmware
>> during QMI memory requests.
> 
> Sounds like something to put in the device tree, no?
> 

This BDF memory address is the RAM offset. We did add this in device tree in
version 1. This is removed from device tree in v2 based on the review comment that
DT should not store RAM offset.

refer below link:
Link: https://lore.kernel.org/all/f8cd9c3d-47e1-4709-9334-78e4790acef0@kernel.org/

