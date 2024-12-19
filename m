Return-Path: <linux-wireless+bounces-16623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD19F82B7
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 18:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B8E7A3EFF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E731A0BC5;
	Thu, 19 Dec 2024 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C64Bj95s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32169199951
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734630896; cv=none; b=KKgfeofrVCwWOqDJx1WTUbZfEF0YaleoTb7+Cc7OfW5ftWIpMK30AurzpGLiuJnrZbLQfjKzkQVI9k9VNg2gcP+UOSl2npkrvRwbeUk+y7VDJJuXxwubS7QT8BiQwe1Onqj0A9VeyFPNbxEfGbArEDNfwlvOXqUfslFVceNkcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734630896; c=relaxed/simple;
	bh=0CMhwzAlo0I4ViU5K02Q+N6n/pa/sb5eQlkbhvBRifo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SUZf2rRYSEcUh9rjSq8FGyAkNLpRfYxqFDZ8P4oRQmCbA4jd6tAWNkMzG2Kh1Qbv9/U84ew7vFaE2PWuaQvnrPVXFUx2BzjXSW5s8At0yv8hqvi0mMjs38cAPMAOSFyE5Q3qOu5hLuAcwDBrGuxrWTrIhbYxrvyvymwzKBTbMXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C64Bj95s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJF4ZkR028824
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J2EZ30d3MEYyxxd4Sjtw4PVZ+mE5Ksp1V5qF30vaks4=; b=C64Bj95sXNBc9vZI
	+eodAnBorX6H8XBv1CY7efV/7XrCl4n/wL5BYwdLkmB5E/J/SJaNvLXAcfWFqaSh
	ld+67cMwSGsLm03pasZPbeviu7prsHMbP++yaj5LpEbydZE9UPo17o51Grfhu1Ni
	FpSfQ4K5sVAIvRsk8/pyrAZpwVXIgeESMlWsAgmsmzK5iRzjEArkCijgodw64P/3
	gRBXBWFMNw7SGBroKi8uYq0qOz186hdsmAlh5+BpyigXInHuJeaAEaH+7ODqqfQr
	9UzXuIufFqMAW2LF3zoPts3HIhxWnFBJpqEduUIbKrzecTHNmFoPOQn9+9LmRNIi
	XCZxkg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mntf0fgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 17:54:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so1322102a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 09:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734630892; x=1735235692;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2EZ30d3MEYyxxd4Sjtw4PVZ+mE5Ksp1V5qF30vaks4=;
        b=QQK1mEIIvLdgEDXDVY6kPGRBmDdpkVz8hhjv4yWeiH3cwtq6Y4Z5t2GiA7xLQCHjjh
         daaK0AkK9D5H+OokXLDwFD4BSFgOwYpJM6Dtr97LVmS9Xy4/IQEUQz2GP73wQg+ufMeJ
         pi/FsV/gC0ibYu2BX03F8QLaRpz14r+Dv5Z44Q3ARSu2lK9Qaw3rzDMcqmygNaEszgy0
         HaLzFUkdhlLzYLczAPKMI2La4g7E9evunBMaEtxlEjcHnLUP8wqG7S8gOoaEcA1Dzrbg
         QOv0MuL+IOcG/EnLWjAiyq+op/Hs/RQT2EqoEiNHbK1ZcN7YBdK46xo84GcqO8zecNcQ
         +d4w==
X-Forwarded-Encrypted: i=1; AJvYcCVFSdL1fZVmo8EMSM0/O3eCoHRgSedcqt+Lng4+VXmkFOzjLFRr1fIkOfc/KUMA5TyqlSh6jRkspQkeofbftw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8dmhzjxzDmfpemasOo/D6IMEDW3fTo+bUhteGJ7D2hvDDfDFJ
	nRSfjP9/s+noCPgrkBoD42TJnzUoim3iexhNKSF66o2Ca53UXlSNdQmwwMDME6fvGrBemfYObGX
	6E/5KMlO+zAPneTH103JyqQRGwmFFxdjAxZ+zQZ2hkdGOayIjot0uVilbQ5qBLALSzUw0w8S6YQ
	==
X-Gm-Gg: ASbGncv6iq0U7nFNC/6/VWV0UOVoDqqWUd7ZrxCwXjiI/93WmRcMiaEhet02rTH5wYm
	JmKPLHus5cOVbLuZB+EqYgSp6CEiUuXEIgQC0hr9rF9GVR7KjEeQxAphw/tfcn5TK8VzJqw9CjK
	urkt14F60AA0LSUh6KJh2dyWNSGyc6LE5yDj0yy0v6gaS/mmk5w1Iq9p2GgkNhzTI45RVU5KX5B
	d1bqv/RfA3MAtTVM9Zy6BPw7PhCmBG7XGLeiYX6a573SxaaS14mrXrpnAdvYSz3QAi+f3d3LMVl
	lzbwQLvJ48bD9gQocg==
X-Received: by 2002:a17:90b:48cc:b0:2ee:8abd:7254 with SMTP id 98e67ed59e1d1-2f2e936a11amr10108759a91.36.1734630892081;
        Thu, 19 Dec 2024 09:54:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3KN/ujEp4Vs+3IIg7YZlhhutYgYl36n+bezIuJ4xgyxuSWoy76jqvJrdV066Sv9uLABJdWg==
X-Received: by 2002:a17:90b:48cc:b0:2ee:8abd:7254 with SMTP id 98e67ed59e1d1-2f2e936a11amr10108735a91.36.1734630891757;
        Thu, 19 Dec 2024 09:54:51 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26fdfdsm3630628a91.52.2024.12.19.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 09:54:51 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        lvc-project@linuxtesting.org
In-Reply-To: <20241209155027.636400-1-dmantipov@yandex.ru>
References: <20241209155027.636400-1-dmantipov@yandex.ru>
Subject: Re: [PATCH 1/3] wifi: ath9k: cleanup ath_txq_skb_done()
Message-Id: <173463089060.2609009.12588280836654250217.b4-ty@oss.qualcomm.com>
Date: Thu, 19 Dec 2024 09:54:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: XXoQmSlHk95ShN1rSwSyqa0A3Q4ymaEm
X-Proofpoint-ORIG-GUID: XXoQmSlHk95ShN1rSwSyqa0A3Q4ymaEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=747
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190142


On Mon, 09 Dec 2024 18:50:25 +0300, Dmitry Antipov wrote:
> Since 'txq' argument of 'ath_txq_skb_done()' is actually
> (mis|un)used, convert the former to local variable and
> adjust all related users. Compile tested only.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> 
> [...]

Applied, thanks!

[1/3] wifi: ath9k: cleanup ath_txq_skb_done()
      commit: 2a7e02fa9116d9b077983257774e6644af064857
[2/3] wifi: ath9k: cleanup a few (mostly) TX-related routines
      commit: d19ac7ef6ee997298a42335d0dd09b67c6cb19bf
[3/3] wifi: ath9k: simplify internal time management
      commit: 0cc6510ca4639a20c8921f223f05faa485795204

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


