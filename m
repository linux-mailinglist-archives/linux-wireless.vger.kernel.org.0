Return-Path: <linux-wireless+bounces-17117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F7A0318E
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 21:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BFA1886D2A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 20:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5D01D7E52;
	Mon,  6 Jan 2025 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OmfKfTzX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A41DF984
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736196404; cv=none; b=dcveZinEtP6AYtuhT9H3SNlXSA83IjXohM738SHzc5DGtKzDRSf66S8bzSKfHyC3Vg1/7ZXaH5sCZH51+DEYnj5jxyd8Lznp0zzUjuVh7/p2ZjT7pR+BLzRf8HrEst18rrmoX/vVs9wjH3lbvC2GafJ1EcIIx06/FEOLxaRLhnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736196404; c=relaxed/simple;
	bh=u+G/N3Jb1/YydoA7odftOohFeGuot9/3DxymLRcn/wQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PPybFz9fZK0CjO83Hwc8K5LvDRS/ROson2k6Ny29E3JnQrg0fcuD/ZLpmoF87YA5r0F4b6xhAZEW0xJHgLHqRJmIujO0HlluTMN07VJvP0l0nQQjjkratkJDo2Y8TARNe6yH6N0/QnwhklaSex2LuKX+/VQrgVkqBGLI58ZzmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OmfKfTzX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506G2wYo001348
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jan 2025 20:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4hS9Maw2Z0ShcNN0wei4njY2d+bdWScClXXVFjbcn2Q=; b=OmfKfTzXS3yBqL/+
	sCOyG0+yei45Tbvl6XRqB6QfEXpBQ0526isAxxh9DdSNhm7fvRo453pD7TBg4buK
	556UMnC1daNksGHE1WI2OdBH5146PJ92Mq79vo31rHI9saynj8+xc8ufXuhBoX3Y
	JwNIc9j+exWUaklQyJ4NH2cDI4XN5boZ7cZR1WjENRJIVDHWr8Mxb2G4mV8TamVy
	CJ8A6Ee+EyqzIA91HWY2d0BY6hxLpRfSWIh+9zRnSIG9YTzu4VcwB9RU67r1AKc5
	PZnY0fh4y0XFDLODbCfZb2yJemq2CVbYEb8nJgbkVa9DwUTOo4/tiDVzJDFV58Ac
	DQsyFA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440jbmgju1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2025 20:46:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so20788333a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2025 12:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736196400; x=1736801200;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hS9Maw2Z0ShcNN0wei4njY2d+bdWScClXXVFjbcn2Q=;
        b=e+dqP+dhELgfibnXMSC2AfR0fbHl04VkIfKVC1Ih5PWZjeRRm+rZYIxMTHmvEhhDzP
         O+oIlSf6YbipwXGr5f1VIYucj8fZgquNY4VNStQw+BYmNbMJGXLCWtn6wBkZ2zDSn9gb
         rxJoyDLX4oEJdOyCtnhQXzQGoi8HQwsCdQGyJdQvrxyrVj+UKF6cBsXr6GyXK0DyoisE
         srOs12bDkfQS9nvR1W2GF/2qpZTlOydwDazvKb0tkX9iuKnTPXKnReLE7FB+OiR14JNa
         4FsKV8Abl9c3XpYj+Trek3T3LA7YQ6z0nMmVHDi+qx0MflJ/O3xGTiTFqKCpCbGAhKbO
         y2Lw==
X-Gm-Message-State: AOJu0Yw9M3w7PO1TmiW5H+TnU/cAxYuhxqgdNbolz7imorAWnjdgsqSE
	XHI4o53Ancr34qtWLEiIRyUGMVTjmk6C6fxc17wG5uXAqaHwWmaNGOsJEXSFLaKIS2NPZKPvL1+
	eZfH6ZfI+9Ox4skq1EWtknoNMoKkxwUfct7FsBctsZewUG5htzWnh4OhzUiMkIjMILg==
