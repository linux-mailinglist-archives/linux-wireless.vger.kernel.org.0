Return-Path: <linux-wireless+bounces-24362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 934B2AE4779
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BCE16CFAD
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB37275114;
	Mon, 23 Jun 2025 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aNQqtrWd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25FE274FFB
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690133; cv=none; b=V+kHDumiMRWTWEDYNRQrUmkKGGV4jZSQ8+SCUqMqieMxmeckbG1AKBedN93gdy3YC9Ga09+K5NEpZv+yRrdEiCSEkXlukpMVfXNUE4YsNT1tLdKIwkt1HokEimRSFbP4EZp0PJePj9WFQK8PUkB3WIRLr9GPPPVMYYJkTutMiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690133; c=relaxed/simple;
	bh=RVwdU66pJDfojfvWOkqztMSkMEaSFHBYQoT70mwrtvM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fPCTCZ2RhzqG2hxz7Jdo0eS/pKXreEevrMH+Pe4v6cg7nXbaVMvMqU38USzmopfgdca6mSAuqIuWYDa6PhubLWepEvXoB8Zzd5eHWfrB1sRWE1QOYaLAsgZrT0TjVf1iepH4C3di/oGC1BaYZbA+J+i0VSBqAkd17d3S5GsdVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aNQqtrWd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9r2Hj014481
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/+wy8FW0+jFScerUnGQmFY4VIpRHcERfP3YQyx6WH9o=; b=aNQqtrWdE3WUeJuJ
	mYDY0EGSgfxgw8VV7dIxlKO9aomCUVfsxoywG2vOjhNHsvz+xZtXJaXpowhJcc56
	PAo4A9kAyQKTDtKaBGjFCLkkJ3bxCclmdnaZyg6fE5n+6LyeOYPsxqRj9Fvmib3R
	gIGhYwDMjVvm3MNfZ2rvx603vf27T8oTzwA3klaKiz0VdkkUd5OQ3cnCe+Dxs80B
	WoW4VphkqQGTD2J6dqAFtoGX5GRv425q4rBvomSvdZ4mYrrCiyID3rWrw7wV2/15
	y27iKDRxmN+mKOuNqC9HzI4xSMvRpdXpI2sf2ec1SbJQZyia/vyh4pr3Re3E3s5a
	VtqBTg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5j4px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:51 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748e1e474f8so5942507b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690130; x=1751294930;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+wy8FW0+jFScerUnGQmFY4VIpRHcERfP3YQyx6WH9o=;
        b=gzHlHi6CNl+hkdhdtepLj6Pp5qF9GhhioFoW8Mqtgcird3w2b/FwNO/CyztndVK4BE
         6ZYev5cyv9TcmxHDi+/2SFYfa9jw+djKppLBGrN19LItwJjLdNIVlypknOHFPM2Oqf9T
         RNNXrNx/OezL8gicu8aOb/agoxX1zyiV8dvp5p7yyoTAVPfGQXJb6pNSccpgO4AwDb2t
         pw0dUHyp3h0MGq5327e91i7uUSlXdp/N+VbXk5M892dCMz6uAy4/7Z5qC7DM7tGZ35f3
         I2rJe/nlP2/0+CMDTNxV3ztegAD0VLFMU9rw300tdVJiNtcKS95t7mq7aITM+y2wPuiP
         OgKg==
X-Gm-Message-State: AOJu0YyPi+F3OCTqCgcDP1Of5g3R35lH05EKjD5WwMKuuUw0UqUTLoWH
	TtTU7mlCaN7UbrzLDyOKTLCMa9GsDmC7YmuINmmHphrVsCwNmagG6s8auhDks9udXj0HOEz5Gts
	WP5SWzv6Zru8ndWk5FrrNgy8HuBta1ivHYsw7K+Rza5pz15kqyMtvdq3oEKsrtuibGrJFK6ogQx
	CEtw==
X-Gm-Gg: ASbGncs5Un4W8Xx5PGL4cJW2kHK89scU0jMl+mdafnOZYXuO0xrF08Qj1yzpqGfrfH9
	TdMdjcH861GvDpdZQbK5M7IfsE+bIn8IcnLxWBDwfbaRmlTAnXVo031xiaGairNRQIuvNr5HX6S
	CV9AWxA8WbamoeFz32pV4DG/fSSyQctVSvroedIjZS+o+H+ms1aY+nWP3R9V+9lulUDM2i+VUrA
	HH2DtBp3AvpqSzAbjXdbqYbv8HUdtZTfMcTXSbUIFjE2ErLi0DMuTeDkya1wGlQPHlm8YfupMe3
	e3LQoQw3GpZPUPtERp7tFRWO/ySq2sh3UwtVMxe11mSVn5j55+QmiCdwNDA=
X-Received: by 2002:a05:6a00:23c7:b0:749:472:d3a7 with SMTP id d2e1a72fcca58-7490d9b9329mr19309171b3a.18.1750690129924;
        Mon, 23 Jun 2025 07:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGchTUzWsFzP7mgaI9GATxWd+ea784s0Aqw/P6sDKIaIjTTCJiTSXjvOes1TUnAIzahnPY5uA==
X-Received: by 2002:a05:6a00:23c7:b0:749:472:d3a7 with SMTP id d2e1a72fcca58-7490d9b9329mr19309146b3a.18.1750690129538;
        Mon, 23 Jun 2025 07:48:49 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:49 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250603103542.1164713-1-praneesh.p@oss.qualcomm.com>
References: <20250603103542.1164713-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: Fix double budget decrement
 while reaping monitor ring
Message-Id: <175069012887.3758471.17282538397999046159.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: H175skJ2KWvzgXud9K7mDgsUyRdFsw0E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX7kf0uRbSKZ8C
 rbTtj5H3Fr8Yq9EG3GONqP76w4NYCXyRW8jpMRk3AuGApEtZImOdRH0YtfoQmDoxgXQixIAqXvs
 JXGToklVtCXLUBsCLFoLZlGJLJP0jVoHkNFJo0NZz7LIsoxYq13vG4oBAHpCF/6jJ2GdagiRUMp
 2cH0rocOX/aJ7CgHiVfpmlaJyLW09dMjjoNFHt+qWNY4um74b0ttMHkWDKL9xYBSq7HzbS/eOBW
 vBhyPKvSrge/pyWLT1DyhxgxUPazSfTSrkCthVdGmykFdam18pKsPuuUloAP1DjeYqH/I51W/sP
 ZJzlqz+UAa/2EasTuGSG7/pVSSTfWVT+M8/wK80rexkpK8RejvbqeT/aWyaKq+20PE5pk3/gT9W
 u7CPCbfu0hwb0LiOb99FMNC1IuSGM0lstubvJRTdQOs4Jh28GPh/7kmXSFpkhtWVpT4jJApV
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=68596953 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=f0_862vhOG2d2rrTCbkA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: H175skJ2KWvzgXud9K7mDgsUyRdFsw0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=899 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230088


On Tue, 03 Jun 2025 16:05:42 +0530, P Praneesh wrote:
> Currently, the budget for monitor ring is reduced during each ring entry
> reaping and again when the end reason is HAL_MON_END_OF_PPDU, leading to
> inefficient budget use. The below mentioned commit intended to decrement
> the budget only for HAL_MON_END_OF_PPDU but did not remove the other
> decrement. Fix this by eliminating the budget decrement for each ring entry
> reaping, ensuring the driver always reaps one full PPDU worth of entries
> from the monitor destination ring.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix double budget decrement while reaping monitor ring
      commit: 54c350055b1da2767f18a49c11e4fcc42cf33ff8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


