Return-Path: <linux-wireless+bounces-22479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B107CAA9C57
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 21:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE6517D9D5
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5421115C15F;
	Mon,  5 May 2025 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BBiTabJW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB891487E1
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 19:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472665; cv=none; b=rPrAiHbA6vZxvC7vhzmDRQuMG6U7+jBLFCIwI6lzdY07Kt1Mf234pkg1cf3aYAE0StW5fVhvauQPwgwotwxOIVGLQqgaARj+ssvaGZr8y61WDAMbVtLFsjNYIPNuS/A2gygaeyMlzhbQEaJcOGtlRZ8PrKmaWZo78vOnsK15/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472665; c=relaxed/simple;
	bh=7mn2rrLB+XnCWDOZpcjuYtgBAhtXxoLufytebR8dLHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQiueY9bxKEbNmDWvNO7TMqeGMxO6VIGWRcdb75G24sIIgGF/tF68XnAC6v4jzBMPqwdFyT9pVPUiQ8rfstJOXB1TnOnYD+lJKavPrDRZDWgqob1oVYqShH2Za3a3WtrJPLFt6438vFvDvba15oluEwL61vGCu/ANbWe4D9nNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BBiTabJW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545BoX7o019862
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 19:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7mn2rrLB+XnCWDOZpcjuYtgBAhtXxoLufytebR8dLHs=; b=BBiTabJW+n4KBvlh
	R1w3pNpnz5dWa89tsPzuX98S8ZllEPCT8oKi0cdnxnXqm2sOjiJp+w8YJE8mtuTj
	b9tZ96FtS8IUc6cAfAsnpRQ7XWABacow/r36VNmYkqqP/J3XYiW4xQtLO2mWNTyl
	31Hyer/PnahgX6vdGkBlPgeaxzz+Gkyju8VDlKfu2ABwHw5uuPXWmGgJxZ92jF+p
	7+USM2gSk+PeQs49HTI8jvc5H6pDWAgUuQqAKyaAhI3ExPM/g/33AhIwikkxVWxA
	/gs6BAdV/vNpPmbN6NQOp5zKRChV4dAqPodRPKWm2OO3YSgYaH9/nonjgUq8PoBs
	BnESbw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46dbh7d11d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 19:17:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso4292813a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 12:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472647; x=1747077447;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7mn2rrLB+XnCWDOZpcjuYtgBAhtXxoLufytebR8dLHs=;
        b=vP/X4qzo073u2enIM0MF+VXpIpBMHId7/cUlNAYnqAHyFq9gn+FCLYAYkkZQKOwbc3
         PzAAy0lEnU5kW5CHXOtx5F0xYxX5VJtJDMt+qRecRQ4sVbsLnLbtElV+4VQRIllpAmIi
         bgLlgWwnocmJB5NoWM46J8vl+yeCEyzjpQ8qmmu60ey986pXHgQ3JFdBDQcDK78xyOX7
         Strl7CBwRuprboxGH470bFGdL9OAClBIZ/K/r2n0y3WLSjTsA0CP2/tAgYzTJAlI8PFF
         mP7CCgOUKwSTBpM89Q2Y6tu5W/joRieQuaz4DbItHyYFPeF4BooOJ+kgreD5pGFyWHM9
         +npA==
X-Forwarded-Encrypted: i=1; AJvYcCUjM3naYXIdtXhR1UfEpb43MBtMK1gZ2gpLNOipcpH5yw34tswAlO6DKOErxDcA+COohlFOimjIlcMPobM2KA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPh274wJsRw702LeiUHVK+iax11aVj1WOomZIPEM9npyxdGfr
	TgHDLUgMLSW0w0mWxsg6Ccvw1r1FrRkChzRGeiVTQcYYzfEiDxhHztKZLS8KpaxqfhzTaM0Rr5N
	7mdTTUkuhsAqnHH+XxTG/+0ise9lO0gaTcdegIs5Q2xB7IPyYqQLUXMX89JvOL5Zm9g==
X-Gm-Gg: ASbGncvdS3hgj2heEcPZYZHPoz2hfxCN1WJyBwF+XG9R2s0fN9xrpPaCcHefHXzg188
	IpG9sfqxT4Xsu44jYZQ8mTtCALd1lZeQ2EBluLiQ9jB+Z7O9pLp0qvlUhrT/N8kAjpX55jGy4W6
	f2fjl66b4YE1Izv7dfqe1jR103QL+AdcpPIbpe6k4M9LqiWQtmNotG2hFd5ttA01O1jXFU0jVUx
	8F3H6vgjbuFHG7aUpDOw3T6Qfk10bjRmY27PfLM4bUN3XVHwFsAFmd8EFNXzT4jgxdsVNRdXXaT
	tZXnVDV1iSKVJha4X7mNDI397jVinIMzoZLzLELtIW5sdfktABRUtyn8aCesu7vrQjXbb9iZQ+k
	zqLo2
X-Received: by 2002:a17:90b:2545:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-30a61a2bf23mr11942156a91.27.1746472647429;
        Mon, 05 May 2025 12:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp19+cr+5w9t5t+d0bTheMNcdBYXAAQfq5l9a4/Cfanoha8qZ0UTuQPA1laccqJJm2/wtiWg==
X-Received: by 2002:a17:90b:2545:b0:2ef:67c2:4030 with SMTP id 98e67ed59e1d1-30a61a2bf23mr11942122a91.27.1746472646944;
        Mon, 05 May 2025 12:17:26 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4762672bsm9313052a91.32.2025.05.05.12.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 12:17:26 -0700 (PDT)
Message-ID: <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
Date: Mon, 5 May 2025 12:17:25 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, quic_bqiang@quicinc.com,
        Jeff Johnson <jjohnson@kernel.org>
Cc: kernel@collabora.com, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250428080242.466901-1-usama.anjum@collabora.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250428080242.466901-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fMY53Yae c=1 sm=1 tr=0 ts=68190ed6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=aP1bZ6Fae55lA2u8vz0A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 2tf-fXY9h-IaTgoHpehjS7d3n8VKy3sb
X-Proofpoint-ORIG-GUID: 2tf-fXY9h-IaTgoHpehjS7d3n8VKy3sb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE4MSBTYWx0ZWRfX+ZFrkItbXmaH
 PbUFFkofdvR0YSLN3pp0lNVn6xs60z85dn7VZ1GB04UC2SdL5WgsAmjzQpJfknqSt5EhCdn69uC
 vVYa2f3ooXXU861cncE5Vg9gSST2/lVU9pX0Ll9//pFEWLRAXckDsJ+Bc4Ci1AdnYRl8KejN0q+
 Dh5cjCVkgNrCQB+zNvVE2TK3nHKptVwBnMel3N8uCRPL9WqPCa/XVXXJbBvxfr7cJ2NdLxBAeh3
 DSyNXS/weCGYuFchOUKqxLY2EuzjLpyowxCUZmYBE1QqIm+zNQjD+sT4a1ADzLzl0xpY3EBjivr
 G7vpVsgiyzCDrLi1EVBBf7Fu5VpypP17vPlJr2P9X03PLQD9zuRPlJiqEX24lGMyIF2Ltc8EBxl
 rfIi0UufVGdkzk3ATjTdVQCdI2465vh6FbjaJBgtmv30GbyidK59qdraBc0O3kxzY+GL/e5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_08,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 mlxlogscore=898 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505050181

v2 feedback was not incorporated:
For starters, can we make the subject a bit more specific, i.e.
Fix MHI target memory reuse logic

But don't repost for this -- I'll make that change in ath/pending

However, does ath12k need the same fix?
If so, can you post a separate patch for that?

/jeff

