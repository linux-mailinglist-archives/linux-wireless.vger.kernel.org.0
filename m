Return-Path: <linux-wireless+bounces-31685-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MVT0D6fCiml7NgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31685-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 06:31:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9321171D2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 06:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1CE43006837
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 05:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA4257851;
	Tue, 10 Feb 2026 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ce+gIzrD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HL3GpRTv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4982B9B7
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 05:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770701473; cv=none; b=TbFUw/t3TYamC3DsxasrLCPKfbOIu37CJLMVhlVShRetST3hAuRNxs3RvK7wpFM/ttmVUrGt6xWQNy6K+hKv01B4fiFopz6cMkWP61/JEUCGQSFeLTcLlDVicUejKrrabmad/J8EBdO6IMGb1eHoHySxuITKGfZ8yiDFzKE/5g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770701473; c=relaxed/simple;
	bh=sIff5O+HUil5i3tVw3yYshIEElHdG4ZEtb6Md5nky38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mtGAYQlDAxbV+99PwN/rjrnzTky8EDSM2no2IDYKtRKdjFWUT0zRdXIldC3l0NUqq+wE2QrJNrgMALVJyvwD2lbtjoQUMRdvmaj60gS1zFvfcNuQ50bUSC/cR1VFgH+yDooHn4ZZQ128p4QZhHh1FOKB4yRu4rxLWf6HVzbDaxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ce+gIzrD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HL3GpRTv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A57WF03699994
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 05:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YuX88TmKTlybTx4SXCqbtswQPc4muScB6Wf5dRVF0+A=; b=ce+gIzrD5RMB/eya
	SIChmwwA+xZzloGXMfBZfHt0W0NHqX8PtBFPHKqa4laTBwGnIVn8uiiIFNTLRgP+
	5mFu3g2CL9niTIXw6NgF4qaEBMoC4qiEUYxSvNXKr4fRg3td9PuxV4tJU0JltJRl
	Ya9GUUlgTRiGLcFgneuEpDRtIfKP1zcNq2zdleDe+C5Bo2f1PA+03pPSLvLc94kQ
	6EN8KPu2SE3rORPM+EXp6AwzsflT6/jIa1IjU5jEDbCf74ntccFcWLWs5sRAz+EL
	enr1hlxu5gpUJu51f2AL5xQahD8FxmnfK69Gzzt4TL/TzQtyJP4juNx9o+W8063b
	XD0mEw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e4mbbkm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 05:31:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a755a780caso50987565ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 21:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770701471; x=1771306271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuX88TmKTlybTx4SXCqbtswQPc4muScB6Wf5dRVF0+A=;
        b=HL3GpRTvdr9sDZFqLZuTKCk+TSgNexrMNi8Q4wKrIenA2Be8X+UPDOevaFCPzXnK2c
         X1i1MYkZyphcy/M6BPjMARVldZuS6R9LhnxN5a72EOpnyC7RWIStzmqwNNYSVd1Nyt6y
         3LQ2QFZPx/xQsKE4Wl0onap6/XQ+zHrvHMwuEIaIFLhusyysapTsv1LLfez6ztK3j+l8
         gLIOXpvvawP9rRjlBZEbK7JXPJE/UOha+B7b54AOn1rP11LhEdJRAY4uS+wKFC4dz6BH
         OAZ2g9+uPjDuMyHECYUxKnVbVOslHK/u5DN0J2LVof2XASqN3nDtGIvM3XS0CFqpgHfU
         K0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770701471; x=1771306271;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuX88TmKTlybTx4SXCqbtswQPc4muScB6Wf5dRVF0+A=;
        b=vJBuK7kzQr6kBIDv4aUl24/Vx4uiMf/Ph0wBj1RnNzXGqB6SslPtzXe6FwtxGDmjsh
         HzPMNTbuhqnxq0u18c/w4+Z26KX/2xInbh0N7ddwZPmIDsAXimM19iywvOulHxhlxM26
         hmS5BZGIDTHV/v68dBxudBPZtbKmFkZV3DfNEkdkDnS9eWEBfhlXNhxb7VaN/6fvV3Dl
         Uj0S43uXaNcOz2u2Zfvm6eO8Fu4d0yTLDPKKNI9KZNHIORXrEb28IZ417f0BbMCQny2x
         1reJPIIOqXsBbeQgId+FEAGF1RPpCUVnhoWVdXR2qhAkt6jZJTktVf2ZEQkN7dgvfsQ9
         gGyg==
