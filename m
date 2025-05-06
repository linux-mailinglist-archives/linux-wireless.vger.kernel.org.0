Return-Path: <linux-wireless+bounces-22664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCEAAC579
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22CB3ABE0F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749D528033C;
	Tue,  6 May 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="dJkQeUSi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DC21773D;
	Tue,  6 May 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537077; cv=pass; b=AXe6Fo3mlXFMaUTgsYNA62DsM/juCMV8ZIYZJrl9zrgegoyrcuRPp8ItS5r/4gf+wer+sOot+xmmzqMGBukA11e2pbpAQrpONfdjnuzsCahY7kT+nPVgEQmv+OGhTFI5j6bMC6ZEX6IX27KCKJBLD5Dz+uHjXFrAfL+vO0SjpYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537077; c=relaxed/simple;
	bh=bqEDUeRg0Z13orMPXIlqQ9MbK2GR9UJRD02DfsPmnL8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MQmLEW0zL83IgKK8TN2cgBKnikiFRJrK90CxasCTsQc7AVVRW/kL9CMYtBmNG34bKAM+rykZWpvXb/TUbPv5y3THsmc2N3ERZ1cnzuLdCOUXYg86jUuXFbUa6BBI86PKL0OxmSFfnOiIhKBYC95/bKNnSlrveWeN3mF8UHxa6Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=dJkQeUSi; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746537055; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mi3wkTw0euUe1uZMnqrVoRQTAXYgJJJpKX+sAdKc+DsIa9D58bptoy+VYTDd0PXgDOyP8xV98/AX/FrMMeFuhd/Kky+4/jkm9g/tkIWUwAnKOfuOPrjGdWHXblqjUTP94ePSAb8itAD6JRgtpEkfiu4sqyMRYV1IctmbHzhFjcE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746537055; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=le+RGOEXf+PLjSVW04iEzrbaCc2v/k7AHP12FCt1V0Y=; 
	b=T0STJ2kuRkK56z6+ILP8yF7R6fyJKSscrn2rQl9bhUWQwaTFxhdws9qzTGcz046IX1WfjQGFwdl9i5p1r/dStlYcq9BMFslV6EMtQmpi+uYGlJ1E9JEzM2gyxrl38lfpo7wi4pUquPRm7FXvVvO9sbETZUT/S6m2pVPBM+Bcl3Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746537055;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=le+RGOEXf+PLjSVW04iEzrbaCc2v/k7AHP12FCt1V0Y=;
	b=dJkQeUSiBYBeRg/Hpa4Cz7IPFuwAeLIk1iv2kmqb3DzxaY4ulM12yl4CsYaRqlKy
	+mFLgkbWqQWWJ5lJOrdMGDDnZMwXoCttV6TMDoxQorJCQ/V+HacA4Uy7nnz87cQWsnC
	p4YG4fAU6WRQKU/qjbxh0xvkd4pBaLq+KpoS9AO8=
Received: by mx.zohomail.com with SMTPS id 17465370533315.429619863376274;
	Tue, 6 May 2025 06:10:53 -0700 (PDT)
Message-ID: <ec0bb100-4a70-4827-86b1-e4a7e8867a2d@collabora.com>
Date: Tue, 6 May 2025 18:10:48 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, quic_bqiang@quicinc.com,
 Jeff Johnson <jjohnson@kernel.org>
References: <20250428080242.466901-1-usama.anjum@collabora.com>
 <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/6/25 12:17 AM, Jeff Johnson wrote:
> v2 feedback was not incorporated:
> For starters, can we make the subject a bit more specific, i.e.
> Fix MHI target memory reuse logic
> 
> But don't repost for this -- I'll make that change in ath/pending
I'd changed again on the request of another reviewer. Please feel free
to change as you like. I don't have any opinion on it.

> 
> However, does ath12k need the same fix?
Looking at ath12k, there is similar code structure in
ath12k_qmi_alloc_chunk(). By adding some logging, we can confirm if
ath12k requires the fix or not. As a lot of code is similar in both
drivers, ath12k may require the same fix.

I don't have access to ath12k. So I cannot test on it.

> If so, can you post a separate patch for that?
> 
> /jeff

-- 
Regards,
Usama

