Return-Path: <linux-wireless+bounces-33489-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHGHGuoevGkvswIAu9opvQ
	(envelope-from <linux-wireless+bounces-33489-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 17:06:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B62CE55C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D04F323EC86
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559D3ED5CF;
	Thu, 19 Mar 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KaMasR3p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JALpFoqP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2B3E9F8E
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935973; cv=none; b=ClT5wZZX7v03n6FPIHd//+FTd/ZW/QGkV6ZQ9cG84S5HpTPtZDXFFM9ZwaixXyl6bb6mMOc1wX3dQ0RvtMX3VSRpGJKTyZTvMNeZgG43XVd2IcY8jAPCPkKPu79HpU4JGhAp+ySzVLpzbW42tGRUKDyzfoHcvEon5Tvlwm/114Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935973; c=relaxed/simple;
	bh=x0GE1uC16PjHA6HJcwlcjhKUrNO1HxlejpfXdFaDIl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cBwGfeLfDV7ths5Y/YARaIFdfWtvtVZJxfmA9hwI9y2fv9JT199cXdi8fZWw/dcPnzWWsa+f7F2AkCJrQcoCGQZyPVALbDteXfdaJMfM/AbGRVluyVPi1cQlLEWjtZFgtrvxrIQ6DAV26bbCi1SdxyKCZCOb/8w7xVJSqSmdR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KaMasR3p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JALpFoqP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JFMZNP3368471
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 15:59:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5xCbyQSap6HnQiTqADbpDYYWdan8jqhSsfZUALvuHDE=; b=KaMasR3pYAaIoyg+
	OmotS48Rf/8vJSAx2yNefUzAXbeb94rqezeC6UEFk6wPBaCw8NXDat5nqOCceRk4
	lau/UXuulEfmYxfkW69bIdM20Om9vHsdMmCu88h8q0+9ONbqWPacV91xTG+iGbdC
	bLn8Dv0x+NtJ2Yr/Uh+W6iPn1Chgzi3fvHCEJHJmSq0lctcR9HOjOtfmPUTWtfV2
	P6QuLjgNAiUUD3ufd464O3tWUfQZtxlCcUMxznQTpmGC+DCLDnMw/8Nwbo0pmz4m
	Bubbxxt0HOn8JQ3LyxsCqoqb19BvxroLAtLDuWCqiWjOWaTz36BcwTH+kPvWWOPe
	VKWn7A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00f9ktq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 15:59:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2c0ffce2570so18140775eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Mar 2026 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773935969; x=1774540769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5xCbyQSap6HnQiTqADbpDYYWdan8jqhSsfZUALvuHDE=;
        b=JALpFoqPSMrlKA9Ze7WReXqNNtL5XOr7UYpDBvcyWA5msqltYn0mAs1oNUIb/NStQw
         OjwBi3KjDXFLT+TcB6Kid1Y2nZAsc2SL5ZmGZYM+vZMTYcwWGO6rBld6Mq0q2r9tc51P
         bQwfgwfgtpNWkxuUIzBwF7Z37wMc5eucMuUHvPVAx/OjD74TxVQX3mFmdmxsHV/405DO
         J6za156EF/sqC7vZlSAvr51QhYNRkjINpnLGxBCa663NaQY8SKt3yzvW2gBRU5DuEH7D
         drKh6yXniK4OLKCE+qJ8e4v3YpZp2MLv5PZoT0NG5k5l7XfvBSZ8eS6A5JFR6vRcmDq+
         tK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935969; x=1774540769;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xCbyQSap6HnQiTqADbpDYYWdan8jqhSsfZUALvuHDE=;
        b=er9R3GW7J58SSp3EGy2Acmso2gHQtEnF65X1j3h/LTitVZqrtBppVchm9yjPTRByCr
         AFBz2h5Rih2ZidURfXcP7slnON7MPxGD8PPgYniJsL1iolcXuZ6w6V3NnRbr3U/vCRJw
         rROdL5k0CnWj2QFmFXRyB0LJoX0goqeyGQGhVuUKRPED7zJzLCvHp7cKRM4Lmo52FAWe
         G+k7I7s/MtEE4JspUrXDBPPVrkKww9JXkkO+D5Tgzs5z7sFDdFMlo6d+qzSFthm/z3CK
         YtOabz45+cVX+26TojWBhZwKqaq0Jm7F6O1MbDPJMZjgKlaxhh3wHGRsaS3F5GOElP7l
         WFvw==
X-Gm-Message-State: AOJu0Yx3mENTgFTphBW79z5ZaF8vzOIbr1lu9C9Rlb5KZL57W9GJGeWD
	IMz30qCBNaDZBzDVM35g82zDQ0JHbJ4+7FptDJbsooA+0WxYlBPBzguySfg7wG+v+FI22ekRwCl
	zzhtgH12d2OdrQ1VXHY94FpAkektpGwFVOyAqK/Vnix2YTQntMSHr7mVUi6V0koefMFg07Q==
X-Gm-Gg: ATEYQzy/Ods1i4xVvPkdzZaN+WaAhEovtEN10wzdHnoYxOWHVswDdZtHPjtjJStQMKP
	WIQdgzLsajphdGlIX6J7bYg9hO0dKow8NV+nq9A3jGz6cXWy4ElpRDOPmU4wicxxQCKBoZCfwvE
	N4SIPfQLexSXdAcrZb7keFSY3xtV1L7MClnveh3rL8NaY15a2808uWaEaB28Cz7e+j6himkKIDo
	UvJ+DUSlBp97obt1cvQsiYxuZop43uNp/4i8hEal0r1tjLSIMt0tzRv7kTKIlOeeR410vkFcUgg
	aBPPrf3wjxaKoNExLs6z5dZUZV6CrnMactB9VZslB4qj2sVurKYCDBR/5shlbjWgVdOC5bkF1Th
	TCDHjYindF7JkoQRaC/OFNW5tfJGBzghM4PYuIea/A0ux+ziAWsnRH0s/OCvl1h2+KebKYb+9L8
	gT7wMwrBpa2usb8Q==
X-Received: by 2002:a05:7300:dc87:b0:2be:6f6:a39f with SMTP id 5a478bee46e88-2c0e5041c76mr3765204eec.26.1773935969214;
        Thu, 19 Mar 2026 08:59:29 -0700 (PDT)
X-Received: by 2002:a05:7300:dc87:b0:2be:6f6:a39f with SMTP id 5a478bee46e88-2c0e5041c76mr3765186eec.26.1773935968309;
        Thu, 19 Mar 2026 08:59:28 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e5368a7fsm12276871eec.1.2026.03.19.08.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 08:59:27 -0700 (PDT)
Message-ID: <40756be1-6a9a-4821-8c90-34f37db01e8b@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 08:59:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
To: Nicolas Escande <nico.escande@gmail.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260317084740.3756880-1-nico.escande@gmail.com>
 <36c1cae8-d6c0-4432-bc8e-57216c5ea3fd@oss.qualcomm.com>
 <DH6U1JMUQXVM.287BFERLLK9KK@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <DH6U1JMUQXVM.287BFERLLK9KK@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyNiBTYWx0ZWRfX/dH10+suFpYX
 KylYs4h+eFbGo78xILVntqrm0QPhi7VH9+AwORGOJPpUH+28SEr14bhjs+VHHTelJL8C1H2pVDx
 j0baIZTEUj5+qNXnmCz24dQ/NgvnfHSDTTeokKzSGpm6I+fWB6trryFhzH52p3hhcyyCOCAxXfN
 PxvjaZzh3X3LonX6vfSCkgMO47o6U5AlmeWiM04+BouQ34HEd9ow+7VdzUlzoJ2ET5cSr7UjG78
 gCb1rMJJXDx6xGg+tR0JebpK/VJ/PrLa48AOQgbyh3zV9pZq7ICb/uskNdwpnyr2PsVsMHNmz2U
 1qEBZHfbw96KOP2na40+898mkeahNkKuWZeCw6+fu9oUG1oEmVjs39zTgri+3EeKppp/Lq62tLZ
 Hu+tJyXGFP+Pt0eBZus8IuPmEH/pGP47TqGAP5MncetFcM9Y4bq91kJve/Ycr9tCIktaADwfrCh
 L7r3YagHRYynNWcl0oQ==
X-Proofpoint-GUID: HCKJCqEYXf0H5J5SeLu_-DlG5Rj7fPEU
X-Proofpoint-ORIG-GUID: HCKJCqEYXf0H5J5SeLu_-DlG5Rj7fPEU
X-Authority-Analysis: v=2.4 cv=MJttWcZl c=1 sm=1 tr=0 ts=69bc1d62 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=Lvwhq10UT3ZPFF2kUnIA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190126
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-33489-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B21B62CE55C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/19/2026 7:35 AM, Nicolas Escande wrote:
> On Thu Mar 19, 2026 at 12:08 PM CET, Rameshkumar Sundaram wrote:
>>
>> Since CONFIG_ATH12K is tristate, a built-in boot can continue past a 
>> failed ath12k_init() and still run ath12k_wifi7_init().
>>
> I genuinely thought the kernel prevented this. I was wrong.
> 
>> Please ensure that later initialization path is guarded against 
>> allocation failure.
>>
> I can add a flag like so to be able to check from ath12k_wifi7_init() if the
> init finished ok. Something in the lines of
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 6c034071cc6d..742fb33f41ff 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -34,6 +34,9 @@ module_param_named(ftm_mode, ath12k_ftm_mode, bool, 0444);
>  MODULE_PARM_DESC(ftm_mode, "Boots up in factory test mode");
>  EXPORT_SYMBOL(ath12k_ftm_mode);
>  
> +bool ath12k_init_ok = false;
> +EXPORT_SYMBOL(ath12k_init_ok);
> +
>  /* protected with ath12k_hw_group_mutex */
>  static struct list_head ath12k_hw_group_list = LIST_HEAD_INIT(ath12k_hw_group_list);
>  
> @@ -2323,7 +2326,14 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>  
>  static int ath12k_init(void)
>  {
> -	return ath12k_wmi_alloc();
> +	int ret;
> +
> +	ret = ath12k_wmi_alloc();
> +	if (ret)
> +		return -ENOMEM;
> +
> +	ath12k_init_ok = true;
> +	return 0;
>  }
>  
>  static void ath12k_exit(void)
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 59c193b24764..f35571b1a541 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -101,6 +101,8 @@ enum ath12k_crypt_mode {
>  	ATH12K_CRYPT_MODE_SW,
>  };
>  
> +extern bool ath12k_init_ok;
> +
>  static inline enum wme_ac ath12k_tid_to_ac(u32 tid)
>  {
>  	return (((tid == 0) || (tid == 3)) ? WME_AC_BE :
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/core.c b/drivers/net/wireless/ath/ath12k/wifi7/core.c
> index a02c57acf137..542ec10fabf1 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/core.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/core.c
> @@ -38,6 +38,9 @@ void ath12k_wifi7_arch_deinit(struct ath12k_base *ab)
>  
>  static int ath12k_wifi7_init(void)
>  {
> +	if (!ath12k_init_ok)
> +		return -ENOTSUPP;
> +
>  	ahb_err = ath12k_wifi7_ahb_init();
>  	if (ahb_err)
>  		pr_warn("Failed to initialize ath12k Wi-Fi 7 AHB device: %d\n",
> 
> 
> I don't like it much but it is easy enough.
> But I don't know if there is a more idiomatic way of doing things

I'd prefer to expose a function rather than a global variable.
In other words keep the flag static, and expose a function that returns the
value of the flag, i.e.:

bool ath12k_core_initialized(void)
{
	return ath12k_init_ok;
}
EXPORT_SYMBOL(ath12k_core_initialized);

> 
>> Or may be have this allocated on first device probe and free it on last 
>> device deinit ?
> 
> That seems even more involved. It would be easier to go back to the previous
> version and simply, alloc it once per ath12k_base
> 
> What do you guys think ?
> 

Going back to that may be the better solution. It isn't nice that this current
solution may allocate memory when the driver isn't actually used. But I'll let
others on the team weigh in as well.

/jeff

