Return-Path: <linux-wireless+bounces-3944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5BF860895
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170611C22EFB
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF46B645;
	Fri, 23 Feb 2024 01:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dypjd1aR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33843209
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653400; cv=none; b=UTx0j926nMShbVcb39HbCGHgfEvo6RT5sg8+wENfLOq3b82Zx8TaTPXIl+W4JBu234tB9ZLHshr+dxcRfdYTLPG6PuWRAcJ2aM37NZbi3DBclWUkTbqhWYIKLpC0TrXRcPLse+VxH+SqGIWsnB6ykvWEeqZwhrVSc4z3+u4HkGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653400; c=relaxed/simple;
	bh=88iqeWFWWrc0MuqMEmIzLg6YN2sEb0+IUV5+yWb9oYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aBxvznMZnUdba9hGA1fKittzW/h/itxCKduh8GsP86wQGVMSM6yet5wkuFK+FGl69QAQagmaEBV7KntwFoES+5Ixl/E+r/ogseJe+laHqaAM3D5MbXl1Ja7R6G3zG19dtO01Q+F+FrSjBiKi0T0+yJv8MwoH20t9X8x+U9ZJvT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dypjd1aR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N1GJQi030552;
	Fri, 23 Feb 2024 01:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/4LHV7qGsFNctQERPBvGY2nISXG2Y31BrMexbTCzEzU=; b=Dy
	pjd1aRZGTe1iRzUvKKN2IKewfWPsP16+A57il+WPIzl1ZGrq3uQ7JlvE4ZouqacP
	T73u8Z3siUOxWlptG9sXNqmDrRXX65fIkNO33tgrGnVuSGHVhtqR6bl+QBnumYD+
	SD7gPL/OMmqrQPucf3yQeZo/g886fTrYnd8uVlT7/valZHMcBpSP8gJdEzDxrhAk
	EBO+rGvOkYSdrjDtMEFry2f7BtMUmhzOQFPExLkBQJd+lt2k1dbxZaaxIZPINbhb
	9cwbBD6zRdRwH73aWKYU7rLhhlrW31HWaHQ/OHQFSJPc+Gk4y3HW4si7mmIvGA7Z
	7u3W/oSptmZFKOuR+AJQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we3231sya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 01:56:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N1uGBj022203
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 01:56:16 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 17:56:15 -0800
Message-ID: <df35ce71-84dd-4c2c-af9a-820cb9a71291@quicinc.com>
Date: Fri, 23 Feb 2024 09:56:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
 <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
 <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
 <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
 <ed8eeb92-e1eb-445e-989d-2340c26faf44@quicinc.com>
 <7a62031b-ad1f-4da2-8217-19a5d7fdc0f4@gmail.com>
 <f363f179-b41f-4bea-882f-e4aacb8ad519@quicinc.com>
 <eaeb8e9b-3809-4f89-a5b2-7949aa01fbde@gmail.com>
 <026d9ba3-525d-4a12-8d03-5fece818330c@quicinc.com>
 <0e8ad2c2-cc39-4903-97f7-c3ffb525e61a@gmail.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <0e8ad2c2-cc39-4903-97f7-c3ffb525e61a@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zw4c1t10bJX-PTpV5eJ0pQBsTlveKi0B
X-Proofpoint-GUID: zw4c1t10bJX-PTpV5eJ0pQBsTlveKi0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=500 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230011



On 2/22/2024 11:38 PM, James Prestwood wrote:
> Hi Baochen,
> 
> On 2/21/24 6:26 PM, Baochen Qiang wrote:
>> But you are using monitor mode, not station mode, on ath10k, right? 
> 
> No I'm using station mode. It looks like ath10k creates a monitor device 
> to receive these frames (that was already done before my patch), but the 
> interface I'm using from userspace is a regular station interface
> 
OK let's forget what ath10k does to receiver those frames for now and 
focus on ath11k. From what I got from firmware team, it's expected that 
ath11k station interface can't get those frame without a scan because 
device A is connected to an AP already and is supposed to get frames 
only from within the BSS, apparently device B here is not within that BSS.

> Thanks,
> 
> James
> 

