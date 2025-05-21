Return-Path: <linux-wireless+bounces-23236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CF4ABFBA9
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 18:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADE716DC83
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E911EB5D8;
	Wed, 21 May 2025 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i7IeNX/Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6D01D7E31
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846381; cv=none; b=XPmlukwcJKW4wKGV1A8DSChXtkgQgmUf6SiWwbJIXJ1+w4e1X1ikgGIe+ddjiIWnB+Lj8PRtVo0xeBvSyuUMyC5J74J2E6Z2AfCrr3rFF/ESQKQsIklV2hbxSfY4EKqu1qtOfd60aF6P2XBs+b0NL6mliG3f+ILoC2TTtUzhEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846381; c=relaxed/simple;
	bh=xWcPS+QqrqnJDRQ6dEoDfWuq6Tdcixra0PyI2ec37Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oVG9sp5ztyzMpVug0NX3WyFhZa2Sw1A+/+LXs9h7aQiFdX1o3U0G5sOblFhQiINfw6O+LIrr/o34HJbbL8FBHpwx8ZPjULFxWASgA76Uqjhv11z8+Bdj1N6tgRD5TDzzUCjqIMLYuT0atvkEHwxV9NToJTWW6t3CM2Y/8SY09eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i7IeNX/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XMUi000805;
	Wed, 21 May 2025 16:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	25mNExFRAnqS44wi8r4cbydqAhfmYZ6ZHfOxRBdsG9I=; b=i7IeNX/ZL3Ykozx7
	rkxj1yYs99CmqfKupKU4n063Ui4oLjhunr2suCQ+EvwvmHhM8VBfCsFF+cYLXfAV
	kZfSsS1JFB1KrvR4E9TWqFCfEJUfTLUwWnU7+tBhG2k6Pf2SStP0qzkeGqIoyJ/e
	YIBJV97688AiZu4np1ZYxebVtrDdk77+OA8VFf3a6kjhhESJ/jv61gUD0lkO2ER/
	byr0Xe+/Hsgn6ZYcl9FP/X+s/tpcX2Nolwhj6aTZstPu4n4TviaoshmgYndIdPOT
	0rWwb9mD8OgJPwhkAKjWbBrdZHBU8ROc3Y0ap7FK8I2ETWJSy/sWnlvthIAG+X+3
	VcRXbQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s95tj0j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 16:52:54 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54LGqs1k024862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 16:52:54 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 09:52:52 -0700
Message-ID: <54c0eb98-2424-4516-8d53-c6d689ae5b59@quicinc.com>
Date: Wed, 21 May 2025 22:22:48 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold on
 per-radio basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
 <e49bd19a-b8ac-49d9-9cce-80772e8ac0b5@quicinc.com>
 <e928cd9c93134aa7df585835e07a601a4ff3dbfb.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <e928cd9c93134aa7df585835e07a601a4ff3dbfb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=QKBoRhLL c=1 sm=1 tr=0 ts=682e04e6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=cwCZwhqnnr_NspQWiloA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: 31Mn-Mn0NN2KxXFtAJywoeSXVl3mwaC9
X-Proofpoint-GUID: 31Mn-Mn0NN2KxXFtAJywoeSXVl3mwaC9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE2NCBTYWx0ZWRfXzFk0IUeLIzM3
 A2XUvUlIpG3no161oX9dVkbfVVzGeXIsi3/11JA7ThFs/Gd4KnpQrouBBFsXIpkUPBgJPSXVlvF
 9fHunfBVe2J/wFlul0dYyi5+UbcXbELTKhad7Ht5gL3A0JtkvKlbXjTpqaP1ccYYOJRrl0ANiE6
 KYWsyrD3mvcOYdLB3cPlyuVej5Qpf0CZhIKEmgKWX+mxPmcQ4WsqpXJgbYZKScDVqgjrypZutpg
 ynrfwJ+fRLwioEzpDxvl63WaI2ecWdDIkI7LG4Rev6cjyjvEV/67Yvqn9czU7qEgrkA6zFnkK2T
 oPGp3s3nwjqgKHGXXVkncoMFMFXYqHgQtkp1BUQQmN38b36BObYtkurzaAswmeoUB9YygZpFRh7
 03FygmWxstDUlbi6nmn2Iu06RLT8Yczp3Y4yEgwZStcNMnKZq1PFrI2hmEF/R0TnaxLm44Yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=604 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210164



On 5/21/2025 10:11 PM, Johannes Berg wrote:
> On Wed, 2025-05-21 at 22:00 +0530, Roopni Devanathan wrote:
>>
>> Using 'int' leads to adding NLA_U32 policy. I think using 'int' is
>> costlier than using 's8'. Can we just revert back to using 's8' instead?
>> There will still be a default value of -1 and the radio indices will not
>> require u32 value anyway.
> 
> I don't follow. You can always take a U8 value and put it into an int??
> 
> I think that NLA_U8 is a bit useless if you have to range-check anyway,
> since an NLA_U8 attribute is actually the same size as an NLA_U32
> attribute, it just has a more restricted range (but you restrict it to
> the n_radios anyway!).
> 
> But I don't see how this is related at all.
> 
> I think 'int' is better internally, and NLA_U8 is fine externally.
> 
Okay, got it. The policy can retain NLA_U8, just the radio_id datatype
usage internally needs to be changed to int.

Thanks for clarifying.

> johannes

