Return-Path: <linux-wireless+bounces-35112-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MQNgEaTm5mkv1wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35112-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:53:24 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B83B24359F4
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC0583005A89
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 02:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E926B2DA;
	Tue, 21 Apr 2026 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXamZDbu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gtykg6yq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A91261B9E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740001; cv=none; b=jD7VwgjCSUtmsB1EycIvrCpgJWPoqRLD3m1VYajoMwJq4pEic5sdyCiZHT5KmOFm6hor/ucSE1mM/1aYhrIKVU6Et28N8enjN+qQ3EJbMtXD0N8zDizg3rRCQr0d4qo8xu5Um6Ozy8XGIn5dYuMZej/8vcX1T4oMbyWrBdz2paA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740001; c=relaxed/simple;
	bh=4IjoQjwiFeLLeSO5t2hKnPbPnrdsdcns09X8bnj4R0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f9hxt59iU6sKPeoO6rhDD1qGUtthdCKyY35PpDJsY42mejPkZUwV7vRxaNjN+u+WjP+nqft37yVUtAN/B3XHhmFtYJZuyHLKLTzBn3HbqeaDePaG0GDEOlHIF63Kf4UOyvo8eweEW+JGMQ3S7bSWticEI4ACgnr1uWW81DcYWgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GXamZDbu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gtykg6yq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L2k05c2980962
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nL9xUfvTkwQZncAFS6niHvBtOoZf0aD/RZbBCfCG6WA=; b=GXamZDbuUaHABGfK
	aJuurbG23e5ntre5qvoQEd+XkZ6jN1novvAz6fn9kGhVfdwgOt0fg/AndDyiLUC+
	EOjqyufcHc/iXz5ULKQXVelzdAgd7UfpZlqqs3A0KlLs8qOTGx8nJEdhRDegC8Ro
	L5KHd7GfTcnjB4vrSr0GvGDcCzDl5Rq2PFIHLEbr5I+sBy2y1Sq1yemu8dWKMVYl
	g0w2+sTkWrzdZG0KcspgI/d9J+eaqG2uynUVmSU9aU2hODtJlOLSKG6mB17vqUQt
	RNsOWiWgoCpedwSIozAu7y/19o7enEd8rPfW5xmqQbERM4xiisQ/StbjIBgOMTFj
	6DO4YA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnj2pu5uy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:53:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso34018535ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 19:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776739998; x=1777344798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nL9xUfvTkwQZncAFS6niHvBtOoZf0aD/RZbBCfCG6WA=;
        b=Gtykg6yq3LdnYNeifzQyijcQ+7lap2JkH/tF4Hs8BmDZ2LVTyGPX6feaS4mqmr3CwW
         b3cwkfkJjTHVqxdR5zXjBIP9x6SLGtAc/QSH31GgNFmTBZx81ngkBYDR2iXIht7exyOV
         udXmUF0DiHN8m/1DZQQ/co6VJ0Lemzgw8te1ZwIO862eS2nnAdbJLCd3RGWh0Dd9pkB4
         wiCVhGeulthz0JpmUYVFtSzOomfU5tA2UT+JZaQ5GR53oLaSnF8lgb9J1ChW81+ZKkPv
         +Su9wAhNxhXns1mSy+mv8RXctWoZIARrDy2zZ6U0c6MOOnqhRqz/0JXJVnCvESO3yUdp
         G/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739998; x=1777344798;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL9xUfvTkwQZncAFS6niHvBtOoZf0aD/RZbBCfCG6WA=;
        b=jxmGtvYfM8FCb2hJr3qKjna9pisDCWY988xxjrupZXEWLbslkph0OwUUzBwv56g5/6
         9OcmwPoAFTWw1yDXv6twXjlXxpZuJEQ5VyvYA+Q7swb0aLr5BQkPlko2PEHHSD9e0efG
         APejQU4hSr4R0TtDPiYTHgLjzMn3iopDdx2XpteunUu6qPMJtanLw8O75IRUuPRXFmQi
         fvu4IIISoaSNtiGjasxQpm151EHJSQIbWpKb4dLKLbiTdVcQ9KZepRmw1AfmAqutv2AJ
         Dgo9T2AjojWupY0ICkm4zinNPNTe6AnSBK/8Qj5+z/nZR5oX9Ne/Lgz2G24t26isgECX
         ge3w==
