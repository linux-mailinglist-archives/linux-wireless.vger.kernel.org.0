Return-Path: <linux-wireless+bounces-17450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A22BA0C4D2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 23:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0CD18813BF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 22:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4261CEEB4;
	Mon, 13 Jan 2025 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9Z5asUv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922E1F8F0D
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807900; cv=none; b=rPORyz5qMhQi94F+UU+H+sRmvXtgNA5N1Gdx7Vidyw8Gg/Tt5ylaGx1F6grm2kXZGe3hAg7R2sM0EYSpZda+JwL50dz2GgLiuRZge6tuah0JPIto17+1eoys3nDOZRbvvSecfTaRoTCsIVL6buhXmRmNgLDqdjYipzzCYmqQ4nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807900; c=relaxed/simple;
	bh=/gCJmy+R6N6hp5gIO4/sxnLOsyc57cDlP+c+hlTasH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjtjZXfCzNdpv2eGjKWv24aWTsQfCr936yBNSICcXCIMr5zaWlGShwPG8qdlS2B2grXLpcrsWxneyqaTRLgXsYHoR+15QlFVjx7wsYgulCXrXOSGUJex8Ar64QtPTYjKVg9FVy6OZn0eX8FfZ6wveoeKVa4rRxMbWE0Aqb1sk90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P9Z5asUv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBm9Gr007359
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 22:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BZvzfOvLKf+5Fzwa8q55gxMJ/U4kfYrn5TYho1uq/bY=; b=P9Z5asUvKi2qM+Yx
	nPSPDK6YVJHlE9IiwhR19kAYHRJT5NYqDE27Ho2UDVSzN3CkjwvLWY6z5MTx4NnN
	WLOaVYCsWPXg01Kwn7e+VHEoi1Mlx+SUcXRzcAIRFffGiEN3gnwUY7vps7JENWBI
	8vfIACziT6XZPVsntPiFFBE0EcIefY7IueCgTypLCbq4080qo3hg3i42uP8Dx32Q
	KGrKofDQ6QmOtm7o7rSCgVCtEQAXnY3SZxIHh+rfjbL2Y7d6XjYwXE4awXvaYTXX
	eclm+G0H9mJ9Gpl2lq67GustfQBL6piKUnf9JgrZQA28Xn9ko+djjY8CdhzSVVOA
	WGLI2A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4452939pwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 22:38:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216750b679eso60428025ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 14:38:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807897; x=1737412697;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZvzfOvLKf+5Fzwa8q55gxMJ/U4kfYrn5TYho1uq/bY=;
        b=RW1i4QR4DZ1ijsb7fwNPFG7UxEzq5Gasv3liumltkMAZAXnBprI4aNEfxvWsMVE+dO
         d8QYAq7ieE4AmT5Wo6eH1mv7zod8S0sX3sq9bbQFQGYEZigViOqsGQD+oJ8/bkYk91Y2
         uXAENgczjbaG6/vhEwST9PMd9vgF8MAV+8zI8fUiqsIsWQMXYyv4QLhVuFxStrHIvlpA
         BIrLGsXRco9pHVv7RYuLEq3pecO/C3cgiappZT71jqmym3lHEdCq/OeiEHYNIw3uKsZX
         dzcpZbIeJxNxhkx9VaIIuSHL9EHoJ7Aet8n7bpFxjYCPcYk2kaGoUdetsKFR+bWy0PeU
         KVIg==
X-Gm-Message-State: AOJu0YyvqsAC1lj5hiGgyuzKclgWUNRNxodRuPvJYBNvQ/2iTxn7Gdu3
	WIFJfXPsp+Iypb1STHFtke8ycAow9zXZOUU1hvbLs8tvxEuQgf9kmB84EEKSNEqDT5FN6WI+rUd
	eFnvl9MAVJ4jyTjd+obl6l3YG4ilfnPoCcbZXfXoVIVksLT/tXyeECVtEI+iqdPuvqw==
X-Gm-Gg: ASbGncvcrzJDaWmlliXKcsV3ahgVQDioFyD7Fw8Xu/QLo84J1V8fmnl8vuJSRvpzc66
	9pbfZC9ZXqjQqnwWost8Xjs5aDUY+5yQLM0o2fRed5tluk+lwhZPI7qAo/tdjj6bmMd9Oziw74y
	TVQE3nKV9Be2wCKih45vAakILBbXJrWgWvy+wWziw0uIwVoh9VjN3/4fksrm87QJieA2Aie2P2z
	ygwPW6ATXwgClYBDm7qe949kHOiii4ihv3Q1fcNkrYwywo6KyvvfD+XvdkjY6XCFLgeUlnnamuw
	KVezMkKL5mySl3ZV8rzPKf4ooa8Yltf2aGaqyRUwZeTcOY1gQA==
X-Received: by 2002:a05:6a20:6a22:b0:1e0:cabf:4d99 with SMTP id adf61e73a8af0-1e88cfa6b76mr39138179637.14.1736807896720;
        Mon, 13 Jan 2025 14:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcl/jD+THM4UEXUS4sHdJMl3DOcM7PTeRnYg+SjC/mqeM1JaiM5rBz5NjNhDNK28rgJS71GQ==
X-Received: by 2002:a05:6a20:6a22:b0:1e0:cabf:4d99 with SMTP id adf61e73a8af0-1e88cfa6b76mr39138145637.14.1736807896287;
        Mon, 13 Jan 2025 14:38:16 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4054894esm6383542b3a.3.2025.01.13.14.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 14:38:15 -0800 (PST)
Message-ID: <3da0a9b4-f318-4a11-89b6-dd84e076633f@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 14:38:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: relocate
 ath12k_mac_ieee80211_sta_bw_to_wmi()
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250110-fix_link_sta_bandwidth_update-v1-0-61b6f3ef2ea3@quicinc.com>
 <20250110-fix_link_sta_bandwidth_update-v1-1-61b6f3ef2ea3@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250110-fix_link_sta_bandwidth_update-v1-1-61b6f3ef2ea3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 31H6DtC_iDLpfSSQMhBCIArEzrrYMaYm
X-Proofpoint-ORIG-GUID: 31H6DtC_iDLpfSSQMhBCIArEzrrYMaYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=885 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130178

On 1/9/2025 10:43 AM, Aditya Kumar Singh wrote:
> An upcoming change will invoke ath12k_mac_ieee80211_sta_bw_to_wmi() from a
> line located above its current definition. Hence, relocate it to above
> so that it can be invoked later on.
> 
> No functionality changes. Compile tested only.
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



