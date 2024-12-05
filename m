Return-Path: <linux-wireless+bounces-15922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5439E536E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 12:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575C7165567
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AEA1DB92E;
	Thu,  5 Dec 2024 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gdlpBoF8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3BE18DF6E;
	Thu,  5 Dec 2024 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733397056; cv=none; b=QIwzGygy3UBqURtcPZYr2OtY+hti6exAG6nXUN3zDX6MaUvcVvhto6NGUKg54k6jeSgZDcHy0ZzdHf/fu7LwN4weR3C7ul8o+o1EBBhq7hAnqzYujrjzP3Q5OWGGE8xsZi0C9/PecDKKmbxZH2AiJJuycqtCSDDTiASVoMWlv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733397056; c=relaxed/simple;
	bh=kb/2Mt8EUGXgFsWvSiXqRIjyzMwKbUYeOPB3f6pe2nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=G/lZ/1hGxyBz23+zRACHsplKHnfn5+gkHK8U6FMJk6Fyvy5llbEFlnHtDW4LR+u94cY4NE0PG5t9RjTxfrCfCnJ9FU7SIckph5B8xjfI/elmUoFCsMv49u3JPvRB3llVVj+J05BypZprakpsmV7EAPY7QsvOolSZ51/Nd9OAO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gdlpBoF8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57heSV005920;
	Thu, 5 Dec 2024 11:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dH6Nc8qSBHFcLSjD+BCzYNw6b/7zxQKMdpGyGFMU2Og=; b=gdlpBoF8C5+eqCp7
	CNcFKqjvbBOmy+CPIvKnimf6K63jr+UDdBgVN4PoBNZt8MpFv2ufBoMHwStbhVY/
	wwSwu3Du6isoY6igIZ2Z93fI4z/8/nssq7R2fUKVIfhRmIT/hd+TdB/WYtDRlZUb
	Bq3CBFaJMxi02EbG0IiZjsdchrS57GQ1Eb56LNtMT0V5zKNwxb7x0hiQOp6G3ASz
	Ic6jUeG58af1L0VVYYN6cfLHlvIRIphiVPLcX3rvRg2Wca6U3ULMidZueCoS/9pY
	obvCg8L+eyYdqHTO1gFxxsM2MgChAoUG7B6nfm46dSFOX7oTmqTBlstNz3PhCQAf
	EVZC6A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w3eqaw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 11:10:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B5BAkF5015572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Dec 2024 11:10:47 GMT
Received: from [10.216.3.193] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Dec 2024
 03:10:45 -0800
Message-ID: <ec6cb28c-ec3e-4695-b0da-97c452127d5e@quicinc.com>
Date: Thu, 5 Dec 2024 16:40:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: re-order unassigning channel in activate
 links
To: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241205-unassign_activate_links-v1-1-84097a1abdeb@quicinc.com>
 <65d22960ca6e47e19cf7c1c6a60dd72a@realtek.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <65d22960ca6e47e19cf7c1c6a60dd72a@realtek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 49iXbVkRfX_sDXyshYRWoK7eeYVlNkyN
X-Proofpoint-ORIG-GUID: 49iXbVkRfX_sDXyshYRWoK7eeYVlNkyN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501 mlxlogscore=936
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412050080

On 12/5/24 14:08, Zong-Zhe Yang wrote:
> Could you also update the description of ieee80211_set_active_links() (include/net/mac80211.h) to align the changes?
> I think it would be like:
> 
>    change_vif_links(0x11)
>    assign_vif_chanctx(link_id=4)
>    change_sta_links(0x11) for each affected STA (the AP)
>    [...]
>    change_sta_links(0x10) for each affected STA (the AP)
>    unassign_vif_chanctx(link_id=0)
>    change_vif_links(0x10)

Good point! I will do it in next version, thanks for pointing it out.

-- 
Aditya

