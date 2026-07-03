Return-Path: <linux-wireless+bounces-38545-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yuDBJfwiR2qJTgAAu9opvQ
	(envelope-from <linux-wireless+bounces-38545-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:48:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3B6FE009
	for <lists+linux-wireless@lfdr.de>; Fri, 03 Jul 2026 04:48:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=U4ds7hK+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="e9h/j3nV";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38545-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38545-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FB71300FC8C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jul 2026 02:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE878264A97;
	Fri,  3 Jul 2026 02:48:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B1223708
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jul 2026 02:48:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783046900; cv=none; b=H/myVpJhhrOiCLQOJs3owao21xRtsxwJte/Q67d7lSowowy/BngOIVXTPqAUhTP+oRwnn0PB6/iv9IgyyqhbKvA9ARl61HFHT1821yNtTqfDh9Et//NLPZ5YLvEXnCbO+29FdrGkWLYe8YRw0WFJyFjhL6H4OkXc7COjPZiKpZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783046900; c=relaxed/simple;
	bh=uV4d2UF2SZyP/JSY6we8a1lGIpeTR+I94ulVg5hzmvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ex3H0X7eXkFufVP6k0cR0WiA8PNODBImo65yhxYRTbd2CUEYX3CD6tukHTLkDGBK8eqnA9hICzNrCPl1ro8M8l8tQDexO7X6la9ixrbsj/TJCombl41EQHss765WD6yXU4A/yFJhx3/wu3YWZrJbXJ470OKSLAVtapPX+m/3UbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U4ds7hK+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e9h/j3nV; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66319rfh2355713
	for <linux-wireless@vger.kernel.org>; Fri, 3 Jul 2026 02:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KC4xQUr0JgE9MWl7+34AveAP7lvWSVW0npuxnAQ4r48=; b=U4ds7hK+qS+ObUqF
	KZXK1TCtawscb0ePcJNX0rymkgSF1rVj7oGv4fgjt9e0ZNsCoP9Fi+WQlN7iKj9d
	8IUxW1veUhFTPMmb2evYDythDJAfxP/w3H17zsZ2h4dq3eIJe3LiC+XDaUgvxuq6
	3/xOdy53xLGjv8A9pEYE019MAI2GzbzfZuqTMNam2LGsV4+rVGGUjNBWh2Neg0mv
	wQwRhHA0U9fJx1/rO1SPFWD1dFx+1RqkGZLQcwjsPDzRfcWepLQOBUY4NfpohlaZ
	EGmXOoW4V/DSVs8u1zKCKceUD8k2Notq+dJm51+m6wDwFn83wxmdDBhh8SvobHK4
	24miow==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnj5dr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 03 Jul 2026 02:48:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84240683a82so108159b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 02 Jul 2026 19:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783046896; x=1783651696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KC4xQUr0JgE9MWl7+34AveAP7lvWSVW0npuxnAQ4r48=;
        b=e9h/j3nV9xixLO/QBgAqQf1TStJJ3bVtEwr6OxCty94Rxjab7EtOy7C/ubZvnHQnkw
         huz/Li9H1AC0/IVxmbUv6q4jcHJK4J/sAuTmkzwivSlufnmkCzrlFkCJSK04GDzEfw4G
         yAtoHhgrvFCcuAttHCZep+NXVRtsb4n/M1gf93v2+29MRsU+xnRQoRTjvCNVU1FeHO0w
         NAgIBPJtu7Rcg+gY9FJpa+BvEENkhKLERuiex7CvFg6ZeA99sOQbpbt4kc9VHlwmCar6
         GiGS2lgyqNlvYOzT+gynJI+xeSS1knLAgE/zEe71JbciyxSlFr3wOvbeE0VtWFMX4vgy
         Xtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783046896; x=1783651696;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KC4xQUr0JgE9MWl7+34AveAP7lvWSVW0npuxnAQ4r48=;
        b=eGXV4EH6V4iaVlvFFGzTSGnRq3uNEW795NJhagej3VIBacyu9PEzxn4NN3xnbYtah/
         F44hySojwooYIrCBJPeOxSlT2qcQfpTs5W0uWa2r4V2c+MJloblkBv+WGlhMfZG5pcGz
         xaFIo+9uC2k9w1uXRSWbiszh2PexRSKlyVsrJcxntZvKN5aGSMkgkTTDfR1NLFaHi2Kv
         8lhdqo/ZHE3SA/LVaSS1z4YOKtIjVPkl10F46WiGzlTPq5AEKhUT+s61vBakKXGPwFlU
         jMqxCUwuExck/Ft1jB6OPUuub+oap1AtGec6zU/STEwIyoEc2VEqbLWUKObhbfu+PJ3o
         3HBA==
X-Forwarded-Encrypted: i=1; AHgh+Rpcloqgi1gJ2MvmLM+wxbw8reW9pkROY+6PX7yFED0BfYwDABsxNeCx4H+wgbEl8eCU6a6BoS5qBI//1BbksA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVrRWFbDZppsVWtQn9ivJubmBnPBYnK1sPjym//wkubt/RWuPX
	PS7LEtuPFB+9PxszFwqaG/cYYR5zg+lFk6KmeLQg+QhZ8ldQdB9vS7sZuaj1l3Mkpv4mijox0BX
	hkNJKzDzrtIE5743ZvcdgtRW55bCovQVY0xog/dkBIxarT0yiop+mJQxiSKHB0mJaNVhiuQ==
X-Gm-Gg: AfdE7ck1wvg5hnHaB+h65nNEIs54vm/C/oIccF1Z0F4cmOczCLEjr8OsIjiw4OIFYFg
	0WwAikU/RP1Rk1po53Of9ywHTOYOto23GcYq07qxF0ME9+fkWIIscjJRPrRRJW1MaCuLnS8Ad5t
	xAVDTkP3DpEMrN80C4m9ZRW+63FkEqXcrVu8pLR43PcYWSQCtSWqgSf8reepK4naAHWR8vDEgun
	Y39HZcyyjzEA+RpqWd8BOKTspi24j0frrOyrZkzQkB38dXnExFHXgCg4kLXzSPE2rHrouenLcRu
	xrzgCn5NBOcFfZrZHnDERvnLoj0yIWUeUELu7TFUuyn7xw02jzaE8KYYd5LjwGt7naQmDrdAKE0
	/5EyWStxasV2pqTSVcYczmCvunNhp6MxrP/bt2MliZDGhVT9ILNNg0XPdNKQSLStJZ92M6Miun5
	25Ir8nZlb7
X-Received: by 2002:a05:6a00:419a:b0:846:eaac:a5ea with SMTP id d2e1a72fcca58-847e177a3abmr2024423b3a.3.1783046895913;
        Thu, 02 Jul 2026 19:48:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:419a:b0:846:eaac:a5ea with SMTP id d2e1a72fcca58-847e177a3abmr2024405b3a.3.1783046895295;
        Thu, 02 Jul 2026 19:48:15 -0700 (PDT)
Received: from [10.133.33.211] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb79b9adsm2251650b3a.27.2026.07.02.19.48.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 19:48:15 -0700 (PDT)
Message-ID: <bf545855-6568-44ad-95eb-ac9c55827e89@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:48:11 +0800
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
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <akZXF0SI8jVky0Wj@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KkXaM_5SL6NvYeNhlI7U4PsILAXzO1s3
X-Proofpoint-ORIG-GUID: KkXaM_5SL6NvYeNhlI7U4PsILAXzO1s3
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a4722f0 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=N9GNhs4bAAAA:8 a=c7I3wfr0XCohLxdBRdcA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDAyNCBTYWx0ZWRfXwQb4nfAtGJTI
 ZL5SnoZL5tGwJ9mweQqRaB4NJpY/bA3q47DqIXihWlasuKgTdesiyw6YE+dhpqkRX77ulcYKkcI
 Z1jOOnEUFNaeMRWRSWaB6taYu6Uqt6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDAyNCBTYWx0ZWRfX2R2oH3jdsoak
 qM0mL8I6DoR7YkCQiXOTAm6rcCc3W+gaFSxFMLQusyAriy7vI0c1LqcKc8waqwnikqBQweNQ5EQ
 B5nsg6TsS05d6HvebI3d1six4ETVyzl9dNL5/Vr6Jtlb5RwqCX9Gf6rsOsgB36pMuGAY5DtbLHY
 6UbG47QLpbrRKJ9PiWbtvF7znr1HTmUg5nGFbk8+i+p6ceiqwUApFgkC3ik90pKBJLJIwfrhmiy
 qga9ELGaxvmnrWEm957SP3cOoDp70QZqIMffK8iFdTD/rJSzA6r4wciBay2mRTr14d4vfp2tz6s
 yxGDwQSUVy11hZJX/DPNZ4ohm+TzzG98D5otlRuCOqLnx9Lx39xertI4y06Qa9idOXgcTh+ihvG
 6OaW/dzSW2BrKKJ+CiT0tP83WmAJQVSDfJ1ZsQRV0dXxbYSm3/oJL8xWrSUzg4gZO419vfu+B3z
 WP/4gnjMEktG67uKlsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030024
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38545-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexander.wilhelm@westermo.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99B3B6FE009



On 7/2/2026 8:18 PM, Alexander Wilhelm wrote:
> On Thu, Jul 02, 2026 at 10:44:46AM +0200, Alexander Wilhelm wrote:
>> On Thu, Jul 02, 2026 at 04:27:44PM +0800, Baochen Qiang wrote:
>>>
>>>
>>> On 6/29/2026 3:46 PM, Alexander Wilhelm wrote:
>>>> The ath12k_wmi_scan_req_arg structure defines the channel list in
>>>> CPU-native order, while wmi_start_scan_cmd expects the values in
>>>> little-endian format. The simple memcpy causes the hardware scan to fail on
>>>> big-endian architectures. Set __le32* type for the tmp_ptr and swap channel
>>>> values to support both architectures correctly.
>>>>
>>>> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
>>>> ---
>>>>  drivers/net/wireless/ath/ath12k/wmi.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
>>>> index 65a05a9520ff..9e1d3c662852 100644
>>>> --- a/drivers/net/wireless/ath/ath12k/wmi.c
>>>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>>>> @@ -2571,7 +2571,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>>>>  	struct wmi_tlv *tlv;
>>>>  	void *ptr;
>>>>  	int i, ret, len;
>>>> -	u32 *tmp_ptr, extraie_len_with_pad = 0;
>>>> +	__le32 *tmp_ptr;
>>>> +	u32 extraie_len_with_pad = 0;
>>>>  	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
>>>>  	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
>>>>  
>>>> @@ -2656,9 +2657,10 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>>>>  	tlv = ptr;
>>>>  	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
>>>>  	ptr += TLV_HDR_SIZE;
>>>> -	tmp_ptr = (u32 *)ptr;
>>>> +	tmp_ptr = (__le32 *)ptr;
>>>>  
>>>> -	memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4);
>>>> +	for (i = 0; i < arg->num_chan; i++)
>>>> +		tmp_ptr[i] = cpu_to_le32(arg->chan_list[i]);
>>>>  
>>>>  	ptr += len;
>>>>  
>>>>
>>>
>>> seems hint_s_ssid and hint_bssid at the last also need the endian conversion?
> 
> `hist_s_ssid` and `hint_bssid` are both structs within
> `ath12k_wmi_scan_req_arg`, and the remaining member variables are also stored in
> CPU order. Therefore, it seems wrong to me to perform byte swapping at this
> point. What I actually need to swap is the data written through `ptr`, not the
> structure members themselves. For that reason, I could also use the `__le32
> *tmp_ptr` approach. What do you think about that?

