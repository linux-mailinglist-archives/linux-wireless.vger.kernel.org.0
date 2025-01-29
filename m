Return-Path: <linux-wireless+bounces-18161-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E178A2227A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 18:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF7C57A0633
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3951DFDBC;
	Wed, 29 Jan 2025 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZmHZl+X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF041DF72E
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738170241; cv=none; b=eUAEdGkIVF9h5zdhdcN6MHftGgPH6/6haU/gGiGpcT6VfZq9RNXCsgpq5tXVN/wzIVz5b1NEaxEmCWf0oeXUFKJ0JCVLtXPDLii96CG4VPTIgtPOZdsC5wUG5XDpgOXliVwohJrKO3ZcfeDp1ruG0qXhnTYZbd/UqNxHxYWXqi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738170241; c=relaxed/simple;
	bh=8FPcYfWJGBqWMsMoqr/6MeQtIerm/gZXMgnT3cClHF8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VXzESSk9Xws87yn0ljad6rRm6UYRZ3cg4GAaL0KWDOEazh+tjHwoyZid/TPCvLqt7PF/AdjKftwYckLh/M1l0HAK7elwD8hWRaquH0igS6Bc5zPZzMyw2Dz4tcldYFv+zYbxzGNFADGXnHGhnlG95Vm7XmhGrQ4nklt+6koGebQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eZmHZl+X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T8Vbno020698
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dcFfRUe3Eu+jKRso7rfrRe7pywcY7FaF66XNyO6jx7w=; b=eZmHZl+XvZWEROIA
	ui0/cIks/S2jctZJY8ICdb4uBmGUeZrN3L08Twogi+G7F9OGN67oKvYlA57ls7wy
	39e6qR2zuUyYGUTj8uaV7O+NIDNVaZRODgzg+rgIcfM0Eu4ssHRQNW6lNmfPVXED
	sFYqsag3ANjFWw5nfBVQBg/DKTd/oibKDks59Oxa3c6BCQG4DVsE3CVm/G4yM40K
	kLIg3lWaj14tDNrjaeIHe0SlwOvxB5RZE4U9ICYUvWHBovGcZ4LcgR256Iod7D2Z
	/BEiwnP/OPkRii4irtAtcd7a44bLkJR1wCH86PQnNL1X100X/GAuLuSpdnftCf6S
	UmUVMw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fgw8s0qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 17:03:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f780a3d6e5so14236389a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 09:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738170238; x=1738775038;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcFfRUe3Eu+jKRso7rfrRe7pywcY7FaF66XNyO6jx7w=;
        b=e+IrNPD/lS4d3vC0mNIvbNKVs+2uBdAly9TnlqAWnwvyiiJqWmtqtIq1uZjeLonkZE
         ApH6DTk+61xtjVMes+RC5v36gIEBNcW0PmvsNFXr4XBQA4daZ523k2GfDyfVcB+vj1Tz
         I6dC7Y9n8CwbsjB1Iu4bok+hNy9YHyw7sqcun1bP6zIg126epFigIPJLb0AdgreZKvm/
         KUZZKJkVfPtSUytKRY7fU/huGoXiQL/66MYxUlUnb1pC51XSSfyd077mQuOqydelZXqR
         8rBSkWzwOQZKc2TKq4wdLjHKg3r05rGVE5qy4QxrwHPCdB8S6CT00AQ3aL4A2Dm/H/7x
         s65A==
X-Gm-Message-State: AOJu0YwVL315OkwhBC3FU4WcZ9bDSwpqqBf8oeqQ16Nz9VUJB02ndLjj
	9Ep2wIDhhM2y6r67tPpWN5qS0mfGsqixzFHDPESxhebShXAIWGa7YdBFWbwAxalT8Onk3k5IXHd
	xHdK7CNNyVv2hSomur+aTj9uv2cnZl6GpFoeEn7Hj+Ogpzv20SHqJLpjYAc4RK2WNug==
X-Gm-Gg: ASbGnctG5vhmAAo+cMPZgOXgN9byQUJeenApQUcZauhNZslCbA2eKo67sa1Yg72+KIK
	B1YSMNdhh70pkuzWr/VNZfacYWrNV9Qp2THky2I0mqBBs5aq47S72+jZBmsZ8+Ip9f1fNDLY74b
	DsWSSLOfkzrjlLkUdBDIoHbhNyc4fB4rlVh5tGaCDwpEvatHXp4vzD2EyUEGOYoidtZZlC7yloR
	8KmPoLmoVmoosH+Jm8w7G6o37oIHyBsI2TtPJtEyZiDVRBuUnkt7qljhy9SZXB3CVidivELDcA7
	s/nA2a9m/kmosElXBACWY4/x1saU3yQ5vEn1cm7jRw==
X-Received: by 2002:a17:90a:d610:b0:2ee:4513:f1d1 with SMTP id 98e67ed59e1d1-2f83ac5e5bcmr4590733a91.23.1738170237832;
        Wed, 29 Jan 2025 09:03:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLicrv/jRmbbjIcyAPzMIAXFBnO9b32WJPWF9zfxtlFSbq0C36a3eIMsWqxdU+oSHYj5Juiw==
X-Received: by 2002:a17:90a:d610:b0:2ee:4513:f1d1 with SMTP id 98e67ed59e1d1-2f83ac5e5bcmr4590604a91.23.1738170236290;
        Wed, 29 Jan 2025 09:03:56 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83be3622bsm1988366a91.46.2025.01.29.09.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 09:03:55 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: linux-wireless@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20241105222326.194417-1-rosenp@gmail.com>
References: <20241105222326.194417-1-rosenp@gmail.com>
Subject: Re: [PATCHv3] wifi: ath9k: return by of_get_mac_address
Message-Id: <173817023561.726123.17616373770684373246.b4-ty@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 09:03:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: SLa3QT4Tk_hFTHfAJmjaUHLqNLkNE0Z4
X-Proofpoint-ORIG-GUID: SLa3QT4Tk_hFTHfAJmjaUHLqNLkNE0Z4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=680
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290136


On Tue, 05 Nov 2024 14:23:26 -0800, Rosen Penev wrote:
> When using nvmem, ath9k could potentially be loaded before nvmem, which
> loads after mtd. This is an issue if DT contains an nvmem mac address.
> 
> If nvmem is not ready in time for ath9k, -EPROBE_DEFER is returned. Pass
> it to _probe so that ath9k can properly grab a potentially present MAC
> address.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath9k: return by of_get_mac_address
      commit: dfffb317519f88534bb82797f055f0a2fd867e7b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


