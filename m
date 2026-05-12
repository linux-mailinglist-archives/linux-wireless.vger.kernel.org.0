Return-Path: <linux-wireless+bounces-36349-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id TW7WG3C1A2pg9QEAu9opvQ
	(envelope-from <linux-wireless+bounces-36349-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 01:19:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E7252B3CC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 01:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 462E5304E303
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 23:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A774028CF6F;
	Tue, 12 May 2026 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JzujmVnb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hz0cxZfx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85C33EF
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778627949; cv=none; b=G1QG/y+4zhAKGDsYtV1KAcxPXHT6KHKIWmwBKpETBfovzuN0QsMz6QPqsuD7JVlt+kslZMft8uVuhmuNfySg/M5AoyHmyfVO5qOolOJ3Vlh2UDIbKMzT8f4nC6zdqjQsAS5wSQkgg8FfGMql1RS8o13140Pv8ZKDta38AiOdnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778627949; c=relaxed/simple;
	bh=CxS4nMuBBeDuzDW4c0xWu7ac3A8aiNO1+WzOxiE9PI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZDUpae3NzpdFHEhmuF3M2qLMn2iQaFxLh3vSUwGWll9+EcT9GPrf/heuCYseKNloYTDMqBeA1Jg3TX80n4ulGR/kTOHCBrHXN1vo/H7syZJ7lUXOiFHLPLvzunTDJc4s9oc6pit8LYLCK0B6nKcPwEhvRuYxtGHrBkWXB1/GOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JzujmVnb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hz0cxZfx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CLnJFQ1414434
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 23:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j27ntAJ+N1LZSw0iXAtPGZfZuXUE/x84Crfg5pmEaIY=; b=JzujmVnb1gC8bscZ
	Hzt1tsDSD+8WUB2IskIW6OEaYO679MD5yVKeZY0q+skQXve0Y5P9WMnbELBEbzjj
	IlawRRsBofNjsMPQyO43k6NXf6snePYb75crICP0KW02ID4Q1axVFErT0xDchCm6
	wvSXBsK03PKf5ANg8ttqCZp9IW/Tp54gLxSvxm3UeCFSbu6XiRyVmjJa1cRWpbao
	V7R6rWrRuLCGj7ZOg0c2BwFOvmy5nPYSZvUpuG/VLE5HaOy7EGkRhpPnV1dApvk9
	gPTZuKacC4GM1OxzNP8rnI9CyaIdqUfQTxeIf3Ptt1jgaTMS7HjWgA3W8kTFa2ku
	lCTuog==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45v59x80-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 23:19:07 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-130aab78a09so6010898c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 12 May 2026 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778627947; x=1779232747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j27ntAJ+N1LZSw0iXAtPGZfZuXUE/x84Crfg5pmEaIY=;
        b=Hz0cxZfxJCtcqZijVOJ3vxzKJCV9fBIK4by2c3gzZ9ltQ+2XHIqx46Ko5ZMyc05xzW
         hWOr3ud1czRrNwCiheMRgdRrcxnnKUVALakv596KDzf9Bb+EVaHozKNnX1U+GK1TnITL
         Ae8BAxnmbCKaFtEDBbSzbgCZlrmt8SchxwvI23yzEcO0MTjVAaSfCPwyDdPg+AJk2qGT
         7xP8jvzZw8lVdY41JEO/0bSpGPI1jWuo/jr/Qb7W9V6Gg2+ykN6uuOfrcLy9Ll3AnByj
         u6EuFg63mD8OREoUy98TVo7axXroFWfNUGPVehZ6/AMUfjssELAF24ABulfYOmQ5syIs
         +3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778627947; x=1779232747;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j27ntAJ+N1LZSw0iXAtPGZfZuXUE/x84Crfg5pmEaIY=;
        b=bk9rwQrkJ2pjMPoiYJZwOuL3ieY8EpO+fH3bOEiboHlV4rOBq4/eqPbWvwR0VvSElZ
         Z78P4wj5WO0yP2WHQDhgL9oRh0xRBAWnUg857ct3HG+CkFMFWPF37O9iSzfndCnJnJrd
         WmoXu2PKLX02GHuBTtk9JtHQwE63Amb2oUkZK9nGf3TRGT2kQTi34epENph4Um1vZASV
         PLmeejL0sKPhziH5sbTMXuZNi68VmstFzuJPtoWeiGUpXduqToA9CWxQ7ag5nrjPOwCT
         JL6cnHxzyBjBqCCmMR6gZ7FccJFNSBQOz+r7SWXHFQlipiyNvmqNDEZNJ5m+GnXc3Rmi
         VJww==
X-Gm-Message-State: AOJu0YzkxUp76fqp0BBGIhAYyO3DbyFhHFKldKkdLqqASKOHktVYGVsK
	AVXKfH2MouDY082yhpGh4/43pgMIZCmJkFrbOUHpkt1577zJcKtdlZjPMSH2I9BwRKImCAJIbDR
	nSpsw/tlcPM1GG1Qrs5KqZj/9gvjfIDBqKN8mvfJCEYi+m/G6rbtjOQcaMbWE1dKmXxsjKw==
X-Gm-Gg: Acq92OFzKJgYgMg0atX8Sjz7Z5EAeBu3cE5SoUOgq76DmyHfMZvQ2xVaHHNizai59sh
	b10IIwWvHVuLEP0suu/uYHDfnbdUjup5rYCkxn5XsE7qNEg1wbqiRsrg2MwJ11hvWQlcQcW0Hw1
	lfzr23NBFZUQjpsaVxmtqEieHfXkCeZxM2PmPTPGw6Cy0C2jkBrBh4TbFBQpXr3PzPQ0HwHsjn4
	03VJOidT4vh9dksn3hLKpgMUeTLyxF8tqa+K0bru+RG6jAYo3ZVy2LtyAxH1UUBxE44gG14aA+9
	s/hGIZDWbMb6kP54OABZsMriA9cKKrAL8EL6t4Tg1RNpSGnqErB6loDPOg5LYhU3AcwIf7B4hxd
	SDZQp6Y7LN904qNC+YyHIEJ5nGJOCgq8Jj8ZCftRMYB3PSsgTcUXHvO1hqAE8pwYwiuusMfJVve
	AuMw+yDXF+0/vtEQ==
X-Received: by 2002:a05:7022:225:b0:128:cf80:deea with SMTP id a92af1059eb24-1342ee3a12cmr528528c88.1.1778627946476;
        Tue, 12 May 2026 16:19:06 -0700 (PDT)
X-Received: by 2002:a05:7022:225:b0:128:cf80:deea with SMTP id a92af1059eb24-1342ee3a12cmr528505c88.1.1778627945868;
        Tue, 12 May 2026 16:19:05 -0700 (PDT)
Received: from [192.168.1.59] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13278210d40sm25517183c88.4.2026.05.12.16.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 16:19:05 -0700 (PDT)
Message-ID: <2edfe25b-2190-4463-bbba-b2468d872a4c@oss.qualcomm.com>
Date: Tue, 12 May 2026 16:19:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND RFC 3/3] net: ath11k: add lockup simulation via
 debugfs
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260330-ath11k-lockup-fixes-v1-0-7ed21095c2c4@collabora.com>
 <20260330-ath11k-lockup-fixes-v1-3-7ed21095c2c4@collabora.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260330-ath11k-lockup-fixes-v1-3-7ed21095c2c4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIzOCBTYWx0ZWRfX55lPusJm7YOI
 atyrz2nSxfrz898BnV7fdRNO8+nOs4LGwapfR02QxCQnRpeMqhtshVZqYDmjB2AKVBujsRSA1P5
 gfAi9S1h1BGc0sMg4owa/X5ca9ooUBAjR4SWGclWGm99s/MEMomCToT+z4zdWPo1LeDcWIqz4h5
 HxbWKFWdFihJtSfRwVVFWkgQJxJR5PCUn/Zpgot8/9Rd2IVIYRyrYVCnWfRdmqVLymuSDbm/LiL
 QRzfRozE/p80EQA35Kk8MhKa+S6XzAsVttycTmRESZo0PG3xQhh6bWNXuP4T1gkn8dK1w0kdfK3
 7EosyBdRP2e7PTzKHFQDNnQI+60Ltioq4I+bs5zq1mSZugKP6DGEc1vOQO3Im3b4ImK7Kct7tGt
 ZgrDqRQMTahqH7jeB1v8G3sWsdUJKPMztEE4il/sUCJLW+7m5gKq8PRrXSJe2WU1BYlXP7kM/wU
 yhhhBCxEo9ZqJohQzWw==
