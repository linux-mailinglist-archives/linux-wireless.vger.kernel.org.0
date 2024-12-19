Return-Path: <linux-wireless+bounces-16624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B559F82B8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 18:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD29E7A53BC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 17:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA31A23B2;
	Thu, 19 Dec 2024 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LN3a/eoS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666219CD13
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630897; cv=none; b=YEmgJuZbO5zCU54D9XApvz8TREIeKRuetn4C6i3kZxcPba3DZJCc5imON6uGHog5T0gH3GqhqaQqvXXjadE34F305iKjzgbUqULRPc5ZN6XrORyl28xIgT+7gfV1/GAzd5ZminN52oOxPu3vEDpeSXE3Q+CTTFH/6SMC78HIPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630897; c=relaxed/simple;
	bh=GswUIzwoz3bCCWLd6kX87ABt23RmO17PxZ6QR/hmIh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GRWHYYO866iUIlS7qHK1dtHNUIisxOnfH3Nbv8X5J9Cg4Kvp3ENUFuD5Yzb2N0b5g7K39WuxQArhZVzo1q6VzBAQr2uqIf5DKa58aUifd4Qf0pAqeP7eLskcs+lrLBF8y44ybkmiKkcrb6fgIcLqIlidhEmB6lrbnxjKpJPRRiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LN3a/eoS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJGGkAf011034
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5haKGbPmr+wCNSOKC7HRHsCVFR5gFuEaq/dhQ+oDlGk=; b=LN3a/eoSOGQPvBQe
	wj7rGLFefDEGfS1ZBwyNf1cHqxA9mvdCYxdnzvtR7QPrkXXxJuW5/p+tNn0nuATH
	CDr1CgpjP/9SLGJms3az9sY6VXrWhVxGKFEpr1gCq0Uvk0IZNQFCac2vnk9M1vGu
	CCXLS1JemzUolgpFi4R39rCHZvKaGxyoyLFy806czWXB+248o1GndaR+h9BrWgwR
	fX0caxI0UTlVsVm1SLWwyIMrzKUnHY07rphd7aSASaw4zVvtLPlha+LBdKsD+qGo
	G5pHGu/dC6hVoFC5CX3j3l7cKR9iDG66cns4FTR02StphEFU19TJOo1fLV6Um+Zd
	GJCGOA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mpvag846-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so959052a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 09:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630893; x=1735235693;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5haKGbPmr+wCNSOKC7HRHsCVFR5gFuEaq/dhQ+oDlGk=;
        b=DHuySqKRFEdAmhc9hkrYxWyNfj8s9bC6OwtlIcZIL/2mmQ8K6IEPqDddGuIP/hr0TL
         H0d7h2DcvwglC9YlJQVi7iNz+Yp5F834wz2ctBr/HDo8y6BJ5mZtsBbgDy9BbyAfCfJ0
         XABLxMPN9fOqMK4oNIz7Sq8ZEJy7mVEVulDBQgJxgLWHJ18NdCQg280B1+tVL8+dV0Nr
         kvFxGHUXZ0jpfua5nUDUPTJvm+xHS2C3Ecp8aRYG+OpHSQoxqth1USg63MNjUYfjYBFn
         ygqKZbDNt4514P0SzMRprSbJJ41uhSCRrqnRKxhd52WeCSveah2pr5NYQ/gtKwoRdLoY
         WQ7A==
X-Gm-Message-State: AOJu0YxbXw+D72Fz4QQQm3AU/XGtK3VAbOZpjdOQ9u0kSSCYCfLz+ama
	JrCp99Qbg5RAviRM59cGJ1JObVYhBaXGhVVPKgrxWEeKeNeI7FVB6lAlThZ6JRlVbTtfpIRmiCM
	cSJ2HvT0xTESEzvhY+DaOGNbGctYk6MPKdyy/wOpODVgw+pp4lEa2zwJSwq88jvWuRneQ7bgiDA
	==
X-Gm-Gg: ASbGnct+1yjMsea9SgI5UGE/IULFDhQQ8xTuS2i+UiaX6U+4+MEB6JKMw7JrxhXM61L
	WsKY5MdCN3uzODCN/QZL2olyewiG0jhWznqv66wrgerATO0O+rucPNz5xunxUnlIrMv2sS/oV3L
	tuTIRd+ZfJTof613wpnE5il0Pu66NvqvQV+1wZGThlcqN/jNXSPVBEMHqwYLUwNNTtlLdV5LkaK
	klLF9Vr+bHhKJ6UPS1UVZScOvabd4b8LttGPlypB+FjwEdyOzt8QQxYvxE4TDqXMIdgv5nCNzoI
	2lpRD/h64N5LQcEzbQ==
X-Received: by 2002:a17:90b:2d4f:b0:2ea:2a8d:dd2a with SMTP id 98e67ed59e1d1-2f45216dac7mr340834a91.27.1734630893022;
        Thu, 19 Dec 2024 09:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGobhZikNK/hsQ8IV2fGUYfGV/HS6RgpNhx3v5W0we8LL/jn4YuAmzuIykLxPLhyu+dX53ItA==
X-Received: by 2002:a17:90b:2d4f:b0:2ea:2a8d:dd2a with SMTP id 98e67ed59e1d1-2f45216dac7mr340805a91.27.1734630892611;
        Thu, 19 Dec 2024 09:54:52 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26fdfdsm3630628a91.52.2024.12.19.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 09:54:52 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <quic_ppranees@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20241217095058.2725755-1-quic_ppranees@quicinc.com>
References: <20241217095058.2725755-1-quic_ppranees@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath12k: Add support for parsing 64-bit TLVs
Message-Id: <173463089190.2609009.942876248648067972.b4-ty@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 09:54:51 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: Y3IJln7b4cwR3XYEQLv7NJPMBSHrQNEu
X-Proofpoint-GUID: Y3IJln7b4cwR3XYEQLv7NJPMBSHrQNEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=904 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190142


On Tue, 17 Dec 2024 15:20:58 +0530, P Praneesh wrote:
> There is mismatch between the format of monitor destination TLVs received
> and the expected format by the current implementation. The received TLVs
> are in 64-bit format, while the implementation is designed to handle
> 32-bit TLVs. This leads to incorrect parsing. Fix it by adding support
> for parsing 64-bit TLVs.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Add support for parsing 64-bit TLVs
      commit: be8d47f181fd4f341b8beee1ca11a96d296d2df2

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


