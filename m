Return-Path: <linux-wireless+bounces-23685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69483ACDA69
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 11:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D951883C15
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 09:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEAC18C03F;
	Wed,  4 Jun 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zu6DSFLZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688D28B7DB
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 09:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027609; cv=none; b=e8riOc5jLI4SjZv/3orNJNC3i8pkS3Yjqvrf4FtCfXZsI5Tc23zX/A45HE3pKHasbiAkndT7VtsEXZiuLG8NC1DqlWaOHohccswn5HpEmVgdmSGGEFkjRUgKJEIlm9rr9LK6K0dUkbMuYyZWSeRfSgeTpZ5amTXLfxwjuYcMIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027609; c=relaxed/simple;
	bh=/g/mpGhVOGz+gK87QTJHRn4TB5hyOU1+lN/sKJFtoxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0K22MiRkAD2wVizKfHVI79oqlBu0yi6VJ4zyxsYZs+IupYHowdlC13yEpaZTNMrYMIg4X0mNYPOl36pq3XrLjo9dh3i1+Sofjp69vCsenDO28MebcbRYKWgOvJLYhQnjcRhzlfBvLdz6Dc4qLdyieTHOFPTR68pFttU3BomH8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zu6DSFLZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55485HDT010405
	for <linux-wireless@vger.kernel.org>; Wed, 4 Jun 2025 09:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u4gLuogvnUZ5BsRuEHeQX26ZSFw3hTDdMUZj/wBFfVw=; b=Zu6DSFLZ8b1cTMVh
	C1kpj3VIZ8aeAbbWYReX3frt2wJrG1DKBYODE1Q6wRpGBAL4VYiNnDhuamUF5nXa
	a5aYi7m48F2KJOrTw509v/ZWigoT8wT3LLqW3vlX7ZirMMgpbSH+NZHocEQcKw63
	JEGhreCJ3cdJMMoKu6q+Wlo6DzwL8gyO36Ha9C0qDRrs4/H3dTx31WbkQel4wHip
	oBSFRW6gqkBDnjcURIAy/Qs2OLOY9PfPSHsPHCpnkMzgTBoP2GR99zxQDWLGnND2
	JGWXKsuos0lWJuRpI77KH5WuUEMakBHqipwsIUT10DJQ0+3IXXNLIpiJ+ns3dzij
	21viVA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ynf80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 09:00:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-73e0094706bso555696b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 02:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027604; x=1749632404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4gLuogvnUZ5BsRuEHeQX26ZSFw3hTDdMUZj/wBFfVw=;
        b=D+F74GUWigUeVUG0WZzXFGzmBee75RTt3b+9JBtBC16NO2GgLsnDsqnoSTR8q8r2vv
         yqmi85xWoX+d0RQfOB6ZsETqkdJc+vVlkty6b/GW4qSB69UiH7Y7/Y7LikaBFHJrQFQL
         HyjCawN7eD3f1XwcbHGDxN74worTE/U1jT33JIcF2Rd9h7wFHux8g+IOBQusrLvs1Wjn
         BnsixD6eUZWlY9oG0du5BFr+upzNU9SChzh9ov9MBh1bcePgdhdTC3laDPfKQ4Fh88BQ
         E/NDFgjAQi33LmCYEmNRLzidadXIWTtb+NWWruy0MLqkJsQs6oEtkWeazVTSwDBNkIyJ
         yXJg==
X-Gm-Message-State: AOJu0Yxo9IqxKLg1kF6yycSqoYlpyJEM7LHxrK/kh8EYsFZrbY6nNXrI
	Cj/ddMBnZrHiPgLlS8UCEG+BnwPQrT7kF94T2o3rrYc8I1IPnxpO7ZH4d9fUemhpldOI5K26//j
	Y8v52KJbyBMWZFaO82xj3aj+oxcb9WuSEe5uiejIdjA57RgvPhvm1V5dvVrKf2mdCVmJuQQ==
X-Gm-Gg: ASbGncvgajEB6jy5klcrksPJdtqq47ehDWYisYo8/5oBhFDWQdHulhV/UFoO/xqGzLb
	+5BwosOUwUfckevg3anYUuChpOgF9rn6fsDvjarPv3JcOR5A6Tl6oS4DldwptWDPkNgzmBFC83A
	vZyn03jswXl6cU6FDNyGHUJYRe1AbNGCIcjuQjTp8/jrq2Zyny0HsERz7ARErnGNzgSi00/2z4V
	Hjg9wv2fKt3O7cg7DnwdLAkgj6GfWVVanbOEVRVOn99p+XS9bNSY8GbOtsEvj+/UiqFMv6oZRwY
	PSbvaMefVjeNUV4D6ERz7nd9ZVOeKzeEP4DX5VFwskv6FVoeF2g=
X-Received: by 2002:a05:6a21:618b:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-21d22c52999mr2945107637.42.1749027603673;
        Wed, 04 Jun 2025 02:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhXyOzupgZsix6xphSRh8LzKjkSSN/p4l53n+2/5C6u8VJJB9YTJcZX92QZK5UEtB3L2BXoA==
X-Received: by 2002:a05:6a21:618b:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-21d22c52999mr2945075637.42.1749027603232;
        Wed, 04 Jun 2025 02:00:03 -0700 (PDT)
Received: from [10.152.192.246] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb28c98sm8309595a12.19.2025.06.04.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 02:00:02 -0700 (PDT)
Message-ID: <3249b83b-00e6-464a-a6ad-80e114ffd438@oss.qualcomm.com>
Date: Wed, 4 Jun 2025 14:29:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: allow beacon protection keys to be
 installed in hardware
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250421114711.3660911-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <D9J8O65N947J.Y0LSNAOS0AYG@gmail.com>
 <57064b98-5950-4b9e-8d76-265e56127dd1@oss.qualcomm.com>
 <9605558d-e785-4eb8-a752-1f591eff393e@oss.qualcomm.com>
