Return-Path: <linux-wireless+bounces-28357-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DB4C1B641
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F381446655A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 14:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB5D1C2BD;
	Wed, 29 Oct 2025 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EG7uUYc+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eTW0Kw/x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F027B353
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 14:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761747965; cv=none; b=Yv9HVuHs4ZmEOEvaeV5rf+atcPU3LAIjPS4XMfLJeSBcZcsIisId+7IPg9dm4+IN6UWxitLrnR30/p52ETTeEQKnjSWErbJXnfL+nsdxmVZctuwha9K77ROzVMrJtU8tZL0f/dmG+zVxXSyTW4lPFQHlDfDD/hkCmnX28YU2KGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761747965; c=relaxed/simple;
	bh=HKUSPmcUj2Xtfi53LB6PGs3J2vl36BecbCI5CMafn/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNFJN8tmNxdRQFfzgUiH/DyL+BIu8Uwl1EgUiWCz8x5qNVCZ7OejgE/ARmwa0vfuptGgNhiDP+TTgkpicXONQ3zIjWuzzq6Gq374eCr3gazGWFnd4G2AvmlE+OHqs8g6aYUepPBn8FXZXR4la0cA6+1JOhjcYhuGxjyOXt0MMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EG7uUYc+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eTW0Kw/x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59TDd94a569233
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 14:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8lRCEMmy9OZlhkQ8RmEl5rJEU/q4AS+Z5wN60SHfen4=; b=EG7uUYc+8OTWFxlc
	AbPYX791VJcYlKkwwm6u57Y8YcEtntoUAkKf5o8AWtM8pWtaN9Gz6ZhvfwXR5w+a
	uNcIPAOnpJ+Oq2LbYIA5nx4We0DvIUn7o2nwb94GoCqRRIg3/8+KsX/7Hmi74En3
	r2ceN9B76Udfu2u9UIfBfgyfGSOAZqyXRRVKVw+u68F4gYI5Sdgf7RmlyypmJDiN
	8PFVjeW28runf14z5AbVeTNlHZ17rprZBEZ9g1R3dMguM3U7+pfAUvpQU9i8Srq7
	GIesfSJ3dom1nhU9YoW5od6nXgnkH5yUWSrdF/aurrd3z2ERh+skYcFJQPjdG2dO
	Bs5P0Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3m0bg4qv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 14:26:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6097ca315bso14952147a12.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Oct 2025 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761747961; x=1762352761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lRCEMmy9OZlhkQ8RmEl5rJEU/q4AS+Z5wN60SHfen4=;
        b=eTW0Kw/x8o0zP1+zeopzLQetVJ1d73m/WMgrM6ap/iZMrJoyE/jbVN9e9mMM+CKIEr
         Esey7D5gfAj4Y0TkgGU6cInPeSKYv5xMO3vzaBHlHL36ld2qxtji+DIyib73m9u+za2C
         fXy/VRM0NkOXf2btvqj/TM0/N4bd2NGEuPNVKyg8efZTu5XWaSD2tJbcKDBXXZoMnGa+
         ugOTWMe7DDk3bLZyR6hVrn/lIno/oMy+BOqoBqf8EUCU88VC7UzzLi+WAsMwhwFNlL8K
         olMGcJzAlYlsBxEFX30fFoOkybge1r3f+mX0Fcp1Hd/nWoIfju8vcjj9OO2O00TPFUUn
         xiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761747961; x=1762352761;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lRCEMmy9OZlhkQ8RmEl5rJEU/q4AS+Z5wN60SHfen4=;
        b=v41RD5ubK1bkTKfgyser72cjUtM7Hdxd5jyINY66xKujT9TuG+iR/OZ3VyxBFcbjrP
         WW+Q/DumClHZI3iS04+gS8g/mipBG60+wvEY+RtFYVRQh4rLZBnneAlN53m25XvQ+xBP
         C2+A5+Js87Q0PzEE9m4xiMYRSweWHbzM94PYtBSqn8I7ZksPjbjtLNvliP6atRFycqBG
         OxWZevfROs0htsRLINi/apczkTi+Tec4WOQGU3hrzAAiiV6GRPWKMrsiwR0pDHKMIdqf
         VzQm9XapBcUvYeWMpu83ddQZXblG8PQwpGSsSqhXg0MOZRXyxGDnTXs+kuPzZWs42/Uv
         Q8EA==
X-Forwarded-Encrypted: i=1; AJvYcCUGZvxs2gkXlqMuy6xu1VRKHKMkkyQKDJ8UW8xEJ0AxR4aEmccgGfPYjvDbtsn3aBDUA4UvXWQXplPCPZZLxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzepwH2buu4H+Fm7tFEwdd3wLdVmAqZaEY0jvpiBEwNiMCGNRYe
	la56QtRwmyqOwBiuU0yaSABVWIdjpEvJ/Eu7aiAMguLqibT8pBZFIvqlrXjAphJtclSZmIhWQ5X
	VAXMUyRyWSDEcXEkMbpUI8D8iFrykNRGO3mRiy8Hvk3xBjuE39a673+Ep1ul2/5AL5ZVNHg==
