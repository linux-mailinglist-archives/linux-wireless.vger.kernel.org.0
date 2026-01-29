Return-Path: <linux-wireless+bounces-31330-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHaBNTZ/e2kQFAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31330-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 16:39:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37086B1934
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B769300CC2C
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FA42C21FE;
	Thu, 29 Jan 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KRmviwai";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RVNP8U3e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB226CE32
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769701011; cv=none; b=LfsHau1LOewCQSRM3h9cdVyXNmyYQCmVc6CjIp0lbBDGTM+HYbFIbM3MRmLt+FkYDPz1w+G60abJ840qjGYESZnF6EtDg2+xYog0Vg4bYnlV3pwo0kFjYXEgGeTW6FG0iAh67q1qbyj5S7WiqRdiDIAyfnfjm/wxVEY6OZjjsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769701011; c=relaxed/simple;
	bh=n/lFUJKr6e5LUVOCvqGDnYvLEaPuH6U/vHLefHnhDQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ed4WDgpikGR79blDRWbn3bp/BrOl5ZSTLz1U4Bx/jNia1kRTZ37vDCDsKBpJeBsn8iApIEj670wk8HGyJ7DKmMeQ9lsxYUIyoX20+eYJMNPYXrdbfyDMEVTdStiV1HDP80ImaVg2Kh7A5J54oTndn03Dji0qXkB8QrjI+QHor+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KRmviwai; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RVNP8U3e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TABrdR2034750
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 15:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	haVDLFesjUr51ljmdTGJ7aBj2MVT/9USM4sAMmtP5R8=; b=KRmviwaim9IAMOS7
	J1RJGYmmnBX+QeCk54Cq169RpzQTQkdCxSTzb7Dm78LMuBXwPi+1m1v+hdmYbI73
	/gyFC0y0WxeBDr2iK6gq2PDyX97q/cC83z2NqkOLZvATIrNA/GTxUcMfdAD2/5wt
	nhNSA5n63c06C31eEQGYFlla6zOZIw1OyQpY8LNwGKn6WdgdAPv3qjT5BqT0y4bP
	vVwr2A56TIzpQQfi/AmXJcXIyZQvPFxZjjmSCjqE63BRms91/SCSsyTcSu89jJF+
	wpflK4zUSZ4va4W3baiMb1cm032i60ftk2kBsd3E4jVeXaRt/XZgon+pnNLiyZCq
	zfJl/A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4byna7m77q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 15:36:46 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b74766fae7so1306583eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 29 Jan 2026 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769701006; x=1770305806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=haVDLFesjUr51ljmdTGJ7aBj2MVT/9USM4sAMmtP5R8=;
        b=RVNP8U3egfye4o22RI1Eek9NmNeFS+ovE7iaBaw4b+lb1IsFkGwunzUECXqfKYFKcN
         GeflK0F3asfL80T2mzPl/cas097fHWeNj9GcmZxQClatQ/IGZ7IFQsvWbljeTi+Ptm6W
         AjjVa8qtfVRoAHIIsS5TEcIy4RY9nNDWeIBsy2FR78XA7HauGIO225UvwlHVrG+hsulm
         PTfY46kFp0oSVdMchpxrZ+hJtwsEE0kICP8/fvSx/fLNcfxnV3VWzNhkm2CAKzzP1VSn
         bR5V13203qxy/9G+0rQo1R73GRV7A6mAr7FOvfKbMsbCY6HbbAOikXIzxjCuqXtQaTbz
         uT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769701006; x=1770305806;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haVDLFesjUr51ljmdTGJ7aBj2MVT/9USM4sAMmtP5R8=;
        b=FlA1WLF9okBHR93lavyKu//TC/YVsfkHCfEUYyAc5UmxOAQg1Js6bUwPVn9AV7Q4O3
         m5syhONQZjY9YDYd3VsjqQ+2hl8DQryLhhT35KhmcSoBHqLgRRKwaQ9vpAW+N97hZrFE
         AJlFTnELS7TsW6juW61PbxuVDUzh6tvOnwWH/WcvSnbHsQxxluQ9i3eC8ZBkXC0i+ktg
         PRYozIOiKIFcZu4riGyvVoRTFH8NPPCExP2Q13Lha+cRNGHGc+2dmFmImD6KxB+zsFfk
         dLwqhZJvz+U9xLf+r2gLJ1TH1d9XTFExw2+TPI25/cJZK1yBhxfP6SDAaUK7tuahmWaP
         oiIA==