X-Gm-Message-State: AOJu0Ywjno+hI2ZOw8Ovk/b8mjKc7O8OTyUS5/oL7VhuUTI/iAE5XKXm
	KkIOLsGgKlY7SgrBxtMSi4Ivf3XVw+Rbh5k96qaQP9Jlfh7Jf1Sx0L5+RNB5FkPrfCRETTgn8kX
	26PoJMNimmJokaTsVG1VrIB59XuXngOc2ERwvy3mR0g4upHOojcZzZydOTJY3HNtLVZSdtBnkNm
	I7vw==
X-Gm-Gg: AZuq6aLj47CEYuptyFFkoz74BMecmNnSmakJ+vQPwCzFrbstiYlELHeVEaq/Af23YWs
	DfkppX/b6Y0ZT2ddNwsF59aysr5hQoMzqpRJuZhQbA1xIv7i3TookOrdT1fAtU2N2i2lZISzg4B
	sa0FpF8Dfcv3qSG5MryostYvdmn73ZzF3Eayk8HhqgkvN9trAvnGqa1wfRNAzTsKB/Z2aQUqMxK
	I17ktHd0+NjNckk7h8vmegjsk4inMCQMNzXeRHgxHRYzIifqdGmJDaHvrYROKby4DMi65zm+VFe
	QJYjE2Y+p4fF1hJ/BJ8wUv6aq2KSI9Wd/6c/FA5+Bm/6Z8mu21dDdVk/hYu3ZDoJyXXu4alSLOf
	QulhISF0aVIosyONctQQpJ9DzjcuUzgCCaerp8RZO/FS1UFOl8qya4REcaUWQAyRSf69yljabXp
	z8LMZhpQi6W86/LY3ZyQ==
X-Received: by 2002:a17:903:11cc:b0:2a7:90f2:2ded with SMTP id d9443c01a7336-2ab100b947emr13753995ad.16.1770701470591;
        Mon, 09 Feb 2026 21:31:10 -0800 (PST)
X-Received: by 2002:a17:903:11cc:b0:2a7:90f2:2ded with SMTP id d9443c01a7336-2ab100b947emr13753475ad.16.1770701470115;
        Mon, 09 Feb 2026 21:31:10 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c50206sm118908485ad.19.2026.02.09.21.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 21:31:09 -0800 (PST)
Message-ID: <a434a83d-6f93-4103-a810-804caa4b7555@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 13:31:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 2/4] wifi: ath12k: avoid long fw_stats waits on
 vdev stats hot path
To: m.limarencko@yandex.ru, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260209030243.1530075-1-m.limarencko@yandex.ru>
 <20260209030243.1530075-3-m.limarencko@yandex.ru>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260209030243.1530075-3-m.limarencko@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: pbajlUtcYhj9k6I7fyiR9LUhe1uw8JQh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA0NCBTYWx0ZWRfX541EPnb3oBzm
 izE76hBiTozfLH7fZckgAM87Y2iW2l5MtUcAkL1GeDg4Wk4ika1TbQ+LNTvicw7/v6/OSPOAKIy
 op+Iqok6XB8GCbhZxAyI6tgZ0VsLLYrgJ40oIPYNwqQ1HeTTy9nCgTLlvRhvunHJiTjlpd7Xu3o
 c7EyY1nBJjTLSyLnNALg/ZygnKAsf0iik9Ef3Fo2fMFsof4d4mf6Awy4/56b7gdWMFKKXYAEpKe
 9MH7rJLHe+5mm4SdInOEpKmQj2RACwQ12LiVZeXtnMN9/VbbQHl6IewE7g5cg0ULO7EZ4Squ4zP
 pzrDp7szi+yHsgVccxGFss5ATxP5I2IHzVlAUetW8orKZJpWLc8Oaqsvrw77d5PDSCCa1MopRTj
 oUJCAhYsH68fB7i1WTFZgerhI/Dg7ICaiIxuhJKcd352MUBL4VrLBtEeSTjWxIxaxnZT+i5SNpL
 jLIh2VYI3BGyLC2S+AA==
