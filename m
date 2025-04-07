Return-Path: <linux-wireless+bounces-21203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 071BFA7E474
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 17:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 095EA189D568
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6D71F8EF5;
	Mon,  7 Apr 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PL46n7yc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0E1BEF74
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039448; cv=none; b=mx70rjqfTLmbsaGKZXs+MF4FPqlb6CAnRVEYXWuVWn2385FvjFYGYGVoWVteQwLDygYpD2kjoP0alzbfLUmGGm5W1Gce6DAaUcIB/mjcpEgxFVPR8bbZnM/G/W5TvQYs07wgHBZRRMrtZ+bqv16yjM8Ycw4XTyciejrcOoGHJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039448; c=relaxed/simple;
	bh=PNRzP356568cbQPwxlAj6jvu+ZhJuKsYQWx+f5qx8Mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q9uGSwC36NOIvkb90RmHHr/IfJBC4UfN9l1pEBeNuH6BUpohkrwUkLIvSvYn7+O3ezNj42t2qP8R4WABTmrukgX25op30eqqkC0O3QSSxTGX4+IGdOMe3ErPb17PfUowpmOIR8/dxgogabkHflPz9Hs16ppK+my0bsIeSQ9rk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PL46n7yc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5378eHh4011554
	for <linux-wireless@vger.kernel.org>; Mon, 7 Apr 2025 15:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d8oSYYU5syqS6jNmAv8fjLJdAjH27s7W9i7bV2ZZhRM=; b=PL46n7yc21RHhGpl
	U5ZRI6dW1G+MCzL0bZYsQeI9Y5ttN4t+rfRpctdZW6XwaiLO598/Cb6H2PGjkfkf
	PeVmEUvmd2O/JjG2JBbHyi0NxzYyl6uSlJLIoMfboi/rmtruUISUlL8KMGg3zZOf
	3HFnk+muJ8ROzt7UXDhxp7Y1tHyqHrUtWpCbjy0ziMGFzI3v6PaP0q64AqKiyobo
	ZhRbqL0tujJLPv64xecq3GoUS4Ii1WfoRpIJxfkCGb76rugo+0bzRUaoq2cknrYc
	TZrC61Bpg5aiNhcbXvd4sBkRhIhwExUrJNXf+JiCcSi6OTW9j16whphBQ9X/va6G
	ErCA5g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd2mpk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 15:23:58 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-736c89461d1so6903913b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 08:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744039437; x=1744644237;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8oSYYU5syqS6jNmAv8fjLJdAjH27s7W9i7bV2ZZhRM=;
        b=xHXbN2ypb8lFDjAf5nUBy5g6NzuMmSZYP+OsoT/pY4Fw+ysJve/Zv7lcKwT2t2sFkc
         /CgJg9jvg4lunomHcw0rS2dCd5ulPXDhh97ervfyPtE1Aj0A+F7CR8aPOedLYyFBqqsW
         pJVoMeEEiSAVhSTyiq+cvwBL4LWIGw7jQoHCA9nwbqdtlrYdVWkMNpmSUieAABcydhMY
         VM9KhIPrmlBRs6Gum1kCpWCU1SCX7cfFNYq2YPOIYn4RGjHWMR/3vifvvL67kgIC4RiH
         Ng9UQwR5NsXUkjxPELUmDwfbhgpxpE8C+h6MQiLP0RVS5iD1A1JSwVN23HSAawwIC7B+
         YaYg==
X-Gm-Message-State: AOJu0YziN/UCoivl6PdjtL6iMbtcET3UAA00Ms+cqkKoxHKX+Jx/ww3X
	ZVkVSFI+Cs2DxqWT6zKfcGH1USGv+hnbazhXKaMQo9jmdEt0/rlpaJeM5Uqf1tT/d9Er2e3Au8s
	H/4iDv5M27yfUPIrSuSBRlyvdXQaJreWsTAHczQ5k0YXt1Kukmbiqs8puoayl5I8GcSS+JhjHig
	==
X-Gm-Gg: ASbGncvS6pE7TpVw1h31Eghw0mHVYXS7ak1yaxUpEYpfuYnOkXAUv5dF9nGNy8MMGiO
	lS/3yy8wgf6BUP8C47i599ZgPYFbMM3Hj1S95MG4JH7jqJlYgXCqgThRVRxLmdxgFNnL8m854Ch
	vqan9oC0Cc06duv9SwRUZrMCWNeiQmc93vWvfddKQkzn/FtGNXC6xluMqCzXVYEdFu3IpieOvLh
	rCQqPqkbynEybYyo6iMjM0m9TK4/ysTJ1fmAJ4KUXKet8pyTFJjw55ltJWAQjj/l/3JjN8xIOKM
	XfZ+zWemhyowuBYLIlze4nio+8K6/o3Kx44LD7XTA0qxdVjHIk0d
X-Received: by 2002:a05:6a00:2e08:b0:736:692e:129 with SMTP id d2e1a72fcca58-739e716650fmr19905061b3a.24.1744039437446;
        Mon, 07 Apr 2025 08:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1gN18j3H8gIFckK7HLeiPhwiHTMvYoXUGn4A1sg3Yx14JG/17APO/VjuchOW4r/T4RThfIQ==
X-Received: by 2002:a05:6a00:2e08:b0:736:692e:129 with SMTP id d2e1a72fcca58-739e716650fmr19904984b3a.24.1744039436643;
        Mon, 07 Apr 2025 08:23:56 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e7d3fsm8691592b3a.180.2025.04.07.08.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:23:56 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, P Praneesh <praneesh.p@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250402180543.2670947-1-praneesh.p@oss.qualcomm.com>
References: <20250402180543.2670947-1-praneesh.p@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix invalid memory access while
 forming 802.11 header
Message-Id: <174403943610.2068408.12657138094703090770.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Apr 2025 08:23:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: ZM008tAULneKsQ45JqwqsEnuWAfA6F6H
X-Proofpoint-GUID: ZM008tAULneKsQ45JqwqsEnuWAfA6F6H
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f3ee0e cx=c_pps a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=-nT5jZN5E8sRPm4SzxEA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=609 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070107


On Wed, 02 Apr 2025 23:35:43 +0530, P Praneesh wrote:
> While forming the 802.11 header from the rx descriptor, skb_push() is
> performed for the 802.11 header length and then calls
> ath12k_dp_rx_desc_get_dot11_hdr(). Since skb_push() moves the skb->data
> pointer backwards by the 802.11 header length, the rx descriptor points to
> a different memory area than intended, causing invalid information to be
> fetched from the rx descriptor.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix invalid memory access while forming 802.11 header
      commit: be908d2360341f8bbc982fff5a5e4f8030c17f74

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


