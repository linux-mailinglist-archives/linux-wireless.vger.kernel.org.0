Return-Path: <linux-wireless+bounces-26453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73674B2BC50
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 10:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51B8716B195
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDB52773F6;
	Tue, 19 Aug 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GrZdQhkF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CDF42056
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593960; cv=none; b=QSErciwQa/lPYLC0sP+7NcY7qtApYlwX5Bbz9J1dp/RD/AQBr4EDlUdj78uiBIpvNsF7Wl9Q7uER6KDxQ+5jKLDPD6O8vOH4v+kngwjgL6iI61rq5RgukGAtZQiQ0zu42am6at5hBfyyKdxoctUgJt2rx6F1v2lO3bqtVMfmSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593960; c=relaxed/simple;
	bh=QtXWbngOPGt6DuVhyjlgeokh/NaNiJ8+cTcMhEttiH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A90qU4s+TAeJA8MrmQWqP331YPBamK38Nn7yKsDZGsLw2sUazDlfL/MPOjo8IIgYuID2ksw/YIyn/e1/BM1gnFArekgyf3/STZx8cGJVNuJeR12P9k1uHkZydyPH650SiVl7ywgIwSMCjDRpcLdiF0R4p0QVpK+7QH48dvDC5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GrZdQhkF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J8pHEJ018888
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 08:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QtXWbngOPGt6DuVhyjlgeokh/NaNiJ8+cTcMhEttiH8=; b=GrZdQhkFdRPRAKMk
	UC7rUFlAeFl0FZESpJAI3cfKhZmxu8p3X/3kVikNRqQyWLAJKI0jfB3Ovr9FyWr9
	wD5ay6W6iTZFOymIMgZRAWUBbBNu72sd1fWNjaEVDYfTTNCGfusnjvcYpnO4pztY
	7UVfGHxkC4SziF8UrhDsXHV0Up+fU62LAPZTradzAu2Di7WhaDHhKC3lUM8LFuew
	hkOQN6YOfc1LKU7/Pb/J8aKY+qUCUM1G8G+HNLMIxyHZc6lXBSlY0hYKrYgANaRp
	V5WipSheyxSU/5ndvscd7gFDl81fGXXb57jbHfYFJkMOmey84dL5Feb1ubd/6tFY
	GTtpiA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48m71cjkyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 08:59:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e8fc814so4656355b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 01:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593957; x=1756198757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtXWbngOPGt6DuVhyjlgeokh/NaNiJ8+cTcMhEttiH8=;
        b=gtyBah3dogZ2lcrjQOMcHG2m85a4I9qj9AdRxZ1A1Ebh9/+hKjmK+fErmDBN3Q+Uca
         Z15EbF3gnaW/Rwie+q0bPIXxtMWYeKIqMOL0hIunIMhw7x7/sAQ2E1mEBRBg8Ci6vslI
         pFC5IrLBBfyNU4V+CxBMi9boTYU5q1SCTYusbdTMSEyDtD5mwaT0xnTI5YnAzClSDPOl
         Zy/9yTBB05ExVWFxGAEDu+zly8Dri7tHE00g8xkCVukLHZEPHW+OWeJ/HEDlyRHQS8U+
         7IiQuDl7VwLxzhlsvyGlXdchv2C8jXaO3V7fjuKrlzIi1dEU0i+TfroNcVYaSdJyNO9D
         aSCQ==
X-Gm-Message-State: AOJu0YyrcVriDXYpAqrsZi6SpJRDTgbLwjg8eAErMK0R6NQQJd6pqJDG
	qyEMAq2um1KaS3nicMeTOPPLcZOPBUfwBlzGJWAoig9Aue5nFHW5t+iGY/EaMgCoh3Tu1YOrgfG
	8kWMYQruTEtmwk/Ot1F1j3P26/EV/iFS6aumKeZ1Ubt0ppOg6E7KrHqiojQ9ZwtvHOAAnxA==
X-Gm-Gg: ASbGncvO6fcGB+jKbgZNrd+Nd+EEg8O62+JQsvcuxCQbR/HtKT5shkgClBQYjvO1g0H
	pTUsbQFzcHzy8SZo0ZmJag82+hkTjKv6eVWeUrifMf4jZrwEvsIDWRYeEuFbf7xC7oy0CBZ32IR
	JqFz06y1onJukAuhNyw8v9HLxDW5vbWqDz3ajHiSJiUBwl0jVdyZmoc1pu6rOc9VYkLejW/c7Dc
	hcUwFMhkrYq1gNhhXa5glBQnmf4asulIMINIEzA98LQDXZBZoByEatv7P/rVryJlmQwixonx0S8
	89U4yavWvjs4LkEnVMqsOKSpX4moWR4cm57rpTgp82jZ9pLCZo2D4k+vlDcA+MDv/LRPQd/ZuAg
	4678VKGQAC2z78M4vwWP0cJMhoQwgF6DE/UZ3
