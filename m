Return-Path: <linux-wireless+bounces-21687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650C8A92D6C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 00:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DCC1B64C54
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C37F220685;
	Thu, 17 Apr 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bzXWYKpi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558C21C19A
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930662; cv=none; b=Rc1vpR5AOOe4ZeWaBthWkMcJGNjr5u0eILbn8bipeSjA3jemOOtwMv1GjEClE0YGKoASp7P8MCjtRhIbjXpvTqwD/wFc9DDgpMzmhBi/BrWJFaOSJf+2Vro/zWGDk/Y7YMsfi3fP7QiyhK6qLHV963xS0PwHiHsLSOWWbbNgB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930662; c=relaxed/simple;
	bh=AUgIlT1I1MG8q6kMnOvi7aJrVtMu5HSRJEwF4/ybpJM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Qy6Go4mK60Vkjgv/d/4I00y9gIfIjD0/63vkmLrN4SCg98Olt98aQ8+2iHbynks/Dm8g9FfJiVJoIgCIWSMcGFbVkJ4kqTBNYi8LMMOdgCzNEhsLGftu+cDKThDra9KUwiNmPOqyJP8LSAWHJpdLDGOj4TDYZwpDu2kur1MQvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bzXWYKpi; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HMt8T9007964
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2YnGaO+20oY81gWUh2DeP3+hX6KtdcrAfVfj6JZUno0=; b=bzXWYKpizF++2I0F
	nryR5cbh55C56//gSoI4CtzRM5ZHJu72DGKh+sSVVmprkHyG2Q8jxLP1Df5ZI+av
	dEpJTvCR0KxshhYilb5xkaTxtbZ2BU/UjTtyDnPp0Q8SmkSvwGTK85sztEGYP04Z
	BK+CyXM1VI1uPqBnMEcfVz46EMgeCN3md15fgtZeLsd+rCF5lNH4Xf18CrA5FTdt
	eNBnOOQBcRpwYqNPiN3TuW/Nd2k06IgLQUgdwRQUVbe3orFy8lQRgYcrOxCa4D5M
	oigw4UyPBzaPHYRbGaO9QXiv1dgPrceF1BolEqTHs/idJcp36VTOCxRe2fveXu+S
	k1VruA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjra20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 22:57:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736b431ee0dso982075b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 15:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744930658; x=1745535458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YnGaO+20oY81gWUh2DeP3+hX6KtdcrAfVfj6JZUno0=;
        b=O1Mb7Jj61SipU8/kkCxUQwcqi3YlgkLBk3cztqfjAgJK8mAaWymPdCW8NaWGfNzN36
         4jUb4ByGgjnz2HMpX0PSH9fFjAWyjKGxOpka/aLeJAETVjY2nPhEwbCxdPpklaoGS8ni
         vM8AwpTpLAIT7Kwl7gwmyJ3B3i5SfqZx8PE7cqNuee28Jyz781pP+JmzR0dna0zjmqLr
         3OgMgBBJc05nMa0P5D1ZpHnwg2BN9mjcDr7UUgS+Fm3sOD1vOSokEDj4dE7fjPu75BUk
         bi+4t6ii8tDUUu9+E9wbi+7gSkWZIMg1oNsx+5iakNFBg3VlKxl0wabFNNAiyMdjq2Ec
         nGAg==
X-Gm-Message-State: AOJu0Yx9BBWb+Yov02yO9mhc5vH/J/k3eWLLkElYGkoabhZulZPx92GH
	w/6YbHkUG3JmoWcIS7uP8BUPfxMh4e5o01teTeVMe4vTmCB5VbZvIjuf6/7sXfM89c2aK66nA0B
	qJe4PDNR/yKU4gPvuCRlTekLvFMEH784ot039QYTYmb3yiJwSFc6EC8oD3yPRAGCxNg==
X-Gm-Gg: ASbGnctHpCDEGmU2J8xYhjbELL6vvRVy9NjDOqIGSGoQ8IbxFDy1OBUJ7NLvOmDZ/g7
	jSFtBzjf4TRMbtKklYJAu8ObLT3p8WVhauiPHa5HulCVDZSYEnmtnmbgx290O4QEYpiSsm1oGfI
	VcNZ1FX/8ljwyUpaSjrC/ozTwFM45schO0RNBLI8uDgxO8CEIXsrOikEhcKZZrGOI/ur2y6usRK
	kNuZH+SDFTEU72uS9Y9Z5iLtOfndAfbZOwBgDqGVz6OXWOHzZnbrE5xzqFwgqRKKjbWIgCAzGsA
	y1wWV+fxf6l4uTabh9zN2iE55Ecwki0lZGwvM0iggL6MMqSG
X-Received: by 2002:a05:6a00:2c97:b0:736:a540:c9b5 with SMTP id d2e1a72fcca58-73dc15d08c6mr642772b3a.22.1744930657779;
        Thu, 17 Apr 2025 15:57:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoB7H68XEErrSA2lFS2YG9DINArEYkCAURDJO0L4ZNF6Rv2nt8aHjeYRdun73VPQRwNGxqgQ==
X-Received: by 2002:a05:6a00:2c97:b0:736:a540:c9b5 with SMTP id d2e1a72fcca58-73dc15d08c6mr642755b3a.22.1744930657326;
        Thu, 17 Apr 2025 15:57:37 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf901187sm426468b3a.76.2025.04.17.15.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 15:57:37 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20250408-rtnl-deadlock-v3-1-fdc12bc511ea@quicinc.com>
References: <20250408-rtnl-deadlock-v3-1-fdc12bc511ea@quicinc.com>
Subject: Re: [PATCH ath-next v3] wifi: ath12k: avoid deadlock during
 regulatory update in ath12k_regd_update()
Message-Id: <174493065662.1347382.15714034015682377931.b4-ty@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 15:57:36 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: 8yRlCOqxBMMCc7yim4J6yTQvkrD_hjHL
X-Proofpoint-ORIG-GUID: 8yRlCOqxBMMCc7yim4J6yTQvkrD_hjHL
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=68018763 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=XmNsEsqR38t-_iXGnxEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=737 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170169


On Tue, 08 Apr 2025 13:39:48 +0800, Baochen Qiang wrote:
> Running this test in a loop it is easy to reproduce an rtnl deadlock:
> 
> iw reg set FI
> ifconfig wlan0 down
> 
> What happens is that thread A (workqueue) tries to update the regulatory:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: avoid deadlock during regulatory update in ath12k_regd_update()
      commit: f335295aa29c2198d3aa02366e7c42cb2e4f7c99

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