Maybe I was not clear. I intended to mean the ptr:

@@ -2728,8 +2728,8 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
                ptr += TLV_HDR_SIZE;
                s_ssid = ptr;
                for (i = 0; i < arg->num_hint_s_ssid; ++i) {
-                       s_ssid->freq_flags = arg->hint_s_ssid[i].freq_flags;
-                       s_ssid->short_ssid = arg->hint_s_ssid[i].short_ssid;
+                       s_ssid->freq_flags = cpu_to_le32(arg->hint_s_ssid[i].freq_flags);
+                       s_ssid->short_ssid = cpu_to_le32(arg->hint_s_ssid[i].short_ssid);
                        s_ssid++;
                }
                ptr += len;
@@ -2743,7 +2743,7 @@ int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
                hint_bssid = ptr;
                for (i = 0; i < arg->num_hint_bssid; ++i) {
                        hint_bssid->freq_flags =
-                               arg->hint_bssid[i].freq_flags;
+                               cpu_to_le32(arg->hint_bssid[i].freq_flags);
                        ether_addr_copy(&arg->hint_bssid[i].bssid.addr[0],
                                        &hint_bssid->bssid.addr[0]);

> 
> One thing I am still unsure about is the use of `ether_addr_copy()`. Can I
> simply copy the bytes as-is here, or does the address also need to be
> byte-swapped? I could not find any place where this address is being populated,
> so I am not sure what byte order it is expected to be in.

I think you are talking about ath12k_wmi_hint_bssid_arg::bssid, right? For now ath12k does
not populate hint_bssid or hint_s_ssid members, so bssid always remain empty. But if we
are going to populate it I think the address originates from userspace and there it is
passed in byte steams, so byte-swapping not required I think.

> 
> 
> Best regards
> Alexander Wilhelm