X-Forwarded-Encrypted: i=1; AFNElJ/HUwJv2wHQCtCEDeBEj9rBR2WHpuGHpUNfstnYvVDIWtQE4e89Sb5KNjywA7fVDLMPdrq1GsfyGZsYcbLXfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnfomk4ONmu0wzM7/Khjw83Kx5qyqn7zM+/VV8ukNpTGvAHs8Y
	d5HiAp4OIYgRMH+rtn4WloI6+hqbFOulZZrR3AS+yXt6FPXyVaiB53uyvKUTbyYGzXnoRuofj19
	pgT3+SJ7nzKjP4nicCncsxVMqK/lPSV04rgM6eBq1s1wCp6+BAIWa/UJOlValWln+svrYHQ==
X-Gm-Gg: AeBDietKkumyu3d+qpm1Eh/p4Drm1s9pE7rsBJCkDZMMBpM++kT0PJ/UGW0fJPBjBWe
	ttzDNHt8lgrYE/FgKZ6CofnF/Jv+T6CxJC6mkGt9g2owMmlFCa90SSG6N6nur7ePD3NgK87wxi1
	thMTvOv0jxNkhLKwRKxDQq+Kk8sJWpMUhLjZNOOmHzX4k7Hf/NEfi83OTF9NC7CAy3YR9HzfrBE
	Obw4eSSMDv9ytIwPeVsDY0Du4pIms6IdIR9uzpW4HsFqw4Wy/QqKw6+7pJVvlbdFIacA7GRJw21
	z49YKfdRleZRn4BW95d/qlZynJRlh8NBPkfTrdilbd2gnlHWCTfOLTvFYzjusrdxcMpX1q8D8BS
	rqQ4cZfR31mUFLuq+2QguRNPVZdD9n7PX5nhjAYDzu7eu950JW+PK9abBeob0g6AvY4F6kVFP56
	DShtVOzuHXNzOR24F0qccPGVONBC3sbw==
X-Received: by 2002:a17:902:6905:b0:2b2:49a7:a5bd with SMTP id d9443c01a7336-2b5f9e770c5mr113292125ad.1.1776739998393;
        Mon, 20 Apr 2026 19:53:18 -0700 (PDT)
X-Received: by 2002:a17:902:6905:b0:2b2:49a7:a5bd with SMTP id d9443c01a7336-2b5f9e770c5mr113291805ad.1.1776739997873;
        Mon, 20 Apr 2026 19:53:17 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa16e72sm117632635ad.19.2026.04.20.19.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 19:53:17 -0700 (PDT)
Message-ID: <a92cb332-b525-47f4-a529-a59080cb33dd@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 10:53:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATH12K WIRELESS DRIVER" <ath12k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260313001434.118010-1-rosenp@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260313001434.118010-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: a_P2bRviifvXvu101D3sTcnNZph1dGZL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAyNiBTYWx0ZWRfX4rVnXijGaeJ/
 BgUk7yueikaQpiqKn85kFOK2Lu/9eJtUQhn9dFbMjXWZehl9jpPO1XW2GNMQva2ysBMLg8+xLJG
 LaGKoOuiP1nr0nOsd2fSHrCbysOxFNl5Y+REDc9IBWaRa42hLkJWuqixnRM1BHqQW97LoWTaW0c
 nwWEI84WrtdxzVnGa+YGqFPLsBEujiJ8kgsuVDZW/2XAZsG95D6L02FbvF64jUEZGCZrJzllXXQ
 T5DrE5/jUYpgu/jFWpaditL2KioaIN/3ae1rupbt7JieGTWVxnDSqI02towEc2M8KqJzoYQZs0c
 XUX33Y/oPViY+GBoFuKPGnVj1wrt41NtAepaUcTbEEnmWvToKvP4/+vvTb4t4fI0VSNP+airN+M
 TARkC6q8hq5JE/cRztwa1S0TWiO8imPb5grExpPLk0PJmBbyM9aKSns2nZ6W9niJy1zB6B9Bl6n
 MJJovnj0CaMkJv5X6iA==
