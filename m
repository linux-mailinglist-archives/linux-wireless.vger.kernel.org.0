Return-Path: <linux-wireless+bounces-33619-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKfCChOcvWmR/QIAu9opvQ
	(envelope-from <linux-wireless+bounces-33619-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 20:12:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BF2DFCA2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CE43009CED
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5A32E6BD;
	Fri, 20 Mar 2026 19:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxaIQgsX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A4hOE+HQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2472E6CD8
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033850; cv=none; b=q4kOgO4ckQhzLBP922qN4x91zuTrtmsBPUo9ZV9Ti+UP3WN66aF7EKt9dZtlkRk5nRHG54CLw1KjrUjCjpr0EVDupwg1ZKUkHElms0YBd/WBsHuuLgJYnibBOliOULJz8SRZijhR7s0bRdYNe5kw1Zt7aqQAsIdYJB70HBj+sz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033850; c=relaxed/simple;
	bh=tS49Mvz2MpR+od/BQozx7gvzEHEIfHGI1W5Pr7bQCrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAqhqcVmI8AdijL/fV7w9UsEniCOfSXlv/gikabMdVYGkCFqpfhvZdsSVh+eUBe1uvgWqZ3bm6DuM+c5xno53TKQt9OJ+OMbOZBUgDUmUg38IgEQeroKNWNqz1OURPCBn403v1bWQgQiREO6lJ0Rh1I5hFSSxGaLqPDmF3AlUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxaIQgsX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A4hOE+HQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KE4nF61191537
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pR4RfQsZmlGcUKDHoiv6xA+zgiFYZJxEtFrDtHqQMJo=; b=cxaIQgsXtYuNKdkt
	JlOiLBCSlYrRLBGmHgGl+tPPPogpeZ72wGcf1GrzHpG69INf6avVDA1lvwEbIq2E
	XHfuCLuHtbpQiPtJ7Jm8ZUse+H6pd3ZYsG624ne8/IWIiPhFj2ZR+2DxGVHenYu/
	tJP+hQJBdsh/y3hMXBdpLdft9hUIOtYpMaPnYJFNb0S/3yLDrIBkznAV+MgI1bo7
	BT5Qp9OX2Mdgr5HTmJKbKYny3Tj5n4yrH3V9LM+RXwcH74i7gtrwOOV72EuZAaSH
	pawrvoopPo+FlmaxkeiWdFOXvzwP4WbbFpPi/XmyhOAcj+AeIAq+ypmBZ7BoWssL
	qhLZXA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0pvhuc88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:10:48 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35a0998a441so12370951a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 12:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774033848; x=1774638648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pR4RfQsZmlGcUKDHoiv6xA+zgiFYZJxEtFrDtHqQMJo=;
        b=A4hOE+HQVid0uxA7X2fF+wnzY7XrrTVL6Q2Ry/xNpn66TkILttTSQn9m9IOQmPus3V
         n45m3k3qJkJ3IJ0S8khnN7kIu97A2r7JSru1B+GiDFLqyEwnBAhPrDi3rcyfSnSgXcJz
         XxzCqFeH1mF/If1FN7PRXmI84wJPB+3K2o8qXK7cl9AkExgTXiPulEIdlQm3UHtLmpZw
         DP5z/t8NB2aNe+8I1Qdh3wT7KI9Lyc2bIy/6646eYgMQ4j9MGQkFLf1Vrt/Bvs6Fj6Kx
         mhMyHYfEWLKhig/ttB5Ij+7nDkG+9TqLJuo0GZaHLZZK1kmOlah/39gOh8fPad6iDEFB
         arow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033848; x=1774638648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pR4RfQsZmlGcUKDHoiv6xA+zgiFYZJxEtFrDtHqQMJo=;
        b=QqB08gZbjOhrwO+ApZyAq3uq9PeJTk52QlaHwJL2AQYYCCWHQ0/EHAeKl3kfQ1hYzF
         2SSdkqFO6WcGEpz83k0CSJwES5N1WJppvVMpa270uz1pCdkg49maOlF4MGuPhO93pKVO
         0wK3lglnaIMO/Suk+i7QRoI0+wUN7JfF0wgxVs3iZrL2d0SdGU9dnWK7A1h6huhoT+zH
         G5D/GRzmB+/yCrBAf2SbOKCRkNYALemPiDmyLfyQSyX0kH/4saX4byjUqU737udAtzeX
         Xgg2Ajl2wu1bAEHh7EIjyfHWtjZ9EE9VfaONA4va55QyHY4HFC056UPjshn2M/rkbapz
         UVkA==
X-Gm-Message-State: AOJu0Ywd+CV/b0Wg6tDgSmobRj5eIAyc3SK8AQhekODlgXywNOpiJGFK
	xK3QmbF3XZqNoDay+V/f/n8CKNKjSf3uDX5ijITJG6kQSpCSH2VMCW92PUmFunf/jfaEET31pq8
	uhIDtKxsJMfH5PGec1JLAv1oQbzkXGBkfUxCHv0QB3JxQfSOa35TkVY9cXHhtC2MKIrk2
X-Gm-Gg: ATEYQzyE73KIke7TznHLBiCPNSwhQO0msscDXxgZME6h1+sJhX6JmnNY9WI15Eg7Xtg
	8GQXEAWtEdpsGK3XfITI4U8eJ/PRO5e4Ow3rNHz5BikHQBsENsQQ/EANdUB9s2Fm7ZrguQyZ8Zz
	pU9ZXbvgOZ+0pvQ0nVcl8YtmW8T588gDzMyw+pwbKajoGJgO6ncasc9eB+5BHBlNVGMAbaq3naV
	c+Ta7Yit5JiG05JMqY2IbqPRfJktt5+klJYuLqowQO4gr2406/kEfEr5yLcZB7lZiT1remIzsCB
	rOqIpRIE1ik3OgBt1fGvvZInAAonmKjGFmqvL4/B7KRi4o9E05F+j3+JCDLgNhkdKfTm17SW8Yy
	STRP+Ip/qm/6KN2Xi6+rYsdeX9en0BpoemTL300MxKRKbn78oYT8qrmA=
X-Received: by 2002:a17:90b:3c4b:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-35bd2bdb7dfmr3155661a91.6.1774033848085;
        Fri, 20 Mar 2026 12:10:48 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4b:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-35bd2bdb7dfmr3155573a91.6.1774033846251;
        Fri, 20 Mar 2026 12:10:46 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.214])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6026a5asm7405580a91.8.2026.03.20.12.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 12:10:45 -0700 (PDT)
