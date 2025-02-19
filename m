Return-Path: <linux-wireless+bounces-19143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CA7A3C6DE
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 18:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704CE166AD0
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09E1FECAE;
	Wed, 19 Feb 2025 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CHuv75gS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CCB1F61C
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739987920; cv=none; b=TJ/SI3EDZ2RnoEdoNJQwg4prJvYUl1hJ6iSHWyDabi9/TlpVk+OCudxBojIjjO6pH+JbCi/19MTsk6NA6MwFqHWXDDlqJu4g/sqEMdgJPd8t55j1j+xmhlZh9A531ys4hiNcgf/pmmnR2TPzTind985S5lUPGyuqePp53WHxSYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739987920; c=relaxed/simple;
	bh=RgbUJcAldgo+cnFThyZfjVSmMgZuU/bHqOywGomR4vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZtFTzF6HrsC1CuI3OF8kkLDpG81Ap70ryNnW+Lz62JyL2B4dM8JO9EuD+ViN9L3I7NAoOIhReqI7ahOPRfvKsyvJweH/6DQ2oPSe9yWzkw+et0scRUbyq2idjyJIjW45nyqAw9/m9uzh3VaTXRwDrqf27j6ZwQRE+8mUoC2Dafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CHuv75gS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JH8dNv011647
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:58:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RgbUJcAldgo+cnFThyZfjVSmMgZuU/bHqOywGomR4vQ=; b=CHuv75gSQNw8cWto
	7x2xy2sgroglwfCYnlf69dW9na1skACDzsmKXCeGKiC1S4IKeiKHWloasHaS1l8i
	R1KUtmfUeeIj2SK5A66f9xDBdMtZ4ItzjF563FDf3y9PMHYgT87Gseiw4M11oCz4
	6s/JNpE9c2PMMqCIoHWYJU+h3xf+amOgtl9voaH6kt6GcrPFKsHS7FQty75qaQig
	5FvD5NKelUZ/xxPeJmviLOs4OXrc1YLzlp+2+SpjWn1F7ioDTbH7qQVE2qHQY51w
	uttRRo7gwnDrmfagQfr+bfleXz0Y/MzsJrd9DFfXIWp3WmPtwV4Mrtcw+SfTSs3z
	yqt/YQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3kght-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 17:58:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220c86b3ef3so23161565ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 09:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739987916; x=1740592716;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RgbUJcAldgo+cnFThyZfjVSmMgZuU/bHqOywGomR4vQ=;
        b=mA/VpDWqj04upUuYkKyGu5+37JGEiQoXbbvY5punHZPUC8jZobm1oZXrRPElkEIN1Y
         tMRQ4xadABj/lsjxWQ5ZRYM/yLj0YDanB2Zjkp5xGJRthhEZg0sblVOjF/xu45XPJhKL
         ZhrUd2XIxsD01FBcRhh1tsY+v0E92HOk4sAN27MCpP/cB3iVfTvzHEyORx6B87m5u5ii
         waybrTmBnA1Em+AX3tAb4v311fY5N719ishVrUqfl19J3leOHBZz8LpFA2qSyKhK+nPj
         S5P1du9BNn2d2ncmpA8RMULA/JlXRGv6V6ZYeKlM5fmMs5JdTS0SLFKnyXTdrki6fDkT
         17aA==
X-Gm-Message-State: AOJu0Yw8iNWPnd+sqpv48UKj3FJjut1A8pdVGCpN7wPlLyGXpYidNipl
	NiQifaECNbj+rzcMzMdZ6dJ++qHYgJgHMZXoqEwK8t5J3usXy0dQwG+Hs5FfmbrdHIsiOnRb27N
	ub8ET9LTPSFyeZp2jnjDLbeImwQKu0Q4k2Tr2E/jXTMyS0zCGeFaUYkZO9Dx/m1ssMw==
X-Gm-Gg: ASbGncuFWKELjfqxyKrEhq6HAoMhjmoe+jMtoE4wh1tPbYoDYH3f0IwONHMFYJxvGnT
	kFMz2rmYk3Epd3Hb0qdSKHL/FeIQEBmTIPed7a7Inl8qhs/d88Q9VqhJRwrlAIKMJM6KDXVozXd
	QlIc/pIXGKJEfyxRLYymfvR8E8mFDvwZL8MfAerriZ6vGEM+4c8b+MLOXhn1nXNrbiN8om579sM
	doWqrJcsecg7VY1+3+anjJh6SpRCYo7EulvZ7fKkbhuOzcmAr5Cz4gr8QAxPLq6zPDfPvoB+FJY
	cAeptcDuKQyrCPq7TP6Q+j9lUxMsO9DkpjfUnq+Dry8EwCSkmScGl5fOpGaX
X-Received: by 2002:a17:902:d4c6:b0:21f:97c3:f885 with SMTP id d9443c01a7336-2218c5576a8mr1962025ad.18.1739987916226;
        Wed, 19 Feb 2025 09:58:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGNxtoH0MLvwbXesnFzPINjy1550eaOM02x9owGxmOK4Am91iwrdTAI7fKou7Aq4t/6L1v9Q==
X-Received: by 2002:a17:902:d4c6:b0:21f:97c3:f885 with SMTP id d9443c01a7336-2218c5576a8mr1961655ad.18.1739987915892;
        Wed, 19 Feb 2025 09:58:35 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d7a540aasm105617405ad.245.2025.02.19.09.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 09:58:35 -0800 (PST)
Message-ID: <7e120d90-bbe6-47f5-bf72-c1ee681c97a0@oss.qualcomm.com>
Date: Wed, 19 Feb 2025 09:58:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fbx: Add missing htt_metadata flag in
 ath12k_dp_tx()
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250124113331.93476-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250124113331.93476-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FguO8eP3o4JdFQXygVfyRDpFygf2FuoX
X-Proofpoint-GUID: FguO8eP3o4JdFQXygVfyRDpFygf2FuoX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_07,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxlogscore=982 bulkscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502190139

On 1/24/2025 3:33 AM, Nicolas Escande wrote:
> When AP-VLAN was added, we did not add HTT_TCL_META_DATA_VALID_HTT flag to
> the tx_info's meta_data_flags . Without this flag the firmware seems to
> reject all the broadcast (ap-vlan) frames. So lets add it same as ath11k
> did it in commit 5e8a373c8699 ("ath11k: Add support for dynamic vlan")

checkpatch complains:
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '5e8a373c8699', maybe rebased or not pulled?

And I don't see such a change in kernel.org

Perhaps this is an out-of-tree change that should be referenced in a different
way?

/jeff

