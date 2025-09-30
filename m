Return-Path: <linux-wireless+bounces-27721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66FBAB04E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 04:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E773A29FE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 02:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB4282EB;
	Tue, 30 Sep 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XpF3QcOC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C8610B
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759199521; cv=none; b=eBa6cGI1FcR24KW+bY0iZlzByOQB2sHTvRNNU3u8PSQnC+D8QB1JIkKkYIkhYiijU63+j38w7yyeOGVmoyGNVyYu5KlssOEr1Yn8e/cSOC9fWLlcOwmyDRTawZ6FvJDcFj+VYoYBYgKCM0CrGRQisQL6yr9AFbpX1N/N0VQy7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759199521; c=relaxed/simple;
	bh=EjJ04bb3e1XM9he3ltr0LaQiYu3kyNqpZuBrVVE0h4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PifGG17L9ujZTYBqxnutu3Q/PajlC7o/Vl0ec/m7LOin4TDvQ56fYfMqrScnv6Rz/7P+IWNvQZWTGQNnElNzqRYkY7KhqT1sqBFjUAhcIeX4KJrFs+GuHSYYpxO22QFeCfq8zklG7Gbm1SutLNLuHkbqbtDsGJlKkFq9c98YM7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XpF3QcOC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58THQoej030509
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0hI59F6O8DsGa2HATkDAmotVnparsQC8EJiXTJi4YNk=; b=XpF3QcOCc5olkOVe
	LxbwOGoFXWyOCb1iNjJnvLREV/XHOuzaMLZVdPio3lZPfI6pfgcjt6/XtJMFOgpu
	bv8/9HRPFgNSgJ3aTM390fnuCZRT+UAak5cD1z8kzidQafs0DgZvs3v3aSQlHuWi
	nXnJT5E1umrgPOeilt8+Tk8QV6fuyZtgDpQphiWNAlb/HveByhqnqiBOQhQ7BlQP
	md5PIYKeHTrStpVWWi4ta2wsBOsBDszYD6nz1nChR3fNN0S3Rvy5tiK9a5XYZ+DX
	WT/ars22KLyCZ4EdrGCp2hos2nhah9tuNzpxP8vjqVmzuxBw8K2ePdGvys4KpxC2
	nIZhUw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcqmpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 02:31:59 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78038ed99d9so7144262b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Sep 2025 19:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759199518; x=1759804318;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hI59F6O8DsGa2HATkDAmotVnparsQC8EJiXTJi4YNk=;
        b=l1565E9QKc7c+/jaZjSZaGZt3c7nNyKM539SX772WvqMnIRzYo6eVBH9fuSWNvKgUG
         WkKaoaAqG9POK/msy769wiMjPBf0tHVAcGbq65JRZNm48mYfGFfvSPi+2XsebVVxWm/L
         uTghK4kbVausi6uoGED43EgqNR6v6kvNMBNgirPjedxOvdpnxqcu3tSiJQohl69KQJS0
         RlMsJbeGoRTFsiQfpeLmSDTs6Y5d/ABqczQeGCYUspvJFMikNGpw9n01AALv0L92qepg
         KKuycrhtrwjJatGSoe96dJynla1zXK9vJdEZRNCe7jv8bkr+jI9iW9L7qLG7wPPOxT0p
         dcbQ==
X-Gm-Message-State: AOJu0Yxpc1YFVpLVhHKxVa0sIBUO5ORtVvSv4XwxfilqaiKblMZw+y9S
	UqQeGZjXN+HdTcwQnVaC+WeOJapbIXXWG0IyG+WhPp3aaelnppMR072xqFlYGZ0lK++CQkLmdb0
	PYPhFSgtXGSbrdJtQZQ5YCZWCIQLfTDzBt+9U5/c/TKjNrjCLdYeMvs0nrYetkNI8XbH/p6vPOP
	rLtw==
X-Gm-Gg: ASbGnctQKICbRjtuD1ULqD3hKGeErUA6fAj/Z5Vpwp31wcrkwYzxoZvV/S6o7XMlY5P
	v/oIbaTKwYtK1HH6BkIM/Xq0A35K4lcC7rhsiIc5MWdDAATtXymo76yuRAtkt0v58rVJMJFP1F2
	qhiOK2ZSvyvXoCl0P/QLc1imrJBN3fOCLKYnKlFr5DalXwAc9s2pTnvi9ma3MxmDzH0o/XRkjKZ
	BXuGFdwHKrwlDUnpTrQ6PB+dQLvqArq9T92GkWf98AOBF4UyREh/KKDZblkbcFndjbtayhVC+ML
	PMcpDY+7CPAeADpiMoXXqCInNql4HIjFkhedKNqc1s3Rgt1IBZLmT58ToG6obn6nTGqYstKDeKi
	eECxgNm3aKZcmVe1xvc7PZCMagp1TubRl+AO4FmB/Hmg=
X-Received: by 2002:a05:6a00:3c8e:b0:784:7275:837f with SMTP id d2e1a72fcca58-7847275a26fmr7405576b3a.26.1759199518062;
        Mon, 29 Sep 2025 19:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy+JqzBMESvQnVvyLIHJ3n/kdGu6h6H8SwNoYEVl1Yx4rIXVWHKdA2haUzkOZiqzGJ1p1+Ww==
X-Received: by 2002:a05:6a00:3c8e:b0:784:7275:837f with SMTP id d2e1a72fcca58-7847275a26fmr7405542b3a.26.1759199517557;
        Mon, 29 Sep 2025 19:31:57 -0700 (PDT)
