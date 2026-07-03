Return-Path: <linux-wireless+bounces-38559-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FI8NBY5XR2oBWgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38559-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 08:32:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645F6FF18D
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 08:32:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mni1d88L;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FyRFmUiS;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38559-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38559-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC02A3023513
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6328237B41B;
	Fri,  3 Jul 2026 06:32:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C33357D00
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 06:32:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060325; cv=none; b=RmjAyO0EYeTvgj4qF1MXn61c0IsL0ctbNQSbUsdK2UUR6OTALa1FwcuELAGFXg6yr2sY6yidib9kVvcgg0pOkzOb/C6XbBLUaXykQEfMsVbh2igZUI51g+YBswr6920vyByH7ziBjaTXboOQW9l9Bhyn2PvexQZ0DDzNfVjUZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060325; c=relaxed/simple;
	bh=NPGCd9NHbX26GVh4RfHtv2s35+xF/se/kU2yD0KLm9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UDf7DV2O9dPZgulZhoubkSwCgUmePnRxXNIZ/j9cJMxhZSQVVBYea/H7o3Ly9KmbCRZOYJzNNMSQqKAR9xxy2oJXBwAQIlySjo3fhfjkgoyCLEXfQrtUugedrgz3SFjKhWc8wuSpwaPlNkENPTF6jnm1UGDm3K8FbbcMLMsT95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mni1d88L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FyRFmUiS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rlfk3123718
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 06:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FO7KICiImDQj+zRAbCrWa+noymeXncMxP471XfTA9zw=; b=mni1d88LddJO7GFp
	ZamOkCkFhH5oFFyPX9TD9C97S+l4jeBvUmF1BB1OOkgYVI/pac4jLiqwGyMKw/7L
	Y1L78lOvKbLOdcDpxYZaBH2aHMMltXyESpc2DqTCPVeF7wYj3eAA07NyS/nuiV1t
	7eIlSzYOU+mRn/kENkKDVdU/X/xhhvz/EIjUeFlHSTe1V8KvxifHoOZaKeXMn3D3
	eoAT2Lal439+3zXlxQFv7u3ytQlcGyzn96hpC+NtEe5vx9V7GZ38SO0PZaAgV6W8
	NoOM54lTQYwn/UXTUVera4bXdvt8F5Xbp/UhvdU/5bbvwVk1ixDC+z5eNgoyYRzv
	tBwJXw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5qnpbync-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 06:32:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c79e5de32cso3563535ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 23:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783060322; x=1783665122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FO7KICiImDQj+zRAbCrWa+noymeXncMxP471XfTA9zw=;
        b=FyRFmUiSm5dqkXo2sMS/GwgO001Z+KMlUwMOK1szg2Li/JEyt1NmVhhEGqUTS+YBDt
         QQ3/yYcFLmY9iLnCM+lvEMAVZziK2TdexPHh7stQeevQ39x5f7riljJtG/EuOKTeViua
         GiWBMyqB6MDiu2ES/bXntTXyLY05EDrCGjvyVGyGSWuWfAk09AxpWG7QfS9E2uLhw4zX
         S8RZhI3fJSigmnQW8lD+kdGb1DxteChle2HMJWYQaTYnNXafLvobXj16ce91yoF7AoFy
         uZ8ZqAPXWfQ+fAhnBrw9ppvqRQaEwqEQm0loifREuH8ZX/DdUsSLUWM1xe/QQQxB+zLt
         eW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783060322; x=1783665122;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FO7KICiImDQj+zRAbCrWa+noymeXncMxP471XfTA9zw=;
        b=TrN/qtJEpECyBKtuzuYrohvMKMrGOW7ek/aj6y0us6mBmUYCdMuqVq/ccQ7teYNppZ
         Jwe0kpbrunu3rkkydTRTIzL2AkUEx3a5qTjOxwAekkmb3mgq3YlBYnFnLsxXSNzdiBP/
         UzVokDyjvAb+xvisJVNdFbvo3JiUIyV0BP30b1NiegbvsG8F3XBkPzl/BLOVcmNViHNY
         2tXuxlJoxNRcqwkRrgLrOtjtHgUvNZL5d9rrOzMjogrq1WY2Kyg98Oc+O3092AIqjCJy
         UijRREwIia7ZqtreC99GClbSdlZUDVhCrTdFZJa8XvmGMlhKEFoEJmM0n0AygdyigHMB
         oezw==
