Return-Path: <linux-wireless+bounces-24226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB83BADDFB7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 01:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798E43BB233
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 23:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C462BDC2D;
	Tue, 17 Jun 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fXKJO8FI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844CC29AAEF
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203144; cv=none; b=JrKIwqUHZ+NcnGzLODfhbPdgnXpBB0RKvy+bL/OPa5+AyGfbCwFTg7s08BwvKBTiowpvfMOLFYK2lz3/CIwdVo7Y8ZTaiA1+yCu/uH2ADsx58isF2aEeOQC8dQqUWow9xX+snNccQ6ICwKp27QEZ826/Vvj9EayAbPKohhxfqCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203144; c=relaxed/simple;
	bh=kps3vLmnJx3B/yJxyZndcBo7ZEWoTFzb7DPEPjlrTOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MgOwyNgvzc8iAbrFmNMpZ1XDbYE/s5ew7tCj6PZy3pnYGY1uJdXCUMHKRn9qSdxBpS8ArT0ja3qwWX+cX7ZswZqQprzSchvlIRsuetAn00KDNgesOJ93VVKMzpG87csBXM62/55Z6F0mxdQsWAH/EKJcx3DvZUC4RlwyDAbWovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fXKJO8FI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HNPqNp008215
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EZ4FdOFIakuXxnQEVyx+5eGfp3wSKPDG7zSbpNvGx/I=; b=fXKJO8FIMXuwCIeN
	tNZrRe9xhGdVsR/sfZ18+TjQqohSqS6pa3Vz58GcB7GC+FX4mZP9JLiNWgHwOKyv
	A2GbslE0RxhymP4UTNIelUUBXPfFLNxREU6nwks2+QkB9l/5hqfG1IfUC/nSaeEG
	KNu/ef+We3WJLKGu+pUEm5xLzRZ3ZidQ6AlL9pxUcyYbcHgCcpG02VE0k7Spk3n9
	HZPbJ7X+ZJahCZ5TUTmBl+ThBHWZ53rxvMMOp2kdD4yvFKxbzYW5NULSC/v3GkQG
	tjGRq94qdOA2VFhqcFB2l+NYTbak7pnAQUukyY5KSZpPHBInvvvMnT476fBYAwep
	Iet/Yw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4792ca265e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:22 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234f1acc707so40932065ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 16:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750203141; x=1750807941;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZ4FdOFIakuXxnQEVyx+5eGfp3wSKPDG7zSbpNvGx/I=;
        b=ObCBwmavDr2vXFESjkPVHjpeoExTkw7BvnzRUbQAjsTeGACARElYMk76u3P1g3su+x
         UNWADrPwFdhGgy5TH6/dJt9HoeeH09opnAzaTV083eaFYkCqckue39Q6Az+K/5qdYVIE
         kVmsu+mBEAqHRSTU3UvQh40KpodZbmmlLVPY6D8QrdjBlNm/xnh2v8kxSB5Z5G2Yd6IC
         6nS+ABJWncRl0Og0bD39+Skm3+ICZkapk/OgtuXb4RsJnfitX8dR+48JmGDy5n4UThi/
         CqxWvXZj2tLssDbvz5Sjf0lNtu+CeXsA8yZ0hR9WVPKK+XrQCMpHRsBu/PrS/FfduKvX
         6w5w==
X-Gm-Message-State: AOJu0YzBMgV692hHdxnvTjYIxFa0V/s8gnG8aPj9uPdJQWGTpHaW6Cia
	VYkdNb8t1KS43xn5tHfurQWMSOdocVWW91u28nXjCT16ob8+NJ9hXkS5MPONOgTqURz419ARIWX
	B12VaOi+JRUJ2SCfPTBipKsGf6KqOMGcgvEH07OBuAaXPoGoyjsY3fmF9mhs9BVrwsLF3Kg==
X-Gm-Gg: ASbGncv1sLMSLkGI9cXRtpTuZrFPowYUDEtKvTZETPyjEvBq38ebUgSqU/Hqy7Iwzog
	J+C7tzNOHMM89luunxK5FUZl22ByN0NJ2A0uKHoztBEt9guk4Cj51C5Jc4Krt5rXrP1PM5L6YPh
	9IiiZ0+lkYPUZI+WCZnFnpVWm0TAf2Pc+4kCiNvHosjERZn7mKx5Db4uJhHL77dTu2atPyRiWQd
	O6Fm6vzEW0dk3l7Ey2kIOve6b+nzKraAPwEmH7WGVCjbceAeFXUHnxWcX3m313t5TXgmckf+bUG
	yQgJ8SPeNsDbNiO/DdtmX/vR+1/Fs5ULEUIhKLKzOdzfnGabkKbs9o+rmHg=
