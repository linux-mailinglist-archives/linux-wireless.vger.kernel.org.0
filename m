Return-Path: <linux-wireless+bounces-17513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2028BA1128A
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 21:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30893163B01
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B850E20A5D5;
	Tue, 14 Jan 2025 20:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDRfGmUk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D9B19149F
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 20:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736888056; cv=none; b=LaeligKP81z2yY4dUGMMzvcHOmxfi+dV+ohh4RRlx4uRlHPdjFYvi5R5yDFkOGg9vuAd8LQiWENwrNVwjdq6ul8y4yC5/xQrNwoQQJukNE/182P6KdN5Khg+HRzqhb6BM3UMaKQ0n8hC8R7cbfvSGxBz3YnoIi3UoFkmqQJqRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736888056; c=relaxed/simple;
	bh=D8aiM6TsILz6kD1iRIqicEw7g8Q+u/caSHUJrZcBngU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nT0IsOa4tZxnK8mfKQtA6T06roQuRC+BVYZfJNjKdLBtFd/F2sCjtdHXpp9cw8FePyrMufhOcumVq0oOql+iK7vQn56XGiEDN8r2mYt9JDZJuFDYoZ+GNln2TFObT0w43eJ7BzyVpYGCwYRJ+QinZRsP/6W1qkI2oirC0hFUOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WDRfGmUk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EGjunm027646
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 20:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UsGojtOFEULy7YGHzEEe4iJo5qMCszRU0RKFvHXchFo=; b=WDRfGmUkHbWQtvhj
	SHq8zbfPS9s9cqauj3wo+l8bWheBS8N7Evge15rjVl5VeyEt4sk45p+6lP92qNTI
	jCPiRRIHqoqSnJ1Yjqd7+Uj6DtzPJvPhGJmjCxovODNbbVwjFGPV2nJbm8p/1Mq3
	pomOaNRaOwW99YQfNxFSfaGkMbUX5zPAp6XJJ+pLf0/733+09PNI25rX4IyXgVKV
	koshCWPqloUVi4X/SwANJu9TQhlSpj/s+E/O1vsRE/gZZJN5WZQ9dcXpZA/ZaiNb
	dlej5iSMh81RNXAnABm29Gmotno1cPmG5iSgo0LQ6tiud808YGD5O8OLR8Xoc9rG
	ydiqJg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445uqsgj44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 20:54:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef114d8346so10125055a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 12:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736888053; x=1737492853;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsGojtOFEULy7YGHzEEe4iJo5qMCszRU0RKFvHXchFo=;
        b=UCY6Bd64QOoZNpvinpSCJOpkIC6Fn6/O2zg6Yym4BCKwoq+lzwAZO076qauao/SObG
         6o84q1oQgBlPgdV/5U7ifooIoNtx6NLZjIOPaqLudLJNEtHyI60CBqVEq30xCLAD3Ldw
         Dj1Z5UgKV8n5kRKELrzy/n6kYaQvjYOMvJpX1TB2a/2MxOBNR+z+D31b40yM41JoL9cj
         86/ak5j16IvUlgvaY39qy6UetPeULFp18xF/DFs7M6Vq7b64EKlDlAOCWUbxXRcDZTAz
         48Z626xE0nFUEL26BKEF6qshXV2uSGNW5rt9WpTMzTfppuCU9ZzLiB87XMXGym9Wt+0v
         mymg==
X-Forwarded-Encrypted: i=1; AJvYcCW7oiJEFH/cYq1FJFHzJB27UqD4K6oFE40SehjJMjITukAleVl3Q+jYoRocMzt4kEscv3K7BrjMyK+uk5VZSw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx54gWbMOLU2vVl9TNBb1ewXLybIltgsutTMIfpOGg159w7NRuN
	ELmW5kXM2lk+4ZHmSbkTL/Pw3GfEu/GgWG1E3BvLdiYBN0Q1+wFY05BHMET+P7jCmO/Dgn+6+cW
	HBIKYNvwXuCEt13fJL4VbKzWP3cGhuWpyIVsEaEfiYw9YKKXI70ULaOXvAoIzxfgSzg==
X-Gm-Gg: ASbGnctpEG+uh17skxkW43ghHCRyMmbo/H8REzWvkQkUa5u6ssPYBGugaIfF9DjqSII
	XNJO8/hn87zkVkpzAyzewuIfX6KTN5xRYfUXZ9suhvF729uMQ+3gmFc8rMr+F9iy0KM6jKEWl7X
	oOIisSYbtWDTZ1CrtmGZOzMerAiucu+xdQwniC7t5z2Hlxdg7JsusLjKqeZ3pl/KRR4w0G5nHHB
	SCBaN7jyV385G2jq3N9PNKqt6m3Pr2uhZq/zuNddOnE1UD67DWiCoCbfXu3Ex9rh6FTqeCd6MX6
	JcCeOz/wciquORpEgA==
X-Received: by 2002:a17:90b:3d09:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f548f33baemr37686095a91.13.1736888053392;
        Tue, 14 Jan 2025 12:54:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3Q6cjDv86VHBSJQbf6mRungfVjqpXQq24MQV4+1KVUXwek7Jt6hoJRKWSdA2ql9T5nYr9EA==
X-Received: by 2002:a17:90b:3d09:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f548f33baemr37686062a91.13.1736888053069;
        Tue, 14 Jan 2025 12:54:13 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad3b7sm12138463a91.31.2025.01.14.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 12:54:12 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250112-fix_key_cache_handling-v2-1-70e142c6153e@quicinc.com>
References: <20250112-fix_key_cache_handling-v2-1-70e142c6153e@quicinc.com>
Subject: Re: [PATCH v2] wifi: ath12k: fix key cache handling
Message-Id: <173688805235.2759377.5453459200658358926.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jan 2025 12:54:12 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: ysTB6C_Pyu4XkUxiLfy4uPOZL2e2D3EM
X-Proofpoint-ORIG-GUID: ysTB6C_Pyu4XkUxiLfy4uPOZL2e2D3EM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=914 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140158


On Sun, 12 Jan 2025 11:23:00 +0530, Aditya Kumar Singh wrote:
> Currently, an interface is created in the driver during channel assignment.
> If mac80211 attempts to set a key for an interface before this assignment,
> the driver caches the key. Once the interface is created, the driver
> installs the cached key to the hardware. This sequence is exemplified in
> mesh mode operation where the group key is set before channel assignment.
> 
> However, in ath12k_mac_update_key_cache(), after caching the key, due to
> incorrect logic, it is deleted from the cache during the subsequent loop
> iteration. As a result, after the interface is created, the driver does not
> find any cached key, and the key is not installed to the hardware which is
> wrong. This leads to issue in mesh, where broadcast traffic is not
> encrypted over the air.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix key cache handling
      commit: 336097d74c284a7c928b723ce8690f28912da03d

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


