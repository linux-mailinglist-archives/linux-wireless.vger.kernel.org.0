Return-Path: <linux-wireless+bounces-21901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A6FA98322
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E667AF849
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B8728E619;
	Wed, 23 Apr 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dGfYKXuG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9F28DF1C;
	Wed, 23 Apr 2025 08:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396126; cv=none; b=Ax2zZECXMfbEyacPeKQAl2nRNTWQcJRNRO6Z0C8g/KLHrt5Jqy1e+2m73EZVs/VjR+F2OdfKAeFpBkV9TEdfzJ3G2/ETn/i9dJGTLW0AT294Ns7jivn57YEtKOlxQus91jdKhniB74F9WPkZjcj11x/SWYXe10v7SrUiJ8FVKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396126; c=relaxed/simple;
	bh=JREAk/5888oU3fX4u/afdl96Aiwf0b+fAZlav0DmLbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dkPm1Ow2t8j4ywRTi8kbyH3H6KdP198uYB0NXcKhdj4rKxYpBsoDwpx8f/LroNp2FiKHMxt1qaXPefsh1O3VVewUKrgrSQsh4Gf08ci9b2csyAnS+EwY4B8HMmg8L5weyov0+AQVdKJsN9LwS3O2XSNMKaCP+zuEqWK0xMvSE3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dGfYKXuG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0i8p4011273;
	Wed, 23 Apr 2025 08:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qZ4dAc3zEs2+CWBeqQ9MAC8977LAguWV8px1Fpbg/Q0=; b=dGfYKXuGiw0LeGG8
	+BInR+ecNMN0xDN8Ak7nUrTLlvUYtEeWFFgmGnsHmMpNBM+EBIaN1MIpVON5cOme
	pjnSwY6WvGwyQFXwOR2rWYy9OMXyOZJrxZkKSu2qhBgZ6Pkc7TIH7GUYaz0oXXhB
	YT2eV0REtGAI+sBVTTNw7zj8HzQJfN7jLyH/tVvlPBktfDIm5CvLzd3Y/v9GqzHf
	2q+ZPT0EwByjYED4BADB9D9QuD+e7lDN8Wo0DtPuAPRly+buoHtM8leFHHgCT9+h
	K8U2uT1QUEbrLtC9+gT8a4p9U9U/HIxCtjZ5uvtNwKlC2kyscE5JOntQ1wgnA69O
	Q5mD6Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh1hd3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 08:15:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53N8FFtA006573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 08:15:15 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 23 Apr
 2025 01:15:12 -0700
Message-ID: <f98ed1af-e190-404f-a2d2-aa64a712e7c2@quicinc.com>
Date: Wed, 23 Apr 2025 16:15:10 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: Fix memory reuse logic
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jeff Johnson
	<jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Anilkumar Kolli
	<quic_akolli@quicinc.com>
CC: <kernel@collabora.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250423065931.4017574-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250423065931.4017574-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0rT3HxEE1QY2ANCXM7tXp71xeZqJvl4D
X-Proofpoint-ORIG-GUID: 0rT3HxEE1QY2ANCXM7tXp71xeZqJvl4D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA1NCBTYWx0ZWRfXzbTBBl7K5xjw LdVxx8ZDjUqMuKiq5Q+JPJYBn7YHJcjzZeW97QvJVde994MA6RIlqABITgdyO/1G6WxU0RVPE+F clXy05Wv7ycKz3P3UUrTIKC6s1QiL5GNIAojYfLngoueQUDw5E9ymOLgz2zpI+BxO5sYJdqmhVP
 G1dl5D4+5UHlGVzd8bHHceLNYp05uQNOMAAeniQP/gv5XyfWXPhpVojGE4JXXOaxsTMr/ScUtsL SOBf3rDJL29YqNT4fLQXtgOeNeGd0JrQUmguvpONs9JdDYYLSvwzdZ/PAJKxxCk84YZDKVu//kr NyRKhBkNm30fpbV7FbAETyElf3u3PRBLFpQSjN1j0hAn4yutzZeQL5c0P+KuXBMm3QCMdK1f2Sj
 cMXegOeb56iBEAHEztvyBvUB2i7YQwL6VeJiYFKQ4JcCJnnyhYtKnlfOUIJg3yBotNRdJeQy
