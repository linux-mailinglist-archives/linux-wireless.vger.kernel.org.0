Return-Path: <linux-wireless+bounces-24591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171BAEAA6A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD75A1C407B9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 23:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10E25CC7C;
	Thu, 26 Jun 2025 23:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBMt9D9A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022125BF16
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750979731; cv=none; b=QhjxaPyrSQcSxtRdD6HBU6KdYlAN9z3V1EaLkqiuWJG81C0klIP1sjDg5JbGSS3Z7UwYRpdvJv2crEYiEGQNIA/IvVx26zJRz10MS1VipQhWNFR/B/N6LTIKLbKRlpdxp637522vQlfDfxR3UDpaSq2dPlxtCO180hZmXGBV73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750979731; c=relaxed/simple;
	bh=wXyb3r/wYy/Y9Hgwgzs3s/yZzKiZUAYUWUjkVSdaEuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K4tK6zMk/kfiL/wWtfxuXh/EuPjM39bhLq/BuLiDPPBPubpc6uthtFbmculVlIwMqEPNOJq1W3wFS0+c+2/0Z9vmZZ/4rnhKEWIYJwfAscrH0EA0RsERkNBK6S8OuDRK1nNIfgCRP1ELyfR0VOYKAc5Ahppb5v0Ahasu2Z4f7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mBMt9D9A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QJTqwn015435
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QeT2KPHrUksQXiwOMplqgsQ1U+N6FD3AUDW54YPL3YM=; b=mBMt9D9AHbPZZiji
	faXOHKt62udd2axM3q32Ucb92G+lELL1Oa3JZ2koioi5bPvr1PW2LpxV04ip1guA
	N2+9TNgFFVK7neMnzujzfTq5CTNotq+Q0N6pqg/HopAtaGEjqOSz5XfHJ7YrGo12
	Bla6Q4Ucc9rvXinev+qe88PsfS5iRl2NIc3Ht3cPwpSdj399tvXSPlhRs+KtLG5i
	QF6u3YxRUN43XU6xWx3Kke2ceuQ/gDxZ8xA848qtZjWTONDkGloblGmaNMb65vga
	cHRoCR/pOWs/a36pLw42+CBI+tD8LsqqSLhMruZey+vL1kB8jnC0sYdEeQIRr9fX
	EY3uSQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47g88fejuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 23:15:28 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so1111602a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 16:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750979713; x=1751584513;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeT2KPHrUksQXiwOMplqgsQ1U+N6FD3AUDW54YPL3YM=;
        b=QGS1coeEAqmyFpuFlpDiH+JJLT3Dp5hS7Q/ExyABjxdBQNVa0JXFDevOOMVil3DyXc
         csD7NVx9nY2n/edQ0JZvYPZuF/PENlffmx/AsPwow92rMgV2hDqR8RqAveaB1ob8SbUu
         R1fqUygrhy+E8B5CC8pk5Xr6cVdk+mvWGU9Gbn/Td05r2nu7VPnsYJTz5c9yts+UNJIh
         tATA/Lnbf2YuKZs4mNRoD5Ue2CjxvGKWl8Owxc710cV1qT6rp02NzJBasH505adQLOa9
         i69H7d4w7up0B3ELkzOppn1hG4P3uOiz/nBjVpwHAvAf1wp/AWxas4tJqFOlWfvdGZNk
         i+rg==
X-Gm-Message-State: AOJu0YyIxG3XYTpjsrrdauVRy8cLQp/cbyR5qtc9HriTaGrlZTARSm0W
	y9xedyZY8wY1WcjX9ia9Vv0p23w8eeFrCHkKn6Rj3KNtfQATWDhKZQ6xJjh6NdaQTiwJZQ+Z3L5
	P+aXgT9MPDTl+NgeBiIjOcipNSHVzZnLGwSbjW/uxsnnBN+eQb0sF19s1QoXCYpl19xyHbw==
