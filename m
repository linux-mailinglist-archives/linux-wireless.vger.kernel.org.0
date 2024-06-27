Return-Path: <linux-wireless+bounces-9640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8D4919E0B
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 06:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5041F21F3D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 04:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0817722;
	Thu, 27 Jun 2024 04:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PYCQ+Rmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D02139CE
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719461293; cv=none; b=RvT/vZXwbilI4AWMrCmCuNfTCD+crYOSy2lWgbHqkhuIrq/qP07wRHclQAsbDKk2Mq6mT0mWI41fmgzozR6diPxfDd3+wUjCqa9LG/QpG+fsDRN0CF0G6KuSKrQNk0qr7mP3jwU0k8kqKTQE0kZrD9Uf1TTOqSmSD8ZIcdboP6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719461293; c=relaxed/simple;
	bh=NNdt60iwrsDM3F95AeR76zN8yFa8IYxvZt2qBwV1v6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YIIxsh9635VcNWxenPEDt4yx9CfdsWA8oMYV4cUtwlrhxIth7cFLfVf3LjKmA6BeNJkbjVjOu4ap5mJCK3Qlnzwea17kNXV0bpEzSXVpSc8SDkPo983fi1dsZ1zJweZUxdcKV66/69Y2Bzjdfn+obNNS9Fl3xe0DIGl1vuGtZHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PYCQ+Rmz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R2Tng0025793;
	Thu, 27 Jun 2024 04:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O6kp/pkPhi+MXR4oPkzNr3Hhm4Vyyc6BzroIZwOoWMs=; b=PYCQ+Rmz6MYMBQJA
	evlpSbWoi0+sWywWs0K0mCFSwjVYRf1ENR3MBjFKnA5YV4dGDfJ1f5yFWC+T1F6O
	OrRFRcvFDaQF7/tMtQgKyFLneSeEgcnkZVBQHmOiJU7MaWWW0Ag9VbJ/oDqFtB5O
	RE0YlV7M8NW7zYk8pfYPraG7glD2MG2MP8htZ/+tsFEaKeDom1VLcPEEwFEqZg4y
	b3aFOZo5FwnCX/Yh7IzVdFM0DDh1Q5mmTQYrZtItSacdWMVMJL1x6pVas/TrgFov
	RbFZtq0Yhb2hisNdxlUJmiOi7hio1IltXEpekDFRuLe4g8HmnFYD76vAUvgF7Rc+
	0ow5ug==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnjs2uq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 04:08:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45R4867l004850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 04:08:06 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 21:08:04 -0700
Message-ID: <8117e952-e189-41d6-9ed2-ed10d96f3b51@quicinc.com>
Date: Thu, 27 Jun 2024 09:38:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] wifi: mac80211: handle ieee80211_radar_detected()
 for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-9-quic_adisi@quicinc.com>
 <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EuuXBd_xl5SIbLrf8p8rswjSDfvAevte
X-Proofpoint-ORIG-GUID: EuuXBd_xl5SIbLrf8p8rswjSDfvAevte
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=627
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270028

On 6/26/24 18:05, Johannes Berg wrote:
> On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>>
>> Hence, in order to support DFS with MLO, do the following changes -
>>    * Add channel pointer as an argument to the function
>>      ieee80211_radar_detected(). During MLO, drivers would have to pass on
>>      which channel radar is detected.
> 
> Makes sense, maybe?
> 
>>    * In order to pass on this channel information to the radar detected
>>      worker later on, introduce a linked list 'radar_info' in the structure
>>      local.
>>    * When driver calls radar detected, a node is created and added to this
>>      list and work is scheduled. The work handler takes care to process each
>>      node and take further action.
> 
> Not sure I like that so much, it adds book-keeping and all kinds of
> extra things.
> 
> Couldn't we just have a flag in the channel context or so - there must
> be one, after all? And perhaps pass the chanctx from the driver instead
> of the channel?

Not really. So this linked list thing came into picture for drivers 
supporting split-band 5 GHz wiphy and both of them are grouped together
for MLO. Now, each one of them will use different chanctx as such and 
there is a possibility of radar being detected simultaneously.

> 
> Actually, we're already having to do a channel/chanctx lookup in
> ieee80211_dfs_radar_detected_work() so it seems pretty weird to add more
> complex logic to it...
> 
> Please consider just passing the chanctx, and then we can set a flag
> there, and not have any of this.

Could do but, logic in worker will be little bit complex?

for each ctx in local:
	if ctx radar_detected flag is set:
		append to local ctx list/array
		num_ctx++

if num_ctx > 1 :
	if wiphy supports mlo:
		for each local ctx list/array:
			call cfg80211_radar_event with the ctx chandef
	else:
		warn that mulit channel is not supported
else:
	call cfg80211_radar_event with the first element in local ctx 
list/array chandef

-----

This is because, in split-band devices, ieee80211_radar_detected can be 
called simultaneously with different channel contexts and then there is 
a possibility that before worker gets a chance to execute, both of the 
calls have marked their chanctx radar detected flags.

- Aditya


