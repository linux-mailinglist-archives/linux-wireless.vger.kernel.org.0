Return-Path: <linux-wireless+bounces-31989-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hD4IJ+FWlmkzeAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31989-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:18:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EC815B18A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64EA03006B60
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 00:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0D1A9F8D;
	Thu, 19 Feb 2026 00:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvXG60bx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EoVv67TD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356914A4F9
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 00:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771460318; cv=none; b=QCmPWfyEwud9O/HbaloiUgZ8bV3EHjkoUYRwHNyDUN6U7cO9iMHvemKSrY4ZvV7AwOJQ6WvsMBqyOqsvNz9cazv3hFapWcmZEkqD4Z3l3ph9AAhCyrjtbd0ZTEHM7MRZLAxsJQU6lb9/BPFm8Suy7WFYtoq929SfMD7UseTsGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771460318; c=relaxed/simple;
	bh=yX58FE41c/ilP+wBoKhqYAK/S3q8rJQbjLJSPC8DJQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pD+vwaXmOvHared2CMMo62kz34ysdztXS67Tt20Iz5NH2zaG7NAqceNV2VzFnT68m+CGvdc8cWV582kze5hMfu1rBNUb/kUGtNWPuAvNWoxmNV/ND0EV2orrbHG/jG9WdeW/Ans5eijFRoBRu5xYehXEWEjUy0vptY8vqCxMCuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvXG60bx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EoVv67TD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61INlfX11924961
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 00:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VXIKfQNG9TrKEgU99HqIDj1sC/EgfQBOZENx2xktZTU=; b=FvXG60bxmkD/dPLI
	vGJrGFpo8R4nuvHrvE8g15jwPilGDG3QnWKy4sbJ+w22k3nKhZg/B4qNK7HP0epa
	i28tuXGgnyN4fr1zrRB+NyFFtLeRLXULXCfbDhFhutPDRvlnWUlKuQmER6TZnNMO
	YKLyKLzXWCJh68z04TBddVXDz1eAX7bwq8GCw/GLINTGTnDF4ORK1tVYZe6K9yXc
	mm24VjqA3Wcc9zv3RAb3IGXpybAqIWAw2ZI8WCSfriL+h5cbVrfQvVbht3yqowHG
	whkYx265eMmy72HvXnhn9BN3n4SpNIjVWP0KOOc4BK3JW6dhIZTHvqb5QGn0Ptfh
	TTX0Kw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cdqdg81ry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 00:18:36 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1275c2ae713so12090174c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 16:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771460316; x=1772065116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXIKfQNG9TrKEgU99HqIDj1sC/EgfQBOZENx2xktZTU=;
        b=EoVv67TDmEs3jh+boQ/WV9/BwoU4oOmmg2zI6HXk3sSEXGmQz22CxxEOzp1h+bWq+o
         7Ez1Zbl0CrRdemyOerGTpQdBULdGja2jcADwsVF7cOil5BuS0tFfZalY7tKzh9z82gju
         pKTNtpaKx6wtdUgP8crag5r9he39zND2lM4hOBxjlXH8kVxWr01aWCjI6HIKGjIDSHih
         xmZKJzXeLhJEoWfJzTHc3IvU5kGTcef2mNL+1VZ/mhKqnFXRz5YRdZYQfdywGyHmTeYO
         Bg58zCrQhT7ByAa81FtopFj20CesjDj5ZrX/C3bdvtrMlhXLk1Cq2K8G87pEE/RxPc3q
         Uw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771460316; x=1772065116;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VXIKfQNG9TrKEgU99HqIDj1sC/EgfQBOZENx2xktZTU=;
        b=fHKsKuYlIRlc5SzG/lmSVpqY9vGNq7upm1pijycha2mIUPCKJpwYXRICyhovwk79Ph
         OdrY5ql3Gq6E44uHB8rSGpn80RK2imF9ukZxizpni8wPXssZUzZPSRcr69cKmp69mtNl
         R2mnXk99OBz3fMPeh0DasUqbDjhMngxwrRniXHTOqh98r8L+vh6xfRONPtS612laVUDZ
         ekGpcTQGhrPnTMfmpeQmF+krZFNbxirVnHAoGEvzpeFpfU9+xAsV/C3gAofutcr/bVsn
         2B7x3oXmNVZC3F3hdGknU/zbVp/zvQU5Ldl1qC73TwHFH3P7eJPvkSNZzNZ/crMmNxj8
         vKQw==
