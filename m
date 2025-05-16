Return-Path: <linux-wireless+bounces-23089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF1EABA2FE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 20:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E5F1C03DB2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 18:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6227FB3E;
	Fri, 16 May 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JhcQeGgB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384FF27FB32
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420444; cv=none; b=SeF4FnSQa/eXUehMvo2MUkMjVOW15aO74yVpb9yoxsxgBTABwhhXNaJqt9B3wHw9Ig5pEePyg+T8VHvw0yNFEK1DW9lmDo1qhkRcy3KbJaYwdlr/sy3MHv5YJuwg3pG/iSDaXxKdzuBGrGT8YIBN1gj5g2p69/K1np8d6cOqvOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420444; c=relaxed/simple;
	bh=htZuv6pashv36afkkYS9hF3nExlSsrWAT5iKAXx/kUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O1JNcN+O7BcHG4yOzHI3K1q/p/ejDI9NOR6yZUr6T6FVIksn1Y1f2bU1VgATrp/UfekYccvHlKOiMMtW70g5sGQ+H8srdzOkEWroGKvYKJgV9AED36oyseL8BGzlBp3dhJUALvA0smctILJwQA7ShOKRw4ylOjM/VhknfI2DZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JhcQeGgB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBID72026131
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 18:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q0svL+8Yfeg+vJiix8AzKhUs8Lq4dqmn7QH+/xdemwo=; b=JhcQeGgBnVPwHm0K
	nqmnDYrEUMdwqOlosGD588McBjTdMLNQpL7Xz9am2PPVrJl2illbMknGVgZvV1xI
	INOhZtdhKHYxBGAxZJwrxfYBF5XgNCqMxR3bV2SAZ7nvZ/qKvwXDDgY7AtSLPj9F
	KZUKWJJrTY0p3MWQecMjiJ85qJHbhHyda1tOii/GbG4gtfdU2TYuQ3PniMvpvYB2
	zJTjsvS86Y21GgaWRNJLtmPsM2KI+Nc6s/vrjCn+6acZ8TrGe+6Da4qlsF1+5/ro
	ztg5pCnnIOqJd1sT+jUp1q/tzZZFcItcP5S+hZ08l9Y61ywUmL52odWU0fQTjf4Y
	iUqb2g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyu3kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 18:34:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-30e0e8ba948so2486027a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 11:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747420441; x=1748025241;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0svL+8Yfeg+vJiix8AzKhUs8Lq4dqmn7QH+/xdemwo=;
        b=HipImGd/OKpRGoVNOeE4K02cQxylclCo/JyS5L+RuohFw/mPErDDlKjxk0c/jnnWWG
         +Rwi2KuDjcuPxMXMqtuyTIm5UiFY4KwUhEVE4fKk01XOaO48tDmGFwTt4tSShJGQoNdl
         qSG0yMqQO2/JuDWVLbPU2IWzK8Cf6vBJvtz+5R8xprJqnutv39EgGlj7Ja6GZw/aMHsr
         N8xszN0vWWM0N28wEFvMlUNCu/YBedasxrEmte9mBsMFUGA068I9BqYdKgaJlKdf9f1+
         oPlZ+ASGbLvJWdQewj9gWIUM4YefBIjcYEUpYEWrxXZromxtQRQQCmfK11+LjakA0M5g
         QD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNRtJSir/XzfPp7G/UVx1hIsFC68ZHhO/N1rZTvTyFBL8UIToyZ7kp9s7mHiHRmG73NOt+2lSxjQoyu+c9VQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfl7LFX0UOvxr78KhE3Bpy3XoycEMWw+JHeWMmz0SUjX5mrxdJ
	vXVUdjvpIINKmDx9B7wYUYZOqpF9z6b4wl+xO4iQr1uuyyFqboh6Mk5XEOoaE2txUykYlFysIfX
	HMfT9NvwzHYuKLIOsrnrlEP1hYCfv19s4GQ+5TTRHU7HEjeMDKeOPjM52WBq3ofmISiH5WUTScp
	NIfQ==
