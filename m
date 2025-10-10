Return-Path: <linux-wireless+bounces-27928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A1BCD683
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 16:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4349E19A1D9B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1C22F1FC7;
	Fri, 10 Oct 2025 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DzhfYxZ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A736124
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105432; cv=none; b=Aujf+fk89TZ9XDPXlAvf6OLSApHBga+8nPBOFrso5PZ849DQxKOITRcytyOpBEbM9uaP9b0rrhrhF0Gbz/B6vjXKOQzl9I5Ea4fo2yx5oq2kv8bZB4ItMJ445XO6iEJidQi6gOqPQxkGxkBixg8BDg0ayvlbs0sxb45Tpi2Kw8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105432; c=relaxed/simple;
	bh=kvpkshzZqe3f7F1KcFccw0CVeBJxsAuzo+ffRNE1L0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B+6AnfzMNf27XJKfG3eSK73b+mda5eXAeoXBp5e1VrDLz2b3BV1qcrdPVlA5qufskktTsGhPvksAF65z/9YIzYEw3iebKiTO6b+P6uEAEukxA32Ynzl8b1l0Lz4ks9BrVGFLXC8Y1WWcRxgIDeYQT/4sH8oe3ZTAx1HDAqYAmZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DzhfYxZ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59A6Wknf009956
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 14:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NRlbDJEHTq1pqn85S2o8iC1FTXfxAiiOIzfqlh9613o=; b=DzhfYxZ2WfALpOu8
	5KWOrwfNyH4CdmEGbzy+d+dod4o1wpTigDp/q0komG0+WtPbn/SS/AS4DZfFYgkS
	UDLNEUi+mksFkPnhNKWCUPKUl4P04DiReFCbcSflvopGCruDyQX0CRcw8FVEHQzo
	Q/EiIWEHOSQEQexnYpOMvuiFI9EEz7jJMIciwuujK+hWpD2h6kFkoCErcR2Z2yGi
	7n+W1K6W8r/xhUU2hBeIBRc5TVGZaaV5jGbbt13RaQ6w4WcgXnbWFQIkRHjM/T2E
	VzsB28SCNTvCZj+G1AhZ9yele/UG0X0OivJvVCH4VtwAObJiHf6O/Mekugu/emWr
	DdJxnw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4nxn4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 14:10:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78117b8e49fso6022905b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 07:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105418; x=1760710218;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRlbDJEHTq1pqn85S2o8iC1FTXfxAiiOIzfqlh9613o=;
        b=uapO9skR00e18Hes81jU3DbJ3AEflaZ5bE2OM1NaToR0ck6jZbgTc9cepIppIZSMOC
         wYX4VjXR3onXQ+EL64dJCXhaymsdhFMNPCIGz6kJy8EuZDxtoZUF5th3bisxLe2wV6A7
         t6saLPLzjnlV1NBqwsRL1MS0j2+BJAffu7mr6B7L5f3xq05GHkcOYOr7t5ubvrwKTtO2
         pgrImKVhtbmdcqI2M+A2EbgxrkZ9fx1BweuoHP9/WgUKMRtRllu8jxsEdRveA5v/XTMh
         y96J7gqUyrVbg8BbeAxh3XkKjIAV9KXiDjtay7YqSIntjZuM4UB/9kF13guJ2mwYslM8
         /gcg==
X-Gm-Message-State: AOJu0YywSeRs2cTeqXTE8u5vx+SsGcGmxPSND072rVVUmIDi+MulPz97
	YIAlW9AXGJNErLPFH/HQZj7Bw5TIXcNnqy6r51is/GJfkgMJ4eYdUB01xNjtr2BoHaUScGE7wlV
	oInVyCZpyJ1ZZb506lxorPICDjBis7qs1XT6pGi/qkE4986izw3xw47J7lmZNYhXy6lpNVj8BBl
	j4BQ==
X-Gm-Gg: ASbGncumzf+VrUfI9TZUl9OOM46dYyUOkkUwQwqI40AxBaONqkvr58AtCBRvO5e5F+Q
	7Mi2mAQbzPFzyx5dO6cPuEGYO3lEG99osKBhh3GmhkgJlNb7fcEb2qXzEeNGDDLzQkWW2vIricV
	3MG9Dlt0BOh+C8UVK7zQ56oMqo8WzrKIS+gYjlaUBCMDpFw428Xe6gR4ZLr+SR3yMmngnF3KCH4
	sm039Uc28YzA2TwR6ZMvmd4JfkriQNgTSIWqkDDbyyjRxq5IEnuMvSOfrmqiYSBoNJYiXUXaz90
	RR6ci+Ud6yZOWUzm3IlrGw8GI7oEKQJ2hvq50Np4rP20BHrR5+Op3+k0A4P6OwlUVF9m3L1KBMH
	u
X-Received: by 2002:a05:6a20:12d6:b0:2b8:5f2d:9349 with SMTP id adf61e73a8af0-32da8453c08mr14981551637.41.1760105418108;
        Fri, 10 Oct 2025 07:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEL83cQq5vBFhOPGj7OfdX57vOzROPiTr4/rVfcVPJdRAJMb6orZxnkAHQO5uYwhamP6xp4Q==