X-Forwarded-Encrypted: i=1; AHgh+RovtN9YFBPrN67+4zJqwasSwO2qjGU2ycxpLDYKHBTXeQuW3gdC7ymvKEv/CbjVuTlFcPtj0c+Ifc+fhyaHKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxSu/0nhUdRXFEoEhzN58fYYv/ES4jGgs2IwM9C540mXKuG1ut7
	7GstmeedmVYTAnyIutJ7Wjvx2Y0spRpuJnezHkmhpjrg3agxI1JYqeMzTzCmRr5HBfIBdaAfisG
	rMJ5+ZOrZcuq/TqrhUqDOTp+JKSqKHjUuDlggVa0+S17zIu5jMrtZN7XW6Ggay3tIUeHVhw==
X-Gm-Gg: AfdE7ckej9iGhnd7nwLzKKLGX+Xf8qcXpymWrXEM7ZumfZRn96iNA+DH5ZskrhBmZ5k
	OewjHu7+0651NZ0ZvvT3Pw9rb/jtysInLgbnd/IqAm+lZQfFhcuUEEh+bDLYN7CTuJCDNUaOHQo
	6kI2pRaJWjKg0z58i9oxgx0ObNoEyLQocnDVs515Qa2DKuqEM343J+Gt6HYDejcOp7x6s0K61qa
	OK9SBjnbw1ixdrQs+vrniTvsWy5chr0ulIyeA6llolFl3E/K5owTZjg2/mxCGlIp8Qinb9whuUH
	/Dg0CmWMMO4jI+vcO498kKOv2xopKm4vU+iaMkuLuQ2Dxs8UoWEoNQbRY78KatZAuOnBS78Jwj3
	MPJqU+qtEvqj6XOuk0fd5ZuT76fnqB22Ess8hG7fIs+i1LW61aeSgdGnBOUFG6mPTIZba3L9Bx2
	Hbd4xu3rH/
X-Received: by 2002:a17:902:db07:b0:2ca:d658:d88c with SMTP id d9443c01a7336-2cad658db54mr15623985ad.32.1783060321670;
        Thu, 02 Jul 2026 23:32:01 -0700 (PDT)
X-Received: by 2002:a17:902:db07:b0:2ca:d658:d88c with SMTP id d9443c01a7336-2cad658db54mr15623645ad.32.1783060321152;
        Thu, 02 Jul 2026 23:32:01 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7894b20sm4356225ad.78.2026.07.02.23.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 23:32:00 -0700 (PDT)
Message-ID: <95319952-645e-49b1-904b-599e22ecd429@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 14:31:57 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] wifi: ath12k: fix channel list copy on big endian
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260629-fix-channel-list-copy-v1-1-5ab826c46d7c@westermo.com>
 <8b29a6f4-0742-46f3-bc86-defa6e0faeae@oss.qualcomm.com>
 <akYk_pKRd7kR13IL@FUE-ALEWI-WINX> <akZXF0SI8jVky0Wj@FUE-ALEWI-WINX>
 <bf545855-6568-44ad-95eb-ac9c55827e89@oss.qualcomm.com>
 <akdNdQPM2jdbMvgf@FUE-ALEWI-WINX>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <akdNdQPM2jdbMvgf@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX3wYPPU3FykTN
 JCXTshAlT66AvDbf138aQt/hKEmh9xN3uTSFvXnHS4/a74sCxe6zUsc2n9bsZkGo2S/Cka1z+nU
 CTBKy55NqVMj6Ye67EnCsU8xHMYi1ek=
