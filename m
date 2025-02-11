Return-Path: <linux-wireless+bounces-18777-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F8DA3100C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 16:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E6CD7A4137
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 15:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C19253B4D;
	Tue, 11 Feb 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iE4bB9Nz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC0D253B7F
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739288683; cv=none; b=XBszIKeVx8+m6/lDenD61hB9bIOl6DtcO5p5HfQ7Vdnp8dGJHHaXCxkvbnLoSfGyTm9Z5lim6aaRcGnPCFF+GSp2bST1K/yUvICkuA7lo6RZZ0Ni2kau89s9IeVmYLfvWsVjDX+A6KjEnV4VcTEiwp6OdbPN+a7xlZRDDJeEWWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739288683; c=relaxed/simple;
	bh=wo163P0UesFqUyN331Mc7pZsnVd7IvDhBT9bentK574=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fu/Yb523VxtqmrDIy5/V8bEz7EVgBZCbEjfG1TGX8P7kvC8E5akPerNTyr0PcjAlU36t0lG23j0MUdajSGle3ok0VsleOtRLteJwoUFSMNXB/VVvVGqYVPkBFiYRV4nQXjUff6tEEKLQ3l3pPfiJ1dKd2vxG856gLLwn2YHUoac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iE4bB9Nz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BBHxZl026628
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ymCGsRh673k3+51lFOExPinq3U9WqfBeI2CDSIUeZQM=; b=iE4bB9Nzmhx1S89E
	9rnrK2o3152xJ4KvUE0GVZq05AHLyinFghSTBkoYKyXyjc0dM1EXgir6lETqqSEg
	4Fc9tKdZ341vs+giDWNXENL6wKx2d2/4nAnfsnxLPXI3Pg9xQrIq7bAqA6UT7gTc
	IvCDjtnG0qsSrevUNZnKKLfQh9UJYdoTp3CAqKR63Dm64G86h5jMwbx3PNnSSkY4
	mTcsD+ZhiqGe8lwB43Xp1D5aiyHtUwmSYNX19MrulbXMII2+CjhRUBXqTe0GkK6i
	pVFRSo3npkAG7vM/8/Wz8/tTccqivSlgHlsa23jt1viZir4KRHQLHM3agxPaIvxQ
	8uGkMQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44r5j58s3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 15:44:40 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f63226a32so74528875ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 07:44:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739288679; x=1739893479;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymCGsRh673k3+51lFOExPinq3U9WqfBeI2CDSIUeZQM=;
        b=uFu2B+5z/vijzTd9CJLsGi90T9VSxSt/blJ715DiDM7eGC9NkSJXMPmPmCQvEegI2u
         NicEf5VGefJfl4jDAzAA+QkdZd2ppsCnQpUbLb7Xd0iA0bpmN+oqPLQyuUUSopjORnFQ
         ammFUvEXKghu528b5UayzYpOGRAPWmf/vjyP53l/hKG7RRMzDxRu70/DfpekIsI0B7Mz
         80wNu3lKHs/ZiEY1NCbEr9XIxEGypZMViy81FLfCSNABBcCRT4Hii+cf37jIUP2fwkRU
         5o2/k28hfcHoG7x9+X/T+YtUaQi1yjl8ymSBTD6VHP74EKTreyOqWX6VsTfEGTtCHDGk
         bOkw==
X-Forwarded-Encrypted: i=1; AJvYcCVgVjz0oXHgUtkg3JdhBjBHKn8zt3QkfK7ve8+H57rHvBs5asF68UDl79KbexXauBVfWXSIC+QAb6CTilscWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEno/EaSbmBQaQemyuy6+nKMYyavRbht2mBAVKey5c7G7U+6p
	MS1qU/z/VZMWboVkrdAmG7wKw/1hCkwgdJpeo6So/cF3/BoIlUDfOX1P78j4ODgSXaWIMS1y7CW
	SIHja0isJCWWentvBb6AoYKcsAAw+vV5QkVP/S2KlhL+tq6iVd/GOMapeVsQyrH13dQ==
X-Gm-Gg: ASbGncsBXpqaSc4kyh9p2Zfo8XNWQsoTuIh4t9cPuMmKmuAjfs3p+uBuWGzflvaq12J
	NkdZ09x3MB5PcBdfpiyRh8U+pcJ3Z3BOHUFA2/tTwkmQjGG5qmVciSMV/2KJi7ay+6muK+uLqLf
	HTeTS8qu1EkovtX1g3IMOWGyhGQeDCk0wMaeTJxhu4iiDHuAQ+Ri0w6ef4rZbNDeGbf2hJ6Tejj
	UAD4ZN1iM1nTBcEk6oKnZcSK/hZUT332YkHWJOZkUdgJvaRu+C7WTE8z4ToKiYnHf+NmlnWRg7H
	MwCBYWFDPzNx9fIaj4UAznXL5j4FwtTnadd7kpkyJA==
X-Received: by 2002:a17:902:cccf:b0:216:31c2:3db8 with SMTP id d9443c01a7336-220781ebe71mr2486385ad.37.1739288679012;
        Tue, 11 Feb 2025 07:44:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgblWuZwpddqv/+atjEJ8t7ZVVqI4cMpZn1gJmiYamen4vJr/3pWQhZY+woUNf/9hSpTFJJA==
X-Received: by 2002:a17:902:cccf:b0:216:31c2:3db8 with SMTP id d9443c01a7336-220781ebe71mr2485995ad.37.1739288678577;
        Tue, 11 Feb 2025 07:44:38 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36510e34sm98399365ad.28.2025.02.11.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 07:44:37 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20250206221317.3845663-1-bvanassche@acm.org>
References: <20250206221317.3845663-1-bvanassche@acm.org>
Subject: Re: [PATCH] wifi: ath12k: Fix locking in error paths
Message-Id: <173928867747.1115150.6634049107701596787.b4-ty@oss.qualcomm.com>
Date: Tue, 11 Feb 2025 07:44:37 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: 9rJg4TzzT6QkBi3_cxtj4UTXCdL7_LT1
X-Proofpoint-GUID: 9rJg4TzzT6QkBi3_cxtj4UTXCdL7_LT1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=606 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110104


On Thu, 06 Feb 2025 14:13:17 -0800, Bart Van Assche wrote:
> If ag->mutex has been locked, unlock it before returning. If it has not
> been locked, do not unlock it before returning. These bugs have been
> detected by the Clang thread-safety analyzer.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: Fix locking in error paths
      commit: b9c7299a3341a737622e4de45b9c27e60ad01e3b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


