Return-Path: <linux-wireless+bounces-32191-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPN5Mv6mn2mHdAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32191-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 02:50:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1888B19FF1A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 02:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A9BF30107FD
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 01:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02C337104C;
	Thu, 26 Feb 2026 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U95bGc8M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hzVHp4St"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879F0301708
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070632; cv=none; b=MXqPbjznMMwtyUla0xWmBTBZ2+udCbfdddioZGya5ojPUUVfsr1wktNKUl6C+c+3EzZtKkAVr+ShVVCf+Nlw+bp85/BUICaP7OW1kaF/DzG1QNl/j8xYhmko87BQvmfC2XlDeFd6ofGrEA0l4mmL9kiEVjoEEjX2NO28o/LoVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070632; c=relaxed/simple;
	bh=M6WPq7mZbqGsLt/EumgSldBrI+rZxWlATLbJnQ93Rss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkp7Hdm0XPFJioe8Pdg2VZaeoyblDt5tfypS8MEzHQw73V9EDaJDApVBMpJUESPC77WdwxMyMlpJguhLnKZWFveGcSDt0Hy34iR0YnR3cYdi23cesyOwvhpS835JFKTNuqpWbxBBjfh8BDqojIsnSiORycKxqxKqExuv1yqLfuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U95bGc8M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hzVHp4St; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PH3mH41195799
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 01:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oMgNABMClazAKP8Gmu/DAP8KsivDNJ19jCLyf5xAcXo=; b=U95bGc8Mvty1NG/K
	CZTWWvG+VRWlhTV6C0VMTsNezId1z78Wv4WHNmx3u8sb6S+8sgpg1T5aCISUlPLU
	H0hi0FSdElu8FpmvEq7shckpXqyxoXoUSZoQruAOlfjgWO/hRsxOEssKocJpTlkD
	v+QEz2e3OCst28VWZ1j/pwGQn40IP3DNp5Yj9TF/xJtHJxIfuDE7CCDTcwdHjnNV
	YfvllzzI+ELBpsE3lP9Y8g6/Y17AhGqcqqtibV85lAW2I+1Aepy/YgbsgRbHmGMS
	6WEjRhE4Lk1W70nEW8bulmv7DaQPOaHJtpT93+R8Vufdwu3UE/uXo22ZL+SBRzZq
	We608w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cj559hay1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 01:50:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adaa9c4b89so15057925ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 17:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772070630; x=1772675430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMgNABMClazAKP8Gmu/DAP8KsivDNJ19jCLyf5xAcXo=;
        b=hzVHp4StYKkZrTS90ze+v7vwfNMkbIFpRm0Q7TfRFYQoyfZmQ+gLThXQk7klfre7oD
         dB+JurM4CrWe0j5t8v9EOrzXuFFGezm6q0ROv1jhXaKy4TwRmpLcQNF+IG+RE9B9dcBl
         JP6+gso6PSF3xYJDIos1BU1w8bY0QEiwRzaSeczu2lxO3kRdT4khl+Zcq4TaHaa9oA2f
         XMQVYAZoXIQrX5fgHK6Zjiqh50D4v70RNFVrjk4T9NWMHV7GKbLcLRw7kpBvvECoOj4C
         nL1uyWbkZgTH2mSVqfRS2UPsIUSJ4XRnMFcDjkdPImjqWb/yAYWoPShax/ZnpnpK+0gA
         dQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772070630; x=1772675430;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMgNABMClazAKP8Gmu/DAP8KsivDNJ19jCLyf5xAcXo=;
        b=F0F+SQQIb3zcq0YL6DniT3q8JTgwWkTDvttPAjvhNqxf5JwW0w/8KSerRVGApKY9Xq
         lMAGQl4rGil5UrcFhqMU57crwLN0aRIMX22tdWGn+a7XEel4e1bYmxu7rdXcL3NaTVFq
         1d4z5R2ReXRYO+axD3lJBr/hy+AKiJv7KloFStGlXcCXR4AeT8Fy4b8DBZH/pxxBt1Ek
         sZ3gIra4XNHHHDGhPkDEAL8/zRxi1dbDBG1KwdbzKL/bbF1SCpiVcQ1Q0yRiuT3ZpX/S
         ALEgFnwt8Uu6ihW6mDkbAMo4zBQFCz9No2UR8k0E2Udk6QF0kU/EX1rqmqiRrloG9VAD
         MY8Q==
