Return-Path: <linux-wireless+bounces-32548-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO2CA2ynqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32548-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:55:24 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81076214EEC
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C2C308E84C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E5A383C8F;
	Thu,  5 Mar 2026 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lgHyc6GA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AWbKP/xd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820013BA259
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725700; cv=none; b=IHoJbFaxiaZN1p21s3BpzltHE95X7DULzLin+AfUIQYWHlfpyvIsNnmiDZMSwb0GKhOut+Icf3C5PTGkOHpakmFLmcGMdhl9q4f+TsuOLwmvikJGWSMbOwwvBkQ9Szg3U3oNDCU2ZYm2GVriu56JF0sPFy6m6tJpDUTclZvGUg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725700; c=relaxed/simple;
	bh=WCRZMrV7/XKRI8upVldTBEzDpvhTG6VyZhnRZ0fpAVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpKBhQ2SQXk1xLffmJlIauNKVP0C6TTejcu7wZp6C1vzMehAw4oNyUH5RRi0ajuZtxjpJUSXNOXW3mBPLAs+VYA8zpv0GdDSfbl5pBHDDIyQAOUHBr2ogF3U0kXtpt164h6CVGQxx/2gHhuzYDXYfWWLfPAexWwtTh9t0VoWPs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lgHyc6GA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AWbKP/xd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AGFXH1519562
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 15:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6MQkzoXXi/qyeQ5gmsyZotV+ajMOrQdBofYtxLfUMMc=; b=lgHyc6GA7ig0jZ2R
	clLCTlzUyNjQbBf5+mTrVHJijxFscewUVhSyMB2a7tutVO6v4ZO3Vflkx6m+jeNt
	KFf0iXOvUEUvm3I8051Ia49ycI9VWvKl4KJnSJ4OwPmxDOYlVKY+VHL9RMpmP9kg
	l5g+i09Ir5NLjxo/zy4R7I7pSIy2fTSybPsXssjHRvbVrY70ubyJ3dW2RViB7LP8
	dHAPclN6Gq9BkOk23MunXIgS2rDlYE2PCEVSMCAfESZIR4VDdNkQIU3XsZYoIRHC
	apuV8GPNP7HvgL9THBKQwSsk2/XNTMg8u33xwBHSmvRr2Zuo11Z+Alu1GZk1FeaT
	4OJp4w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpuptkc1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 15:48:18 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae47b3adacso46115685ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 07:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772725698; x=1773330498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MQkzoXXi/qyeQ5gmsyZotV+ajMOrQdBofYtxLfUMMc=;
        b=AWbKP/xdGynVzIUXCYi+iuy+8CSQ9gi4WsJJXVM67V8Faxd2yx+QvMrkR55PqPoAhl
         QWNCzvPYzk7q7q6e1MWTxt59lStgs2HSTu+NUjQuhh0OecSAsNaQ/TF9yCbeUVGzY8MJ
         OlSBsh3ZkEfnlqeXKMQIgKy+Hs11qwgS4LKpRTUseNn7Y8BFZs460lfvlE+K0LmN33aY
         EW1NcoqpzZlnw7FWBdm56ROZu/vP3uETSEENMomYwNeo0VJo2x0uCpVYCPt7V1beBsBe
         CyT9XTHM5dnJwXeMj1qSXiXm+li863EII16FzDbnCZ+85U2dK74VIlohrcNEffrkNT6P
         7XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772725698; x=1773330498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MQkzoXXi/qyeQ5gmsyZotV+ajMOrQdBofYtxLfUMMc=;
        b=rvyCGFaTuc8Kh/AtGGIZeVHy6LCfqG3XAKmfk67irPTSXAQfL679VZK/gHTO1MaSpk
         xXvKZ5HIQFKq6RfsJO5l9s1HEJeLSiTcbKSzNzXdQRN2TSuaaSoxGunDaBJV9sF7FOap
         4+/8rR1CnbH7sQrl7ORk4OUpYOlfyre9rRsJjdrOaYQDC6uL4io33ujVUWuqTvu4nS8Y
         DQ4EA1kEEDo9iyzyi7qRpC622P5ZXetFzVx9l+qT2xigYw2WPqctKf5UHoe/yliMLtIA
         mnpMOdy0941f49HLSSGaE73HSUyx066ZanB0gf3MHScn1ofKfgLwXs0H9OQUIJoMDQqG
         F6JA==
