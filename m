Return-Path: <linux-wireless+bounces-32384-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALz4Ceyzpmk7TAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32384-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 11:11:56 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 951D01EC715
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 11:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 629D53024477
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 10:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71E3382367;
	Tue,  3 Mar 2026 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dJ8SRry4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KgImgAt+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C963CB
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532713; cv=none; b=EQWI/7/R+DmSKZK3tQZIuTU4b004SgGBH1FUqmPXr/z2Aq20NvRs/nnljK581pboNzMtBvDg9JAfXsKExgeMVSOnbdl9C9Rl4xzosj0lsTf1jnXWtx+saqc1Mqz45ZP619znZ0nzrxfltQPecD8pEsKK+Nhctk3diLnAYk98Tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532713; c=relaxed/simple;
	bh=HrwWkz70n4fw9DEjn8mYhUmyx9xGvWHmdBhu20u6krA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWZrBi512whotIxk7Cwjb0E9/Sp6xy/JMyMYgj2TKzq0aW3UiBBsifTAR5wKiNS7qeH2z7rhi70/fRplZjogKraEP32OL10vBRpvDzrb+XPkMvcbbf1zNuR9YO3DnsSz/ivS03zsr9zQXmD565ps5W6TqOww0X800zNVlyLhNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dJ8SRry4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KgImgAt+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239n2r92775551
	for <linux-wireless@vger.kernel.org>; Tue, 3 Mar 2026 10:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YzHJOcx4tkvTcrLPF6I8Mk3LI9l+AOpi3RUhN+dWY8s=; b=dJ8SRry4JF4tFjlp
	OppGf6M4utFnIx9Q7RGwQP8eUAYIWpJ0RMq3sPA7zjn7ng3BmK156XX6vfGdwsO8
	xFOLgwaJB1nVgRRYiH4jVXkZiyezCnK5fdRqBrN3qki/bHvO8nT05Mf/69QvVyac
	y/bFkqRGLMnwrU36KSGLwxCB+N3AzZH+aAVjfDlLejDT/NzF6VyEwxCzHNMj43UO
	7HtYnYY7peKWJsZiMZvubJFH/A5u8jGnDuRaidstPDPY6ZTyONds0voIIElTYzPw
	lDxZdxZ4lSsq2TfF4Ruwq8qfGMlLmtE+s399CkWVFuE2ichcVpHX7KDR+NfX/WDl
	V+17FA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnsjm106t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 10:11:51 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae49120e74so21872905ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 02:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772532711; x=1773137511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzHJOcx4tkvTcrLPF6I8Mk3LI9l+AOpi3RUhN+dWY8s=;
        b=KgImgAt+yuphwrg4sF5PuTkSj2WKFyQK7o8yI+oi6ZftuoMzLTiRBi2C4oXulBylYq
         j7l/bZ4Ufps6fZNPnXc02jES2DBCZm9PEpIHn8lZdWFDnDvVB6Y0UR2tU7d10vS0wTBn
         T56sOfNhtRnFQHLLsw+npFNpU7q57Up+TN1KULTABPbOHJ8j3OrsloIuvithQakbPyBI
         CMLANg+vugtPpKDJbVRn6Estw9oGSnDhjvMljvpWok4kMiTF/s23FgxVYeYg/iKagDMe
         y2tf16Q0dszJf3M7VseBc+ZkUOZBP3Olbq0b5U6zk4HYrsZw/EqAtdCn6fQSX/ErJSMP
         A0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532711; x=1773137511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzHJOcx4tkvTcrLPF6I8Mk3LI9l+AOpi3RUhN+dWY8s=;
        b=FJf6rR4e7ECGqpq2RSvZrGNY0QfqL5yvSZIIDJru+9Zi+vGKh4BP/h/yvsh496gnOP
         doX9Woxky22nVbAN6FNwGb8dkgQIWsx4dg4vuxHAgTwEbAn3mbYsrwkdGxHgR1YsCoeU
         VMYxI/yL1B1vjFVn24rIqVTg6OvfBk2cVWSVhkRm6aTustTcacRdOM54An0GqQdQtqbh
         aSZwYrxTam7W+VG5ORv5gSjDdxcjBNZNC0woMRj0E738g4zlO5OvetAJeQUSwduCGKI7
         hcBqJBKnwsSyKXqbxqHf+Pnhrei3FNAaa1Ib65KYhXigL1vrT95wUrbmNlpqlgiNB2au
         ZViQ==
X-Gm-Message-State: AOJu0Yx1q0IZRZpdyVRtHaNUARWDIenWfFXreeF7zr/hm0QAEhIIpqaL
	Wm89F4HEsZ7SQK/mcwFz0ErNlb3X/X8mPBuyzwAaPHerw+p4hL6VQe2nYRPlm1tldsvkMBpTB6S
	5fdukhu+n3/qxb4C6GIKHACeRLuq2UtYry9nvZqoUo41VWwpqoWAWUGqXrTG5QtgNMkcyBb9xsZ
	5oow==
