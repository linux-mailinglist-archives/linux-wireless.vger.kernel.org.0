Return-Path: <linux-wireless+bounces-29449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B1C988F2
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Dec 2025 18:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 222AA344FEF
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Dec 2025 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884DE3385B2;
	Mon,  1 Dec 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZxyuzaXv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R3IFI0He"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C533859A
	for <linux-wireless@vger.kernel.org>; Mon,  1 Dec 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610867; cv=none; b=hPK5nuwaLup7kCy0Qn+wmRmfM5sKDE35Ohk9hKGPXpQIRQM6C3lAn20NeCBZjVP5jTbn46GlALmaJ3xp5DP9f9KtvscclWJnAL6wth+ntg1EFULV1u+ZQI25ZANhZMwxXqwhFY6Oj+GDU8FX/slAJvDD1ajj5gakFzdkoVcQ5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610867; c=relaxed/simple;
	bh=kQ0Zplu74sroYykShKNsBr0haSMA+a+HAxKkzuexd9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lwy5N4v7ybE/c9TaloIAp6novnaO+D5t9FSxGnYzl9qo6MXQXlKPYTGvZE0Huztr5piRPwcNNY9xsUOSxVW0VftEupT9jW0MmR8+htKOqT2u96RSFCVlBK6R9nd+UgqK28RKHJ+RWDrahvsIsoKevaCssp0yWYZND0JnPBF9zMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZxyuzaXv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R3IFI0He; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B1EQmDe3690423
	for <linux-wireless@vger.kernel.org>; Mon, 1 Dec 2025 17:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	exm+out2T1Pb1oWg34oExcEhVExwIO1gE6DHWlTI8qw=; b=ZxyuzaXv6A26qiRW
	3ib+4vKjJnwB99Ulmz3+RRb3QOIt9IEjEBZ2SK904Gsv6nMU2UluCtxKVvgbRPW5
	aXIV0VxAUSTF9gt+hZmetm/hPC3OkeqsVaPFydPZLYXkVi6jmR1m7IIpi7WMdh31
	G1p/Mm5LYsJGCX7rhrWPgKhgo7vMYyzGcSbUtkJSFYm8z2SL/nbgk217ze6jfZvJ
	eC0pkwM6QvoPRK63MsxQXNL1M+QTG01ljbQaMRJVju5uvMdOjxXBsAqaxu4C3s4H
	/zjOeRaj09yH4rJo95lgrRbtjeRy5qN6DQvXd2C/tC2nj88agyNrKRoRmpFD/Fpd
	eNuP+w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4as6141yds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 17:41:04 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b4933bc4aeso3389861b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Dec 2025 09:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764610864; x=1765215664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exm+out2T1Pb1oWg34oExcEhVExwIO1gE6DHWlTI8qw=;
        b=R3IFI0HeBkThA5/dEjl/SXdjufhQWzWrBEqdCZ6hX0XB8pkzY+WuHwq9oBx6ggMqIZ
         iw4ZTPbRXAnc3Zwk3XGsv8Z0XRXyq+XIpmAVe+c+FtkaqWGVsqvm7FHOFTPYjIo+tc3a
         96JJ0SuVzviwZSQyFK8/eCIheHJIAugRQsVunYjiqmVvOp+OdTjZDkmGPLqr4xQ6GSJp
         0vkavj2mS9x0DiNYkr4Va/iFwVD5LUpRLms/OGgSCUPUPuDWtHF4d1dP+jxcx/rAXk5l
         WvJTYpkGYBvEQ9HxWDluG29F3zk+zc2rTuQu+YUGkPkSAcKkF2weTij6kTpdFaLfaBDf
         /jnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764610864; x=1765215664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exm+out2T1Pb1oWg34oExcEhVExwIO1gE6DHWlTI8qw=;
        b=m5stxXUGk+MsbO+I6JwdqGr8tH+6uLkMn8G4qyXN7il3nLBbnNTNb8wWp8U5JlwELS
         KdNZoSDszJUn3JE7Lx3t/sOVO+waHJabpwKJVmbHr42Fv0pS2fQggzHuRDia1JAzHxnJ
         ICznLIt4YhEsoHqKGwJ3FU0o2JWV+iFH0di9SujguR34LpSR+DW/qeIyl3wNmW51Kw7C
         F6/FWsypS//V+BFN406pWC9/Dw9SRUWTFtL+tMn0RaHr/ffP7gbAJCby3nW/MQhkKnks
         7/pBTAy5OSoTEfH8GaIJkwH69wua/S6xyfzCAJ4VeoIlivAG3xN+gwM1DzTs0eS4yrlw
         Y4nA==
