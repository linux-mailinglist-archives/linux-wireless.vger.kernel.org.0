Return-Path: <linux-wireless+bounces-27495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B9EB8766D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82C9E4E19EA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856952D027F;
	Thu, 18 Sep 2025 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ij3A0EKx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005D258ED5
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239245; cv=none; b=SAFntY3ZYHslosdcUEAhjz8HnotuiKoxhtmmuBOPAEj+MJbliGA1zU1yqzko4NtIpOm0/9NYRsaCJafysO8y2MwJnB8ofjGOtb1Gw++9PQKP1Y/BTkriwMTJYdXhc1cNLNoKBj6eGXiq5HrCLx5lgJCvB9JxXskB+ul9d4PuN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239245; c=relaxed/simple;
	bh=rCOAexOT6WZaJhAEefRZTCV9YfHjefbq2NIVzZ7Be9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rar2sdAqT5gTMLWHYWw6wpWYsUUhoFKFV4ZmYDXY6TxVbM9iUFXh/j0Eu3xvPgVRk8uGRtjNEVhxEskEop6ElXkJZ23l3RgAl/SVLVwrz4g+pfFTHsPAnVCjkuR8sNUuBOjUmJ1JGMV++I0xW8M0Y5ewdc9fd3Vaq5dgF3pU8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ij3A0EKx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IILHCs010782
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wv8vpmjMm6rlbYNScyvr5yh8ZGIpG+FYpzsqoJqddIE=; b=ij3A0EKxVSO028dD
	j9dIDXJNoYe7omwIXAPq04IQkE7/TFqsoqCXwU7vJ/NLjoy1+vTZ9Dqun+qb3MO1
	aRg2iYkcoVAl8TgPhdw++Ndaiw+thvdL6qMHQYu4RYZ3lGMACeZsvE/UOaSl+gvM
	kgR+vDftFa+3Aw5S3F5gSXU9WOwatq9BdCm0tbpR1wZXTL4yVQCjHGSQg5/4ZGnq
	IayJgZy8GQ1O0ZcOEoveRh2szF9VzL3neBkomJ1HaT3560j/oYvCEC5GknLSTzeD
	0fDiuwybOekqbkwXAS4EQ2ZlvK/ym9jDRx5OZSu5asr4pXeme3MEgYogM7u74fWP
	/lyn7A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxy0c7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee62ed6beso2133235a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239242; x=1758844042;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wv8vpmjMm6rlbYNScyvr5yh8ZGIpG+FYpzsqoJqddIE=;
        b=PM5psV9YaqdQ8VNzGCIOrpdsKpe32hg2pZhZ8dZn1RFn7TosK7ahY8cShQxDz2EitK
         jNzpqgUlsZMVmOqUD4qFyj/jbWdj1d5mIM5ImkTRE50FCtVYZy1GRPAeV2qBZL1VqlP0
         6kykfNySu/aOdoNUyrpavqVRpswDFHBKH648yoqBIjxrVQtxP5houfRw0KashVYvkXls
         r5U/WRySBNlF9DOoyC3HCDrJPO2aC+nw6NRcxEOtUsB0ZoYt8t6MNgWQT/wo45qe0Y6p
         aMUlWuSm3gewzWqqTZXJHm05CNy5yNbc0IGFYI0RYEXMiamIfrR5Y/gdi9sFKaCFKg9q
         KhBA==
X-Gm-Message-State: AOJu0YyblbnHeok8gvTFrvX3BN33oCO+SwwP/19JMLoKw7Irk60Bi4Qk
	tSGT/6amzUrJ/yACkc4CiYFiw9PsnI0eNFmNhmFwDrBYPnuvC9A2GuWssVRuFdseMnTM3e5aCMb
	OIugQSCsNlJnSKf/QwmdWuBopKEoXBKhPqZuI7L3lYOOUZ61NMM2j3/Vcp2YZQVydH1CqZA==
