Return-Path: <linux-wireless+bounces-23499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707D9AC8714
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 05:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 323434A3A2A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 May 2025 03:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0354652;
	Fri, 30 May 2025 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ID+luq4B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88B19C54F
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577403; cv=none; b=q2FkeDvzSzIbi+JXMIk7L81ZW4iiSRFx1T3nfrh0qQvhJqYmBgkKYkasK33tyH9P5dGXMIS8B2EcJWNMLNOZpIQnzDR+apQblNDG8/IExZ3Ow8dXtZMwv1V+djPj29zxaQIw5X0wukH6nfU5bFhyAnoS1AXu3zpebKTtmaO6yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577403; c=relaxed/simple;
	bh=r4QMW+6nPbx1aotp8QuGsIxzG0uyKiYfTP6IqZ5bSgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ernLN4iKYZp12w5Bnbb01Y8HN6CS2VLV5XJBw2rD5qsRpx38WQDcTdA25aZOaF5DH8T3mbcyEwcwHSF4+40Crts5W6THa/BpZLsoZ3msoO350Cd3cINXyNLvnXdAknYi/1Yn14dzlLO7n2/pLpZ8PGM0DjxsNFhPnMSaELl+d8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ID+luq4B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U069eJ009757
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jdWd0ET8Sph/xs+o09ASCjrikMx2pDVrlCs
	20H21d9U=; b=ID+luq4BKR0f+50C746I5rTmjqJVfqJQD+QaC7QfFDRXREauU+M
	q6HB+wBEWMGAMtG1Gh+6hEteRp+tJtQgwrHUvBBlypuuf2Nu4GFPq6zcQfJ+nsj6
	kbyJL/YSidaLQ9H94razEeDR5sLhlnn3T4UIPe8UNAT9WwvwVG1Lw91/Ypg7oJ9U
	2MtTbUWGMiS3Lzp/RNxyBceQIwCF7+dxbcBrSeJk5BG80WLPCM0dBNF8aEcpjA1a
	1jFZfGdb2qAMqUFqeNkXwciBH+6VGEjR2q9GGQ6S5dicwyDlR0zu2lwvniR4nDI8
	np6FRf2tbCU9LioT2aAc92IF+/wqNr5TZZA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46w691j9dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 May 2025 03:56:40 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7370e73f690so1771526b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 20:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748577400; x=1749182200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdWd0ET8Sph/xs+o09ASCjrikMx2pDVrlCs20H21d9U=;
        b=m0K7b7PkgTQfuAOornv/rm12vGbOfuHU+2XwDyuh44zacRvtFNP6iNmND9v9t2VpL7
         yK+9oB87G9PWqS5GZ1jBgtWaB4syh0zzjIBQlebTzpdx9AOxOsqHf661MuJhhHng7/Gt
         zoOC2cEWSlJCqv91aysmNhFQhvktMbns8xlmrVSU8YYqmdyivqvK/i2s0VjocqrNbXSz
         7uEpcDHNj9/8vvint6ExUzqSxensygEWNPJ4ga9wgexHDixoJznSaTzUkzrtj4W7O5R8
         yw7TVKGdmF/+ofJtamMrYWunwdkHC13x972pbAT7sbZWY8Vx8SQ8vrKYlFOtrzTOJwjd
         3F1g==
X-Gm-Message-State: AOJu0Yy81Ao0VUM0KC/UjlVNFltnmD1KTBDyRzQMNvwLXeQMfQqJHZuF
	8s+7XZpdXS0E3Z1vxV0Hlx8ccxglsWW388kEhv+iM2hpxq8IrYvx+JLLswmhgrsfCXUE5Ig9S44
	cn3pJ4K7+qQCTKmOG0As5GJySFNpBqfdigch7KEX8y3cYaNqc3e716TqrBkktSZADDlz7DQ==