X-Received: by 2002:a05:6a00:178c:b0:76b:dee5:9af4 with SMTP id d2e1a72fcca58-76e81140267mr2183298b3a.13.1755593956997;
        Tue, 19 Aug 2025 01:59:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO7sRbH7cezJOI47T+oxcZtTuI3MjOHvoF0FadK7AtZgpwLcezuh5FE3fQ50kc9WYgXTNmzA==
X-Received: by 2002:a05:6a00:178c:b0:76b:dee5:9af4 with SMTP id d2e1a72fcca58-76e81140267mr2183248b3a.13.1755593956523;
        Tue, 19 Aug 2025 01:59:16 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3a82sm1943347b3a.6.2025.08.19.01.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:59:16 -0700 (PDT)
Message-ID: <096a0450-0d77-4c46-a7d9-4bc002724d77@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 16:59:11 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: pci: avoid unsafe register access during shutdown
To: Balsam Chihi <balsam.chihi@moment.tech>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        jjohnson@kernel.org,
        "Vasanthakumar Thiagarajan (QUIC)" <quic_vthiagar@quicinc.com>
References: <20250611164004.38580-1-balsam.chihi@moment.tech>
 <91fa8b1d-7bd0-4beb-80ef-eb65d2562f17@oss.qualcomm.com>
 <CAONkfw5Xyk8CGmVDpWZfkWnuCcFq6400jUkqyeMDtS0UNSh9vg@mail.gmail.com>
 <ecab2156-b234-4fba-a2ad-13a2d9b4693f@oss.qualcomm.com>
 <CAONkfw4hkDQtJyOj4RVsR3V=FJDJYKnjtmqzD=jBMy1ax=tC_A@mail.gmail.com>
 <0dfe48fc-085f-4dce-933d-e0f132d2ff9c@oss.qualcomm.com>
 <CAONkfw4p1AuE-MhGiZNMmi-PXR+CjoY63K2Yx_dmv2vnjo-Eyg@mail.gmail.com>
 <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <CAONkfw58jcGRxotm2zJasQd56oDR-h0b3Z0Yi+pE8hdrmN=Ucg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: j3r7ln3Yr9SiSSt6A4uif-vzOITIz9mQ
X-Proofpoint-GUID: j3r7ln3Yr9SiSSt6A4uif-vzOITIz9mQ
X-Authority-Analysis: v=2.4 cv=IvQecK/g c=1 sm=1 tr=0 ts=68a43ce5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=16gmyrRBeBkEDI0Ud1IA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDE0NyBTYWx0ZWRfX0YKSGqgyrTph
 RMrBoY2GxNWqRoClus+rfQh6HJSMbCh7DNHN2uGo7JFFynzRRyhrCkRSyzJfh/t1Tzy9fBY9jj2
 1AMqNlNvSOUx1DZYUM0Nhhu/KRtzVUGkavA1Sn3ANeYXQSHOsPU4Ph6vV4UCG7mwLW+2qfXSL92
 AJ/L/QU8ZGGhWHGRMy0aR/w/BYFFb4lbEt5AfAJPIL427JRHjImTfpZL+VzQixYwQssoEk/2pSK
 YvQa84mT2H7dnWHjDvjpN7Q58LjANC6D1vqByaNIrew02pB8fekWyqTcb1CmauSLKsuuDyYPyS3
 lAeRKRlRUxGnJTqOekEW8Jln16GesZ5nzsgbPEFhPvUY8axg2n63SlYycEJ1jxaD+G7/PQT+GLg
 1H/2wnzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508180147



On 8/19/2025 4:50 PM, Balsam Chihi wrote:
> Hello,
> I Have a question on the same subject but not related to the bug.
> I have many identical PCIe WiFi cards on the system and I need to load
> a different board-2.bin on each one (1 adapter per frequency band).
> Is there any kernel built-in solution for that?
> I could not find any, so I had to create a patch that loads a
> different board-2.bin for each card based on the pci device address.
> I patched ath11k's core.c file so that it reads a string from a text
> file in the rootfs (board-2.bin path per wifi card).
> If the text file is not found, the driver loads the default file
> provided by linux-firmware for all cards, the original behaviour.
> Please let me know if there is a better solution for that.
> Best regards.
> Balsam

Vasanth, can you comment?


