Return-Path: <linux-wireless+bounces-21683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E74A92D68
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD70D1B64B52
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AF721B183;
	Thu, 17 Apr 2025 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dYjYUdMy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFDA1FBEA2
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930659; cv=none; b=rDRCc7xYKZa0aDngLSEGIIMZdqEmBGJvEKiMzbDknBzqi6rrcvVThc35S+6wMGaytAcnCLnQfS8PFdze+QSlrsnz8IlXGOq4rjN7gR0YaCUSPw51LZFVNVyqtJzOOUD+fI/ehOmKiTtOh90LpReE+0GgXN1E1shJp+B8dM35++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930659; c=relaxed/simple;
	bh=2qMplhQQK9bfXExVF6ZNN6QmXeagwar0NoXHsy1SHOI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OeCeAGwadtljkX0C+HvMK9UMPPcy8UiovtM1jwBOwmX+jrMqMKxfDSdwh7a3G7ViCNnxI+dvQCfkQ7O5htQbjAouOmtsfVZEYyOMidorrOSqN4UHJTkhm8Sp1I6BvwpUK44mD6NKYZLZqFQPpVusrbgbz2Yh1n6EgC67y15PwqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dYjYUdMy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClSNT014357
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zLmEiFinkCqTOFKl1HpXMHgW01j+DjPbWxjINLNw8DA=; b=dYjYUdMyEy0x/0YW
	ad2EnQpg+smjQn184JdJtGXq1Xf/emCSpN/miqogl9b3OpPr2GiPNPVqxTVKQmRY
	qELPgrHQfbK3N2jyxd7tFRZQHc78lx/DClBlQavySabNVqQFRT7OX31S2zppow8h
	YaDFBRENSLqIsNjpA1zkIJhRieTkJRnLhVJHhDHiM+35aEB8EdrCCZgZMpCWnz1W
	V6qQ3zAhUdmVfS5HfBKYMS81suYGeCYZpPCiypRNpTMyl9g+o8gkAFsAuJcGVr3z
	Tq8KGOK1LS2sU9/zTKSJMXWxwjx39/onlx2QpMdahZ4gv8s80bFPlV4C2EN2paSP
	LSFybw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1g9kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:36 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736c7df9b6cso1521970b3a.3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930655; x=1745535455;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLmEiFinkCqTOFKl1HpXMHgW01j+DjPbWxjINLNw8DA=;
        b=nbx+DqC8pTnnN6HfKPSdotVtMNXGK2noaG1xuHLkHh2kmifhwdydzUpKUWxtwPkwsq
         3vwlP3hGk1Tzvdw+m/ng2NudVosSRh9in+j/hAcTVncgKwFHbyxpIl0T4bnWEC2550QW
         /XiSXmuweh7Pmp46f1F1KzEhVRy+ciOwfuKPyIdoJIYm7aFObMeActXHV8z0hpH/Pt+d
         pFxGOXzHrkxk2skJAlZbh8uLfNLaoTwqDGmlyMHy37iymHw8XSjce3pDd7sxF12rP0oE
         MfcD2rI0go2rVR64H+FimdVLwJc6SNW2vBM6hd0JCjDzVT+8J9/eHVv4uvmesiewPMUY
         yiTQ==
X-Gm-Message-State: AOJu0YxK4UNYMwpT7pHv6xGH/g8ISnJh3Wq+F2RuvSvmJbOBt52ofGC+
	kKkWVqbsS0xixXXRwCsvq90bSRZLvgp9EM9lYxSq7+VLGJ6AaRKKOiURaxBEQ/hH6SZMSRj03GU
	wSy2LcKgrv11pkbbfugo5NDpb6hgpaAqa5A5Q2MZh3XkH+Hnl+H4zpPfmQ+yOCNlTww==
X-Gm-Gg: ASbGncve/awh7AinvMcEw2R97NyN4XpXZUPmcmXv4COqO0lMTjvIyXdB8JCHn9AJcot
	R+ckZhZYen6EvcREpy8iSptQ4yuRtr+AspgBE/yhH2IuRkm6Htv9JNq7h5E1MSIiHgHlc4MvacD
	BYG8JKzmgIOMLx5ITId46CNZ0dDxTvHSbONsP7eupqCAXO4Mv2a8v3luGJrvS/zv0zVwhrlL+PE
	IQVpjq0ZzcS8IiZS6ML1WaIWbsda7EVNxlWmHSgYLj+VQhS1rS+Tfwc21NKxaT1Pu1W0Bsw0t1G
	44+SSAiB6F6a/AulAxANOgRzTFiMHHuWPXXyiLlVcr7eAWpz
X-Received: by 2002:aa7:930d:0:b0:73b:9be4:e64a with SMTP id d2e1a72fcca58-73dc15d8d05mr694987b3a.23.1744930655382;
        Thu, 17 Apr 2025 15:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5Xdz9AwF0M7Ydwx8V+qE+zgm+QOcKbsYU1sDDQ9MJv51sIfJZQ/MbTnEQ0hyoJ8wf0pQppg==
X-Received: by 2002:aa7:930d:0:b0:73b:9be4:e64a with SMTP id d2e1a72fcca58-73dc15d8d05mr694957b3a.23.1744930654858;
        Thu, 17 Apr 2025 15:57:34 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:34 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250411061523.859387-1-quic_sarishar@quicinc.com>
References: <20250411061523.859387-1-quic_sarishar@quicinc.com>
Subject: Re: [PATCH ath-next v2 0/2] wifi: ath12k: correctly check RX
 multicast bit
Message-Id: <174493065424.1347382.16677408754808794980.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=68018760 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=lyCGXvvuIA_9HnfeN9EA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: tP6D9EnZiTRMYLTakJFBuNprsOz0uesb
X-Proofpoint-ORIG-GUID: tP6D9EnZiTRMYLTakJFBuNprsOz0uesb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=590 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Fri, 11 Apr 2025 11:45:21 +0530, Sarika Sharma wrote:
> Currently, the RX multicast broadcast bit is fetched from the MPDU
> start descriptor. However, in some scenarios, the value is not
> accurate. Therefore, changing the process to fetch the bit from the
> MSDU end descriptor for improved reliability.
> 
> Sarika Sharma (2):
>   wifi: ath12k: using msdu end descriptor to check for rx multicast
>     packets
>   wifi: ath12k: correctly handle mcast packets for clients
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: using msdu end descriptor to check for rx multicast packets
      commit: cb7433cc5cd4d07175dbc41f5a19966e9fae48be
[2/2] wifi: ath12k: correctly handle mcast packets for clients
      commit: 4541b0c8c3c1b85564971d497224e57cf8076a02

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