X-Gm-Message-State: AOJu0Yxldz52Ff2Wjnb20tEYnojXZNKTJzOFM6iDGhK/kLBZS3+PjEtN
	in0NKbrRTp5Bv0AHwJVqRQJlnai7erNAhEQu1GIUejqdXkPoGU294WLpmi2Vjr09IT/arZLD8ac
	HcET4t9VE8Gxt+NKhBcO5tlkI1ntLXZV3ne4XBws8rCYR/lt4zDp42V1A6Jnh40aHpXnYKg==
X-Gm-Gg: ATEYQzzdJebptUUSTrE/PY300vg5vURGblG7Dje5RSS2HCXYK+BWqd93pVaAY945ch7
	LbUTBdxkvkVlsgwq7xLQloZ0bqYx9+NzhiCYYgNxhyz0kIYuXJJMnZnYzi24f75LhnEcorMVU/0
	VotgWOF/ivZhpjXI8JkTIvwww2oH06Bv5B7BlRn5Rid221+3Uv5B9IlWuHPURbUyIHI7uBQfx4W
	xtxzD7sOxY/DTDoXeYBZQU5SSpzyaxwpTwr24cJMmcP9I3/6oWWQAuTABAMSVOvSvwQaBRH/iGH
	mtwX/yY3W6UxSpCPZUQTEdcYr8AdT1i1D/+FMdpc2/ER3jGYS1ESV5eiBElXE41lgoBxoGVuX8B
	q1FO42tj/QMTjI3Nw57b764Ozjhg7pMRJBWPc3YCcvlsImxYro6QV+lHcVsQ7HkyeK3TfGI0m1g
	h6qsU2dqg1IG0BXJN7nEs=
X-Received: by 2002:a17:902:d541:b0:2aa:e55b:22c4 with SMTP id d9443c01a7336-2adf78fd098mr9996775ad.9.1772070629924;
        Wed, 25 Feb 2026 17:50:29 -0800 (PST)
X-Received: by 2002:a17:902:d541:b0:2aa:e55b:22c4 with SMTP id d9443c01a7336-2adf78fd098mr9996465ad.9.1772070629397;
        Wed, 25 Feb 2026 17:50:29 -0800 (PST)
Received: from [10.133.33.106] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c1976sm5861215ad.22.2026.02.25.17.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 17:50:29 -0800 (PST)
Message-ID: <34363bc5-2439-4579-8999-67dedded39d0@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 09:50:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 2/4] wifi: ath12k: avoid long fw_stats waits
 on vdev stats hot path
To: m.limarencko@yandex.ru, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20260212121746.329619-1-m.limarencko@yandex.ru>
 <20260212121746.329619-3-m.limarencko@yandex.ru>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260212121746.329619-3-m.limarencko@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: c2WogQy_S55LFPsk9WQogppTNqugSMp9
X-Proofpoint-GUID: c2WogQy_S55LFPsk9WQogppTNqugSMp9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDAxNCBTYWx0ZWRfXzf0w/eTJNt2/
 LHySS3oqJvz2hvHm+T3346E0dwu2E2SegjR4MYoqb/DJ/LaCWpbIfU6gyhOye1HF2YLwOamx42i
 k+zDS20MZq0iy8NfcH7hMcRavC5mhOAOHwc2Q1aY3UX/Wyrnv+a1X+v1VOvjqAtNKTdrmykB8og
 /sbhttDrtRoVGQ7t7zO7ezLfvcv7oFDdl8mPa+cy5S0lQMMy0D8gBVXTP517N6WgWdy0MTLgIvv
 mU8EeS4UkGIOgod41RqzTGMg70pIs+t8A7vwC6YI0w0tcAIipNWzRbBBrxPk5i8mLvyiqdEJt9w
 mIuj/rSlZf9BtKQWu9h3pxJljtMzILuqDZxZ/ZuHIilT4ouYc/hwUEO9+pZlxeILxYKYWAnjE2L
 EGBzNMLV23XlsHLGjrjJxNpWZ7eIFdl3VIDzMnj9RGBzGDoCEVYqaICBekAT0TRbqRfj2O6aV1+
 Jb7v3JIW9sTj5C9BQQQ==
X-Authority-Analysis: v=2.4 cv=TcybdBQh c=1 sm=1 tr=0 ts=699fa6e6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vaJtXVxTAAAA:8 a=w32g7tGSt65Kz2FTHNQA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260014
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-32191-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[yandex.ru,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1888B19FF1A
X-Rspamd-Action: no action



On 2/12/2026 8:17 PM, m.limarencko@yandex.ru wrote:
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

once again, can you please try

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


