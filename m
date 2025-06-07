Return-Path: <linux-wireless+bounces-23820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246AFAD0DFB
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D830016FDF3
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Jun 2025 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF2C1D63FC;
	Sat,  7 Jun 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTPY57V7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF71C8604
	for <linux-wireless@vger.kernel.org>; Sat,  7 Jun 2025 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749307443; cv=none; b=and2axqlX6g9mAI4irjBE6P+poFEiXQ7zCaccP4gYerlLPAojVaGB3r1zChryB0rku2zemhJ/rGkVfwOPlx3ZTS/QvsN04gKzlBLPAWixARLYUTkKC5+s4La9dj9THBNaiBon1mSpQBkVEV1Ii1YUYG11mNbV/pq/qXZq/+J098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749307443; c=relaxed/simple;
	bh=wslzCSJytARY51oE/Hg+iUJCMc9tRFDOZbcCV8xVUO8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QddoguDjrqmfl2pMdHDF2SwIkVcBkNZTrurngYnqjY4q/6T5F16EbwC7KRdI2rtgP5uAXsYND8NoI6YNs6tAN9s2A8fBMLtHtd7f7GY02jM5BTucHDt9ZRw2uZmfAU+xDAqR0cqZZc1qa4nn5zNU0/Xk4pa8wgumJge55GKJajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTPY57V7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557BCXoo029480
	for <linux-wireless@vger.kernel.org>; Sat, 7 Jun 2025 14:44:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HRWxqErks7sLsi17VyYwdDjgFQ3hE+NIBCIEY0BhHX0=; b=pTPY57V7hUH8c1ZQ
	PkuxbukW1jZub0u/K2RP1c0is5CELCu9WbhV7kAEFh+C4h6c2UrsngsJUE1gF4+x
	XK5qh0lngMJJLS8uXzQ4Jv7pbfhhROXp+ZpSrt0DMwcAjZX1eh8fO8IP274zzZJx
	cF8p9BLQ4rKnj7mhOtOtDr+RQf1N6aePe7U1IcFf+OupoycnB0wMEbXDy40qKB2z
	CL//b/ldOykrBxrCXXNGfcpsXNL+PJapi/6DSF5XI8L4GF/EpKuHIjPkN/g9mg0m
	JIqDWZbob7ThlNVMworSHg+oLkdjFwKSZrd4PIHqetAwgChVkKPJ0zFdaqd34yjM
	4oWj+g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474asrgwgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 14:44:00 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-310efe825ccso3049270a91.3
        for <linux-wireless@vger.kernel.org>; Sat, 07 Jun 2025 07:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749307439; x=1749912239;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRWxqErks7sLsi17VyYwdDjgFQ3hE+NIBCIEY0BhHX0=;
        b=rHrpquVSAH+VmjQ/g0h6B5h8mKsYeeHtBQH4zFzc7MNNrf81ZXQ2CaMQuQU5oypbwM
         ZdZLMLg5vPeEVly8fNU0k27qjn16DEhau5P7WnJfWuKzU07on9+8Ku/LdhC1zeKpmBC1
         l7Fv7a2AyoERPxsTDBlk9E3vF96HSY1QEv0qQa+DXHxX+UYzGCFbD5HpK6rDKqBao0Zj
         cBPJDYnOitQeVDBX0zV07uizG42Uap5J+QB8WvYjBU8FIlYNRzPUdgNc2q+kzoOSjMYI
         tNdKxV4XzLWqBbfbgSWK0AmdCZs4isc6zpso4ZKb23hrogj2o6VBQt54ZaNDnPMh66XV
         I3qg==
X-Gm-Message-State: AOJu0Yye6QdZavAxndDfXpiaCQsTfMMWYtrSy85amOXrDUfdrZVKGh/Q
	zWWfcdUun+GaseXbN35VAyGVZ0aZy3gxsG4mNlWTkjJtR81zsc5HdDOuITEha2goNveIahxU0F2
	b2KzXwhJ17RE9+EwSZFW5mlrFNYl1iSnVvH8kWgb+FmQhBpDJCL7yP3IVjPpE9d80ZuU7/54cNt
	nO7w==
