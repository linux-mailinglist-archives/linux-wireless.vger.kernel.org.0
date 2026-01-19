Return-Path: <linux-wireless+bounces-30945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A356D3A20A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 09:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FDDF3029BAC
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6823134E743;
	Mon, 19 Jan 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EWv9Jb3V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZzMxv7BO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1072350293
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812539; cv=none; b=m/nHcgKli8FC0d9qS4QBvd5hGMF1Gcv+Jit1DqJ8Z5Q+iTkBlFWdf2W5zbxjb2ATRX194mVT6JxV2tM4HDXJVTBFfQporbiy/fwvQgkqJcTJNB3BzSOMNPqn9Y+ZvT5p5KpNPneAoOHc9sr5ZlWcxU5ioU75yQEgV5/zXtMn6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812539; c=relaxed/simple;
	bh=T7668+r1LrQLj2huPAjnuOOPJRGKbQLme/jY57DNpno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUaPrQDB/sQ+7XSJW6M5JIsE0ESzFmpqKxCsDzC4VxDH/ExJm/F6VoRBFnix3ggY6D0rjAQ8fi702cIt58LdDiVyf+JPay1bheuM6TElyXqEA524/MAOSunIzggPksUL1FtugU3uSmROoLu/1N7I1N5g+49Da//CpoPRgTJBzCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EWv9Jb3V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZzMxv7BO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J875H63720736
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 08:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6E1iWiERiA9eoYTJsvFJ9yZtgxiIeuP7mpIDKhfF5rE=; b=EWv9Jb3VBz5MEi6e
	slCa+8u/3QqHODYbU9veCaYr2tYP7hCXBHhnmvnGIDiKWNdFrzAW9ievhNRznxMM
	z/7UCbHhKRDfT8SvcIqz+urml+tVHsNmimPvZosdKVCBK6dCLvzXsF4HMQt1q8B4
	5CD8unwzrp+C2vpVDVCb3vX0rGvNSWLVsqvX+0hVdS9ymSEC2o4BUj3YcgUt2z7q
	iP5AduR+ZAVnyN87dpGmoZDLXor1jEZACH2SOP5rppsJ0JRi1m05+8RwDVgWtqgz
	UcnEm5P98XkD/xN4nkftV87RbRUM9WURhqa9HZYRPf4T4jwuogZTzy1vbxk+NOdo
	KV2xsQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br3q9c8jf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 08:48:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso96127595ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 00:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768812533; x=1769417333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6E1iWiERiA9eoYTJsvFJ9yZtgxiIeuP7mpIDKhfF5rE=;
        b=ZzMxv7BOgHeZxGijJdaLKb0VBp4me38R0Y0iFMq7+jeB8qzuAnySVa4fLra7xJZfFj
         xsaVxN3AertX2ImcyJRLx97GZHicC2bhKSqU9AAhdRkoktOvJGHN8nZv6trk0GGollbv
         Az4fQzLVHgnTN4NFCnAglVzj0Zxel/l8ujdltHvwrl7mT/vOZ0u/IYsrc7c2NI00sAVI
         8GEhS2lseQkBIjTKmlNl/Fvgtz7KmBEe1pthb79cv56BX1/W+cKIGDykROZ2wkLVyPCo
         cHvXegZ+GOgqmciQRZxGHiyIsb7eQqYlSfGg86WJZD00CUs6YKnr8U9QwfRU1NIwfAyk
         Mg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768812533; x=1769417333;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6E1iWiERiA9eoYTJsvFJ9yZtgxiIeuP7mpIDKhfF5rE=;
        b=u92PjSMBZuhtmiXOYuosfPDTFiodu/nG19KgnP4+p7zw/2njlC4TqiYn3adKZX/jfM
         tx3+gXWmkRzh+qx25uuNILlfJn6FOTHJB9pE3Frvz7LWjjsuzGZWycN90GcKNb2rXIZL
         n0ZIpCdcFlGawYOoO2RgrO0ikW0fOBhr/x4qLMNnRMdkqoCbbgDkrk0IosNu8ZS+EcKJ
         +yaeS/uuurYXHqL01MpaHIU01YYEG0Eow/Xpmr4XToiGxxLazHe1Nw+njNNq7GK/U8j7
         NCxAX7TJulxbGze1IB5aCpiKRu3ZhGWv4NdtLQ450yC0gl4wvtDj63GsgRd3CR62lMKc
         uxNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYLHoGaEIkAffHWArliEY8I3d85S6FKSyEKCFWIlVuYBckaEtW8BD5B6A+7/+ILteo4M2FNTZfRmebBHiV8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ZPJeSmPbmQo/5VpRfyQfxAAggYzllOkuguUMHfdBQmD0QOo7
	lK/d3jOtmJKT+3bT7+NzL/rfuYvcMaAXmICO1grfdghMDj5T7FG7uxZeACa2dlDAsjSgV9jeXeA
	1SQnlarNs/e1xHO96JN97kWVHbq6UfZiL6rCUBTx+c7OaUiNNR4IVhRRYrrgSI+XXh9Bzdg==
