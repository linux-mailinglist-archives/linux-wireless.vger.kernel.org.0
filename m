Return-Path: <linux-wireless+bounces-31785-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /7E1BpMTjmmZ/AAAu9opvQ
	(envelope-from <linux-wireless+bounces-31785-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:53:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 543C7130159
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 18:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D2D2300D9FD
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 17:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F9A13777E;
	Thu, 12 Feb 2026 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HqkDQBOA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D8mYU3SD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9786C200C2
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770918797; cv=none; b=A3Zy1YFgsUvTSQ1lEUXLbqEeETDxX+l+RuI2xeK2k0Vcj6EkdQoQRPOiE8Bao+TTo15e7Gjsh4ndCtiodDtm/qgnMcglYE8Biah+wzhvVeBSkqlP7LHoY1ClNFQriOX+YAs4ucgxFO2+YXZzERUHcEa6Zakq1o9SWgPRWeUptag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770918797; c=relaxed/simple;
	bh=+dKXsUxuhHX9XZRNwqNCkmt6k7E6gWQAu6E58WUB8Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rht/c0JfdKIktQZrRidQ6euLYgtngvTOi6qejmFppp/U9vW+LZU1Pcm++HClvomrxEpozkNtpAX5aPE8KyAkMnjYRMhBp+H7IdGYhfaCpujZGzbr78pZp4TxR45f7N43odrrxPpmby3B4m/GD1TGfcfBFP3yBjGwlrPPL9veVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HqkDQBOA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D8mYU3SD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRfk2588641
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IkTTp52mJ6DXf9gr79/0dYtfSZzxQH+y7ktaIbvrwkY=; b=HqkDQBOA90wvv0eO
	BpIJ9KLOzdseO60LuJosEiv6m0fu/ujT5eKp5UZonYG62DEXM7nMe1jvfOQAD9o3
	VXz5AT0i8hvfrZuxYlBlUQyw7k3OFsbHbJvHjo4GZZ0zAhaMyYLlV7xSGAc7HMML
	AO/GZfqX3cpv981W2EIaFQThbPPINRuYRDgQBBD7ATWq6VLUi5zrB28CzFKhxOcY
	jjSTJEUZqABY6GJoKvMZ0A4cwsJi2OI6zWzQNp/DiJLHGW1XxeToCoq5ak5xDn3Z
	fA+xck0yPCLm5Z3iCKuoiei5wsX9aSPEnqrwWP8SQJey8T9EJjmzNL0ULbRcqxDe
	P7K+nA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c93snkakt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 17:53:15 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c67e92aad79so30045a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 09:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770918795; x=1771523595; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkTTp52mJ6DXf9gr79/0dYtfSZzxQH+y7ktaIbvrwkY=;
        b=D8mYU3SD/+bViip8gBrehcePa7CHSDKuD6rNh3qJCZmSynNRKNGbsINoWLYwGixF4E
         dchnao7UnJAIkYhkDHXMHpq4sAoa/l2AfZYHYbgKrQ9cwxa/1yDreIvXwMKFjNTxSjKj
         i2n/q7XKzpXIY9YM6XP/3oxa5QGQvjwHQyeDlvR9cf2DT/xoFjDAPDttaZGeoBbIkpSk
         GEczTKbxF2pNjMld0+ExS+1i4nDZWdSQpDsKBV8qnI4wy7yxC/Z4inWRy1OyT1WBAJwC
         lLAMcNZnavTM3qHrQv0zyh4WAmQIGGYb5/dADSNFAL9z0MNp/c12Vgga1f+XUgguzKfj
         DMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770918795; x=1771523595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkTTp52mJ6DXf9gr79/0dYtfSZzxQH+y7ktaIbvrwkY=;
        b=wxuF7jcJC+2cZq81Csii0Z+JM0bM/46GhnIKamLt4TQvdk4AWOAcYl19bMarEgQ5Xb
         LpPhpsM+ST6DLqqoKSNe8kFy3q1YvfLT+yW0SOLOUvaM49sUXM/cKiIiLY6SQULx6UNw
         StC1UXo4TYGtHKkTfCembtSAG8KWNHoBaQlpZW1pB08LskmiVHzar/HgM+sJ5E499T5B
         PyYcPCAJRL0Tpb5zK/AAF0M+7GGVB0/4NktP9KDrBRoHNqK3hrmycj6aeEWKbSPXtIS8
         GXAVr3COw8xSlAGPx9wJt51bsCXwWKHheaBnQl7iSSLbdczyapt7NgEbCrB3gxmR0hmr
         yQOA==
X-Gm-Message-State: AOJu0YzWi+v43XlMEYm2mbAeFr9qaQ8aCb86MtmxZh9uVA/nEFBfVoV6
	7ky+02T1Wpahd28MmzRJ1s4NH8UrquhX2+RtrvPJnKZNBr8Bfd2gJnxlqPj2CqN+BlijOi4pBRa
	N2nlrTwpVuZkr/SE6PouvvSxw1oa5l6QrHxBfDsN/yXbq+QDxXgMquXk/4Nh0AosZXUfRdQ==
X-Gm-Gg: AZuq6aLjtHyMWL2h7BAEseh7lN/JXPtGzJy294pgnsF1TuDWVW8caymMm5IBWirQl2b
	EgbTcwb/KH/y4du0jTxVBvDHGupGKodtJEN+BhNkL1KZ15J2onuoMl5bHwzt0E2E7Eqdy4Of4up
	vyKiUCRCRU9RHCk4pQoj9Q2I+JrbuqgfI9S+nNmD7+ebDLLKEFX/QxfDhyWcZyo2K/bltePxj8f
	PSZrzOhEquYPBzL3LIc6rB55t8pEzLIHxOgL+r7qiNlpdMbjTaD4doHAp5L1hgbo82AgeevYex9
	2AAtR+uVDSxdEfqHtfzhfIwvXSBVCJG+Bh0VCooZD5XyfZCXAusr6DWnP7BynbRnLZ89TazQkLS
	h0UwR2sbKiRYDiVlYUvfNadh4tE5JqVFsgxvmXt0wrrL9V09LxrhwbFHa9Tllb07aPxfD44Icii
	YMc1vv017/uK5zbc4/l7HZXBL93J7xgbk7N7v638DskmJ+2UI5vw==
X-Received: by 2002:a05:6a00:ae0f:b0:823:652:d2a8 with SMTP id d2e1a72fcca58-824b2e3586bmr2213510b3a.5.1770918794999;
        Thu, 12 Feb 2026 09:53:14 -0800 (PST)
X-Received: by 2002:a05:6a00:ae0f:b0:823:652:d2a8 with SMTP id d2e1a72fcca58-824b2e3586bmr2213489b3a.5.1770918794408;
        Thu, 12 Feb 2026 09:53:14 -0800 (PST)
Received: from [10.50.42.130] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8249e82fd32sm5514804b3a.53.2026.02.12.09.53.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 09:53:14 -0800 (PST)
Message-ID: <1012eecc-3bfd-4c81-949a-9db8a1b31777@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 23:23:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 1/2] wifi: UHR: define DPS/DBE/P-EDCA
 elements and fix size parsing
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260212172401.234059-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <20260212172401.234059-2-karthikeyan.kathirvel@oss.qualcomm.com>
 <7ac00be5cfa6a31b91d72db027030b89195f25a2.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <7ac00be5cfa6a31b91d72db027030b89195f25a2.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEzOCBTYWx0ZWRfX9SVFbiBv2QkK
 HJ7OocoBtTYCyLYVOHYBVeNFD4KYiDwHWth5tjNdPIdbEYrF222as93EvEQ+4Gitm6LDJ5lLmdA
 qyceXh2uqYO7kx5w3xF2itv4bl642cqfta+6DMvmNWEYma+8PUF6wvvTLEXgqY9LtzjWZMzeHTe
 PTVYUq9HrGC9czuQ+qQT62hpoZNFachAh1PULw7cqz0zU7JMsiZrnsuEAVeWvpMP8Or6M71hj05
 usjlLhMjMypU4Vfn9xbwgpaUEqe9G3JD5qD/pCz90suvWByqdbSU9SDKGLwZrJlGgp0pqxLmvxt
 LY7CtRwMtAbTJOXvh+UwBBvUDTi0N07JAaAmb48YSPELKMAUi5nIBl57PgY9zynHHAn2ZPQED5r
 v7wfTbvRgfsg0XMj+bTNMuLxT2bdGiFnHosogAQbO7CIiX7tYs5X8Dt1j+ow8TCJWHhUd2DAOjC
 Rol8B6+8EXUv9S2w8gQ==