X-Gm-Gg: ASbGncv21Auw9UkvDauAxTkWYSY8vsY0KnSfu8ezb+syZ0jDyjKX++lsZ+N6HKAKy/0
	fuMBqhFAGhc18Ym0lN9k3eG/JxorRdwWPwjJLAZj/bMW4ZwvaGsCrRcq5wzLPdi2TrqIkR3SAX4
	n72BdKake/UFqt9Lh5U7EfflzzyEnnJofvsZ9U/HWxJXMHAuvPy28n3qhPbirSzgMpEtt1REkkU
	znLFLnXlX3yGhdRmLlqdCKXblakU9IGau+4LcwSDDBUf/Sssj8UZllpUMMnRR8Pa+9qE9w0qll0
	usos89yk2/yqHZ6XP7fPgiBjjUKKMt3/JmCxT9kIBMZwS+zPnklZZ+uTZJosDp61Gc+ytAAMaDj
	NgKpRENH8l7iXW8wuaJ3NaSmRjY7CzT0hBduARxwG8V9BkkU3J5PbEw+lFQ4=
X-Received: by 2002:a17:902:d491:b0:269:4741:6d33 with SMTP id d9443c01a7336-294dee4b276mr35510335ad.23.1761747961357;
        Wed, 29 Oct 2025 07:26:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVs9ARm8Q5wCdoLG9mCSaU6IsMR0Zt2w484KzdbhKLh1iw8y3iST3S4vvTj/Qii13tEl5pOg==
X-Received: by 2002:a17:902:d491:b0:269:4741:6d33 with SMTP id d9443c01a7336-294dee4b276mr35509925ad.23.1761747960807;
        Wed, 29 Oct 2025 07:26:00 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0996esm152263505ad.28.2025.10.29.07.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:26:00 -0700 (PDT)
Message-ID: <c7b1a108-6831-4e48-becf-45bac0e73d54@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 07:25:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] Revert "wifi: ath12k: Fix missing station
 power save configuration"
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ross Brown <true.robot.ross@gmail.com>
References: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251028060744.897198-1-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: V4Hmvk17geOCHQ7gPDJWz1cPo75yb4mD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDExMCBTYWx0ZWRfX0pxq5vwJKQbB
 KGZp1CPwjQSqJZkyrmURcWNWzKcJ/3BuT2yuK9GUVUjHfGOLFEkpqlnNSshkzymCqZMjty3aYLN
 TOfdZ/mqYuRU0pOBPFwrnn+6oExpUrmolxWJkCJ69oX4+ExoCt1K8lUzQbKm51KiTxNW1Jb48gX
 wbb1b+uqI7+b9c4+giP6ysgz5BLoUUyz/pW+0OuIZgPfaD0zgL4fNyiUcmRPrVPgAkpnbrbd3n3
 rUfWpWIfIFZFEnpMd3Q/obass+aunuCHa8TOrh9fKMusfZk/EAs7YrjTg3+qSBWC8cTl30aZ1ck
 mSnro0BbclKrvBrcoBAFiv3Ex8j+ZRGO4zETqC21cyglA3gwnVfKu7R8ZFSwERTJxw5e3tioeVb
 rYXWrdlKNpt8NJMNsEsYWv0KqUAcYw==
X-Proofpoint-GUID: V4Hmvk17geOCHQ7gPDJWz1cPo75yb4mD
X-Authority-Analysis: v=2.4 cv=YLySCBGx c=1 sm=1 tr=0 ts=690223fa cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=WZLPHaEoEJzMMJhDTEQA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290110

On 10/27/2025 11:07 PM, Miaoqing Pan wrote:
> This reverts commit 4b66d18918f8e4d85e51974a9e3ce9abad5c7c3d.
> 
> In [1], Ross Brown reports poor performance of WCN7850 after enabling
> power save. Temporarily revert the fix; it will be re-enabled once
> the issue is resolved.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Fixes: 4b66d18918f8 ("wifi: ath12k: Fix missing station power save configuration")
> Reported-by: Ross Brown <true.robot.ross@gmail.com>
> Closes: https://lore.kernel.org/all/CAMn66qZENLhDOcVJuwUZ3ir89PVtVnQRq9DkV5xjJn1p6BKB9w@mail.gmail.com/ # [1]
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Note to maintainers:

This patch to ath/ath-current has a trivial conflict with code coming
in ath/ath-next.  The resolution is to take both hunks, ordering them
in reverse xmas tree style.


