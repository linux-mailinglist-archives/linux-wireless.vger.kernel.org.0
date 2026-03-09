Return-Path: <linux-wireless+bounces-32775-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDYbKM0qr2mzOgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32775-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 21:17:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EA0240C4A
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 21:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE1FB3009140
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 20:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A212369225;
	Mon,  9 Mar 2026 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FO7NFjXv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5GCgnZL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CAB25D1E9
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773087384; cv=none; b=uvfcdDO6Ey4l9md85EoVBDtk+7atGp0gl4dVEf3yLlcF1isgBTFySonMgsznyPxGYrBXnnLBbsODBpjpseELuOb9DkOKlLXuMfoNAyWGULK8S5XLzkvqleo15up1QVyWSliRDqA1IIckh4/bpBDg7kmnNWPVbJl44gXk/Z2g9/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773087384; c=relaxed/simple;
	bh=EsTHDx83OvYPSOrBvT0hlRF8CexHEAe7DKpYu6GXyOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoeO3JiBCmCJoLnBUSsoV64MTqYW+EU18Ug9NngfcmhZTc5fOo2fmftgcXNiMPosLx4JDCMkthbP2RJvqMCZevVZDvtY3gjgecnJEIq2nfZzVlvraI8bC9o8Os4B5/VLf5fLWJicM4IUw0oJJmIQrRIqs0onaMN67g2rmyGcovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FO7NFjXv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5GCgnZL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629JG3rf2872930
	for <linux-wireless@vger.kernel.org>; Mon, 9 Mar 2026 20:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1W/57dKEbvgDKZIHUNPuGulUAs5FFvgypvGnAL2PC1A=; b=FO7NFjXvhIMGPNky
	Ww8/Y4kO7OhHvQ/q8aojfSNGaPq9hqZyVU6Ao1OcLETWDEK98oLH67QrEb+NJX1Z
	98et+HuSOPXaLObcZil6/dLZnpO0zTmJhjxvkzV0zbcJG7h8GVlxJRT8JthSfmbw
	qtMCgeHglUS0RXjm7GE9aUuYEzwXvDMtbCrWd5TlA2w0Oz5ZcSuuTN91AmppK52i
	BEbicUTY7Mv6PoLzzDKgu/BXDRGx7Uzlws9lJZsAtoGa8IacA6N1uQAZHmztvFCz
	c+QobiZm4+/tbBSaIU5aJY7lFmPVzHzWyVtjiTBVdyi2XZnk5Nvu7AdYAdpi0N+K
	LFf5gw==
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct477g68r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 20:16:21 +0000 (GMT)
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67bb77eb9f8so11262035eaf.1
        for <linux-wireless@vger.kernel.org>; Mon, 09 Mar 2026 13:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773087381; x=1773692181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1W/57dKEbvgDKZIHUNPuGulUAs5FFvgypvGnAL2PC1A=;
        b=R5GCgnZLRzTLiuXfmzxMvL2V1HMJpLjk4BtBatNHqEDDomm4hm0W6Npkx11XsHgcBP
         xo3leyDqXwCX7N29WmFpYpaWH2WGzk9kMxm41uekr7I5e11hD8wh+h4quQxuNMgWJ56s
         PYl8nXAzwAgC4o0fo/HpTwLq+a9bPUA8xjcD9yVgGXQTxzKFycdU6QpfLd2j1TZz8hoj
         X1QMaxiaTSiTvqdv9eNCcj1DiaAXwE+fP1jPpvDiVBkpaQ2iI5WzBdQ4XrATGBKWntLp
         kwczm7ie97ZPhFV75jimb5WGtfQK01dzHF/vd8Vl+UDAc3Vfiuh2FeHkwQ77T0+pTL1l
         zH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773087381; x=1773692181;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1W/57dKEbvgDKZIHUNPuGulUAs5FFvgypvGnAL2PC1A=;
        b=VlbckBzYhWbls8CBUI5d8fkUo78aIIeVKTDfPvNuNZssdLFQLhg3m5iz2ChpVzsAGM
         wDByX316mXuzHvDKXL2JstExGAlOOuPpWL2RsJtSt/0z87t2nRgNLKxrBmCgBqly0MN1
         /keBeODxq9IhUAmE6/uUAI0hmjejEjIZH38YefK4TZDMigPD1pgPq5v9zdjITlzXZzyo
         gpDgHo/JK4MpfiI0OBtLXvsgssnu0kakhROHbDLaDrV18tItilBSt2+idTTWIYCR47jd
         vGuGAMJhboLZpjgWy7O4WSJ3UbPx2gYIiSO/ObuMYd5ThND1jwayAGKxi0vlcqOLpqp7
         rofQ==
X-Gm-Message-State: AOJu0Yz2YjSGwue0TtQpNhwifZWeFrfe6H+JqVe796S59ekyUNrTOkFW
	FKk0krm428IEv7G8M+DT6td+ZUJWHH9cl149gvqeW+8k1QwuPErISCE6XsPIBQ3gWfaT+MN35Iz
	uVONM+g9zNdld010MjVnD66Liw5LcZVNFQohIqlxmb1ogP0spoXmKo0l01x4Dip6/Rysv+puViX
	w4RQ==
