Return-Path: <linux-wireless+bounces-9437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5693B9127A5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 16:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CF31C26058
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 14:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283CA5E091;
	Fri, 21 Jun 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F9euOEBl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BFC374EA
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979927; cv=none; b=Oj9Zg7CCF4hKdgG+Hcmtu4wKW+N+Dq88VQ7g8BI+TIenXxbLsq0k1FmwC6lUSUMVpdLYWKBl+MCFXXBHPRxMGabTV2R66IoeT9s6DFS1nyaX34vKH2NL6o3s2Xj/YjuNKdecjCtrrpvGomMui3PhjE62Lyct2hzFipz0zsK5EJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979927; c=relaxed/simple;
	bh=joA6Six2KdkzzpMKeuueUzmZt2iJ/iO3Kl9WA0Nx/o0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AnJaJuZpIaoO66Qkbqw8/O6T0DziBMS8jvQp5iBRgynA2D/SmOyjymezrcwJYqWsekBluACL62zoag7cHjFmFJeDmydCAj9VdxqIg6mLGs9EBoyNWXN5Y/VupskEmQhrlx2nmAQI2dkQOZrL7qfwo+twiFnStzDYpFVOTBShjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F9euOEBl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L69Gb7017857;
	Fri, 21 Jun 2024 14:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k1BMwmoqzLXEHo06KRjFqu9IWHMhsUsIxjoQ1LQTyLM=; b=F9euOEBlLQ2nLuwk
	55co7xkoOPyTiMt2NP9im2E7H9WvTJ0JesspeVcvyaA/SVDLJKCJmuh8uli/0fNZ
	z+E38Ub2Hkyk46RK2jwc0VvQwFJVshPBPLCXBawCzq0odyCKc1G6RgGfiLzJOHO9
	ljcGni2DbdWSfg7QyiY3OwhMMMqOM40WJL4/2uiaIZ12nLzDN6rcEDNqJDMRBPpk
	2DB21LIda6vUBLQUpzilxH7xassrVgTsqeiD3m1ytFFJnpwRd+bZHXY0rlFO4Qry
	qMJ+N5psZ8NoVUmI3UzqfZtdd76gcJqw/biX1zKNGLfqtIDl7V4ov26z6+Cky0mb
	bRh1pw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yvrm0as82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 14:25:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45LEPAJt008624
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 14:25:10 GMT
Received: from [10.48.244.93] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 21 Jun
 2024 07:25:09 -0700
Message-ID: <d834ff59-f331-4eb4-91c6-e76eb48780d8@quicinc.com>
Date: Fri, 21 Jun 2024 07:25:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ieee80211.h virtual_map splat
Content-Language: en-US
To: Koen Vandeputte <koen.vandeputte@citymesh.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Kees Cook <keescook@chromium.org>
CC: <ath10k@lists.infradead.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
 <efc8cdc0853a921ce4dad1a36b084608fe0b01a8.camel@sipsolutions.net>
 <CAPh3n834eg1_+gmh_LMTQnc95aLBWNVOANjZsMap=_szOY2nHQ@mail.gmail.com>
 <83fcb33e3fadb457466126255297899fbc4186f8.camel@sipsolutions.net>
 <CAPh3n80PF4NULjKJVVMEiGuuJZhLQszYSTCv+f6e9LfVJbKesw@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAPh3n80PF4NULjKJVVMEiGuuJZhLQszYSTCv+f6e9LfVJbKesw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WhCeEoPq9amMvIylEq0S7fLbQf1MY4JM
X-Proofpoint-GUID: WhCeEoPq9amMvIylEq0S7fLbQf1MY4JM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_06,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=580 adultscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406210105

On 6/21/2024 3:31 AM, Koen Vandeputte wrote:
> On Fri, Jun 21, 2024 at 11:30 AM Johannes Berg
> <johannes@sipsolutions.net> wrote:
>>
>>
>>> will this one get backported also?
>>
>> Why? It's not even a bug.
>>
>> johannes
> 
> Because without this patch, it produces a splat on kernel 6.6 (which
> is an LTS) at least ? :-)

@Kees, have you been backporting all your flexible array changes?
Or are you suggesting folks disable FORTIFY_SOURCE (is that the controlling
config?)

thread starts with:
https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/

/jeff