X-Forwarded-Encrypted: i=1; AJvYcCWm43hVJze4BmvUyvcmuNTe/V3KuSQgDctmkiW+k1rjsKMTkP/+NI4K9Xv88BpU7vNsUD/NkeF4qm28k3OAcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLJehIS7dZyiFOECrnHbzlVjNgjkEW9pfWw3NTEWJHprw13IV
	YfXyif0tjqUVQSLcURkCG+v7IQTk40Hr2jevgRZYMgZj1YYEvRPe2V58/Ulz3vaxRSjsaGnblJy
	xYcCIWp5OxIKdAVFZafoR8w2xsmsta/IoQXpqxlVkTPPNWJ0PTCu6yBcjhC3VjDjMDsY5Zg==
X-Gm-Gg: ASbGncvwDTFGa9PpHV8Smi5lCQ7R/kW2O/pbTIAAwLxCknSpka1HrA4hTSa88ClL/QK
	OWPQKA1hTuoE9vvUImLa5BFJof3ameS2VLnQ/xGorL7TDLAqF++9Na4ERmESMuSdsHW3MNQVsGp
	ZcEXGQl4X5wix1yJmmYFW6mpOfRR/4G5VdvxO5HnrVFvaEjjzZgg3A5EepqGS4yKrf8QYe/jPZd
	u+GA9XzfSv3xw8tBn5GXp97UHhB8pPHsxbQg1HBSVJ/VGhdhO3jpk+djsSYv0D9+C3BncaDpKhl
	/g6VBUfDKjdjCcn6K8jKRdnew+61YzLYVwjiGHTWDBRrEd0xhzzU7HBWqQDq1TpHv9vU4yGC9hq
	lifXHAmorFzz08ScTpq5XdGTkemAkB1h6SU7MgSPL24HaRlB56shAZjUN
X-Received: by 2002:a05:6a20:3ca6:b0:361:2d0c:fd70 with SMTP id adf61e73a8af0-3637db29723mr30315567637.17.1764610863745;
        Mon, 01 Dec 2025 09:41:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuoKHcI6kog7ZiSeUimSTc1QQRfMcR0gyLQvIhQiA98rGJvDjNieYJ0dzMpSwyxYjBOD4K6Q==
X-Received: by 2002:a05:6a20:3ca6:b0:361:2d0c:fd70 with SMTP id adf61e73a8af0-3637db29723mr30315517637.17.1764610863190;
        Mon, 01 Dec 2025 09:41:03 -0800 (PST)
Received: from [10.73.112.168] (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d150c618e7sm14245014b3a.3.2025.12.01.09.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 09:41:02 -0800 (PST)
Message-ID: <ce68d28f-c737-402c-9f6d-f13fec4d2e82@oss.qualcomm.com>
Date: Mon, 1 Dec 2025 09:41:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] net: mhi_net: Implement runtime PM support
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
        Oded Gabbay <ogabbay@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Chris Lew <quic_clew@quicinc.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, netdev@vger.kernel.org,
        quic_vbadigan@quicinc.com, vivek.pernamitta@oss.qualcomm.com
References: <20251201-mhi_runtimepm-v1-0-fab94399ca75@oss.qualcomm.com>
 <20251201-mhi_runtimepm-v1-3-fab94399ca75@oss.qualcomm.com>
Content-Language: en-US
From: Mayank Rana <mayank.rana@oss.qualcomm.com>
In-Reply-To: <20251201-mhi_runtimepm-v1-3-fab94399ca75@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J/KnLQnS c=1 sm=1 tr=0 ts=692dd330 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZdW6uxA9NKXbfdqeeS2OGA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=vwh-6NgWTdBnnHhUpCYA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: yKKct55hMLDBFcXqSDz_lYGRJQo5qgWQ
X-Proofpoint-ORIG-GUID: yKKct55hMLDBFcXqSDz_lYGRJQo5qgWQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDE0NCBTYWx0ZWRfXxltMxmLF236V
 2EE4TsTJUfB8mpN2MYtfPQ2OjqAjuydlSUVo33TMS7TPCF1qTmqAcZmsCZot4u8nf8GkPF+T/Fm
 yJqdqp0GZZ1iTubToJiuCLD5b8GdyYcU67zApZSH7W7vDkllA3qkqX0ImzM95Qhct5rFd2LFtCX
 Huk0VTySLjaHx0JSxo1rW3YeKhRVgr5Y6CN4UWHLmyRbXf1HQOOPNTtZswIc7r+BWIY7/5oiTvq
 uVVKFaukNigC1cSDrFpaD6NLgTrv4lrjzQQ9hMMhcPz31q8QhPmk3SEhnddvH+UIs3XvWsLq6Ew
 105LME+Wdpun9rgTxhfns3CvLq37Jsre68SGXfEJm3PUq5m48wm9NTLHk5CKAN9iK/GPe3CATEq
 dbj6bEKvV8wKwsRCdY+V+BjulOHqcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512010144

