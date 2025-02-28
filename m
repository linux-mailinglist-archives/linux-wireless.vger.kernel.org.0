Return-Path: <linux-wireless+bounces-19621-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918DCA4A33E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 20:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02E70174A4E
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC09C27293A;
	Fri, 28 Feb 2025 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZ3zcWUm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30779230BD8
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772611; cv=none; b=RAMANKM00k/2WQgAUZJxm7ZcavhE1Vo5TMGu4vG5xueCGGXZKR5dT92ONECcMjBp139Dnsz8PynPxx6mhl+nQj4CNpVcqrr7y11ByKZawe8qS8cH5VeEWyDG3tiR4ENLaqO3x8uL1THeOsp3ueR1x7s8OChg1V3Fp3KO9hURdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772611; c=relaxed/simple;
	bh=+6G95sNAYpGpdt4lhVmJqI8SNanPeyKH7ztqZOfCHv8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M6oe4yVPJyQS3QzY4a9su0U02PisfppPYBXjvi+/SwLAGh7KJkFjN9X4VKfsjY1m2v38CyOMB3RzCMrvbj7xJrizxb0Q9iQnQiDvyrGioP/jzQRj8rSromTJJDWO58A5v9lsLV4zQ8o1R/M/llTpyg0JiGtECEUphy0cmyvlbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kZ3zcWUm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SAXHMf018843
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3qF8i7KVqrk2V7E1Rt7ZLTFnAeJWhkQ3hP5vJGtB1q0=; b=kZ3zcWUmiyyutS9b
	nkiOjjG5CMxIX4ph7bYxDcpQU4I6AqH8JjMp0CfGJTZECwR+u3jkCg7BFSRLXyhO
	KDZR7lncO0IHG/kH7I+obZ9qh6jg4pqWaooQnDk0KlhGS23yrPflIZybXBhOToaK
	YtLywEbiP0zsolTrN8QfHfnX/r0pisHvN52rieydk0f/JmkfMZYCjXtpR7Ox2HeL
	mVvHzj9zRkAalqH5GBnPgOantdcehwV/qQtslJNDe3JEygdORu4MeLljSuPdc1C9
	TflLbeCcvIjYGos6ZyEHzg9by5Zgr9gL80nRsa9oSN4hKqFfkWJ0IrK+tDMxSdFG
	21D9aw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prnaecd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 19:56:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220cd43c75aso91835975ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 11:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740772606; x=1741377406;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qF8i7KVqrk2V7E1Rt7ZLTFnAeJWhkQ3hP5vJGtB1q0=;
        b=X206iv/x9vC4WVspP6HP8UJ2F/jE/PxnvD7z88gekiZdZt9fpEORbE4LgrsUvOm4Lt
         AiYGczhpQkrg4dEd6jBjcWs5vvC9ieEb1sprzD+k2f36WZopiY89ONX9YuUB5TrEg8p7
         p3ekVPxEAfmfLupjiPr1tU8TnRvgvbiFc8N2DfOV926WUSSKhJ6/CqTnGLesze/EeSDq
         dSHxBh4uK7pqRSAEdnbE19+sFrNvclzvnpR9QKkiWtQ81Ajqfu4bL+0Bj2YI6ZETVcVL
         Zw0bWmPZn7UHnrXdi3aXV7d74W2+o8pyhjB9OWN8cTQ35egytBpo5218ooq4GF/OtzVu
         IXZg==
X-Forwarded-Encrypted: i=1; AJvYcCVuD/k0pwvfAgoBI3fEj2LA88yKLqTjB/80cwZmm+o289T2xZIhNIQJ3oX0Voi5oE30b0OGRowOPwTQYVwNSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtXhcxm3cgArS586No83KtKqanzaCfF5kJBhDrjUbAC2Nxq6U
	cT3PDdyq8I/qcbUjYWJtukaMpBPD26YXeYsMpvNSaVsok/Hjlo/Yk/LSLd+F/7eADNs349EYUcm
	hVSL69CGYlN/0exqH9Pxwsp7yopm4rWNTwScHWjqoDcZMgSylsaYyKnIDqAKEFOJfYQ==
X-Gm-Gg: ASbGncvoIZr0DZTw6e6OHw7AcFtdjsrv74+uEayGUwgYtNLr2g2h0HXhN+YoQ8p089J
	ioZ6ytaD294If0NXH1EQXm3a4HcP/cA6gcHQhlnlfxJpE32rWIX52kVa4KIXRUPW08x9Qpx8pNm
	haIDI9WBD3t4vz7gs3xZ4xVSiVM5klu4DGLE2RPLYlKAgw7Xff+yGz6v9xvHYI+Q72NQRrqyfnY
	I7HUSw7a99Ea72AYI4pTwvqMUdFB3V0uVQtBmU2yGq5DXZNwtGIJVfw5RsQ2+fLRgnUf7eJx6eF
	DEQOw6BUWzV2Jrp6BOTzND06IVVXYCJ16sEWYAVS4Qb3Bk0jCSSt
X-Received: by 2002:a17:903:2302:b0:21d:dfae:300c with SMTP id d9443c01a7336-22368f60a53mr72832525ad.3.1740772606363;
        Fri, 28 Feb 2025 11:56:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExZWp04s694oFSfVY12xSazXlY3K9MyoNC3J9R+QbrD1vGsWlXV56BmqnqfXnoa/uEc4Vg7g==
X-Received: by 2002:a17:903:2302:b0:21d:dfae:300c with SMTP id d9443c01a7336-22368f60a53mr72832265ad.3.1740772605982;
        Fri, 28 Feb 2025 11:56:45 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505336ecsm37140165ad.244.2025.02.28.11.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 11:56:45 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
References: <20250210182718.408891-1-aloka.dixit@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/5] wifi:ath11k/ath12k: refactor tx_arvif retrieval
Message-Id: <174077260480.4132177.11927601453604393606.b4-ty@oss.qualcomm.com>
Date: Fri, 28 Feb 2025 11:56:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: gGKx0eTqRJjqtDMqsPWvcrUjQD0dMyz7
X-Proofpoint-GUID: gGKx0eTqRJjqtDMqsPWvcrUjQD0dMyz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=905
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280144


On Mon, 10 Feb 2025 10:27:13 -0800, Aloka Dixit wrote:
> MLO MBSSID series for cfg80211/mac80211, which is in review here
> https://patchwork.kernel.org/project/linux-wireless/list/?series=902914&state=%2A&archive=both,
> changes the way transmitted profile data is stored for each link.
> As drivers currently retrieve 'arvif' for transmitted profile at
> multiple places, MLO MBSSID changes will becomes unnecessarily
> bloated with RCU operations for every retrieval. Refactor 'tx_arvif'
> to avoid this.
> 
> [...]

Applied, thanks!

[1/5] wifi: ath11k: refactor transmitted arvif retrieval
      commit: ab8a17bc63e2d187ea4602e1d1b9baf10c7b252d
[2/5] wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
      commit: 8e30bfad4dc96c27f52b84b3fc5928252dafee5d
[3/5] wifi: ath12k: refactor transmitted arvif retrieval
      commit: 20fe6390b503f0c8fa15a73720fdceb2c3745c87
[4/5] wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
      commit: 5f1e9f2cbc2b8aff6a2bef9b67c09c8ac8923285
[5/5] wifi: ath12k: pass BSSID index as input for EMA
      commit: f4f5ee5e3a21830c3c4f1925108dbc7c3c070574

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


