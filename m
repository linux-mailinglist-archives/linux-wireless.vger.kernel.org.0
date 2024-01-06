Return-Path: <linux-wireless+bounces-1543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159E825D80
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jan 2024 01:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D121285243
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jan 2024 00:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C650D15AB;
	Sat,  6 Jan 2024 00:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oJ13mZ52"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DED15AC
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jan 2024 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4060K0YW027423;
	Sat, 6 Jan 2024 00:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=PYzHPuGaIcq+wJave8/VhoIIsIA6M1QK14QMgQQkL2E=; b=oJ
	13mZ52A7ysZXcDnHTe66bmcKAJI3vH4WnfR0blncoeh2zNfEEXokeRbJMrGDFgAs
	IK2JjACbCjI7485uQU0BKqhrMRCdMTzBNQo9gi9NqH0OoGPu0/SMbQJ2iH1yJMl1
	P0blCz5KTUpArARSlCHdwOWObhHwHwBBnDzIlTNGbHwccyqJ6/0iG8wJrrgD49r5
	Qw8Ru2EQ8kEr8U7BV05edeo85bGOpJbfcy1ohxeg3xDVf2xnRuYzUtikbayatmXE
	5d7WVL8wPTQY04teLqrpnzTujM3T6OeNOh/MhG9tjapIBUADQ9DOfjRo7m63qsis
	9hPdYhd1dxefdddRiyXw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vev7sr1y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jan 2024 00:56:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4060u59w011094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Jan 2024 00:56:05 GMT
Received: from [10.110.42.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 16:56:05 -0800
Message-ID: <fb5144cc-a414-4fa9-a1d5-4f063fd7b57d@quicinc.com>
Date: Fri, 5 Jan 2024 16:56:04 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iw: strip NLA_FLAGS from printed bands
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Matthias May
	<matthias.may@westermo.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Zefir Kurtisi <Zefir.Kurtisi@westermo.com>
References: <20231221222842.1310957-1-matthias.may@westermo.com>
 <6a54a2afd9e2b1b67822e3ca9b86654e3886feef.camel@sipsolutions.net>
 <728b6538-19b3-4fb4-b91e-f72080c4c9f0@westermo.com>
 <b39657b8e248443b1b728e81fd194942a02826d8.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <b39657b8e248443b1b728e81fd194942a02826d8.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wTTqpSiKHiyQSZb_4DlzTyhBFob8cp1_
X-Proofpoint-GUID: wTTqpSiKHiyQSZb_4DlzTyhBFob8cp1_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0 mlxlogscore=382
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401060002

On 1/5/2024 12:36 PM, Johannes Berg wrote:
> On Fri, 2024-01-05 at 21:35 +0100, Matthias May wrote:
>> We saw that happen on one of our platforms where we are forced to use an 
>> out-of-tree driver by QCA (SPF12.2).
>> If you think this is something that can not happen with upstream 
>> drivers, feel free to ignore this patch.
>>
> 
> It should be independent of drivers, so they must have modified cfg80211
> to explicitly use the nla_put_nested() instead of
> nla_put_nested_noflag()? It's just ... weird.

Indeed. Matthias do you have a QCA support contact? You should open a
ticket with them to address this issue.

/jeff