X-Authority-Analysis: v=2.4 cv=FoI1OWrq c=1 sm=1 tr=0 ts=6a475762 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=N9GNhs4bAAAA:8 a=OEorHgOQthOkk5lfAioA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA1OCBTYWx0ZWRfX+pKqWjmeEOFW
 N+iyfswpJw8VoeC/6uZ97efJEfzk75TRKy2lO53ULKMGQs+onC9q5NYyPwR/l2cbV7+Sb2UWe5W
 c1a2Ue0HAAXO9SAegcBLxJ8i52pqIIqnyJYFLw7HVUij0llLbtK4K+v8VC2JyqfuTFTUrBnLmhU
 b9CIbE/lximNROYRAVjhKZe7HlDEfu1djSpyhWwr1eO2LKKermGv9Zh5pmpn9KFqBtQetz5JLa4
 iDILrQ3o9nMcBZDsCwQYfvDsxw64wGV7TExex2cf8h0Ha/OhMwVMKBpxI87LBJhEXBGLtNorNTN
 J7BgyThDeZGEJmMdfGxdCs75srP+ewEQGqNq5ta6sBdDCqPK/ET67YNWRKBv2pkMtX+9FDvX7s7
 35uQPYQdULRzzYWeHJ9Ehklm2zT0qhwk5gSjPyOyXhI26NKECW0M7xA4eAq0yXrjHYe/yEiLKwk
 8Ehs9b9UrXf8+t9GoYQ==
X-Proofpoint-ORIG-GUID: VfZv4BkgUXVONMo54-SXAjkt_fJD3zLv
X-Proofpoint-GUID: VfZv4BkgUXVONMo54-SXAjkt_fJD3zLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030058
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38559-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,westermo.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6645F6FF18D



