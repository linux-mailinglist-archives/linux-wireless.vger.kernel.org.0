Return-Path: <linux-wireless+bounces-35113-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKAKHmjn5mkv1wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35113-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:56:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3DC435A3B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 04:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B35533007E23
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 02:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEF3265CA8;
	Tue, 21 Apr 2026 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o9TE/HKO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gsvaIM3n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6726AE5
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740179; cv=none; b=urjc7iOgfXnwb9oXFmnSYm/WVY1UXcB0Lyz0rIh25Xm2M/JMsWaEP7gUBWbYganQYIyecDhBqC0LwBORWoefT2uO6tAKo9vh7jK62/MpZXENlt6APJgPmiKafbPMzstT5Y+2aUOfH79qhiU60vU2gNYBj909D2CMja8RdISgGLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740179; c=relaxed/simple;
	bh=01LHw69CfcRkJCLx0EOLBBPnBBkhBnSq1bf2+egQZ4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ivmbKCdC7dUXCs1qeDE9Hb5bMfIpd0dAWQExfOX9zb8VBhH23FO4x3SQNnCmcxdIcp4v/yGv3vJlNkbFY4+Jmy6udIONEm0TCTuM7F9p9agS3sYloLhhixRjuLBpL9CHd97/bVqkaRTIcGqEpzTnE53vnrmZvNO1PS149ISPzmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o9TE/HKO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gsvaIM3n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJ3ofu1532112
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sEHBkFzrKWkCCiqEO5KBaKRSVTv6hNVHQcN9eRtDTRg=; b=o9TE/HKOuFtD+5zv
	lx5uzoPoborH9eDlwu84CEJVAabpdR7CqrZ10Fiv3/a2gRxhz53IR1tta0UundZ+
	ofy4CGt++wO7Ca+GA3SqqcY0yRhXQpkFGXLZg5BFkwSXTp3eRQN3wRcpvcg8rYkr
	Ja6MBHHzTVKXMJeZr1fE/r25FTonZ21EpzNdONBvqqtJDBdjnio+5ikgSWdQ0w02
	MAfXRUmR1UaJ0QnCfc3/kbxtCu6Uv0gZVIiJQpvFLUtHCIp678MXuPyoEkQs5xoB
	HeaUNQjxZoUPn/hPcslU+9M5N8knJjeGb/j/3f0+rS0pLgY5Y9wqJ8HoTe4NGYc1
	siR6MQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfus42gn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 02:56:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b241be0126so75616305ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 19:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776740177; x=1777344977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEHBkFzrKWkCCiqEO5KBaKRSVTv6hNVHQcN9eRtDTRg=;
        b=gsvaIM3nruQYyMznt0NdYnrF+NfX1am+bFJ0L1ce6cY9ECQ8Z1eDskYUubOyFNFID6
         opfrugHnletzSWRl3KC1gKtWZkp1Ise+DN4G9tsh6IhaqYrKVl5C/m85l5EltaZkIU1L
         gwuJkdVA+iFo4VGqdQykeKQHwv4zzKdxE4tOygDq+GfHCOaH8sbs1LtKqfa9IrjbT117
         oaTU0WmFT3xKRzOjBWltxQmihBFdi66qWAsw7jYkEGOwJG4apCsJnGN3y/34z7CNjd7u
         FOB5sFtDA27AsHFmMDOgQE4RXbJmtWc7A/b0gfXZV8hchK5C+PGppWIsr+cKXAoMTKh1
         BKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776740177; x=1777344977;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEHBkFzrKWkCCiqEO5KBaKRSVTv6hNVHQcN9eRtDTRg=;
        b=JCW5nn6hfoW+wZkd2XDzz10yVWqNkE57aS/T1ZQu0It6M6/pNxdgzgaZCjyIsJcxa9
         crGPOR5YgBbDgDpc2ztGKKfSQZIgHXu115IIJLqZLu/vDEmXj1T412Z7JTSvf2bYWHVp
         MKB2giOtlcdLSjBskmbm/rijhatkNa5/hGhuot6AAViIWlVAJ8b5o0/0OwlUm7BTFSrc
         NXAbxiG2anBLxUbgqYGXcv3NxCUEwTkllvm77qZfEVVUrkAD0G9rf1iJb+6uo2kittB/
         FqJ4ptcwfOkJNIluGcVVfYxGVubW4esqfvoiqrpgOF10XfUf/3a5+SLrygfug2YGKoc5
         c6xA==
