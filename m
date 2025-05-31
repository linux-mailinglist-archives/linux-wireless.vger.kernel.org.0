Return-Path: <linux-wireless+bounces-23520-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB84AC9CD6
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 23:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0A7188B5EF
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 21:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705DD19A2A3;
	Sat, 31 May 2025 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgPFia7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E491411DE
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748726205; cv=none; b=RwqKnossgoz08fv1kpdZmdoOn25aC+PGgAhJ9+enxR+XselUNYW/dk8z6zAYNptschNfw2dErU+cjc7nEpN9i1c/bc4JDmrfPEsKhk3POjaFez2VXSspEy3yQMOCUcnhAdAOPvbDVmqP9Dnr+4+Iywg5cCJ2+Lpb8XkOx2quZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748726205; c=relaxed/simple;
	bh=EUvczlQzZiV+h+BBDfrE5Xd/wQgSlMczVyOkVpEO7xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIutFGpfN60MQlnd/5Jpwj/Y0PTi0MiLQ6rUkTV84v+u7jUHHGU3/rKYTy+nXo7rgq2ppoj+27Rd/VxhTLIMdL6FEDcda8iyDWt642yVjNRiiWMoEM8oPGen/NVW16t2S6IsdgyoBcrqqczLr8fykS2afrhojl/rf1F1doyvl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgPFia7E; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a375888197so1601636f8f.0
        for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 14:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748726202; x=1749331002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D6C5boLECn1PDP++AHk6Kl4LYmMjXBe67l9wKYkBlSg=;
        b=lgPFia7EtXjOqKLJBSd1xWJcmMqN8dTbuZ7MYwZbXw8QlPcwztgNACkPRdQq/kGJRR
         3cJv3HwsmQUa9/UgSS+l26w2WN41IosnwNGu8OzxlmxerH8+McSZWklMctXkliRNf4u4
         olImBAGdN/rn8VNDabPt50PO9D5BX71KIaLniV/jSC7RJBEMYTx7zyMyybq9coD55ZSs
         XzO2HqGQB8JV7kRt37aFfpOG8C2bJs79GV4/+rasBgQ7AH6qrdUQNV5DxeVHHgeSbgsn
         L7DYhYvBF3DP75GXoHqOGrLFSd0XZhBMmODF46t17FpVkT+4z5NXNFl0nEjkLHV2s8uw
         N4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748726202; x=1749331002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6C5boLECn1PDP++AHk6Kl4LYmMjXBe67l9wKYkBlSg=;
        b=hNBH80JpPZb7+gO/hEDr7v7KSBlH7507cO0QHnAFLQ8ANMc4UjpMns7w62lDkWINh4
         8+KlTfJoVaT4eyqF2s3Thdvy/fMz+ObcW4JX8ibWMMYfY2qHYOWBXXkyuOeAfEGKyAnR
         SaC+kJ2RE8M4lxiao6morTBwG8MvUZdMo2M2XzV5VdgViAcSLw7hB0RtepACDukvZdJj
         z1JVt4/IVcYBVh1ObByiqavbgkdeZ7SepMWqyUzVJMZxi/csF01gGersoAtHazdT+ZPR
         hKx1ZjW3NuN+y3fOpmYVl1DewdX/lKQ8y4GYJH746MN0b0vf5iU24OWJJZIWLkOv4/Yd
         p9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWIrM+6ZYfUNaJgsaQf8ojjAdJiu8M6ngtGWm1x2ALAvKOvTDnZq6V+E6hS50Mkl41kbzjryC7O2k0a307DvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VkHHxImdMhdL1ci0VOOB8FkI8cTOhLeemfMmSZRTiB+Q/A4T
	SQQI10gbzFD2kkQ/ep/o//w96EgoPMZq+m3NdfG3wzCXrsnTt1CCWthFNKqt//wd6LQ=
X-Gm-Gg: ASbGncvRtQtPWAPgPMnOa1d+812oRTz2Wmu9yI2B+zZN/3s+BS1f6odpFi3ZMZIgEvx
	VN/RisvIHuMWtRXD13GWbAJkHMgqu55mvDyr/lMx0vawW9dJkkBo5aE4UvHtgVuY4sxgfCspQ74
	95CwPDB5HtFuUVNXNBUzJcVGJ0fWPnpZzOVJfDTL7oSQeDMvm1qAxgR0bBtjZGMiPa3+a2Ht51R
	pXBGnWeitmX9D7IgrYiw0fzgJHrNRuaoEaL8XccJoLoaKaNPbEZogEtlKiSmYLkCiPnqUwX8ZGs
	H8UPMIuDWTAplnty6+zdkYmDs4u8vQf6DU/c/A89ovAfdkXH3Gw0qx1UJYj0VZT1
X-Google-Smtp-Source: AGHT+IGvcJGDwbjtlXjqFLefX5L1sH0BT9VOf0rQy4wUjlg1RcI3m5TY0jePBST/a4GfE5jBrdlXhA==
X-Received: by 2002:a05:6000:2313:b0:3a3:7638:d754 with SMTP id ffacd0b85a97d-3a4fe17ba86mr2479780f8f.21.1748726201915;
        Sat, 31 May 2025 14:16:41 -0700 (PDT)
Received: from debian.local ([2a0a:ef40:eaf:3101:2d68:caee:7294:3fe1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009fb0bsm9030648f8f.87.2025.05.31.14.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 14:16:41 -0700 (PDT)
Date: Sat, 31 May 2025 22:16:39 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"Berg, Johannes" <johannes.berg@intel.com>,
	"benjamin@sipsolutions.net" <benjamin@sipsolutions.net>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] iwlwifi: suspend failure, bisected
Message-ID: <aDtxt9fInIypgPsI@debian.local>
References: <aDsNn70jcX6sDLLT@debian.local>
 <DM3PPF63A6024A9CDCDCB068431DD5249FBA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
 <aDtc_1OIwh0DH4Kw@debian.local>
 <DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM3PPF63A6024A9ECC64ACBA27CCABBAB0FA360A@DM3PPF63A6024A9.namprd11.prod.outlook.com>

On Sat, May 31, 2025 at 08:07:31PM +0000, Korenblit, Miriam Rachel wrote:
> > 
> > It doesn't look like it made a difference:
> It actually did, that's a different assert 😊
> 
> Please try the new version of the patch.
> 

Fix looks good to me, tested on two laptops and the errors are gone.
Thank you for the quick response.

