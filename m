Return-Path: <linux-wireless+bounces-31006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 995AED3C073
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 08:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BCEA4F4B4A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEDD395266;
	Tue, 20 Jan 2026 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jxuO37Ci";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Baodj58i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335D392B99
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893567; cv=none; b=V/eFgbCNUbWkiHDiBJ8naFwollgSKKLYJO4cuP+a8bAScA5wxATyFFLf7BEKxzHXAUMDuRfzOVCc7dVgsqPSWwkm89lUIzfBYeiIulohcNNrAJ2iBXrPtdKIsIqEY9lxVjjAAIyH93/K5GelU6bEcGvZ+ESwvBR8nLtlbxB0wjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893567; c=relaxed/simple;
	bh=Am4DASNIaChGbG8aHFcpMHq+BSTcDGBgY9be0xM7k4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aMVvpPkXrMywEAedi8SsmNUXyWbGtjk926q/3P7eQZNCyB/1Vb3K0FnP87GkMqXzOUSd5+lxad7ZncIwpgpHBLiVzqTQJ8umuuyPOwI+3HiLGgadej+9DiXe4mhKT4fgUVJ3x0QKy64CLC9t4teWYJO6AOD7PrzdNhpjfkx3jhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jxuO37Ci; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Baodj58i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K61YSA3772477
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 07:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gd7D/YUZzVo2knwthSbnndhf1Qb341qujHUYrRBqbTw=; b=jxuO37CiV/zMaSZ0
	Dbhx+SlKE1KgIcWMQijlbPhYDWLxtYUbl5q/+OM2Nch6M+W9EZiEHRMmy3WeMBGT
	xJpnRuTunGrZwI/N3PLvOr9GxdnQoaIp5+OlTiH/OEWamu+PJy67Y2nVovH+9woA
	yN2XllfRLNfUewWa6m+B5nf1EK7o+uV/xgWDgsXOkn2e8lgnm9A2P1McXTdPE1wL
	sKCx3fUZEIoN/wmzM1fCu4dw4vmQivexHCetmmC7Zx3u7wRQjih1SfTYb3aumwXK
	3HS0i1pAdHCfk+GbA91x27BHhWy0yZlMJxbN7OnNwNRKfwG4PidLUnZ2YnhWuKBh
	a7HZaA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt42wr7wj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 07:19:16 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0bb1192cbso46453645ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 23:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768893556; x=1769498356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd7D/YUZzVo2knwthSbnndhf1Qb341qujHUYrRBqbTw=;
        b=Baodj58iOwPjSJUgwZzxOnG/HpALI4Lzrh1handlGddBF9aey6QVnGh0STs0iugyq8
         Vd8CdnNRAavj5eprfrmqV1fUim6HJN7Nfr0v8GArTcoSapYTvOG2ReeoDrqsngimf7TJ
         HAocBCAqU4kNponNICOoWrkK4UbMLmxc/nvDrB7p01rQeOHTLBkZpDMMcyzU93o3UUmT
         YILP9gb4COt8s0fQ9gc1T5MIiZYn+yTTN+1hdKmtkAx8vIBtEpWr4vkZYMSSpYuAdPr1
         vmPYaoHVRTWE7dGtJJMKxlrFIeyb7DyaNOyspod4W8nfpFXEe+VCk5WF3y04EHU+qFhZ
         p74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768893556; x=1769498356;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd7D/YUZzVo2knwthSbnndhf1Qb341qujHUYrRBqbTw=;
        b=PgcpyAuVSmHJo+n3aOmMEGCQA5YmU3OY7G8Rl5zoKtFUJBgV4QU1S+w18khAzUWTtc
         PRNUvDNNfE5wRdH4zglCIyvxLNBtOSS92/M5z1SByzL3kw16TsYoSvbhI4jeffCde6eW
         +0Na3VkFJqAI2fJU+xVV9+gUtdPN3wW45DLZyHUYZUZh0mBlYRIsYRJjq+69iN3YnSLB
         P4IUroUbRJ3YAK0bMeFpRFyccFqB1eWgtxlLqI/xEygpYVuFwpC34GPlJRRQ2Pqny1iC
         G/Pm1bIkwjQjzBor7gK83gkGxN6Rzn3SPkPyqCqpfODoyaKRLqQ3hORVbOvagiQUytqY
         tMJA==
