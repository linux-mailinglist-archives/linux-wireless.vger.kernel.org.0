Return-Path: <linux-wireless+bounces-11811-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98FB95BCA1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 19:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6329E2871DE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E001C1CE71B;
	Thu, 22 Aug 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B50uwlNE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF12C190;
	Thu, 22 Aug 2024 17:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346089; cv=none; b=WsWlg/uV+R9TdKqWdgP2pDoxud58ACjxWssDXNXjA0ECcQsC5vtZXYR6PlilobWK+GGjxmW5oIfy4ARhMkxUmQdB7YoHf2+l7iZFHRJQE4tMytxZ6bkfkVasEiEhwcSbfNm4VfVq+gbLk1n1VUm926CQNe7yM/T7TgVO1OsxvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346089; c=relaxed/simple;
	bh=KtA4oYSVp+tCFeIPBkDZAv1Ibin4JPG/1Qu6dMmoIg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MesIUQwZI2+/Z/66G3/kacEZHLFe4A5aWJzyDtlDPcmwz0NFtkMMGyant2c8FgBwjEAwiurk6NlVnTSbsJfzxFxWsmAxRFO1rU20xCdbZ8zEjaPZhfZFzbwhJFn/J9By6OSwc9azgNgCYWwnvGafx0JKmzBo72i0f7o3vFcci74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B50uwlNE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M9v9O1030906;
	Thu, 22 Aug 2024 17:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xl7miFXgrV2201IWVkxgpac+HCQbuJB8WNU4Rg/Ckmo=; b=B50uwlNEKirzCWvv
	vmtAiKsqegjmF0BDQUB6DLqouaTJXcf42MIbMBI/GNtCRsnqOchLnZUKAZz5vHMG
	edTED7b3WvaxTlMnOKpOn+xBLlqcudgZ+0HPxBC36sqTv82eqNkOKMBXibGY7UYK
	Xm/W6arm0cNc8qlq0aad69+INiPt3M5EPDmPRIBgLYixEE8VWkhDsdN7OH0YM0aW
	peSSKMuAy4sc9cwyXY4J+n++eRfC/VkfU3E6/JV/Jh+gHwxYdT8aDifd4QtvdXWf
	8oYBBl437CIzBTRitFkHTpxWtvruwI0L2Jj27Jhha7YYWZ0zoq5MLtadvuS00tBu
	iWyRkw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 415ck9d0bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 17:01:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47MH1LmO022640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 17:01:21 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 Aug
 2024 10:01:20 -0700
Message-ID: <547af05e-0110-425e-be11-2cea261776fa@quicinc.com>
Date: Thu, 22 Aug 2024 10:01:20 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: ath12k: Avoid -Wflex-array-member-not-at-end
 warnings
To: Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <ZrZEuxJihMzAaTVh@cute>
 <172434545943.2469785.15733185765753701476.kvalo@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <172434545943.2469785.15733185765753701476.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oCJUQw1zs7xtFFqKa0Fj5N_3BbPK-AtB
X-Proofpoint-ORIG-GUID: oCJUQw1zs7xtFFqKa0Fj5N_3BbPK-AtB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_10,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=777
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408220127

On 8/22/2024 9:51 AM, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
> 
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the structure. Notice
>> that `struct ieee80211_chanctx_conf` is a flexible structure --a
>> structure that contains a flexible-array member.
>>
>> Also, remove an unused structure.
>>
>> Fix the following warnings:
>> drivers/net/wireless/ath/ath12k/core.h:290:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>> drivers/net/wireless/ath/ath12k/dp.h:1499:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Should I add a similar comment as with the ath11k patch:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/ZrZB3Rjswe0ZXtug@cute/
> 

Sounds reasonable to me

