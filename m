Return-Path: <linux-wireless+bounces-30395-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3ACCF7A79
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 11:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10E8C30022E8
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A052DA762;
	Tue,  6 Jan 2026 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ciUsSU+h";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kNcWIUq1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3930DEA6
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 10:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767693686; cv=none; b=cK/iDzJgdp0mSS1MqJddZCWkxOL44RRZbsWcsohrXHTZc+7qxWISBUYxvUbl8BzE7dvcrAjH5YoVC+c1RiW/sRb4lFEdy4pVGQ5ZXCc5qUTfEJBcakPbBWUxUFM/0irtGoR9cEUdwbOPg7llXZhMVSaEjzd8tUzrUvJ7L/VmmMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767693686; c=relaxed/simple;
	bh=TEtCtHsqRpP9qf3468gIVgZon8mhEIVv+VTFec6/RCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE7HpysnUEyiZGyo6/NqJKZZXx1VMInqRe5cJIfvnPRGUVwsjZ9YhJmIZMuSESQqfZe0iYGDfcZmOrVWP3o1Lvil+IAdQqRIJKG0HqHtXkfVQz+PC2zi3EDG5lOwV39yXkhG9tvDZYyEcafUpfckepoGcXo8CqgmC34HqOo04zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ciUsSU+h; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kNcWIUq1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6066tXrX3295997
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 10:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j4HKFWWo6W7gPbfh2tN5wFUcJzGeLsVtA756B0bDLos=; b=ciUsSU+hN0+irebs
	HeY9p2tv99RJ7fijeXMhdb03i+Pr8ewvCkXs3yXV4sN9eS/fXIAVIyqpJ/fcoDwI
	hvLWFX3k+mHxSr5KTqhYp3UPut5BTfaoJ6Il0P44Koqb/tI2KjZTjcJs+2dsUUwD
	qHmDN3LssnS3WyW3YyY/c5/jOtQ64UTMydaot83INJHV9LimEzroZIRDgvSWuJ4k
	0VQ77N+VooGhc2G76dM2ycGCXSqQWZ7PeArFRApgaJG0Bu+banN8DacQp/aFt/UA
	34oMH3DfjhmaA78rvZn74YwLg9aGtT/QlKymOrFakMClP+yT8Q3RLcrZjQEElecg
	thYQdg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bgwj00jj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 10:01:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7c1df71b076so1728846b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 02:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767693683; x=1768298483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4HKFWWo6W7gPbfh2tN5wFUcJzGeLsVtA756B0bDLos=;
        b=kNcWIUq1aO9O31ki7spyXE3Jte8gfE3vsa7NbMTOAhUNT3WOR3nehVd3n1tEY0fPjI
         VAH6b08sZ/LXd//e/IKzsBRgnaP56/0bIZt2gEEDYl7rCKE+H/Tgq43rnf2aMh/uD0x8
         hOgCCsxq9Mu+3ooJn4wJjCcyxX2bZIjLGwYjAwemcfRDGJc6x3B6faTEteCSmapqpcz6
         QTIK+P8BovwHHUgnF7xKP+/ZOOWDTV5vVeOpVCBChAyqYv3qLxQ7Br9PvQ2YLx8axJaW
         epYthPqDWcgrKAJxFex6kiY7mKHIN0MXe91OoZAzcaTaMrqTSujs95DRilJcXbTgrHDv
         YrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767693683; x=1768298483;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4HKFWWo6W7gPbfh2tN5wFUcJzGeLsVtA756B0bDLos=;
        b=fnxSGuXzlAjwJ2b2YDC41l6Kzak4OooekpvvngN76PUd5jbuKpti9c78yMmQKNovoP
         ZSNlHP4wILwlDUdTP98NhnSqL0+Jotc58ibV2TWDFHyZ4c2EfjOuMTp8Nug1/470dbZ4
         HC2YmmKS6nI6qE965XTjKbAjZMhXViw9c872/xDbJFXGkMEtUPgYR1/Hrf26I0+AYUcZ
         P0TaqlIyz3IkLYmKHhF6pEN/d2dbtHZMqxPBORRxrIlJsditUqJ0CuqL6QMPAH8ul7hk
         TW9B0E5IOrd2dFVwSVpl0GknV3kqD1XGKgEn6y6uiJYdB+Im7XqVsRgm+eN7NqO6bIuZ
         YpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9sSOMg0+BDYErsTYLfZ+ahZcwn90BYwx6xIxyTwAPJZEnkZF1n1kYmvZuwlafeT/YvVX/pHwI68wMmBTrvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Uy8Eoim8q/oEb8A9N+jcmgd8cSIU4nTjGJVChIsUhEiY2gXJ
	BbPfDC7cWzo7cqChiHc8gfFEbXHju4o1tMwP7HBELxxLA3PsvmeAbY2efy1WliLzoFVuea0abfk
	B9NNs4xSPf5H5O6EKNoUtnATXsR7tM3Ba3f4RzXjGL72P0xpl0xACaGkBy10Hs1G2J7LaBA==