X-Gm-Gg: ASbGncv35K9Lx0cs5qNFRaBNVtlA1ypss2C7EDes9MkSWNZHZC9v1yu8mHK80oedfdA
	Smwf/7raFwdNXAQeNc4u3D7wtFh1i6dspFxbxmnYi+T/ysknyjtgeknkVgRq7dVPHUtmECSnc0/
	Uh8mugxKupfIJBQ/31WI05xim4B32e967UGoFVt0nWqMU4qt5JO9J5IFhtz3MFcrNwb+uFwI3pl
	zz2vcNahROP+pwBnLrPR/6Jsg/wp2qSHW8j3aONQeaxuDWtoQqUCWeMdZBFig2WLmlG4lMS1HiO
	w5pO03XJ7+wq90G9cf4bNb+fkz/HgTrn/nbomomXugESimmg+A==
X-Received: by 2002:a17:90b:3ccc:b0:2ef:3192:d280 with SMTP id 98e67ed59e1d1-2f452dfaed8mr92842111a91.5.1736196400232;
        Mon, 06 Jan 2025 12:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdfVgLqPHCEq0Lx4bCm4Z5GRr0qnXbVKc8tgH9PUIdQzSB4np7W5kFTCbiKwai67JtiIhowQ==
X-Received: by 2002:a17:90b:3ccc:b0:2ef:3192:d280 with SMTP id 98e67ed59e1d1-2f452dfaed8mr92842094a91.5.1736196399831;
        Mon, 06 Jan 2025 12:46:39 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f447882d11sm34481806a91.39.2025.01.06.12.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 12:46:39 -0800 (PST)
Message-ID: <7721a8cc-ee42-4b6a-a08e-ed2ec472041f@oss.qualcomm.com>
Date: Mon, 6 Jan 2025 12:46:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] wifi: ath12k: Support Sounding, Latency, Trigger,
 FSE stats
To: Roopni Devanathan <quic_rdevanat@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20241224102013.1530055-1-quic_rdevanat@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20241224102013.1530055-1-quic_rdevanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1AFufQCeTb2Xgkp_1FLxcgYpVf4wx9et
X-Proofpoint-ORIG-GUID: 1AFufQCeTb2Xgkp_1FLxcgYpVf4wx9et
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060181

On 12/24/2024 2:20 AM, Roopni Devanathan wrote:
> Add support to request HTT stats type 22, 25, 26, 27 and 28 from
> firmware. These stats give sounding stats, latency stats, trigger stats
> for uplink OFDMA and MUMIMO and FSE stats, respectively.
> 
> Depends-on:
> [PATCH 0/2] wifi: ath12k: Support Rate and OFDMA Stats
> Link: https://lore.kernel.org/all/20241128110949.3672364-1-quic_rdevanat@quicinc.com/
> 
> [PATCH v4 0/2] wifi: ath12k: Support AST and Puncture Stats
> Link: https://lore.kernel.org/all/20241217055408.1293764-1-quic_rdevanat@quicinc.com/
> 
> v2:
>  - Added line breaks where necessary, as pointed out by Kalle.
>  - Modified the use of pointer arithmetic print_array_to_buf_s8().
>  - Modified commit logs, as suggested by Kalle. 
> 
> Dinesh Karthikeyan (5):
>   wifi: ath12k: Support Sounding Stats
>   wifi: ath12k: Support Latency Stats
>   wifi: ath12k: Support Uplink OFDMA Trigger Stats
>   wifi: ath12k: Support Uplink MUMIMO Trigger Stats
>   wifi: ath12k: Support Received FSE Stats
> 
> Roopni Devanathan (1):
>   wifi: ath12k: Add API to print s8 arrays in HTT stats
> 
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 736 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   | 267 ++++++-
>  2 files changed, 970 insertions(+), 33 deletions(-)
> 
> 
> base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
> prerequisite-patch-id: c30df5e4af6f5773ed942d8f78de88c05ce2b18b
> prerequisite-patch-id: f2181eee4bce2e3487db9bd81ed962f477759e7e

FYI this is not applying to my test tree. Strangely, you list two 2-patch
dependencies but only have 2 prerequisite-patch-ids instead of 4.

I now have both "Rate and OFDMA Stats" and "AST and Puncture Stats" in the
pending branch. Look for those to be merged, and then rebase on the main
branch at that time.

/jeff