X-Proofpoint-ORIG-GUID: Tmrp8Xk9Q9cqPTz4gOQc8wtAEenw_c8Z
X-Authority-Analysis: v=2.4 cv=dLCrWeZb c=1 sm=1 tr=0 ts=698e138b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Ug5BrCXmp09cZfeqHW0A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: Tmrp8Xk9Q9cqPTz4gOQc8wtAEenw_c8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120138
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31785-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 543C7130159
X-Rspamd-Action: no action



On 2/12/2026 11:04 PM, Johannes Berg wrote:
> Hi,
> 
> Nice, thanks for sending this.
> 
>> + * subclause 9.4.1.87. Refer Figure 9-207u.
> 
>> + * Please refer IEEE80211_UHR_DPS*
> 
> "refer to"? Or "See Figure ..."?
> 

I will use "See Figure" and "Refer to IEEE80211_UHR_DPS*"

>> +#define IEEE80211_UHR_DPS_PADDING_DELAY			0x0000003F
>> +#define IEEE80211_UHR_DPS_RESERVED1			0x000000C0
>> +#define IEEE80211_UHR_DPS_TRANSITION_DELAY		0x00003F00
>> +#define IEEE80211_UHR_DPS_RESERVED2			0x0000C000
>> +#define IEEE80211_UHR_DPS_ICF_REQUIRED			0x00010000
>> +#define IEEE80211_UHR_DPS_PARAMETERIZED_FLAG		0x00020000
>> +#define IEEE80211_UHR_DPS_LC_MODE_BW			0x001C0000
>> +#define IEEE80211_UHR_DPS_LC_MODE_NSS			0x01E00000
>> +#define IEEE80211_UHR_DPS_LC_MODE_MCS			0x1E000000
>> +#define IEEE80211_UHR_DPS_MOBILE_AP_DPS_STATIC_HCM	0x20000000
>> +#define IEEE80211_UHR_DPS_RESERVED3			0xC0000000
> 
> Not sure I'd defined the ..._RESERVED* ones at all? There's no way we'd
> ever use them really unless they get defined to something else.
> 

