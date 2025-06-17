Return-Path: <linux-wireless+bounces-24227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0DEADDFB9
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 01:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADE7189BE6B
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 23:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644E22DA77E;
	Tue, 17 Jun 2025 23:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XnfGXFke"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3C62BD5B0
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750203146; cv=none; b=AgledIt3+TBkUEhOBwpCDE6dzU3VTVx2gtSwqAseGhsBKetpODpLc3DNc9kST5azdTc41UVSOps+BIj+bS1PKVg5Fpfx38IbKnNcf1/ykhcSJ5IMeJD8zpnh7UFdmTlW0cyQM2KMqXnCesYDSJNbCkK7JoMbeTA1ftFlQOXIEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750203146; c=relaxed/simple;
	bh=AfxMsF94tF349EpItID6PgNiNVqvXkqdbawyp3tz8Jc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K7QqzZj4IOVeSjMINjlDkJ0FNnWXBkytvIXWgzxKg4MiGXN2T4Eb6l4XC378QR1GKpee9//iWn713h/BL5zFVz3OKEO5LI0JwqqvXl6HhkURatd9Off7hIwyw9D4J7g8PCn2QLQzI2v7PAOzDY7kS+ERqDYks1Juo2DXwnWKaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XnfGXFke; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HFghFw028781
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VH/vxjqeQUdn+kO/cJnT4XNxKWalkHSfP+TNuNuY+T8=; b=XnfGXFkei+fRye3p
	yo1Tdtw2eBZktxgfEeR5RLtZKs8t+10KdO5GxMcqkckMZ2elRjJGhUKbueafPGIs
	ecGTrDomEXGgxid29vYqBEChhzqOyyMAJ/juyYFIt6nqCz5Qh2z7NbwL/DpTWArI
	GDRGJ1As5j5wp5pOKs7dR0Fcp9nod8C55dyRf83RWpd25ERPteLhkdnz7kPCMca8
	aCT7j7oMSrp7I8juvUkYuPHtHkCgr7fz5AHrxWahezx6oJTHv2T+/GixzmsP1bTY
	+saGJ9rT+K/2JXbpPG3svrDTMefo5xPmU/2Feb1UaR55Z/Qbg3CVQLdy/k1kZt9a
	iom4XA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47928mj27k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 23:32:23 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31c487e1cbso374940a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 16:32:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750203143; x=1750807943;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH/vxjqeQUdn+kO/cJnT4XNxKWalkHSfP+TNuNuY+T8=;
        b=oG0MWFe9fAF4bYq7QhLcP4l+blr717UuwmpHp4j1kMf5vsyPHYK3UnKIiv+5TH/noo
         qHiel90BwvFPJC1HN5PrxhAKb/k6IkSYT19xrPpaX78MbXtA12DoQ8Ew/JpW9JaA/Sce
         0ZDYprLJ/gFrN6Zf+sTLjuBcT9/BzZnHCKmN2jjX1sW9SGyiGELTT+rHhp0sxNXjmd6F
         UW2zN1r2Bbg0alEQVQoIzOMfukc+pBnbKc2klpRy+IF8SOb8gY+oC8H6P1rm86n4LnNc
         kgMA7PKwOz+BaSUT5GkEado4hd38uKc8cM2xh3JWWyeH9/CxfrjXWv3Hyorl1LfDma6N
         9i4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFROev/YJ8crZ8RVEs/nnS78heDEWhRGIg/6VDHTcPyAdmO8msnCbc+xcb2EJc2NXnTkDyr+Bq9YprRk9ygw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQHPh1urt7Z/Kg1QPyBoLAF4osrB9AOnSFgdhB4ie4It06iwq
	+h2HuVJynavu6O2g2NhfxpfE5ME/XJMfEvkxrPM3zpuFTGSsNXLhEbO2OfbJPlqsjGq7o34NERh
	y+VWc1wE6dbjV9QUhwKASHVCH9Yl9l71wowRp33NXmww5UXgKQl3/c7l+NeO3HGOHXkgtqQ==
