Return-Path: <linux-wireless+bounces-17873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF59A1AE15
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 02:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5713A7A1210
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 01:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558541C6C;
	Fri, 24 Jan 2025 01:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BTckb0eD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2A4C91
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737680837; cv=none; b=HTQIDNztWT1NEqkQyNtEJieE1KNezojkcUJaW6jM6gvP0rwZZIYITEDo4SXbMrc/rrZQk9SZFF6F8f0Tvu4kAXp8U/kPtOwT+iysk+Lx3IMtNo2YQenfFiyI84yGTIYkh7eYgp4onxcUcSV35mKp5xcwHhUi8lc0HkKB9JShCeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737680837; c=relaxed/simple;
	bh=dfT0oagw9ZwfU+xGitsK3OnB62wYS2Gudi/s6twULwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qwjxybramqcgdDWaE1oe4e10gM/fr3wP5xl7CIXy7UqoFxOsZBLTn8gfOIyGRjX1lmNdN103cHO7KaaRhWqGl1PLofocdcX3QcTvS2XVW45e1BgFXMpLD1NzFbx0jbD4iSNhvxi2hlos/ydbAjhhll8aR8DDzuyUh5RhnTNOq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BTckb0eD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFoSPL021309;
	Fri, 24 Jan 2025 01:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jnzf1dUR07L1zvCIHDCpIhQft6fe3tiV/UuCK3QeC1U=; b=BTckb0eD8ADXjqp0
	pjO7hUjKwvwJ/uR5dFtgiGkAPG1R3Qys6bq4MngCBGP0s7gZzGO2Vc7GrJLFt3NI
	4i6TilOk5ShFLMWpfJhrsDi7PbKnnnjqSVUFCycuT8HWfURjdin/snQuC/1Im6Bh
	D5+ajqYTu8LS+VoqV2cWJj39G2KgwPUz3CgFveTlQO4F2OCXk8eIkH106dHW/V7d
	XkUk16gWxfgn1Bu3/5SXQepTRDuKSBjEfQ2bkFp85iojg1gJE2+NyOZEl7MVLe8R
	mYT3PdGoJywE7OGAzEgaF5Pdz9Qz4FkjszTA5e3VW+8cy/IwQusFrnpEtDzeW6pd
	8QPNcA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44brs0h1ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 01:07:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O178Xw029278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 01:07:08 GMT
Received: from [10.227.108.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 23 Jan
 2025 17:07:08 -0800
Message-ID: <8755c0c1-86f4-416c-a91c-e8bd7373423e@quicinc.com>
Date: Thu, 23 Jan 2025 17:07:08 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 4/6] wifi: ath12k: add 6 GHz params in peer assoc
 command
To: <mbizon@freebox.fr>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Avula Sri Charan
	<quic_asrichar@quicinc.com>
References: <20240508173655.22191-1-quic_pradeepc@quicinc.com>
 <20240508173655.22191-5-quic_pradeepc@quicinc.com>
 <600e45a74fc3ca1bedc12c273a84966fdfa3d908.camel@freebox.fr>
Content-Language: en-US
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <600e45a74fc3ca1bedc12c273a84966fdfa3d908.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7Q8A0Lqv0uzYTiKz2xSiMvb0qdmyUwh6
X-Proofpoint-GUID: 7Q8A0Lqv0uzYTiKz2xSiMvb0qdmyUwh6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_10,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxlogscore=968
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240006



On 1/23/2025 3:35 AM, Maxime Bizon wrote:
> 
> On Wed, 2024-05-08 at 10:36 -0700, Pradeep Kumar Chitrapu wrote:
> 
> Hello,
> 
> This patch has been merged, but there may be a bug here:
> 
>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_40)
>> +               arg->bw_40 = true;
>> +
>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_80)
>> +               arg->bw_80 = true;
>> +
>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_160)
>> +               arg->bw_160 = true;
>> +
>> +       if (sta->deflink.bandwidth == IEEE80211_STA_RX_BW_320)
>> +               arg->bw_320 = true;
>> +
> 
> 
> Downstream driver does this instead:
> 
> if (sta->deflink.bandwidth >= IEEE80211_STA_RX_BW_40)
> 	arg->bw_40  = true
> [...]
> 
> 
> So for a 320Mhz STA, bw_40/80/160/320 are set, resulting in multiple
> bits WMI_PEER_xxxMHZ set the associated WMI command.
> 
> Which one is correct ?
> 
> (This is for EHT, but the same applies for VHT/HE code)
> 
Thanks for reporting Maxime, Will look into it and fix this soon.