X-Gm-Message-State: AOJu0YyThL8uUFyjsl/vQ6QU/4ftm1dli4FdAyV80XBU+sCeD9ZPZ0z/
	KNDl/ZaYmQv0yd5Fcw1Ni/vEO85QCbqgIPszjn0azruTObA0TZPn/7YknoGbSe+s8wi/kAIY3kz
	E5hAgmSIZh1xvyqrAERa47SC2p4i9EorcaYYjjEBgDSftimmx/PWWYj8Bhc84jo7Xyp3L
X-Gm-Gg: ATEYQzzDixnIwl+q7OCrxcZEGGg+k7OCXco9bLR8v1P0t4AXVfmQl88UpSK16fpoSTV
	TqZGSLa3Xr1vZrfo9Ah16t1VeACJ895851FXJX9Si1ZdX+dY4sjDROSobYZHFCOqNlAs7PIIPYh
	j3u16HAUIZ+n0mCZrCLWdw+tg4gHrRegnmIlLsBfKNqrx/p4VltPqaKJbLGc82ozdIutHAcamDi
	SOnqm/d8h3X2CJHt1fkRaKBy5nS8f4bnihMJs4WS9+ze3Q6yC4ysjN5lGYIjuS2+9yQapXB9JLz
	W9wDgTnZlyjx5EgJErdfRUpA8jQwVBUpLSxvMaqU8onDb4OJ5cEPo50EpJO+PeIZcYH6Yz9Bl7i
	vVpTlQgAhpF5gCHtaUtLdyRR29bNrGb++GJyjGjPVqfvnF7Ks2uvj
X-Received: by 2002:a17:902:e78d:b0:2ae:4d23:3364 with SMTP id d9443c01a7336-2ae8028f319mr841085ad.52.1772725697732;
        Thu, 05 Mar 2026 07:48:17 -0800 (PST)
X-Received: by 2002:a17:902:e78d:b0:2ae:4d23:3364 with SMTP id d9443c01a7336-2ae8028f319mr840875ad.52.1772725697249;
        Thu, 05 Mar 2026 07:48:17 -0800 (PST)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3a9dd3e7sm164634165ad.40.2026.03.05.07.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:48:16 -0800 (PST)
Message-ID: <3b5d8e4e-1ecb-4255-87af-86f1a0ca6d7f@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 21:18:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 15/16] wifi: cfg80211: add LTF keyseed
 support for secure ranging
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
 <20260304071538.3833062-16-peddolla.reddy@oss.qualcomm.com>
 <8669fc9bcc8250ec71ddb293da5022881ba714a8.camel@sipsolutions.net>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <8669fc9bcc8250ec71ddb293da5022881ba714a8.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyNiBTYWx0ZWRfXwwGqnslD22Di
 4oBgOMd0MfgU/PK3JXtcF17KhBz3WZpvQxQ7jmKFZxnLM+oszC39qZXINdVI3Cu4UJ9COZLD3XM
 SdDhQ3KQRX5a801/clvyWK6mY26ScjfSemcd9faGHsQmNbJMsLeCxoEZugDqVAUUAvzXq3onrSD
 F5MHONwbRb2Pd5W9WyuJ2zSqmqGPgZu22FA8cymYIDCgWKEDb15QEK0/AJHYo6UeKtpLZXIRnWH
 Ig8nR14v+T7V3gwTwoKqrgmZGbfGJVHyTwsY41MpxxmsF4QrmAMElhtkBE433Dh0BFzZZLHtz12
 M4aSa0pQTapSxrOXn8tHW78T4sZpu0d/fz7/Em6uzrc6PwRU1pltUMHqOGyDbaALMT1bikUI/qr
 N/sxm2ikW/u3LJCqA1gzNZwRsU/tkpmuaOCRPw62upqOgAgjyKEOIRw8vrE+1GZTfHJhb7l7KDo
 eqWBEtng2EFlCwVAoXA==
