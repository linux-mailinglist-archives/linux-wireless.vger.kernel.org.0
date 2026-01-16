Return-Path: <linux-wireless+bounces-30893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9300FD299B7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 767F3301BB21
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5658A337B91;
	Fri, 16 Jan 2026 01:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niopzYqj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e2+rwmcH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E61331A61
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526843; cv=none; b=YUQVR+83t5tN5IR50brYcgTrQaidyghh+1EUC2O7ABtyIXpllP0FZuvEbVrXpjZvR7P7aZEN5ZGNLF+vhLKSLtgrlB764TSSTvLDDOerFd7NabJ53uEc5bmQoZksZEPLhz5Q78Ky6Miy5HfLELIHRR8NgN5WFyvIrnIjDsDxl4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526843; c=relaxed/simple;
	bh=gwI9m6Qrn0HLwWHQ0y5FzFxHw0ZyG/ACh7Tjl2JVm+Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RYyZqj0pLTsPffky3j4A9IcgBzAa0AA2j+zQVKKsbzSruQQiQN+dTWHS3cTEq//VuevHzzjst76ubrvI9yRHvA/zb3u9+6hXDQPVJb8feLzl+r8VoknkBaMZCQojyjYvIxMCYNzqHE4SF7ipb2KZl+RhTQZ6+wJAKfmU4Hycye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niopzYqj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e2+rwmcH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMcchs4100521
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	88rACB5TJZg2guiiJgrgY/2HQRCAqkBXUr1eDvH9nho=; b=niopzYqj7qyrGD18
	K4Bn20x+YUCKazivETYRG1v6MGvo9W6uppS4phla4WJFV0gS1lx3reNB31XU3JWK
	5Um5iI2OoBVJqTyD6mqk+kXatYE21agkhgyVLbd7G4auLWNUpq7CNkNjXeJOvxIg
	dKemaGVNDxBSAYJY4kYQqhIQN6Kn2QZbFhkbU+eQJiXKVUbfWJldGWBpFjYLwe5c
	Kj+JqaI8lciAowY/vUvTUj0EXDxUydKtMyKGC5EJq7qYixeJPiSjdgVmyIGdu35x
	lqeTAQxPAdmstGFSgOFuZ/p/8GdAo5G2+30UHjdey+u9vtkncmSa00gjGEeEWdWc
	OfDTOw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9750aue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b6b56e2b07so1803304eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526816; x=1769131616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88rACB5TJZg2guiiJgrgY/2HQRCAqkBXUr1eDvH9nho=;
        b=e2+rwmcHxHkIsRfLgJlFaJFDZxJA8Hgh1CzdCgBFClPQq1OJ9LAiN4+3I/ey134eeF
         HmI5kE85oaS4uGmd905xdLBL38stMU3/2FF8FphOZl4iiowbSodUZTJS4xZHvddElC5w
         Vv2X+fcpdQo7ctmB0BJdZ4GoJI5drZdMS9zyspic/tWKHWLeAk0JxvE13eobQFvjLm7h
         06GhfM7JBjTo9ZeWtkb0u568a3pfsU8Ra846QkpEiXkBiRLjgBhWMHXbpJJwmxk8YgIG
         3uN75+zwyAn+JyHyU594cuMlHIPCh13V+p0N9jGiILVIIyJmGGujufP7HRVvlb3eJyMt
         zp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526816; x=1769131616;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=88rACB5TJZg2guiiJgrgY/2HQRCAqkBXUr1eDvH9nho=;
        b=hmDazHzqxDRtyjTJi23kQB8StCDdQgygpQ+z47J4fmglf5Fm+kb3AcR6YUNPx2XubM
         kBfuKxLAU5ov518DlrcpofQAaSObrdvLWTCppztWs6kt2n4L/bVM6mvHxcdtckJbveK9
         meoHlqEriasrs/jg4qNYX0W39ERns5dkD/64Gd+CFp1BSaip6FNx8LYLrn5dyFw4t107
         b7wqpsny8wdiYSin+F0+BlW2jbqIRSiYDYLbPkbq5SZO3pEq+TSwSfeSrGe0y76KkXHn
         /u3zW86xSdQwa/01/xpIsfnYVLo1fMMZ+OC9mvDgR/fcMWLwBM7RDKd3qeDZ75yt02zl
         YngA==
