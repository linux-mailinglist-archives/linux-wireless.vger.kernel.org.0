Return-Path: <linux-wireless+bounces-25753-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F0EB0C727
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819723AABE8
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 15:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56002DD5EB;
	Mon, 21 Jul 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U+ZA1H2T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD082BE7A6
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 15:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753110110; cv=none; b=JI/KXD0IKyIDhvxocfVHoCXqd9fAQW4en/OREMn+wHp/yXvvxIxUIaiu3DMgxzSHz8Rk/cBujNQQOoD+yF/b9F1kc72Yv2KAatGP3W0RLcsIisi8w6Yb2SonIowstBUgTqaXhaZjLjz4tK/t9WnQmlnzH+0ErMLKCPHzcF2yR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753110110; c=relaxed/simple;
	bh=XRkewL3soVtnrk2cXEW94xn8BBgLqnliEYBf9HPXV8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS/bHIeB2aOAWxonU4QW0vXlYd+CYIzDLR8zJt0PHl3HQ7whxogt3WrB7MjVIFINtGBNhnGo7XijVeZ1qfmTjWTvAehqwXp9zi8RzMyX3YEkV5m8gH+kRQ6VTm+9AgipgXdiM4pcnbqtzrZXsv6SVbCsxEyDUy/osAVTZOCfcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U+ZA1H2T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LAVRCb015777
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 15:01:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KbhR7wgqAsdiZEMYBFwiyXJ6Odxv1EybtfjmhHzvafw=; b=U+ZA1H2TS/RL4aUm
	Lhxtrhcu3PfqknEGdYgI3QpMTr+O6n5XaOo0FL67UlrnbOxMQLu4SGffo15W3PpI
	s6KgEYtuQ+xejOKlUR9k7AinopvPt2RMzlWyoG9RsgmRaTycj0IcPqTq1cmJ+JQ6
	ZTU+P5VlmVRDhqdNBZTO9bxN+XjkA2LMEMX4TDv+vJ1W6MyAaHaUf/mOKnGNDbit
	BMBkoNuDDhTr6JynGLGridMPrI0pzIopDoINWpr/E+xYTAKBJ3sezRpDzCuFPWwh
	RHjlehTB8C3QTM7j51eZ1k4GTM13lBDs0S/dGH1H2+2XFM1z70FQGnr/SJRxzH8h
	dvou/w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451dnx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 15:01:47 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7494999de28so5896209b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 08:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753110107; x=1753714907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KbhR7wgqAsdiZEMYBFwiyXJ6Odxv1EybtfjmhHzvafw=;
        b=grqd1Nm1MnP0Z8h+rt8gwrc9PFUmXmCxXSeJp/5u/VVQqRjJjVJ5UqG+8VC9eeMn0w
         PSvVzvCSLsC5ZN2IoTqWKHQBLzMd/Mrp4o49TAX5RVKTPow9G4fwlzFx37aEoyl/RwiT
         3xGXpGWO5+5Lowu2rKOJC13m3SgfgEr4igCJRIupbCJr7lcKGym2R1w06GAhZOIZF7it
         dTKbAZyj+WU+utRRcBwJlPvBiEc8/UF+OYtGJbJtagtpCqmixaxdm2iVT31K9+anoL38
         zrX/7HIxOsNBPiXbom7QFFwxE8p29ZipgKKNR5g/tmJ7nfsj9E5TzCYDVe3BHdUOdP+X
         F1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUG7kx34DhKM624tqf+IKlcrf3dHCb6c04VMqtRzoqZuHY7Frp6CrRSxV/RTmNJy/Y4ZoI0oT+9eb9HGGiH/w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+//pdibhTArI1zNx+sSXpJDUiP2hcElWrdeoQgPLS152KQdZt
	Ie9cjQPuO8nYoUZs1/tXacuoH/eBDPmzqRJzhnI+94AqpVKyIU4p+XnZWu94I/chkNO55Q2Zkth
	RUFhIb0h2eIOH+elVq41bQHj9m4R+D+utEHXiNxprD1o99vT+VS+BuGo+ave2FTakeNifkA==
