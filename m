Return-Path: <linux-wireless+bounces-31279-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K8nHFA7emlB4wEAu9opvQ
	(envelope-from <linux-wireless+bounces-31279-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 17:37:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC0CA5E63
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 17:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70BE1307F060
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 16:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782431691A;
	Wed, 28 Jan 2026 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XDBjR8j8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PQC+vj+I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F2318B9A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617829; cv=none; b=UY64BPGSGLvPb2VWpba24fD6jhAZEfUMQJ/uNvpMPA7x3mlSOTpSQ3X2iOWXh9Ld1tOuZnmFl/QvgDra5wsbWTunD+S41tguXm1goXKw4PH4bS2Hmm40a7sCsoLJkc4LKP3F91jsLFCEtHEf7qB4gN1TbXUgkcm/n+Xr07q2bzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617829; c=relaxed/simple;
	bh=aDgIxXjpQ1KOxUnNki1fM2T6kdAIXo8L5rJv4hAWvdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pMSNAHArfh9ZS0boqnGKwuYLuR3h33USBf8DE3zTdAbylns+2hyuGn6IyS3FFpVQ8Uvj2N8+R6YEErs/+Pq45BL1wg3jfF1eFj6oardnIlj8NlFRSiVlWSxwkHxxAdZyF3j4aWhAX1AEsb0EbXwlDPYCN4okLQ55Y8cTg6kgTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XDBjR8j8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PQC+vj+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SFeHAc3246846
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 16:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PQGe/X5qhgopdlhTGL3zNTsLAfHq3ot7gtt/3+73Mrc=; b=XDBjR8j8O2/EAtsV
	zWHfkUKTP1xIMVN4fWe5kedH/SuE+uLE+3mYAEsBOKCIKZmW4zbLK0jBJfLZd/qH
	/bcMs57pL38DCodeaBQrxXyBSq4M2OTgh90nlzZYkDknq7LfbbaChPCUv87ysTRM
	6THPM8zBi/CH6f9aVdcZOdHZ551dNElGKT+GdBrrxuiqRAv/ZhlVQ8cn+BBGN2BH
	Fd34EfAgaHPjmhmwBK3buM140M7Z8mDOK8dmopKei/vDGOgm2Xv9woJ5h9Z3IRdD
	9gcH61Nr2iRKkRWtDHOJLfpgSvM5yDRUy2dC67tXmvIDw9sTJ3chAwMyNO3H/d/I
	v1qd6Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bydfk2486-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 16:30:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b738854780so60912eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 08:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769617825; x=1770222625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQGe/X5qhgopdlhTGL3zNTsLAfHq3ot7gtt/3+73Mrc=;
        b=PQC+vj+I5tOVhq2S7F3qZ3HLg64RpEdqLBnZ0/0soKdP1J0rNet4fVQWI6CEG98sio
         HnQD/njO/f4MIDhr4tJMifnhGAJUr4U5dDsC1UH5TzGbBrIKLpKpliQ2FLl8dR6iptdf
         fdVZt0As7C1HctIf/kRbdN72HL3yNMuGR3DvYoImHVIj/NNpYIHc9+ll3IFd2oqW8XQF
         hYAYdDeAt0xdFSm7kNEvX+8TxvqQEmh4SIGrC7UrQ9rcO3Dj8cdSEZSGikQ53w6PZ4L1
         SkVOvNyNW761WkNaBju54RIQcZV/ol6DTO3lL+Q6m2QShw9QIMwM8l1mdyvGrjD+9NP2
         3Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769617825; x=1770222625;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQGe/X5qhgopdlhTGL3zNTsLAfHq3ot7gtt/3+73Mrc=;
        b=oIJtYVnqdF6poBKuFMxRPAoTMQBSX6Pzj5nCnIQc2a5RucpWdyl9KaZVSMCxAlz98a
         yR8w/Q1TwiYeVAjHqki4hlq4+6E7ofrX7hXO3c4mHxkymfoydiSeGYiuY2oZVXfw8wJy
         9UYgf4ugSJirejQVWT6ILjYhJr8A8PzP71cuFFloUjUVSRzCtPEIU60ChLCRSNT7zRzT
         FLjil4Tvzs7XeELK8eQQYHJE73P4MZcRnYKBxRAG8HXS8RF+zUtKQxuiAW6VHz9XENg9
         /G2Dt0wHRIp8/OZwoFhP39SME3XhKpcL5WTo2UQ6gVXT6eg/awUbFBD+V0qhZX/BpgP7
         CT4g==
X-Forwarded-Encrypted: i=1; AJvYcCWiQwwl5QnVpzWck8FstJitjNuc65j6hozE+Uo0lDR7GaWQcl4hXg+XDv4cRzg4vGVhbbSQsVodqURAHrlnjw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydz20n82oZJatWr/VDSliRDUhc9SBw2hrr/lTtyYcQK4t8fjBE
	23eOx+JVn1ZP0J2LfyCJqmLMpnLGA213D8cVCY6uE22BzgoemVhqP8pNGnVajtWSWxTbqTJfqeV
	vo6Z6nPU912SwmMh4IPUUuuKsXkZly/xaPIvestQpsRvdmYLud8+VBV+LfWPxEdT3us+6eg==
X-Gm-Gg: AZuq6aJCUO9Xx2B/BZVRM6wiv6Qjq8LN83+2JR9hY/9viQIVFT8uV6pNiCzgCNih9up
	sIzOODdqm95pjIRWnBANEYIqpJR0wmEd8WdwRDa4Orh/2oQJaO7y67EJwOtXAjIEWpn8/r4ZE3n
	GSVjFdsXU8LhmonH99pSbwdlWjIxZsNwNcn0EbFXSI+VYjEX28DtGWjlcvwkJiT2lFRrvmiIjql
	LVh5IEW+C75EZvXkPggSX23f32NqA+SPqyF82bJbbqcw6lXC50K09+bMz8IgbypUyJ8tpSOuudj
	pchvVUU0Jd5Bg7/KtXdHEHGmvWzCAQ5XGZn3E70OlBAI2mlY+7rRL87whToPwnAcgigdVA47OB5
	b7a9qc0W5A2RcnWJPXytYDmQaOQeQPlmlqMgCQMa2DWNCPOKtnHcz9fqogcruQQjdY3KOkA==
X-Received: by 2002:a05:7301:688c:b0:2b7:24ad:5c54 with SMTP id 5a478bee46e88-2b78d8d4028mr4295836eec.9.1769617825083;
        Wed, 28 Jan 2026 08:30:25 -0800 (PST)
X-Received: by 2002:a05:7301:688c:b0:2b7:24ad:5c54 with SMTP id 5a478bee46e88-2b78d8d4028mr4295818eec.9.1769617824506;
        Wed, 28 Jan 2026 08:30:24 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af88dasm3548084eec.32.2026.01.28.08.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:30:24 -0800 (PST)
Message-ID: <6cc72c12-6f50-4e91-9b7a-bde8633009c4@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 08:30:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: fix memory leaks in beacon template
 setup
To: Zilin Guan <zilin@seu.edu.cn>, jjohnson@kernel.org
Cc: baochen.qiang@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn
References: <20260120063731.2383695-1-zilin@seu.edu.cn>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260120063731.2383695-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEzNiBTYWx0ZWRfX9dCC9tcy17Of
 cUn9jDjwEvdChJ/Q1XzKSTgNEAN01ow8t+39fc9ZY7yp64mSY3BzAZIR1w2dHiMIdKVpwG2FgBq
 c1uzsFrKF1oZOu4z+GZyYcqD/GnZkrMSjA+CrWa9KHLOxf7TKuWDd1bOOMn0UbK9hP5LloZ4ncq
 c+aylE6jiJQuql6pr/2wgeJZFeYMYlJ81Yxhkg707IrtS1Sm0MTfpq09iBpT8wr9W2+fjUlML80
 A7PCzxEEa3yw3LZ4Fwo0rU7wfb4ZR/UgoVC/ZFnjpE23U/AtCycSe5sJGabtlIq37Fki6tQZ6NZ
 z8CBZb6IKdMqUwEuDreJbHEsHjG3OsQoejBMD0YY1dEiJV9ZeF3rlCo9Yp4BH4wyGamUDvA136X
 hMZ2mVPjQswjy3OhAu3zDPrBmaNo4ieoFEmJ0bp3Byra7rFro+IGlIVV2b/g/ZY6zTW2XWIpbny
 hES3366ThWx28KUz0ng==
X-Authority-Analysis: v=2.4 cv=XfWEDY55 c=1 sm=1 tr=0 ts=697a39a2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Nk4IflzP70UQ0qszZz0A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: dkrQmRzTdm9-YDghmwYbMzZejRVN29NR
X-Proofpoint-ORIG-GUID: dkrQmRzTdm9-YDghmwYbMzZejRVN29NR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280136
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31279-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: DAC0CA5E63
X-Rspamd-Action: no action

On 1/19/2026 10:37 PM, Zilin Guan wrote:
> The functions ath11k_mac_setup_bcn_tmpl_ema() and
> ath11k_mac_setup_bcn_tmpl_mbssid() allocate memory for beacon templates
> but fail to free it when parameter setup returns an error.
> 
> Since beacon templates must be released during normal execution, they
> must also be released in the error handling paths to prevent memory
> leaks.
> 
> Fix this by adding the missing deallocation calls in the respective
> error paths.
> 
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
> 
> Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
> Fixes: 335a92765d30 ("wifi: ath11k: MBSSID beacon support")
> Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
> Changes in v2:
> - Use unified exit paths for cleanup.
> 
>  drivers/net/wireless/ath/ath11k/mac.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 4dfd08b58416..42edcc5e9e49 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -1561,8 +1561,10 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,

while looking to apply this patch I noticed the following logic earlier in the
function:

 	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
 							 tx_arvif->vif, 0);
 	if (!beacons || !beacons->cnt) {
 		ath11k_warn(arvif->ar->ab,
 			    "failed to get ema beacon templates from mac80211\n");
 		return -EPERM;
 	}

