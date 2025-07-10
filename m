Return-Path: <linux-wireless+bounces-25182-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123D6B00561
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 16:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8721C45B3E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 14:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEAD274654;
	Thu, 10 Jul 2025 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VgUcE23G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3578A23ABA6
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752158178; cv=none; b=nURvmq4oa5bacL1emCIyA9wX++VESSDAv+NSaUgxGRKjU/oOf6hDyPyucTVS9wWsb13DBDjfNL0iJulV/P/hz8gODCIA4d+uIFwbC1pf/a2zEqW6NTD05MmUlN3c1OL1ROkQ9Lz1sk3zWsMw2njYyUn4b+h2E61J6aitV0UwU4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752158178; c=relaxed/simple;
	bh=JhE7AvtQeMuDX6kNOShpo11zsSTi11yaa62qC1BeurQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tV+On50dwTdao1gSvBswh+xT57wiFTkMJSZ2WdC6WWrHV/WuhrWjVjrukT+fp3tnVklJApuK+pNPHY5081jIP3CgJZ83APIaE8fACcEuAIaLypNRu7fwdIJpc3KZFItYItF3txuJxluBWolHVvAQ2OzJmb24L43bjfiHPdGG3bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VgUcE23G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9Fx3L009948
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h/RmMphwpXUwtprvOSTHvrbX2FyNKRWzXRwfmMs/+4U=; b=VgUcE23G+TZqCwrx
	/qtJiIx2mVaFIf6tZbLbmIS/VKRAk79un81KrYcuFM7OfyQHGsYH1GeHPgXPXWQh
	lwKiHQDbb92YKiyK7CM3eejP2VK9XuJwaFhEOBo5SnM7L3HYZ+V1Vwafjv1LOLS+
	un294NbS7L1KBdElLm+C9VwjaorVwgaZJj1cUv+QH0h8ZSZu9c8V1dkWgsIJLj/x
	JWg1ATL5QM7esPREaU+AYNtlxpzr9cV1iErBwQUXQx6wn2HVS5h+xO/NCYRck/fr
	Q1YWq5siC6Yv50qrIDsnek8wC8HRFqLn5ICL5OVy9MLmIlDWrvhn8gX0j4UT71QV
	7txoHQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9dw9ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 14:36:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23494a515e3so9092425ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 07:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752158175; x=1752762975;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/RmMphwpXUwtprvOSTHvrbX2FyNKRWzXRwfmMs/+4U=;
        b=uOplwqYW6FvSCZtrGFva9JE0BlLQ1IVG9fY0aVg+hH/w3x7SX8JCo7sZdKRZYTdK66
         TiOfofcPYgnFC/SQbACeHxgyJpEAuoTP3Uu2BwwDZp9LNKyIoRmcmEdAebRj9yXugtnQ
         PcYZ7v7pGYP2fokgSOiI6cNpwZsOs0E9pDbndz8uViiNoa4JSiuJ+ppivVNsc2tX2pWZ
         IOOUIhgzoKkyyAA06TdM0l+BMus9+AFBp/s36rOQv2MnD9otAxvObZXmfgD2a4S3wUXz
         uZEJQILcx85haU83jXuOSmAzjD8OVjxXrcgdPz6vLLlKd8PCl0KpSiI+t5yN5POfpCCM
         ENHA==
X-Gm-Message-State: AOJu0Yx0466x/jjigm22DHfRmckuyXi2FCXq/CQ8FHIEmP7oknw4463M
	SO67qGYIh8IKqsY972tqQgdgY07+2g2lNYxQffzyHuz+4/FbmVgAcfxsfWQfX2m+mDyfaBbkmB4
	rhWqubzG80cQYRm6JKUOQcrUq4cGB0ICicPU1ISwO0/pa4LqMTqd2N4pUBPMEm/0PPeas+A==