X-Gm-Gg: ATEYQzzLI7z75k4bXC4ihww1s4jqkRssZ+ar92k4QfHuBIOXe+r6e934nIu0ZTsFXay
	sr96iLwPBtUN/GIIfPEFZg5dh0wJ3vppTjiwr1vhID3oxsHlUZjXZOoGjvuNybVp28FVZf27lS/
	0oDUJKVcPxpVo9Jzr8H9im4zNnGIBLLcoYuYuIUxLUJtI59YANVOS2O0urYsaYKWKqea586NbBW
	ZD6bMqFknm1bwvlssA/ofRSl0dNRIMIN8Dp31YUJ148e1Pc3zx96uHam12smMyXoMH4h+mYY5ht
	JIeROid23z88LO5FcNRTnaiH1AMGuC2gUWzsD/dWJug6aIL7y3scLRQZ5nRehLczwYpAL56BKNy
	8HOL5rFvvouM0urPtPe9aso5ym71lgoKV3FGQCST+BudyoEp+vIWIXT28MmpQbgIwutFosNpyfS
	cCO+p5qd7xLfkGCA==
X-Received: by 2002:a4a:e909:0:b0:67b:bb4e:4a16 with SMTP id 006d021491bc7-67bbb4e5f8amr990091eaf.37.1773087380948;
        Mon, 09 Mar 2026 13:16:20 -0700 (PDT)
X-Received: by 2002:a4a:e909:0:b0:67b:bb4e:4a16 with SMTP id 006d021491bc7-67bbb4e5f8amr990063eaf.37.1773087380461;
        Mon, 09 Mar 2026 13:16:20 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb0085724sm3554991eaf.3.2026.03.09.13.16.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 13:16:19 -0700 (PDT)
Message-ID: <621ab5fd-206d-4cf9-b30d-cb9d6bc0459b@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 13:16:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid dynamic alloc when parsing
 wmi tb
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260309152050.191820-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260309152050.191820-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4MCBTYWx0ZWRfX3SaHTWcQb4XP
 gYVWx39evAzi/V6tuAO97BnHuhzV9dZXOV0ixR5YiDZrMyBGA8S+TmVkYL+wXBute2npF1SPp/a
 rRcapDCrq/4dB1e3ypTlGNp0zynv5Vlrr8gJLfWU0fNuf+QXuxmAFphiK7xonfk+as1uNmVrEo3
 zactWd69dP+5Lg21akjVJTtAVyJI+/yZ/z6iwNeYYXOS1ONx3mwgSkvFKyR3AgyxxJmdNa9f7w6
 xnC5FjR4wXGSjJHdpNS3bkt7qL2eBuBT2Nz3Nvxz1KUfst+B0hBgkHhYsy+wI8DkTFzKK57abJW
 VgqdknykfGFoC4B50AajUunVcboVns7v8XjTMEb3UtFE1E7mrNEJQP4uU0JtdIFoa3umYbJvsg2
 Rmln7CvZrwo0hImkUXSeOaLO0b3NLrUEn8ycvVNAQBbW7MCPt9oBbahLxnkMA2Vwl9AXmS7HPrj
 X4kOxJ019Z4YIZLdpEA==
X-Proofpoint-GUID: acGwz5TMikKTW83Fn-8-fTYltwtWGeV2
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69af2a95 cx=c_pps
 a=lVi5GcDxkcJcfCmEjVJoaw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=uZB4Gw5mc7jQY1ITqb4A:9 a=QEXdDO2ut3YA:10
 a=rBiNkAWo9uy_4UTK5NWh:22
X-Proofpoint-ORIG-GUID: acGwz5TMikKTW83Fn-8-fTYltwtWGeV2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090180
X-Rspamd-Queue-Id: 05EA0240C4A
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32775-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/9/2026 8:20 AM, Nicolas Escande wrote:

I have some nit comments...

> On each WMI message received from the hardware, we alloc a temporary array

note that not every WMI message handler uses this pattern.

> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. This
> alloc can fail when memory pressure in the system is high enough.
> 
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time

add hard stop .

> 
> So instead lets move to a per cpu allocated array, stored in the struct
> ath12k_base, that is reused accros calls. The ath12k_wmi_tlv_parse_alloc()

s/accros/across/

> is also renamed into / merged with ath12k_wmi_tlv_parse() as it no longer
> allocs memory but returns the existing per-cpu one.

note that imperative voice is preferred.

> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00218-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> changes from RFC:
>   - rebased on ath-next 8e0ab5b9adb7
>   - converted missing call sites ath12k_wmi_obss_color_collision_event()
>     & ath12k_wmi_pdev_temperature_event()
>   - changed alloc order & cleanup path in ath12k_core_alloc() as it seems
>     it confused people
>   - used sizeof(*tb) in ath12k_wmi_tlv_parse()
> 
> Note I did try to move to a DEFINE_PER_CPU() allocated array but the module
> loader complained about the array size. So I stuck to the per ab alloc. 
> ---
>  drivers/net/wireless/ath/ath12k/core.c |   7 +
>  drivers/net/wireless/ath/ath12k/core.h |   2 +
>  drivers/net/wireless/ath/ath12k/wmi.c  | 178 ++++++-------------------
>  3 files changed, 51 insertions(+), 136 deletions(-)
...
> @@ -3913,7 +3903,7 @@ ath12k_wmi_obss_color_collision_event(struct ath12k_base *ab, struct sk_buff *sk
>  	u32 vdev_id, evt_type;
>  	u64 bitmap;
>  
> -	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
> +	const void **tb = ath12k_wmi_tlv_parse(ab, skb);

checkpatch complains:
Missing a blank line after declarations

Note that when __free() is used that this rule is not enforced since __free()
declarations should appear at first use

So I'd separate the declaration of tb from the assignment to be aligned with
all the other WMI functions

>  	if (IS_ERR(tb)) {
>  		ath12k_warn(ab, "failed to parse OBSS color collision tlv %ld\n",
>  			    PTR_ERR(tb));

that's it for the nits. the development is stress testing the functionality.

/jeff

