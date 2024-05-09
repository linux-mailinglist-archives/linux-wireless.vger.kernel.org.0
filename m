Return-Path: <linux-wireless+bounces-7370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6718C0A6E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 06:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 403941C20E26
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 04:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AA147C6F;
	Thu,  9 May 2024 04:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bYNy9nQp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFCCD26D
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228588; cv=none; b=hGpqMxn6/XUoYo8PshcFS8H1Z3dBxMNV6cPsFt+GyGuC3z9X76Fg2vew0QYkKlBy8b8l/BfqZ3vtYXxItZIaL9YsdJR466bXo3uXgPug3pTHb4NjfTo6PBX3XqS0N9vWPna3ypE1OIOFwv+dAdPWDgj6DxPDx68/EmIkbkh3eWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228588; c=relaxed/simple;
	bh=B+Pqiio8rouKqw0u2Yz4tw0lqGIVlCH6/rh6kM8pTCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s9QQhsstaf1VrXSF246HpgCQISG7hsiVjvT7WU6IvMXe1u0DtCwzIm4jEzJ7qCZ/QZromQ4EiinR3HQjU4fW7j3RPrbme+x1huBMX6GwgQAqKpLj5K9WzIWl5Ao+Y8AME/V7zxkMqFGZc0jZfib9mZCabztgyMJ2o2tW8N9pG+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bYNy9nQp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4491tqNG021431;
	Thu, 9 May 2024 04:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=J8JbVFtP3tF9xOR9zx0M/q/VKzZHQdLU9i9++yVm2YI=; b=bY
	Ny9nQp/WHmDA4xK/gE5q8NsGZLPK+a9eiO5EkbqAcJW84TGDblUaTl4yUhmRONZI
	e9PWfB3toX8nadupjTjG45s9Jqxds0JTMQYIv/EfgtD7CQgIGp562vVYe5CBYSDR
	fkdo4jOq1u+QKoJ+RNa76kbT4PH4KaPRvGv3vw8ECzwYyVbBKlvIP5NLSP9eCNh4
	eorCqD5zEHHzYjGWO36gtq2cX8CuVj8hgwhEGyESbwgE3VBF6sH3nJ2uYiAf1nYJ
	l0iHgJQ4qru5sWvoLCcnyf2RI11uq9DnQPT68SYjLJ9RWhE3cI7pGVFyxlWFwmf6
	rj/x2hOnTk2UxpUpHqDw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y09g5hqdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 May 2024 04:23:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4494N04R005656
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 04:23:00 GMT
Received: from [10.216.41.86] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 8 May 2024
 21:22:58 -0700
Message-ID: <4dd39edb-cd23-482a-8c94-b09142d92198@quicinc.com>
Date: Thu, 9 May 2024 09:52:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: move radar detect work to sdata
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>,
        Miriam Rachel Korenblit
	<miriam.rachel.korenblit@intel.com>
References: <20240506211311.43bd82c6da04.Ib39bec3aa198d137385f081e7e1910dcbde3aa1b@changeid>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20240506211311.43bd82c6da04.Ib39bec3aa198d137385f081e7e1910dcbde3aa1b@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _wHXDokk0uFzHyzHigRM_aNS4sNgZ1iG
X-Proofpoint-GUID: _wHXDokk0uFzHyzHigRM_aNS4sNgZ1iG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_10,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=822 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405090027

On 5/7/24 00:43, Johannes Berg wrote:
> At some point we thought perhaps this could be per link, but
> really that didn't happen, and it's confusing. Radar detection
> still uses the deflink to allocate the channel, but the work
> need not be there. Move it back.

I'm currently working on MLO DFS support. It is better if the work can 
be left in per link structure. With proper support, instead of deflink 
it will use appropriate link.

