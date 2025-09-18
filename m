Return-Path: <linux-wireless+bounces-27503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B0B8769D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 01:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A96581C94
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 23:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D523301025;
	Thu, 18 Sep 2025 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SqeSWjpk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791322FF14A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239254; cv=none; b=NQIjP7AJ0VIHWS/n9UnGR21MOl+dEzNO3+sJWXicgzDVYQ1XwdnW+dUEen6AJWu7k/hT0rfivPeJ9d5qkGXI9pYNeSZpXTxKVqwpepznAkgrrQ7oDJFkX+q76JS0orASOmFTdoDWetOCCG+h1JD5kyaseXJNrMvrkRypFTFuee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239254; c=relaxed/simple;
	bh=Nv+MCiokCy3M+8CTX4vl9JVzgPKppQSAEpsutTt/bIg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GpPh/iWghgXXv41fgazO2Zut2kUnOCCn1jOTgwYzvw1ZtvBQzJy3b40SP0yPDnsnaFRiIBsVOnt7x8BSJQvqX+KkmTgYriow2k33/X2mWQNoDE8nP7yL0KYfIPuL+CFY7W1t9OaWdm7ovnHuNlmBE1yrk631w49UuoJ+vUk2HlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SqeSWjpk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFjSKx003351
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	znVREtlVg2TbngpLdOZn/WWH07iDbQ9DOMHKMLM8FN4=; b=SqeSWjpkMm3Gy5sW
	na6Q8e99ogR7PHx9shr3VMU4aXdJZHZQEWxc8nhY4myOHh0BLC4SV4sbQWtoipUC
	q7SRer7yY4cZy6JcpFbfkFc7jLfTlJ+JKCHBRVN2/g94hqDRHXc1Hxw8ya578vGG
	K5h4uVCFG8HDwC3ps5c/0qT8MreqykYOGsZZ9aXoft99kJDWqwogZFQwA3XsOwn0
	wUakVxGSuJx3qomhM04vyVttkgVMbewHH70s5fchTj5M3796PBtQEqmoH083TXEe
	ZQ7Yx14m2h6O/rDvYyuZylnSpQZyMCygmAhTKxb2x/wycotNCZnaGN6UzcMvxxPB
	BtMlIQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqgwyrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 23:47:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4f86568434so1117209a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 16:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239250; x=1758844050;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znVREtlVg2TbngpLdOZn/WWH07iDbQ9DOMHKMLM8FN4=;
        b=BV3saEgaOnuBAmJbWKl0PvAndc6pPISNOXQdYV+sDACIP8BFzIIJng3Lsk7lVEq28P
         psCR49HQwzf7Ld39t4hCuoYozpxb2WKwmBBajhLmtjkXR88T2gmPv5E/iHqD5mmmSIv0
         OLcoEU6hwEMHLz9jh7sPkC0lo0PN5dP+x/QxRol4KQJu9llhvybmBHDy7RJF/7i9WYzL
         P8/ERVdwjLdyI4IdLmzeqPHk1p5VU+SEK0WpzW1nONjJ864rcBwD8QYebo99rknhSHCv
         nuFNfNTMXq/i33myrMGtBE933xY9ZiMJ5/YyCoN0qACrRdD8eUpIBebAnCzBFsidAB5L
         e3rQ==
X-Gm-Message-State: AOJu0Yw9MSrSm9Ui2MD7mi9krmxVal3WH3HWTXiXt/i+cTAz3KLP2/3a
	3J1NfPGCldILrHBG9AEApZtEijhTHj1PWYj+CQF8vOhqkzuB5epSLVM19BdtAbBku2k+X8P2OGC
	iZ42Ax9vb8rbba9+HcPejVOLowLaFkhqWyS1P7l7OaGPvnFGrd2jBFekrUxg9RlUcDkYqrw==
X-Gm-Gg: ASbGncsGTV/eo+gbJXF84mu8Dnd9ON2gKfPKncf0/ToJnFVS+nv/hP+qpH1wBJQ2hj1
	mH3CURIKfREdVKhFFj5bAtOXg+fZEQlyi/e1JsXDwofd26CM3j07or1Q3+siXxUJj2wjBUtnusQ
	wRS/HZ81eP1LMxW43hpm/8sL7RCzYLttpyTfc3MSv/r24jYEev1Nt31BbECBu67Lh7v/eOBwsNp
	AfV3gdYGCuRJXwUQxPwNjYzaLoKz2Tha1BC+BdIsNmhCLZzV+Xi6EKUzMx3xBgKNBiFARUldf9d
	C6Cs3nqtT8ABXBEGOvI5Kgg2Jpc3TCzhvU+qWel++4xNZVNj8koikNsGgNNjNac617JSuobU+og
	S
X-Received: by 2002:a17:903:1108:b0:267:b1d6:9605 with SMTP id d9443c01a7336-269ba3f9e56mr16342995ad.10.1758239249716;
        Thu, 18 Sep 2025 16:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERbqV3wCkjXG3PjyKuXLu4cfZTg5E/48OfLH/KV9hBuTRpyKhpYzz7BhKJc9/AhEvCPV/Yqg==
X-Received: by 2002:a17:903:1108:b0:267:b1d6:9605 with SMTP id d9443c01a7336-269ba3f9e56mr16342815ad.10.1758239249282;
        Thu, 18 Sep 2025 16:47:29 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
References: <20250811-ath10k-avoid-unnecessary-wait-v1-1-db2deb87c39b@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: avoid unnecessary wait for
 service ready message
Message-Id: <175823924851.3217488.17742065327824732992.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: BXQZr3HQK94-W2W7JJjWi87IJoz6bwk2
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cc9a13 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JOwH9nCdIS4rS6tIlecA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: BXQZr3HQK94-W2W7JJjWi87IJoz6bwk2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfXzcVD13IpW1Vw
 A4cDPFVxdVuB5Yg/7C81Ll89V9go8xISXMoMKvmv17epT+8+X6mRtCeDNMu0b1sF2KHwzNkb56q
 cPzsmOmweJ14uhSlJxOg+Q0HKmnufILkD2hU+PHg9xN8WQavlHKeDVedZx6rScQYwf7fWOKu2hS
 pmMRfkE8EpnFhsvUtcI7TKJxERjmsz0m6V6KK0Xr1SC01L+nbYbPcV+VYq7ybT9g0QAFsX4ExFg
 k97uVURDUoL0lBTSyYtnP2NE7ezXBBTXXxFx5NBXF9IyP/pESt3u3z29bEgOkuwL6/aircqcYFn
 02u+t892nn7IWKJrERWG7uatvnT27brhQ2omq0a/HJ4NzrysiP9poazIXI3Wjf3lJ4Ihp/eheAg
 0LRBoGUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128


On Mon, 11 Aug 2025 17:26:45 +0800, Baochen Qiang wrote:
> Commit e57b7d62a1b2 ("wifi: ath10k: poll service ready message before
> failing") works around the failure in waiting for the service ready
> message by active polling. Note the polling is triggered after initial
> wait timeout, which means that the wait-till-timeout can not be avoided
> even the message is ready.
> 
> A possible fix is to do polling once before wait as well, however this
> can not handle the race that the message arrives right after polling.
> So the solution is to do periodic polling until timeout.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: avoid unnecessary wait for service ready message
      commit: 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