Sure will remove those

>> + * subclause 9.4.1.87. Refer Figure 9-207u.
>> + *
>> + * Please refer IEEE80211_UHR_DPS*
> 
> Also here as well.
> 

Will take care

>> +#define IEEE80211_UHR_DBE_OPER_BANDWIDTH			0x07
>> +#define IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES	0x08
>> +#define IEEE80211_UHR_DBE_OPER_RESERVED				0xF0
> 
> same comment about reserved
>

Will take care

>> +#define IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP		0xFFFF
> 
> And this ... I think should just not be there? When would we ever mask a
> 16 bit value with an all 16 bits mask?
> 

Oops!!! Agree, will remove it

>> +#define IEEE80211_UHR_P_EDCA_RESERVED		0x7800
>> +/**
> 
> reserved again, don't think it makes sense - and probably should have a
> blank line before the /**
> 

Sure, will modify and remove it

>>   static inline const struct ieee80211_uhr_npca_info *
>>   ieee80211_uhr_npca_info(const struct ieee80211_uhr_operation *oper)
>>   {
>> +	const u8 *pos;
>> +
>>   	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)))
>>   		return NULL;
>>   
>> -	/* FIXME: DPS */
>> +	pos = oper->variable;
> 
> I'd probably have directly put 'const u8 *pos = oper->variable;', but
> doesn't really matter.
> 
Will initialize during declaration in next version
> johannes

/KK