X-Gm-Message-State: AOJu0YwtlQaN4tZoutvq8+d9Gi8rlNzSooKQwR9gCSCs35c5D4cGSK27
	VQr0Th4S4QV1Zj8CD4NBWevfXpaetPJsTM9zCtvTaa3kn+XlPBqekhNxc2evsYiHBBoA39L4rPY
	zxtT3Lz6meuoVKkY3GmJEQZoSTg9G1OCNM97Zu9hpeIzDuT0bBXvFy/eaACuuzR5MC4nSpA==
X-Gm-Gg: AeBDiess5eBSzvVp9OuRbtHqrSP8Fs2Ihg9R0DKFY6B48/++o7GY06Whv2cjeXXlaPH
	j5jUecRqKfwOrfvuF3A8khNStBL2BVcAMX+EUnog8w04sBu31Rt+w4asRxsn5V0iMz7BWmxHTHm
	ffIEZW5IYi3rQIuNJEPMj15NefwNVF528RCrb892Pz5iDVN69O4xkUnMx7IYaU9N5TcSI29ZpvV
	YuMubktebpEJ8xY7g7n4xuXUy9X7fqLiHEniKuRGlR9fht2MOEu5dAk6hnSL2ly9q7A8CXxt+El
	c9ArZC3nl8tZlwAyN0HZNCuuDhG9xuvsSGpTSRAW9y1/qvC5zqBJf4iYCv01xtF8f4UOwqIV7ei
	j2EmMh9zGhJLc09KoyMhy1wp74ofvBcKiVxd8qh2ThldlceJZa3bvhSxOnc/8THIdIUe0ALRGM3
	9WgWTMgcL0e7MNRlsaxBzFOpZdeHYkLg==
X-Received: by 2002:a17:903:1a88:b0:2b2:4c92:c389 with SMTP id d9443c01a7336-2b5f9fe62femr175063535ad.34.1776740176956;
        Mon, 20 Apr 2026 19:56:16 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:2b2:4c92:c389 with SMTP id d9443c01a7336-2b5f9fe62femr175063095ad.34.1776740176332;
        Mon, 20 Apr 2026 19:56:16 -0700 (PDT)
Received: from [10.133.33.231] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0dafcsm121756405ad.52.2026.04.20.19.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 19:56:15 -0700 (PDT)
Message-ID: <f77c1e60-d0c4-4220-ba13-fd649a2edbef@oss.qualcomm.com>
Date: Tue, 21 Apr 2026 10:56:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: fix OF node refcount imbalance in
 WSI graph traversal
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260410071300.2323603-1-aaradhana.sahu@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260410071300.2323603-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDAyNyBTYWx0ZWRfXzKRi/RmMAh5d
 hCuidtPF6CYP8e5r2YSbDQUZWBNX+j9DtF45X5wQtS3gcaoqUuP1A6ncCvUHWwVRbHCi7I+muve
 1G69rC0Ckqh/6LtjP9WnINaBagJipYuZjRIh1dHOytHEuzLS3SzRof6EQwMN6aerJGaY3crr9xj
 i5T5+kxDEfnkFB9JT630FBv/K+DbynYvTIbFja4Q47khwixEIAspv5D7OcVVOoThAKLbL2AJy8b
 0hYADMHPz+92lINOXDgulY5lPmd+/Df3ZdgmzD8NrvcBomVttPlSysAMjC8X0xj25717I3/EFvm
 FKznxmpkam/6hwxIjgIhFuQfvZqGENBW3WbiER0pBmtOiRtq6VFbODrvL5DulLQIXXhTpK68fOO
 pVw+7sHH2+ZxiXZHUKF71wLSpsYANwFG9AX3xJA6P7btawe/N/Lhv5c/sgZ6hrTLs9a2sAB5ASo
 NJtQaVyTdw99/5cF+HA==