X-Received: by 2002:a05:6a20:12d6:b0:2b8:5f2d:9349 with SMTP id adf61e73a8af0-32da8453c08mr14981506637.41.1760105417615;
        Fri, 10 Oct 2025 07:10:17 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df8ea31sm2447948a12.42.2025.10.10.07.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 07:10:17 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <quic_rdeuri@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
Subject: Re: [PATCH ath12k-ng 00/18] wifi: ath12k: HAL changes for Next
 Generation Driver
Message-Id: <176010541694.1798640.7649833428489810940.b4-ty@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 07:10:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 3M-76CxbQ8QsO_-ZvRu3MGpSpj49evkg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX6FAoRAyhf1Vw
 srS1vIWFf7I3Uz9Hl+2Hnt3JkoRyrSQk+OSHFmCAKe5JFDAlYn/hNxwk2rbgqalGBKT+zVZ1e0n
 mW96FsH3X3Z0cIBaS/RVgEw4MqrXXYTqWISf5+ouaRvHVdV5Kn2NOvAHV8cHxWw9u1rlgZ9hmRe
 NZOni2q7T6tQGxnMiSpoyDw2z3Bpk6fRUIfcRaevdbKz9+g8qGbf50GGPiIK4qNG94C468dVmc6
 0nxX//Y7fdx+mi5DFnHLViFmHvJ1yyWhYntXoLmDX9looaZbk6ISnS8ehhRAsG6BwhDEPb6d3JB
 stnIVm+lkOorCoXF0xZUy1kg3rXjWk/wtVvt11a9Z+6fsSuc0CYO3hbL2vjUa5coaoFqfiKImn7
 qbdAPBDYDoo0KvsCwcC2o1zi5vUGEg==
X-Proofpoint-GUID: 3M-76CxbQ8QsO_-ZvRu3MGpSpj49evkg
X-Authority-Analysis: v=2.4 cv=b6a/I9Gx c=1 sm=1 tr=0 ts=68e913d4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=nUlrOwfnRBZjULIfKVIA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121


On Thu, 09 Oct 2025 16:40:27 +0530, Ripan Deuri wrote:
> The primary objective of this set is to modify the HAL layer
> to suit the multi-KO model. The HAL APIs will be implemented
> differently as required by different chipsets and these
> implementations will be abstracted using an ops mechanism
> (by registering function pointer callbacks). The hw specific
> implementations will be registered as callbacks in the hal_ops.
> 
> [...]

Applied, thanks!

[01/18] wifi: ath12k: Move srng config and hal_ops to hw specific hal files
        commit: c0600b35e08db781511c2b35af2d2ec58bbfbdfd
[02/18] wifi: ath12k: Initialize desc_size through hal_init
        commit: 74ed243dad18366aeb836f40b921758e20d9d5b7
[03/18] wifi: ath12k: Initialize hal_ops through hal_init
        commit: 369cb192c2ecf1228df06adcf1aa5074aecd2902
[04/18] wifi: ath12k: Move wbm_rbm_map to hw specific hal files
        commit: 1c1d4b491d2085f6bdea90b0e021abf8e30f0457
[05/18] wifi: ath12k: Move hal_params and regs to hal from hw
        commit: 492dea1892dacf1c1ee356c60465e7fcdc18cc97
[06/18] wifi: ath12k: Add direct HAL pointer in ath12k_dp
        commit: a337bff1db715e67135a2e5fcb6ecafdcf81f8b7
[07/18] wifi: ath12k: Use hal handle instead of ab handle
        commit: b38213660ab9ebf9d32db40ec0ec6691b6dd9d1a
[08/18] wifi: ath12k: Move HAL CE setup and SRNG related APIs to wifi7 directory
        commit: e9f00e22963e809a35999465036d3f58b126c1c6
[09/18] wifi: ath12k: Move HAL SRNG shadow config and get ring id APIs to wifi7 directory
        commit: cb419f582f36873d31368835be34ec1500792dcb
[10/18] wifi: ath12k: Move HAL CE desc related APIs to wifi7 directory
        commit: 3d947cef0a51e19a779b201fd27885b31af19383
[11/18] wifi: ath12k: Move HAL CE status and set link desc addr APIs to wifi7 directory
        commit: eba935ec922fd77a88ea2bed12d929afe340ee19
[12/18] wifi: ath12k: Move HAL Tx, REO and link idle setup related APIs to wifi7 directory
        commit: 356942d328a4d85969953353b4b9c1f0934918c5
[13/18] wifi: ath12k: Move HAL REO and Rx buf related APIs to wifi7 directory
        commit: 17540a7c9b363e08eb417ffcd25c74226cbb131c
[14/18] wifi: ath12k: Move HAL Cookie Conversion and RBM related APIs to wifi7 directory
        commit: ea23813a2e442f96a05d3d2ddf3d42c6005b1862
[15/18] wifi: ath12k: Segregate the common and wifi7 specific structures
        commit: 2bb41934527d3b132958e214d688cc525d0088c1
[16/18] wifi: ath12k: Remove the unused ring inits in wcn
        commit: 6250af6073092f25bd2c104156e0808c03adb5b9
[17/18] wifi: ath12k: Rename hal_ops to ops
        commit: 49ba5debad420506eef9fcef38d1fdce41010901
[18/18] wifi: ath12k: Drop hal_ prefix from hardware register names
        commit: 25122460e7f96864a80b59ffe6c953911516d3b3

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