X-Gm-Gg: ATEYQzxFMSdMzrCd9v7uJxXwm3YGG2M9eSnhh2nV7WyMSs1eue6ptqd9uTvLO2d4C+4
	n5cgZ5jwjtMfXY7Hp7jush3yivswTgMh6Mw6MSQtTQDZdxcMPOq2963b6mxm89Rgrf7pLGUrBKp
	SYYeSp02Yy3NMFmmE7Dnv7+9S8q98AObNY3tLx9dxupK0HhWWNzYAf+4glOlAcTtEjXmrqHxMxz
	1eRCCLH3XkAmOMqJN/QrBebBmkpTPp9ct9qBK6OPg2Cksxf3pIfNXZsicdAb9ih9IEydtOEjHmw
	VTTZ8IiEfT+ZaGrKmmEo6n4F8wgpPjfYWgngiZye7bVp2ZhL/YiY48mrRSgGqoR1BHr/xfBF8AH
	loA/eplEPvl2nXcdsCcBKJE+oHPVbduiqVL6sarQCUd5TuKayVOsPEUjbgHu2i34=
X-Received: by 2002:a05:6a21:44c8:b0:395:7fb:9352 with SMTP id adf61e73a8af0-395c39e0f72mr15276753637.15.1772532710719;
        Tue, 03 Mar 2026 02:11:50 -0800 (PST)
X-Received: by 2002:a05:6a21:44c8:b0:395:7fb:9352 with SMTP id adf61e73a8af0-395c39e0f72mr15276728637.15.1772532710255;
        Tue, 03 Mar 2026 02:11:50 -0800 (PST)
Received: from [10.152.199.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4d93dsm15372721b3a.3.2026.03.03.02.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 02:11:49 -0800 (PST)
Message-ID: <2b64bdd1-0bf9-44c7-845b-4c07cefb708c@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 15:41:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 1/2] wifi: UHR: define DPS/DBE/P-EDCA
 elements and fix size parsing
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260217054731.3667600-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <20260217054731.3667600-2-karthikeyan.kathirvel@oss.qualcomm.com>
 <6cec588857a8fa5866b3aff323c367b0096e613a.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <6cec588857a8fa5866b3aff323c367b0096e613a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zTQYJT1EOWfmYbzIZd_fyzN3x9GqtNBJ
X-Authority-Analysis: v=2.4 cv=GIUF0+NK c=1 sm=1 tr=0 ts=69a6b3e7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=7-Pj4gzqvCTXqnPNP3YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: zTQYJT1EOWfmYbzIZd_fyzN3x9GqtNBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NyBTYWx0ZWRfX0m8ifFojVlzf
 BiNSazveX6FEBYDuyoVgcOyZqgLLpKhOGIXzU6mNHKvYvllHt04qmaBK2WYfI31d8xzk0sXXmne
 ljXLo8fhp+7RWhT9sp7T/oJnlvr91IB7n52ZZemJsj47wylBaE5UTzULE8qgKmv5IRei9xVPL8u
 v1V6UhpZX9izPP8h4aY8TQ9Up2LiFJZmn1ISF5AJw6lD6FX6DWGixV507mIijwLVsXwOVaWURxl
 ZRStq9fvE/4IZ3OpcVsHT+IGKlUVdHZXEBFo0jAmSNyR/LJYbzn0s3Omg4dQTeo5muZU9S5BVIR
 1V0M6rkOeAYkvJOW60gmQgDyMt/y0NvrE3+tbcx6VWOplnrK+TI76ONkHZijF85ckJiS/nzp1IQ
 tM+N1qM/0xOSYPv48eyYywDB+e5dLB9oLJEv/uUGzTOLe3J4Iiq1zkWvvaFph2T07cgKGSpaUOc
 +1uhVxivb1gFodIXZGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030077
