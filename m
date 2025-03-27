Return-Path: <linux-wireless+bounces-20901-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C53A7413D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 23:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899AF188ADA4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 22:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459D21E1DF0;
	Thu, 27 Mar 2025 22:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SNJ5FmNM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EE1E04BB
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743116332; cv=none; b=VlzB8lbc/Aw2crTqVx+On5JAOcNV52+sfFoAgg8kh04stkqttHVZ6GjUFlGi6YMxLqou/CHGgQp2wBIbZkMzSOJJscp/KPBMEy+i88VCrdTYTnHgPzwXiQOi7ISso6j2SQsWRv0Q5Vde16MAtCaW8MRomyxNbNqWLz3LE8LDY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743116332; c=relaxed/simple;
	bh=kiTwH0qQ/oq4c0VkbW0bsIYyvzYfzTt1Qh1bUdO1K/c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YVnHmERN9icSs2tj5fnqNJWPkY5MSgsqqDmpv/7IZEETGqI7ED4xDt6YXUQHA43HIbZz/si5Wu7cvVoGHmPD7kXRLm8pfp0HU3KkujJecFtktOTZJhTt5aNvITMoiZtptOfPB5TtbVXgVICPtWlrBl+Lx32G7nZAVK7xRL4kliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SNJ5FmNM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RF6Frp010197
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 22:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Kukxmb9dYO7oPUmf/OKc7J6CPSGfAzlCM/uBo1yrOFQ=; b=SNJ5FmNMnatP3eAR
	tG4BZNBwrwuNn4T9dmk6QBeHKcGkiAw6ob8qzkbSfvbLmYJdOoSl8UD8fiJjcF7f
	HZPBcXWvocUX05SZ4UjlxTVSOYC7ybXIPZiTjC1TWUBD4oTR12vaN2I6jBg9ZLVI
	QpL5rVkOE7PBC2Wea+YqsHkUwg0R1P0csYnrnS/jDrRMLPC+VEef4EfJ2sQ+v2lr
	nKWRHqwrP8UAt9+J8kjsW2ciCREgZtIVKg1W65WQPxYM3vGswkT++nSsekDQH1F0
	hsJ6S2mGBHMjV0oj2BSDehaqS+zOOqPIWrZcFLHUP6DYHfMe9dYx8y05Bz2zbG2p
	wzamUw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45kmcyj4dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 22:58:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2254e500a73so20664375ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 15:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743116328; x=1743721128;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kukxmb9dYO7oPUmf/OKc7J6CPSGfAzlCM/uBo1yrOFQ=;
        b=iRRDbpvZXdY305tsFzQ3dEDLcrHJMSUbIC3NbHZ1SR7q0dLS5bW58HeFWaQvf+Oi6v
         JZWVbkAVeu3YwIwTudQ88BPdj7ioxcdIu38pBglPtUPrnXk6WnoRC+bgrVStjgmp0rh+
         1laTZ3WrDgxDnPCwAYE0TQFYkyStuElZQO0VDYnLVFs2ivZDGV4S1S2vqijCJ6jjsWVz
         Zd6YfHEQhnVUFMDNExPE/pCzLQS46/JJ0M9+0U09PmouMGBZU69vnMDX8KaOP3yHqHxG
         DsdgMrgXwe+y14VHESxLccX637MekA/tmJupvW3pY/obbTZs28eH75XL0C+pQhzCzDHd
         CUhA==
X-Gm-Message-State: AOJu0YzuoKuuoGihEvcUDDQAzVcTFhkfhWMmz/LFUUnlQ5OwRcV1Bap0
	QH2UreDCJQDnCEo3RqkmH3JprERacGuIr+PivPs555ObJt9E6XLLSBAjyUcFilWm2OVyyDZ09LY
	2Z2tN6budLor5auV+hN+JeoJi8wOQf/4xTbk8DBbrbtdhgoleVqdIQrLVoZpOSrFQZeYFzqBWxg
	==
X-Gm-Gg: ASbGncvB0E1nCm/yti6+4EhYp6tonsjPSPoI21JrfyvPT2lNPSrqXiliNS3USA7Fv7C
	vwwKjbJPS/+tCu5Yt+4gWgisQH0yV5huv2nFZxFefonsqK91NxmeJGBLJEYbEGVtSUghbcCwREh
	QyisLAltmInzFv/DP1kLUgH+ljuqiB4KAObGCOvJFxqHuUVPogRMvY7o61vA7CVo/THiBZzIXMG
	xPCgKiFx5v4YbBnpkr55To8wBXeN/WWgPudCXG1MybtKqNxd01Fg8QGG64wKMaDK/3yEemLr/t/
	wQVHOjnSpn9DqQJGxfuRFHUWANZYYf5WeJRxnsrO2i7syesS+5Ox