I did not look at ieee80211_beacon_get_template_ema_list()
But if it is possible that this can return a valid beacons pointer with
beacons->cnt == 0, then won't this also leak the beacons allocation?

Given that ieee80211_beacon_free_ema_list(beacons) can handle a NULL
beacons pointer, perhaps this should also goto free?

>  	}
>  
>  	if (tx_arvif == arvif) {
> -		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb))
> -			return -EINVAL;
> +		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb)) {
> +			ret = -EINVAL;
> +			goto free;
> +		}
>  	} else {
>  		arvif->wpaie_present = tx_arvif->wpaie_present;
>  	}
> @@ -1589,11 +1591,11 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
>  		}
>  	}
>  
> -	ieee80211_beacon_free_ema_list(beacons);
> -
>  	if (tx_arvif != arvif && !nontx_vif_params_set)
> -		return -EINVAL; /* Profile not found in the beacons */
> +		ret = -EINVAL; /* Profile not found in the beacons */
>  
> +free:
> +	ieee80211_beacon_free_ema_list(beacons);
>  	return ret;
>  }
>  
> @@ -1622,19 +1624,22 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
>  	}
>  
>  	if (tx_arvif == arvif) {
> -		if (ath11k_mac_set_vif_params(tx_arvif, bcn))
> -			return -EINVAL;
> +		if (ath11k_mac_set_vif_params(tx_arvif, bcn)) {
> +			ret = -EINVAL;
> +			goto free;
> +		}
>  	} else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn)) {
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto free;
>  	}
>  
>  	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, 0);
> -	kfree_skb(bcn);
> -
>  	if (ret)
>  		ath11k_warn(ab, "failed to submit beacon template command: %d\n",
>  			    ret);
>  
> +free:
> +	kfree_skb(bcn);
>  	return ret;
>  }
>  


