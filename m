Return-Path: <linux-wireless+bounces-16326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9F9EFA96
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AA728DE48
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D4422488E;
	Thu, 12 Dec 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pwkZGxdz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B596D2063F8
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026911; cv=none; b=bFEhi14pgVGO7+C33KFulnTetVplF8T7E6MlzMZb4IBrBCxLHnCFpwcuPeX2z7bBmHHP/wNKDZiUWJSy5sURMRL4ajsQQVrLaoiw/vh9ah/oLn58H5PAJDztJ9SFVsNQSJo2DFDwXF4Mlne5XC/Gn9zUfpiietXpus8SVl7X0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026911; c=relaxed/simple;
	bh=A4SoHROMcA/b4c41oXY+uc3schTEq/Qz+rWDBhibBfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uwEEqfiE5RJMWROlNuxjcpr0aGM+yMyJTSZfrdtfj6al8IqGihSgCVFqr2E60boJlFB9PS964Ha27z1kyUpgCyC1pF679kKsquJWQ79P8+yTf4nXAsQvN6KFX6uBCX02DRBBScf8q2npkb4/RWyffkU2Mf9EMUm68X8Khc3ndxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pwkZGxdz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7qAOE032186;
	Thu, 12 Dec 2024 18:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cKRHSSkFO/9qxXnX4VdFN+ENGR4IipewyVU2OtOSgwE=; b=pwkZGxdzRXJ2Gniw
	egccIPPzOALI1zJcCjw5zl0F7E4zSWN7FXq6aBopmGg2igmA1nQEXl0TTn8NzO+u
	5O75YYwy2FbnCHyPjFzFlZ15611kxQfrfwXQDFnmkRdLmUahptn5OJeOSuG1MYp5
	qvF77DYJbYa6psPR8h0a+nHNOZM8DdNXL014A2275bagC+eElqhsb2PR4AVwvoGC
	uQJnmAxN5wNbCoiAGuj9Tuf2feVtgxrptgmDEvWngD26TyoNN9MVRQ4Xsg4975WD
	OTQuLayy4DOIhXVKWA+5OWfgQ6GC0yU9ac5WtsMbzTFZFNswirZuphDKeEr0Pa+O
	BvcHNg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43f6tfd390-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 18:08:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BCI8Caa025893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 18:08:12 GMT
Received: from [10.111.178.2] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 12 Dec
 2024 10:08:11 -0800
Message-ID: <ecbd70dd-9274-42b6-9673-9c6d82c4e763@quicinc.com>
Date: Thu, 12 Dec 2024 10:08:10 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Christoph Hellwig <hch@lst.de>, Baochen Qiang <quic_bqiang@quicinc.com>
CC: Robin Murphy <robin.murphy@arm.com>, Tim Harvey <tharvey@gateworks.com>,
        <ath11k@lists.infradead.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "Marek
 Szyprowski" <m.szyprowski@samsung.com>,
        <iommu@lists.linux.dev>
References: <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com>
 <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
 <20241209081714.GA25363@lst.de>
 <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
 <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com>
 <20241210041133.GA17116@lst.de>
 <CAJ+vNU03Cqsc+O5anwmvJW8Wfd-06LbDMVHjxVFdixf01ZLczQ@mail.gmail.com>
 <5fe372df-ae51-4a8b-9fa3-a4a0ea2d33e3@quicinc.com>
 <9b2e8ffa-ba2c-46da-a478-eb1fb44b693e@arm.com>
 <80992ae5-e329-4a34-94c8-9345b2e8a9a0@quicinc.com>
 <20241212071848.GB6638@lst.de>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241212071848.GB6638@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PhVrHVHMthQseaX3U30Djw5Jr8uC55Ie
X-Proofpoint-ORIG-GUID: PhVrHVHMthQseaX3U30Djw5Jr8uC55Ie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=924 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120129

On 12/11/2024 11:18 PM, Christoph Hellwig wrote:
> On Thu, Dec 12, 2024 at 01:24:45PM +0800, Baochen Qiang wrote:
>> yeah, you are right, Robin. didn't know there are convenient interfaces
>> like these already.
> 
> FYI, the DMA-API documentation says pretty straight forward to not
> use the streaming API and documents these interfaces.  But maybe it's
> not clear enough, so I'm open to suggestions on how to make it more
> obvious.

This is probably less of a documentation issue and more of an issue with the
fact that each instance of the ath driver is based upon the prior instance,
and hence it inherits any usage of legacy APIs. So unless someone notices
there is a better API, or proactively adds the usage of the new API for us,
the ath drivers will continue to use legacy APIs.

So it is appreciated that light has been shed on this issue.

/jeff


