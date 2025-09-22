Return-Path: <linux-wireless+bounces-27553-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B42B8EFD3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E7A7A2C24
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 05:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6F31E521D;
	Mon, 22 Sep 2025 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivHhLo6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5651DC994
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758518073; cv=none; b=uy/RuPxBlL9WMTEP6E2u1EQS1zwisqFLZPkCakhoAIhL5whc6ccxHdJxArurEmqk476ZjyLXB6ZJfnAE3k2rSD0RJaaviFSco6gvtA3q7DuOY8wcSKPUUc9oU6YTlSqYBhNjZikNE1WYq9076THsZSZUUcDFS8w3Yn6qjdcHlTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758518073; c=relaxed/simple;
	bh=wvAjjXRp8ffbZXncOQ/lr7gTgf5RhdhZbGnPwkCvIPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vt8Bc9CYxe1CxRi3doUMzulhjMQh2gWtvaBhgk7VqHdvTCk6ZdHtuSu0Oly4G9Uuoj67d6sfrR41MLfT/1aaWc+eFsr0MrV2NOkLrTGjvn0gTBumCSbhXASxJZHLuZY28yHSO7VMbVszumzYqcCBkd3Y6/bgW8kRCUniE3VjvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ivHhLo6Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58LNc556027593
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4t2MbPKeeyTCerO+jZq2CMDKEJKFkfNJ8eZh5BM34mc=; b=ivHhLo6QlpOPXuHo
	Wsuj+7nqsenYgGnx1ZJTcHbwvqN6vlNNvl4IAztNeIR2D76s1U3p8oSlK+YPGJV6
	imDhCy9mCwVXjKVnA5XACMMrowDS6P6NtuzAIFtxRuaST5FfQM+Kzt9Oxt4rbWTB
	IJ8OeZoIr+Ir0vHpHdfjo1RNWD975b73R33uFtxhNSdf5X4BUC32tyKD/0DTu9Je
	6YSvqOly4xhNpjuZNyDNkm5mzzm+rP2/wJvhegYwnRk0q8dNzNtnbfImVheGKiCC
	ouKzBoFWqsNnj4b8R/2ZKO08SHjA1Sm9ot8MPyXwe+9bUBtrTnKMX3lbaDPaz3x9
	yablJA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg33cwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 05:14:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-77daad52913so2950133b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 21 Sep 2025 22:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758518069; x=1759122869;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4t2MbPKeeyTCerO+jZq2CMDKEJKFkfNJ8eZh5BM34mc=;
        b=YWKsUq6rwKNZiWsQ2upeZBJjBbaTxWR4/zLb951SwtirclPXVDruFMN0yZcXuvo61j
         JiPAAB9D7FdoPt6hrtyF3+q4AJjZ5BK2lA8nstbBpWubrTk6Hl+LlDBGtWgK0lrKclvE
         EGE+zQP6u3UuIj8GcnzeS7Vucq31K1xEhSkTiDaRNHswb98lG02uyKxle9gensiOUHkB
         zTVXI6oaNYqEazywvPhc7pkBcSqJad8yYRTzpdLeF2tDRa2ntzrLcZtzeIs7PE19W7rL
         J2XR8euytg3WpGwmhZ5icGdT3q9srU36xnVCuAfh5pDMnxgPIvXdePh+2YcYao6nZ5Pv
         8OGg==
X-Gm-Message-State: AOJu0Yza3XVFhhtqYVAHXa6yqe0N/zCR2leRNX1fNU0pUTEqFbaD25Tv
	9Rw3Jgv4kR3unU7LIrxWpOQshnVw3L/9vspBuQ4qKHGL3W8JMD7DsoyP3+SVee/gduK56h7Kmy3
	K3N24KHuzle+Q+gAq/IUig7aFYhqPsOERV5dyY/sERfIYo16+gK2gLfi6+gABis700ssni8ISAj
	rDLw==
X-Gm-Gg: ASbGnctYENBpgSgE088z+fk9IWZFOidan8iP+X5j6HsUv7fPjZYqadsHhGcrxw8tpDO
	O9q5vvkajP+SXz0H0DvfiqdGK5SAUhwQ9ci6ISmSzhRl9mmyAXGQexHj1Gw3omc51huCEdjlegC
	RLS0M0vtxRpbhuW9wKe8g74J87KnDFvJI0yaPPl0xjAuQOj13vloosqdlP6e9EmjcEg4wtFixhj
	Ar6ALSrNl6BryKO8/Y5nQ7Ywx9JJHVE+1TGG/HHo3OzJQBnPLviybPfQDWBk/HxPMJSaqVFai75
	YKh6JV8j16hf032apNSEfTZbMiDu0ijRT42KiLQ6q6zYcSszE8LVw0fNQ9GPntotRI/y/7+HvAS
	Kl0SJX3yie8hBPG05Px4NNeHztGUB7K5/gEeU
