Return-Path: <linux-wireless+bounces-30985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 713E4D3BDB1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 03:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 785584E148C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 02:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32342D3ED2;
	Tue, 20 Jan 2026 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CSCvIEpJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H0EzNTcl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F72D47E6
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768877586; cv=none; b=b5og/lmLERU+vHYL/kSBgeFQMTzlJIOLx12UhuxBVRvuuCatIef9hd2la1KftxsGOya0iPVP1UKnhiOaK5lIr3NXjU7JUp6fo5mL4zqKe5MmgtCKK6J8BCDYPkuGlaN9SQrjX8wiF3sol7yrWqXq9AHL1r/XNfB24jaRgP2pF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768877586; c=relaxed/simple;
	bh=JgW68y+40qtFpX8tarIppJ2zPYQhP6omBpd1w3EaGcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EFQeURnuYtGKTfmEt98RUWZx8SZYEtWEa+UbE7Vth43waUD3dde5XN5CHa9T/dNIsLYjfM0MUyqKTWwziQOAJlNiB41/lRD0YRE1zdUh0WGnIBpNrf9SG9HXsODGPdtg1J5ETkDuB0uwjE+esf7VYkY0p1znstIZRTAusqHES3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CSCvIEpJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H0EzNTcl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K29rWH3177105
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CMjkrdm9ThDbm6nZ2qzsucANq/wC95yDAs4s1Sf8szw=; b=CSCvIEpJ7+SLqy+M
	2p8V+x9OsJzVWnr2a0hZxkIdUz/Hg/Qs+/LPHpvEBwx3Clz2LA+WwKihcNEP0dl7
	idkjCePiVY3t4CBN/4nT1hji4pbJlNMwagDPPpi7LrvIwothR3LBL+PR5iBY4kma
	E08okrGxXAI1EUJ2Q/5Hnw1nmmGVzeBO1HkMJ7bUgtfkBgf3lCj0amamAHWK5p+w
	/9ZBgAJUS6Ml1rqJOgyc4rfR+e3vs+Xh7qaMMGWm89Xd9m4T0aRA+h2EFVUGVv3l
	IP5XxzFafYdQaDnXhva/mls/TRdr97BpsEDmfbdHc+plpjvyuW8dqBc4rVgE0xiX
	B6Z7Qw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt0p2g3sd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 02:53:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a13be531b2so46581035ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 18:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768877581; x=1769482381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMjkrdm9ThDbm6nZ2qzsucANq/wC95yDAs4s1Sf8szw=;
        b=H0EzNTclvD0jG1xQTgP9sNny8keXLM9ku7/Zx/su8E2C0nVC9Pv50Jjzk9kT4Fyhqp
         AKgOXp7mTuDhd8ixLQJl2gHWfOwVx6d7YNouds4cHXrE5EeSk2XxkUh+/FJ0x84cMlnk
         Fwzkz5cfMLj+xIOWQfcGH0FpLJNKV6i9tuXkMqFcaClvKno+cqWoulBEkF5JAyvxKFsx
         nmoYIcUNGebvN1J8xJOhpe2bS38GXcOrs14nf00mixkbDOecQh06JJG5Heb6wzP2Sr3E
         K3TMnG4YFQVNa6NefHbI+J9ZwDVXgn1kQFAnrhzq6ecHcDEc7yICd73gXoyfz9ruQTy5
         aD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768877581; x=1769482381;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMjkrdm9ThDbm6nZ2qzsucANq/wC95yDAs4s1Sf8szw=;
        b=SdcQTIFSplQfjkQq21zsGxgjHjqHQ7HsZALp2B9ho2n9qK2tYXaa0IZH7H8YiGvY0n
         +oT8qhiJwKuSGjIvEE7HanbLzl5OmIMXWVaTEKYfdd/BKTacgGJcWr7JnAonLrs3sHca
         AeFEM7QNcGbtTXKTJaUPd6QoeWu/TrCv/7UGH7NKnZ6VXH5JwdBBt5nIzVcWUV7pto7b
         ncbc/lzJlG3tqU2FTdcYEDmNHh8wI7vy/OBZKMoft735tn5R7r/rveBeujUmfLrOpitM
         uUMYTLnrpkXJRQe0bawOKrXJrASt4iWCmepdunvUdyJUZVO7DAFFfjzhY8pe/EWzaiQ8
         mM6Q==
X-Gm-Message-State: AOJu0YxyAiyaXnYHLutffSb2xlDbsCpFpiW4FVZUmoLDIT3YQTMkMAAS
	2Ps3gI9we8vdENbo+Qg5Gp/zjUc7a/jrYtYwBhS5CensdTDdtcBd6xLzqhXuhaUnMVBMo/3ZkOw
	foH80t7uFDdgBwgIxbQIiSLqZYAQjUNHcajfNWZRl0UajhA36uzAjdmoPR9wu71jaVH3Ycw==
