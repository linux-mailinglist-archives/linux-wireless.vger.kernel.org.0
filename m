Return-Path: <linux-wireless+bounces-3859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C87A85D868
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 13:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1867C28614E
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D06469954;
	Wed, 21 Feb 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D42+SIG3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A169947
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520073; cv=none; b=QQTmGoVjvWtrJ2WfccakelJMMMZAjCHLZZSFRmubXMO/ECGi5ljE5sB/kPiyUaiGAJkCzxfbSk3WroLDvIcFGZq+MOGIs/iMgzoGdilepoiaOGR9nV6IE3/gLYoY23RFdYw5X0iIDB729SEczz0uEnXMz3jkIIUemgwnJosSsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520073; c=relaxed/simple;
	bh=iu7n/rHLYlayrKKQSptZK3p3ZjI5fmMlZAwxeZlnScY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HQOXmS1B3ewZeasuJ8bCnnCB3jzSKtdVRg5+ww9yi5BPiQJh2oyHZCQ66R11RJLWH9m+K1DSs3UM56tcbmxLo1x442TB79FphXSy6iPEfyzC8g7yf+tmIkxR+y621lX6MKyLEjLepAp8lWIblPeqtxOeLa+51EkyAC/dLRgryfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D42+SIG3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LAkQ0q012357;
	Wed, 21 Feb 2024 12:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WE7OkHCA0dIhmdoc+dysD8TIzltPFciEPaJhKydkHGE=; b=D4
	2+SIG3IgXRZ9I9yBICutkunqGcncuyGzhlKkP03Adbpyyd3pM78I56iV/I3jMweT
	Bbg6fGo9pvAgW+tiDMK56P+Qo/KwJOnnp4aP2Np+g6EJn/SyY0gUPWOZKfLOlMQD
	DZ2P5t9eDaVxlMhjg7h671gxShlU/FA/9o8pMGJ+6FsL5TYbsW8s+6bQplTjzISY
	C18snW3zYpMV3ZuTx3ExL+nbio5WVQzOvgchaI8sOtnnSt4lky3HQXttk3J102Ww
	Uyfz6I8ov+CkhdhEDE4wobuqgyUvNwZk3Bk0oKgibjcY8OSvujj1bgUQdpFU/Mwg
	528K4FWYmJ4SkNKNGovw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdfqa08ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 12:52:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LCqH9U014644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 12:52:17 GMT
Received: from [10.216.12.189] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 04:52:14 -0800
Message-ID: <beee9cc5-6174-473b-bd57-1101430f200b@quicinc.com>
Date: Wed, 21 Feb 2024 18:22:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Ping-Ke Shih
	<pkshih@realtek.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, "Jouni
 Malinen" <j@w1.fi>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Felix Fietkau <nbd@openwrt.org>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
 <20240130140918.1172387-5-quic_adisi@quicinc.com>
 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
 <5a89e63fb7644d12be72154c90c96199@realtek.com>
 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RGLVr42LzJ6fJjA7-9PE3kQjw5bcZYyE
X-Proofpoint-ORIG-GUID: RGLVr42LzJ6fJjA7-9PE3kQjw5bcZYyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 mlxlogscore=858
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210100

On 2/21/24 13:39, Johannes Berg wrote:
> Qualcomm:
>   - copies and updates CSA/ECSA elements all by itself
>   - btw, not sure here about probe responses, does it do that too?

We had a thought about keeping this CSA/ECSA handling at host/kernel 
level only. But the major point of concern is _synchronization_ among 
firmware of each of the links participating in the MLD.

* Even if we ignore TSF/TBTT synchronization for a moment, how firmware 
will know when to transmit the beacon with a particular counter or when 
CSA has finished on other link? If rely on host's update then there is 
room for further delay and hence errors.
      - This is because, counter value on the reported link depends on 
the last beacon transmitted by the affected link.

* Host can send the template on all links but how to ensure that first 
template is reached on the affected link and then only on the partner 
links? Host will queue the command properly but reaping of the command 
on n (no of links) independent firmware can not be guaranteed in the 
same order in which host has filled. It depends how busy each of host to 
firmware path is.

* And then obviously, considering TSF/TBTT will be again complicating 
the synchronization part and making it more difficult to manage just via 
host.

Hence there is a strong urge to let firmware handle all this for beacons.

As far as how firmware will _magically_ communicate among themselves is 
concerned, we have *IPC* in place to achieve that. One link firmware can 
talk to other link firmware when required.


				Kernel Level
____________________________________________________________________________
  -------------- 	      -------------- 		 --------------
|   Firmware 1 |  <- IPC ->  |   Firmware 2 | <- IPC -> |   Firmware 3 |
|    on HW 1   |	     |    on HW 2   |           |    on HW 3   |
  -------------- 	      --------------             --------------


Hence, host just needs to update template of the affected link and 
indicate to firmware that it is a critical update. This firmware then 
can indicate other link firmware(s) to append CSA/ECSA IE with a given 
counter value to its beacon via this IPC. Parsing the IE and 
de-fragmenting and fragmenting it again can be done by firmware itself. 
(Agree that it is bit complex but when comparing with complexity of 
maintaining synchronicity across links, this looks more doable)

Hence we have taken "offloading beacons fully to firmware" approach.

For probe responses, it is handled in host/kernel only. Firmware sends 
back the last transmitted count in beacon to host. So we have the last 
transmitted count info. Per STA profile generation logic is also there. 
So we manage via that.