X-Forwarded-Encrypted: i=1; AJvYcCUR/NfoucDkTcAvHDmQw5OVtuglHJHUP9NaK5e/MPaGydrVQz6csj8kICu+ejXfF4ruH5OMr6TEM9yah2u+Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEf00kIhPIcvu2GQlZ2+fJH/k+ypwrknNo2dxvk/9g0p0oFQw
	tlIZX2VFyNmXUyg+fSzUw9ICe9zxwr9P6NdFucpH/ua+LqpYw3pcpiR0n+B8WEIjOzOwabzGdVB
	HMf6erLx2g5ka+9Vui94xV8btQZZ21kSa3lK7voOkzKC6q6hViS9OhMjMF2lwI8c+Dqm1lA==
X-Gm-Gg: AZuq6aLDB2+KDn/m77vFh3jdIVZaVMFacCVLgGCHYTACIlnJNeajRBmyRlYQvXHG0hV
	lI3GdQEuWvrG8R/JlzUoipTZnhauf9A3o9vMimYZVGd9M5bnq5ef4HuOKtri8NWWSXCcm+Qkq2+
	A8bKCCdriQHIlKbkRk/x8I7x6pjf8Iqtk0Nb05azZIgon1WeJK/V1YXBaOIy7x0nrhhaBtRVRhk
	peMsuju1B+eRzuPC0gzy0snOvSpPIbBUQSk2P5CE2j0FSo4ikqRtXXqHDsO2GKamzlEzU3pTa1i
	HUXobnNy+cToD1WilDd/7W66oP0JC+8CKE+j+hkQDTf7LH8qoDTn2C9Z7RusUVTESJuKjKKJe+d
	XiqarbcIsINv7LQCExPXm4R/RECiSlo1U8fj2xEhB5iX2ZzNSDl4FWrwxbDP0aegVNCdzCk/UcW
	7f0w==
X-Received: by 2002:a05:7022:1a83:b0:119:e56c:18ae with SMTP id a92af1059eb24-124a0080fb3mr4849533c88.22.1769701005807;
        Thu, 29 Jan 2026 07:36:45 -0800 (PST)
X-Received: by 2002:a05:7022:1a83:b0:119:e56c:18ae with SMTP id a92af1059eb24-124a0080fb3mr4849504c88.22.1769701005108;
        Thu, 29 Jan 2026 07:36:45 -0800 (PST)
Received: from [192.168.1.38] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9debe5dsm7311579c88.11.2026.01.29.07.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 07:36:44 -0800 (PST)
Message-ID: <97b132e8-d3b2-4e52-aa74-c8aeb0f5d516@oss.qualcomm.com>
Date: Thu, 29 Jan 2026 07:36:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: fix memory leaks in beacon template
 setup
To: Zilin Guan <zilin@seu.edu.cn>
Cc: ath11k@lists.infradead.org, baochen.qiang@oss.qualcomm.com,
        jianhao.xu@seu.edu.cn, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <6cc72c12-6f50-4e91-9b7a-bde8633009c4@oss.qualcomm.com>
 <20260129061330.796429-1-zilin@seu.edu.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260129061330.796429-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Hh88dzHnM0QDtquk7StOFBpo_9Kh0IbQ
X-Authority-Analysis: v=2.4 cv=J72nLQnS c=1 sm=1 tr=0 ts=697b7e8f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=BJHQ5hLiUQ4w7pZWvIEA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: Hh88dzHnM0QDtquk7StOFBpo_9Kh0IbQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwOCBTYWx0ZWRfX2ipi9Kvtx6HQ
 L+zEK2NNp+9lSXJJR32IAVekGk8lPIR4m3jWKYeN45c/NafTBm99oYTBgrP2i04JwTJM5xP1A9/
 KXpPEr8E9Vd3hVkLAJxq2bzRflAEyaL2KJi+ym+6il25VcdIJQG1JIOEyZQLMjud8z41iQKR+zU
 QjvVhf9oMJjuUbknp8bnubnpal1k1v3gs56NIjnCAGtpaib1v1WF1whbtRNuJk5POg3XzxdF7Mu
 T2sCEERIU6zIoIwo4/40NgNf1M8uLsQTfxbaHCPRx6PQGGZ6K+KDdq4mZ8EOyOimzHNJSLKYrgt
 HXSXIURfA/LpUwEk/vuoHsSbA2f2nWYrKVH0YHaYpSgGBn6A85QXN7wquVM2P2r8hvy20s6Ge//
 AkJfwMJxC8rbtJ7Zkq4/pge1T8Z5v5NsvMD9Y5zFG4A5I0sRf9hRQc+QbfYpVxuU4csV0Q1eUOk
 Eo5FPoYVbg7/V8XG31g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290108
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31330-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37086B1934
X-Rspamd-Action: no action