X-Received: by 2002:a17:902:e80c:b0:234:f182:a735 with SMTP id d9443c01a7336-2366b3acd9cmr218531035ad.34.1750203141269;
        Tue, 17 Jun 2025 16:32:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHRvrUYB8tbc6pP2l3PnvgjQCwiR+ff4pjdfIGh3YBUmg+FQydrVipUHwAYmdF7GwwSPh6Rw==
X-Received: by 2002:a17:902:e80c:b0:234:f182:a735 with SMTP id d9443c01a7336-2366b3acd9cmr218530655ad.34.1750203140862;
        Tue, 17 Jun 2025 16:32:20 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19b84e5sm12731527a91.2.2025.06.17.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:32:20 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, g <gregoire.s93@live.fr>
In-Reply-To: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
References: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
Subject: Re: [PATCH ath-current 0/4] wifi: ath12k: fixes to firmware stats
Message-Id: <175020313996.3793705.1525991907377461235.b4-ty@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 16:32:19 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: pI9Su4gwasGzPQ8I9FD1ukvUj-J32qMU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE5MiBTYWx0ZWRfXyZ3z3lGJs3P7
 k6vVwKA5YNKMOL5HXITaz6Rx/cTTT2BQktGiUWdYVDxK9gKf7IY0KoDREAxF976hNCfhVCmcFiA
 CHR8FGFXPcv2Uafbd44vmUSUY7pkCaAy+aePAQ0exZcQ4Tvb1/ni7ADsVtPHU9G5pZXFV0+eeAE
 p/NEdUkwyGWETzZ9xfvr8XQtTV63KXXF2L0gED76X3IEvR585b9QKDeRd/q0brhWeX+T7CJV9Fh
 UykOH0/8hCg1OrDXVLTfXlbEUyPoX8cXzMQSRRkewelTQoOwd99YG4ySaAZWyJqu0PydlVIUQ4I
 zAE06lbBP+N+BYWeZTL3boolyMQGKxI6FkTRxHyWd0uhngzo3nqz1Y+57AWY2Zj2kvnHHCVF/5u
 mDrCahdXh30FeIZRpa2R7YJ1gCrpdTd3qoHxaii6NE298MX+oe0lspArDe5yN9MTfDu4+/E5
X-Proofpoint-ORIG-GUID: pI9Su4gwasGzPQ8I9FD1ukvUj-J32qMU
X-Authority-Analysis: v=2.4 cv=etffzppX c=1 sm=1 tr=0 ts=6851fb06 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8
 a=EUspDBNiAAAA:8 a=ImaOgrEwS3qXJJwQdZcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=967
 lowpriorityscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170192


On Thu, 12 Jun 2025 09:31:48 +0800, Baochen Qiang wrote:
> We get report [1] that CPU is running in hot loop while requesting
> firmware stats, fix it in patch [2/4]. While at it, fix documentation
> on back-to-back firmware stats events in patch [1/4], and fix potential
> failures due to static variables in patch [3/4]. patch [4/4] fix the
> failure when there is no vdev started.
> 
> [1] https://lore.kernel.org/ath12k/AS8P190MB120575BBB25FCE697CD7D4988763A@AS8P190MB1205.EURP190.PROD.OUTLOOK.COM/
> 
> [...]

Applied, thanks!

[1/4] wifi: ath12k: fix documentation on firmware stats
      commit: a48a931a32f88157db2baa31c10738a7fe660e93
[2/4] wifi: ath12k: avoid burning CPU while waiting for firmware stats
      commit: 9a353a4a11a475578be3c02dd17e70afe3a4a7f6
[3/4] wifi: ath12k: don't use static variables in ath12k_wmi_fw_stats_process()
      commit: ac7b8ff7839ded757806317ab8979be844766770
[4/4] wifi: ath12k: don't wait when there is no vdev started
      commit: ad5e9178cec589bf3af589dc43e638e5a5bf56fa

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


