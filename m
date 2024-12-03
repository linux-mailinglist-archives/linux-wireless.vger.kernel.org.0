Return-Path: <linux-wireless+bounces-15844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851499E16B0
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 10:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5981D1605FD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Dec 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1751DE2B8;
	Tue,  3 Dec 2024 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qm5aNgCY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409181CDA17;
	Tue,  3 Dec 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733216849; cv=none; b=LMtmgo8DNPNoWL2FO7hJ4NVsy7zJUasFXYUcfwQL/fhw3waIU+j5pcOZxMFf5L1SU3CCn16ZPmhMsWklgnLoEP0YW0C9hZ+RQVd8U2HG+y4ihJC9RhMVyTL/+8Gd2VWKxBMJdprAXSXZOCIuOpvDMJxu22pSfUY1eNw1DaGCFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733216849; c=relaxed/simple;
	bh=l48q8oP1OscIa/GBWs7ZNmtUnlFbM6Db6h9pXlpl1Cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tDenPDtmMVvg58S/2pYfegz5iQR6EcsDOAwhLQ/v//0rht3rsbSLwL/04ThULCKdqu3sQL9jtrQGVUmRrh3uH7v5u9R+wgJSuXgD+KQJGyjk6kgVR6BKZ+3nwT+z9G7z4o/TXbgQ3LfVABtJKdoeVJx3kEJawFAQ1ZBhK86sgcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qm5aNgCY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B37n2FX003843;
	Tue, 3 Dec 2024 09:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dKAHM6gB6y5e5pwi+Dr68lc0+ueibn3zjXdtb/JYQzw=; b=Qm5aNgCYeRoiGiU2
	e8uCBHl8G3PyHnmPoP+n5LsCschUidNeAq7K84jAPrXFf3prTVj6hxhGV/8E+CE4
	UbV/HlwI9xBc7mHDHTu8kdD1k8XoqCUrd014K2Dbl+LYHthhgFurHZAPt3T+kMQs
	pxdbS82+OpLfUwNJFMNYcKiF1T4zKLk7yrxdP5UHhYQgesHG73K/M5eRFKQPUeys
	Q3GR1+Fm26ukkCvaIbirIPpo+RBYTwUoKGhB7LV+B+rdxH+2Gkwny00lGMlNLo6W
	UDGvkb/HQkGTqdFJ/7LArjIq3zFuW8XBbBEp1kQyGCFQDxzhnb2Z/QM8jAkpelrk
	qAmTQQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437uvjyck3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 09:07:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B397HYO000533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 09:07:17 GMT
Received: from [10.151.41.184] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 01:07:13 -0800
Message-ID: <4db4c390-094a-425b-abe3-1b8e881366b4@quicinc.com>
Date: Tue, 3 Dec 2024 14:37:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] dt-bindings: net: wireless: describe the ath12k
 AHB module
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Kalle Valo
	<kvalo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20241015182637.955753-1-quic_rajkbhag@quicinc.com>
 <20241015182637.955753-2-quic_rajkbhag@quicinc.com>
 <qzjgpwemwaknwbs3dwils6kaa5c3inabfvkaryvc32kblzfhy3@6yduooj4dk63>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <qzjgpwemwaknwbs3dwils6kaa5c3inabfvkaryvc32kblzfhy3@6yduooj4dk63>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sLoadAbg97qacDOoN3q0Vcsve5WZA8dg
X-Proofpoint-ORIG-GUID: sLoadAbg97qacDOoN3q0Vcsve5WZA8dg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030078

On 10/16/2024 3:58 PM, Dmitry Baryshkov wrote:
> On Tue, Oct 15, 2024 at 11:56:16PM +0530, Raj Kumar Bhagat wrote:
>> Add device-tree bindings for the ATH12K module found in the IPQ5332
>> device.
>>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
>> ---
>>  .../net/wireless/qcom,ath12k-ahb.yaml         | 293 ++++++++++++++++++
>>  1 file changed, 293 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
> 
> Generic comment, please add qcom,ath12k-calibration-variant
> 

Thanks, will include "qcom,ath12k-calibration-variant" in next version