X-Gm-Gg: ASbGncspNxrVRp0fDUj+fZpDwKie8ZeFJ7gX8obhTQdY+ilwFpXdw4q135b7Xi89gDO
	PgGU3X753Jw5ubLmkWD30fzxjdAYx5XGo8LkhYTVuIS/kirbSNRgqCgUTG79+bLYF+VUhYAWTT9
	W5zxKJ0pa/Z/BAkmZuj2MI3NmrXqP8VdqOUIENtLVTcox8NaCiiaf2IQO27vvlm6Rd3Qc7PXL0Q
	olyFYzGSUj8PGrcNw6rXlTfJIDt6hN1w8EMWA1pIHeWlT4wvh3IRVYy309/o5RtL55jJUKy4Y8s
	BdLqxE6XoNSrsB/ve7/OoyhMaZLrbEYpDnVr0HUxK0PKhm7ELDlZu5efFGBPzbwDQZBp2Kvhu+d
	1MaF1dsYEa0M=
X-Received: by 2002:a05:6a20:6f8b:b0:232:a885:e84e with SMTP id adf61e73a8af0-2390dc2f805mr27535052637.25.1753110106503;
        Mon, 21 Jul 2025 08:01:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOHmWE4iyguDMxAHTPOU1nCRim88f/pJDZPNsYN+kAb9LJOLyI2W/6u92FrBlgWXprwHe4bw==
X-Received: by 2002:a05:6a20:6f8b:b0:232:a885:e84e with SMTP id adf61e73a8af0-2390dc2f805mr27534927637.25.1753110105474;
        Mon, 21 Jul 2025 08:01:45 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.224.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c8eb0e98sm5977496b3a.66.2025.07.21.08.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 08:01:45 -0700 (PDT)
Message-ID: <7ee5f1fe-0d0d-ce10-2e6b-8bc9488289dc@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 20:31:40 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next] wifi: ath12k: bring DFS support back for WCN7850
Content-Language: en-US
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mihai Moldovan <ionic@ionic.de>
References: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250721-ath12k-dfs-v1-1-065c31454f91@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687e565b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=jjkvTE25TcCRIAzKtE2jAA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Mae7F14F_SpBrmaiimsA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: ARRzOQVs0aGsKKZV-TEYQNkmetuw00ZH
X-Proofpoint-GUID: ARRzOQVs0aGsKKZV-TEYQNkmetuw00ZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEzMyBTYWx0ZWRfX7fqAGyMZMyS+
 x+jFiMFYhdwDurKeTCsFlatBMTTKD6V37DPIeLmgbjcAlfx1M2qbxN0hYYHWAlCy34uk64/vruC
 8rlalLdCgG3L/In6BgWMR7/jPClVUUhJ7sptzUWCjj/NETTy/pl6jqe1NJ3Gu8IoS01WQ+31UeU
 nvTIPOPZMpr5AoDl2Fdef4Di0boRfCi8EQJM75iESMRxjS6Za1Veem3H2N6JDEUt4Tx1TrKOgsZ
 7xD3gPUyK5ugdp7gaIYWGYPN1BSMupxUtuTpQC0RDD2fzZkPoUN4Iwo0QNeLCYD/W9xLAbMPozz
 Dh/eN/GTPPLn4mc5J2ICbOqh2sR4x3ZLl2WvBFdDHB7+QN6ORVuPJecRHgfCeylDT5keSrq8pAI
 q6mNElZLwvfwfZMNXEYsefIyVV9xCfa3P3SEPKhQndPAtgRE3wDIgn4b5zixhP01zTxH1Mij
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=997 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210133



On 7/21/2025 7:57 AM, Baochen Qiang wrote:
> Due to the restrict in MAC80211 that DFS (Dynamic Frequency Selection)
> can't be enabled on multiple channels, commit 176f3009ae59 ("wifi: ath12k:
> support 2 channels for single pdev device") removes DFS support in order
> to support 2 channels concurrently, making AP mode not working on DFS
> channels [1].
> 
> Revert portions of that commit to bring DFS back, and add a new
> combination to support 2-channels concurrency. This is valid because the
> MAC80211 restrict works on each individual combination, but does not care
> about them as a whole, as far as DFS is concerned.
> 
> This change applies to WCN7850 only, other chips are not affected.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 176f3009ae59 ("wifi: ath12k: support 2 channels for single pdev device")
> Reported-by: Mihai Moldovan <ionic@ionic.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220346 # 1
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

