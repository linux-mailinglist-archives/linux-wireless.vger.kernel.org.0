Return-Path: <linux-wireless+bounces-17447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3E7A0C16B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03BB3A10C0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873531C1F0C;
	Mon, 13 Jan 2025 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="knolYIyA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AACE1B21BC
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796562; cv=none; b=Py+ZMeeUT9cLoqLAtRb4sTxVwoZBJmr0V+eR1g1OS/l4l7GaVPDxe68xEyfl7HBCswFgFoWeZQ2SalM4tT6iyu+oz0sPaIsGYM84JCWLAsCzX72VlYD/wyzczQn1deHI3F8dO05G6GTSRMitTk+TJ6PMfyfd6R+UZlAkmpz7PHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796562; c=relaxed/simple;
	bh=GMmNytS30S4NpXZGdD1FO9aY15kW/PNoPgXnPayuX1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tp6+j7rghCikGgXumSVZ3FvSU3g97WWiJw/XHzolcbUHZ2EwqgWotLqSFhgUxdV9RndIyw1bsW98NhW4R2L4QXfx3AvdAkRbHTsfo9aA5BtckjizLwIS3l8XEnZIwG01rTRUocEvk5grqaD/ghxQHw3wSERrrJZLXygEawL82oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=knolYIyA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DC0vVG000748
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X4JA/i7/OC4FxbT9AIYXFyIoNZebbdXPnSVbrB10s24=; b=knolYIyAmcgG/XkN
	Lo8dbWI5XdN7Tzx8QUy6Xe21PnRoZmgOB1vybELiG5sSgDHcBmzcoYyPHhVYPLlx
	3hJJRKowRLgl8Y/3gaZmL3Kd8NrfmA2R3QyZA5k+r/uau5a3TH3PXm/PiLLLlpsy
	NAQ/SdeAsyaeJdv1A6Fhox4ra7YiJS89D2M7siCx+Qu22W8+TUjt6FzcpL/agZ3i
	hMQXXDzYG+T0CgfqwlDi5E9U04fPoh8J9r1yY63Vhs/5Cjv+4lHYyUtQlAomOxre
	Q7iKUXTST9pQd1ye2723VHOybnPlhfasht0Rr6PCKrwZX1cDC3vH+cnmWrWQdCg7
	1VVQRA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4452f9155b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:29:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2efc3292021so12162262a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:29:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796558; x=1737401358;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4JA/i7/OC4FxbT9AIYXFyIoNZebbdXPnSVbrB10s24=;
        b=E6EZDC5SV2ED2WhEnmE1L4w66ZG4mefTC9gyKguPzHQ9q+/PJUecflXJMivaqnuBa7
         +TwcvP9h5xp/I8rnlgJ+qSbRlp7VT0etq0XYvG+DrOMF1JfMDyOdRzM0BAJAAVHpItX/
         dBUZaY9jrirWZE86c/AyZohXLrTkoOd7aCLrePuTBS+ah4K8o41hglk9ZFZX0UaToty6
         sRMupSRzFV3y1o7Ey1kU6dItjxbht+xa4aF9wor29dvJOb1mDQ2Ebn/nmgwqDqTZbeq9
         sWY1kd0KA+Vk+Hmr5SVVjMG/RuaGAD9fDznap6GYBcmJgYqZ4dMCFAa+5CDBL1BV4ssV
         v3Bg==
X-Gm-Message-State: AOJu0Yy7QpI1b6DxCJM/uELOKb4508RA0OTizceKQWsxebEj1Yd+1TJ1
	K8ezOAtmLO6aL2IqqmSOAmNpV379TltbLPn9nZbZZtx89lFTstZa1KH3ZJrGlZAbd8sWvdhKKDo
	98vvJ73esP0j6OMIosBJ0D4tbOHqFD/bsnJxP6F4ADI6dzBD1tIc7y0+rHlFcZJrd8YEwc17OoQ
	==
X-Gm-Gg: ASbGncvM6YyoXmPdtpVsM3cVMoG01QQVwEUj3KuIxVsEnbnI7HFmXGNgEkAoX3OrfrS
	R+TPnP94w6bRm63bQ2nkdA7CzzCWfIpNkAnh7sf2PwfMINg3a2+HeTTBeLI9FUzbgviHv0p52Dz
	zPs4PFiCn+SzojDD2U9avFrnO9endDCP7ybkcjy7ASyUK0GcTo1tzTix3hFE0Uuc0L97tjpjyH8
	8mOYYY820EU/FWVG9Z//R6XYRz55RTUivNwfXxyWyW0q/kcivtS90JzxNDxuPXG/TQQe+9DAY3s
	JAoq00C2VewF2eC3fow8CxKSbhDa5+3UfFFx8i0XG5hHTQNf9w==
X-Received: by 2002:a05:6a00:340c:b0:725:e015:908d with SMTP id d2e1a72fcca58-72d21f459b9mr28226073b3a.1.1736796558507;
        Mon, 13 Jan 2025 11:29:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlppUWigIhRpncUzBzvJ8sBlojPnSz1ng0GTzw+hkyEacaIw8rHWiKXyR2SM9P0KWeHLPaJA==
X-Received: by 2002:a05:6a00:340c:b0:725:e015:908d with SMTP id d2e1a72fcca58-72d21f459b9mr28226042b3a.1.1736796558127;
        Mon, 13 Jan 2025 11:29:18 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4067f84csm6391821b3a.142.2025.01.13.11.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:29:17 -0800 (PST)
Message-ID: <b5cbc224-8a6b-4c14-a268-09f71b8aa04a@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:29:17 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: Add support for MLO Multicast handling
 in driver
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
 <20250109184932.1593157-3-quic_bmahalin@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109184932.1593157-3-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wKEvMkwJVGg8XFgYhTktcjTdIiCO41P4
X-Proofpoint-GUID: wKEvMkwJVGg8XFgYhTktcjTdIiCO41P4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=703 malwarescore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130156

On 1/9/2025 10:49 AM, Balamurugan Mahalingam wrote:
> For MLO netdevice, the broadcast frame should be transmitted with the
> same sequence number on all the links.
> 
> Per IEEE 802.11be-2024 section 10.3.2.14.2 "Transmitter requirements",
> An AP MLD shall use SNS11 in Table 10-5 (Transmitter sequence number
> spaces) maintained by the MLD to determine the sequence number of a
> group addressed data frame that is transmitted by an AP affiliated
> with the AP MLD so that the same group addressed Data frame
> transmitted over multiple links by the AP MLD uses the same
> sequence number for transmission on each link.
> 
> Currently the MLO multicast handling is done in the mac80211 layer.
> Enable support for handling MLO Multicast in the driver to update the
> hardware descriptors in a custom way to handle the multicast frames.
> Firmware expects the MLO multicast frames to the submitted to the
> hardware with special vdev_id (actual vdev_id + 128) to recognize it as
> a host inspected frame to avoid using the reinjected path and it also
> uses the multicast global sequence number (GSN) provided by the host
> in the HTT metadata to process and transmit it with the same sequence
> number.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