On 7/3/2026 1:49 PM, Alexander Wilhelm wrote:
> On Fri, Jul 03, 2026 at 10:48:11AM +0800, Baochen Qiang wrote:
>>
>>
>> On 7/2/2026 8:18 PM, Alexander Wilhelm wrote:
>>> On Thu, Jul 02, 2026 at 10:44:46AM +0200, Alexander Wilhelm wrote:
>>>> On Thu, Jul 02, 2026 at 04:27:44PM +0800, Baochen Qiang wrote:
>>>>>
>>>>>
>>>>> On 6/29/2026 3:46 PM, Alexander Wilhelm wrote:
>>>>>> The ath12k_wmi_scan_req_arg structure defines the channel list in
>>>>>> CPU-native order, while wmi_start_scan_cmd expects the values in
>>>>>> little-endian format. The simple memcpy causes the hardware scan to fail on
>>>>>> big-endian architectures. Set __le32* type for the tmp_ptr and swap channel
>>>>>> values to support both architectures correctly.
>>>>>>
>>>>>> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
>>>>>> ---
>>>>>>  drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
>>>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>>>>>> index 65a05a9520ff..9e1d3c662852 100644
>>>>>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>>>>>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>>>>>> @@ -2571,7 +2571,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>>>>>>  	struct wmi_tlv *tlv;
>>>>>>  	void *ptr;
>>>>>>  	int i, ret, len;
>>>>>> -	u32 *tmp_ptr, extraie_len_with_pad = 0;
>>>>>> +	__le32 *tmp_ptr;
>>>>>> +	u32 extraie_len_with_pad = 0;
>>>>>>  	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
>>>>>>  	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
>>>>>>  
>>>>>> @@ -2656,9 +2657,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>>>>>>  	tlv = ptr;
>>>>>>  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
>>>>>>  	ptr += TLV_HDR_SIZE;
>>>>>> -	tmp_ptr = (u32 *)ptr;
>>>>>> +	tmp_ptr = (__le32 *)ptr;
>>>>>>  
>>>>>> -	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
>>>>>> +	for (i = 0; i < arg->num_chan; i++)
>>>>>> +		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
>>>>>>  
>>>>>>  	ptr += len;
>>>>>>  
>>>>>>
>>>>>
>>>>> seems hint_s_ssid and hint_bssid at the last also need the endian conversion?
>>>
>>> `hist_s_ssid` and `hint_bssid` are both structs within
>>> `ath12k_wmi_scan_req_arg`, and the remaining member variables are also stored in
>>> CPU order. Therefore, it seems wrong to me to perform byte swapping at this
>>> point. What I actually need to swap is the data written through `ptr`, not the
>>> structure members themselves. For that reason, I could also use the `__le32
>>> *tmp_ptr` approach. What do you think about that?
>>
>> Maybe I was not clear. I intended to mean the ptr:
>>
>> @@ -2728,8 +2728,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>>                 ptr += TLV_HDR_SIZE;
>>                 s_ssid = ptr;
>>                 for (i = 0; i < arg->num_hint_s_ssid; ++i) {
>> -                       s_ssid->freq_flags = arg->hint_s_ssid[i].freq_flags;
>> -                       s_ssid->short_ssid = arg->hint_s_ssid[i].short_ssid;
>> +                       s_ssid->freq_flags = cpu_to_le32(arg->hint_s_ssid[i].freq_flags);
>> +                       s_ssid->short_ssid = cpu_to_le32(arg->hint_s_ssid[i].short_ssid);
> 
> No, I understood what you meant. The issue is that the upper two lines will
> trigger sparse warnings. The member variables `freq_flags` and `short_ssid` are
> used on both the left-hand side and the right-hand side as members of the same
> `struct ath12k_wmi_hint_short_ssid_arg`. I would keep these fields as `u32` and
> use `tmp_ptr` on the left-hand side instead of `s_ssid` to keep things
> consistent. Alternatively, I could introduce a separate structure specifically
> for this use case.

Ah, I get your point. You are right, the issue is both the WMI cmd member and the arg use
the same definition.

Please introduce new structures for this. Note ath12k has a guidance on WMI interface
naming: for those interfacing with firmware, use the _params as the suffix:

e.g.:
	struct ath12k_wmi_hint_short_ssid_params
	struct ath12k_wmi_hint_bssid_params

for those host-used only use the _arg suffix, like the existing ones:

	struct ath12k_wmi_hint_short_ssid_arg;
	struct ath12k_wmi_hint_bssid_arg;

> 
>>                         s_ssid++;
>>                 }
>>                 ptr += len;
>> @@ -2743,7 +2743,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>>                 hint_bssid = ptr;
>>                 for (i = 0; i < arg->num_hint_bssid; ++i) {
>>                         hint_bssid->freq_flags =
>> -                               arg->hint_bssid[i].freq_flags;
>> +                               cpu_to_le32(arg->hint_bssid[i].freq_flags);
>>                         ether_addr_copy(&arg->hint_bssid[i].bssid.addr[0],
>>                                         &hint_bssid->bssid.addr[0]);
>>
>>>
>>> One thing I am still unsure about is the use of `ether_addr_copy()`. Can I
>>> simply copy the bytes as-is here, or does the address also need to be
>>> byte-swapped? I could not find any place where this address is being populated,
>>> so I am not sure what byte order it is expected to be in.
>>
>> I think you are talking about ath12k_wmi_hint_bssid_arg::bssid, right? For now ath12k does
>> not populate hint_bssid or hint_s_ssid members, so bssid always remain empty. But if we
>> are going to populate it I think the address originates from userspace and there it is
>> passed in byte steams, so byte-swapping not required I think.
> 
> Okay, sounds good. I'll keep the `memcpy()` at this location and prepare the
> next patch version.
> 
> 
> Best regards
> Alexander Wilhelm