X-Gm-Gg: ASbGnctOz0rt45bVMNGH9xC7/brZ0AgXPYcQe+5MNrr+yBBX+4VAW7x67d8+hjzZGZM
	EG8qY64CY7uJ4TlHH3encEWgiJfVf7g8FE7ULEn0+X33msMJDMB4vN1Fe7qL7gNzAdIWoZQsqcb
	l6K/I56KBnWtOnpMEfkfwd8hS+GfkwUy1aPZ2tJzWTknh7cpIUTgqFGVW104mqUHWUaCg6dyO3b
	quN/9GtTCk8Ew7gq41R9nd590JI00zNRLJ5D2PsAUmRVCuch9hPy4Mf5pLFwIuxsy89D6FyCemM
	ZrvqpDcXY9VsC2q0V6Ys0dsB6ubobozsxsNM8WP3r5iHiniy
X-Received: by 2002:a17:90b:17c5:b0:313:33ca:3b8b with SMTP id 98e67ed59e1d1-31346b21437mr11001100a91.9.1749307439067;
        Sat, 07 Jun 2025 07:43:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDwn6zz7we/kYyYomL1SNvZE3a9uBD+QUcaiRA3aw7AIEctjVjHgCFcuGzzWzR2vEeIkv0Mg==
X-Received: by 2002:a17:90b:17c5:b0:313:33ca:3b8b with SMTP id 98e67ed59e1d1-31346b21437mr11001082a91.9.1749307438700;
        Sat, 07 Jun 2025 07:43:58 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236030969ebsm27626415ad.72.2025.06.07.07.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 07:43:57 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, s.gottschall@dd-wrt.com
In-Reply-To: <20250304012131.25970-1-s.gottschall@dd-wrt.com>
References: <20250304012131.25970-1-s.gottschall@dd-wrt.com>
Subject: Re: [PATCH 0/1] wil6210: fix support for sparrow chipsets
Message-Id: <174930743747.154748.6289755371455487003.b4-ty@oss.qualcomm.com>
Date: Sat, 07 Jun 2025 07:43:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: BaPp6R4RO6WE28Bpqa_ikIY0UnceFezY
X-Proofpoint-GUID: BaPp6R4RO6WE28Bpqa_ikIY0UnceFezY
X-Authority-Analysis: v=2.4 cv=AMUSjw+a c=1 sm=1 tr=0 ts=68445030 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Y5XITzagAAAA:8 a=EUspDBNiAAAA:8
 a=WD2RVSGR4ZOmZR8fVjQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=dfzBCs9aBJshU-flp7fy:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEwNiBTYWx0ZWRfXwOJI9CP+jOFn
 x/S3vr7P0P/5uwH6RcdieIh+AqX6Lq1/PK82hcXgXDspVmgwrAvHNTmFAc8iDtjCCsKrqRe1hnY
 by/V1/vmKJGO86oMri3TOLU6GuslBCw/ar0w/TrQXcfhDTBK0WnE6Ibhezf+gyH9JKViEFEa/NG
 ur5lKW8kyakB2AqvrgX9nvdlDKUDQeVoda63CSY1qchqAB/mdg8gdQGkBeqsF/ILkoDVlnVDwk3
 hIPoRJjt63XM/2o8lmSUrIk5ij3+7UUaukNQIoK+7pU9eJft19TYYoEkP4vSj3VDypBMRBjw/oH
 X1jLBu2Wja/XfFxTvgbaR3XcDhDIuCUtG3CviotqkTWQZSezxhGOAJW7XQQvmrn1/UFtf7y905I
 8OyY64KM1ZeWHjNScaK1rxR7tnaGJb+o2sqW4l3Gmvij7tYKMhMyk+RWqEYOGf0kH4B//X21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=515 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506070106


On Tue, 04 Mar 2025 08:21:30 +0700, s.gottschall@dd-wrt.com wrote:
> the wil6210 driver irq handling code is unconditionally writing
> edma irq registers which are supposed to be only used on Talyn chipsets.
> This however leade to a chipset hang on the older sparrow chipset
> generation and firmware will not even boot.
> Fix that by simply checking for edma support before handling these
> registers.
> 
> [...]

Applied, thanks!

[1/1] wil6210: fix support for sparrow chipsets
      commit: 593963660919a97a4546acfd706dac93625724f5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


