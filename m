Return-Path: <linux-wireless+bounces-31359-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHh9D7qIfGmbNgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31359-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 11:32:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E4FB9628
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 11:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E4A4300CE54
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EA935E54F;
	Fri, 30 Jan 2026 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eC9NAg28";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gJoVNQag"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA12330B2B
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 10:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769769143; cv=none; b=WNkv3mdekCkTr0HSIV9r86KCLLJAF3TXpELuYI8rZvr34vSd0krdCzqFQKs1CgxQwhivwEwYAS7KOnTQHvwQY4bTVqTKU5xHHSMQelaBrsreq/uwmz94poFCtNa9o+I1/puvhlbp8b4PymUqzHu9UUx9eJUWF9SEAR9Zb8GJd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769769143; c=relaxed/simple;
	bh=x2Fa4zFCAQe58U21V2D/m7gyHU/goPS9Un8g4G8dTRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lDtDuWxG13NDe+oEC0sS8rcTeZZTJJ+Hf0aaPCNpzfzEvl9LmJpE/vBEWgU3I26x2Ktz6fqR8NKEQb8prT08kb2WF/kZ0fRac3qO4hyjIRxdcjcLVsWuMTcl2ZSoomnk2hDhv6BlAQKqu3sLlI40gSGmEbk0S9tbUGycNKBUCew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eC9NAg28; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gJoVNQag; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAPN3s1488307
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 10:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ajrqp3chO4YHwqPxAs4wl7Ae8mZrzZqPM2SAtc3oJGI=; b=eC9NAg280b4uiYqj
	OLZRbdCg4/12nYDVA0wjoZwXyL6aMQ7GwFf+gjEISscSkGo6i4Z8KCSxqQ9N0d72
	QISL5CFLJFZ3O7bnoSlp/X7aQHzahc6B2F3Wc8TXUhQXFRkqEACapwhVwothBtBy
	KctKf8+gy/A3sLeszVuIKpEcrcXtWtmj0jjW2aje0594g3j5kuEJgoLJVtaNV7yR
	zCGgQGca5flMZDLurgBrEI/Llvd2Uzk99/sK9JJRG63A2uAj5iycL7coq36GFOnl
	pu5GQaivAKMdlAsF8UJjKvFUF8nIy2XRC3G5Eu+MYPCgSF74S2gSEZeQ+rflAGg7
	RI0M0w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bp3tuam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 10:32:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c54e81eeab9so1361074a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 02:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769769141; x=1770373941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajrqp3chO4YHwqPxAs4wl7Ae8mZrzZqPM2SAtc3oJGI=;
        b=gJoVNQagldQ4kqbS5fdciBGo4VZFqGT+aQ0Gr+e/uMPmXNBlbqW60U+GZQp+XWzzuc
         97oNxydIIZXSwyhy4AGIGjZvUdi4DacBYx6tEfEr+4FSPH2Lcn4mfXiFxb+FD1Y44GVa
         P5t/EejA7CKZIjlimhXLyeoG6dxkz5Jx+VVhoC/+EX5nxvXUyhTDuQkb6FFalJqoWt+o
         nWwXn0gXB/9aJtt9uYOlhFaH/Z7HMzKrS8BGatSUTaaWyLzRu/jCZJghy88yGwYq5nXH
         iWOgNwJZ0NCJRi6Lu28cHpXwd+LQKnjLTMn+vogZQBe/ETuDnOb7m3U2ysd9mpKrxKqG
         YLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769769141; x=1770373941;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajrqp3chO4YHwqPxAs4wl7Ae8mZrzZqPM2SAtc3oJGI=;
        b=P+ra8nAtqc5DkEugJcWKDwA3MWP3q7YJJVUgp4hZwytr0JFYzEX9IydzuKtGpLvmTR
         vdrm5t6UaqI+6P0tL39h+watoO/GmjU8LlCxULu3IV4KWzn2ur8qqCOLGsz5eR890RIG
         LfLGSF5/ZPT6f7qf4DNzXbFuNwwmVCAVEQylBozj9FC/KVeFf4GOPnGgUT3CB1legYaZ
         e4Y431Bp7AIvv9JILUwVJSJPPr4XdXqcbhaJ4ZTVpLZ+gRfMQ68hRT2U1zrbSHQXUyRJ
         Y/lYBvIiED3xFzgbza+uab+wLW1wiuXt+yeHTzrb7NoQyubWjRaZKJ7PjwycDJitc7ge
         H3gw==
X-Forwarded-Encrypted: i=1; AJvYcCWiimWaoSXJgeGl3fqILgu8ijelDM84rRBHelUAghwu2qY+inUa99Z9nmE8ESToMEYmceGwB9xdPJD3byk3bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq8xZSYDibd0F9pD6NnLccc7zV2fxhhwIOGngakv+lgfpfCnaL
	fQbbsRu6WQBtvB92df6RSCPp+RLNR/wmhwn+FzR16vEFTE3d6wXloZ8e0mzK6SXMNVq6RxK0S8l
	p142OyqpOkNnfXp0lYOxWx2PFm44riWo2dYqB1Oj8Bvw0bBOu8TvTN7rNfM3uSQalFL04DA==