X-Gm-Gg: ASbGnctr3DGH/tzzpcufxrjMM1Aq8yv0IAZ/5WeSVffqT5v3ZpMC1w8tURqk/qwrUXz
	IC2M63JsrAGvS9vi2JI+EK+pefsrOIcVdG7RvL2qh8kbpztTAQSe+YFDB0uFkxQmP0AlfkVyQ4E
	Kc8ODfVgu0yjITGmKzih+6xMwwI6bk3Np5o2n4Yl0ZK9g6fcD74nf7OgoVm60vPKX7B4wOZu41v
	wBxKUOjqQ70OWqpwSqnenPypGWlxVnp4GNr5Jv/YSeACXgvzqxY017p0DkgYNsTkCG6LSo7RNGw
	eNcwUOMJPGhFGz9qqAKjVUWE4ztQ/etw0ZWh17x2ABiUvjK1pXoTz+4QV08=
X-Received: by 2002:a17:902:e847:b0:234:cc7c:d2e8 with SMTP id d9443c01a7336-23ac4605d70mr15054175ad.37.1750979713392;
        Thu, 26 Jun 2025 16:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjZM7kfjryOD1GdR5F9TG9re8seWvkCufqnpRGD5s0uPS8B0Ynib8/JhBBMrDAQYW3NoGGrQ==
X-Received: by 2002:a17:902:e847:b0:234:cc7c:d2e8 with SMTP id d9443c01a7336-23ac4605d70mr15053705ad.37.1750979712970;
        Thu, 26 Jun 2025 16:15:12 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3adeeasm1548105ad.156.2025.06.26.16.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 16:15:12 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250624082022.15469-1-johan+linaro@kernel.org>
References: <20250624082022.15469-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix suspend use-after-free after probe
 failure
Message-Id: <175097971224.153431.11379630143491274753.b4-ty@oss.qualcomm.com>
Date: Thu, 26 Jun 2025 16:15:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDIwMCBTYWx0ZWRfX/0cTwc15RvDV
 5wTkg4TsXWef9K+LcAtHfpbgfNy6+DR8lxTZyJZKsAvKEsIAubaO7JN1c45w9mdM2bbqtlhxp3l
 /9OGajzFPIDT4l3k0DySkP2qW9QYzbq3Eck0LxukpV8Ai3WNuljXnLciDI5w5TTOOZsqCnt4OAB
 58vUTR6hGxMopQaTBUZ5Mo21a28Iyjtw0vcAUO5al4dtY5CIsmj6LKOrZAiJFNd+YHE3lqaOJ+r
 /3Fk2TDQVIBGsi/qcpTqDgEJryTtwOM8M2Zgs5vlN6mMoiTbY9uSd6veAogXXJEAc+WEYHuAVBr
 pAnDYgri99F4OEiaVD7ygaKOENa6EosMW9FTkc60y1aZWC6na62YmmJMCodLNy+XeBGvovn8+LO
 oQeBbfQ6CkInnCqRDPWNZZIyZC4NmIJ9Uz2Z7yzdw5+/YHHOCe0iOLh+jWZ3Hm+MX9TOe+CU
X-Proofpoint-ORIG-GUID: O-30qOp_OxkXtykmKlEYmLd4GcHGuXZN
X-Proofpoint-GUID: O-30qOp_OxkXtykmKlEYmLd4GcHGuXZN
X-Authority-Analysis: v=2.4 cv=LNNmQIW9 c=1 sm=1 tr=0 ts=685dd490 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_07,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=950
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506260200


On Tue, 24 Jun 2025 10:20:22 +0200, Johan Hovold wrote:
> Make sure to deregister the PM notifier to avoid a use-after-free on
> suspend in case core initialisation fails (e.g. due to missing
> firmware).
> 
> 

Applied, thanks!

[1/1] wifi: ath11k: fix suspend use-after-free after probe failure
      commit: 8f9480451514c065dc8296c0db6e26d6c467fafe

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


