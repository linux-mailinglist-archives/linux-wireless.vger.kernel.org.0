Return-Path: <linux-wireless+bounces-24590-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0E2AEAA68
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5085D1C26E54
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705F25B1C4;
	Thu, 26 Jun 2025 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kVNPjn5i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC6B258CC4
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979729; cv=none; b=uCQBBey5awi+FTUeuIK3UxsWSyNKvcq6i3QAf/QZM2ADQFdfsXKotIrIma1ZB6E78P4iK1/ZGPHYsTuuo1a0L03hzLdeS4D5Ju1MnNyccfsENkgBPNUcuM6i4KBwUPSQtY3U79abpf3ESIPq+61f2cyrc+nusH7m/oMuNPRzJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979729; c=relaxed/simple;
	bh=1xbC3FqF6QTRNvttuJQVR82RJ77huxe6On8X1ko8luU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nFzxAETt/sH3y9RvNJJg6CeinENIT9wKK26L6Ik/uJWO51qTpfkBw4DX3epdRwU0O+OfC6zjZpROL1G+J+yxhPds6DK42Oq6DOpipU/dbfnG1Q7eoNyBFZu8Db9vsvEvmpt4xCBDmiFQioqC0pV7Bhr48Xmk5fvFzWHkIpSWhoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kVNPjn5i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QKEZSd013644
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	O11XQzatHA1yASDGlkteCVGH0IWgWMK9d0eiU8vyEGM=; b=kVNPjn5itPor0KeS
	7Ov9UJLsXx+E4QEwHjMUiogmoaVuBrkwk5fbU01EIp9OamDvzMhgZfGXayXLkXkm
	mNyW1jCoxFbhUcGAimIYjvUPOCHfaLfFPoV4zqFv5seI5EpvwR27c6NUwCfS2tMA
	mXlkR6EyBvj4tvDND118ZgF9CGKcM2AG9A6/bVtuBJ7DW5i0aUBKc4bEjW2MLFWY
	odmFzDNKet7XhTvMQhoZeafkMQ8vlqbVIohJxcY4aPmQjPEj6F7RR0zVIZlfyIFN
	tVvDBtONcmNdrv5IBf53NmNUzOSeTRrrmbg5+rLcOcQ5PQM+hFuEc8vnjmkGL1I1
	Q4PFiw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bgmt39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2356ce55d33so22036955ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979717; x=1751584517;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O11XQzatHA1yASDGlkteCVGH0IWgWMK9d0eiU8vyEGM=;
        b=oBfiyWCsW4yRN9zhYDRgMlEFYp7v/+GO6n6hAya4mcELnzK2RL4LTI0uiGr/kM4y3Z
         vpQpnxdy3ZSq4HjSm9eUJA0ZKUh6WjxJGs9aCOhHjkSwWKV9a152PK+b0UWr3FVE+gfO
         zXMbZ8XUAOppyj7XDmqdD318lz+Okb+AMYzQfMRBRw6mumtWlLPXHhqEgYqpeVo0rCCx
         DrspiYvexubnpP3bJNtEd8x61cW2+oBDpz8wWc8WwneHAbzguVvSe9VEYYW7AyDoMNaM
         WXqQKwOHeyoycM0mmYNQ5dIpYmlPrnCP9+lTOfXf9O103EumOJ4VWkVbHv6YzVA3ZBiI
         ZkOA==
X-Gm-Message-State: AOJu0Yxs63OU7iuZ8qfSDboc6YAi++CsCZoEeMIEk9h76YG6zIQ1EH/H
	i1+WtsVgPg6TQAYP4MnLnJLA2CtYX8ENaU6LlH6ZhdF70kV2XAE93Mo9/aIMgElgVgzG28mqUHX
	pWNf01brN72jmqMsUWBY4SrbEraEmfaMXO+tF0nsuNwdr+ihsdbU8xHlBvT4phdAF9/3iIQ==
