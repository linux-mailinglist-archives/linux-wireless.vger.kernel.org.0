Return-Path: <linux-wireless+bounces-4755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE1287C152
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 17:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7121C2223D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2871B5B;
	Thu, 14 Mar 2024 16:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GSLGPIwF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AA92C9E
	for <linux-wireless@vger.kernel.org>; Thu, 14 Mar 2024 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710434060; cv=none; b=e4USQ0Brf6dHUmpbD/uanNVcd9AILRSTf0606xnB1pPJAYnVaIt56JYyAuJmBrJGKpigJX8f5zUZ7TcovuWzMmNEMu7+88HNi8Km5lX8jhiltss6RBIFyBBrT2O80199S98QWlEV+lfWV+o82RHG74w6HgR257w65M0/gDXqf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710434060; c=relaxed/simple;
	bh=o8ul5FYQdiWLkkCtSOjm3OwPTCFgYD+Y06aNt7G18OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aXljI25KY2QNQouXPhVPK6l2GzQ1LGmxthD0/3tZzMXR+ipo03gpo3n4QhcILAmD6RK0kCXOmTYv7KAVhnxaNqdtZ1ToI/SZRoOaQCsm/rOrPojNVDOpE78ofAyvhgQe4LfGI/694jPFln4w+S5w0N8S6BvlqxgGf3p2amjOpOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GSLGPIwF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ECrQdJ014862;
	Thu, 14 Mar 2024 16:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JR5QujvucPNtP7rGD/ADHSVsAGRQcE7JIMLJA8xdfSQ=; b=GS
	LGPIwFBek48Me5mxt2XCEmNs8Cep03TqaI9SisV2NaS1VWoxI9GHUAYWdEMjoco8
	fT4eVXUHM3gSyGWEl4LfwwNrcEAPLyuYHaa1etRiOiaG3QB+s7SdY6yfFHHRK9eo
	YFEVx6j03DOb+e1SpdqXF9CRvAEchAu/nZOXdtLp0WTraJCxu3LNaQa9UjyvRhyx
	TS7QvdB2lrknktSPIzs9R9lh8WZN2PgWfjofhOOV/7Czyc940gPiqqovp8t7iHUf
	5/Ukiz/txNbq69bxYu5pwJ3n4VVWPhVf0OgvCkurBw9puejkwAJefM9zcl0uRP+W
	mcCNmJK7A1clScqRuejw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wuujssdyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:34:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42EGY6iF031340
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 16:34:06 GMT
Received: from [10.110.27.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 14 Mar
 2024 09:34:05 -0700
Message-ID: <3883eb2c-54dc-4492-bbc1-9fea02e7e46e@quicinc.com>
Date: Thu, 14 Mar 2024 09:34:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: iwlwifi: mvm: disable MLO for the time being
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>,
        Miri Korenblit
	<miriam.rachel.korenblit@intel.com>,
        <ath12k@lists.infradead.org>
References: <20240314110951.b50f1dc4ec21.I656ddd8178eedb49dc5c6c0e70f8ce5807afb54f@changeid>
 <20240314110951.d6ad146df98d.I47127e4fdbdef89e4ccf7483641570ee7871d4e6@changeid>
 <87bk7g4x08.fsf@kernel.org>
 <09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <09ca997159333980a168051a2a49c675a8ad5eeb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KyTGkh9WF4iAciQhO2XfFnJ-mE1k-EdI
X-Proofpoint-GUID: KyTGkh9WF4iAciQhO2XfFnJ-mE1k-EdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_13,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 mlxlogscore=560 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403140125

On 3/14/2024 9:09 AM, Johannes Berg wrote:
> On Thu, 2024-03-14 at 18:08 +0200, Kalle Valo wrote:
>>
>>> -		hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_MLO;
>>> +		hw->wiphy->flags |= WIPHY_FLAG_DISABLE_WEXT;
>>
>> I think we should add the same for ath12k, right?
>>
> 
> It's really up to you, I think. I'm hoping to even get this into stable,
> FWIW.
> 
> The biggest issue here was our firmware, but the stack is also missing
> some things, e.g. we see CQM problems (warnings?) if you actually use
> multi-link "in the real world".

what does it mean "disable wext" if we are a mac80211 driver that doesn't
utilize wext?


