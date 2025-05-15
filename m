Return-Path: <linux-wireless+bounces-22975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E47DAB7C68
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 05:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7E817DA73
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 03:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106126ACC;
	Thu, 15 May 2025 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nzX44wIs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515C1B3927
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 03:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747280446; cv=none; b=ryVz8zYmqpD4FXm2Kw7xWka5aIo+q4svq1DUb0k4HiwKmeIXheo0UJAAHeioraX7ki90WsNI7F/X41B66tDyiCye0Lg1QlB6lhRKCcGGmd7mRNI18nPKFwOtwCN49xwILaPYheTlAAIkbKepH5Kq1N9m92V/EjfTjiDXBLDLpEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747280446; c=relaxed/simple;
	bh=W1HuRom9HIhItJQVqQIn+cl4zAjZnBp2Ev2hG6E7yyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DQfeLslcNN6CPjNaP+mH5VOJR2zyKCs0rno7+D+IkYMZYfgUjFGjuHwiLudsKhF1ud3bi/NhXSTBlDK8HApVNpO0wYEW+A6DYF56xLTaQGCKXTUGKlORH+05OFzleCcE+HTtLbEARcQoOtVmPPZ2indcOxGBn9cpR4L5ujADXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nzX44wIs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EKpmrh025457;
	Thu, 15 May 2025 03:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83ze0VGVC3zLVuFj5TDfWLwjeHeLhdTqint7yXZyavg=; b=nzX44wIspTP4o+I7
	gxvdPu1vUkGjpbFZV17z0kPgvT0LwLBf+W3r6uywvAontC6JJvPuL7KGk6VSVwrJ
	qQwb9W3UMlDuh1cXS6U0YnQkOg0ii0yMbzZcYW1XuallJmSTvN1zVlawW9Gq+uS3
	9fOZpkXO1YRPrHer+R/rtqbsT1gUsXeiSjhcL6DS/Cz66G/jy6/wmJQJjtTx1Qk0
	Wz6w+caiGnijP51mYn11gu0Y/tlrS5EM7N61NCc2ukme86HqlcZiKVMkLwW0WgUm
	t4WGP9MS3b0CVnwrFQvirVjNOIAul11fJ9SnxD6e5EbHbIFd6ezXzSpS+P7xb4SH
	nHgsZg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbew4qkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 03:40:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54F3eW9O014402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 03:40:32 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 14 May
 2025 20:40:31 -0700
Message-ID: <e3c01438-0975-4213-8066-f1df32a585ee@quicinc.com>
Date: Thu, 15 May 2025 09:10:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v7 05/10] wifi: cfg80211: allocate memory
 for link_station info structure
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250514164857.227540-1-quic_sarishar@quicinc.com>
 <20250514164857.227540-6-quic_sarishar@quicinc.com>
 <25b89deed3bb6871109fa94c3c967a27a35e3d90.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <25b89deed3bb6871109fa94c3c967a27a35e3d90.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PfcrZF304skpdWNFH2pDOBnt8h61JID_
X-Proofpoint-ORIG-GUID: PfcrZF304skpdWNFH2pDOBnt8h61JID_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDAzMyBTYWx0ZWRfX49bzL6jsi46q
 Hi0jWNcuV7JfvP6eZk0fCbP456WHh6Gc3fCbeQhT7YqgCWzDc2wP0u4/9LXf3YpPCENFxC9ysaD
 j5OwCieFifTx5yE5XcX+YqErndoHu2mR9MOfz1c6qkydZK/EF9xUCEX9zbfmhhv7r+MNTlufUEw
 E5CFpE6NgowrhiVL+2TV7D1AX41nHj2mMJVj1YAYuxKWUMAPYpzna74QdtL+rxgVvgtaME1P4Tv
 WcusMOuepS63uo0oS7qLmpGF0B2xpXINkXrjaFFKbOOxjVxkvIEyzPLQ2HYi7lTZBGR0PP5+jGK
 Ee4sUS/gitfAsRVcY2inw/NLimxRcEVlrnAwEhyiV8faXWGlqlwY2h+0zAbcOMUS+td58Rxss2m
 iAi7emnJD7nCYRKJ69sQ39DmrJLwweS1q0HmGT7Bsiqt0rJ/qBauakFC//n920MB+4RxREPv
X-Authority-Analysis: v=2.4 cv=LOFmQIW9 c=1 sm=1 tr=0 ts=68256231 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=stkexhm8AAAA:8
 a=EeR8soJtryZRNb31oUQA:9 a=QEXdDO2ut3YA:10 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_01,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=986 impostorscore=0 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150033

On 5/15/2025 1:23 AM, Johannes Berg wrote:
> On Wed, 2025-05-14 at 22:18 +0530, Sarika Sharma wrote:
>> Currently, station_info structure is passed to fill station statistics
>> from mac80211/drivers. After NL message send to user space for requested
>> station statistics, memory for station statistics is freed in cfg80211.
>> Therefore, memory allocation/free for link station statistics should
>> also happen in cfg80211 only.
>>
>> Hence, allocate the memory for link_station structure for all
>> possible links and free in cfg80211_sinfo_release_content().
> 
> I'll probably take a look myself tomorrow in the interest of getting all
> things lined up for 6.16 quickly, but chances are you'll be at work a
> couple of hours before me (and I'm not really all that awake now), so
> pointer to this bug report from the bot:
> 
> http://wifibot.sipsolutions.net/results/962902/14088291/build_allmodconfig_warn/summary
> 
> Says some locking issue.
> 

Oops! my bad, got it now.
let me fix it and send new version.

> 
> Also, is there any specific reason to want to allocate each link
> individually? Why not allocate them all together in one bigger
> allocation? Doesn't matter much though I guess.

No, it doesn't matter much.
Sure, will allocate them all together.

> 
> johannes