X-Gm-Message-State: AOJu0Yw4Gm258DBlQzbv0PRO7MclE5ndbZisODnugclFzZ+rWE7HrX8D
	whoyxxmNw8visL3nZT3mR0RtPHxP1/oqdrGuDfyB6n8HyHOqDDIT+7fDKOEec0rjA6Hiyo/X/Mt
	vqHOuPBT0r+99ydbSDMYOGpSPEq4IQBSE4+jeUwa6h6xx53j+OJkSgfzydn20+TX6TYTO9nEOf9
	e5Dw==
X-Gm-Gg: AZuq6aLjtmzPgiS/bthaaPnqQOi8WE3JxhWY3KU8FieGekQvjegfSsZucJ1w2pVzOdO
	t3SyqNaNl3DC75tsaHYIQsJ6s2f2/yvVqzbh3UVol19GjwXXq74yMlyJFZWWCxdla6HWVpz3V3P
	HPzli6Zl9v/UiI3Tyc/2Z26PuPLqTsb0HGjClQzbgcccBWEGUMj1v5wCSnDotj91oNTYE0+7Gee
	0j+ExjkLBqcTQbgQWqJ4FHxf0iK4T1n36HRxIZWOoLli3j5vXJEE0n2LZXswBperO0iRQU4zPsc
	+y0iHxGtgvCfittM5+Rfc/E0sQDxJOtZYMSnUlqIpgqSunJn8VjaSQ6N5j/oKX4Ck0xnNYW/Nse
	DOpTDW4bygGw1ct8OXsg3d4WloECsyckLIqnshtNz10DX3rBmy8mfT2d6cFyIXqi1715nJSzCjG
	YNwpmRcJRKj57uDw==
X-Received: by 2002:a05:7022:4a3:b0:121:9f05:7e4c with SMTP id a92af1059eb24-1273addcd33mr9051071c88.16.1771460315809;
        Wed, 18 Feb 2026 16:18:35 -0800 (PST)
X-Received: by 2002:a05:7022:4a3:b0:121:9f05:7e4c with SMTP id a92af1059eb24-1273addcd33mr9051060c88.16.1771460315217;
        Wed, 18 Feb 2026 16:18:35 -0800 (PST)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cadb25sm25643780c88.10.2026.02.18.16.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 16:18:34 -0800 (PST)
Message-ID: <d2a02b4c-5f69-4f5e-bc0e-428b64e99d36@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 16:18:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: ath6kl: wmi: Avoid
 -Wflex-array-member-not-at-end warning
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <quic_kvalo@quicinc.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <aZP4RI-uN2001cBh@kspp>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aZP4RI-uN2001cBh@kspp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CIZpgjEilkUk8agMGJhwXhrEObUaBIjM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDAwMSBTYWx0ZWRfX4aseYM80mHFp
 reD5rMtnrHCMQ6wMvN1PlX6p6NHN6OzjzB3D6HjVU070pKK3PG2g4AMz/WxtHwc+gIegg7neFAK
 XGN89ouZ7VCTFkPLGtkjsuwfWVC3qgNPVdz12qqtLMux6LYCcFLZYNTGBBYx4IyvDYNcRR4flbb
 /0qJQE2XMpNWChDbGAfy3mtDsD2Or3Te63aahWa1SEqYaKCNFWNK/1d4Q9M5QRx65+hzMHas7/H
 BVSnGfyVV8AmsyAbDLg6gzLR5JBMjawRnGE1Ciup2FFm1O+pjHFARu44fHf2QGE7jge00KP75Sj
 JVt4N/VXm2nvhmyH3nodHZKo1GZXcLaotr1IzH1qxyeMxQJ2Bbk10/v0NZt2JX2fgzZMnUPUhpB
 u8bMElb/xKYJMgWjMhhhy+Hgy8zpz4CBunFxcMAy4oq9+TilgRmY3DzdPrS60aubB60PPfOO/QI
 cASBEKeyE7uDoml+cqw==
