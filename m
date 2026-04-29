Return-Path: <linux-wireless+bounces-35562-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ETZHHyg8WlSjAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35562-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:09:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3805748FA26
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 08:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A209E300FA07
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532D320CD1;
	Wed, 29 Apr 2026 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jKZHibKs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kMnuYRwE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F085A308F1D
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777442919; cv=none; b=KE+Xtai0NrCimnf3dXVvIYG+h1LZgNh7DtzmMWIpVzm3R+IyQG3Xkgff4I5D9SCkC7VfLN7i+F5ny17OWaTSQe1yEIWB8IKATxS8MUiWIaSOh/36VfAHC8BD3+ejitfODgDDhD7RybjP6lI/lFvpVoTLvo+J5cXulUDS5Wr02pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777442919; c=relaxed/simple;
	bh=oF8eAUvhFSgrl8XjrcKj0/b6nLva1SYdo9JIObrSCpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROym/MyBoZI0mUALXzcoIGvMwoHcfkP/o6E3Xo1UHMz6lv3PI6CnQoqMdLLCEoZcMYTyDRXZoiIGCBpO5cmOCpjDQXDElTdQK3nS6kePJtBWcJKczBnnQyffNspOl6ZVWmdnYFBTtWVVf8He4voik+QtPh4571k/1xKuVZDyQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jKZHibKs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kMnuYRwE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T5HtcQ419679
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IZRHfHc/rWYG3q1JNXo5cD4m0xOECokIhYbw/yRmmSg=; b=jKZHibKsaqhX54ie
	pG//BYuXGp6TUFbp+BvAV0WZaTLdn9fvqA46UHdQc+LysLRF+vq3hpDUSIU+YQoc
	BZQa3jNDqD+BmOERL/2OmeVp9gXFNIEjMYrtwJYgD5bCVM7Vym3zKEVscyi/qyEi
	m0tQF2JWdJmWjKK8aFf6vZYILHFc0quBugWcq/u1hHwegZhacKswu7c21w83Ya1O
	/33FTZrU19+ZKFc3LgCejKRJ/zUBg/jSF0p00OQAgi4npDL2kzcpP1BTtKRSRS68
	Po0JhSSY48yYcPiyuJuvXMW+EdCgfMBbtYOpMHl9ynNEqIMl4+lNpqqS9+1UnQ1D
	IbGE8g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dubq9g585-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 06:08:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso18366180a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 23:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777442916; x=1778047716; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZRHfHc/rWYG3q1JNXo5cD4m0xOECokIhYbw/yRmmSg=;
        b=kMnuYRwEPxxvPmoFHF64cM6bef8s9EKbYsh9wKIhwsMJ5I3zujjfzZjACFBDcyCxk2
         raUwGPWx85OJmxSV+HBlKYgN3IsCcqB8f4KHsQzUoAGTTbThrPvinANiyviu0OdK3HJ5
         Jep3gyy0h0aiX+6RAvdsKmIXGzIHe3UKSX3CUleLaZg2iW3SfAkW21c68mImJqxcxsIj
         lZiE8PkQtJfHKplo92gcckoQvxQYT9Uyuj/kUy+JW3GjGqR9G0wGP6icZlrIukn5ycD+
         0+JDJgcvKeislNEQwNTCe4BrmD6UgkJWVFE+F05wkDDRNr4v+9OxVeJjrWPwzlJUPknq
         rlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777442916; x=1778047716;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZRHfHc/rWYG3q1JNXo5cD4m0xOECokIhYbw/yRmmSg=;
        b=dvcLM1Hw9+9bf0jLoCjKJWhJuldSYekb+sRer0o6SLnLrvKqFdaMtOsyloOrA4240b
         600gaMSFNKa7cuawQf8MAOghxxngd0RBid+sZ1tFCREW44egs5MV6/hrd1J6tQMSGWCF
         7KGatSDyBoVdoC3ZJ+j3JDG7AHxGtxzfoATeC+TNoIuf7cnbySepXV63kxyABslVfcg1
         wkSSeJPCLVEjdUFZmz/MG2HhE2OEkvBQMm9RkepHdyJ6W2SZS7Qp0jbr4unP5rSOCgm1
         xdv8Fj+CwN9mX/ApgZctqYr4eljNSvhk1nPHJLc8V95HHz39YX0tNb/X5rC3b6Ue2GE+
         jBcg==
X-Gm-Message-State: AOJu0YwKnE7DahZ14MUBQOKBxIO7I9QYPQVJexayCHBWOjEaeAYPnCGt
	Hpzm5ioTCAeta5iJcrjHTnTNKiq+hn/kKZxxV+E+g3tKg+tYvT34HuwQjdtP7od8kSbCD9okB52
	sklBnAgpUO83llOV2Gcs1BOi+aKK/1SSHG5aPaYmXdxZMsO0ImQBBRE/7W4uExLFvbOgu/g==