X-Gm-Gg: AZuq6aKlP18nopVCRF5KIw5W25oKQwhgB4HmyUMT7YOGzMN80RGn26xZ5OeQSd9stuC
	JD28/UY1BU/Inol9aMMToDgfhDjyPgidGnHDBvlffm5CesOZPNd7Gf6LdiEDIMBmlI7ZO0Hgy00
	OLqC+JQn42sRnlgMt6e6g7BTtD3x/BYkgKMaXlkP+UPvUuYAhV4VW6WABbxMyJNLhmF+exNN6qy
	Fl9RqMv+iyUI8MNeT0fjsjiy++d6ZZENxqNIT/vGw/XUGD6MGHzu5KRxE8OtUOeJQ5n9vLIN4xR
	CxoqgMYjus9bk7RaoL4hc2RkgYRHhfFr0wLsk6rGn2xTkcTH/QyP8nPxc5JfH3m0gpiS7W3wlbN
	zBxGCo8mZfA5PgbnItrqxg/zWPle9Dv+9O+4RYj0FIFZ/ozVV8vBv6jmcoS+8J1IcV8f7YHuWYM
	yJ/m67OD0=
X-Received: by 2002:a17:903:2ce:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a717545089mr97863735ad.21.1768812533046;
        Mon, 19 Jan 2026 00:48:53 -0800 (PST)
X-Received: by 2002:a17:903:2ce:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a717545089mr97863555ad.21.1768812532525;
        Mon, 19 Jan 2026 00:48:52 -0800 (PST)
Received: from [10.133.33.150] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ca9d6sm78325155ad.25.2026.01.19.00.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 00:48:52 -0800 (PST)
Message-ID: <b947e130-707c-45f2-aba9-de9c12b73be2@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 16:48:49 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath12k: fix endianness handling for SRNG ring
 pointer accesses
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260119073923.764245-1-alexander.wilhelm@westermo.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260119073923.764245-1-alexander.wilhelm@westermo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA3MSBTYWx0ZWRfX0IU3QKMaGJyn
 a846iOlkBsmpCCDTw9L/V7Unbpoa0IKwZ4X0c5Elywtc68rJmL0ssmW0VrRikJpMd5HqDac8eh/
 aEFof5PVIXD/BM4Ed6K46BE1K1XlLnTopqlJ7o1JUSagBa2pJBD7vcOZR0Z0nL7LFnPVlDCaUvn
 h1sa6yaXLV9/kaaCze+QLFW0CLZIOF0bYcNdOTsNYUnAWUKiZ6A9sCimjSxRf9YHa6os70+nKWM
 15pprpWwmpeuzCsaowHeNO6Ruu/LPRFnK/G9U8sNGFs64SQ8KcW54BXhdyrkPD1cVqMKYyQJqXC
 TabJqnBGhuU2N6O/5ADmCwQSfiXfTBCpOOjY/fkaerOGkR6jey/MGdgM3xSWp1gmDEjMvRbwuH+
 vJ40yyoqb6TVhs7gHRJnj5lSlrKkK1LyE7tN/GGwRiD3V3s+5aA26ipGul2Tude1PqSD3ILx7cR
 B7uNLiUTQue6r7xXw5g==
