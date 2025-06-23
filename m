Return-Path: <linux-wireless+bounces-24355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AEDAE476B
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 16:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE652440744
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jun 2025 14:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CDC26E140;
	Mon, 23 Jun 2025 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GGD1nJYz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429426D4ED
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750690127; cv=none; b=AWGeNwKF78a9I2dfNHkdAUEwCPjmr0zlD2GzYIxyTCvngVPnA0EMSeks+bCb4VlmY0BJRsNClb//PlOJIuNeT+FKf2hxOSa2r5R5DrWOg3Q98EgwEY3HyRPGpKMGKTcLcMgElnjwENcF3XyhpSiNDxwrp9cYuDXXoNFxbsZcWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750690127; c=relaxed/simple;
	bh=ViVwGTcizn1t9U2wWyA6rYKY0oNirYy6v/b9oZzRkBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bV4fcu04G2XM/nR2gN9krJE1CcRWBzSOtC/I4KXJVxyr7iNOlV39Y3cuEodctGGIgNxN34M9rLssk8i0fi1mkfRHzGog6sdOZNcDtq3+B58KX8A9PecZ5AWzR29Qu4NffEdAKw6S9vI8Zo6bQCiOopj75qdvkjJQfOenxycQuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GGD1nJYz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8LhEq006106
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RcESoQNexIsT/AjTnUYA4YX/8ust1TQriqVvjq0z8zU=; b=GGD1nJYzClKBCRb5
	OdPIkDFPgURfebrWvHCtgFNKQsBQsTq5sCBHPViqjzOCSDPjjKJ/op0UF0anQNdo
	pw8RXz8M5AJ6wDHfQM3mfq5dLCqXGT2PHxRuzMWO0BLZJasR6c3CtdU6TAGSnEDe
	uZDPWfPG7yJOzZWDgYDGnzeYPbdXPgKU66wJqWht+COdV4OtEVJYWOo771KyaGxB
	CLs331x1WHo4mLDn0FFv668btf8czT2TZeLvgEhIVVhjc/YvAp1XPAKrrcIFyjRP
	8klpLgjgIdJChXBBd1tRF5pNwvbJVwRfl3tOdhr3pB/zGsxZaXyL8tEyxOjP7Ya9
	vDro+Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bg92x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 14:48:45 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7377139d8b1so3296808b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jun 2025 07:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750690124; x=1751294924;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcESoQNexIsT/AjTnUYA4YX/8ust1TQriqVvjq0z8zU=;
        b=WIYV2eFkGvCcxK4sXxgSIEa/Z+TVDFT5qejgI5kXSkdrRmGRoM70PcDDNdd/qec7Ew
         iwJsrLi4eepO8w7m1kzAbNKq3/h6kwPxZon7jGQjai0wY81Ogtc1PoiIfaPinlIydc8Z
         7zKGRSyTMIcpBBpy7yGYYkIJ0Mzy4asiraTp6e3EjT0LZK2QaTIeL1LcmuQVo/YURKsI
         2N8DrrypSeJvPJyeXhI3ci6cIpee2rq0Tll/aWudDeLLXA4FV+LuRYrWfSxdaZMeEubh
         lgKxuZemNVnnGFW3lUYG10k4T6vl6jX1nbczQl1ynhYZ9D4ML5o95BII3Oyg8KWJQkqx
         ZjaA==
X-Gm-Message-State: AOJu0YwgC/tSowzX9qySE7fg3B4CZ7G6upYb8+aqnsuPhNDO6n+5gIrB
	b61cBSvRpouKsfzb2SmxoI4pA2HxAPufvWhuBlMUnAafDI8g/dnOHDnBz1SthEgrE9GWm0xiR4W
	vJWWS+TRpvq90qvrr2d4O37tM7O+0kEywEolvB5zHh8DhofajNT/sUyEO/wq8AC5AIfctZA==
