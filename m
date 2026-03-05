Return-Path: <linux-wireless+bounces-32546-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHsKOISkqWl5BQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32546-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:43:00 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 845B8214BB5
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 652F73080B95
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860D3A1D07;
	Thu,  5 Mar 2026 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hYva46JL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W9lzSaTb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC86739FCC6
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725095; cv=none; b=tYmxWhOvUCnk1NXE97LKUUjdGeeoimS6jPMXKzvW9U7gAJ/HQ/xcCD7YprJt2nn1xaTBcs8mxv6eayxaMwzyXqpFYVHlgX6sYmlszNDQX7RxCRCFIIv6lRIpR5K+9i0RAPm7A3Nc9QixnEYwPo5lHs7/6vD8/+upp5v2AYT6+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725095; c=relaxed/simple;
	bh=9Fwt+qNQ+eI6/bMuVQ02kr244b2IAviNz2CNyZ4HzjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTO94RT4Mkprnukyy3a7kYzFLXmP5aqxOdsDxEIjyDZhGM7STsXiCAshO+2lGWOiop2WYH5lMD7VeHpGAJXeHEBi/cXCucv06phHN7Y8tkLhvEMNT7UnofCNSksH2/pW5aIKCveNvCI+B9DTEg1yCs0UZMEqHWM8rrWrgZiR3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hYva46JL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W9lzSaTb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AVvUW2401203
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 15:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pNH93bOUS5JmZTGLel50rW+9Ens1zHMV+TWK8/Af8n0=; b=hYva46JLmvz0p8Pr
	eE5t5d7WPRFcsJG07Rx0DvCbeKCofl6rQirprKYLosZVDzOkGs2GYFGo+TseRBEk
	Uj3oksIL6ODt3e1V02L3HvpPw4a47tOu9ZcFUEhqj2TTyvnzkolV+lfXbKKjNjoW
	bcYA69bNUj5Sc8B78HSoLyxTuazQ6VHb2ex3hXdASAYUsmHPAgpyCILoXQ6IvPOF
	UP2/vRSNm3DsRhFOtgPfnIzBxHUfkHoevItUcfANO4B1YvLbk9Rp6hSCKab+5tzr
	RCpymgtK5DEr1td82vDIEDcHT5yFK+FCGRHcwYSTx6E/ehV7kQcBGAy7nIxWUlaN
	nUAN2A==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq85dgwrb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 15:38:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8298b363fb6so1260481b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 07:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772725092; x=1773329892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNH93bOUS5JmZTGLel50rW+9Ens1zHMV+TWK8/Af8n0=;
        b=W9lzSaTbGqii2HaFumoTKO1pSDeMP1V8Ma8CUuNP2QHUu+4/ychx1Dd3gda+Jxpf3m
         5Ory3B5B/+lf3S+TAls7UW5nelbI7mz/J8Vpqg7Um6iW7V2UCWmcGhMlRQzc0kMVi9Am
         N3K5oCgJBIROeW3lBRDLYe8uIOgLU6yUum4yHnKDGuZ2M5FWU5ySp0w++eNGx45phLT4
         i07ffB6NwGO58+eIThs07IbaMps9hUNJ6RYHw0gXZChY/a8hSDIozn6aE2pxwQ0GV7c/
         1zGzOowpDSbodZ1M6zBPTAELkmt3UQlURLjPKPC1sFCIpf9BND+f/CcUzSqFpUP3eFuM
         T/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772725092; x=1773329892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNH93bOUS5JmZTGLel50rW+9Ens1zHMV+TWK8/Af8n0=;
        b=bmm7EKnefxIH5FB5uEeS6x1BFL+j5VtlYuhvjlJ4iHdlU0FniN+EfoLCn2YOwnH1CJ
         kjmXe3TR7i7ITJXX0C4eB9n3UDcMj9/VOBocJx6kLzvV83yIgibegVGI35xkDuVUbefF
         QsPQEu6WJqJzqTLlvtDhheDHO0EWQK2r7fZSI3VVerZ2qKAFmZMtco13x4EuiiHwEcjS
         xT3cZ6mT5SXsbqFhByTiDdpkQCrN1+WB0UQcuh70MpnMDbLDZQTVLb0m988dtALVSKR9
         lNk6WLVoxq2bXBapttBRNaMBZYOLNLpppHVVUvSlkqeGRUtWq2hgSTTMVSlHJWwWYBHq
         2YtA==
X-Gm-Message-State: AOJu0Yw81fQH0ml/5qqZhCmZxHOhMW4GK1tjV+cAnd6d7GEbYILliIri
	kgnGJc9jitC8/kxdquzZO92Nh7MhTBXfQIYYNCIpqRMEHm6ZfGmn+6WoqHq0Gry8xiOYo1AcwIb
	s58tYE3ofSSpwTx7g+U3RzQxoTdSoM9pesoGE5eABjCIhbx0WrIpx6xFmRoYtvPTMbQZS