X-Gm-Gg: ASbGncvOCmqVWal1jHBpm2vuAgLn2yuf7RioQx1ajPSZo/kL6Lq5K8YVBWF4S8CQgt9
	ejGwrLHkAli5oiA1VveGdFDl4Q5u3GjEilvkXgbzKhC3wC8IUTfVJ4s05VeG4sa/It9MgLpz6Ph
	sl0ubgfHOw3Lb/mAQXyT3QNvzsBT3TmZsCpvmAo+0aYiWMnFd88c7yl0eabZsAuIP2AudRYvD/P
	Ri7wU0S3vFTc3jCzTZaGz7bpBCRgN/mDU7cMs/UntQOlSNkrICFbFA+tfbQwjmOH4YNi0Z71CmY
	gIVmIQVv6kzxJFUHXccKDYe8GDrKkmUsttRVG1Hf5N0d5gFLh01rexhF5Wyk4ZTecunrOobF1V2
	CxnMUC8Tkr0h+whn/z8vBAzFo6DbuQGR6Lm/x+Q1N
X-Received: by 2002:a05:6a00:b49:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-747bd9e6d31mr2803342b3a.19.1748577399754;
        Thu, 29 May 2025 20:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnPc/WuVpNI3oK8G5Hxv8hf9um2vwaLwsn79HcV8zB9Xw1b0Gw8UptoCSA1gPy2MiCTeL0Dg==
X-Received: by 2002:a05:6a00:b49:b0:736:6043:69f9 with SMTP id d2e1a72fcca58-747bd9e6d31mr2803313b3a.19.1748577399348;
        Thu, 29 May 2025 20:56:39 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb96fe8sm705274a12.59.2025.05.29.20.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 20:56:39 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath12k: Fix station association with Non-TX BSS
Date: Fri, 30 May 2025 09:26:13 +0530
Message-Id: <20250530035615.3178480-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WfoMa1hX c=1 sm=1 tr=0 ts=68392c78 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=FOfoRkoqiD14MWsr1q8A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: BspHRFxFv5P2wKT8hyDBHcTQX2Mw-WCO
X-Proofpoint-ORIG-GUID: BspHRFxFv5P2wKT8hyDBHcTQX2Mw-WCO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDAzMCBTYWx0ZWRfX4hBJmPLMOg8h
 tmLRu0WPSKMp8XUNl0S42+Xn6YnfCeCc7tQE3fKOtXR6q1x0I1nhpGW77HBqTxbthoK3H4EKSXL
 +skYN6/cH4oaz5Ighs2UROwa25qGlPV6QYCK8+kNJx0dF33gH5M0MJw6+CTQwJXxnh/UsSmreSA
 p4lL6N0LLSrg641EfCTTeLqEy8vdB3+bLwxtdqyxyEKeQiqWdNFviWgHiNslPqMKKGZkNtjPlv2
 n933QrbkEeTZhOtQFxeeX7PvsmPuf6OJFNHI9cL7xVpss9BcUJQsak1SH47otUXsUZPla33byCR
 PIWTfFViTH1uw0SspTsZy7JO7P31rA6z3Jhs7PqZyg6TDY13uuWfD4Y/otTRtFQrYAx2aznqC6d
 kX5ZUL/rgzI9LKxWdSGM2Y5WCL09epHjhrFVP9fG0csU6kG77QLYUahigsXs50P6kgQ9jsVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_01,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=810 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300030

Currently, ath12k Station fails to associate to non-transmitting BSS of a
Multiple BSS set as the scan results from mac80211 does not have
information about the non-transmitting BSSes. Fix this by advertising
driver's MBSSID capability.
Also once STA associates to a Non-Transmitted BSS, instruct the firmware
to keep track the Non-Tx Profile's presence in the MBSSID beacon
transmitted by the Transmitting BSS.

Hari Chandrakanthan (1):
  wifi: ath12k: Fix station association with MBSSID Non-TX BSS

Rameshkumar Sundaram (1):
  wifi: ath12k: Fix beacon reception for sta associated to Non-TX AP

 drivers/net/wireless/ath/ath12k/mac.c | 57 ++++++++++++++++++---------
 1 file changed, 38 insertions(+), 19 deletions(-)


base-commit: 5b5f14fc4d737a956dedafb996459c4276f4fa49
-- 
2.34.1


