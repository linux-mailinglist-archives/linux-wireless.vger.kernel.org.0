Return-Path: <linux-wireless+bounces-21740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BCA93DF5
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 20:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E658E4A0101
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 18:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F5E22B8C6;
	Fri, 18 Apr 2025 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a1tFClEj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA522CBF8
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745002137; cv=none; b=ATe7FPRhlcJvvT2Hyave0fgWxgBlbBT285LbXeaMUzZsR+3s9msvblFCXo5E4gaCfwdEgV37pi1WOE+dWH4PTQHDsu5udJLBmiwLnHg/V7viZcVDgP/9xFVABeHvwKMWhPT6aQRH8PKG6ZeX7YWdkjs1TNKqCe5B/kr8zOcYRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745002137; c=relaxed/simple;
	bh=wuB+po96jyJcpn4GfMishhM3sK+dPLxABDKFmHpEfHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co0li6vdmh+z1Jo2lbDNwHi36jEzVX37Nb92fCQEUZQewybUhvXNGw81H8h6HT3jeelvvcyUr63R6R7HonIy9cfP58H4HEOjCRfBbqBHYnP2x8dXNqnqq4uxpnb3/aasiYFj0jbtRnp5dgzEXugvbETLGxTK2KT4BmjBJ9Q6Eo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a1tFClEj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IFdaH8008153
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 18:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wuB+po96jyJcpn4GfMishhM3sK+dPLxABDKFmHpEfHo=; b=a1tFClEj8naI7yJB
	eXQKb0MGBhe82uZbz2bregE5Z83n9L2u98ER+ONW+9n0w1p3OIUHp8w9PgqXm54/
	kkn4U9oOcI5aS56b5Ax3bCuQFjBcnL3JCyvYWqGKFfM1ImXZu3khDY856BuZDWfL
	Kf5lyEOMPd/8BExzDswmok9CwMhVT7yNF/2IT2vnicH/KzCP+67FOmQ4uHoKOTd7
	No+01e4SG2Ct70elTLGKpV2rBJMURxGnbYga7r6OE9TxDBaJj9DQDiNjguY6TrLG
	3xr2EJ0Ad+HAv4Jk3pAtC6oQtKBBQssyorEgtiHgTOsbiaHMoVOK1n+j/sKUwqIe
	C0/YMQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxkak0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 18:48:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af8e645a1d1so1352767a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 11:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745002134; x=1745606934;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuB+po96jyJcpn4GfMishhM3sK+dPLxABDKFmHpEfHo=;
        b=QsFmILHBiauGCiJldNdrWdecDe4G4sy2yB5GPUXnOvs90Fxy9+lBK6o+rPQN2Mq//h
         3IbZi2zivTYwIoWm6aMIV5+++IEu/dAEGxi5FRURAxNi9ikzBhmV39PwYpmvs2JPHlug
         ZdFoqbeqzOdtgM99f5t4rLzA24f2/uew9sJGLP+z1SxuELd6+E7/eIf2c/BpkrIf+scr
         pD3OGz0MP6JvBDDsBZAcpBdL2f3qkG3TByLEn4Ojf2dlYyKRqh9+5Gzkd7SZ9BUZBDwV
         qYFcFvFMdMT6a9KvWdCBeKybGD6j2C83BPG1DCmGhvk7v7HsXj2lzFCwdrffJ2rUGCrF
         WAsw==
X-Gm-Message-State: AOJu0Yx5x70yPCI29vZo/TAVE1mSG6slyrOZ63ERe/x7BnVjOVAg8MrQ
	SfxxuS5QStzJRi+CuOB+o6QlDtQceq7niunqyMniVAoI35dL08tzfOCyUDq9uT0KUdZbP8rNShA
	Mn4sx8SbjAjQlXdtYPNTplWK/nwv+D6O+j7RQPhX5kv3sdOhUB003U2qe1wZ57z7yNw==
X-Gm-Gg: ASbGncu/n6FENP+AGvq8L6TVFlSgoL9tez6H2WK4NT4/zGhAjaB93+cFq2jMVpyGCGm
	nceGiUr84DzlX6DPnC/BgGdlHMTA+XfBY1Iku1zWYmQIW6nQTX7wVvg2jwOJg3yBPtDWXJeqT/T
	J5y2exgBojuQVcyNmmmQ9YJ+0nc9dbyQ6FzTPWdR4sk+bjTztL8fGjJOHJZ4S1rAJJ1nrU0oPeh
	lO2xOS4bmIE7V+7a1TEcNgph+6gbBzsv2sZ9yiV25RGMcuSfA4V5JpucGi0h0Wczi+KOXiNcb1L
	Kp37fpE2UyUeCiMpTmW6uWJoi7dK9i4iYZopDCNBgLh1hEPdla2FLY4jBDEkl38Eifc5wqRa1e8
	zX0il
X-Received: by 2002:a17:903:19f0:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22c5360dc9bmr53927115ad.39.1745002134173;
        Fri, 18 Apr 2025 11:48:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2vHOzst/8vCa4KMObopvWwTseNUfwEWkYiCQV5cjRLm5sx7Pyoz0/LrvQgWu55WOmepl4JA==
X-Received: by 2002:a17:903:19f0:b0:21f:68ae:56e3 with SMTP id d9443c01a7336-22c5360dc9bmr53926985ad.39.1745002133789;
        Fri, 18 Apr 2025 11:48:53 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4affsm20035125ad.119.2025.04.18.11.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 11:48:53 -0700 (PDT)
Message-ID: <1173e72a-efb6-40de-87ef-41ebee98aea9@oss.qualcomm.com>
Date: Fri, 18 Apr 2025 11:48:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=68029e97 cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=dZ8E1E-v023Ymm4DEa0A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: 7p_wKkkO6WmnktpUYNvxtLqVr8aeLWSL
X-Proofpoint-ORIG-GUID: 7p_wKkkO6WmnktpUYNvxtLqVr8aeLWSL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=724 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504180142

Reminder: you should be adding a destination branch tag to the subject prefix,
i.e. [PATCH ath-next v13 0/9]

Don't resend for this, but keep this in mind for future patches.

/jeff