X-Gm-Gg: ATEYQzzzO3t1vpElJyUDdnvoCkTqR39xIS/stAIEcOc+Mf8TOvpoirq6ASKGp8rsK3D
	jBpSi6K1mIjaSiWIxuFt7EWqnAviidLDj6ht1k94z65Zvm9Ykd9zHOLDBBMJqACtUXx2aggGm5x
	R0JK/+8aeTWi2GPD3SNsDT/0aIauYZTskcR5KX5Kn5cYHVgt1+enDrBLCK9jION/yvH9cvyUfw6
	DKCZ0/dyrHg9cXnnKB1Vc8pQO0V6M4LKw2d1iO6kWeTPjtTatxrlTnBfKxAIltQRL/e2i4/PSJ3
	KiEBNJzzpHM6oyVZa0RQAF/8GhSHUFXjEfQHQhCnFu2UrijMfOf0xso0rqqhFImnha4eN8NfwCs
	x2koEaGuQxTSYXvhGJsJ/5lbmhtfNYXQ/gBMQ/RHOvGwCLaaW7SsA
X-Received: by 2002:a05:6a00:ab86:b0:81f:4769:6fec with SMTP id d2e1a72fcca58-82972b42ae9mr5528354b3a.21.1772725092363;
        Thu, 05 Mar 2026 07:38:12 -0800 (PST)
X-Received: by 2002:a05:6a00:ab86:b0:81f:4769:6fec with SMTP id d2e1a72fcca58-82972b42ae9mr5528332b3a.21.1772725091829;
        Thu, 05 Mar 2026 07:38:11 -0800 (PST)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82984a01827sm2883920b3a.43.2026.03.05.07.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 07:38:11 -0800 (PST)
Message-ID: <7c37950f-5059-45d1-b244-4132dfece297@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 21:08:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 07/16] wifi: cfg80211: add continuous
 ranging and PD request support
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
 <20260304071538.3833062-8-peddolla.reddy@oss.qualcomm.com>
 <e01d16bd2f890355a1edb545b4b5ab2fee265bfc.camel@sipsolutions.net>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <e01d16bd2f890355a1edb545b4b5ab2fee265bfc.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BnDApwDb7hJFs3S3NnrWgnSFvJyE48nN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyNSBTYWx0ZWRfX1bJpGUhXz+U9
 Mmu6xVaFh23Wg6UGAKjeQ9qsD9prVCq2J/Wd3UQK+qboFamZqQyJTSJ2TJUVygzgpBY0yeYYpGQ
 KbRZXQaxvjWjKYo2yOfuP/qaM7YTYcZPy2V05x20gVlEIMB2h4R9AYvQ7862yBbW9IKQ7qob0Mc
 8dFQssxqqQa8uoNfPvq00X7VWroEsD7SgOMgEP24OPd86Sph9LE/MM9kON7m5A10gqfpEkzDRMV
 H6OBf7sWfcyyn5CWM7Or6eEnsflrki3QJPihFyNv3ONnK7KfVK3mnZl6ljAupTiuqSD+9or0Q0l
 iWqPP8F5MT4ynpa1B9POqFFNU7PksgZd06GNBjDGAwRkJJKl5EWufOTQf0VIxk/riuckcsxlpEf
 DqMZsQc13MuRdlpisRBOHySxPjVg7r86r2ycTkl1yirVDQ8tlaPusVFpClsIoclFxaY9/pfwgre
 fq4OcfYDNsm+eTL69ng==
X-Authority-Analysis: v=2.4 cv=aOb9aL9m c=1 sm=1 tr=0 ts=69a9a365 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gIzyHdiTevXcD4jfWAUA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: BnDApwDb7hJFs3S3NnrWgnSFvJyE48nN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603050125
X-Rspamd-Queue-Id: 845B8214BB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32546-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 04-Mar-26 5:22 PM, Johannes Berg wrote:
> On Wed, 2026-03-04 at 12:45 +0530, Peddolla Harshavardhan Reddy wrote:
>> +++ b/net/wireless/pmsr.c
>> @@ -91,11 +91,10 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
>>  			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]);
>>  
>>  	if (capa->ftm.max_ftms_per_burst &&
>> -	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
>> -	     out->ftm.ftms_per_burst == 0)) {
>> +	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst)) {
>>  		NL_SET_ERR_MSG_ATTR(info->extack,
>>  				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
>> -				    "FTM: FTMs per burst must be set lower than the device limit but non-zero");
>> +				    "FTM: FTMs per burst must be set lower than the device limit");
>>  		return -EINVAL;
>>  	}
> I really don't know anything about this protocol, but this also isn't
> described in the commit message, and zero seems odd?
>
> Maybe it should be allowed only under some additional conditions,
> otherwise you're potentially changing some check that existing
> drivers/devices rely on?
>
> johannes

Sure, will address this in the next version. Thanks.


