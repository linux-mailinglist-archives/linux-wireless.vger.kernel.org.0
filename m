Return-Path: <linux-wireless+bounces-18162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD14A2227B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3C818844C4
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF4C1E0B7C;
	Wed, 29 Jan 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZlurnVUu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825E1DF97C
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170242; cv=none; b=NUpa46d6SUdHV3TnY9rACkgXDVNbCYBx8x4HGS4kCjVHg0xDL81tsPJ3a5Rv7MTHKFE89S3b3w+YMQTpJZAgN6jlj6VLwMLbn3KfKDS6nIJQp3uI2kRvMS1p5cVSOCAgE/YaI1KTuQIFqKaQ/BhDj+cCOKLLr5BTPisxQLduqfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170242; c=relaxed/simple;
	bh=1FklVPf7uXqSSWidepTl1AmXpZW893IWcewCK2ytmkw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gK3K22K1w8vHqbwIakBbPFPAUYf5OcZUIlg3BJ2d4jxXpngTcLn8d881KjkilnRN0incbYRjpmNTS4eI2M9u43lvjQdupYX3B43ugNKi7Xe1hi/Bq5p6KTXEFh5jhGWF59DOKvRlCKxDS2fcEr8ZfBlsRuY30QCKJj1kuTYRThg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZlurnVUu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8SkCu001536
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CAK5AYU2DDiO34LL96EmarD63aQQ31iXDXG5ZFzJuwE=; b=ZlurnVUudc0Zqe8j
	c8uwC77wvubduvQ1oYYqpXVOTNBifmsCFZNFbwhjbcrwsVXZcaiepmWuA3tDiHdE
	Q+/4ncDqehEnBsRCyzaEmb9vPe6ngeh9kQoLf6nvh0gTAVjNwBtYpCBz5S/Qs3x7
	noFw7OgY8fs8q1R0JL079Xcoc+e68yOSnV0rQF8CmprNcWVjxkxVWZybtiqXUhLQ
	finVU1/C5WBEhGaTRL3UNBZfhQbt8H7jnO3XgytASXz4+eXSr6S7yj/8RBTMEd/J
	Z1vgsvNIox/u+3B7yiodvoL9ku6afkeHsOODOQccX3j3wca5R5mHpuTuvnx07mpF
	RfEGBg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fguxh09h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:03:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef80d30df1so13110833a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170238; x=1738775038;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAK5AYU2DDiO34LL96EmarD63aQQ31iXDXG5ZFzJuwE=;
        b=mR+KZ+2MrNKmuZPE6uu/SZV5VTZKF3RQnboIirquTsazsdOfiBiaGkQfs6IZuMoILV
         QXGDASsFBX6Jx8Kgi/FKTMoGplWMCqsCcA64jA0SGmsu1ecvsu9BFunfw4ZyuqwpFPe1
         IkK1/cH7hxJfcvthVBztAri+70Kxw2hn3YAneFt+xGAwH4F9/nGYxbRU5Uf2BIbjZpN/
         /h0Yrf1QjSWAT7EN54xlMm/3V/pao0dYhY3wuuU519neBy9VIeRcOBiM2LsWrS8qhCeO
         JJVfRmYnxhzk0gVi/aPXBbnOSLGMna9C91Myi6kbYFP8k0VttFyaLb7J9Ltmr39Xc1uV
         V8/w==
X-Gm-Message-State: AOJu0YzZdoD4HrxskaI2B/dvj9ViVi0TpZmhEMvnI+JzdjIx8c9+VXmG
	h9o3PsakV6LsbwKX1Q1ah5Gm9azyB1K3dKSKJe7F2Tv7Ff//OlyK+bXDaZGUlsrum1lob+03p4I
	YS0UYjg+4yRyM5GF/ksjXAp0l6xWyXHIx/akgk9kgb4vsvAW7PckDf0PoWOYb1ysQFmfc4gtJNg
	==
X-Gm-Gg: ASbGnct8NExUF52HtAurCdgujEkCQRf9oJiav08MjEdWUSDHEaCF+cE77aYF396MqIt
	mESl5cAfpBB0GbLgsOYukKRCyqBNt8274hnNIwZZCkmVkqmud3a6aD/D/ofEzHgd50/sbqAo4Lz
	BrOWCz58jgkDWF5o2p20h0vxZvfNZkPCYWprqssv0Ns6tkRepZZfVuT0sLywZRAwxreYZbrSs4v
	15emgUIran5Uy8/AomJMpvPYkzjcoKw0cPfwnaa0usvuQIAiAz/hwoEMUCw7DeAByeqe8xHMO0N
	/MrnMxi5rhbk+J168K2UZ+QJYi5xCrsSqJgU6Gi63w==
X-Received: by 2002:a17:90b:280c:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2f83abb8dd5mr6017607a91.11.1738170238410;
        Wed, 29 Jan 2025 09:03:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFg6cb6j47+6W/XghU3MY/1geDUu11NiKBdSmfkh2S7dK3AUQGJDRMumaRzJ36rF68pka8dPA==
X-Received: by 2002:a17:90b:280c:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-2f83abb8dd5mr6017578a91.11.1738170238078;
        Wed, 29 Jan 2025 09:03:58 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83be3622bsm1988366a91.46.2025.01.29.09.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:03:57 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250117181953.3375273-1-nico.escande@gmail.com>
References: <20250117181953.3375273-1-nico.escande@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: remove peer extra rssi update
Message-Id: <173817023736.726123.12379675127279342671.b4-ty@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 09:03:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: TT_G--tHWNrGEspynO2Q9K73irtn5DGJ
X-Proofpoint-ORIG-GUID: TT_G--tHWNrGEspynO2Q9K73irtn5DGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=810 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290135


On Fri, 17 Jan 2025 19:19:53 +0100, Nicolas Escande wrote:
> Commit b205ce4c266c (ath11k: support avg signal in station dump) added an
> extra assignment of arsta->rssi_comb in ath11k_dp_rx_update_peer_stats
> when it added the average rssi support. So lets keeps only one by removing
> the legacy assignment so the two statements about rssi stay next to each
> other. Compile tested only.
> 
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: remove peer extra rssi update
      commit: bee577165a0a375a1d47d8ddef1c321e0f7dd6c8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