X-Forwarded-Encrypted: i=1; AJvYcCX15fvHY/Y6SZv/odMCKkBwjWaxwxg4KEudSe0dCCWGk8Pj6/rUdCHN+VhV2tOIj/UKfyig2qC8THyO9/LSCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwmddwhTJLriWtHerhMqTNgx0NyEAI68bRzw35kqvAVGlvISZ
	SVDl7yhTlFem1gmP6QX4TFpjK7bYo97G74HqgwhdqnzutxX/U7SlsUJvqQxYtyr9vvcZCIhVcfV
	ZVtEESdsDgbslo1Hv0KirtrL+rMyBhG5qO5BMz9aqerPlEmgt4IQgFMz91z4YDBMZ8KiOmg==
X-Gm-Gg: AY/fxX4pET4n17lDNySiOrUCIuKSFbf0MUE+oE1EYpCcunMSbRtUw1k5JL83deVrSd8
	b9I8VGDZRkOfU1tEO9ujR6I8p3lpRMTccO5BNvjoP2dODE2fBod9HWgS9rvBkq47b5GUY9LXoK+
	GkKwDotZWVwYSu+gut/IuZU40cg1dv16SiSbzHRtyqFrq9d+e+O5YOyWCF+dm0+3GeYktlTQkod
	jwWsnp3pQ55eZWF7raQR5LKJkfHyueesVhwyBzkQ0D8k7N930Gk0CBncHOP1My/VUhQIfe/Tvfl
	4u9DxM08AwxRb96z/C9kEK1ZQEUkBi0J+XBlEpGNP23TbRCFyg9/BuVXVxoZISQNT/LZbgtRt5A
	I8uHs+xakGQ5NEDMWuerW79DISF5CCjnUK/BjpZl2qp0+Hrn28tieQX1IXaCjO1K4
X-Received: by 2002:a05:7300:3b05:b0:2a4:3593:9692 with SMTP id 5a478bee46e88-2b6b3f300b3mr1322031eec.15.1768526815876;
        Thu, 15 Jan 2026 17:26:55 -0800 (PST)
X-Received: by 2002:a05:7300:3b05:b0:2a4:3593:9692 with SMTP id 5a478bee46e88-2b6b3f300b3mr1322016eec.15.1768526815193;
        Thu, 15 Jan 2026 17:26:55 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:54 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Harsh Kumar Bijlani <quic_hbijlani@quicinc.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Ripan Deuri <quic_rdeuri@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aUOw1J0TU4VgeXj6@stanley.mountain>
References: <aUOw1J0TU4VgeXj6@stanley.mountain>
Subject: Re: [PATCH next] wifi: ath12k: clean up on error in
 ath12k_dp_setup()
Message-Id: <176852681459.1143034.3213517841557777716.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfX95IyGWatlDEu
 lc2W8FbduCW5ww2lMwVP43PD5NFb9wp86QsaPrFoE3mbCZnVzbZgMAKY3ryI2S2ikaWakvlAndJ
 vOdtQ/VSOtKh+v+njjYV/nnkxxhY40iXA96Dy+Y6tpkjOGqmqvXfwG8VVBVIgbXJI2B3UbJQQWd
 +Uy30ADoiqSdyVIzZS1U5l9pMVlqrSNstL/EtAgj0snKmZG4NkAXLaQ7oBGdWy7fIjOltAX+ZIv
 paNHSTBlHaJ+K/0KyZPQSxxSD+wG3X13GNGfvelH9MsWR18T7WbFCMeD7APG8slshGTCIumFujs
 oRS9GXXWXApQJrh3LUATs7e5Z6MeONsEbRk94Klw+1c2gEjZY0nIdTjeHOKSvCUOo4GB0hAahJy
 gTWfyZhPELFyhCWdxcF8BKbLURMEyyub/qanQiyGv+rJLcRbJPUeI8MD+Q3UbffvSSyghWal/n1
 U+G2RNCXB0plPnf5kbg==
X-Authority-Analysis: v=2.4 cv=Sv6dKfO0 c=1 sm=1 tr=0 ts=696993e0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6YG70U5JATtl4AP3FOAA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: rF29nWnzgDgpxrC46FJfntBQh9E-QAXO
X-Proofpoint-ORIG-GUID: rF29nWnzgDgpxrC46FJfntBQh9E-QAXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Thu, 18 Dec 2025 10:44:20 +0300, Dan Carpenter wrote:
> Destroy the rhash_tbl before returning the error code.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: clean up on error in ath12k_dp_setup()
      commit: 40feb23c726369700918b9c35db987f9fe3c6498

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