X-Gm-Gg: ASbGnctLtUWh2NDQqZpjso08LSybk+1WNO+prRvUH6n0ekq7ImHok5xJVKXkPJrHXpH
	MOiTZuBPYB8CaUMYlAmbrm0oumCWLJM3LuPrRAjlLY23a22BJP+myTspPx9mY2ztbsGd4q5ytjo
	cpI88vgJMlfS7oERJGakyYxoUESTF5MCmHmF8KdM0Rye/CvRA8rfD4A1osH3JNKx2I+H0/E6ESW
	9vVdYzKL3/yu8De5hUzmlt7kd6EiGFdF+Z21feaCeb8x/IBjUI1bBS4tmn0ppLX/hFxLNQrzMzm
	LJdp+IhV4hwZkb43Rmy3E2uLt9PwVuGUHCz/mGOGtZ+KCY4kgiE6AbXILhE=
X-Received: by 2002:a05:6a20:2d12:b0:21f:5aa1:3124 with SMTP id adf61e73a8af0-22026dcd362mr18758446637.13.1750690123780;
        Mon, 23 Jun 2025 07:48:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPi4cKrud61xznT4SLpXN7/4aR7GqNyZ6AuJr/+55M55Lvw0EN4S6Hhx5uVicZoOPqbf0Xww==
X-Received: by 2002:a05:6a20:2d12:b0:21f:5aa1:3124 with SMTP id adf61e73a8af0-22026dcd362mr18758410637.13.1750690123252;
        Mon, 23 Jun 2025 07:48:43 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6d1eccsm8332894b3a.180.2025.06.23.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 07:48:42 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kang Yang <kang.yang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250605082528.701-1-kang.yang@oss.qualcomm.com>
References: <20250605082528.701-1-kang.yang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: update channel list in worker
 when wait flag is set
Message-Id: <175069012258.3758471.5681456771680550756.b4-ty@oss.qualcomm.com>
Date: Mon, 23 Jun 2025 07:48:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: G8sWmEru1xQRbc2OB_QE9YJkvlS_IZFt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4OCBTYWx0ZWRfX+rakbLrKjxo5
 MNjutCu1lwf2xGpiYgIFZacC7yP5jk3A0LRotCGh3A7BMCF/RoF08eJuMzVhUUWbzB4cINDLQ4N
 U3kIw6LVr2KGxE0LuY2Bv1nvMEwv1u6/9Rna4FVmO/mXjuclGWvbjSjN3Nd3hFCy2L5Ud8L9IHV
 0905oL7LywTU6YPWsX7+mQ0wHd1XPDcrApPdjnQfpNrJvgKKEAtrn/OtGd2Utd2kruUY19U5UZW
 J/F5czCBPnIY/hHexlueV2Y+kv0CyYr1HmsAdyAYWbw1r/WOSh5JKcU7ksqwEGdD6lBegpGSbIh
 20KSi3WqWMJ7W7Y2nIpGcPeUc38Z1OaN/E6XgSlEBLVY0dfDpfDKnEFPkyMTSmGJQuVEg0uUtR0
 Fxycr0c+zpesF3oUgsBHtUti3H8OI7XcJ1eCQXRx07dDpMslvQZMeWH+Cf7iShJw1jYDBTAn
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=6859694d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=zSQX8QXsPFLw0YBL5ygA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: G8sWmEru1xQRbc2OB_QE9YJkvlS_IZFt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_06,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=965 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230088


On Thu, 05 Jun 2025 16:25:28 +0800, Kang Yang wrote:
> With previous patch [1], ath12k_reg_update_chan_list() will be called
> during reg_process_self_managed_hint().
> 
> reg_process_self_managed_hint() will hold rtnl_lock all the time.
> But ath12k_reg_update_chan_list() may increase the occupation time of
> rtnl_lock, because when wait flag is set, wait_for_completion_timeout()
> will be called during 11d/hw scan.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: update channel list in worker when wait flag is set
      commit: 437c7a2db6a34db2a9048920694a2bf9b0169726

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