X-Gm-Gg: ASbGncsGKGmPEkEj/hFk1TKxxDPHJL08OJzL61xIMZwQq5kVvvd/RhXR0U/hfoFc+R9
	vad2qI1QUcFWnZIql5OHwKighGs5vO2Lh3SIHgWI/uLHVa6oZ0hfUCse16JcEoFj8QUx2zU1tdf
	uxCtTCxPIyEezdEztkzFTHmB5+sTsUzgqAoGmYqeXJSnUHmGMP4pinUUW88oWC/+4/iipUcCRvb
	LPovU6jKx1eYIuHWw4kgyI4R74o58P6GmQrpxULHLalJwBoOwSPIRRI2fMppWRoSEk/RSF3EKw+
	LDMpMo8NP0wzs12vVjrAeFsFQlXq5Eygg0tpMXGfqp13qE4u
X-Received: by 2002:a17:90b:33c2:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-30e7d548c90mr6850104a91.15.1747420441006;
        Fri, 16 May 2025 11:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDN0c6qarJQvD++Jh93GB0pXnmRuirKipjsMNV6jsu1UQrfj/SFWZkZbDZFNWhmtdcINcZQA==
X-Received: by 2002:a17:90b:33c2:b0:2ee:edae:780 with SMTP id 98e67ed59e1d1-30e7d548c90mr6850072a91.15.1747420440579;
        Fri, 16 May 2025 11:34:00 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d576babsm1886299a91.33.2025.05.16.11.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:33:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: quic_bqiang@quicinc.com, Jeff Johnson <jjohnson@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250428080242.466901-1-usama.anjum@collabora.com>
References: <20250428080242.466901-1-usama.anjum@collabora.com>
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
Message-Id: <174742043941.3092151.9479454399125527127.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 11:33:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: aonseu9xVurnqWcjevgVekGfSHvYMO37
X-Proofpoint-ORIG-GUID: aonseu9xVurnqWcjevgVekGfSHvYMO37
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=6827851a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=fqv9DNJugNdUxR9BDUUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE4MiBTYWx0ZWRfX9qr+B22Gi2JG
 H33Hg404RdnnkQuE22X2zW8vz3b/qdo1kH7Do+qFAYH6EVltK9YaOcY/sa8mj3NciAhdm67983F
 eJ2Y0PTPs4KtLpvKZPDjh80nxr/BgS4E2rCooFFCI2kuYA56pbp+VKS58WRc2Mx5x1tJ2XNpkUP
 MGc19T7oGAr8/EPALttvF1dpIq5sAljYnjNBAkh5j2yokllFcO2eK7U/C4WZIgl5RzqXAP6outh
 pZzghCzMm3isWwIFnuz0NWMc3uCsAIyL9iBSIWdF6xtumw6PDSELhEoykQkmsv2i3ycY2YhgkJo
 5DtWWHWSBx667r3aiocZuLJ0n5R2vuhi6j0a0xRizEIb+FRo8CIp6BgYFURKzxn16ODtVARwXch
 BwJyjmW4jYCPCrZbqK8xbhfsW9eqssn/L62bXjR1wKQr4UQnHxeYpTMVNtwSf9kHsEy9Jj8S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160182


On Mon, 28 Apr 2025 13:02:41 +0500, Muhammad Usama Anjum wrote:
> Firmware requests 2 segments at first. The first segment is of 6799360
> whose allocation fails due to dma remapping not available. The success
> is returned to firmware. Then firmware asks for 22 smaller segments
> instead of 2 big ones. Those get allocated successfully. At suspend/
> hibernation time, these segments aren't freed as they will be reused
> by firmware after resuming.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Fix memory reuse logic
      commit: cd2e7bae92bd7e65063ab8d04721d2b711ba4cbe

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


