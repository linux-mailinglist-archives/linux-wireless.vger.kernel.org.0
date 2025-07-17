Return-Path: <linux-wireless+bounces-25590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6A9B08908
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 11:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF3B567754
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5782C18A;
	Thu, 17 Jul 2025 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O8wYtx4a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F60289829
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 09:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743469; cv=none; b=WXj3p+cu+tQcIgKB67WDawbHxyceezU+70QydujXEXEo9bl6apkkbcaxv9baBiV4ZUJdAySd/N551V8QvrTgBgL4S7kRTNVTloEgFnbZDsh0k6CBU8RTAiFUxIsd9+Li2jSldbsVAryWl1UQP2YAaO1akBK5pWaDpwjSKwqheGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743469; c=relaxed/simple;
	bh=ttlr88v9rAB4t92QIODYz7AhNgMQClE1aB1jvpFGOE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KuQdAR1UUOUjg86y1iTZPS9gizGY8LRnErBKE9xLF39NLhz7kid2AWPSD6xY7tEjU9yVGv6T7kKA1EnKRRvol5Io8bUUI650lPewoNwme+AbP7qd+K8QbnWPCj13h7kiMkKGfHkAX7my4RMHJ0paHTwp6LsrV+WPhPzUJ2rtEnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O8wYtx4a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H525bv008498;
	Thu, 17 Jul 2025 09:10:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ONz0pazu5hz7FVc39q0rmuR3I+njG+EKcs2//uX+z0k=; b=O8wYtx4adglrEqqh
	3Q0fu77lpm1EdtzgKC5wIqSI0s9JQTbhwqx+Frxn3npPYWRC/FN0esQkdxIFi8Sm
	Tzw6+ihQh8W3vLfg+TGy3ZIABehhPwKvhQX8dxlz0u6gHnVRS0wmHjuhS1SBy+N9
	XNkRNm9lMDB6mI0jnmY5NPnFOgA6/2GqyD+A2/0QYah9EYRjz9KfwUtypyfUNVxu
	EdeHnzBOO5Q/9fGsaiTwu36c0kmfj+SXvyYS3ZEwgp6xTLUiuQ7UsSEntcexJ0Vf
	KaXd/Ug4wxOvm8LutnEmR19/T29/YEEgMXb2v2i296dPD6VZiw1IhSj/xDosQyMS
	Ohz2Vw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxb71us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 09:10:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56H9AvlP029000
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 09:10:57 GMT
Received: from [10.152.205.125] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 02:10:55 -0700
Message-ID: <95f682da-8be0-49fb-875e-4200ee348903@quicinc.com>
Date: Thu, 17 Jul 2025 14:40:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BPCC in per-STA profile in link reconfiguration response
To: Johannes Berg <johannes@sipsolutions.net>,
        Mohan Kumar G
	<mkumarg@qti.qualcomm.com>
CC: Yuvarani V <yuvarani@qti.qualcomm.com>,
        Manish Dharanenthiran
	<manish.dharanenthiran@oss.qualcomm.com>,
        Jouni Malinen <j@w1.fi>, <hostap@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
References: <aa29ba3015d533796516a1fcf8036aa1e0090624.camel@sipsolutions.net>
Content-Language: en-US
From: Mohan Kumar G <quic_mkumarg@quicinc.com>
In-Reply-To: <aa29ba3015d533796516a1fcf8036aa1e0090624.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wRWocwn0GWOHekckiUe5jbspCWUOgHPo
X-Proofpoint-ORIG-GUID: wRWocwn0GWOHekckiUe5jbspCWUOgHPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA4MCBTYWx0ZWRfX6dOaoy0buTUp
 Kif6Kg7TrL6A4IXAdV0vXLFtB+okqGOly0QfAF2Pnd464q+KhRNMqstBULsWvNLkHdoSIVu4OXY
 6KqJDKqwY1A+pl6WP+lkR7338uEWwEr4J+AleTOLwvORXlXSk4Lej1iMTd7jEXHddJWyjXh2b/6
 m2SKq+bTT1XjTg5tSGo0VCA86GV0HGz79M6HpLMMj/BcdGYsFfIXADFP3s1iB3A7I3N1D1TbCaW
 LnnK2/b+XUgMKeEvCfP/4Kls/5b9TsFsmAE0vaNhbiG1kaOoAsPJ90F3U+mS+GCfYm0xf5wBIBC
 ESISU3CgczTQ588J8JwKSKghvqtgYQMQjW2wxv1cqXUAM1AkOT6ZsSWkAmaegMEromNJos5NWIA
 VOiFjd8/MF/iWpZhc7aF/SFLc3oUS6LLmdS3yW0A/3hScG6Y5kgrGffGqW+AEpjPhn72eaMH
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6878be22 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10
 a=leKzB7mKujqwlGhS_bUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=939
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170080


On 7/15/2025 5:47 PM, Johannes Berg wrote:
> Hi,
>
> Jouni pointed out to me that mac80211 currently requires the BSS
> Parameter Change Count in the (Re)Association response multi-link
> element per-STA profile(s), and via sharing the code, also in Link
> Reconfiguration response, as you note in hostap commit ce8a121287bf ("AP
> MLD: Include BPCC only in (Re)Associtiation Response frames").
>
>
> Also, as you note there, the spec seems to suggest this should not be
> the case, per section 9.4.2.322.2.4, where it is only in (re)association
> response frames.
>
>
> However, in the spec it seems to be explicitly required in section
> 35.3.6.4:
>
>        If the AP MLD accepts link additions for one or more links, it
>        shall include [...] For each Per-STA Profile subelement included
>        in the BSS Multi-Link Element, [...] and the STA Profile field
>        corresponding to that AP shall be complete and consists of all the
>        elements and fields that would be included in the STA Profile
>        field for that AP in a Reassociation Response frame that includes
>        the corresponding AP as a reported AP [...].
>
> We had some discussion about this internally and think that this is
> inconsistent in the spec, and also that the 35.3.6.4 text (that suggests
> including the field) makes more sense, so we'd suggest clarifying the
> spec in section 9.4.2.322.2.4.
>
>
> It seems to me that your commit was more meant to fix the ML Probe
> response (no disagreement here with that, I believe) than the Link
> Reconfiguration response, so two questions:
>
>   1) Did you actually look into the various texts about it and decide
>      that despite the seeming spec inconsistency, it should _not_ be
>      present in Link Reconfiguration responses? As I said above, we
>      think it makes more sense to have it present.

Hey Johannes,
As you mentioned, this commit was initially intended to fix ML Probe 
Response,
which is why section 9.4.2.322.2.4 was referenced.
However, after reviewing section 35.3.6.4 — which says that the
Per-STA Profile in the ML Reconfiguration Response should be the
same as in the Reassociation Response — I agree that it makes sense
to include the BPCC in this case as well.

>
>   2) Are you aware of any APs that don't include it, which would mean
>      regardless of that, mac80211 should accept both?

As far as I know, I'm not aware of any APs in the market that don't 
include it.
Maybe people in community can comment on this. If such APs do exist, we 
can consider accepting both.

>
> Thanks,
> johannes
>

