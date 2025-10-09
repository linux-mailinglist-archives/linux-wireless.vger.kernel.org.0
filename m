Return-Path: <linux-wireless+bounces-27896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B8BC7B86
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C7074205A9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 07:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60A82BE7AF;
	Thu,  9 Oct 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBsk4/pg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8792D0C88
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995005; cv=none; b=KQdZCSSk42UL3YptM5l3eo8gN8yaVlJbYZReeaHnb9fJIzn+t1fAqKrpnO7+YJgC9NshHFQdajJ5E0o8x2lMr4iq4vY2nFQBAfq2Cb4eXcyC85NGEyc0hkGvjKiRIoRF7UfMUAMcMJhq+t33gYfiny/xDlU+X4L3uzUQblDyhFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995005; c=relaxed/simple;
	bh=BOxQzVfurUtNbiobKYbH/CEHDgnzlf8b/5c1dzBffHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rf7uNBiMD04ZAnmfCVe1M68Jd22x4OffHJHxmVVqVQJ6HxfRPysD1OS3uZq391N60APBAUUlSr8QKBVg/B0996Im5oEryNKvTuuXE5fV3I5zZk97Lo4qAepotRGVO+8aZiGd9OHVU76UMiplO2pY6abPukRa3303kj3yCPnBcIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBsk4/pg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EHej029247
	for <linux-wireless@vger.kernel.org>; Thu, 9 Oct 2025 07:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	izHl2XA8Y46KuYAqY1gGV/8UKFs8P8nAtkMQJrm+XSQ=; b=FBsk4/pghzH1KS5q
	IZ5nPyynR2tD6u+r9DgNnGmoTLXEH1iimf4D7AnC1djsutRAT6m5Qx0MxJo4XZgt
	2Urw7PSVTIMLVR9ZBCXzG4m2qbLGwmIWBPBRXdx726h/bzYiiL8+mq8gp38slGjJ
	NZR6D2bFbVuJG9eXEgOQ03e9dn3A1USXjb1J/uuRt3YMeTiT1PT/hTQoexvb8gdB
	T59Pyv+r2aggBBQ9hMjO3nfwnT2yS0ib70zx7Ie/0tVuL5Bl6aPcgkRunJQ3sAc8
	h0R9Fm0U5faRot0SSdFMMkQaOkKTRuRfere98t4fRrzlm8FijlXJyVIX4tk1bBUu
	2z+QIw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nhw8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 07:30:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7810af03a63so2073205b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 00:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995001; x=1760599801;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izHl2XA8Y46KuYAqY1gGV/8UKFs8P8nAtkMQJrm+XSQ=;
        b=b8t/kDtgEh3djR98p7Ro1MB3dC2zo9WD21WbtkeMYKYg3m3IACDqm4ZLHyg6oXBB7l
         uj20ETuw++KPVYoY1ewfHG1k6+h2y6P6bGdvFhcmMT72f9jLp6IfqJyHs6VgXKhqrK7Z
         8XDOryhdaP2TVJZLUUai3eDAKUzB8bhCqK2/+xPv5qP4aNKjbdmkWZDxXI9lb3MXv0pP
         cbUtz2Xd/vjOVJt1F2/mG8MTwL9U2XMwcP6dcNBk6s2JzQ+lx4WYL4cEIZtq903HCdoo
         wlnZ6qt5adej44rrExdNtbAXYbopJTCRi9KJNmfKo1OFH4KXcRolozABh93lcCCOYURm
         vmhg==
X-Gm-Message-State: AOJu0Yxim2Ga2vQ1hSkENTY/XgDaSN97jJactmoI+JtB95tpUxv7f1Uc
	6HM+jXn4/hZUZan1vl1qN1kpsdCGkaHmHMNFyZnogJP/MaZJNMMyQbZu4Xg4brz1W4grqyMSNyK
	9nisKdTIMWbX8jw/vjA5/gGJOMwnJyYC3aUjR388YM4vAPBhU6SV40hW2XHca6e8pVExEsxV5xE
	c5DA==