X-Gm-Gg: AeBDieuJT5SkgKhj76goUrXpstyOI+4k1P+jWj5CWUTSPqqdSRps12P0/B1WtF91Ay0
	ymD+znycBkcOZ51WXO5+zw1OcYSIX6CNSebmb9CPmXD8gj2RvgtD+D5uFwLOw/iMbNnx82QxgMT
	QnOiR/xmLVNtmh7ujuWDVBDCi9INXdqXyqYd/s+EN0hrxTEuQxwXKBdOrnP5d+GrxZDjRkH7lMk
	S1/93O6w8rafO7SoRYB6KH+2quO8gHvrSpBYn01OphTrcFhILbXC4nuMyuPexyv+33ZEiOLgvMf
	135ID20QxbPr3ZdlWjkoeJU/ye9nPMcEPcdF5X+kcJiT8g8eLUWptjHmSFV1fxl/TEnCGSuJehH
	oX+kH0oaltfnAZ2fO8mq2+uvcpLaWK9QzXaQT27y0e0y/T2wZuaEO1l2m1+PoKj8XYmZnpPG7HQ
	NcClGLxPqrG70kP6FGCeGtW8GZyVpIyB1/AKkZVyQNroSICzEAnA==
X-Received: by 2002:a17:90b:3f4f:b0:35f:b75e:fff5 with SMTP id 98e67ed59e1d1-364a0f3d15bmr2695183a91.22.1777442916499;
        Tue, 28 Apr 2026 23:08:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4f:b0:35f:b75e:fff5 with SMTP id 98e67ed59e1d1-364a0f3d15bmr2695151a91.22.1777442916000;
        Tue, 28 Apr 2026 23:08:36 -0700 (PDT)
Received: from [10.131.77.91] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd6514688sm886871a12.32.2026.04.28.23.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 23:08:35 -0700 (PDT)
Message-ID: <3945df66-0f90-4371-a85d-26cd220dfc56@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:38:33 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211/mac80211: change memory
 allocation for link_sinfo structure
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260428090919.1798601-1-sarika.sharma@oss.qualcomm.com>
 <20260428090919.1798601-2-sarika.sharma@oss.qualcomm.com>
 <59fa69de18211d2f17d346d22f2d07bbe72c157c.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
In-Reply-To: <59fa69de18211d2f17d346d22f2d07bbe72c157c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: EIcB2QACeKmlmP1xA-oZswM9eap4YZaK
X-Proofpoint-ORIG-GUID: EIcB2QACeKmlmP1xA-oZswM9eap4YZaK
X-Authority-Analysis: v=2.4 cv=Wak8rUhX c=1 sm=1 tr=0 ts=69f1a065 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=qQ37hQgK-u3qeEt44QQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA1NyBTYWx0ZWRfXwHRUpop1LeL5
 i7cpwo76BsA4Ay9PeZr7j015RIk/nZvNxVfzxRwDqJSCX4b/xRNNuMibp5fJLvy7STKx/gELrfC
 sxzM1mkR2Jix7iQnD/tpigDQdGXbmnvJS1NX4xET5Ham65IOB5d5E7zgJbZXPKVWjTc8MvG1I/1
 GPaOeARL2xtJxkDSfnWGNY7VigwMh/MlRq/ofOhZrSxTDaQu0Z8pqboJhNacQ1gZsJjqGuqVEyT
 zIXX3wi/pTT+KYYlnfN+QrCF3RjWr9SMZhDy/dDPPwig/ZusiE9brGlPeyK1kjHOcb2rb0Ih3t8
 L+KNpJltYlR/LbReapirxWP5tUnUIxdUXwYwpuBow8jKkcm3e2L5l1RV8YaTcWFmBYgXvcKOtNl
 dE0F2bECe6O1I1obCeZH3McD2wQfOsNA5UWdJyZ4dvLMyLMbMkNAap7sPdLnpOuAWHwzceDHTVH
 6KRBvC6UL2V9IzU7QSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290057
X-Rspamd-Queue-Id: 3805748FA26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35562-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sarika.sharma@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 28-04-2026 15:01, Johannes Berg wrote:
> On Tue, 2026-04-28 at 14:39 +0530, Sarika Sharma wrote:
>>
>> +int cfg80211_alloc_link_sinfo_stats(struct link_station_info **link_sinfo,
> 
> really?
> 
> johannes

So, this helper API I introduced in cfg80211 since struct 
link_station_info is defined and primarily used
there. Keeping allocation and lifetime management in cfg80211 ensures
consistent ownership and cleanup once the link_station_info is consumed.

Please let me know if I understood your concern correctly, or if you 
were referring to something else in this patch.

