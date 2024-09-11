Return-Path: <linux-wireless+bounces-12796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6979757C6
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F341F23039
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727381ABEC8;
	Wed, 11 Sep 2024 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OSc6tqKs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10F1AB525
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070381; cv=none; b=KRS3CwIKt5pDoHsgUJX628qQ3aKK9CFgioROsvxnSde43vTnG1+e8nzK6/Upql5EYDgg9CpevojEDr+jixD/NocIJ+0Vv/V1Mr1to5tIWCUH/UeBxhP97rm/xf8VR5zbvrhCcyBz4h1ttjMH5Z3qbVj4fLv9HgoxbkUXyQ09Hr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070381; c=relaxed/simple;
	bh=Ec0XdTVofHMFC+aJe+iI/Mzfjm+o1HCLQdU2xMVZo1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U2WdwzxQ2E5KEJNT6CdI8B2iRTaBqJlrKr3jBCbAQRS+xpG5MJT7CHpL3sv1ga/Nhv9T4aC/SS1cI541hZrBRiOICslDMJ9b7rnuKBdn5m2N92lvyDtoXB0TV8k9S+dzsmlTqu0TkHsz6HV2gBom+cxwar9Ic5QqngHAqRgDk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OSc6tqKs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48BEmsjN010036;
	Wed, 11 Sep 2024 15:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BOkY54mJHKms7FbM9FkcYYKZK+oPRIjQikCgaAkOeSo=; b=OSc6tqKsAqfciTIf
	f1c4+7NCF0r3NZUQRJvn0TjDgYpiEglNUMbKoPhgn9ITEL0MpSS+MjI0Yx4PHfmO
	p9lm8z/cy3WL0A+NZVHhxiKg6Fa1FBd/zZ/TL5g7ldYjmks3RP/Q0pfjw2Vtniu+
	yKwvdJVag5l8twq9aHddlO3+H85cxq2f/srkJoLltxTsJ9JbcgwRomUHLHYkolnA
	6qU+7OZ5L9kNbOiIvJPm1siORhzVmlYLgQI3jS5JQa2x+kSZZAP622LjTXLIu5hA
	kzebICSUq0xMUSySqZesYSe5PU4BJfK1AJbks5iiJ79ZFb/aPbzzmMjv+Trrahfm
	qhpIHA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy73280e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 15:59:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48BFxWBE010808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 15:59:32 GMT
Received: from [10.50.37.116] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Sep
 2024 08:59:31 -0700
Message-ID: <326bdba0-d186-0d90-d836-92132495de10@quicinc.com>
Date: Wed, 11 Sep 2024 21:29:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>
CC: <linux-wireless@vger.kernel.org>
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
 <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
 <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
 <0d800949-d43a-2172-6aa7-5d0069d3b88a@quicinc.com>
 <36d111a1118349a86946bfdbc55e8fcbf3720fbc.camel@sipsolutions.net>
 <a588beba-ddeb-445a-abff-cfb3f6a41a63@quicinc.com>
 <7ddb082fc1a1886f343e4c0233a24221932edb64.camel@sipsolutions.net>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <7ddb082fc1a1886f343e4c0233a24221932edb64.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0Bi_2iHnK86VL1Ecbx51DQjJh3QA9PC_
X-Proofpoint-GUID: 0Bi_2iHnK86VL1Ecbx51DQjJh3QA9PC_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=839 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409110122



On 9/11/2024 8:55 PM, Johannes Berg wrote:
> On Wed, 2024-09-11 at 20:51 +0530, Karthikeyan Periyasamy wrote:
>>
>> ieee80211_link_reserve_chanctx() calls
>> ieee80211_can_create_new_chanctx() with radio_idx (-1) to calculate the
>> max channel (ieee80211_max_num_channels) after the iface combination
>> check (cfg80211_iter_combinations) passed for the global iface
>> combination. Here the expectation is number of channel context is less
>> than the number of different channel. So in multi-radio advertisement,
>> each radio support atleast one channel, so totally multiple different
>> channels advertised in the global iface combination to pass this
>> ieee80211_max_num_channels().
> 
> So maybe that's broken then, I dunno. You should figure it out with
> Felix I guess.
> 
> The intent was, and clearly it has to be, that the global combinations
> are something that can be handled regardless of radio information, to be
> backward compatible with existing uses. Therefore, it cannot be
> something where you say two channels and radar detection on both because
> that would imply being able to use channels 36 and 40 with 20 MHz at the
> same time with radar detection, which isn't actually possible.
> In this case, the "two channels" is only possible with also two radios,
> which has to rely on the per-radio advertisement, and the global one has
> to be just one channel for radar detection.
> 
> We still need the part of the patch that calls the validation on each
> radio, but it shouldn't be different from the global one. If you could
> make that patch I'd appreciate it.
> 

@Felix any thought on the current implementation ?

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