X-Proofpoint-GUID: CIZpgjEilkUk8agMGJhwXhrEObUaBIjM
X-Authority-Analysis: v=2.4 cv=W/M1lBWk c=1 sm=1 tr=0 ts=699656dc cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=za3tAlzF_62g-CIsXx4A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_05,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190001
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31989-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 36EC815B18A
X-Rspamd-Action: no action

On 2/16/2026 9:10 PM, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> struct bss_bias_info is a flexible structure, this is a structure
> that contains a flexible-array member (struct bss_bias bss_bias[]).
> 
> Since struct roam_ctrl_cmd is defined by hardware, we create the new
> struct bss_bias_info_hdr type, and use it to replace the object type
> causing trouble in struct roam_ctrl_cmd, namely struct bss_bias_info.
> 
> Also, once -fms-extensions is enabled, we can use transparent struct
> members in struct bss_bias_info.
> 
> Notice that the newly created type does not contain the flex-array
> member `bss_bias`, which is the object causing the -Wfamnae warning.
> 
> After these changes, the size of struct roam_ctrl_cmd, along
> with its member's offsets remain the same, hence the memory layout
> doesn't change:
> 
> Before changes:
> struct roam_ctrl_cmd {
> 	union {
> 		u8                 bssid[6];             /*     0     6 */
> 		u8                 roam_mode;            /*     0     1 */
> 		struct bss_bias_info bss;            	 /*     0     1 */
> 		struct low_rssi_scan_params params;      /*     0     8 */
> 	} info;                                          /*     0     8 */
> 	u8                         roam_ctrl;            /*     8     1 */
> 
> 	/* size: 9, cachelines: 1, members: 2 */
> 	/* last cacheline: 9 bytes */
> } __attribute__((__packed__));
> 
> After changes:
> struct roam_ctrl_cmd {
> 	union {
> 		u8                 bssid[6];             /*     0     6 */
> 		u8                 roam_mode;            /*     0     1 */
> 		struct bss_bias_info_hdr bss;            /*     0     1 */
> 		struct low_rssi_scan_params params;      /*     0     8 */
> 	} info;                                          /*     0     8 */
> 	u8                         roam_ctrl;            /*     8     1 */
> 
> 	/* size: 9, cachelines: 1, members: 2 */
> 	/* last cacheline: 9 bytes */
> } __attribute__((__packed__));
> 
> With these changes fix the following warning:
> 
> drivers/net/wireless/ath/ath6kl/wmi.h:1658:20: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Create new separate struct bss_bias_info_hdr, and use
>    transparent struct members (in struct bss_bias_info)
>    instead of rearranging members in struct roam_ctrl_cmd.
>  - Update subject line - Add 'wifi:' prefix.
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aR153k4ExCD-QTMq@kspp/
> 
>  drivers/net/wireless/ath/ath6kl/wmi.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
> index 3080d82e25cc..d2a5c96fc878 100644
> --- a/drivers/net/wireless/ath/ath6kl/wmi.h
> +++ b/drivers/net/wireless/ath/ath6kl/wmi.h
> @@ -1635,8 +1635,12 @@ struct bss_bias {
>  	s8 bias;
>  } __packed;
>  
> -struct bss_bias_info {
> +struct bss_bias_info_hdr {
>  	u8 num_bss;
> +} __packed;
> +
> +struct bss_bias_info {
> +	struct bss_bias_info_hdr;
>  	struct bss_bias bss_bias[];
>  } __packed;
>  
> @@ -1652,7 +1656,7 @@ struct roam_ctrl_cmd {
>  	union {
>  		u8 bssid[ETH_ALEN]; /* WMI_FORCE_ROAM */
>  		u8 roam_mode; /* WMI_SET_ROAM_MODE */
> -		struct bss_bias_info bss; /* WMI_SET_HOST_BIAS */
> +		struct bss_bias_info_hdr bss; /* WMI_SET_HOST_BIAS */
>  		struct low_rssi_scan_params params; /* WMI_SET_LRSSI_SCAN_PARAMS
>  						     */
>  	} __packed info;

That bss member appears to be completely unused
(bssid, roam_mode, and params are used)

So IMO the better solution is to remove bss from the union.
And I think struct bss_bias and struct bss_bias_info can also be removed.

/jeff