X-Proofpoint-ORIG-GUID: xxESWTI8JQ7xQevO1ZtOSZ8fE6624QCD
X-Authority-Analysis: v=2.4 cv=Ddsaa/tW c=1 sm=1 tr=0 ts=69a9a5c2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=UU2sjmbT3E7BKXBA-K8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: xxESWTI8JQ7xQevO1ZtOSZ8fE6624QCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050126
X-Rspamd-Queue-Id: 81076214EEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32548-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 04-Mar-26 5:33 PM, Johannes Berg wrote:
> On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>>   * @NL80211_CMD_NEW_KEY: add a key with given %NL80211_ATTR_KEY_DATA,
>>   *	%NL80211_ATTR_KEY_IDX, %NL80211_ATTR_MAC, %NL80211_ATTR_KEY_CIPHER,
>> - *	and %NL80211_ATTR_KEY_SEQ attributes. %NL80211_ATTR_MAC represents
>> - *	peer's MLD address for MLO pairwise key. The link to add MLO
>> - *	group key is identified by %NL80211_ATTR_MLO_LINK_ID.
>> + *	%NL80211_ATTR_KEY_SEQ and %NL80211_KEY_LTF_SEED attributes.
>> + *	%NL80211_ATTR_MAC represents peer's MLD address for MLO pairwise key.
>> + *	The link to add MLO group key is identified by
>> + *	%NL80211_ATTR_MLO_LINK_ID.
> I think this is a bit misleading since it mixes up the key attributes
> now. I think at this level it should refer to %NL80211_ATTR_KEY instead
> of the specific nested %NL80211_KEY_LTF_SEED.

Sure, will remove this.

>
>>   * @NL80211_CMD_DEL_KEY: delete a key identified by %NL80211_ATTR_KEY_IDX
>>   *	or %NL80211_ATTR_MAC. %NL80211_ATTR_MAC represents peer's MLD address
>>   *	for MLO pairwise key. The link to delete group key is identified by
>> @@ -5602,6 +5603,14 @@ enum nl80211_key_default_types {
>>   * @NL80211_KEY_MODE: the mode from enum nl80211_key_mode.
>>   *	Defaults to @NL80211_KEY_RX_TX.
>>   * @NL80211_KEY_DEFAULT_BEACON: flag indicating default Beacon frame key
>> + * @NL80211_KEY_LTF_SEED: LTF key seed is used by the driver to generate
>> + *	secure LTF keys used in case of peer measurement request with FTM
>> + *	request type as either %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
>> + *	or %NL80211_PMSR_FTM_REQ_ATTR_TRIGGER_BASED, secure LTF key seeds will
>> + *	help enable PHY security in peer measurement session. The corresponding
>> + *	keys need to be configured before hand to ensure peer measurement
> "beforehand"
 will fix it in the next version.
>> + *	session is secure. Only valid if %NL80211_EXT_FEATURE_SECURE_LTF
>> + *	is set.
> NL80211_EXT_FEATURE_SECURE_LTF already exists today, and is set by
> iwlwifi/mvm, so I'm not convinced you can just redefine it to mean also
> LTF key seed is supported?
 will use a new extended feature flag along with  NL80211_EXT_FEATURE_SECURE_LTF  to resolve this.
 would that be an fine ?
>> +++ b/net/wireless/nl80211.c
>> @@ -983,6 +983,7 @@ static const struct nla_policy nl80211_key_policy[NL80211_KEY_MAX + 1] = {
>>  	[NL80211_KEY_TYPE] = NLA_POLICY_MAX(NLA_U32, NUM_NL80211_KEYTYPES - 1),
>>  	[NL80211_KEY_DEFAULT_TYPES] = { .type = NLA_NESTED },
>>  	[NL80211_KEY_MODE] = NLA_POLICY_RANGE(NLA_U8, 0, NL80211_KEY_SET_TX),
>> +	[NL80211_KEY_LTF_SEED] = { .type = NLA_BINARY, .len = 48 },
> This probably doesn't do what you think it does, unless you really
> wanted that it's *at most* 48 bytes. And please add a define in
> ieee80211.h for that.
>
> johannes

 will fix it in the next version. Thanks.


