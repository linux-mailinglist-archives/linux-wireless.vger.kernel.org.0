Return-Path: <linux-wireless+bounces-32385-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4POmDIq0pmk7TAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32385-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 11:14:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 851CE1EC83E
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 11:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E8530CD594
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 10:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FC7395261;
	Tue,  3 Mar 2026 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DxxDk4Ih";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CCDwVs3T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FE763CB
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532717; cv=none; b=nRSAvRX1gtEg8XO4MrrRKSKMxvPQCGD/bbXUsfVcjoww9db9G3usIFUPu0dum92vlUJf8Aob0cs2zs4ll8cT0GteFpkuhgT2w+/UleyrIgGDBTGptEAocNVqEYxOyWRoIF+mABjMQQphaDKlefk4pAgOU3qqyU++wmobbx/w3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532717; c=relaxed/simple;
	bh=gYai30Q8lf5JgZJe5yqL2lNOFL6fBbv+o+Zgn6w6TyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3SrtkoddZ6Kwm0d081jSe6FRyWa9OP7iVaXfzITJ39XlDiBJ+Waj1e+BqMmVi/ET1vwvddDDARSxoa+V5tRkspkQOdHa1YKfqm8wnUGCXDXGbDj4DewcFEG99sfs9tW9Iz8tlYqqBtVEWwqx3H+fPQ2VfrfdzophrgLyTd+XPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DxxDk4Ih; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CCDwVs3T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6239nGgH3349578
	for <linux-wireless@vger.kernel.org>; Tue, 3 Mar 2026 10:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hcvmD29bQdL3AHE+sXiV2TXNwct4RnmCX84SiYx0Q+A=; b=DxxDk4IhZOMCcXUR
	bNlN+3dp0Ug7N+fM/0LxpwVa4FZ1pOyHAfSGq+SENk+V6bJJu+kXuMQ3C/bfALyG
	wnnXcWs3gyjT6i3hqGWpFUbBpOEyfy3aMi9yaY1qvLrMgQs6k4xpRvrIpMdyFiOI
	dJQxi5dTLrax6/e0xhBeRwkbAUmI3ykWnjb6d3bVpg6saX8cOm1tMeTNADqleocf
	Bocriuuumi34XuRlpgTpzJMx6RDblimyruXFbUNS+hHADZjywrP7tJjeL7iHKKrc
	YIpgEUovzXbRo/04uuZnn+YpP6jy3y6m5XboLb+XUUqWvuOsENZz4jRGpdsP5aIP
	sAY4wQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnhxsabrh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 10:11:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aae0d40a47so345375625ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 02:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772532713; x=1773137513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hcvmD29bQdL3AHE+sXiV2TXNwct4RnmCX84SiYx0Q+A=;
        b=CCDwVs3TmAFFQK6cx/k3+ZPfM2TWaeASdWlM2TAbR/K8Vn9mhxPpRR6Uu1DQ75ifSD
         35GHL4T/7HVggCOPlziIIHUnowevBG4sz84RuXFsxMKwp+lUzyUtMBeKClgtHoN0P3bh
         UesZZdonFH0Q7c0zCS+lz5jJWSY7jhXCg6LJG4CvGr1pn7BhzyVdvkxe4YvwSGTJSJCR
         /gNYvJOEzTE5f2oyrUiWdhY/7Uhu5EIUveygOk6jHyyX2CFC+ZThy10luuBtEbPYqhRV
         KgHGuFU/vxqn2+v89Ipqy3aluKjKbVd4YRIzP15wtJdod1Uobo9SIzH/xiPT9K1KBhOB
         j6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772532713; x=1773137513;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hcvmD29bQdL3AHE+sXiV2TXNwct4RnmCX84SiYx0Q+A=;
        b=YH0+P7dl/wFErw+jRZevIxds90XFCN9pVhCiFivh2tJAE767uzGgKY5StzjCxc1+Cp
         lccCFp8p4lnGrZLs1HJ/KunCqYrUGOORxJCfy7yCjmHhcFLpefY+YWkTW41tIvg6xUM4
         53uJnEPYcesgS7tf56ABpVkzTXvTNvQMBlxZkqEdLTZpy5Ko9/SMazyJO2EDkwpfqueT
         Z7PQXqUnXGFFXG3xMo81sgYrOryL4C9MWEe2D5/wg/9HFaES390OyAs575A0DMMOTJ/R
         F6w8jY8O1Fy9vY+oth004oLIx3VLW8Iw7nVrPLRD4QmaQrlKhiscXINHwAAtgcutBJ/R
         fz5A==
X-Gm-Message-State: AOJu0YyCsTs0t3G0Kr5/9BoHzEkelOynzMV6uhLVRRTwEbPhcVg/fy3B
	RtokhJNfowplAyuvSD7YNwHlhUrAvFQx6UWk+Zzc+yyO1jaWILdZ/i/YwDH1IldwdXBQZMrAOOw
	2VWZg+34WeLfNpmyf6BNXztKl7gNnYA/ZFcTC8dPZ3cmpjNGovL+QiZnbCrmNvBNvywsCANg6hc
	h5JA==