On 1/28/2026 10:13 PM, Zilin Guan wrote:
> On Wed, Jan 28, 2026 at 08:30:22AM -0800, Jeff Johnson wrote:
>> On 1/19/2026 10:37 PM, Zilin Guan wrote:
>>> The functions ath11k_mac_setup_bcn_tmpl_ema() and
>>> ath11k_mac_setup_bcn_tmpl_mbssid() allocate memory for beacon templates
>>> but fail to free it when parameter setup returns an error.
>>>
>>> Since beacon templates must be released during normal execution, they
>>> must also be released in the error handling paths to prevent memory
>>> leaks.
>>>
>>> Fix this by adding the missing deallocation calls in the respective
>>> error paths.
>>>
>>> Compile tested only. Issue found using a prototype static analysis tool
>>> and code review.
>>>
>>> Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
>>> Fixes: 335a92765d30 ("wifi: ath11k: MBSSID beacon support")
>>> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
>>> ---
>>> Changes in v2:
>>> - Use unified exit paths for cleanup.
>>>
>>>  drivers/net/wireless/ath/ath11k/mac.c | 25 +++++++++++++++----------
>>>  1 file changed, 15 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
>>> index 4dfd08b58416..42edcc5e9e49 100644
>>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>>> @@ -1561,8 +1561,10 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
>>
>> while looking to apply this patch I noticed the following logic earlier in the
>> function:
>>
>>  	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
>>  							 tx_arvif->vif, 0);
>>  	if (!beacons || !beacons->cnt) {
>>  		ath11k_warn(arvif->ar->ab,
>>  			    "failed to get ema beacon templates from mac80211\n");
>>  		return -EPERM;
>>  	}
>>
>> I did not look at ieee80211_beacon_get_template_ema_list()
>> But if it is possible that this can return a valid beacons pointer with
>> beacons->cnt == 0, then won't this also leak the beacons allocation?
>>
>> Given that ieee80211_beacon_free_ema_list(beacons) can handle a NULL
>> beacons pointer, perhaps this should also goto free?
> 
> Hi Jeff,
> 
> Thanks for pointing that out.
> 
> I looked into the allocation chain for 
> ieee80211_beacon_get_template_ema_list():
> 
> ieee80211_beacon_get_template_ema_list()
> 	|__ __ieee80211_beacon_get()
> 		|__ ieee80211_beacon_get_ap_ema_list()
> 
> It seems that ieee80211_beacon_get_ap_ema_list() only returns a valid 
> pointer when ema->cnt is non-zero. Therefore, a valid beacons pointer with 
> beacons->cnt == 0 is likely unreachable under the current mac80211 
> implementation, making the existing check more of a defensive programming
> measure.
> 
> However, for the sake of strict logical consistency, it would make sense 
> to use the goto path there as well.
> 
> Do you think it's worth updating this in a v3, or is the current v2 
> sufficient given the current call logic?

I prefer strict logical consistency so I prefer either adding the goto or
removing the beacons->cnt check.

Or a completely different approach would be to use cleanup.h functionality and
annotate beacons with __free(ieee80211_beacon_free_ema_list) so that no
explicit calls to that function are required. If you try this approach then
beacons must be defined at the point of allocation:

	struct ieee80211_ema_beacons *beacons __free(ieee80211_beacon_free_ema_list) =
		ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
						       tx_arvif->vif, 0);

Note that I have not tried this approach with allocations other than from the
kmalloc() family with __free(kfree), but in theory this should work.

/jeff