Message-ID: <2a6f39b0-98cc-4874-bb1c-3055201e811a@oss.qualcomm.com>
Date: Sat, 21 Mar 2026 00:40:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 14/15] wifi: cfg80211: add LTF keyseed
 support for secure ranging
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-15-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB8383484D69A62802D1CC6898FF43A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB8383484D69A62802D1CC6898FF43A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F95at6hN c=1 sm=1 tr=0 ts=69bd9bb8 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=VSCeRQfBNntvLL3gq5i/+A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_CUiv2pmZ6_Yma1m37UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: OeDpx02cDLZcq078NsIzheNahw7YBKA1
X-Proofpoint-ORIG-GUID: OeDpx02cDLZcq078NsIzheNahw7YBKA1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1NiBTYWx0ZWRfX6u66o3NfSCaM
 61mCEZBeO/q6So/8irnLdQNsiBHR4bdO+IoWV+D2J7Zp3SunpU8vtHg2cwqsWk8AWlMjHVmaABz
 JjjUE1CpZZHHhJNm5U5v0qudY6WGuNW25Kkd+F86vLOJrBOIOvo2YMdOx8KXQjtXGVSuWMsEyqC
 QPk+Z5J/f5QQiOGmSnt1EMHLoBJm64qvmHyhiFn0dojvzNs3Hhz+2HK/Tq+ceOhI8074buzLPEO
 GaSGmC8D2+rJUDWTOvAnyF/Irvewf3Q/MJVPykc1r7mKKtZdQcWT6e3I6Yi+XwkqXWLj9ccK8rs
 hJbssckSkmOaPsF4RoPcJScsb5Wv4WOEbrwIb/vu03Oljvd37owg/V88twfAPfxeU6q9AHPU/Wm
 +n5hvnibuostGkMOEeuvJrmSGTpRqEcjquIlxx09AapOgwYHE3hWaQIi74UcQqEo/s0PwlghKXl
 /2KpWIkKp+INbrvkRzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200156
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33619-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:email,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 829BF2DFCA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 15-Mar-26 1:52 PM, Stern, Avraham wrote:
>
>> Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 14/15] wifi: cfg80211: add LTF keyseed support for secure ranging
>> Currently there is no way to install an LTF key seed that can be used in non-trigger-based (NTB) and trigger-based (TB) FTM ranging to protect NDP frames. Without this, drivers cannot enable PHY-layer security for peer measurement sessions, leaving ranging measurements vulnerable to eavesdropping and manipulation.
> Installing keys when there is no station (PASN keys) is something new (not supported by mac80211, is it?). so currently even installing the TK from PASN is not clearly defined?


Yes correct.

>
>   
>>  struct key_params {
>>  	const u8 *key;
>> @@ -839,6 +841,8 @@ struct key_params {
>>  	u16 vlan_id;
>>  	u32 cipher;
>>  	enum nl80211_key_mode mode;
>> +	const u8 *ltf_keyseed;
>> +	size_t ltf_keyseed_len;
>  
> Since the mode is NL80211_KEY_LTF_SEED, can use key and key_len, like any other key.
> On the other hand, LTF key seed is not really a key... maybe add the KDK (from which the LTF key seed is derived) instead?


Yes LTF key seed is not a key but it is a pairwise key material to generate LTF keys. So we are configuring these LTF key materials with pairwise TK using single new key command 

>  
>> + * @NL80211_KEY_LTF_SEED: LTF key seed is used by the driver to generate
>> + *	secure LTF keys used in case of peer measurement request with FTM
>> + *	request type as either %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
>> + *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED, secure LTF key seeds will
>> + *	help enable PHY security in peer measurement session. The corresponding
>> + *	keys need to be configured beforehand to ensure peer measurement
>> + *	session is secure. Only valid if %NL80211_EXT_FEATURE_SET_KEY_LTF_SEED
> "the corresponding keys" - refers to the TK?
> "beforehand" - before installing the LTF key seed or before the measurement?
> This is not clear. 


Correct, TK is the corresponding keys. 
and yes we are referring to before the PMSR request is sent.

>
>
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