X-Gm-Gg: ASbGnctB5zbgxww3S//zJDumi/uDfu5GfP/iauSwYVT54zYZLUqBCXrFjqu9YaDNw1Z
	GO5Ci4ZkZoSenNxXMzb5C3cl++ythdrfFoVVA2ySZWS4L/0BR2h7V0zJmXtZVYuy/93FnbRyLxl
	3zqf8L737vFMKUxXveZJlP0gCCB9Vlf3KnCoZj5qoMCdKcSlwkF7aHu8Ad7+8K8KZM6CNfO01IT
	abDe0IEujRACF/dx6VHybOPgetjbWT9zjVKrOMQu89xsubtw38+cHHf9947357wqsU1h4Sz2NXH
	/F/8LPZSqodstDv1HZRL61/OLuHruM6SF7pB/Ls7BFkjCbLQ3jhcpuhq4ns=
X-Received: by 2002:a17:903:947:b0:235:f49f:479d with SMTP id d9443c01a7336-23ddb191922mr101468175ad.3.1752158174699;
        Thu, 10 Jul 2025 07:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+9kZtp78lUyXCZPidszEdeSIgS+85w2fVPdUcx7byKpJYl9YCzoFS6MprbaGw3Cx0jxncMQ==
X-Received: by 2002:a17:903:947:b0:235:f49f:479d with SMTP id d9443c01a7336-23ddb191922mr101467825ad.3.1752158174315;
        Thu, 10 Jul 2025 07:36:14 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359a86sm23758055ad.210.2025.07.10.07.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 07:36:13 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250605050135.1802902-1-praneesh.p@oss.qualcomm.com>
References: <20250605050135.1802902-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: set RX_FLAG_SKIP_MONITOR in WBM
 error path
Message-Id: <175215817318.507672.1199336449389284432.b4-ty@oss.qualcomm.com>
Date: Thu, 10 Jul 2025 07:36:13 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: -paa8A-fE7-6uOhdyJjMPN_8yG91wugy
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=686fcfdf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=48WJXGFCw6zJ8tVVsPQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: -paa8A-fE7-6uOhdyJjMPN_8yG91wugy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEyNiBTYWx0ZWRfX7w+yYTCJU5dO
 X0fi3m81oRksl9H8Cr2EKWKM6lnBl5c6qoDfR9ChSPNYGL3xP+B68ca551R/zVxl21ddDo47d2z
 rFG7WHar7HcZyHxl54U0ho1Owh8pvPW2vZIZOJtjEk65JWCGichOXaastnMTFnxyZHz0tKL7Ci8
 wv5dbU1hHjJjm02JJxnwPt2pnuk5CsmLlu1NvZ1DMoc4ivAipnam4yI/jUaJnK1JJvCEpRsZpRf
 u1C/F9BSTo084WEBTMNhhB/8Xt+K85OH4+wSm6Ej3RsaY4RwyaIYdAOKIBEuGYOKPgO3VDdCA84
 OSGf02z+n0pYgZqGVd63+LPMTD2WqOWE/kycWhUKjaScht2tKaKxY61LSXlciNhy0sQZH2pFOFV
 3G+bZB47M4UtRN35GvxuGU/1DukyMZcCpIfzvrxFIK2XQhk70AaAVytrO7A1OhgrC8C7dmzg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=755 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507100126


On Thu, 05 Jun 2025 10:31:35 +0530, P Praneesh wrote:
> Packets delivered to mac80211 from the WBM error path currently do not
> have the RX_FLAG_SKIP_MONITOR flag set in status->flag. As a result,
> mac80211 performs unnecessary monitor mode checks on each packet, even
> though these packets are not intended for monitor mode processing.
> In regular rx path, this flag is explicitly set to avoid such overhead.
> Align the WBM error path behavior by setting RX_FLAG_SKIP_MONITOR to
> prevent redundant per-packet checks in mac80211.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: set RX_FLAG_SKIP_MONITOR in WBM error path
      commit: 0424cc3d70f6bd72e6501c730b1f95ba966e2ee9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


