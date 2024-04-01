Return-Path: <linux-wireless+bounces-5707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA748937FE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 06:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497F51C209DB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 04:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1C749F;
	Mon,  1 Apr 2024 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TZaRVF8/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2A443D
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711945168; cv=none; b=RZW1drEqD4/R3XzetEdws4hV+n3xjx+GOkluMDyCQHlBF7HIuYHrkCGlA9zUzzswfwLFhHjVimsTekytdRoNGU/az+n6zX42LB23Qvek6YV+h5X9rtbc3hwmwrZyOdS8KERaoQ0Jzjc/oyu417D+DBLJ7bWou7Pe5UP/Vdx7eoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711945168; c=relaxed/simple;
	bh=oOLS2/EzZEcYHPMHh2VMCSeMGhVD9tPGpBJ3XYs491c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k5HsKT3buCfIq87hFon204xZNwv+0WTl//K3zemZw4avaK1EpU3d5isM1UIurDK7GQTT2YNtkzqkLrQLZ1nWJN2wQq92TSrAEJH/u0jZ5qaquYaOt5avPEz6ltXF3JNZ491Rj0WQrAnAZxLE37e8ZYS8errg9MVuChTz15PXNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TZaRVF8/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4313OXlF030720;
	Mon, 1 Apr 2024 04:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=7UT59QlgKS3WS7yeK/Em14rK2iOM88E05ojXCflJgCQ=; b=TZ
	aRVF8/RSfiUI6y1SKoz/As6aK1Mmr19VaV+y83wxUNYxkrZfUCf0zJaP4UQj4jpS
	7DxFwoFMXplxmsSWbhMNSNDqxiPwFfQknua8h9TMeSXifzAOY7sWX2J9GfWzXA1I
	mvJruDod2QLOJYxGYZQjyTvrte5NHfGc+oIF6Qhb6pWJShh5ZVC6gPysoMe4iwkF
	xIzCApHE32a84SOk3gyLUW5taZjWT1aC42203FDiiWbEF02rYinXY1KQhYF3upP2
	zXYMurNbq0tRJUb7VLuWevav2YTvVwo46GN1jVDtqrZz5oS4WOnNLY1LbLiLHwpA
	5L5DpMjtKHkwRKs/3LBg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x6atwk3wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 04:19:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4314JFpm002001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 04:19:15 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 31 Mar
 2024 21:19:13 -0700
Message-ID: <304e71ec-4234-c07d-ab90-b2309325595c@quicinc.com>
Date: Mon, 1 Apr 2024 09:49:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kuTi8QQ9dfS_PL-RikdQnph40DLgmXfN
X-Proofpoint-ORIG-GUID: kuTi8QQ9dfS_PL-RikdQnph40DLgmXfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_01,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 mlxlogscore=765
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404010028


On 3/28/2024 1:16 PM, Johannes Berg wrote:
> That's a big set, not sure I can review it all at once :)
>
>
>> +struct ieee80211_chans_per_hw {
>> +	u32 n_chans;
>> +	struct ieee80211_channel chans[];
> That should probably use __counted_by() these days.

sure, will address this comment in the next version of the patch.


>> + * @num_hw: number of underlying hardware for which the channels list are
> "number of [...] hardware" sounds odd to me, perhaps 'devices'?

sure, will address this comment in the next version of the patch.


>> + *	advertised in @hw_chans, 0 if multi hardware is not support. Expect >2
>> + *	if multi hardware is support.
>> 1, I guess, not >2 - and ==1 makes no sense really, maybe it should say
> that?

sure, will address this comment in the next version of the patch.

-- 

Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி


