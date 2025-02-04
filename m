Return-Path: <linux-wireless+bounces-18392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA4A26CB3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE28166D85
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDC0204088;
	Tue,  4 Feb 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ek8hssLv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6F206F36
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738654579; cv=none; b=bu+5d8GtKyAZywFirfnIfSh4ihH2VfC162FM9ra8PRAk+6iJ0d7I0Va0dIjuPm9hQHprPK49ilQxyqtAWyBvYbs+HgL3+Daxlpas8HcYfTdXnVIzF0JQnldQeyK6QC86hEUjIjMuOxMOxFMxnit3B1ajpsJUOb1qI4TIMerltgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738654579; c=relaxed/simple;
	bh=EQD9gmQEVA6k+MlspviszKJBYwouvmMiSnP6qfZuXfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apuJY3pvMQLnT2evCexHwcHYtLfj+mL+2Ay0JiymyFTGf9xVez1J9C5pz3xA2qOQmTsPplEZXdhrGnv590oKfHX06KTCpMqn+4uALYgniot+VPMad6tiR8IhdZk955aUBiYJDDi1qV2DbJNzjmmHV1MZ17hElukO7yer1vXpq7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ek8hssLv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5147P0QT010967
	for <linux-wireless@vger.kernel.org>; Tue, 4 Feb 2025 07:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cmhZf2jtZFOhpBYRl2QGSrvfhYgmFz43h5DbYsnxQXc=; b=Ek8hssLvbAp3HLsl
	d6Cems0cQ7UVrrtOzbw3rP9RtUvlU7LZQxImsvUh9mNHPoYQADnNRM/5M2RgKMxT
	/txFPJBT7brVeDMQk4Sc8iYLwHFtqyNJw3BoV7O+HIo4wy7jEsRxexnk+SairqKH
	NByr3jgpN7UTLiqDB3KdLumxG2DkSUr7rysvbJeWKw6CyOp7phFKSFJXCS56jero
	yMEjKPOSSXhddeRCxUcSDD+X1WkbFSQazlwNFXwDVrL+8niI84unV54g8EojG78y
	dNgg8fU+AFM58V1XcVBKtEd0n+s5ahd9jSo6rrFFU3pdRMeHHNLmOJf6dsf1UlRu
	np+IkA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k159hrgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 07:36:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2163a2a1ec2so187035205ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 23:36:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738654576; x=1739259376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmhZf2jtZFOhpBYRl2QGSrvfhYgmFz43h5DbYsnxQXc=;
        b=PJtYTWTJw/tVX+plj0w8FyaPr+JTG5M/S9CcIkU7q8e44DCXK9gr9G+c/Ll7c3yP+m
         86EQtl5c+/HuLeQVIv9omkK93Xj6F6c2331Sseml7WPoirXXIf4OnRX22C7i4Ica9yil
         OCdbii1ljV/PnE7tVYMyG6z6h6gGJkIM2xi4jLqLa1bJq0S+Xdvo/MA4b8C4JvVqLr8w
         XKt6b71oH5o9shMjwkiCNU+PHiEqnFE/K5QK2Y/S2CcG+As6qDm5oUQThnVxKuII5z/Q
         wvPp58GJ2DpdgXpG2u1hDVyUbgsCST7Dv+s34YvOcZNsX9TwkRDwJ0zEm3k2ZkE7U96n
         0RpA==
X-Gm-Message-State: AOJu0YwyEwm1Ija7bEgtnfI/2BH0pQAGGSRPdvsjfY7yiX7SMx/D2i4m
	ywPFY69An+2HiMt6IVevTYohwbsHI6kGGpIP7EYhbYh9q54E07OuhoGQfxP2DGOcAGwX1uH6Syw
	wqBzcTj68sRA1fNEx4jx2mvpD2Zl0rESVGd6M6xq6OYnxzkw0NetgADCl5WrLsD1Lww==
X-Gm-Gg: ASbGncuUIrv6gg1BNOZoz7NTJNJn9vA7T2y2SBNofWnEzjtQ0/6cFblZjkIG7ZFZCYT
	VDbwwv9d3ZOElyfY+8AS4gES2gCDefrIBTky/NxbU5zrM4W3fVYlWRc883OPx/rHJkSZB8Yekof
	lKtvtPIuDppksDSDtMx+rPJvskXb6QD0+FUGBT1DaZ9d7qBMhPZ74untOaaJaWAh4PSwrRBidq9
	u4Pjb8jCsc/OCGyCFT0S4PvY/e/gc6X1Ra45bN3DE9+tP+BFrx6+cJNy9iHo+nauDYua8eO0o8l
	BQ8E7k5gxyqXxPgUzaQj46QUzNK+cA1mqFyCuV44Y0hQYJI=
X-Received: by 2002:a17:902:e5d0:b0:21c:1140:136d with SMTP id d9443c01a7336-21dd7deefabmr438784485ad.40.1738654575717;
        Mon, 03 Feb 2025 23:36:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBJ1xxgLF4XGmhl1EYxqcc54FnC35M9tEB/AjgAeRQpmlzCyfnNfRRLtDm9urOOoIV/+qunQ==
X-Received: by 2002:a17:902:e5d0:b0:21c:1140:136d with SMTP id d9443c01a7336-21dd7deefabmr438784225ad.40.1738654575341;
        Mon, 03 Feb 2025 23:36:15 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea80csm89749945ad.140.2025.02.03.23.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 23:36:15 -0800 (PST)
Message-ID: <aeac367b-00d6-4dcb-82bf-cda8307fd0d0@oss.qualcomm.com>
Date: Tue, 4 Feb 2025 13:06:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/8] wifi: ath12k: use arvif instead of link_conf in
 ath12k_mac_set_key()
Content-Language: en-US
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250204-unlink_link_arvif_from_chanctx-v1-0-675bd4cea339@oss.qualcomm.com>
 <20250204-unlink_link_arvif_from_chanctx-v1-5-675bd4cea339@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250204-unlink_link_arvif_from_chanctx-v1-5-675bd4cea339@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fkcSuEF8Q4RLkSyG54KTw5I81Ff2m0dk
X-Proofpoint-ORIG-GUID: fkcSuEF8Q4RLkSyG54KTw5I81Ff2m0dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 mlxlogscore=844 phishscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040059



On 2/4/2025 9:53 AM, Aditya Kumar Singh wrote:
> Currently, in ath12k_mac_set_key(), if sta is not present, the address is
> retrieved from link_conf's bssid or addr member, depending on the interface
> type.
> 
> When operating as an ML station and during shutdown, link_conf will not be
> available. This can result in the following error:
> 
> ath12k_pci 0004:01:00.0: unable to access bss link conf in set key for vif AA:BB:CC:DD:EE:FF link 1
> 
> The primary purpose of accessing link_conf is to obtain the address for
> finding the peer. However, since arvif is always valid in this call, it can
> be used instead.
> 
> Add change to use arvif instead of link_conf.
> 
> A subsequent change will expose this issue but since tear down will give
> error, this is included first.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

