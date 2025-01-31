Return-Path: <linux-wireless+bounces-18256-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7525DA2450C
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 23:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D71461887CD0
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 22:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F391C5D74;
	Fri, 31 Jan 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Go/qP/sJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883921487E9
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738361403; cv=none; b=aZXmoWZmmG4z6tw7fsDoCGonWg/14uVZnZq9+psxarDwqDPsHdJfWmMmFL/ukEHJhKJw+KouA6xQKC2LRl6rsRQCKYTHa/8EtWQIVAotZ9oc6ZL9mKPMgMLrptC3UwHpK8LhpMLiqWWHxyDqFsY2Scd9KMhvfbZaKMhbVHyZ9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738361403; c=relaxed/simple;
	bh=FDOH1xAtgOz8Xd61rj1a1/4t3oH6pgjU1v1tOWC8dMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuxYQByWOwqL7ActANNKNaM0lWk17F3tMADP2ILJ1BPA1Dh/FlbHTLoIGsVTzyMi2q8YROOaiROLLxk1bWhmzwGFZuTydUcQAVmfZKk2ZJEVgK8uSJqgu39LcidQWoK5BLlXpk8Xg46SbR+Y0pdZqQilVT++ybwEWaFnkrRsZsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Go/qP/sJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VDL0o8016186
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 22:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YzrLG4JS/fWwtEHwbff15586VvIk96Av9ZQboWCAQg0=; b=Go/qP/sJrqawnM/k
	N7kNhnRIiZrhnzEGxHZOZAAROvnvhZv2/2pvJwoWKyPZtLZV+gexOt834zwxIGYO
	VfKrbgRLEz0tGq+3WznOfwTjv38wIparg1SRFcPIZMqT4BNlcJdRktRUPdSoaSXu
	kRBoiB9M3l7mmc+1V8aK7banke7Gy4okmD/9o303UbXoeo4cLZcv0oBJuboc4/AT
	+I2wj1QAzdBaBBQ+z+gdL3K/9o0798jL602cskG88rIplogZtwzgv4JkgfwkK6o+
	/6zuBGg9cJIULBUaH0a+xW1i5aEsQflIiLDXz4/yey1Msy0l5A80OvUNMhW98+LL
	85YCSw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gyau946s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 22:10:00 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso6729697a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 14:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738361399; x=1738966199;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzrLG4JS/fWwtEHwbff15586VvIk96Av9ZQboWCAQg0=;
        b=cmQwWF8QJe8fruJEGreUpL/V/JooCxSWpMM/b/X9ARAcBRifZHvLAY4PenswsvQrF8
         ySTxv8vjP8QI9yhvujqLy5GiZXWXsJBBcYSerrWltIFAeTLbuH9I0ww7Qv5f1YTw0HIG
         SHQ16yuQgp7DXvSCH6VXzWt73wOYYNg4sro3gsbjG0kbcZOvfuoiyeL5GmrgZEYJxLEj
         0RUR1nm6FiM2KBA2BykXlka53I0chEZL4USwVtoRVA3S5lNFxId/kvWXGy9AoXXRPgQt
         CrULTAoaPC+mjtdf2STXx/n1GMQs1m2lLqnvejjAYKkoo7fM6oqGCl6SIwDhBkrdDLIc
         pNRQ==
X-Gm-Message-State: AOJu0YyImb/6UP9WvZ1yFbhMKbPOqi+HTGJH58cAaqTkmqoGBAZV6X5X
	pGI/1r+W68dzlUraF6eATCy+ymSzCxGylacN+ZGHEd3Z+2lXIjdlzbvF/pQLoIYOeC5LHD/1hlr
	C8tkPt6WZm1QGbb6Xa7Lz9j/FuzjuRCZ7tSvXUn7AiSdxaiDr5IJHYCCt8ldc8a69/GPyj6q/jw
	==
X-Gm-Gg: ASbGncusSxRDKnbk0XNPHZHbJmRAI+V8uTC+LcITCGTceNZufaiZxa3we9kvzqlbhDg
	pPvGcbPpOd96twU1hKLN7WNrXr4q1hTWLJnM5LTshBAAte3wZHbXdBho22UIsnTBxPwR18Ssv75
	RzWfmZiItL3kK9VWZFkmWhyIckLLY9sUStiCgQYFdj5qvworHInGI3vuKLb94xdwECct/hDtM4J
	1lGYYISLz1FlMP19P/YkWeTuQGtDKV7JPkmq1d0O7UqZ1ObGlVwdjMG7r0ZAngtGenhpqk6ltdi
	RZNk9mPSDF9fhh0bOREQFbQUeOPpjBgkSJ0yDHIMQG1S8C+Y6+AGNFL8mqCfm1/zH26/qzEv8Q=
	=
X-Received: by 2002:a05:6a00:3a0f:b0:724:db17:f975 with SMTP id d2e1a72fcca58-72fe2d5eebamr12841877b3a.12.1738361398509;
        Fri, 31 Jan 2025 14:09:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFA58tVXyHxvzv49/ZX/BxOfEGx1wGjFS+5r8qwLEN8Na08t/yBZwAowGpK6CHqZAm3x4i9sg==
X-Received: by 2002:a05:6a00:3a0f:b0:724:db17:f975 with SMTP id d2e1a72fcca58-72fe2d5eebamr12841842b3a.12.1738361398028;
        Fri, 31 Jan 2025 14:09:58 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cf267sm3907978b3a.147.2025.01.31.14.09.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 14:09:57 -0800 (PST)
Message-ID: <6c4d37a2-8f67-4b5e-81dd-eb61f9b46dec@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 14:09:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: support average ack rssi in station dump
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sivashankari Madhavan <quic_sivamadh@quicinc.com>
References: <20240514124949.2197384-1-quic_ssreeela@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20240514124949.2197384-1-quic_ssreeela@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: x2_tIb1YxBHmjz1BdgNQu7Eqae8XPdPt
X-Proofpoint-ORIG-GUID: x2_tIb1YxBHmjz1BdgNQu7Eqae8XPdPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=968
 clxscore=1015 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310168

On 5/14/2024 5:49 AM, Sowmiya Sree Elavalagan wrote:
> From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
> 
> Currently, the ACK RSSI value is not shown in station dump. Enable WMI
> resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
> management TX completion event from WMI. Update ACK RSSI value obtained
> in management and data frame completion path to ieee80211_tx_info. Also
> advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
> register to mac80211 layer so that ACK RSSI is added to station dump
> message.
> 
> Example output :
> Station 00:03:7f:12:cc:cc (on wlo1)
>         inactive time:  600 ms
>         rx bytes:       288106
>         rx packets:     1446
>         tx bytes:       41818
>         tx packets:     342
>         tx retries:     64
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      602
>         rx drop misc:   51
>         signal:         0 dBm
>         beacon signal avg:      -44 dBm
>         tx duration:    0 us
>         rx bitrate:     1441.1 MBit/s 80MHz HE-MCS 9 HE-NSS 3 HE-GI 0 HE-DCM 0
>         rx duration:    0 us
>         last ack signal:-51 dBm
>         avg ack signal: -50 dBm
>         authorized:     yes
>         .......
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

For some reason this patch was deferred in Patchwork.

If this patch is still valid, please rebase to current ath/main and repost.
Make sure to add 2025 to Qualcomm Innovation Center copyrights.

/jeff