X-Gm-Gg: AZuq6aL5bDSBqQe1m4gBn6wb59m1Cxkdqz4rQp1Pxb4jNzblr4pB/aIlC6qZZQMBzrJ
	tj3KaYkUj5hkaqf8HnaSd1GTbEJaK3UNzHHFUXJm5Wde7Fjewly0m6QYAUSO937MhpYYvbzC98T
	Kbs2v6dUf3/jci+aMElzZT3I9E+rtJAil7qm+EhC1QHom9+l4yilvpvq6iCHYVa7aLx50NyfujK
	BuuOc4bylG10iXiCNCP60PFqWR/y/cgvKthmPGGPMHx9QINQIKybZiT+cUfle+gFYkCYs6Cd4dh
	dt2zdL/BkiB+dphMhcOT97aeEgJQH2VFm/T22vBazFkNpfO1CZiCttWK8zHr9KxemWBXMeDnMsb
	Y+Be0jX5Mcdi7mmjyhB0rm3Wi8X1eYiLTAjn3biCjjP05MRbWZHX6qCN/5aS1tHeOCj5q14eV1/
	tYHz0sPQE=
X-Received: by 2002:a17:903:9ce:b0:2a0:b438:fc15 with SMTP id d9443c01a7336-2a717519d9fmr123842875ad.11.1768877580765;
        Mon, 19 Jan 2026 18:53:00 -0800 (PST)
X-Received: by 2002:a17:903:9ce:b0:2a0:b438:fc15 with SMTP id d9443c01a7336-2a717519d9fmr123842655ad.11.1768877580255;
        Mon, 19 Jan 2026 18:53:00 -0800 (PST)
Received: from [10.133.33.150] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dd19asm107690225ad.59.2026.01.19.18.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 18:52:59 -0800 (PST)
Message-ID: <55fad8d1-ab4f-48b8-8712-24664a6bab2c@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 10:52:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix memory leaks in beacon template setup
To: Zilin Guan <zilin@seu.edu.cn>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260119160535.1874628-1-zilin@seu.edu.cn>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260119160535.1874628-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: kd4M6EOo4T74koZPa1HfeuRtmU5uuaq5
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=696eee0d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Nk4IflzP70UQ0qszZz0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: kd4M6EOo4T74koZPa1HfeuRtmU5uuaq5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDAyMyBTYWx0ZWRfX7YgOQQiCk0SQ
 RgAjGrQ5FR+wbgksul0NK4xTTpO23ixin54Q6eo8h2kByWQB+n5OhFaM5j4xyO48lnmk9nFfmoG
 8KUgitfJ7LFiO2OYkxZ0RiHtGiOt3gLFk2Av2TmlACwLIhVYdDni6F4J5Nb6IWqotr/iqYEw+DL
 AXXEXwZMxTLrTTEG4UgBuGKDEV/m1BWZRUDGZ5/0L8WoPsfqm6vb0UJRIVuarmHKAWNyej1pYXD
 vRf9QimOWUxA729AJ3x/vL0drSNUuXoqEYmvmLxenZN5FKVGleKhvzWSPr9w5ZSr02bBQW0bCI9
 LeAzlvQ4UloIXvlN2KGQAUF/jNUdwQZRL9GgXn+39pCIJ2V2vvXV8ELi2MmgQeD/VOGCC8IpyxM
 NBW2fWwAR4JChhsYsoYYU+J3virrC6GN0eIugjyHpFWeIziOgLuv1S/qYqaJsrWxp9xcM2jAYDx
 26KdN2CmKccXUbSSwXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_01,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200023



On 1/20/2026 12:05 AM, Zilin Guan wrote:
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
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 4dfd08b58416..005cc81a3244 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -1561,8 +1561,10 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
>  	}
>  
>  	if (tx_arvif == arvif) {
> -		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb))
> +		if (ath11k_mac_set_vif_params(tx_arvif, beacons->bcn[0].skb)) {
> +			ieee80211_beacon_free_ema_list(beacons);
>  			return -EINVAL;
> +		}
>  	} else {
>  		arvif->wpaie_present = tx_arvif->wpaie_present;
>  	}
> @@ -1623,9 +1625,9 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
>  
>  	if (tx_arvif == arvif) {
>  		if (ath11k_mac_set_vif_params(tx_arvif, bcn))
> -			return -EINVAL;
> +			goto err;
>  	} else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn)) {
> -		return -EINVAL;
> +		goto err;
>  	}
>  
>  	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, 0);
> @@ -1636,6 +1638,10 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
>  			    ret);
>  
>  	return ret;
> +
> +err:
> +	kfree_skb(bcn);
> +	return -EINVAL;
>  }
>  

below would be better?

@@ -1622,19 +1622,21 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif,
        }

        if (tx_arvif == arvif) {
-               if (ath11k_mac_set_vif_params(tx_arvif, bcn))
-                       return -EINVAL;
+               if (ath11k_mac_set_vif_params(tx_arvif, bcn)) {
+                       ret = -EINVAL;
+                       goto free;
+               }
        } else if (!ath11k_mac_set_nontx_vif_params(tx_arvif, arvif, bcn)) {
-               return -EINVAL;
+               ret = -EINVAL;
+               goto free;
        }

        ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, 0);
-       kfree_skb(bcn);
-
        if (ret)
                ath11k_warn(ab, "failed to submit beacon template command: %d\n",
                            ret);
-
+free:
+       kfree_skb(bcn);
        return ret;
 }

>  static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)