X-Gm-Gg: AZuq6aLh0BPcp74nPja6he6EEwIsWIMC84Q3QlRMAsNByIzX81r/UJuX5bek20j7wE/
	COYpRsiZOIlofbFQPNToJ1/9W1HBgPEV0KjzE3l2wyR9p+6fyKh2BtL2rCoWudUqLqNtpsM2bkP
	4qleJCHbYWGf4OnZx6gmgeo8w1fWm666VRStnfDsN5Wek4zznWygQ8R1qXYOQ9H26qc3t5cDB3s
	GI4PzLOhBvuPOUgmO2qNSYvFyrF5/JBlSlALnirxuCPAT2kqfpo46pcM03nul15IpqefNQOcBtC
	7e6cVnC4x+CeSMPDUapnipF0ZJifkBzfNZFf++JFy5/KnZtDBQ/hoKybpiw5k6qFwKOsg0fznis
	+MmERb+e4zbM8/1NZJ1CRHRc9qOuv8uwllaBBfWQqf0lTIUIKsfPRzmejs6nlCmGMvpWjlptoi5
	AoBSGeig==
X-Received: by 2002:a05:6a21:138c:b0:38d:f56f:cdde with SMTP id adf61e73a8af0-392e0000443mr2454029637.8.1769769140787;
        Fri, 30 Jan 2026 02:32:20 -0800 (PST)
X-Received: by 2002:a05:6a21:138c:b0:38d:f56f:cdde with SMTP id adf61e73a8af0-392e0000443mr2454001637.8.1769769140304;
        Fri, 30 Jan 2026 02:32:20 -0800 (PST)
Received: from [10.133.33.47] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3540f2cb0a7sm7740722a91.2.2026.01.30.02.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 02:32:19 -0800 (PST)
Message-ID: <a4ffdfc7-5eee-4c00-9ad2-00f3088f0d42@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 18:32:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: fix memory leaks in beacon template
 setup
To: Zilin Guan <zilin@seu.edu.cn>, jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org, jianhao.xu@seu.edu.cn, jjohnson@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20260130084451.110768-1-zilin@seu.edu.cn>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130084451.110768-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: UUY7KZK7My_OstpuXLcWLfS-L3IuyQYt
X-Proofpoint-ORIG-GUID: UUY7KZK7My_OstpuXLcWLfS-L3IuyQYt
X-Authority-Analysis: v=2.4 cv=d6T4CBjE c=1 sm=1 tr=0 ts=697c88b5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=Nk4IflzP70UQ0qszZz0A:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDA4NCBTYWx0ZWRfX1QIT3a9PVwaF
 pRC0VyrvDvyHFFsDfIaJFxwFphA6vNEINKqLOj/iZiHpqg7IAiJLQMmgNAKpYyH9nTMCmpgEMHi
 V5V20bune78XesjsaaDtJvNwvws479/agZzkP327DJY1MCmQTUOibnp6Sf9bVlWFIwRQPl0xBo8
 apOka7wCwhAbLDrNNZLWE+lB4vLPfxDfP7X8mV5vIrNTDFby9NClyRVzmrhscEMoxviQ4If/L6S
 e+IJUd354xbFUsInpJjKaOZXZubOEh+hhxuHKZCtA+KeeK7FiXT2IYUgUkoaD53lU06I0Asdjas
 B9nIuaL4vNTgaKQ1epNS30vCfHGfSvvu982P9LtNhrttlkdRqW4qqrWNqs8eLYPHk1l1C3a1AvV
 W+NeLwnKv+AcUSy9Lf52XMId7zKtOLwQqq4SW//xk8VJkahFPedT4O9VDuz+pjgGTq1ngk9Pinv
 k5yI1pTwkY34GmmuScA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300084
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,seu.edu.cn:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31359-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 96E4FB9628
X-Rspamd-Action: no action



On 1/30/2026 4:44 PM, Zilin Guan wrote:
> The functions ath11k_mac_setup_bcn_tmpl_ema() and
> ath11k_mac_setup_bcn_tmpl_mbssid() allocate memory for beacon templates
> but fail to free it when parameter setup returns an error.
> 
> Since beacon templates must be released during normal execution, they
> must also be released in the error handling paths to prevent memory
> leaks.
> 
> Fix this by using unified exit paths with proper cleanup in the respective
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
> Changes in v3:
> - Add goto path for the beacons->cnt check for strict logical consistency.
> 
> Changes in v2:
> - Use unified exit paths for cleanup.
> 
>  drivers/net/wireless/ath/ath11k/mac.c | 28 ++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 4dfd08b58416..e872f416ea97 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -1557,12 +1557,15 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
>  	if (!beacons || !beacons->cnt) {
>  		ath11k_warn(arvif->ar->ab,
>  			    "failed to get ema beacon templates from mac80211\n");
> -		return -EPERM;
> +		ret = -EPERM;
> +		goto free;
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
> @@ -1589,11 +1592,11 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
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
> @@ -1622,19 +1625,22 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
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

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