+ Chris

Do we need to consider updating client driver (net/qrtr/mhi.c) ?

Regards,
Mayank

On 12/1/2025 4:43 AM, Krishna Chaitanya Chundru wrote:
> Add runtime power management support to the mhi_net driver to align with
> the updated MHI framework, which expects runtime PM to be enabled by client
> drivers. This ensures the controller remains active during data transfers
> and can autosuspend when idle.
> 
> The driver now uses pm_runtime_get() and pm_runtime_put() around
> transmit, receive, and buffer refill operations. Runtime PM is initialized
> during probe with autosuspend enabled and a 100ms delay. The device is
> marked with pm_runtime_no_callbacks() to notify PM framework that there
> are no callbacks for this driver.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>   drivers/net/mhi_net.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
> index ae169929a9d8e449b5a427993abf68e8d032fae2..c5c697f29e69e9bc874b6cfff4699de12a4af114 100644
> --- a/drivers/net/mhi_net.c
> +++ b/drivers/net/mhi_net.c
> @@ -9,6 +9,7 @@
>   #include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/netdevice.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/skbuff.h>
>   #include <linux/u64_stats_sync.h>
>   
> @@ -76,6 +77,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>   	struct mhi_device *mdev = mhi_netdev->mdev;
>   	int err;
>   
> +	pm_runtime_get(&mdev->dev);
>   	err = mhi_queue_skb(mdev, DMA_TO_DEVICE, skb, skb->len, MHI_EOT);
>   	if (unlikely(err)) {
>   		net_err_ratelimited("%s: Failed to queue TX buf (%d)\n",
> @@ -94,6 +96,7 @@ static netdev_tx_t mhi_ndo_xmit(struct sk_buff *skb, struct net_device *ndev)
>   	u64_stats_inc(&mhi_netdev->stats.tx_dropped);
>   	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>   
> +	pm_runtime_put_autosuspend(&mdev->dev);
>   	return NETDEV_TX_OK;
>   }
>   
> @@ -261,6 +264,7 @@ static void mhi_net_ul_callback(struct mhi_device *mhi_dev,
>   	}
>   	u64_stats_update_end(&mhi_netdev->stats.tx_syncp);
>   
> +	pm_runtime_put_autosuspend(&mdev->dev);
>   	if (netif_queue_stopped(ndev) && !mhi_queue_is_full(mdev, DMA_TO_DEVICE))
>   		netif_wake_queue(ndev);
>   }
> @@ -277,6 +281,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>   
>   	size = mhi_netdev->mru ? mhi_netdev->mru : READ_ONCE(ndev->mtu);
>   
> +	pm_runtime_get_sync(&mdev->dev);
>   	while (!mhi_queue_is_full(mdev, DMA_FROM_DEVICE)) {
>   		skb = netdev_alloc_skb(ndev, size);
>   		if (unlikely(!skb))
> @@ -296,6 +301,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
>   		cond_resched();
>   	}
>   
> +	pm_runtime_put_autosuspend(&mdev->dev);
>   	/* If we're still starved of rx buffers, reschedule later */
>   	if (mhi_get_free_desc_count(mdev, DMA_FROM_DEVICE) == mhi_netdev->rx_queue_sz)
>   		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
> @@ -362,12 +368,19 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>   
>   	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
>   
> +	pm_runtime_no_callbacks(&mhi_dev->dev);
> +	devm_pm_runtime_set_active_enabled(&mhi_dev->dev);
> +	pm_runtime_set_autosuspend_delay(&mhi_dev->dev, 100);
> +	pm_runtime_use_autosuspend(&mhi_dev->dev);
> +	pm_runtime_get(&mhi_dev->dev);
>   	err = mhi_net_newlink(mhi_dev, ndev);
>   	if (err) {
>   		free_netdev(ndev);
> +		pm_runtime_put_autosuspend(&mhi_dev->dev);
>   		return err;
>   	}
>   
> +	pm_runtime_put_autosuspend(&mhi_dev->dev);
>   	return 0;
>   }
>   
> 