X-Gm-Gg: AY/fxX4B83ELdLM0VpF/LzIrD+GcPmmlmEhSiiJYcKHHM0PbwMT5mWK5S1Rw5vN7ojG
	sLGBB1IXixe57SMz1T5z3upW8RfHu8tOCjGgZYJdjWIyX3uiaMEeBdPDYcm3GekM+JbcSo0gaAA
	fTJ2rS0U3ewWE94FjzciLbZG3n0mLpVsCCc1CKMtvv70b2eJM61G83s7+drZ2efRoCLILhIfpaE
	I+lUHszHNk9Lg3dzeuZrJWBqjfGViIWmOTaYUA6aaExmF5vSdswt+H0jP813x5z3LJJlKB6/ErQ
	k4qFJuhzxN18PG/ynqrhGXnAluQmgSy3URSMol2l9Q/4SImE7vdmtTJvNh/l7xpcPZZUtayO3M3
	2prQ16lOb5xp9mAYMdhCvjLqRkdobE0nRN3OowTIMzxwpX6JOrGAdwbJgsitrndObmu2YZswzqZ
	5ZvOPO6w==
X-Received: by 2002:a05:6a00:1c97:b0:809:33e7:5d89 with SMTP id d2e1a72fcca58-818832c940dmr2279578b3a.64.1767693683503;
        Tue, 06 Jan 2026 02:01:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpJVZcGU/yMmbSm8cCO+VvvqV91A5JT4ce5P4ZY5G0vL39xcSvsOISQdH6C11AWWGi918cYA==
X-Received: by 2002:a05:6a00:1c97:b0:809:33e7:5d89 with SMTP id d2e1a72fcca58-818832c940dmr2279545b3a.64.1767693682930;
        Tue, 06 Jan 2026 02:01:22 -0800 (PST)
Received: from [10.133.33.54] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c5301416sm1701367b3a.38.2026.01.06.02.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 02:01:22 -0800 (PST)
Message-ID: <ef342a0e-5f04-442c-aa4a-3375c6023547@oss.qualcomm.com>
Date: Tue, 6 Jan 2026 18:01:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: ath12k: fix dma_free_coherent() pointer
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260106084905.18622-2-fourier.thomas@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260106084905.18622-2-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDA4NSBTYWx0ZWRfX195kxtK2ui5Y
 fzaj5DKvEIS1sndZzsfe7IPuMQGrmDcWgR8DGA2MRDSQ3kvqWuNbdl4j+SIQDtvo1vxHzPdTfsA
 6IQXLNLBH2KvH07ZWE4lMvSXDk3wNgRe/JVuKAoEmiQnev7Ypbo7R4pWcoxbOmhhB26w19C1v82
 3vyIRJMqC6XhNhh8fMZHC1LS16gSU/cneXmmiigOecNI4QqQ6m1cscstfDVjW4GpvbJEzeSL6gM
 U2zpyiYNKDtBzHfXQzG0+WpvLTItfeVo5uBvg3os6ogFJM4BNkVEuOWP3OU/wwjR6IV/0GVyFnk
 xJaFcgtxnzO7Ry6YjPTymjjgAaGxt+YYtYZo8PmBbmu+tFbckaXGWM0cFa423zufRmd/cJdr1x8
 tE6/h8ok6CPtbaF+rlgVsn0nLcU65PAyHNOjvNA+qMfpIiYLE+toOURCeMTdh3+K3mdauFiJ1m4
 VxKR5NXt62//tln+5aQ==
X-Authority-Analysis: v=2.4 cv=bdBmkePB c=1 sm=1 tr=0 ts=695cdd74 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=MvB9iNEEFr4mKuRVMNwA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Qn17jBjz3kjsiI-kI_Ncjt_QwmXvyuYP
X-Proofpoint-GUID: Qn17jBjz3kjsiI-kI_Ncjt_QwmXvyuYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060085



On 1/6/2026 4:49 PM, Thomas Fourier wrote:
> dma_alloc_coherent() allocates a DMA mapped buffer and stores the
> addresses in XXX_unaligned fields.  Those should be reused when freeing
> the buffer rather than the aligned addresses.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/ce.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
> index 9a63608838ac..4aea58446838 100644
> --- a/drivers/net/wireless/ath/ath12k/ce.c
> +++ b/drivers/net/wireless/ath/ath12k/ce.c
> @@ -984,8 +984,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
>  			dma_free_coherent(ab->dev,
>  					  pipe->src_ring->nentries * desc_sz +
>  					  CE_DESC_RING_ALIGN,
> -					  pipe->src_ring->base_addr_owner_space,
> -					  pipe->src_ring->base_addr_ce_space);
> +					  pipe->src_ring->base_addr_owner_space_unaligned,
> +					  pipe->src_ring->base_addr_ce_space_unaligned);
>  			kfree(pipe->src_ring);
>  			pipe->src_ring = NULL;
>  		}
> @@ -995,8 +995,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
>  			dma_free_coherent(ab->dev,
>  					  pipe->dest_ring->nentries * desc_sz +
>  					  CE_DESC_RING_ALIGN,
> -					  pipe->dest_ring->base_addr_owner_space,
> -					  pipe->dest_ring->base_addr_ce_space);
> +					  pipe->dest_ring->base_addr_owner_space_unaligned,
> +					  pipe->dest_ring->base_addr_ce_space_unaligned);
>  			kfree(pipe->dest_ring);
>  			pipe->dest_ring = NULL;
>  		}
> @@ -1007,8 +1007,8 @@ void ath12k_ce_free_pipes(struct ath12k_base *ab)
>  			dma_free_coherent(ab->dev,
>  					  pipe->status_ring->nentries * desc_sz +
>  					  CE_DESC_RING_ALIGN,
> -					  pipe->status_ring->base_addr_owner_space,
> -					  pipe->status_ring->base_addr_ce_space);
> +					  pipe->status_ring->base_addr_owner_space_unaligned,
> +					  pipe->status_ring->base_addr_ce_space_unaligned);
>  			kfree(pipe->status_ring);
>  			pipe->status_ring = NULL;
>  		}

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