X-Proofpoint-GUID: D53OcuQFlzGn6Y_30lw7gq940dmgzHlP
X-Authority-Analysis: v=2.4 cv=PMQ/P/qC c=1 sm=1 tr=0 ts=69e6e751 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=UU95pK5i7bRfzSGnuscA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: D53OcuQFlzGn6Y_30lw7gq940dmgzHlP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_05,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210027
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,0.0.0.0:email];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35113-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CD3DC435A3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/10/2026 3:13 PM, Aaradhana Sahu wrote:
> ath12k_core_get_wsi_info() traverses the WSI (Wired Serial Interface)
> device graph starting from dev->of_node. The current code uses
> dev->of_node directly as the local traversal pointer and calls
> of_node_put() on error.
> 
> Since the driver does not own a reference to dev->of_node, dropping it
> during traversal results in the following OF refcount underflow:
> 
> OF: ERROR: of_node_release() detected bad of_node_put() on /soc@0/wifi@c000000
> CPU: 1 UID: 0 PID: 210 Comm: insmod Not tainted 6.19.0-rc4-next-20260109-00023-g797dd36dc178 #26 PREEMPT
> Hardware name: Qualcomm Technologies, Inc. IPQ5332 MI01.2 (DT)
> Call trace:
>  show_stack+0x18/0x24 (C)
>  dump_stack_lvl+0x60/0x80
>  dump_stack+0x18/0x24
>  of_node_release+0x164/0x1a0
>  kobject_put+0xb4/0x278
>  of_node_put+0x18/0x28
>  ath12k_core_init+0x29c/0x5d4 [ath12k]
>  ath12k_ahb_probe+0x950/0xc14 [ath12k]
>  platform_probe+0x5c/0xa4
>  really_probe+0xc0/0x3ec
>  __driver_probe_device+0x80/0x170
>  driver_probe_device+0x3c/0x120
>  __driver_attach+0xc4/0x218
> OF: ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'
> 
> Fix this by explicitly acquiring a reference to the starting node
> using of_node_get() and attaching automatic cleanup via
> __free(device_node).
> 
> Each discovered WSI node is stored in ag->wsi_node[] with its own
> of_node_get() reference. These references are later released in
> ath12k_core_free_wsi_info() during driver teardown.
> 
> Also remove unnecessary memset() of wsi_node array since cleanup now
> explicitly sets pointers to NULL.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 908c10c860e0 ("wifi: ath12k: parse multiple device information from Device Tree")
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.c | 77 ++++++++++++++++----------
>  1 file changed, 48 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 2519e2400d58..980a12fb2c6e 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1838,10 +1838,22 @@ static struct ath12k_hw_group *ath12k_core_hw_group_alloc(struct ath12k_base *ab
>  	return ag;
>  }
>  
> +static void ath12k_core_free_wsi_info(struct ath12k_hw_group *ag)
> +{
> +	int i;
> +
> +	for (i = 0; i < ag->num_devices; i++) {
> +		of_node_put(ag->wsi_node[i]);
> +		ag->wsi_node[i] = NULL;
> +	}
> +	ag->num_devices = 0;
> +}
> +
>  static void ath12k_core_hw_group_free(struct ath12k_hw_group *ag)
>  {
>  	mutex_lock(&ath12k_hw_group_mutex);
>  
> +	ath12k_core_free_wsi_info(ag);
>  	list_del(&ag->list);
>  	kfree(ag);
>  
> @@ -1867,52 +1879,59 @@ static struct ath12k_hw_group *ath12k_core_hw_group_find_by_dt(struct ath12k_bas
>  static int ath12k_core_get_wsi_info(struct ath12k_hw_group *ag,
>  				    struct ath12k_base *ab)
>  {
> -	struct device_node *wsi_dev = ab->dev->of_node, *next_wsi_dev;
> -	struct device_node *tx_endpoint, *next_rx_endpoint;
> -	int device_count = 0;
> -
> -	next_wsi_dev = wsi_dev;
> +	struct device_node *next_wsi_dev;
> +	int device_count = 0, ret = 0;
> +	struct device_node *wsi_dev;
>  
> -	if (!next_wsi_dev)
> +	wsi_dev = of_node_get(ab->dev->of_node);
> +	if (!wsi_dev)
>  		return -ENODEV;
>  
>  	do {
> -		ag->wsi_node[device_count] = next_wsi_dev;
> +		if (device_count >= ATH12K_MAX_DEVICES) {
> +			ath12k_warn(ab, "device count in DT %d is more than limit %d\n",
> +				    device_count, ATH12K_MAX_DEVICES);
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ag->wsi_node[device_count++] = of_node_get(wsi_dev);
>  
> -		tx_endpoint = of_graph_get_endpoint_by_regs(next_wsi_dev, 0, -1);
> +		struct device_node *tx_endpoint __free(device_node) =
> +					of_graph_get_endpoint_by_regs(wsi_dev, 0, -1);
>  		if (!tx_endpoint) {
> -			of_node_put(next_wsi_dev);
> -			return -ENODEV;
> +			ret = -ENODEV;
> +			break;
>  		}
>  
> -		next_rx_endpoint = of_graph_get_remote_endpoint(tx_endpoint);
> +		struct device_node *next_rx_endpoint __free(device_node) =
> +					of_graph_get_remote_endpoint(tx_endpoint);
>  		if (!next_rx_endpoint) {
> -			of_node_put(next_wsi_dev);
> -			of_node_put(tx_endpoint);
> -			return -ENODEV;
> +			ret = -ENODEV;
> +			break;
>  		}
>  
> -		of_node_put(tx_endpoint);
> -		of_node_put(next_wsi_dev);
> -
>  		next_wsi_dev = of_graph_get_port_parent(next_rx_endpoint);
>  		if (!next_wsi_dev) {
> -			of_node_put(next_rx_endpoint);
> -			return -ENODEV;
> +			ret = -ENODEV;
> +			break;
>  		}
>  
> -		of_node_put(next_rx_endpoint);
> +		of_node_put(wsi_dev);
> +		wsi_dev = next_wsi_dev;
> +	} while (ab->dev->of_node != wsi_dev);
>  
> -		device_count++;
> -		if (device_count > ATH12K_MAX_DEVICES) {
> -			ath12k_warn(ab, "device count in DT %d is more than limit %d\n",
> -				    device_count, ATH12K_MAX_DEVICES);
> -			of_node_put(next_wsi_dev);
> -			return -EINVAL;
> +	if (ret) {
> +		while (--device_count >= 0) {
> +			of_node_put(ag->wsi_node[device_count]);
> +			ag->wsi_node[device_count] = NULL;
>  		}
> -	} while (wsi_dev != next_wsi_dev);
>  
> -	of_node_put(next_wsi_dev);
> +		of_node_put(wsi_dev);
> +		return ret;
> +	}
> +
> +	of_node_put(wsi_dev);
>  	ag->num_devices = device_count;
>  
>  	return 0;
> @@ -1983,9 +2002,9 @@ static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *a
>  		    ath12k_core_get_wsi_index(ag, ab)) {
>  			ath12k_dbg(ab, ATH12K_DBG_BOOT,
>  				   "unable to get wsi info from dt, grouping single device");
> +			ath12k_core_free_wsi_info(ag);
>  			ag->id = ATH12K_INVALID_GROUP_ID;
>  			ag->num_devices = 1;
> -			memset(ag->wsi_node, 0, sizeof(ag->wsi_node));
>  			wsi->index = 0;
>  		}
>  
> 
> base-commit: ae530e0b135102c5fc08e64c39e7a18564a52b3e

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