X-Gm-Gg: ASbGnct9x5XPu4ijyUqQO2xb9cNwAJnWBMuvMlemc3Qbs/kvM0Ps+zjNN5L2eoJTIX/
	QwKWbQHddNlW1dBTeZul33v7jRklgM2J/vuCVTY/lpGohLADUlhIurMCBU5ugEtiCynoazfxwQJ
	CujS693cv0tfv/KrvUGXRrd/oatN8q0VT2ZEdwtyoTbvXVOts7HzvF/5rS9bqSI6a15elmEmLNi
	87fV4zrKMjPJo7IPGVzfG3EtjGhQ74fiTSGqELsUBORidfTm75x1SQ5j3rWVCbikh01p74o4/XP
	f4UC8kg7YgXA8NyBVjciSJ57H/y6MZoGg4ifjVbE+3GrDmNErEH3UeVLqEW5ZOndWqZUfj4XL0E
	mNfXmTWx4lO1Bc4UY7J4pq1xr0FTNjfBwjpq4eAw9PGI=
X-Received: by 2002:a05:6a00:9a4:b0:77f:2de7:eef3 with SMTP id d2e1a72fcca58-79385324dcamr7614566b3a.5.1759995001359;
        Thu, 09 Oct 2025 00:30:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF20Y9+6vH3jpIxlSpjec++tzldizd9+WSgJ4Ckq5PIP+pv/YrbqEOv18ATJmL4B9IcgI6ziw==
X-Received: by 2002:a05:6a00:9a4:b0:77f:2de7:eef3 with SMTP id d2e1a72fcca58-79385324dcamr7614537b3a.5.1759995000798;
        Thu, 09 Oct 2025 00:30:00 -0700 (PDT)
Received: from [10.133.33.228] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794dbc5a1d8sm1928981b3a.39.2025.10.09.00.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:30:00 -0700 (PDT)
Message-ID: <e28f2257-ad21-40cf-b071-60807bef3be2@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 15:29:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: Improve RX Error Handling and
 Debug Visibility
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250930091551.3305312-1-sarika.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX37RHJtIoELYx
 ZfRjnEnziuAzSaYSdAzTWbioZZTX6xuSjMMCts9D1TzJoqZajB18DGWUujuYvMt/wOf4BRxUmM0
 u1HZ83w82dJRlZh4OFECxYHLGxhns8z3ZVdlHdleGlx5WGZJMixm0zgJEuqEA/H+DrrckAh0i40
 nfF5pjJ7vxwuoekGBdn8DtElfvS4xyw7RKWWA6NBqdgkQtLhsHNIfJtm5f1sF1VpA9oapptihfp
 11nmgL8C9VzBJJ/a9ofAhzs5PyuVJFkAGRzYr3iDcJZlZvQ2/h/IkTtqBMRgRP31DQji609xUbO
 9tNczZTt2iAFeT5tOb7H1TskANoRPcL01oP5TkY/F6k0W1xi1G7Q6P4HZqVmckQKVeCrG6uZAw/
 v84+6c4DrbdugJehYNfoTrvTmyzwuA==
X-Proofpoint-ORIG-GUID: aGqWan6bFtxKdA2o4EfMctEKrDCxPkGl
X-Proofpoint-GUID: aGqWan6bFtxKdA2o4EfMctEKrDCxPkGl
X-Authority-Analysis: v=2.4 cv=VK3QXtPX c=1 sm=1 tr=0 ts=68e7647b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=Bq-bgh1W-fqbGKBxPPAA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 9/30/2025 5:15 PM, Sarika Sharma wrote:
> Fix buffer leak and potential crash in RX error path. Drop MSDU
> buffer-type packets received on the REO exception ring from
> unassociated peers, as they are not parsed but their buffers are not
> freed. Add debug counter reo_excep_msdu_buf_type in
> ath12k_debugfs_dump_device_dp_stats() to track dropped packets
> and aid debugging.
> 
> Sarika Sharma (2):
>   wifi: ath12k: Fix MSDU buffer types handling in RX error path
>   wifi: ath12k: track dropped MSDU buffer type packets in REO exception
>     ring
> 
>  drivers/net/wireless/ath/ath12k/core.h    |  1 +
>  drivers/net/wireless/ath/ath12k/debugfs.c |  5 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c   | 72 +++++++++++++++++++++--
>  drivers/net/wireless/ath/ath12k/hal_rx.c  | 10 +---
>  4 files changed, 73 insertions(+), 15 deletions(-)
> 
> 
> base-commit: 58a0a7a45feaf4538841afe8e251737bf7c56607

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