X-Authority-Analysis: v=2.4 cv=ZpjtK87G c=1 sm=1 tr=0 ts=6808a193 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=jXdBDdtSTMXgVRb5xNEA:9
 a=QEXdDO2ut3YA:10 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230054



On 4/23/2025 2:59 PM, Muhammad Usama Anjum wrote:
> Firmware requests 2 segments at first. The first segment is of 6799360
> whose allocation fails due to dma remapping not available. The success
> is returned to firmware. Then firmware asks for 22 smaller segments
> instead of 2 big ones. Those get allocated successfully. At suspend/
> hibernation time, these segments aren't freed as they will be reused
> by firmware after resuming.
> 
> After resume the firmware asks for 2 segments again with first segment
> of 6799360 and vaddr is not NULL. We compare the type and size with

suggest to rephrase as:

After resume the firmware asks for 2 segments again with first segment
of 6799360. Since chunk->vaddr is not NULL, we compare the type and size with

> previous type and size to know if it can be reused or not.
> Unfortunately, we detect that it cannot be reuses and this first smaller

s/reuses/reused/

> segment is freed. Then we continue to allocate 6799360 size memory from
> dma which fails and we call ath11k_qmi_free_target_mem_chunk() which

it is odd with 'from dma' ...

I think just say 'allocate 6799360 size memory' is good enough.

> frees the second smaller segment as well. Later success is returned to
> firmware which asks for 22 smaller segments again. But as we had freed 2
> segments already, we'll allocate the first 2 new smaller segments again
> and reuse the remaining 20. Hence we aren't reusing the all 22 small
> segments, but only 20.
> 
> This patch is correcting the skip logic when vaddr is set, but size/type
> don't match. In this case, we should use the same skip and success logic
> as used when dma_alloc_coherent fails without freeing the memory area.
> 
> We had got reports that memory allocation in this function failed at
> resume [1] which made us debug why the reuse logic is wrong. Those

The link is just v1 of this patch, it is not the report. If there is no public report,
just don't mention it.

> failures weren't because of the bigger chunk allocation failure as they
> are skipped. Rather these failures were because of smaller chunk
> allocation failures. This issue is in the kernel side as because of
> memory pressure or fragmentation, the dma memory allocation fails. This
> patch fixes freeing and allocation of 2 smaller chunks.

I know you are describing why you start to debug this issue. But I don't think it is
needed in the commit message. No matter kernel allocation fails or succeeds, the issue is
there, and the description above is sufficient to make the issue clear.

> 
> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6

blank line needed.

> [1] https://lore.kernel.org/all/b30bc7f6-845d-4f9d-967e-c04a2b5f13f5@collabora.com
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Update description
> 
> Fixes: 5962f370ce41 ("ath11k: Reuse the available memory after firmware reload")
> I think we should keep fixes tag as ^ claimed that its adding reuse
> support. But it left a bug in reuse which we are fixing.
> 
> Feel free to add it or leave it as it is.

Jeff, what do you think?

> ---
>  drivers/net/wireless/ath/ath11k/qmi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
> index 47b9d4126d3a9..3c26f4dcf5d29 100644
> --- a/drivers/net/wireless/ath/ath11k/qmi.c
> +++ b/drivers/net/wireless/ath/ath11k/qmi.c
> @@ -1990,8 +1990,16 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
>  		 */
>  		if (chunk->vaddr) {
>  			if (chunk->prev_type == chunk->type &&
> -			    chunk->prev_size == chunk->size)
> +			    chunk->prev_size == chunk->size) {
>  				continue;
> +			} else if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
> +				ath11k_dbg(ab, ATH11K_DBG_QMI,
> +					   "size/type mismatch (current %d %u) (prev %d %u), try later with small size\n",
> +					    chunk->size, chunk->type,
> +					    chunk->prev_size, chunk->prev_type);
> +				ab->qmi.target_mem_delayed = true;
> +				return 0;
> +			}
>  
>  			/* cannot reuse the existing chunk */
>  			dma_free_coherent(ab->dev, chunk->prev_size,