X-Gm-Message-State: AOJu0YwQp7vHJCKU1RUkE/TmmWLzqHvcod4XsSYucOxbAOg6kF/18IRn
	xAfRwLXcpX6SBnrz8W71jqKGorIU/VSOlrs44Kypzmsnh6lp67qBdd71cREDheN+CrkkFLRsVQS
	r0M9XJlRaBcBIAQvHKr/KAI2nj7sR149xQWmxCCUkLHRelpnYJQbFklYNIucVT9W+mf0iY13Tbi
	Xhdw==
X-Gm-Gg: AZuq6aKfOmOzL1TuXJQJirvXLvqBojoHDxa3h7x8WLDl+xuV9yQu6PNYp29JiwoxStw
	USibAG9UClP8gH6tca4eTvL4AINfb2MGHPhOztWhDdk6fWrzzsQi63qkQqpgSE45l/nhBUhk0jo
	0qW9aWxAWbeb/MG1C3tPfntsyw/7R31YdeDaNcmLPpQHxs6fOtyNNsttAyNFxvtM25wwQNhorwx
	wKOzyo+6OSVhbKj5RxC5BzsxPhFo9voPQJBJ36dIkYMDTl35HO75Vhj1J9vDUYYK+OJdL7BuQZ1
	8p7ANlff87VgsBXj5VQc1P4xsH+FVRvVo/KxkutS7bIpmVFPBnrILvtQw7+viMGpMhHvAel3aWZ
	UTqF/JB07ivd5/gKVcspz0CRB8Eew92Kgt6hnkcTq/YICk5b7uJuHSniea1oOBZ4PrqPGB85iQo
	azsI2lUY0=
X-Received: by 2002:a17:902:c40c:b0:2a1:35df:2513 with SMTP id d9443c01a7336-2a717533c8dmr132039385ad.17.1768893555639;
        Mon, 19 Jan 2026 23:19:15 -0800 (PST)
X-Received: by 2002:a17:902:c40c:b0:2a1:35df:2513 with SMTP id d9443c01a7336-2a717533c8dmr132039265ad.17.1768893555137;
        Mon, 19 Jan 2026 23:19:15 -0800 (PST)
Received: from [10.133.33.150] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce6a9sm116209015ad.34.2026.01.19.23.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 23:19:14 -0800 (PST)
Message-ID: <40ccd4fc-33c8-41b5-b68e-4e590a5a6ec5@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 15:19:09 +0800
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
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260120063731.2383695-1-zilin@seu.edu.cn>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260120063731.2383695-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: p4fS2r1Pia5zyYr9Ud9JKD1xQF1kLDGa
X-Authority-Analysis: v=2.4 cv=eJMeTXp1 c=1 sm=1 tr=0 ts=696f2c74 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cJDDEaPil63sA2faZhwA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: p4fS2r1Pia5zyYr9Ud9JKD1xQF1kLDGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA1OSBTYWx0ZWRfX+ZSYSpNcKRzb
 ogFSBxpklL9BNVSdNIy67aGyuVrzsa2YoWx76v8SyHzbMstvRtzvawi4XYKZbFpP+7/gDVP5VEy
 C2NbrbNnferiVavVQ18gs4XglHrnlOLjIxWIrzqCzWmnnKuuVSXgAcaKKlZ+Gh2fkXJavmWXdIQ
 I3fqCQV5wtGkuTzH3ZcWZJRbHe5IY+Pe7JZa9Fdw6CrgkHw+1UYC3DliNMf7gHDvA5AsuyHdNkR
 wqPplrEBJ+dclvNtkZjDaE8USQMA+2ftw4vkVXrHAUnbApsUByWoh3UZPlPJ/Oi8YB2qqVwBqOk
 IhqcgKOSwIT+nRTyoCuI1TP91TSUc2CxtBwYUl0GDMZCei4ZDZjfQo925K+P8C9zFOsKge/Stk4
 m3l9T2ojwbcqFd7RB2qwB0H3zLq5i7Pz0lLOR4kK/eFNewzaQePx6aogZUG8XlaAjoOiQ3X32tK
 ++y9yn/FyQ9HeQFd9zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200059



On 1/20/2026 2:37 PM, Zilin Guan wrote:
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

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

