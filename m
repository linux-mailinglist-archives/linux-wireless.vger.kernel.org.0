Return-Path: <linux-wireless+bounces-31159-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZS3sGyr6dmnVZwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31159-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 06:22:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B137284275
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 06:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30008300CC3D
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 05:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED5262A6;
	Mon, 26 Jan 2026 05:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3asSMv2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="io6bD7eH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31F29A1
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769404966; cv=none; b=BeFeK97IExwBAqdR7C35Cq8XBmYtWZSJFEtvNWJIwLGGy0476MyDag2sT4KB3VRxvnV21tAtHWXy8mmjhRwDL1n7JwlhjIUwcAfnnEmkLvEsUsKAfYZY4Do3sSz+/OnT+fQSDX3Rdld9rFpQy9w4tY1teneBwO+k45qqJEpOHHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769404966; c=relaxed/simple;
	bh=0IRczU0jwFDyiV4DPppkrG/b7eyU7y3UqudNKhYmmWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9j51p07iI7hOsLcHVE8zrHrscDK8cWJasKZdFoA5UBiBMny09ZsIqU8Au9NW2PO9DG4ho7D/VIaG5t3MKxLMVVq5/hHHm8R+m3CBeWNrJas4AKO9vKADxXRVMHKpfeBXiHs7Rrl5vhXv4k/PEZSFLXmfHFl7FNu8o+5FIJfccM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3asSMv2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=io6bD7eH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60PLuBVa1133292
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nzowBhmh4GyiafgZbDVvPBTe8h+TGbXiR8j+6f8P5zQ=; b=J3asSMv2vynvxwyZ
	ZfhjTWx+/dxzpReukXbBHERknAYxXomhZEgrY5OsLa0EpnfCnNLkQPRrMjmoDVNs
	q2V/ga5W/Zpl5tSH1uw3WPkTuz4B9MOLfhqIBr1EvOfbWxRPcWhwvqg+cMT2P9tN
	TcHT0P8j69/rCITYTeO0LPi09XaidXNhY2Nahy1nafvCmyG1ds0Gjv9vZhQNT2s6
	495I/yOBz9hEXL5PKB0tarMqp0mi5W78O3fimkpZ7/UrMvCmxxl6Xzu7t760QeDU
	LdMgR0AV6tqKe07SfIGkiLkseZlXg/iVwr8PCBezja9thLMUnf3kdKP+yTIUNLxS
	uVbZLQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvq3hbfx9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 05:22:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c63597a63a6so1682207a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 Jan 2026 21:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769404963; x=1770009763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nzowBhmh4GyiafgZbDVvPBTe8h+TGbXiR8j+6f8P5zQ=;
        b=io6bD7eH4s8qTb073QRuUSGlAYPGyNgvtQ63FELsnEOTq9M0aWNCcqBJ3HWI+53k9L
         onpafjCvqnK/sOqLWcTm8uuaU2BMMemgq6HwWgymOo8edExxpHS+B5K5lyBI3u1ZO1Uh
         Ucf/Zf5GeVJ0Fni5RurhB7jY+44nTidQzxgCpXvGevDJMnz6AbHkfLzDs7Y7VuUji4Dn
         2S2PCbm7Qmk49SRcKyeIH6hnBZgT/LWfS7hpszX+72uZkLAPWjpPfgMqy5cCyXZmQVmq
         IDoQKy1FWhGBdCennnOY+uGE1PbPS3w09RwK85WPapoh8tLGv4GJsw26MGU7uksCDD80
         46Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769404963; x=1770009763;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nzowBhmh4GyiafgZbDVvPBTe8h+TGbXiR8j+6f8P5zQ=;
        b=j41ne4Z5ISN9BVenb1hHqheeOgJg2ECH0+VuLr6etOaAysJDBDP+NWns/QjAVsx/mn
         Yn/O5bq/VlRuKrXlgfmaJxTfjq31BfJ4Bv/cXtuffYpRF1uf1fSZcaXz5kJZRLKa6rpJ
         yLQrTl+Coy9Dx3MD7iC6h0KVCbut+23sUxGHcJARTRWPXCXSvGtNxQ45gDXVm+XTd6at
         elB5cBA/yvIcKI5Tiy8a4856tlcoEAYQeN/7nGdudtYqkzKFe0GYQcISTG5NriAO9Vto
         ot0dlsLEwYmUs/BhWdDC1IS1tt0G7UPOgPDsRICUgDAO5PmGcVMzGpmSZEcUb0Z+sxLE
         gKSA==
X-Gm-Message-State: AOJu0Yxj8mcA5mxPTVDlSUxCz9QRt9qNznei9h2QpCWBWLTvNflWt9By
	yrgu+SM6/PXi70S00FboCW27d2MDlkQJShpE1vZ3Vjeg9kaJGSEdlJd9FDCMOOPep5cVYWdTNZv
	XGDNF4YVvSUuYHc35wwbRpor5laCLfsnt6g+IkpHugBysGkmkBpDL/nJ5KrhEf1eLUE1ktA==
X-Gm-Gg: AZuq6aI5Cp/K9y5etrN6eXZHY2TdYjCAyOTMPT5AA79pZOpuhAFtAJ1QhQ9n1mkSt+F
	eI4gl/cedPbIfD/ZvcLrTnfgi7bItP/Y+WO9CesBDbNGS/NNo2LBc2+jglGR1Wy8Wn/jh8yczzT
	YswIM6CdwEr96oUAanvs885x5UGG5gq+XcKQX+jHrioKXrtmXnh8HpoxUyxT/D1EQOw06r7aP3X
	4ktMMxEXF1ucMaQnQ4+1kUax27L+eN5c1niKRd2/wBQLGk7VlkJi3XCXvtBKsIcFUu712VWoprf
	7SEmJu9E/eKbpHUBUeenjuj2vVUML8Bw0Q6XkQDqwRRU1YV/QgxgC4gmj1meXBnFsiVQtVguiY9
	hY4qBkNFTykqfrj0X8DvzcetkbvIe9C1HlZqeISJRw3EKKlGIzIm4UOxL5SL6H277/R47+6M=