X-Rspamd-Queue-Id: 951D01EC715
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
	TAGGED_FROM(0.00)[bounces-32384-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2/24/2026 10:02 PM, Johannes Berg wrote:
> On Tue, 2026-02-17 at 11:17 +0530, Karthikeyan Kathirvel wrote:
>>
>> + * Refer to IEEE80211_UHR_P_EDCA*
>> + * @p_edca_ec: The P-EDCA ECWmin, P-EDCA and ECWmax
> 
> that seems unclear?
> 
> 
>> + * @p_edca_params: The AIFSN field indicate the AIFSN value that are
> 
> "indicates", "value that is used"? I think it's one? Or "values that are
> used"
> 
>> + *	used by a P-EDCA STA during P-EDCA contention.
>> + *	The CW DS field indicate the value used
> 
> indicates
> 
>> + *	for the randomization of the transmission slot of the DS-CTS
>> + *	frame. The value 3 is reserved. The value 0 indicate that
> 
> indicates
> 

Will address this grammatical errors in next version

>> + *	randomization not enabled.
>> + *	The P-EDCA PSRC threshold field indicates the maximum number
>> + *	of allowed consecutive DS-CTS transmissions. The value 0 and
>> + *	values greater than 4 are reserved
>> + *	The P-EDCA QSRC threshold field indicates the value of the
>> + *	QSRC[AC_VO] counter to be allowed to start P-EDCA contention.
>> + *	The value 0 is reserved.
>> + */
>> +struct ieee80211_uhr_p_edca_info {
>> +	u8 p_edca_ec;
>> +	__le16 p_edca_params;
>> +} __packed;
>> +
>>   static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
>>   					      bool beacon)
>>   {
>> @@ -47,19 +232,52 @@ static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
>>   	if (beacon)
>>   		return true;
>>   
>> -	/* FIXME: DPS, DBE, P-EDCA (consider order, also relative to NPCA) */
>> +	/* DPS Operation Parameters (fixed 4 bytes) */
>> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DPS_ENA)) {
>> +		needed += sizeof(struct ieee80211_uhr_dps_info);
>> +		if (len < needed)
>> +			return false;
>> +	}
>>   
>> +	/* NPCA Operation Parameters (fixed 4 bytes + optional 2 bytes) */
>>   	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)) {
>>   		const struct ieee80211_uhr_npca_info *npca =
>> -			(const void *)oper->variable;
>> +			(const void *)(data + needed);
>>   
>>   		needed += sizeof(*npca);
>> -
>>   		if (len < needed)
>>   			return false;
>>   
>> -		if (npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES))
>> +		if (npca->params &
>> +		    cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES)) {
>>   			needed += sizeof(npca->dis_subch_bmap[0]);
>> +			if (len < needed)
>> +				return false;
>> +		}
>> +	}
>> +
>> +	/* P-EDCA Operation Parameters (fixed 3 bytes) */
>> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_PEDCA_ENA)) {
>> +		needed += sizeof(struct ieee80211_uhr_p_edca_info);
>> +		if (len < needed)
>> +			return false;
>> +	}
>> +
>> +	/* DBE Operation Parameters (fixed 1 byte + optional 2 bytes) */
>> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DBE_ENA)) {
>> +		const struct ieee80211_uhr_dbe_info *dbe =
>> +			(const void *)(data + needed);
>> +
>> +		needed += sizeof(*dbe);
>> +		if (len < needed)
>> +			return false;
>> +
>> +		if (dbe->dbe_params &
>> +		    IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES) {
>> +			needed += sizeof(dbe->dis_subch_bmap[0]);
>> +			if (len < needed)
>> +				return false;
>> +		}
>>   	}
>>   
>>   	return len >= needed;
>> @@ -72,12 +290,15 @@ static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
>>   static inline const struct ieee80211_uhr_npca_info *
>>   ieee80211_uhr_npca_info(const struct ieee80211_uhr_operation *oper)
>>   {
>> +	const u8 *pos = oper->variable;
>> +
>>   	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)))
>>   		return NULL;
>>   
>> -	/* FIXME: DPS */
>> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DPS_ENA))
>> +		pos += sizeof(struct ieee80211_uhr_dps_info);
>>   
>> -	return (const void *)oper->variable;
>> +	return (const void *)pos;
>>   }
>>   
>>   static inline const __le16 *
>> @@ -131,6 +352,25 @@ ieee80211_uhr_npca_dis_subch_bitmap(const struct ieee80211_uhr_operation *oper)
>>   #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES	0x08
>>   #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES	0x10
>>   
>> +/**
>> + * enum ieee80211_dbe_bandwidth - DBE Bandwidth
>> + *
>> + * As per spec P802.11bn_D1.3 "Table 9-bb5—Encoding of the DBE Maximum
>> + * Supported Bandwidth field"
>> + *
>> + * @IEEE80211_DBE_BANDWIDTH_40MHZ: Indicate 40 MHz DBE bandwidth
>> + * @IEEE80211_DBE_BANDWIDTH_80MHZ: Indicate 80 MHz DBE bandwidth
>> + * @IEEE80211_DBE_BANDWIDTH_160MHZ: Indicate 160 MHz DBE bandwidth
>> + * @IEEE80211_DBE_BANDWIDTH_320MHZ: Indicate 320 MHz DBE bandwidth
>> + *
>> + */
>> +enum ieee80211_dbe_bandwidth {
>> +	IEEE80211_DBE_BANDWIDTH_40MHZ = 1,
>> +	IEEE80211_DBE_BANDWIDTH_80MHZ = 2,
>> +	IEEE80211_DBE_BANDWIDTH_160MHZ = 3,
>> +	IEEE80211_DBE_BANDWIDTH_320MHZ = 4,
>> +};
>> +
>>   struct ieee80211_uhr_cap_mac {
>>   	u8 mac_cap[5];
>>   } __packed;