X-Authority-Analysis: v=2.4 cv=XMoAjwhE c=1 sm=1 tr=0 ts=69e6e69f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Axv3upY4dNLjRVsui8cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: a_P2bRviifvXvu101D3sTcnNZph1dGZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 spamscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210026
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35112-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B83B24359F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/13/2026 8:14 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation as required by __counted_by.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 29 +++++++--------------------
>  drivers/net/wireless/ath/ath12k/wmi.h |  2 +-
>  2 files changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 553ec28b6aaa..b7c43a64e37b 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5611,12 +5611,14 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>  	if (ret)
>  		goto exit;
> 
> -	arg = kzalloc_obj(*arg);
> +	arg = kzalloc_flex(*arg, chan_list, n_channels);
>  	if (!arg) {
>  		ret = -ENOMEM;
>  		goto exit;
>  	}
> 
> +	arg->num_chan = n_channels;
> +
>  	ath12k_wmi_start_scan_init(ar, arg);
>  	arg->vdev_id = arvif->vdev_id;
>  	arg->scan_id = ATH12K_SCAN_ID;
> @@ -5638,18 +5640,8 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
>  		arg->scan_f_passive = 1;
>  	}
> 
> -	if (n_channels) {
> -		arg->num_chan = n_channels;
> -		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
> -					 GFP_KERNEL);
> -		if (!arg->chan_list) {
> -			ret = -ENOMEM;
> -			goto exit;
> -		}
> -
> -		for (i = 0; i < arg->num_chan; i++)
> -			arg->chan_list[i] = chan_list[i]->center_freq;
> -	}
> +	for (i = 0; i < arg->num_chan; i++)
> +		arg->chan_list[i] = chan_list[i]->center_freq;
> 
>  	ret = ath12k_start_scan(ar, arg);
>  	if (ret) {
> @@ -5674,7 +5666,6 @@ static int ath12k_mac_initiate_hw_scan(struct ieee80211_hw *hw,
> 
>  exit:
>  	if (arg) {
> -		kfree(arg->chan_list);
>  		kfree(arg->extraie.ptr);
>  		kfree(arg);
>  	}
> @@ -13735,19 +13726,13 @@ int ath12k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
>  	scan_time_msec = hw->wiphy->max_remain_on_channel_duration * 2;
> 
>  	struct ath12k_wmi_scan_req_arg *arg __free(kfree) =
> -					kzalloc_obj(*arg);
> +					kzalloc_flex(*arg, chan_list, 1);
>  	if (!arg)
>  		return -ENOMEM;
> 
> -	ath12k_wmi_start_scan_init(ar, arg);
>  	arg->num_chan = 1;
> +	ath12k_wmi_start_scan_init(ar, arg);
> 
> -	u32 *chan_list __free(kfree) = kcalloc(arg->num_chan, sizeof(*chan_list),
> -					       GFP_KERNEL);
> -	if (!chan_list)
> -		return -ENOMEM;
> -
> -	arg->chan_list = chan_list;
>  	arg->vdev_id = arvif->vdev_id;
>  	arg->scan_id = ATH12K_SCAN_ID;
>  	arg->chan_list[0] = chan->center_freq;
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 0bf0a7941cd3..190e7a4a92d0 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -3586,7 +3586,6 @@ struct ath12k_wmi_scan_req_arg {
>  	u32 num_bssid;
>  	u32 num_ssids;
>  	u32 n_probes;
> -	u32 *chan_list;
>  	u32 notify_scan_events;
>  	struct cfg80211_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
>  	struct ath12k_wmi_mac_addr_params bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
> @@ -3595,6 +3594,7 @@ struct ath12k_wmi_scan_req_arg {
>  	u32 num_hint_bssid;
>  	struct ath12k_wmi_hint_short_ssid_arg hint_s_ssid[WLAN_SCAN_MAX_HINT_S_SSID];
>  	struct ath12k_wmi_hint_bssid_arg hint_bssid[WLAN_SCAN_MAX_HINT_BSSID];
> +	u32 chan_list[] __counted_by(num_chan);
>  };
> 
>  struct wmi_ssid_arg {
> --
> 2.53.0
> 
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