X-Received: by 2002:a05:6a21:e598:b0:38d:f0f3:b94e with SMTP id adf61e73a8af0-38e9f116422mr3045930637.24.1769404962605;
        Sun, 25 Jan 2026 21:22:42 -0800 (PST)
X-Received: by 2002:a05:6a21:e598:b0:38d:f0f3:b94e with SMTP id adf61e73a8af0-38e9f116422mr3045914637.24.1769404962124;
        Sun, 25 Jan 2026 21:22:42 -0800 (PST)
Received: from [10.133.33.199] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a142e71sm7592156a12.11.2026.01.25.21.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 21:22:41 -0800 (PST)
Message-ID: <6a3871ae-e926-47cc-a865-a9a1a786b535@oss.qualcomm.com>
Date: Mon, 26 Jan 2026 13:22:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix firmware stats leak on get_txpower
 error paths
To: Saikiran <bjsaikiran@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
 <20260123155750.6007-2-bjsaikiran@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260123155750.6007-2-bjsaikiran@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDA0NCBTYWx0ZWRfX6RcAYouFBP1J
 tF0fMhvmUzw3+mttUtoxoUw70se5wEAHqGcq+K+jhE+H6zbvLChoxLDprQ6ZyRRJsJDebJcLdDl
 RsFCM83WgqDhd1/H5gr3r2XqH2aSclUewpfgBjzgKGVDrXAfnWimY+DqC/SHNdrn20G5SNsUrXj
 5gURIIGLei5OJL32co6MkaJniylEHroydkEbnG28gC6bgGbVXy6CrFcw3THSzbaQAut0cBPS6aW
 aC7Ocso7nrHDgeWBz0SmPzHVLP6miNDwueJi+G3Xq0PrgfFby7CPoAU4slgYd7DWg0ik+JnxoY2
 mKULAduYwl7cuKqeu5UDMzu3PbRXkUIqz/W93n4Eff1VuY7QiilOhmXPQyULE5yCpwGPbqtvbif
 QZ818Outq6oiAWSI+B2+9EGIcd/ZDgNKDXxWWlm+kEDF2dUkmRezj75AvB/Gk8JW7RWAu7XoK69
 xbhJY3Be6MNhDvpi4vQ==
X-Proofpoint-ORIG-GUID: 4tJJFVfuWoX_9MxM9jXl1EbXy7cyMbAw
X-Proofpoint-GUID: 4tJJFVfuWoX_9MxM9jXl1EbXy7cyMbAw
X-Authority-Analysis: v=2.4 cv=c/imgB9l c=1 sm=1 tr=0 ts=6976fa23 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=danhDmx_AAAA:8 a=pGLkceISAAAA:8
 a=oXzjqz-Yo2UKM-P5LK0A:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_01,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601260044
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31159-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,launchpad.net:url,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B137284275
X-Rspamd-Action: no action



On 1/23/2026 11:57 PM, Saikiran wrote:
> The commits bd6ec8111e65 and 2977567b244f changed firmware stats handling
> to be caller-driven, requiring explicit ath12k_fw_stats_reset() calls
> after using ath12k_mac_get_fw_stats().
> 
> However, in ath12k_mac_op_get_txpower(), when ath12k_mac_get_fw_stats()
> succeeds but the pdev stats list is empty, or when the stats request
> fails, the function exits via err_fallback without resetting the stats
> buffer.
> 
> This causes the stats buffer to accumulate data, eventually leading to
> firmware communication failures (error -71/EPROTO) during subsequent
> operations, particularly during 5GHz scanning which requires additional
> TX power queries.

IMO the description is bit generic - can you please describe it in detail? like the code
running path? At lease in
ath12k_wmi_tlv_fw_stats_data_parse()/ath12k_wmi_tlv_rssi_chain_parse() there are several
places returning such error code, and in which exact place is it returned?

> 
> Symptoms:
> - "failed to pull fw stats: -71" errors in dmesg  - 5GHz networks not detected despite hardware support
> - 2.4GHz networks work normally
> 
> Fix this by calling ath12k_fw_stats_reset() on all error paths after
> ath12k_mac_get_fw_stats() is called, ensuring the stats buffer is
> always freed regardless of the execution path.
> 
> Fixes: bd6ec8111e65 ("wifi: ath12k: Make firmware stats reset caller-driven")
> Link: https://bugs.launchpad.net/ubuntu-concept/+bug/2138308
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)
> 
> Signed-off-by: Saikiran <bjsaikiran@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index f7a2a544bef2..4195364cb6e3 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5161,6 +5161,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
>  	ret = ath12k_mac_get_fw_stats(ar, &params);
>  	if (ret) {
>  		ath12k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
> +		ath12k_fw_stats_reset(ar);
>  		goto err_fallback;
>  	}
>  
> @@ -5169,6 +5170,7 @@ static int ath12k_mac_op_get_txpower(struct ieee80211_hw *hw,
>  					struct ath12k_fw_stats_pdev, list);
>  	if (!pdev) {
>  		spin_unlock_bh(&ar->data_lock);
> +		ath12k_fw_stats_reset(ar);

curious how could this help if the pdev stats list is empty?

>  		goto err_fallback;
>  	}
>  


