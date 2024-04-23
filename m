Return-Path: <linux-wireless+bounces-6734-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3EA8AF6B8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C050D1C2212A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 18:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE371E49E;
	Tue, 23 Apr 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FTr4HNPE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DE1CD39
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897437; cv=none; b=riciLp2ZxMW4SgFNy7bPjMhB6OzX25A+CDd3hlCqCs7nWfnnYVU0aLbJvqZcJo/8rNOp72oe6rePww9yvNfJSSFD0wPruD4XfiezKo8Age6/dF/zhtWZZhkjBwvlh13mDV8BbUseNxkVHcd+VI0I+BA0Fcgmwqrt03YZm6JONq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897437; c=relaxed/simple;
	bh=M0FkjvzzafwnGLjcy6J5h2oE7WhUtTzUndE4hw5Jq3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nAeAA7oqE94iKHHXgA+1AhcQX740y3Oj3E1bhXexQAbCRPBfChRu3jlhCRRwILQFCeUKcQ7YhlHbSlClxOWwc+BsoE72dNnsyFdOlaZxuSPAQM3VIz3aOg5iaENd7DFBpiBigi+k15LxQ68KGyBts6SM6wK9aGyfqc4sig0EH0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FTr4HNPE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N8EXj4007181;
	Tue, 23 Apr 2024 18:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DaSWgmYuXkXhEWmVzATY0t9zHnvMZ5Hl9HRcGkfKMjI=; b=FT
	r4HNPEx8kTXDcdH4EPhTgvxmEOS8tzPJZwIe8NvWFVtwxSyLDHL+nIMKOGjOdbu6
	OkfWiBSZ203hd4rO5lgReq3LnHappBlhPObpyC8bbIsEs4eVu/c/tflKPCQ1BWt7
	R/dSDTT+Uuc2r2DA3lz8+Yo9P7Py7Kh994zWDr0GsTF0NX6l4NaiHNE4QGhUPrUu
	Grs7V1RG7D32gatTE2+n3DHThezax3JQJooyagFMRWUjQuysE4q7cJAtGFnl/rIg
	W9Vr/T66qcBdqQzNFZaDOZ9407q+yeFFGGiKcczqXW0S5lzPUl1QHsMB8lbSU7LI
	f7U8Asw+VADVzeLpOPjA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp9aa1t4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:37:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NIb9dS021972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 18:37:09 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 11:37:09 -0700
Message-ID: <9d75e329-742f-4d3a-bdf6-52ed4de47488@quicinc.com>
Date: Tue, 23 Apr 2024 11:37:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] wifi: cfg80211/mac80211: add support for HE BSS color
 handling with Multi-Link Operation
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
 <e4184e8fb0cd4573564ed8daace08c432757399e.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <e4184e8fb0cd4573564ed8daace08c432757399e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rRbAfDsZ5G5VW8sxi1JDRQrW-ruws91R
X-Proofpoint-ORIG-GUID: rRbAfDsZ5G5VW8sxi1JDRQrW-ruws91R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_15,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=957
 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230043

On 4/19/2024 2:12 AM, Johannes Berg wrote:
> Sparse complains on these patches. I think everyone at QCA should be
> able to *consistently* run that.
> 
> Jeff, do you really have no internal processes, it all depends on people
> running checks manually? We have our own internal tree first, where CI
> enforces a whole bunch of things, and *then* we send patches out.

We are trying to get there but, as the community knows, Qualcomm has
historically had a "downstream first" mentality, so all of our automation is
built around that.

The good news is that there has recently been a massive shift in philosophy
(and one reason why after many years of working on the downstream Android
driver I moved to the upstream driver).

At Linaro Connect 2023
(<https://www.qualcomm.com/developer/blog/2023/06/highlights-linaro-connect-2023>)
Leendert van Doorn, SVP of Engineering, announced "Qualcomm is about to adopt
a developer first strategy" and "embrace open source and its upstream
contribution model."

So more resources are being directed at upstream, including updating CI to
support that.

In the meantime, in my personal semi-automated review workflow I run sparse
via ath1*k-check, but unfortunately that only looks in
drivers/net/wireless/ath/ath1*k. I have now updated my workflow to check all
of the files that are modified by a given patchset, and that flagged:

net/mac80211/cfg.c:4847:1: warning: context imbalance in
'ieee80211_obss_color_collision_notify' - different lock contexts for basic block

So hopefully in the future I'll catch issues like these internally, before
they escape into public.

/jeff

