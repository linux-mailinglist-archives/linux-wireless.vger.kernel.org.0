Return-Path: <linux-wireless+bounces-21423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE0FA85418
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6909A387C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447641EFF9C;
	Fri, 11 Apr 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aKWYuWyX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A727CB36
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352756; cv=none; b=b4xeWgIWwfzwiy+oaJ9fF16B+fSMccl7nm3NjNMb6MlVdfKouxW4VIEhr7cJtRfCchlkUAMlWhAuzJ568U5zYl4GgJ7q7B0h87ZlfKjX7UYQE6ptALJax991nKZKsM+krQmIott0E2HsqkGfG4opsAdfMXG2VWkwlQAo0brPVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352756; c=relaxed/simple;
	bh=pOIOMlfdOCqgbv4ET0sq6Ewm0cPBZXchBVAcNqs+FIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGLspC3RTJ/Q6N6bJLWBxRH0yWh1NT8qlBRWDO2q43fKTiHER5IbiO5LL0wPVnBQI7GSs3DdzZ0RrJnc1pdp4RFqWRrMz7SOdIUQk19rdg4NaVAVW0e2KeB83mkdYn30sEJvR2/rWg5GJ4/5AgnaYjCyXp1qANtyGbjm956KNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aKWYuWyX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5o5mA016303
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aZjDG+Namf5hIaFTcyTdEBtA14YlBLkmgXS8yfksRX8=; b=aKWYuWyX2yxT/OBN
	P/Ibec3k9itz6I3HPdwEBMnDAgTvjsWX1uOLnhhUHvCsB+aCmYWXD5pXpZxPzjBl
	SFFEXDc78BReK3y2dinhws2COm1b9RwNqwSEEZP0m/L81eGKLRaHUF2KUjrNwrjH
	+WrG5MSJr4zrEOYCfOR2hTnQq2UtbHLDlI4mbgVGFDwThGzdDg3e6XSZi4Wvbc5n
	tOHBYYdAJOKindMJF0/xBktG2u7PoIkfHF6glFISVYlURkhDnHJrC5I2GqwNk7ti
	HU9JqQ2iKuvyJRcrnGsd1LKFz1WQmkanpQLLBptncyKL431TjndneUq3hVtx6FVn
	+prdgQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1s79m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:25:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736fff82264so1339266b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744352740; x=1744957540;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZjDG+Namf5hIaFTcyTdEBtA14YlBLkmgXS8yfksRX8=;
        b=d9TMPuunOVTbHiGGIQdZHbEU8/dlszVb/z3sqzTWKpPeNVyvdfeHW5u+2U8M/0ikqk
         BAUyoyjhEn3xcMMOB+e43mkENl3hEaI0dB1xK7loP6dqz+1/4jdJcpRVtTW56Xum2ZZ1
         bfpHRm+xgX+QfC01aJI8lnlqyNjt525cH5Hrp9lVola+nd4LZuW7OwciYChTju6CDiQd
         CpZ9G7PzRwW9chG6gzBXTb+8xfGMCUmfsfHz1A4j/AJwCX629MdlUq16XWbXqtruSPoW
         hKqW63Jgc+7z6+KLADDUUVg1d96M+NXi4LtOLoTOJyB8dey9M0O2zGMjgxOQWcgqNVZ2
         p6Ig==
X-Gm-Message-State: AOJu0YwbesfuVje1L1JowY8yt4C9qX1JNZmzdxNyYLvOKM7bW2OFSzVe
	n/Y4Chn6f3dQfv6PRLars/hSrbfxrtD+1g5QPEKOxBGPs0mq+4j1HzDV4i8io3xdEFZJxOQ0JLe
	mbtAcXPAbvg3tvDnNh9EMfUK6nnrQK+DQ4OhAMF7OofnknLIJA7kO/68NJDXvK3ioUg==
X-Gm-Gg: ASbGncsuy58OFFswvkuA5XpKo+LVlu9c6frqkbgw2be9acEaglqxwENaizneZM+R819
	GZTgtaBYlexethj9nglDLaQbdpSeAIGN5BpQobZwzmnuzlwWkHTs426YyDhlq8YT+DFNvrsrFz9
	Afy/sqdcp9wj5O+ZpNeiGBhMebQ8YZcrnt+MHRqJTNJGU+SN+gw5mm38zJl6QKeVPb7zoulM8a+
	PLN6j1krcQCHMii8MD2fbNz5O0sIFbwCQHNkNAXplYfUWBqEvnXAnS5oK60Ans+31SJjnrh8OBQ
	kTA1VnXEc5I+6fNrp/pWWaEnKT+Bg6GKjSalj7SoK8u1GpECisayow==
X-Received: by 2002:a05:6a00:1394:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-73bd0bd4548mr2518652b3a.2.1744352740353;
        Thu, 10 Apr 2025 23:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMA6R59sQ1NqK7igd9/2jNcxA1+RfqvbTNMKUH7nNQfU2hU/UALeZME6rkL6dw0k1o8VMEBQ==
X-Received: by 2002:a05:6a00:1394:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-73bd0bd4548mr2518625b3a.2.1744352739898;
        Thu, 10 Apr 2025 23:25:39 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230fff3sm664098b3a.125.2025.04.10.23.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 23:25:39 -0700 (PDT)
Message-ID: <24179c31-f351-2ed9-2699-d98615742d4b@oss.qualcomm.com>
Date: Fri, 11 Apr 2025 11:55:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v2 2/2] wifi: ath12k: correctly handle mcast
 packets for clients
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250411061523.859387-1-quic_sarishar@quicinc.com>
 <20250411061523.859387-3-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250411061523.859387-3-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yAxA1sw2Cb4qKmoCy4nJPIPkmi6EBt3E
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f8b5f1 cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=aG53odMEPdmtmHfcJ14A:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: yAxA1sw2Cb4qKmoCy4nJPIPkmi6EBt3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_02,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=663 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110045



On 4/11/2025 11:45 AM, Sarika Sharma wrote:
> Currently, RX is_mcbc bit is set for packest send from client as
> destination address (DA) is multicast/broadcast address, but packets
> are actually unicast as receiver address (RA) is not multicast address.
> Hence, packets are not handled properly due to this is_mcbc bit.
> 
> Therefore, reset the is_mcbc bit if interface type is AP.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>

Should there be a fixes tag?

