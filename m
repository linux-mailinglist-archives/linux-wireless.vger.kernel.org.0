Return-Path: <linux-wireless+bounces-18411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB7A26F43
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 11:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B2C164B8B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 10:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BA120A5CE;
	Tue,  4 Feb 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jLi0ChJI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68E2207DF6
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664624; cv=none; b=YeSArXMIlGGQJPRziA/k/vHrAIv5WiM68XL6VQKXt7wKaPFNDCxJHB5SXUPFUw1IXjHpcgSJBZL7aSqPBAUjFpI/9pbzzwEFtv/GKktRcnZ+5WmQVR7CBBQv8/msMJ2ARxGDFd3iJZKnA3xyDtHejsxXI3QEuk4rwrIvRAHJ2a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664624; c=relaxed/simple;
	bh=2tOrENL1eh7vCOb+YRZ48Z4/lH/9EZu7VjQAHHXcToM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YyNZRdZshAL+OYwGyHWp6YLr/gpKpNUHlTikU081BYl34GdlBLtCE90Uzamor/yNjPclQH4TxZL788oKcoK+svtB7yPYAJIV3uNy869h2mQF7EDypldWtlobSj5dqORrIEcevSLiGiRlPs/ebzObXBBTFzPVvDR+tyyul1HBZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jLi0ChJI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5149tvc6007727
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 10:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hayHRKWt3KgTH36kTGY0tB09nAi5jZ+X1aXPPC8Jm+4=; b=jLi0ChJIfFSaqRTo
	U8zKG6GW4fh86fBHmxsOOe0PfMqBFOJ0RsFmFEObsBg6z+3w1kJXsiOwyf3blsbZ
	CaQbF9O7tv5Pab0r+ElwOqtCrA4nndHMW3bJ6YG97xRu+HlFFuwsrsU5y2eAvKm2
	d6/FXo4Fh2C053yZs40q7hdLXYd/2JHLnezsTH22df6bXYRFGrzeeELERbCAk2hW
	N4NAigo9wZTzsKOcgHOGLL9UccMdVVhmJGwWKc0Yi8uOOjo0uZ6uPJVHjSRsrkww
	rKrTZq+XTF7jtboxx8gAbxTrgaA2N2u/BjkC0j9gRkvIeXzo94CZFwEkbsL5xCWU
	IeGo9g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kgp7024b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:23:40 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2166e907b5eso100269885ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 02:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738664619; x=1739269419;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hayHRKWt3KgTH36kTGY0tB09nAi5jZ+X1aXPPC8Jm+4=;
        b=b/r4QBUzeQCWAwyOuim8YfndmxBIVa9+1MjlH6MM1CoEevalaGOECkUoYSwmwofquf
         W11J1sW2/V+kkMm3N69Rwgz2HzkJ9n5FFqT2K6hwJKpPgOXVLd/Ts9jzgg8PDLliI2+u
         NFtmLcdxFB9vrrhGP74OK/idS7H+LHF3uRF7IdE6X6N4USAc35nDyMhhCGg4xLQhqbUJ
         fTuBSayDWZt5qUUCsEMGS+K+MieX9EGAWPyPF1EPJ7V+z51EGlyX618ZhSZrgwMhpOCY
         XsSFDgmFyYrP/7wG1G+cyjm/QNDnD0/xfUOCfG5Ikyr94XM5A1LUFtDu0yU17WvE+bw3
         aqig==
X-Gm-Message-State: AOJu0YwOPAekVFT6bAjL9Ji0PVbt4OjK/xf/oMU/SlQWcz+uqrDx7yCu
	QPYgJwX24pk173wMVzlTnAp3WwZa5EjvEtUP6N1uVtsjj7z6dJSyZTwXeuifJpELAVZQynaKXD2
	qGBGeSasQGQo3B0TqitmXbJC0YLZmmwh7/eGadpbzvmT1JG2429oZlFeoQAAr76gKZA==
X-Gm-Gg: ASbGncvNWQroY2InueoZ0EM+a3cN8B6kmP50MHcmxHasj4mRu4tQpBJO9KLm2n/eZ0E
	62xIyMpYfF15Avj+elbmQOJRwFt8oqWuLrX/e0qqrrzENpcuI7TlYiDGWCgy9oIJkzMLBIaY9Uz
	RRu1fqKmJUAiqjzYXTLMBUSWMl9H2uYchkxLX6TBNk0bM2fVd7KUjC9dEtxMJS+sfZtFZsdmnrN
	88ztLXTWYUyvlLVvz9vADcey7FD6BzVnJtXAPtOUs8ZOlWGzJCQgSGSv8CYTOyP0deZEp+la0FB
	ObYGzvBHfd/coLegqDQkpbcY5C4HIimQ5AiTxXY=
X-Received: by 2002:a05:6a20:841b:b0:1cf:27bf:8e03 with SMTP id adf61e73a8af0-1ed7a6b81f3mr40738757637.26.1738664619050;
        Tue, 04 Feb 2025 02:23:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIdD5AiG7u15rXf2GHuHDUY9fbuc3P//5L0huLyjmG8JXN8JnwvXSF0P2RL0jsOL/hgtFu6Q==
X-Received: by 2002:a05:6a20:841b:b0:1cf:27bf:8e03 with SMTP id adf61e73a8af0-1ed7a6b81f3mr40738723637.26.1738664618630;
        Tue, 04 Feb 2025 02:23:38 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acebe856840sm8243100a12.41.2025.02.04.02.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 02:23:38 -0800 (PST)
Message-ID: <076014d2-eaaa-44be-81fc-a8f1eb0c2ac9@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 15:53:34 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] wifi: ath12k: handle change_vif_links() callback
To: Nicolas Escande <nico.escande@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <D7JKQ60C6EZA.24H639LLIG2U7@gmail.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <D7JKQ60C6EZA.24H639LLIG2U7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8k3JE_24hn7dKY7f-Sy8LRyuFb9RCKYm
X-Proofpoint-GUID: 8k3JE_24hn7dKY7f-Sy8LRyuFb9RCKYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=919 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040083

On 2/4/25 15:32, Nicolas Escande wrote:
> Hello,
> 
> When applying this series I am no longer able to start an AP on a DFS channel.
> (I don't know specifically which patch though)
> 

Thanks for reporting this. I think non-DFS channel should be working 
fine right?

Anyways, I'm able to repro the issue locally. Let me investigate further 
and come back.

> After the initial CAC period I get the following kernel message:
> 	[   45.248441] ath12k_pci 0003:01:00.0: cannot install key for non-existent peer 3a:07:16:d8:00:08
> And then hostapd goes in failed state:
> 	wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
> 	ACS: Automatic channel selection started, this may take a bit
> 	wlan0: interface state COUNTRY_UPDATE->ACS
> 	wlan0: ACS-STARTED
> 	wlan0: ACS-COMPLETED freq=5620 channel=124
> 	wlan0: interface state ACS->DFS
> 	wlan0: DFS-CAC-START freq=5620 chan=124 sec_chan=1, width=2, seg0=114, seg1=0, cac_time=5s
> 	wlan0: DFS-CAC-COMPLETED success=1 freq=5620 ht_enabled=0 chan_offset=0 chan_width=5 cf1=5570 cf2=0 radar_detected=0
> 	wlan0: nl80211: kernel reports: key addition failed
> 	Interface initialization failed
> 	wlan0: interface state DFS->DISABLED
> 	wlan0: AP-DISABLED
> 
> Maybe I missed something ? Is there another series this one depends upon that I
> should have applied before ?

No known dependency as such.

-- 
Aditya