X-Authority-Analysis: v=2.4 cv=GZ8nWwXL c=1 sm=1 tr=0 ts=6a03b56b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=QX4gbG5DAAAA:8 a=MEfDkqlxHPSrZSc_TmcA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: mhg151N5eOB71vgBKR8044hlq_Nh01UX
X-Proofpoint-ORIG-GUID: mhg151N5eOB71vgBKR8044hlq_Nh01UX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120238
X-Rspamd-Queue-Id: B0E7252B3CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36349-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/30/2026 3:05 AM, Matthew Leach wrote:
> Add a debugfs command to simulate a firmware lockup.
> 
> This does not hang the hardware. Instead, it forces the driver down an
> error path that reproduces the sequence observed during real lockups:
> 
>   ath11k_pci 0000:03:00.0: failed to transmit frame -12
>   ath11k_pci 0000:03:00.0: failed to transmit frame -12
>   ath11k_pci 0000:03:00.0: failed to transmit frame -12
>   ...
>   ath11k_pci 0000:03:00.0: wmi command 28680 timeout
>   ath11k_pci 0000:03:00.0: failed to submit WMI_MGMT_TX_SEND_CMDID cmd
>   ath11k_pci 0000:03:00.0: failed to send mgmt frame: -11
> 
> This allows validation of the firmware lockup detection and recovery
> mechanism without requiring a real hardware failure.
> 
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.h    | 1 +
>  drivers/net/wireless/ath/ath11k/debugfs.c | 7 ++++++-
>  drivers/net/wireless/ath/ath11k/hal.c     | 7 +++++--
>  drivers/net/wireless/ath/ath11k/htc.c     | 2 +-
>  drivers/net/wireless/ath/ath11k/wmi.c     | 6 +++++-
>  5 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 221dcd23b3dd..44b02ae1e85b 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -1041,6 +1041,7 @@ struct ath11k_base {
>  	struct ath11k_dbring_cap *db_caps;
>  	u32 num_db_cap;
>  	u64 last_frame_tx_error_jiffies;
> +	bool simulate_lockup;
>  
>  	/* To synchronize 11d scan vdev id */
>  	struct mutex vdev_id_11d_lock;
> diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
> index 0c1138407838..ca0b72a3e0b0 100644
> --- a/drivers/net/wireless/ath/ath11k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
> @@ -356,7 +356,8 @@ static ssize_t ath11k_read_simulate_fw_crash(struct file *file,
>  	const char buf[] =
>  		"To simulate firmware crash write one of the keywords to this file:\n"
>  		"`assert` - this will send WMI_FORCE_FW_HANG_CMDID to firmware to cause assert.\n"
> -		"`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n";
> +		"`hw-restart` - this will simply queue hw restart without fw/hw actually crashing.\n"
> +		"`lockup` - simulate a firmware lockup without the h/w actually hanging.\n";
>  
>  	return simple_read_from_buffer(user_buf, count, ppos, buf, strlen(buf));
>  }
> @@ -413,6 +414,10 @@ static ssize_t ath11k_write_simulate_fw_crash(struct file *file,
>  		ath11k_info(ab, "user requested hw restart\n");
>  		queue_work(ab->workqueue_aux, &ab->reset_work);
>  		ret = 0;
> +	} else if (!strcmp(buf, "lockup")) {
> +		ath11k_info(ab, "simulating lockup\n");
> +		ab->simulate_lockup = true;
> +		ret = 0;
>  	} else {
>  		ret = -EINVAL;
>  		goto exit;
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index e821e5a62c1c..e01fb17a4734 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -691,7 +691,7 @@ int ath11k_hal_srng_dst_num_free(struct ath11k_base *ab, struct hal_srng *srng,
>  
>  	tp = srng->u.dst_ring.tp;
>  
> -	if (sync_hw_ptr) {
> +	if (sync_hw_ptr && !ab->simulate_lockup) {
>  		hp = *srng->u.dst_ring.hp_addr;
>  		srng->u.dst_ring.cached_hp = hp;
>  	} else {
> @@ -743,7 +743,7 @@ u32 *ath11k_hal_srng_src_get_next_entry(struct ath11k_base *ab,
>  	 */
>  	next_hp = (srng->u.src_ring.hp + srng->entry_size) % srng->ring_size;
>  
> -	if (next_hp == srng->u.src_ring.cached_tp)
> +	if (next_hp == srng->u.src_ring.cached_tp || ab->simulate_lockup)
>  		return NULL;
>  
>  	desc = srng->ring_base_vaddr + srng->u.src_ring.hp;
> @@ -828,6 +828,9 @@ void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
>  
>  	lockdep_assert_held(&srng->lock);
>  
> +	if (ab->simulate_lockup)
> +		return;
> +
>  	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  		srng->u.src_ring.cached_tp =
>  			*(volatile u32 *)srng->u.src_ring.tp_addr;
> diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
> index 4571d01cc33d..b05d04a1f5e8 100644
> --- a/drivers/net/wireless/ath/ath11k/htc.c
> +++ b/drivers/net/wireless/ath/ath11k/htc.c
> @@ -208,7 +208,7 @@ static int ath11k_htc_process_trailer(struct ath11k_htc *htc,
>  			break;
>  		}
>  
> -		if (ab->hw_params.credit_flow) {
> +		if (ab->hw_params.credit_flow && !ab->simulate_lockup) {
>  			switch (record->hdr.id) {
>  			case ATH11K_HTC_RECORD_CREDITS:
>  				len = sizeof(struct ath11k_htc_credit_report);
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 7d9f0bcbb3b0..27d6d4a2f803 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -345,9 +345,13 @@ int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
>  
>  		if (time_in_range64(ab->last_frame_tx_error_jiffies,
>  				    range_start, jiffies_64) &&
> -		    queue_work(ab->workqueue_aux, &ab->reset_work))
> +		    queue_work(ab->workqueue_aux, &ab->reset_work)) {
>  			ath11k_err(wmi_ab->ab,
>  				   "Firmware lockup detected.  Resetting.");
> +
> +			/* Assume that reset gets us out of lockup. */
> +			ab->simulate_lockup = false;
> +		}
>  	}
>  
>  	if (ret == -ENOBUFS)
> 

My 1st impression of this patch is that the datapath folks are not going to
like the ab->simulate_lockup checks in the hot path. But I'll let the
engineers speak for themselves.

/jeff

