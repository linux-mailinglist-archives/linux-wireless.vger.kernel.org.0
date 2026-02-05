Return-Path: <linux-wireless+bounces-31584-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAofHwxXhGlb2gMAu9opvQ
	(envelope-from <linux-wireless+bounces-31584-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:38:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE77EFF81
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 09:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA260300CFD2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7E8366DCF;
	Thu,  5 Feb 2026 08:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XXe+VIxJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VU1+XxwK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889134F27B
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280712; cv=none; b=LaMGyA7y3cmqNdqP1+bCY8Kbxw05RGoWxqtSkqvdOBARsVAxmG6lnuO1uCpfCCh2fFbbLNNWTLiWpR1EKTg3+XfXrSFqt81l81Q+Ddy1tqh5ocC4j/0i+1PhjW2ASsKwQ/6SCaabCGLp9pdd8abvkW5F2kTX2FB184fPyFiJ+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280712; c=relaxed/simple;
	bh=8Dgy5xYa7EZUFCxHDZUUNqz9jp1EnkLYzm1Eu3VUVZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fC7X7I9KawsZ4qawXmFekJ/5sWL6C7lOPxpnG0Gu+OB+hG+nkfhzMjMnITkWPg4UPnyZn4krwcebMIszEN3raTODIkorNGtWpY8Xf01D1tl2X2FfUQ14jiK9IqbtdmCMlvvApzTmaiAMrKyVlcsK7TnOTYOYF8+gBX1ILBYTyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XXe+VIxJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VU1+XxwK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153emTb2641875
	for <linux-wireless@vger.kernel.org>; Thu, 5 Feb 2026 08:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aQITtJsRqX1vJCqjiP/nSLak/Jwpn80v/QNRIronuO0=; b=XXe+VIxJJzpTqn6f
	YaqyGoZCmrfwnMmlIV92s1XLMWniLc4wqOazsuh6oCpkNdur+vrlcvBdslAh5PI5
	KGc9Sa2XcipUImiKxjTLkcFtMfRDDGQn3pufcl6O7Z9Pg3g4Fbzqk7eAQSWgfNkX
	Vkhys2i5pZ4N6jxm58EHrpTbHjSraHCzL1vc/jchY7vSlpsiaK1dBbozgYumS/WM
	RpryfWMwLc0tmz5cnVgdUm3bfEyWzZp5flIHbTkc4ZyaQplLnry4PpCiutccOoKR
	8Pvdr+uyKe/DhxLF/C5ahZEhoHhTrrL82B5sqLwAnFWA0u8K2tnmetkwQN8I44bP
	NkXJbQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c47qvb1bs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 08:38:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-81efa628efbso752661b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 00:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770280710; x=1770885510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQITtJsRqX1vJCqjiP/nSLak/Jwpn80v/QNRIronuO0=;
        b=VU1+XxwKnVJgV3SfwRQJv1IHJf5MKOo9V3uVYV8SETtk9FTxUR4YgwU/xLaGj+m5pu
         BS1M6qCGN1AwjSXVi7YpGP53bmzxrupVLHlhsS8dAnftAyLhht9qCfeghNNk0S7zMvu2
         yBfFUy5n0GADKAwNFrdOmpy4JKlkFZdrefR2A+CFv0gkzY0yDwmVLMcbba/O9yQWJ2yP
         HD/8vNFvx8lP6CzKiiJLwrhd5uXzn30B1vt4cj8TLZ3B2gvQFXUj4d6ThrRh9fHu//rg
         jbtWS8BJme0gcwCyFrS0wo43XjzzVGPAQjQRx/AaS/2X3ZDhfSolCZDQrwErqkY3vlmg
         Botw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770280710; x=1770885510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQITtJsRqX1vJCqjiP/nSLak/Jwpn80v/QNRIronuO0=;
        b=f4JpU7MUnP43n+LvznW7Wbm53Z+glPHvtM6FvLmE4sCkEXUdwFZm7bgT0wxjLWeu2D
         DZIYl6FY48wH32VoCeUf90I3NAoOhv9TiEcASTeKAQYIWm1CMfDgQZWdR5l+emETrkSk
         wFaPxl8Hw3QPe04gDBrL64cTtyLlWuRMCfz3g4ilA7PAD/o6FOgf/H8/BA9dB0+IQKNM
         HUE/m3yyBvVngCAcq8XMKooQan4UFlwnh8ukeiqoN1/w33fmdEwxQpLoUOASEVz58MCh
         E/bw2gF8KaiTHQC+WDcSfnFRQf61W7zgh2cddz444CJBAEihB+INQa8twcgTKkswTpfO
         aVKA==
X-Forwarded-Encrypted: i=1; AJvYcCUaMdSK/ZQx0Rvx3+j5nIUCGFrNQlK0LXlh79jY+gIY/LrucuDqG+k4p6s+E755cNRfK6Mx3gkO0hcMtuS2gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznpRQ8XEK15awebYyldssJQkX+RKkqGmcehzcrJPa9qvNVvoh6
	J4LRLhxzsN0uYlVEhyw517qS7OhMGDFdxraQ4ZbQzLlp5ET2UcEHJ80V2eGl8dFI5d+ZScqxyhI
	TdJNUd1POcPPjbEtojxTHvaC60n65JGJPNSlGAtBi53CXZ79L1ew5IE2WbV0/IyH6/D81YPJ6jB
	Y1Tw==
X-Gm-Gg: AZuq6aJ1y0ZvNxckImjkjpy4+d/ygXt/5rVNL/ohvmg+gK29hgVDT+lhYYRtGsDsNoF
	fvN8yFcdumOVQdHisi8IBqci7UJUuLF1ZU12APxbVXr5W0dAetSmvlCrMCjyIiX43/Om6OGtYyN
	bz+P4PO+61mxZchPmqVj/YyDbvlqTbGo3y9VfgbeuyRku7t6TPiL8Uy80uLw2KaJ1i4e6RAigRP
	Op1NaEn+x4MDsigJLeyrfzS9POwtAIWkJzR6n1TDPUlq6tiJiouUodoHMOm5vD0roRYzKuBtEmj
	LbOGdAbUmZuaSSe+gUAOZKUho09VrX2JgF9BZavzuZP/TfFq6AXkAu1/bFGNMaEcYPK3kb/qwxx
	/2Ry53UZVFxD11LVC61YZcLqw0IuuDg6+MiiZM8wGdBBMxh2Rq24=
X-Received: by 2002:a05:6a00:7486:b0:7e8:4471:ae55 with SMTP id d2e1a72fcca58-8241c5edcb5mr4520655b3a.33.1770280710232;
        Thu, 05 Feb 2026 00:38:30 -0800 (PST)
X-Received: by 2002:a05:6a00:7486:b0:7e8:4471:ae55 with SMTP id d2e1a72fcca58-8241c5edcb5mr4520641b3a.33.1770280709784;
        Thu, 05 Feb 2026 00:38:29 -0800 (PST)
Received: from [10.152.199.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4a5c28sm5837833b3a.62.2026.02.05.00.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 00:38:29 -0800 (PST)
Message-ID: <3e8c7494-edc4-4213-a6ae-24f0853110c7@oss.qualcomm.com>
Date: Thu, 5 Feb 2026 14:08:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 0/3] wifi: initial UHR support
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260130154259.265130-5-johannes@sipsolutions.net>
 <98c47cd2-6e90-4a17-a8a3-ea2d2290a72e@oss.qualcomm.com>
 <e0090840157dcb9968e683dab437296871bbd4a5.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <e0090840157dcb9968e683dab437296871bbd4a5.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GaEaXAXL c=1 sm=1 tr=0 ts=69845707 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=uAJhxH7tUyNBufTIDTAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: kmFmKDMIExn63ArxFvMLXuqiq6Rc6L-d
X-Proofpoint-ORIG-GUID: kmFmKDMIExn63ArxFvMLXuqiq6Rc6L-d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA2MSBTYWx0ZWRfX0UbbarUvnJCK
 iKTtFeQV3ZdyYAHgPdnIhn1PnUmVw7N91Hc/RrtCQ/st8pOyj5XKTIfnME0dfnnISST6R+3MLgv
 rDtCPAcgRv9F2J42kGWTonC7GtdG2mDGC4T9Mj4905Pgwx/XVB5tK5XJEudg5zcwlJtiqhTPNtV
 XElPNAvagNIEfAZbizZh3/TacQsYonffRQn7fBlzHmaE3TYkZEqSDsjjKjgB31ZKezUFBu1IMjp
 M2lyHpt0XYByjjVWdFvQrfUhJxfI3yj2FF58CWDrgKJzbdPE4fL2H8i4IZrHgGK2u4j7TiOO0Kp
 buK7cVVcCJL+BBOTQqkWujica2Ethz/gEb4xt9Pg5UsoM+0QA/CoG9W4BGLp4I6tjZ27gNtnxch
 n0TIf7lUoZ9kZJnB77dTbrUb7poDL9yYApxrqNQ6hiSgd1kDTxxMj0ohjuVTxXGqm6npeECZn5r
 rRkY78zN61GF0zbeudw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31584-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DBE77EFF81
X-Rspamd-Action: no action



On 2/2/2026 4:42 PM, Johannes Berg wrote:
> On Mon, 2026-02-02 at 16:20 +0530, Karthikeyan Kathirvel wrote:
>>
>> Would like to see your approach of NPCA for AP side, since we are
>> working on Enhanced critical update for all UHR operation features(which
>> includes NPCA as well).
> 
> So, FWIW, I went over this a few times in my head ... how do we support
> it when one station has NPCA and another doesn't (need a per-STA flag?),
> how do we update the NPCA operation when stations with different
> parameters join/leave the BSS, etc.
> 
> Ultimately I decided that I'm going to leave these problems to you ;-)

This I'll check and come back

> 
> For now literally all I've implemented for testing is an ability to
> represent NPCA in the chandef (adding npca_chan and npca_punctured
> bitmap to it), and two new nl80211 attributes to configure such a
> chandef.
> 
> That won't even be an upstream hostapd patch, just some hack to set the
> NPCA chandef in nl80211 and advertise it in the UHR operation element,
> but it's already good enough to test a single client.
> 

If it is a hack that's fine, but any change in NPCA parameters in AP 
side should go through Enhanced Critical Update procedure as per spec

> (Oh and nl80211 won't accept that unless the driver advertises NPCA
> support in UHR for the AP interface, which our driver won't do outside
> some testing mode.)
> 
> johannes

Sorry for the delayed response

/KK