Received: from [10.133.33.193] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-782e36c803fsm5812092b3a.38.2025.09.29.19.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 19:31:57 -0700 (PDT)
Message-ID: <1b2b3e9d-2907-4902-93bd-c7d9aeeda841@oss.qualcomm.com>
Date: Tue, 30 Sep 2025 10:31:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: free skb during idr cleanup
 callback
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Karthik M <quic_karm@quicinc.com>
References: <20250923220316.1595758-1-muna.sinada@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250923220316.1595758-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68db411f cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=iNz9HNjNQJPbPCLPB_cA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qwsuBcbRo-7ZrNwyM2JF2weC8Jn5ZfN4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfX00tjfZdj++/k
 gnzZtlzULCvAYd9Fg9rrOCWqlOjcv8C5I/Nz3yqq8yv9l3n/9b0y+qMtZwpSdEJyYMDKIZ/DHAx
 QlE23IpDipkbnZ7OG5kPCUQ92pxPEOGB69VdE4AILFUlfeGFNJPSNzs8po9Fk2n4Sc9g7ra0uEe
 MbMHivbPDJwTuFKgHqLRI8NNCl4TTaY4Lb1irSBI2C7Gwtx0NMLUfcnjwg82eU4cxQsriWKMGJa
 D0HDyXZ4egwWHa2I9TbzBELK47oWZU95Djrx/aY9J52QMmZxu4vwc95fOb0O9pqd9AzrXlsEnXO
 rjeFfur43U1RJsqJMPJyP168w7XPy7c6lPKqqMRvt3x6ExsQda1lDLV21uqnUFE4tiVsSoFedaH
 l77/b1xdD7vkMaim3af9T3MNrFlouA==
X-Proofpoint-GUID: qwsuBcbRo-7ZrNwyM2JF2weC8Jn5ZfN4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_08,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004



On 9/24/2025 6:03 AM, Muna Sinada wrote:
> From: Karthik M <quic_karm@quicinc.com>
> 
> ath12k just like ath11k [1] did not handle skb cleanup during idr
> cleanup callback. Both ath12k_mac_vif_txmgmt_idr_remove() and
> ath12k_mac_tx_mgmt_pending_free() performed idr cleanup and DMA
> unmapping for skb but only ath12k_mac_tx_mgmt_pending_free() freed
> skb. As a result, during vdev deletion a memory leak occurs.
> 
> Refactor all clean up steps into a new function. New function
> ath12k_mac_tx_mgmt_free() creates a centralized area where idr
> cleanup, DMA unmapping for skb and freeing skb is performed. Utilize
> skb pointer given by idr_remove(), instead of passed as a function
> argument because IDR will be protected by locking. This will prevent
> concurrent modification of the same IDR.
> 
> Now ath12k_mac_tx_mgmt_pending_free() and
> ath12k_mac_vif_txmgmt_idr_remove() call ath12k_mac_tx_mgmt_free().
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Link: https://lore.kernel.org/r/1637832614-13831-1-git-send-email-quic_srirrama@quicinc.com > # [1]
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Karthik M <quic_karm@quicinc.com>
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 34 ++++++++++++++-------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 1d7b60aa5cb0..eacab798630a 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -8290,23 +8290,32 @@ static void ath12k_mgmt_over_wmi_tx_drop(struct ath12k *ar, struct sk_buff *skb)
>  		wake_up(&ar->txmgmt_empty_waitq);
>  }
>  
> -int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
> +static void ath12k_mac_tx_mgmt_free(struct ath12k *ar, int buf_id)
>  {
> -	struct sk_buff *msdu = skb;
> +	struct sk_buff *msdu;
>  	struct ieee80211_tx_info *info;
> -	struct ath12k *ar = ctx;
> -	struct ath12k_base *ab = ar->ab;
>  
>  	spin_lock_bh(&ar->txmgmt_idr_lock);
> -	idr_remove(&ar->txmgmt_idr, buf_id);
> +	msdu = idr_remove(&ar->txmgmt_idr, buf_id);
>  	spin_unlock_bh(&ar->txmgmt_idr_lock);
> -	dma_unmap_single(ab->dev, ATH12K_SKB_CB(msdu)->paddr, msdu->len,
> +
> +	if (!msdu)
> +		return;
> +
> +	dma_unmap_single(ar->ab->dev, ATH12K_SKB_CB(msdu)->paddr, msdu->len,
>  			 DMA_TO_DEVICE);
>  
>  	info = IEEE80211_SKB_CB(msdu);
>  	memset(&info->status, 0, sizeof(info->status));
>  
> -	ath12k_mgmt_over_wmi_tx_drop(ar, skb);
> +	ath12k_mgmt_over_wmi_tx_drop(ar, msdu);
> +}
> +
> +int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx)
> +{
> +	struct ath12k *ar = ctx;
> +
> +	ath12k_mac_tx_mgmt_free(ar, buf_id);
>  
>  	return 0;
>  }
> @@ -8315,17 +8324,10 @@ static int ath12k_mac_vif_txmgmt_idr_remove(int buf_id, void *skb, void *ctx)
>  {
>  	struct ieee80211_vif *vif = ctx;
>  	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
> -	struct sk_buff *msdu = skb;
>  	struct ath12k *ar = skb_cb->ar;
> -	struct ath12k_base *ab = ar->ab;
>  
> -	if (skb_cb->vif == vif) {
> -		spin_lock_bh(&ar->txmgmt_idr_lock);
> -		idr_remove(&ar->txmgmt_idr, buf_id);
> -		spin_unlock_bh(&ar->txmgmt_idr_lock);
> -		dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len,
> -				 DMA_TO_DEVICE);
> -	}
> +	if (skb_cb->vif == vif)
> +		ath12k_mac_tx_mgmt_free(ar, buf_id);
>  
>  	return 0;
>  }
> 
> base-commit: 32be3ca4cf78b309dfe7ba52fe2d7cc3c23c5634