X-Proofpoint-ORIG-GUID: sq5t12mpWbOJc1wWhAxkbhJTUqMNIwHP
X-Proofpoint-GUID: sq5t12mpWbOJc1wWhAxkbhJTUqMNIwHP
X-Authority-Analysis: v=2.4 cv=dPurWeZb c=1 sm=1 tr=0 ts=696deff5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=N9GNhs4bAAAA:8 a=EUspDBNiAAAA:8
 a=dxIy8T9YzDl2N4HinIcA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=PZhj9NlD-CKO8hVp7yCs:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190071



On 1/19/2026 3:39 PM, Alexander Wilhelm wrote:
> The SRNG head and tail ring pointers are stored in device memory as
> little-endian values. On big-endian systems, direct dereferencing of these
> pointers leads to incorrect values being read or written, causing ring
> management issues and potentially breaking data flow.
> 
> This patch ensures all accesses to SRNG ring pointers use the appropriate
> endianness conversions. This affects both read and write paths for source
> and destination rings, as well as debug output. The changes guarantee
> correct operation on both little- and big-endian architectures.
> 
> Signed-off-by: Alexander Wilhelm <alexander.wilhelm@westermo.com>
> ---
> Changes in v3:
> - Rebase on latest 'ath' master
> - Use always 'le32_to_cpu()' macro for conversions
> 
> Changes in v2:
> - Set '__le32 *' type for 'hp_addr/tp_addr' in both 'dst_ring' and 'src_ring'
> ---
>  drivers/net/wireless/ath/ath12k/hal.c | 37 +++++++++++++++------------
>  drivers/net/wireless/ath/ath12k/hal.h |  8 +++---
>  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index a164563fff28..28d0ff524fc6 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -355,7 +355,7 @@ int ath12k_hal_srng_dst_num_free(struct ath12k_base *ab, struct hal_srng *srng,
>  	tp = srng->u.dst_ring.tp;
>  
>  	if (sync_hw_ptr) {
> -		hp = *srng->u.dst_ring.hp_addr;
> +		hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);
>  		srng->u.dst_ring.cached_hp = hp;
>  	} else {
>  		hp = srng->u.dst_ring.cached_hp;
> @@ -379,7 +379,7 @@ int ath12k_hal_srng_src_num_free(struct ath12k_base *ab, struct hal_srng *srng,
>  	hp = srng->u.src_ring.hp;
>  
>  	if (sync_hw_ptr) {
> -		tp = *srng->u.src_ring.tp_addr;
> +		tp = le32_to_cpu(*srng->u.src_ring.tp_addr);
>  		srng->u.src_ring.cached_tp = tp;
>  	} else {
>  		tp = srng->u.src_ring.cached_tp;
> @@ -500,10 +500,10 @@ void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
>  	lockdep_assert_held(&srng->lock);
>  
>  	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> -		srng->u.src_ring.cached_tp =
> -			*(volatile u32 *)srng->u.src_ring.tp_addr;
> +		srng->u.src_ring.cached_tp = le32_to_cpu(
> +			*(volatile __le32 *)srng->u.src_ring.tp_addr);
>  	} else {
> -		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> +		hp = le32_to_cpu(READ_ONCE(*srng->u.dst_ring.hp_addr));
>  
>  		if (hp != srng->u.dst_ring.cached_hp) {
>  			srng->u.dst_ring.cached_hp = hp;
> @@ -528,25 +528,28 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  		 * hence written to a shared memory location that is read by FW
>  		 */
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> -			srng->u.src_ring.last_tp =
> -				*(volatile u32 *)srng->u.src_ring.tp_addr;
> +			srng->u.src_ring.last_tp = le32_to_cpu(
> +				*(volatile __le32 *)srng->u.src_ring.tp_addr);
>  			/* Make sure descriptor is written before updating the
>  			 * head pointer.
>  			 */
>  			dma_wmb();
> -			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
> +			WRITE_ONCE(*srng->u.src_ring.hp_addr,
> +				   cpu_to_le32(srng->u.src_ring.hp));
>  		} else {
> -			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> +			srng->u.dst_ring.last_hp =
> +				le32_to_cpu(*srng->u.dst_ring.hp_addr);
>  			/* Make sure descriptor is read before updating the
>  			 * tail pointer.
>  			 */
>  			dma_mb();
> -			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
> +			WRITE_ONCE(*srng->u.dst_ring.tp_addr,
> +				   cpu_to_le32(srng->u.dst_ring.tp));
>  		}
>  	} else {
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> -			srng->u.src_ring.last_tp =
> -				*(volatile u32 *)srng->u.src_ring.tp_addr;
> +			srng->u.src_ring.last_tp = le32_to_cpu(
> +				*(volatile __le32 *)srng->u.src_ring.tp_addr);
>  			/* Assume implementation use an MMIO write accessor
>  			 * which has the required wmb() so that the descriptor
>  			 * is written before the updating the head pointer.
> @@ -556,7 +559,8 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  					   (unsigned long)ab->mem,
>  					   srng->u.src_ring.hp);
>  		} else {
> -			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
> +			srng->u.dst_ring.last_hp =
> +				le32_to_cpu(*srng->u.dst_ring.hp_addr);
>  			/* Make sure descriptor is read before updating the
>  			 * tail pointer.
>  			 */
> @@ -711,7 +715,7 @@ void ath12k_hal_srng_shadow_update_hp_tp(struct ath12k_base *ab,
>  	 * HP only when then ring isn't' empty.
>  	 */
>  	if (srng->ring_dir == HAL_SRNG_DIR_SRC &&
> -	    *srng->u.src_ring.tp_addr != srng->u.src_ring.hp)
> +	    le32_to_cpu(*srng->u.src_ring.tp_addr) != srng->u.src_ring.hp)
>  		ath12k_hal_srng_access_end(ab, srng);
>  }
>  
> @@ -810,14 +814,15 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
>  				   "src srng id %u hp %u, reap_hp %u, cur tp %u, cached tp %u last tp %u napi processed before %ums\n",
>  				   srng->ring_id, srng->u.src_ring.hp,
>  				   srng->u.src_ring.reap_hp,
> -				   *srng->u.src_ring.tp_addr, srng->u.src_ring.cached_tp,
> +				   le32_to_cpu(*srng->u.src_ring.tp_addr),
> +				   srng->u.src_ring.cached_tp,
>  				   srng->u.src_ring.last_tp,
>  				   jiffies_to_msecs(jiffies - srng->timestamp));
>  		else if (srng->ring_dir == HAL_SRNG_DIR_DST)
>  			ath12k_err(ab,
>  				   "dst srng id %u tp %u, cur hp %u, cached hp %u last hp %u napi processed before %ums\n",
>  				   srng->ring_id, srng->u.dst_ring.tp,
> -				   *srng->u.dst_ring.hp_addr,
> +				   le32_to_cpu(*srng->u.dst_ring.hp_addr),
>  				   srng->u.dst_ring.cached_hp,
>  				   srng->u.dst_ring.last_hp,
>  				   jiffies_to_msecs(jiffies - srng->timestamp));
> diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
> index 43e3880f8257..ff6148be94c8 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.h
> +++ b/drivers/net/wireless/ath/ath12k/hal.h
> @@ -914,7 +914,7 @@ struct hal_srng {
>  			u32 tp;
>  
>  			/* Shadow head pointer location to be updated by HW */
> -			volatile u32 *hp_addr;
> +			volatile __le32 *hp_addr;
>  
>  			/* Cached head pointer */
>  			u32 cached_hp;
> @@ -923,7 +923,7 @@ struct hal_srng {
>  			 * will be a register address and need not be
>  			 * accessed through SW structure
>  			 */
> -			u32 *tp_addr;
> +			__le32 *tp_addr;
>  
>  			/* Current SW loop cnt */
>  			u32 loop_cnt;
> @@ -943,7 +943,7 @@ struct hal_srng {
>  			u32 reap_hp;
>  
>  			/* Shadow tail pointer location to be updated by HW */
> -			u32 *tp_addr;
> +			__le32 *tp_addr;
>  
>  			/* Cached tail pointer */
>  			u32 cached_tp;
> @@ -952,7 +952,7 @@ struct hal_srng {
>  			 * will be a register address and need not be accessed
>  			 * through SW structure
>  			 */
> -			u32 *hp_addr;
> +			__le32 *hp_addr;
>  
>  			/* Low threshold - in number of ring entries */
>  			u32 low_threshold;
> 
> base-commit: 758064145fe77e06d07661b27dfa9c24fe0309a3

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