Content-Language: en-US
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
In-Reply-To: <9605558d-e785-4eb8-a752-1f591eff393e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2NyBTYWx0ZWRfXydYeSlsHZ/Xg
 TOjEGO65U0gxJ06v13tUNrgU6lhvTcX8jNApNikwxiwMYUM6F0yW/M8JPP0gQB60igV5CQcp2JW
 2DHx+VDxoiZcd3dGX1HRNf70uU4MDso9iETRfqOmQaE8or0BJuFT6yW2ilc08lKuC7yTtQtvt0i
 KAWQ30L2UfHb4vDsnXmQr0DXyUs7/PobjtMm/LqV986I3Bzl2utw18uG7TL2hWmj4cUXobK0lDE
 cwyWJtmIIn2YjRVmqHdq2PIWHGAwoxNWi+sRbl6k1XezsLqVXhmI+NU+YrRhognusrBrhNWsqZr
 pEUI4jPsePYGVU5R2HuakMBDMbXs5N/XhGoiw9QKBqG3QmKXO5FcV46lkJpcxjK9iDo9UrSlscK
 YaLTM94b20abRoawN3QXTqcPwnpg8e2OLmUnIbHSzbe8R7jByiyN4vEiqw2C5RfiZzdfIDaS
X-Proofpoint-ORIG-GUID: B61gHISpfnevpyDwuGHdvB4urzH3Z3xP
X-Proofpoint-GUID: B61gHISpfnevpyDwuGHdvB4urzH3Z3xP
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=68400b14 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=qC_FGOx9AAAA:8 a=EUspDBNiAAAA:8
 a=WJSFguKkjCZlOGsh5swA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040067



On 5/9/2025 9:37 PM, Jeff Johnson wrote:
> On 4/29/2025 11:05 PM, Karthikeyan Kathirvel wrote:
>>
>> On 4/29/2025 9:17 PM, Nicolas Escande wrote:
>>> On Mon Apr 21, 2025 at 1:47 PM CEST, Karthikeyan Kathirvel wrote:
>>>> Install beacon protection keys in hardware for AP modes only if hardware
>>>> supports it, as indicated by the WMI service bit
>>>> WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT. Allow keyidx up to 7, since
>>>> beacon protection uses keyidx 6 and 7.
>>>>
>>>> Control this feature by setting bit 0 of feature_enable_bitmap when sending
>>>> the WMI_BCN_TMPL_CMDID command to firmware.
>>>>
>>>> Check for the beacon protection enabled bit in both tx and non-tx profiles
>>>> for MBSSID cases. If set in either profile, enable the beacon protection
>>>> feature in firmware for transmitted vif.
>>>>
>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
>>>>
>>>> Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
>>> [...]
>>>> @@ -4964,14 +4994,6 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>>>    
>>>>    	lockdep_assert_wiphy(hw->wiphy);
>>>>    
>>>> -	/* BIP needs to be done in software */
>>>> -	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
>>>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
>>>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
>>>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256) {
>>>> -		return 1;
>>>> -	}
>>>> -
>>>>    	if (key->keyidx > WMI_MAX_KEY_INDEX)
>>>>    		return -ENOSPC;
>>>>    
>>> This hunk seems to break station mode on QCN9274. Maybe on WCN7850 too ? I see
>>> that it was not tested against that HW.
>>>
>>> With that hunk I cannot receive broadcast trafic sent by the ap anymore.
>>> Generated by a simple "arping -b X.X.X.X -I br0" in my case.
>>>
>>> Replacing that hunk with something similar as what is done in CLO [0] seems to
>>> fix the issue:
>>>
>>> @@ -5575,13 +5605,9 @@ static int ath12k_mac_op_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>>>    
>>>    	lockdep_assert_wiphy(hw->wiphy);
>>>    
>>> -	/* BIP needs to be done in software */
>>> -	if (key->cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
>>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
>>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
>>> -	    key->cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256) {
>>> +	/* IGTK needs to be done in host software */
>>> +	if (key->keyidx == 4 || key->keyidx == 5)
>>>    		return 1;
>>> -	}
>>>    
>>>    	if (key->keyidx > WMI_MAX_KEY_INDEX)
>>>    		return -ENOSPC;
>>>
>>>
>>> PS: I tested that with firmware PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
>>>
>>> [0] https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0/patches/ath12k/726-ath12k-add-beacon-protection-support-for-ath12k.patch?ref_type=heads
>>
>> Thanks for catching this Nicolas, will check and get back on this
> 
> Will you be spinning a v2? Note the dependent mac80211 change has merged.
Yes Jeff, we've identified and confirmed a firmware bug that gets 
triggered during IGTK key installation, which leads to corruption of the 
GTK keys in firmware. To work around this, I’ll send a new version where 
IGTK uses software crypto. Once the firmware bug is resolved upstream, 
we can re-enable hardware offload for IGTK.
> 
> Also there is an indentation issue in the blob:
Will address this in next version
>> -static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif, struct sk_buff *bcn,
>> +static void ath12k_mac_set_arvif_ies(struct ath12k_link_vif *arvif,
>> +				     struct ath12k_link_vif *tx_arvif,
>> +					 struct sk_buff *bcn,
>>   				     u8 bssid_index, bool *nontx_profile_found)
> 
> struct sk_buff *bcn is not aligned on the (
> 
> /jeff

