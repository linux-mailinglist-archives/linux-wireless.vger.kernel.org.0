Return-Path: <linux-wireless+bounces-21095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17CA79248
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013D03B5513
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 15:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91DC2AEFB;
	Wed,  2 Apr 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i83CMuOW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A982E3372
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608291; cv=none; b=XOcMjC4djwoMN/m0YsdNdBBbnXmL5woGvNGORetTa8O6zq75qo+Bt+pM5NLmDmGKYVDmjq6txacunODdWva5zj4jxAmGKadYZ5AhzyAaV+dHWv8n1G6MbkCL6ZpFaHkL7bktfxsjoNJbgHkiEDe4yvVns0oVnl5Vk6w20OlPMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608291; c=relaxed/simple;
	bh=pny6SP7nOOzbuDamPyWu+caVv2TsM0tO5Y2h7J0BAXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDsLVu5yEo9blDpW2GWK5JDeQN7HvIP4yNONhCoImqc3/9geWtA/0UsWs7BgeoGyhVrXHjBdft5eXgteAAqnlubfvcBoeuvstfF0m+MhVYf8dA8peGFKg139kmELn+C6/w/1RvnteKIq0aC5Fh4xTtniBaoSeVklsLnX6xdYBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i83CMuOW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DiGUc007985
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 15:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/GWHIyxo5rvVvPxb93MLiHYfWejVEeyBRIf1dWoTt+Y=; b=i83CMuOWLZOz4gpZ
	okxsCdBTxfKpUOONqhz5utjg7n7Ab5R4t9qEZULejo1xrTc15ZeLVF+VFm4KDZ0D
	xROOWHu5v3LJvApypJQWF8NgOUTKJ/No0zk+w0kux4xiv0zg388BuEYrRI+Rb//h
	7HTxLv5Hri9ZIO9Y2GSAn/2Rr2u+/D4RI/m0gfxXGQjyCIVpO4jRzGsAuZHqpUjV
	72fi6kvIKBpnQCTjfhztf/w97pyqTRL28qkdvp6QXOiIiam3e4IZan6KsczPX5EW
	I55UO/LDka0ACYFOSrTqA8wtK1hNF387OoCQGGNVgDUDccgG5SDX0ZSUb94NxxB6
	IrMzKg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45rxb01uqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 15:38:09 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff798e8c90so11193593a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 08:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743608288; x=1744213088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/GWHIyxo5rvVvPxb93MLiHYfWejVEeyBRIf1dWoTt+Y=;
        b=Xc32Btc221Iny4T8RtYbF6xD01ajv/c7Ymj4v2VHpoxF4rdEsimmxj1O74GcvjFdD2
         M78D+u9QqrAyCs3ma6g/OuxWzvL00fwxbjvhzgEL8N7KabCCQQkjurZN0HogiQn/+KIB
         8LwHeER80Thxf1NZ3Y7uI8jNfTYUfdipLUCZKmeem+Zv9/5JJmFMIU87cmDheO8pT5fa
         jxy/pFMj+OSQNEBrwAx5n+L0Q4rqIxuN6BqjZHPlwXUkCoDKj5KPpoZQrxJRhWa4j/Br
         F9D1bBsG5DEoMCwn8zJNOes+Qks3MFyQXm/MYj6p1n2RRRkhTIwjkGt3WlEmrSHrhPA4
         hB6A==
X-Gm-Message-State: AOJu0YzyRkubf5Qe0qbYVa5yyk79UankXVt3NBJsBI01jHV3sUOhzOpx
	yTrOb8ZPK1KFlgLRqCeA8zWDUdisZbdu3mTCTtoBMRflh15FqhemDm0qmTdK81FXi6Mkk77NxZm
	w5jW0ZRvbNcQcWAk/7n8H9d9aRTb/u0eQvG5EZkjYvrd418Gm4tdPY3a/m32GfQ/Jww==
X-Gm-Gg: ASbGncvRnaPtrJjCNgzyTVnDLK+ALi7eeDeuhhh8plm1YdVNYK3ssPUgJre6ObfiJcB
	ZnONsH5Ili/Yil6xko1jT3R2j4vRqG2YwC7LGNmz70X1dd/EkCIbSAET+N/82MQdNE+5lIt80HB
	vocsckNmav4iAlHieHL5jV+l+3Qgw1TYbtjWGANA8KwsGhYR0hHNlnNQBwlXSUSfaC/OtI5iCz/
	1alUKbEugGCsKTIxpfDV1T4ZMpnkRVzPZZYB4YsAAJYK0j+jrtBR+dKuzfyHa6R5JXSGAwmaA8H
	2YQwQCBkcQCiiGNxqh8jvWb6qhPzsx5+xgwKLquwr6PB2FSfswvz1LGQEToUvpc=
X-Received: by 2002:a17:90a:c2cb:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-3053215d1aemr24637972a91.27.1743608288643;
        Wed, 02 Apr 2025 08:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQMz0BHktFpeCbS9P7BV/d6ICFDH5ZXqLD6hZ4mBJE2QnJmdeBfMkIGHS5ZODAe7dL7rJvAQ==
X-Received: by 2002:a17:90a:c2cb:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-3053215d1aemr24637944a91.27.1743608288258;
        Wed, 02 Apr 2025 08:38:08 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.201.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3056f8a81f0sm1759461a91.37.2025.04.02.08.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 08:38:08 -0700 (PDT)
Message-ID: <70c4576d-7b11-7992-01e4-1f32d6e31a56@oss.qualcomm.com>
Date: Wed, 2 Apr 2025 21:08:04 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v4 3/3] wifi: ath12k: Enable REO queue lookup
 table feature on QCN9274
Content-Language: en-US
To: Nithyanantham Paramasivam <quic_nithp@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250402152529.1649402-1-quic_nithp@quicinc.com>
 <20250402152529.1649402-4-quic_nithp@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250402152529.1649402-4-quic_nithp@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: fZVepgx_veD8P94WYS04xHo5DVmHo-fL
X-Proofpoint-GUID: fZVepgx_veD8P94WYS04xHo5DVmHo-fL
X-Authority-Analysis: v=2.4 cv=BavY0qt2 c=1 sm=1 tr=0 ts=67ed59e1 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=HMRESTvIlCqp6qiEfvMpsg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=BhWuI7cmRP5ft_gkYV4A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_06,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=758 phishscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020099



On 4/2/2025 8:55 PM, Nithyanantham Paramasivam wrote:
> Enable the REO queue lookup table feature for QCN9274 by setting the
> reoq_lut_support flag.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

