Return-Path: <linux-wireless+bounces-6627-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D848AC388
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 06:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED64B2114D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 04:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2151429B;
	Mon, 22 Apr 2024 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="boNvCL/a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24D414269
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 04:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713761900; cv=none; b=QM6lWckYw2PPfUe8Iui3FRIU+qbST1M3GiIwGjpOkQQGg7w5af+J/FBb8IlRC+yselmp6SIab0ahqPMSespHLdKCHCRhrlLKH6VarGkEjgo2vBH2OBgajPbaELMCrcl1IQNgzPfkZvrAmDtXsxtdHOgvKgWtnQacUKZFfFAN0sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713761900; c=relaxed/simple;
	bh=Ykd8CbX8bkgkrZk+/J/8yoqrOa/hvifDryyrwyAs5u0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GKibKfrA/xL00B732+bRZW6ezOSAGRgw2FpXtQ38gS/p9jHEmzeZJjx/dJ/BImcDsd0gOuw1bjF/ffsdHFcnWwBXqstiF8n5jkNOtnElXjBO9XRWC8Bg7DhYF8PSakDqnrk/uh4mzeSzohfPE6edTTdm+Yc/4lxPIQNBiwf1KCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=boNvCL/a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M1QCZY018040;
	Mon, 22 Apr 2024 04:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4RO20pHeoKRZYrVOJ9Fy5M6bQiyiBajWHiUahAxQR1c=; b=bo
	NvCL/aa6Zox/fNzzM7h/RMYhcLsCTBNoXs8JtLjtB86isHD4+LGUYuTcxL1w1PlA
	cQwI/58JqP+OoL+cGMr1gqxvC8I2LbjhIgRAXPijCobvPV8dARJtw8hI1CvlHjBP
	cw9ugV2uEcIn0955oA8usX9VnlA1bS2ozhkSwx2EmTXyXBjQXKiOf00/Q3CVeqLf
	fIkeojxQijEh98pTa1HYNAHKR9Rwjr70sLANGtU5D7bzbS95/fpGD4KMqEczyA9C
	ANOB4xyPtdpPEGGSl9LF3L93S/Wg4ooPS983LSWd694PUmDcsFG86+wpE72ghsVr
	HUKYwJWnY/A38on7ZyFA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm49nkb6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 04:58:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M4wBWH008246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 04:58:11 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 21 Apr
 2024 21:58:10 -0700
Message-ID: <5a2a6131-b224-400e-8f9a-edea9c41710e@quicinc.com>
Date: Mon, 22 Apr 2024 10:28:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] wifi: cfg80211/mac80211: add support for HE BSS color
 handling with Multi-Link Operation
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
 <e4184e8fb0cd4573564ed8daace08c432757399e.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <e4184e8fb0cd4573564ed8daace08c432757399e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I6oOH90P9_JyotEPUZGuC0-ZuFytBHMN
X-Proofpoint-GUID: I6oOH90P9_JyotEPUZGuC0-ZuFytBHMN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_02,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404220022

On 4/19/24 14:42, Johannes Berg wrote:
> Sparse complains on these patches. I think everyone at QCA should be
> able to *consistently* run that.
> 

Oops! I don't know for some reason, this got missed in my manual run. Or 
well I was using sparse from Ubuntu (apt-get install sparse) which might 
not be the latest (and that prints a lot of warnings on ToT itself).

However, now I tested on ToT from sparse.git and I see it complaining. 
Let me fix that and send next version.

> (Also not sure why no bots complained about this set, it's been a few
> days, but who knows, maybe they're just behind.)
>

Yeah even I'm surprised how come bot is not able to catch it. But yeah, 
missed from my side as well, sorry for that.


> Also this set needs a rebase now with the kernel-doc update, but I was
> even willing to do that.
> 

Sure will rebase it.