X-Received: by 2002:a05:6a20:431e:b0:249:824c:c60d with SMTP id adf61e73a8af0-2925f75d4c6mr16889445637.20.1758518068660;
        Sun, 21 Sep 2025 22:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjli9PJGgzAEkxVobbRVAo/BmjPvQIrfSHP0w7nF8GqIuv8u+ix93pGvdvoksek93V0d74PA==
X-Received: by 2002:a05:6a20:431e:b0:249:824c:c60d with SMTP id adf61e73a8af0-2925f75d4c6mr16889421637.20.1758518068196;
        Sun, 21 Sep 2025 22:14:28 -0700 (PDT)
Received: from [10.133.33.83] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55396db81fsm4702577a12.19.2025.09.21.22.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 22:14:27 -0700 (PDT)
Message-ID: <aae30f00-1d05-4f3f-afb0-8f4924f57bba@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 13:14:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 0/7] wifi: ath12k: Fix Issues in REO RX Queue
 Updates
To: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250806111750.3214584-1-nithyanantham.paramasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfX0vrsE2iZ533E
 EJR8bw0cRSauehtzxVuELZCag0BGyDz0RTaHPby+Gy0xOCne6+LiDZ8u01TLojPGbUtL+ztma3S
 gzoZn1rdE9n8KGZCYzimlafWUqzbu/95YqrYzjY46+Lx/QfK1+EbIjSz2iVlfKmKBB/T8MeIyeO
 SO/jKozC4hCTZShxX3ntfmZfzVJNQoYDbvF1z8EAF0F4pd4Qz/08mKCYlM8XLxldQQossXds3OH
 4oq+bKZKlxd4jBg0FeoGmJeqyJ7x5ufyC45O+4P9xjK+vFTRHPJhDBb2lYoZCjFkp/k7gHaHQXZ
 fG4fduPgMUGCAnVUw5S1ehB5fREsxO9AVmnOvT7LHBc4E8nKlA7/mrs9DDYMeWrIEP7M7u3PGfJ
 eerhyNsI
X-Proofpoint-GUID: Kb5yoY6o40L8NJN06-McQJ7_18E210fD
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68d0db35 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=xzmuE1EisdE_tCyGCEEA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Kb5yoY6o40L8NJN06-McQJ7_18E210fD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_10,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032



On 8/6/2025 7:17 PM, Nithyanantham Paramasivam wrote:
> During stress test scenarios, when the REO command ring becomes full,
> the RX queue update command issued during peer deletion fails due to
> insufficient space. In response, the host performs a dma_unmap and
> frees the associated memory. However, the hardware still retains a
> reference to the same memory address. If the kernel later reallocates
> this address, unaware that the hardware is still using it, it can
> lead to memory corruption-since the host might access or modify
> memory that is still actively referenced by the hardware.
> 
> Implement a retry mechanism for the HAL_REO_CMD_UPDATE_RX_QUEUE
> command during TID deletion to prevent memory corruption. Introduce
> a new list, reo_cmd_update_rx_queue_list, in the dp structure to
> track pending RX queue updates. Protect this list with
> reo_rxq_flush_lock, which also ensures synchronized access to
> reo_cmd_cache_flush_list. Defer memory release until hardware
> confirms the virtual address is no longer in use, avoiding immediate
> deallocation on command failure. Release memory for pending RX queue
> updates via ath12k_dp_rx_reo_cmd_list_cleanup() on system reset
> if hardware confirmation is not received.
> 
> Additionally, increase DP_REO_CMD_RING_SIZE to 256 to reduce the
> likelihood of ring exhaustion. Use a 1KB cache flush command for
> QoS TID descriptors to improve efficiency.
> 
> Manish Dharanenthiran (2):
>   wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures
>   wifi: ath12k: Use 1KB Cache Flush Command for QoS TID Descriptors
> 
> Nithyanantham Paramasivam (5):
>   wifi: ath12k: Increase DP_REO_CMD_RING_SIZE to 256
>   wifi: ath12k: Refactor RX TID deletion handling into helper function
>   wifi: ath12k: Refactor RX TID buffer cleanup into helper function
>   wifi: ath12k: Refactor REO command to use ath12k_dp_rx_tid_rxq
>   wifi: ath12k: Fix flush cache failure during RX queue update
> 
>  drivers/net/wireless/ath/ath12k/dp.c       |   2 +
>  drivers/net/wireless/ath/ath12k/dp.h       |  12 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c    | 336 ++++++++++++++-------
>  drivers/net/wireless/ath/ath12k/dp_rx.h    |  18 +-
>  drivers/net/wireless/ath/ath12k/hal.h      |   1 +
>  drivers/net/wireless/ath/ath12k/hal_desc.h |   1 +
>  drivers/net/wireless/ath/ath12k/hal_rx.c   |   3 +
>  7 files changed, 251 insertions(+), 122 deletions(-)
> 
> 
> base-commit: 95bf875b89b48a95a82aca922eeaf19d52543028

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