X-Gm-Gg: ATEYQzzD7U9/s5SAnl6aEhtKQ+xZsPoJILtLKGpCDbG3C6l6yflBdKcy1c4YxHZvxcJ
	vKQMGETcmaalSAsw788l8DOikgxDO5gQvznGXXknGW0D7Hpv3Wv0OKFIdgqdZIXbgQjFc9avFmM
	oztU2E580qSuHa5j/9LTIBPyEVICmtPioLcvIxpC3s+aPS2R/viPjkfNYN/i1gZD0pgkj89yrnb
	JSY2znz94Q8MA7uo5TXrzeg9+HVqCUMCKbnGy25TY0wroDi+ibaMyrH2y7SdA+izAqMNpXBYIuE
	Am5dt+IVWKbx0sq7XApbDd1uZe4vfpMo1wpgmTUYaN3175JhkbQnxZXXWDZmcEex5YPHzLdYI6r
	3VvbYNrMH1WD/PxCtsUbZfcALVgEyDUONTniW0EqBWU1DBLVWsASXdvmUfE3LM5k=
X-Received: by 2002:a17:902:d508:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2ae2e4d0a96mr176767815ad.50.1772532713405;
        Tue, 03 Mar 2026 02:11:53 -0800 (PST)
X-Received: by 2002:a17:902:d508:b0:2a0:d33d:a8f0 with SMTP id d9443c01a7336-2ae2e4d0a96mr176767545ad.50.1772532712883;
        Tue, 03 Mar 2026 02:11:52 -0800 (PST)
Received: from [10.152.199.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4d93dsm15372721b3a.3.2026.03.03.02.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 02:11:52 -0800 (PST)
Message-ID: <c8af5ae3-f754-465b-a897-48b0c99367f7@oss.qualcomm.com>
Date: Tue, 3 Mar 2026 15:41:50 +0530
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
 <c71a84fe19a632ccd748d0f1fded1a8b1277e0b1.camel@sipsolutions.net>
 <b2b284785c462961f4801e783e1421c0c9bba398.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <b2b284785c462961f4801e783e1421c0c9bba398.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: M3NLIpSJtO2y7aMrOf2zKMglXsG9BxV0
X-Authority-Analysis: v=2.4 cv=dfmNHHXe c=1 sm=1 tr=0 ts=69a6b3ea cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=UspniTRYGAPcDlIwxWEA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: M3NLIpSJtO2y7aMrOf2zKMglXsG9BxV0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NyBTYWx0ZWRfX/iC4fOEuS+Ur
 29s6df3LByhmNeMRJzRZDgIvaDl0BOc2rnELL/zASJ1V91Ac6P3pdz+kgrUNNDLcDphSCMVZary
 Pl3luA6CkxrIYBSaAgpXZzI47jszFWzEuIiZPzbTsd8uKWQKu2GSNzlueaWMW5Z2K8bVjrWAgLB
 wKiH/rQ28nMd8CrdsNXYhdzt0bXelXQth6K1tO6g7lFAsjbN7x+rFi0BXuJCzB9DPlQbvfAR9Ae
 IWVz6NWJbKHthtdhKTAJFP4mxy1WcAXo5vpK1OuocIe84r18jr9RjOAwUrdagcr6bTCSs2LB6LE
 xP4JURDuGCQiOJwAhdLo0urRDc/JvOwJXpspUy8tCrp/cV/vhgWG5wNnmPv9L0p9cH/I3C/51hr
 HfFwSve+lMKWJC7+65rUcIVP0cX/HJwAEu4jf0lSK2wr/mShgv2wJRXi6d7Fe2h0Rzo2FQKalgh
 7B7G2eSA0c42nN9+gaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030077
X-Rspamd-Queue-Id: 851CE1EC83E
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
	TAGGED_FROM(0.00)[bounces-32385-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2/24/2026 11:08 PM, Johannes Berg wrote:
> On Tue, 2026-02-24 at 17:42 +0100, Johannes Berg wrote:
>> Oh, another thing
>>
>>> + * @dbe_params:
>>> + *	B0-B2 - DBE Bandwidth field is set to indicate
>>> + *	expanded bandwidth for DBE mode
>>> + *	Value 0 is reserved.
>>> + *	Set to 1 to indicate 40 MHz DBE bandwidth.
>>> + *	Set to 2 to indicate 80 MHz DBE bandwidth.
>>> + *	Set to 3 to indicate 160 MHz DBE bandwidth.
>>> + *	Set to 4 to indicate 320-1 MHz DBE bandwidth.
>>> + *	Set to 5 to indicate 320-2 MHz DBE bandwidth.
>>> + *	Values 6 to 7 are reserved.
>>> + *	B3 - DBE Disabled Subchannel Bitmap Present.
>>
>> Seems we should have an enum for the possible bandwidth values?
> 
> How about this?
> 
> enum ieee80211_uhr_dbe_oper_bw {
>          IEEE80211_UHR_DBE_OPER_BW_40    = 1,
>          IEEE80211_UHR_DBE_OPER_BW_80    = 2,
>          IEEE80211_UHR_DBE_OPER_BW_160   = 3,
>          IEEE80211_UHR_DBE_OPER_BW_320_1 = 4,
>          IEEE80211_UHR_DBE_OPER_BW_32_2  = 5,
> };
> 
> 
> johannes

Sure will add like this.