X-Gm-Gg: ASbGncvU/ZFz7vd55pvOG/MHqHVCeh+EdBxsiCHjclOjBHH5wfPcYu043kAZbJ6K/+A
	VwCMHxPEcyLWn4VXy8rM28Vgpne4RePUVFqfnjCAldLBR8Z80/vSZzefEdXCyxyA+xJuajivz/B
	2N5JN1Nde3teIZLsgNEgJDVAR/+432vcqfn4MQMi+Yzn8VP7S6NPKfkFeeDhgqtBtFT2Lj+6j7+
	EntkQ1AFxPyqRfKs6jgE1yZByws56wqJtAYAF1TSdY/npU4l+K/3eQEU0aDd77OBUQuK8eFeFwy
	sz1m9YcnZdlAylfrByndxN8X1GAXKNVe2RK12f9I83w5hbVam8WLZ1WIi4A=
X-Received: by 2002:a17:903:41c8:b0:224:24d3:6103 with SMTP id d9443c01a7336-23ac46523d1mr18331485ad.35.1750979716984;
        Thu, 26 Jun 2025 16:15:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJRZ/YV8WDP7uiPZXM7QB7uHxxtcXHfxIByngwgEnbMp6UiFrwF5jg503t2UJQ0ZIkJ3CaFA==
X-Received: by 2002:a17:903:41c8:b0:224:24d3:6103 with SMTP id d9443c01a7336-23ac46523d1mr18330945ad.35.1750979716452;
        Thu, 26 Jun 2025 16:15:16 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:16 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250603063512.1887652-1-quic_sarishar@quicinc.com>
References: <20250603063512.1887652-1-quic_sarishar@quicinc.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Add memset and update default
 rate value in wmi tx completion
Message-Id: <175097971586.153431.933903658345273396.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:15 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: PjC7bXpiHxk_-qyBeFOswGhzIFtJHClj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfXxCJnbXzfrp/7
 nqZH+gehQi/YCPC+TDfCz4pFEqmxWA3wd005LRXcbQkDZV5kalJcNekJRQ2JH6ZTdh755dokGzE
 bJxzElXvlu4Ku533Ggndc00iVwYPBT0XBshmwx7bhznKUQ6upyTnT9L4mjJKGqM7yv/4oEegfJ/
 /HI0UREEEDH/Yw9bEOANq8MaR7Enn9wiUuBwZtxyIMR/a0wmFrmzZM+lXacU1u1ffmn1MQjEFkL
 cG0+6LiB3EV0WrmDFl8IBxPA7SUJmlvdj4bcJEPGt/DsZMuWXvYIedcdCuse51UvvWtW9G7D9Dc
 G/+bmAgg3Qv4gf901o9FsI8EyAQs8jDsoja0FO5D2JxYaC9TmCZlhvLuTDRoChRLvSM/zxs0oLE
 mBlfEr/ccVKP8iPfxNj/vZy/1IlT0wcuKpS1XPMUrXX6kyqCzMYR22Bc7ShrYDcSiYuRBLkI
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685dd48e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=_Ud3jh0soZ2xRjmNsUsA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: PjC7bXpiHxk_-qyBeFOswGhzIFtJHClj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=854 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260200


On Tue, 03 Jun 2025 12:05:12 +0530, Sarika Sharma wrote:
> When both AP/STA and monitor interfaces are enabled, ieee80211_tx_status()
> is invoked from two paths: the TX completion handler for data frames
> and the WMI TX completion handler for management frames.
> In the data path, the skb->cb is properly zeroed using memset, but in
> the WMI path, this step is missing.
> 
> As a result, mac80211 encountered uninitialized (junk) values in
> skb->cb when generating the radiotap header for monitor mode, leading
> to invalid radiotap lengths.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add memset and update default rate value in wmi tx completion
      commit: 9903c0986f782dfc511d7638b6f15fb6e8600cd3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


