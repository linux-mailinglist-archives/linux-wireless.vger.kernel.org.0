Return-Path: <linux-wireless+bounces-27588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ADFB9340A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 22:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D70DD7A554C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 20:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB61268C40;
	Mon, 22 Sep 2025 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dg6HGniu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B89265296
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 20:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573788; cv=none; b=q57iUQJeuwSCU+jjYr1EL1ZFY4xj62RehP7sLPpD0a72WOgBb59Au7UQp067WnaCBWPctkrp/X88g4VdZKrSmzD/pr/VUUBdxzaoRYxBw/x6f0Seno2FDjrAcsjk/xh4lZM/RloFZ2lsGpVR/Zf+VGJqjXDTbwEowRwPzJnflf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573788; c=relaxed/simple;
	bh=ibSnc5EcRPBlcLr5NtFCqj2PtCG3lWg+ziU5Fbo7dXg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lt6nW+Z3QZhT5sudSawpxQx/sv7kFr/pKm330TLi3asodBx5bAnkGqJZjIIcXqjTs2AS1LcNirg+L5vsgkO6EHLGGBDqZoG83vgYkbHJfmkVntZekOIHbIt8OtUkWYiPSYLzqo7UdUlJ7U7BUGZWgOG1u9EYm9insO8EDA0Dwnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dg6HGniu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH6rWs029591
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 20:43:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PiEv48j5rWcaAqxNJGzE/96rwguoW5QgNkq7JH6PInI=; b=Dg6HGniuAFPpZpd0
	9Opv2Xsco/IP+PSOQoRyjkrQ3jXbUGBE0TK4VlJ4HrijiPil0Qy9Elj8iStERSYR
	t3BLB0IQXOMuvbLGXUNo9yotAGvYZFxCLYwoBF82pbTcbSjeFcSfFGaU4CRfuvaZ
	+jHToQqG3azzwC5hu620B9CltYjqOvDs9vn789nmrTq1L67r7Yaucudn4/0Vz0Iu
	Ovn8fFd7m6bUBFmqpZMOtsZ0cuQFdEVHK+eSDZPmARkpKM4Ec88uQdMrNuWdf4uc
	ZDbeR1eibvln+0i8LmY7wVudm9oDGmv7fxSlwnj8x6R4iCpf9XSmdTbuQlSidAc4
	f0F7EA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajerjtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 20:43:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27c36902f42so2416515ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 13:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573785; x=1759178585;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PiEv48j5rWcaAqxNJGzE/96rwguoW5QgNkq7JH6PInI=;
        b=t9wJo93rCyr2db4KQBI3ejVUGyC+bmxbLdh7yoMSsQDiHdnycEoWK3h6HhG7y4SZOg
         8ZUioAskwynLfsp1TVMQ3FIBW1GIOaURehZz6wVhQ/rvUSwxCsbwvT4zwyfoDkaeGep1
         Q8Lnrwt6msUW2/aAYrvmt+eNLXAao3bHgThowDpE1xItsnupvqEIvtX8ELv2qvAhvYOY
         uq1GczK1w+uUgIvRVBQfJn+6mVyKOL5C7192NpIr2e6oFgg2vjC7klkdRGrFOWGzK3U0
         R5zS6D5oArinpTpRYlJvfH6zAp04saQkBkoHKe6tpiZ7M69mIF4kitiQ7N5hQEd6aXG4
         XMQQ==
X-Gm-Message-State: AOJu0YzN3yedNeSdw/ZiUW0dF+OULpTPVqmfvKnrBs6GVd3QC1fXTsrW
	JDxIt3Qqq0minMZcwRhpGCF/xy7M4z8VDpk48Vj3m4cNjtqEyoYvB1dbd2PokXGZ6s3romeOKnD
	yJf52Saip1EDYJfzQOS8zDqb3Hns+P3EOnW9amkG/00xTTa3a8Xrx+4DrkSE/EpEOXkRZnA==
X-Gm-Gg: ASbGncsh4oBHFFoIhkbiSD8L8KCCclStTXJjKDR6gO5a88kQR8AZXWOU2NLdvGQeZ3r
	pNeRT8d+tEEKVJnXSkHFRkRr7DNcv58RbIIndphEKllZjSXUQkzdv5QNSP9jMenndbEA9xQv8ry
	bEncCNUdIA2cX4AZLZeNy8n4wm2FvRMrDFbD0so7uVTCXHJRNjsBJf7yXD6u5BwLvXb+tvDM3NM
	hEFK0RP3J7FLQbtsMm/Va/zGQ19ggSZrqjUvkxiFblUfPe1qE/hf4iSNhXdqF+2itG9NrjDKgQu
	cJ+YLHFtc6dWlRMN3grhXyqhIDkuswaGAJ2IGpYuyNjM36q0zmGDfKziN4LgR00cS5dQpoC/ea8
	G
X-Received: by 2002:a17:902:e84d:b0:263:ac60:fc41 with SMTP id d9443c01a7336-27cc76e2007mr1508995ad.48.1758573785412;
        Mon, 22 Sep 2025 13:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDg5SUvDYpoOi4QrqEmsVu3tSJHlXvWSpdSXO07XSYwVXcsF4lRFp4zQ4axpAHjLd9A8W2DA==
X-Received: by 2002:a17:902:e84d:b0:263:ac60:fc41 with SMTP id d9443c01a7336-27cc76e2007mr1508765ad.48.1758573784942;
        Mon, 22 Sep 2025 13:43:04 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27cc8b251f7sm817935ad.8.2025.09.22.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 13:43:04 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
References: <20250922061607.11543-1-alexander.wilhelm@westermo.com>
Subject: Re: [PATCH] wifi: ath12k: enforce CPU endian format for all QMI
 data
Message-Id: <175857378428.47334.188951936542723567.b4-ty@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 13:43:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: vJ37MA6LoQIfdQ6uGY7SoGt0xHjZt-WP
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d1b4da cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=141ELwY65cG9oRu6GBAA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX3V2DVAEEuf8C
 AEgxXfCN564i1Q/RpfaqI+eUHzJE9CWKORsai3Qe0n+XpxjRJvwGtka12IM5lN4vAXGpDchKXen
 wXWmOyQ/CduuDAC4/xISdOd+SLrkTF5WiLotEAd9aLE2mxxB8M8lK9iA3zPOoR693YTX+NgGuIh
 3FoCUexKvZod+rTzQWfItbOQ8hiuAEzILU6mywQLNLFthhg+M3ZcU6/JM7PnfRKUUw/8RHgVRTS
 CHdttIF9ID6QeMHW0nHocYlm5ylpc40+T1VeI+zpMfyl/Xyu/xEVPXPIzijMdA3dNCzSKfATNoH
 icfvjWZrbKKmD5/JsVNOkFSt0GQE6PZfBmzQ9W+/QUzvCs25iQBAFmn9lWFKqSckYjbSP5CnRME
 /XkfLjzD
X-Proofpoint-ORIG-GUID: vJ37MA6LoQIfdQ6uGY7SoGt0xHjZt-WP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168


On Mon, 22 Sep 2025 08:16:06 +0200, Alexander Wilhelm wrote:
> Currently, the QMI interface only works on little endian systems due to how
> it encodes and decodes data. Most QMI related data structures do not use
> endian specific types and are already defined in CPU native order. The
> ath12k specific QMI structs are an exception: they use partially endian
> specific types, which prevents the QMI interface from being extended to
> support big endian systems.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: enforce CPU endian format for all QMI data
      commit: 9eb6f553026e1268a62aa352af38f70fe7d42a46

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


