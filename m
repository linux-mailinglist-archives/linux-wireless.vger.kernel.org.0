Return-Path: <linux-wireless+bounces-17446-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D773A0C16A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E089165946
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1660D1B21BC;
	Mon, 13 Jan 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AmoGWBEM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1B1C1F0C
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796535; cv=none; b=urdOlvHF3L0n4mBpi17p5kuAHjbu6sSPJIpU7+jpchapVhNBosp6scBXVTzYaytNJPZMqTx9Y0NgaLKdL+JVughJnoyJ0iax7Mknlme6qMq6Ndc0YlYil1T0hxSPdyWQeLo1bG/xTwIZkD9xidTRPXH1BbtVYTnIifGVxu2JbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796535; c=relaxed/simple;
	bh=cnnGFozQcr7VbBH0JJdaBS1uGXqpSXC9u2tqE7APqFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qKdyhQbaRwLi5lVDw60Hvpdt9UFOiTXh0Ys2d7L0LjYXrp+13Ttgv0Si2cRZsXu4ez04DMA6rU8exWz/fl51O/qsfDYkG8XCwA6ABE8W4rwJ3oHZH2+Dc84dx5jeeym/L+4I91DRlbM/K0Gj6SHsjfA2C9UUR7UvICT6/sKztkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AmoGWBEM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DIigZv007900
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/5mhQy/iLi/hHQbqK1N//sXRK2hJJG0CiemfOAYFPXk=; b=AmoGWBEMTFYlYWwN
	vLzi4YKb+BKcOjAC07fN9B7ZQa6CTBZ0dM0Vc/GYA7wSnMXIyD9YFVHL/GQoddQY
	B5ioEhUdPQUff+puj6At++3IVRxt73xMSyN+DXiFAeBCVBirxKJ/gGqqFRmjShFp
	R3+Z8yNQ9LJSw8138W0cCwbXxNUYxVdlQUExLhBN6vZkVIYurXmlYr5i2iTQ+HZZ
	X4BRjyA7tnjEwfaTAZ9CdfcOKEiFMQh5YZKdy/bqzvhEp/BjeWD4VF7lKf8T+TEU
	nhK/aer0itq6jlCSwrHyQ8CL1gD4DrKJAfhkIcoraPTC7Q83kUgofax2oXYo60Hm
	t5eg4Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4458cn03xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:28:52 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21655569152so89047215ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796531; x=1737401331;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5mhQy/iLi/hHQbqK1N//sXRK2hJJG0CiemfOAYFPXk=;
        b=oz9EnKy7h3j1jyyx9LdJRoK5uj6YrxixkGjyJpnkOINh/udHDmkm63RU4GGB42wwxd
         V2IbbDx1TNdlMrPlWx4nJREWVuYWczVlKBQ60zGyucDRfmjHXSA+yPswA+WeIfQZmWem
         V+uT9RgKwpEb0IGrvkAX1Zc6Ai4ddwzS4W8IR9NKiE6DdgPynT1BlIfS7MKS7tBWzE/D
         9J6aqUEXP8cp45d6mZGEh02SYfV1E75u0+iAMeXRJP9CXJAt4F06wn6/Qql8igfkkV9C
         6dLyYxrHBDLBS75bnXXSlVyCWF0eLDNqCNI1TiSObvwOGiWEmfwD/zO3Fd6LuuXaWnbB
         PEjA==
X-Gm-Message-State: AOJu0YzTJap1xZ3bJWTWvYS91lGLX5uayrUuJu8wvlq2xlwsoxuC8TIY
	LkC/nP9iY6G4DX6McvLL8+Yt5Hz1/JEQYTTdxNevNWjGZcKd6+8VEJL10F3dPQWevOw9Tmby90E
	ujR4SiENd8u4nhUpct/IW3HF0NutsRcjFLhuzOKT3YiAi5GHumwDeCXeWTXWM57l3Fw==
X-Gm-Gg: ASbGncsot0Eoxx3jvHmDcOQFKX6Jx5A0zRfGIO6c0DM4/9MCLTLOk8tekBiolnCul0h
	ZthYBBA7JZqa3geXBZzdSaIi6CUDbjX9d/KyLP7iInDPmkrGEn466gVBphXUay2dy6MMucD6x9n
	4SLy2QOWissalg7+Unh4hdfoxO49j3mTJ+dv01vUOPlXuRWFPDR32foz9z0fBJb7cM6DDplsLjm
	GsaNikYCrR1ZeGg+w9k3O6voURtvYxwefkO5dq6X9pIKkdgZVQlwZtJZkbeiVParWDjxJq4QM30
	NYS0cNZN60vz7nA0DPZFor3UbGB/XS2s1t9WFR7eviVQKH2C+w==
X-Received: by 2002:a17:902:da8d:b0:216:2abc:195c with SMTP id d9443c01a7336-21a83f429ecmr304262115ad.7.1736796530769;
        Mon, 13 Jan 2025 11:28:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFy8aD+OBjXqv32LcJQYeGJg+trdsFUduQg1qH1ESZhroKs+54HzfL+haMDzQ8DNywU/hIVRA==
X-Received: by 2002:a17:902:da8d:b0:216:2abc:195c with SMTP id d9443c01a7336-21a83f429ecmr304261755ad.7.1736796530351;
        Mon, 13 Jan 2025 11:28:50 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f253e02sm57279285ad.225.2025.01.13.11.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:28:50 -0800 (PST)
Message-ID: <b3f38056-b2af-4f11-af5b-e21d3426024b@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:28:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and bit
 mask definitions
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250109184932.1593157-1-quic_bmahalin@quicinc.com>
 <20250109184932.1593157-2-quic_bmahalin@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109184932.1593157-2-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: EMHL9p5XKkte7F_mI1JEfbe8N0BtXW4x
X-Proofpoint-GUID: EMHL9p5XKkte7F_mI1JEfbe8N0BtXW4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130156

On 1/9/2025 10:49 AM, Balamurugan Mahalingam wrote:
> Update the HTT_TCL_METADATA version to the latest version (2)
> as the bit definitions have changed a little to support more
> features. This new version allows the host to submit a packet with
> more information to the firmware. Firmware uses this additional
> information to do special processing for certain frames.
> 
> All the firmware binaries available in upstream/public are compatible with
> this HTT version update.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