X-Gm-Gg: ASbGncvZC08DkCxkHvmeOe1o37VxpGsRu6CDpc7CEYpMkGooZqn0pu4LjvAhsZZKTvV
	uQsCXsi3QNkbH8meMfMUp3AtsjUlCulScCBGMjamGD5tBoRWMkvydAs8a8XBQEOGt5GqJup1AkO
	4dqFae3Y+mSvuQpeKTRZWdgtMcx47WJ/cksWAlt/D6icWMJVKzilalrGg8b2GEgxtBFk7cyNT0w
	S0p2ZKMriakNFLuouppDrZC1OQTIRkFNgpDfUSAakjcteO+nY30Q2LZKjv3uYQkQVKI+xceiqY6
	9jrb+OTIKqpIUQGZv4W7VEqzsGfl8jFUYzzI0YA5K4axX3FFht8pYYX5lza7XUanHqYlvets61q
	y
X-Received: by 2002:a17:902:e741:b0:24c:d0b3:3b19 with SMTP id d9443c01a7336-269ba55f952mr19918265ad.56.1758239242221;
        Thu, 18 Sep 2025 16:47:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyxK8bH7q/0zfeiIWmwMZKcxlg0yck4JvXJAIklWaQwJF4KdSNcnI+LaCqe7oKrgTbB3s+qw==
X-Received: by 2002:a17:902:e741:b0:24c:d0b3:3b19 with SMTP id d9443c01a7336-269ba55f952mr19917985ad.56.1758239241830;
        Thu, 18 Sep 2025 16:47:21 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:21 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Aishwarya R <aishwarya.r@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Sriram R <quic_srirrama@quicinc.com>,
        Vinith Kumar R <quic_vinithku@quicinc.com>
In-Reply-To: <20250723190651.699828-1-aishwarya.r@oss.qualcomm.com>
References: <20250723190651.699828-1-aishwarya.r@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Add fallback for invalid
 channel number in PHY metadata
Message-Id: <175823924111.3217488.5312521302210804871.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3GcqcIlxw2Zi
 y+9NozRYdb1UfHDweiiuFxllYesamzxmfVnaB2A8EnEnyZlBHkiHLR9GiA36mXzN7Nax/Fopq7V
 Ht3tctKI7HmoDS4IjRwT8rd+uam2ggdjcD4C+fQy/GAk13GAM2gUhSdZqRb/MCHSJLTLKaYl/Mf
 ib8avZFtpe0QRYpYxhLSxZljBLkVTJ0h5/KGW451M/Q74uyynxkvkxdMTSadflGydkJFDgXXfC2
 AM3zeh9hTYgkYBi3NZD0yqUrHMxs6bcedpwm2dPE/4W8xEBidydaHGEbPQxHHQV/VSBu3vOC2/f
 m82xgf9VCzfXgQj9fKszAKivI4DJzg888RD1Rv513ATyXk99M4p6ljdlqFbU8DDv4E8+Cax6urq
 GR1ZuicD
X-Proofpoint-ORIG-GUID: YtDTTTZ0xmvL8A-95xhobqs0ZOY1ilSz
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=68cc9a0b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=RSXUyCpSUqS4h5l59n0A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: YtDTTTZ0xmvL8A-95xhobqs0ZOY1ilSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On Thu, 24 Jul 2025 00:36:51 +0530, Aishwarya R wrote:
> Currently, ath12k_dp_rx_h_ppdu() determines the band and frequency
> based on the channel number and center frequency from the RX descriptor's
> PHY metadata. However, in rare cases, it is observed that frequency
> retrieved from the metadata may be invalid or unexpected especially for
> 6 GHz frames.
> This can result in a NULL sband, which prevents proper frequency assignment
> in rx_status and potentially leading to incorrect RX packet classification.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add fallback for invalid channel number in PHY metadata
      commit: 26f8fc0b24fd1a9dba1000bc9b5f2b199b7775a0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