X-Gm-Gg: ASbGncsWMx3+e/OGz/IRd487/WyVjHLtSCaHij+84fNdgDOzjsrZ6w1kmuKqRotM062
	GfLID7KQZeNBbKiAvpRbVpNd3eZssQOZfMcE9inKhoYE/Dhy1A6+eTKu36Pb6UXnKZvYR5YPDmK
	GBMAGqJ9Cj+t6nRhIYuU7+dZNKtalxnJcDM9AYG3hSVSnV9Yurw5agStvjjGn35QcrlMQneDOY/
	ZsqKRT/yIW+Tbp8BBhUBUPj3RNwkTX4Z/UooM+9LOh6oogqn0Grd+XDTqmlfLLw3/p4A05TsmKY
	SS36as6jkB0jfExkN3DxaRMMvL70hpXs1Z5o9l92nMjGxWkPB89L7gXsa2U=
X-Received: by 2002:a17:902:d585:b0:235:f45f:ed4c with SMTP id d9443c01a7336-2366b13c99dmr252533265ad.24.1750203143014;
        Tue, 17 Jun 2025 16:32:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOndezAISbh89EZjT329rhotx16f4QoMZN73NV4uaafxkFVLDwAG95zuM7H0TtUbyAkTOQ4w==
X-Received: by 2002:a17:902:d585:b0:235:f45f:ed4c with SMTP id d9443c01a7336-2366b13c99dmr252532935ad.24.1750203142508;
        Tue, 17 Jun 2025 16:32:22 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19b84e5sm12731527a91.2.2025.06.17.16.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 16:32:21 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Christian Lamparter <chunkeey@googlemail.com>,
        Dmitry Antipov <dmantipov@yandex.ru>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250616181205.38883-1-dmantipov@yandex.ru>
References: <6bacdb9c-6064-43ea-9dfe-0eca496d1c9b@gmail.com>
 <20250616181205.38883-1-dmantipov@yandex.ru>
Subject: Re: [PATCH v2] wifi: carl9170: do not ping device which has failed
 to load firmware
Message-Id: <175020314103.3793705.16544660436986036473.b4-ty@oss.qualcomm.com>
Date: Tue, 17 Jun 2025 16:32:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDE5MiBTYWx0ZWRfX2+Krrh2Won5R
 nMaBCTMTY80xtt+Ii/AupyfxqNJqNhMsYmpJMzP2FC5RDVJ91V4v7ps/2TuYgwv+pDsECflvu0O
 ywoaAX1fP6jg2DmRhnlqLM8Ydp9PZxh+3JtX7qg8ITt0DzPLunzK3x8G6dqTdEHxIpcLYnqtPl6
 O5KqIlMhjdDgbO8Iy6tduk/T4ggtTsxkbnMoeQpv7MCZXsx3vyKfYN0WjRDM7+v8y/oQGye6DGV
 WFCtFSyn2k1H4kKiwN6E4rH2E9z0jON45aVbDzMLuXBjHxduzBoxYky8kySQ9vAuO1M8BC/t0pV
 g4a5OCiciJ4Cn0WREmulvnDCxXRYM39v052dk/DGpUKvjH5LVuBKpjEXvytkm9mOhbu6YPGkOA1
 XUUjhTHhLHu4nLzgG1SrW6cWuhwYwk3VcUZTHJvaAowzB7Byvke18ri+AieXf3os+D7ZAmxR
X-Authority-Analysis: v=2.4 cv=fvbcZE4f c=1 sm=1 tr=0 ts=6851fb07 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=8oJg6Rz7cn6bK4rY:21 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=edf1wS77AAAA:8
 a=EUspDBNiAAAA:8 a=z7cAG3P89-7qryZaYlMA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=3WC7DwWrALyhR5TkjVHa:22 a=DcSpbTIhAlouE1Uv7lRv:22
X-Proofpoint-GUID: YXGClrR9VQdC8JzQbSGdCyGU6pFQYWP3
X-Proofpoint-ORIG-GUID: YXGClrR9VQdC8JzQbSGdCyGU6pFQYWP3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_09,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=850 phishscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506170192


On Mon, 16 Jun 2025 21:12:05 +0300, Dmitry Antipov wrote:
> Syzkaller reports [1, 2] crashes caused by an attempts to ping
> the device which has failed to load firmware. Since such a device
> doesn't pass 'ieee80211_register_hw()', an internal workqueue
> managed by 'ieee80211_queue_work()' is not yet created and an
> attempt to queue work on it causes null-ptr-deref.
> 
> [1] https://syzkaller.appspot.com/bug?extid=9a4aec827829942045ff
> [2] https://syzkaller.appspot.com/bug?extid=0d8afba53e8fb2633217
> 
> [...]

Applied, thanks!

[1/1] wifi: carl9170: do not ping device which has failed to load firmware
      commit: 15d25307692312cec4b57052da73387f91a2e870

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


