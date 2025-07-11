Return-Path: <linux-wireless+bounces-25294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB26AB0222D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 18:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8F557BB2AD
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 16:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C017428DF27;
	Fri, 11 Jul 2025 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YezCCEFV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FC12AE66
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252701; cv=none; b=NrJyKx1mS8M+gqApgRgAcIv6/cLxl/7Ye+sBYMgHmufaxKkLI+FYgrbQphT+HItUsoWm0jjTQpmEqxCEm8qhon8JM6y7v0VhLdYXpknLBMjRXiYS4HSbYnhtq9P1zozWcLyNfsK5YYDcpg+QaBLN8laMhzKDPeevkU7BsPlA9+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252701; c=relaxed/simple;
	bh=4e4HsBTEENy7d3o/Hg7Ecq4UEgSF1wgRRsMqxY33gSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nTCy9Glo3pajQzigJRQvSZQA2tLHRZWrD9fcrf+0aq6Ex22ORway7MYVicUtLGB2V6XZNLGN3NfNxgWDtZEOvgEQyohUwol9Z/UgJjod6IfqjKfXmeSAvab4eGOOO6efw/TikJKVuxqWjqw+uAxbDh/6QrWtCOJWAB1nxpPI3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YezCCEFV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBWEuE001265;
	Fri, 11 Jul 2025 16:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dyBhJKDirZdiz9+LHvGruAD7p8R1c5W2P4LYfI4Svi0=; b=YezCCEFVbLLvjN/Q
	LtjaGoJKL4EhHvAJ6WhM9adD7qFfSC4n5n534zEvLep9hQ7gy0vRnt67NtyEg4CP
	0ZgyL3Vvauqy2LMjY9ivRFXXD9PR4xE5eaItdXJrSdP7JbBu84v+Ifb4WXdp3d+z
	lk6QMJ/t/QM6/mGJxFRzoNrbKhbg4KETPVNSMhuB2TwdIQQr5fGgapR2Wesn6BjW
	Nru1h2ITpr6HuTxGB/kAzNLgKMclRAkPst88/Q3utKKsoMTJLdfXQg6EVkbZGGXE
	+9zxlR9BG/fg6vN5pWdUc258L/xfmA2+GrsppQz5wzyCXZYM0tZvdM0WHhU0UWRG
	INnZWQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucncr2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:51:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56BGpYuF018915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 16:51:34 GMT
Received: from [10.50.2.166] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 11 Jul
 2025 09:51:33 -0700
Message-ID: <13a3367a-56cc-47b2-9458-beda38fa48eb@quicinc.com>
Date: Fri, 11 Jul 2025 22:21:30 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iw: add support to parse 6 GHz channel
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
References: <20250620073240.2770468-1-quic_surapk@quicinc.com>
 <220639a5bbf43c125ef114c6ca8e71d050125cd6.camel@sipsolutions.net>
 <344daf44-525b-40c9-a570-fe659717d656@quicinc.com>
 <1450bfa2265e8609699a70a493209091873040cc.camel@sipsolutions.net>
Content-Language: en-US
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
In-Reply-To: <1450bfa2265e8609699a70a493209091873040cc.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=68714117 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=QkBOT-S9sAWfJOGl45YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7gr89qT7q1LYIzJwriM9o8kcFgQmoFdS
X-Proofpoint-ORIG-GUID: 7gr89qT7q1LYIzJwriM9o8kcFgQmoFdS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEyMyBTYWx0ZWRfXxD1d1JlwjAab
 dsuIsAQhAxl/IFw1PzPaNFgqepY9uWI/KyYz/UheSaDj2kkjIPy4wOscxtYozmhBh9TZ/GC2wUO
 q6ZzNdC1btdW+xoV1xIUY9YQOIF+wJmJZMdtZJMfx0b8HtdWe+BaccByGywh5U35bXgUnvDPCXO
 RH0ccqbdg39OnVya/IK5oSefXphrfCgXDR0Ey9yVRIMx5vZeegXeOrTFLFud/oqtXRK80X3NzFq
 /c/A8ymkvQFiQQyrFeJY1joRtN0DX09CygwvjFa5kTY/BdBk8fexmGrf8hiQ5a23ICLHLQT4mCz
 pY9C1azvg0aUd81C7wO0/7WDhvjwAyZyZXV1o3YPn+m16/yALnDsLoYK8Wo7oh60yurbx4p4eL0
 snrfLBhnbklB/xSp6rMY7dyJn3vMpbWMzMRVrWZzuDML60WJCGTku2vXkuSx+C1ZBNsY0idy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=877 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110123

On 26-Jun-25 5:31 PM, Johannes Berg wrote:
> On Thu, 2025-06-26 at 11:59 +0530, Suraj P Kizhakkethil wrote:
>> Adding support for the 'set channel' command provides users with the
>> flexibility to use channel numbers instead of frequencies.
> 
> Sure, but who are "users" here? Most people we'd normally describe as
> "users" will never touch iw. The users here are mostly us, who work on
> wifi in the first place? There are some corner cases like sniffer
> though.
> 
> The thing that might've made some sense here perhaps is the automatic
> center frequency setting that you get if you just set the channel and
> bandwidth, but I think that also works with center frequency, so my
> example should be also possible instead as
> 
>    iw dev wlan0 set freq 6195 80MHz
> 
> 
>> If you think this change is not acceptable or needs modification, please
>> let me know. I’ll either drop it or make the necessary adjustments.
> 
> I just think it's really quite awkward to do in the code and unnecessary
> as well. _Maybe_ if we were to do something like "6ghz:5" for the
> channel number? But I'm not a huge fan either.
> 
> johannes

Sure, Johannes. After internal discussion, we've decided to drop this 
patch, as this change would not be optimal.

Thank you for your support and feedback.


