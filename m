Return-Path: <linux-wireless+bounces-21412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B7DA8527A
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D748A5580
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 04:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E891E8356;
	Fri, 11 Apr 2025 04:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G2+XXULN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD1D3234
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744345634; cv=none; b=PA3qv7FQn0jRM2pBQGVzbX85uGXz+uL5q7Pk1KfdWJS46VRt1lM1dmvs4N0LFGxhhaPK/fnzXpx2ef0yfv2xgdHesi9UwJ/P3E4W6gOetS8+vMR6pKcAiONqXsvABqs1Jftd8anycNvB+bd5HjLAlCgvrm3RhIHEvYiiDO9pmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744345634; c=relaxed/simple;
	bh=9sFKrJReU+VRkPEjOuKR/9D0h7GNwIlk+LQ/tr9UpHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be0b7SRG99o5nNakhIGtBA3dQXhEP05NLNACnsvxXen3in/C38jMSUIzHun30ZjaCk6+RvFONynOsEvLr+xPxye+0A01Uz5R7e/4KcejdAaQKuo9guP0tDhFm0ijh3JAxrXzjGXBCU6MDBUB77m36DnqORpC7icXekIxcjVHZz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G2+XXULN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AG7jTu028877
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 04:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b7t/ukaTibcNJ932Pv/IkSD21w1/bx2HpuMzZkG0EWw=; b=G2+XXULNas2x0X5w
	N6IRTpoaUAaW8cQLdLE+0A2dolCcWBdGFA7JhIWt5jYqDdGSehjEa9xfN6H/RS/3
	JZSKkBnV+WIC6nBcXwVRURYO9CVLRSU8Q4Y25TiQLFhCWwaoV5j/XEJ6ux3nOtqz
	jN9qAhoSUoH0EoQ9FNGRr3ae3+gfPKTvLoddpM1iHbXaQ/j9L5uBwhY7pUQbNcDj
	OwiTxAFG+MIvpiwJ6Ke4fDURA5zC4NkQvI4Lx+7LLu3Nzlf4uMxLcCwNvFmYi3Wr
	AFHjeSr0e3cLWPB3fjRmv1dsCJZc2bCv4rpSuvGirLtAvCGxTQ6eR0kdU5sope4G
	OubmGg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbus5ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 04:27:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2265a09dbfcso24066705ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 21:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744345630; x=1744950430;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7t/ukaTibcNJ932Pv/IkSD21w1/bx2HpuMzZkG0EWw=;
        b=OjYpRqipbbY6AsPPke8SZkzYJzlK5/ltE79vzNitJIlmooetquYfqsp3Ma/J6hMZYK
         9JaXfP6FOzwaz6PNunhTGUH72MSOX/yzKKRj/1qBXBpKw91g9G6b+0rhBhTJBsClT89f
         00mn233JqMNwC7l4ZWYRtMD1CGeb/sEQULNcSx+UlWibvRWNgfc/7+hsgc/J+NLo4xIN
         /hqLxyKgqHvKk3ctMqmc9Uymfsk4ax6IFsrkvnu02DwCd9RhC2Dl4dpyJeY9cyZj8cRM
         OQi+pEsANl63g6+iT+GnXv2EAwjNzHY+6RyQaaujMqrFYLdelgaPVBUbz7zyxucsg60/
         AdQQ==
X-Gm-Message-State: AOJu0YwoJaG2ZYut8R1xiT13e8a3nL8An058UsKoEIEGt5QhsgLw+pdg
	YIs8ukFXVz/Vp/B/Uvj1cSYUpuhySXLRjbtIXXC3FarN1SSpK9Omye/NJHvVu0Q2pmProRESghq
	liJGeRNABuY0aDF07YrLfC54oh/z1pnQExF+3wYa0h1tw4ONKjYcnpmNgPZjp1gF+2lA+WGUWvA
	==
X-Gm-Gg: ASbGncsrFxt2YGkHnSs6V127bdeoBntK01THZwtbipUvOTnIVCWZvDU/+aWryJoY/jk
	dVcQVRjbZoUlfE4icYM4eCUVsxulHDhsyl3/IGGlv69b9535wxHQ5Sbi+UuDRYCoYPB2wVHzKRw
	vsGoRhGvBHs9t9gxZ9Vh/r+1dnqaei4wZc29yAtIkMCUtpcnYvGM5ikTLWaKuH9QGv1D3w4Ionh
	YpItQuTYaeYY2PRb5CYM0pmk/R6UN++IMkKgwnjP6C25lyIpSpzpEaoiegG8OOKeNC8Pn7FIoeJ
	NC0xZw/h9VQ/LzeOp/3nl5C1PRqQ82HUMcZQZPg0o3kCgCm5jId3vg==
X-Received: by 2002:a17:903:19ed:b0:223:4bd6:3869 with SMTP id d9443c01a7336-22bea4ab849mr22176265ad.15.1744345630724;
        Thu, 10 Apr 2025 21:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbnfJDdGzfNkx2X+qdl3WNt6aHUv9phaEYx+WIJwz4vw5L0A5BtoeT67/qccGFe/6CIbt2Hw==
X-Received: by 2002:a17:903:19ed:b0:223:4bd6:3869 with SMTP id d9443c01a7336-22bea4ab849mr22176005ad.15.1744345630374;
        Thu, 10 Apr 2025 21:27:10 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb688csm39489505ad.174.2025.04.10.21.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 21:27:10 -0700 (PDT)
Message-ID: <8da15ec7-2f91-a7e6-7291-7d733880d6b8@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 09:57:07 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: fix invalid access to memory
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250408045327.1632222-1-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250408045327.1632222-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: kqVK5diBHHRKHOhd8ASrdN-0n0qjXLGS
X-Proofpoint-ORIG-GUID: kqVK5diBHHRKHOhd8ASrdN-0n0qjXLGS
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=67f89a1f cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=0XJ0nkoN6fRkH-oyq9IA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110030



On 4/8/2025 10:23 AM, Sarika Sharma wrote:
> In ath12k_dp_rx_msdu_coalesce(), rxcb is fetched from skb and boolean
> is_continuation is part of rxcb.
> Currently, after freeing the skb, the rxcb->is_continuation accessed
> again which is wrong since the memory is already freed.
> This might lead use-after-free error.
> 
> Hence, fix by locally defining bool is_continuation from rxcb,
> so that after freeing skb, is_continuation can be used.
> 
> Compile tested only.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

