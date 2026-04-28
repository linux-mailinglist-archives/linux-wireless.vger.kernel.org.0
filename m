Return-Path: <linux-wireless+bounces-35487-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHAEJSqY8Gn8VgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35487-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 13:21:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E58483951
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED6C030D12DB
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6FC3F65E1;
	Tue, 28 Apr 2026 10:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ao5NKZBD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DsYjf6nn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03433F54BD
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373932; cv=none; b=ZDdyRdgC2PmAyfrXUFsTEKdegI9OhbiiOFL5h+tI9kGenoEcAHVgym2WdH3A3r6zoeGF2D7WYrrtQc7yIGQ7aSzFqP5DPoFHhUkPRsUObCrX8TiIeX/Y8tfZvejV2cpTLREgEraYQ0/MEE4AlLvYWaU8lHSoHeyJ9uSO7gu9rQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373932; c=relaxed/simple;
	bh=LfnMyE9oS9z9Ofu/betLSgRymxgsu7j55drLmBKJ0X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFbQ4S2z2FBxVWtcOobhO29/GyrvXffNyM8sb0ShkWGnRMZTAoLeh5yV/U2Gs0AcaQIsLuMqAtIHlizwf5I35pbjVlv74252mKNl+SCki+Zj61C02gq+FU/kdXNUc+a/ykni4BgPudd4A7tAucgTqJTXHcGY1huHL7981ctOm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ao5NKZBD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DsYjf6nn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SACORD2928898
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 10:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y52Yi+a1zEEjIQSW0ZftC3lUljIf6griQubb/brHq5E=; b=ao5NKZBDXRRrHWC4
	hW7R1+gUnQI2SaWQL+C3X1YXK09lPWZFary1B1nOI89B6FolH8df3MixaxF4xBFE
	L+3E6B8uIlfVxjtlsN1xNkg3we27A8nMtzNZ2IDPPa+QD8n6IQk7i0hasptARCOj
	4B1nJkxOGza9ZgR7doU6IrMbvoxeOiocqQ3AUFihWv2+BgQeGDSDX0JLQGoScdYu
	4A54vBigzcJkbdyrffdRoWg0pEjwVgHSLk4iJpl/xHDH/R7UH1GQli3mvL26o0X7
	72nM8Kk/mzBcsz3R1fXgdsMW1M7o/Ee+FN2II5gV/+vv/uS6RfSlq7B9thHxb2MV
	ON+HNg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dttxh8559-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 10:58:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so8431475b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 03:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777373929; x=1777978729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y52Yi+a1zEEjIQSW0ZftC3lUljIf6griQubb/brHq5E=;
        b=DsYjf6nnq/IaOPT9JxdnvBQrFVR84hLOEqGkvW4RunjjtCKyLYLJ5YlnOLfOM5BeHQ
         dnXCB3mSL9CTPtERXskY9d6yuZlIybKPnwk8KxQ4Jud1Dt8Zha0R61ln5ip0Mjqi2TUy
         hEa7RNHAxQzoCZOPqORp86KIObBj6w0CUQLG5oPlKz10sKIgmTfUJc+I88H6dkx005ql
         pGUGFU7RaqyTWm7rvheuPQ3/sabTraBcToyYtJeCTRniEhGv4sjglUiTBsD3qhXA86LA
         LxbhnVu8zo8V65w/SL+ZyBkv+gU522Axl2Fff297CTxccE03aiaIXoHhZJPssidFzv3+
         GfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777373929; x=1777978729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y52Yi+a1zEEjIQSW0ZftC3lUljIf6griQubb/brHq5E=;
        b=bkUfGXUXzS/OQOa/xn8iTjb8BLp9Wug1Je4s6OrtgzhVEvDjza2gMiIa8Os7T6uiCo
         +HbQ1oQO+Z6FcQVvj5V5NNDif9wpFmQBMzhDtfjSDhhYArQr7MHvzUy9PHCLWmZYT53l
         WJaf3RI0v505bzlepj0rYElaNIhjCRBqZ1Hp19Pmb8o4AQvz2zJIaHvLkbtaQKpx7g8L
         a2JhzKRRrw1h3N/WJiBVxkuB5/DWeJNOfLPLbcQFJ6aIxGHG9a4ju6I/lsQIhmgeXJwv
         N+r5bpC54K7eJQbBCaVCxDaiypmHLLjz4vcUFW7Np3kRbiEMqeUB/qyBAOOBIYJRoMpd
         +/Uw==
X-Gm-Message-State: AOJu0YyeN5j1AfL47enl6bTNZ1/0/CiESINvJ+CvOUJbGYbvFDTbzQdX
	X/2MZLO+PGG9BjTSgs+jKfo/lTBmHAztfKjfSwB/3DLpNsuM5E3VPNOHr7RFTh2zwIW/bFed9AP
	HFrW5sXJ32NuNwBN9hNGzzuCMG/VshCEwlHV8bQkO4FO3lXzyC/riZ3xPqBIhTTMZwPmg5w==