X-Received: by 2002:a17:902:d507:b0:223:7006:4db2 with SMTP id d9443c01a7336-2280489c923mr89742975ad.31.1743116328050;
        Thu, 27 Mar 2025 15:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr97TIlNq2Evkp6K9STR5+gbzTaqkBodaCbfJ2zsbgn9bbVwsjfEp4917/3LcYLwNEqSy10w==
X-Received: by 2002:a17:902:d507:b0:223:7006:4db2 with SMTP id d9443c01a7336-2280489c923mr89742645ad.31.1743116327528;
        Thu, 27 Mar 2025 15:58:47 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec7bb9sm5442425ad.6.2025.03.27.15.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 15:58:47 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
References: <20250324062518.2752822-1-quic_periyasa@quicinc.com>
Subject: Re: [PATCH v11 00/10] wifi: ath12k: Add monitor interface support
 on QCN9274
Message-Id: <174311632682.448522.2851136834591383462.b4-ty@oss.qualcomm.com>
Date: Thu, 27 Mar 2025 15:58:46 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=EZ3IQOmC c=1 sm=1 tr=0 ts=67e5d829 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=Dalc5V8WfDTeSt3ZhMEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: tR_0zHy_6_66we3F5dDXx5poArP_BUJF
X-Proofpoint-GUID: tR_0zHy_6_66we3F5dDXx5poArP_BUJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_05,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270155


On Mon, 24 Mar 2025 11:55:08 +0530, Karthikeyan Periyasamy wrote:
> Currently, monitor interface not supported. Therefore, add the missed TLV
> tags parsing in the monitor parser, configure the monitor vdev state
> identifier with HTT filter setup.
> 
> v11:
>  wifi: ath12k: Move to NO_VIRTUAL monitor
>   - Added new patch to avoid multiple change in a patch
> v10:
>  wifi: ath12k: add monitor interface support on QCN9274
>   - Cleanup the VIRTUAL_MONITOR handler procedures
>   - Removed "Reviewed-by" tag
> v9:
>  wifi: ath12k: fix NULL access in assign channel context handler
>   - Updated the commit message
>  wifi: ath12k: add monitor interface support on QCN9274
>   - Removed the mac80211 callback config handler procedure
>   - Removed "Reviewed-by" tag
> v8:
>  wifi: ath12k: add monitor interface support on QCN9274
>   - Added comment section for restricting one monitor i/f in each radio
> v7:
>  wifi: ath12k: Refactor the monitor channel context procedure
>   - Added new patch to avoid multiple change in a patch
>  wifi: ath12k: fix NULL access in assign channel context handler
>   - Added fixes tag
> v6:
>  wifi: ath12k: fix NULL access in assign channel context handler
>   - Added new patch
>  wifi: ath12k: add monitor interface support on QCN9274
>   - Moved to NO_VIRTUAL_MONITOR mac80211 feature for adapting single wiphy usecase
>   - Removed tags
> v5:
>  - updated the s-o-b as a last tag
> v4:
>  - Rebased on ToT
>  wifi: ath12k: Replace band define G with GHZ where appropriate
>   - Dropped the tags due to rebase changes
> v3:
>  - rebased to ToT
> v2:
>  wifi: ath12k: add monitor interface support on QCN9274
>   - remove redundant filter setting in ath12k_mac_monitor_start()
>   - set the default filter when the htt monitor configuration get disable
> 
> [...]

Applied, thanks!

[01/10] wifi: ath12k: fix link valid field initialization in the monitor Rx
        commit: 2826139f9295821fe2b049318a1cc057ec003131
[02/10] wifi: ath12k: Add extra TLV tag parsing support in monitor Rx path
        commit: 3973cda5ef496fd412fdec2c7c3403ac90e391b8
[03/10] wifi: ath12k: Avoid fetch Error bitmap and decap format from Rx TLV
        commit: a6621bf6397ae6981b5041ba0a127e7dbeade746
[04/10] wifi: ath12k: Replace band define G with GHZ where appropriate
        commit: 6a88093f79ea0b131e5feab9cdc045a007fad26e
[05/10] wifi: ath12k: change the status update in the monitor Rx
        commit: 5393dcb4520911f2b4a980e7e3c2c0de2bbf9ec7
[06/10] wifi: ath12k: Avoid packet offset and FCS length from Rx TLV
        commit: fc1771b9c59e284e72b4fd2e9e405cd220898c1a
[07/10] wifi: ath12k: fix NULL access in assign channel context handler
        commit: ea24531d00f782f4e659e8c74578b7ac144720ca
[08/10] wifi: ath12k: Refactor the monitor channel context procedure
        commit: 1dfa44db967c5c4f73ba5c9177aeaf2dddaff574
[09/10] wifi: ath12k: Move to NO_VIRTUAL monitor
        commit: 7423b64191e325681e0198f4a8ccfe66f282b95a
[10/10] wifi: ath12k: add monitor interface support on QCN9274
        commit: 2c4c3aff7362b09ec356bd9f3b7cf4a718307264

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