X-Proofpoint-ORIG-GUID: pbajlUtcYhj9k6I7fyiR9LUhe1uw8JQh
X-Authority-Analysis: v=2.4 cv=WecBqkhX c=1 sm=1 tr=0 ts=698ac29f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vaJtXVxTAAAA:8 a=w32g7tGSt65Kz2FTHNQA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31685-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[yandex.ru,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5B9321171D2
X-Rspamd-Action: no action



On 2/9/2026 11:02 AM, m.limarencko@yandex.ru wrote:
> From: Mikhail Limarenko <m.limarencko@yandex.ru>
> 
> Station info requests can trigger frequent VDEV stat pulls from
> 
> user space (iw/NM polling).
> 
> On affected firmware, waiting 3 seconds for fw_stats_done causes
> 
> repeated stalls and visible hitches.
> 
> Use a short timeout for VDEV_STAT requests and skip unnecessary
> 
> waits for stats types that do not need completion
> 
> synchronization.


can you please try

https://lore.kernel.org/ath12k/20260129-ath12k-fw-stats-fixes-v1-0-55d66064f4d5@oss.qualcomm.com/


> 
> Tested-on: QCNFA765 (WCN785x), kernel 6.18.5+deb13-amd64
> Signed-off-by: Mikhail Limarenko <m.limarencko@yandex.ru>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 095b49a..1b550e9 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -4829,6 +4829,7 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
>  {
>  	struct ath12k_base *ab = ar->ab;
>  	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
> +	unsigned long done_timeout = 3 * HZ;
>  	unsigned long time_left;
>  	int ret;
>  
> @@ -4859,15 +4860,32 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
>  		return -ETIMEDOUT;
>  	}
>  
> +	/* VDEV stats are queried frequently from station info paths (e.g. iw/NM).
> +	 * On buggy firmware this path can timeout repeatedly and block callers for
> +	 * multiple seconds; keep the hot path responsive while preserving behavior
> +	 * for other stats types.
> +	 */
> +	if (param->stats_id & WMI_REQUEST_VDEV_STAT)
> +		done_timeout = msecs_to_jiffies(200);
> +
> +	/* Non-vdev/bcn stats are handled in a single event. */
> +	if (!(param->stats_id & (WMI_REQUEST_VDEV_STAT | WMI_REQUEST_BCN_STAT)))
> +		return 0;
> +
>  	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
>  	 * when stats data buffer limit is reached. fw_stats_complete
>  	 * is completed once host receives first event from firmware, but
>  	 * still there could be more events following. Below is to wait
>  	 * until firmware completes sending all the events.
>  	 */
> -	time_left = wait_for_completion_timeout(&ar->fw_stats_done, 3 * HZ);
> +	time_left = wait_for_completion_timeout(&ar->fw_stats_done, done_timeout);
>  	if (!time_left) {
> -		ath12k_warn(ab, "time out while waiting for fw stats done\n");
> +		if (param->stats_id & WMI_REQUEST_VDEV_STAT)
> +			ath12k_dbg(ab, ATH12K_DBG_WMI,
> +				   "time out while waiting for fw stats done (stats_id 0x%x)\n",
> +				   param->stats_id);
> +		else
> +			ath12k_warn(ab, "time out while waiting for fw stats done\n");
>  		return -ETIMEDOUT;
>  	}
>  