X-Gm-Gg: AeBDieuoZmcfHptT/4gjX6YjGw8xGHX6L6DO2wfHp1udOY8qkalcIV3x7ccPlknCFXD
	GnWL5p+oRLQAL0ws1x6UMR/kOi959eGH+6p99m5zy9mMDTJhZfCfK254Mcoa0yBV5rdOqqMyubZ
	86qb1yHLmlmIyqNX7kU33S/efSSe4ehKHuq/ZOJPnoPjWNt5GRoq4iMwc5fMV4ZcHVdC/Fd/CIQ
	ijfmV6pXDb63PFQ4nBbqUF/3TeMGCZ9Fct/ZEIJFQ1yIECMkQ5CXLAJhMPZDK3TT3r155HzLUJH
	OUVLQHQlpF7sbL+DTNs4QWx4WAlhhnneG3PEjPNcssri7jrFGXgXOm+4ihq00eu1B2fzsfFzgZD
	CbhJVryZZAT+ay6lZF/oq1gKasJswkDzZR6wSjDpAPlno8dEKasNwGgmoaQ3eFzIJ
X-Received: by 2002:a05:6a00:138b:b0:829:b08f:7353 with SMTP id d2e1a72fcca58-834dd37b133mr2138298b3a.7.1777373929488;
        Tue, 28 Apr 2026 03:58:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:138b:b0:829:b08f:7353 with SMTP id d2e1a72fcca58-834dd37b133mr2138277b3a.7.1777373928964;
        Tue, 28 Apr 2026 03:58:48 -0700 (PDT)
Received: from [10.206.105.147] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf6a1fesm2413976b3a.51.2026.04.28.03.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 03:58:48 -0700 (PDT)
Message-ID: <14c91715-321f-43df-91bf-c4c2ffc9bb3c@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:28:45 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 2/2] wifi: cfg80211/mac80211: extend
 cfg80211_rx_assoc_resp_data() for assoc encryption
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
 <20260427150735.2391680-3-kavita.kavita@oss.qualcomm.com>
 <e3fa97dc1d0bc69477d3a2d2b2bfec6ff0ddff4e.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <e3fa97dc1d0bc69477d3a2d2b2bfec6ff0ddff4e.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA5OSBTYWx0ZWRfXx3OieLwMa9hU
 D1f6QNrI5tYDIvkHoFTD6ezLB3Zlee6Zqfi3i37Hv6AbmcYzrZMFGxYglB6mQu/45fP/rcJ3S4n
 BvGqsV3DU1G5Bwsld+/04eKCAOzmv6SAAB8CU0/yNVjotlWhG96y6k0ZAsG+hJ0m2Q/Ai81vO0r
 2P06UP7V5OFZyfvct/cO2oBNzxeWaSJgSjRBSL7pU+eWb+NaAd2pz9WoyW4BqooTZ1xKeSs80qB
 aSPWYgQZoFeKtjrKZIy6xO2Nppm1Gdk7V0IJQ7OWHmwprw2dUl0M98+ii4O1hO00i5PY/zLmAjx
 OvvymF/7cjratJMFNucn7gET0yiju+3dXUZ8o3zHHE+9b2Qn2emY+z0T8Hf4hJwPN8uC0nQQpQ0
 muVd53/ese4Zrl4DeGkxZ0SP4wR6iS83cqlTBlFcov6dqhNd2G/02ZvLVQhsbdelzSHIdQXoKFN
 ladhZtQ3rqO99zIhwLg==
X-Authority-Analysis: v=2.4 cv=Uu5T8ewB c=1 sm=1 tr=0 ts=69f092ea cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=HCyXEqksTsveLR5shZwA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Z4x5qZojjvRKz56n9ulwO6lklpg-jrBA
X-Proofpoint-GUID: Z4x5qZojjvRKz56n9ulwO6lklpg-jrBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280099
X-Rspamd-Queue-Id: 04E58483951
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-35487-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/28/2026 1:08 PM, Johannes Berg wrote:
> On Mon, 2026-04-27 at 20:37 +0530, Kavita Kavita wrote:
>> Extend cfg80211_rx_assoc_resp_data with a new assoc_encrypted field to
>> indicate if the (re)association exchange is encrypted.
>>
>> Currently, when epp_peer flag is set, unprotected (Re)Association
>> Request/Response frames are dropped. This ensures that by the time
>> the (Re)Association Response is processed, the entire association
>> exchange is encrypted over the air.
>>
>> Set assoc_encrypted in cfg80211_rx_assoc_resp_data based on epp_peer
>> flag when processing the (Re)Association Response.
> 
> I don't quite see how this is necessary, even in nl80211_send_rx_assoc()
> the whole frame, including header and protected bit, is available. Why
> does this need mac80211 involvement? 

One could ask why it's needed *at
> all* when userspace already gets the frame and should probably process
> the frame RX preferably over the connect result indication...
>



If I correctly understand your point, you meant that when both NL80211_CMD_ASSOCIATE
and NL80211_CMD_CONNECT are indicated (mac80211/SME-in-supplicant case), NL80211_CMD_ASSOCIATE
will always be processed which has the full frame, then the point is valid. However, since
we are sending the NL80211_CMD_CONNECT result, I thought of passing assoc_encrypted there
as well for completeness. At present, there is no use of passing assoc_encrypted in this case,
so we can drop this patch.


 
> If this is needed for some reason please outline it in the commit
> message, and reshuffle the code to properly split between cfg80211 and
> mac80211 in the commits.
> 
> johannes


