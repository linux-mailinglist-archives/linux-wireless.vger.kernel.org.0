Return-Path: <linux-wireless+bounces-30840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A429D2260A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 05:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 607B3302BA51
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 04:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D662C0323;
	Thu, 15 Jan 2026 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="graEc0YF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9F2C0285
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768452242; cv=none; b=gwNwxOf7Gkqx5Ol0Pj1MySt8bV3iDBFjzVxdhVU3FNZrTwjv048Lm0CIfOX2A3YvfM0fXsner5VCKfIpa246GsXgehznwksmYxOriiT66yHeS0+2w4EWKr7KWQeho0oyHqVIO9QWNw2OmW9Lj+XxcwM+WrByINM8WKEYZY/R43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768452242; c=relaxed/simple;
	bh=gea7RuH2/PFVWFXrNZ7LYLGqLx/mVrB0Dh3kN1pDCjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQMFsegyXQgV0IvGGMp9Z821xl4RXKgkwPxb9IIUs2tytvtdWyk4N+UrDZ4+19QRe5BDP/i1EqFoQCGT8pzX54XaXGrhSQyPTWqfK+O68VEmHVdORIiB+/xFxyf9okfSrRoZqx5EP157a9vilo0kjDXCUYQvE4gqbF5/woufGlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=graEc0YF; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3fe3cc80bc3so344623fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 20:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768452240; x=1769057040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyJ1nwAoXFB46LdRdtLwHzhq+4ZJYtwrTRcf5CIjovw=;
        b=graEc0YFLarvHSi2YZtshR92VoLGPP0e9CBKe5ZYkAZMEiG6VeeCgAN7Rz4/a/SVic
         l0iH8b/D3uvDHf4n7SFdmmWne1EAlVZ9PFWF5L1ddcPlCVm9rlqsYUKvVETe68ej/tO+
         irfShz9tmtwtZUvCkz5FIswEqjlQKUXA5QF8WKBg4YOS0RyNI7X+vKwUUxTB36lXwPoV
         L2gn85osARJwFtgNYCaq+Iv+GLnoqHt/uOl9AP/nrHWAtRT8SV77RNDTH/MxZVMbw6J6
         H/uYiTSFHjLDKm+pqIsfoddq99zdmKk6SCrk4phUdWLXBPsj89IdTIlR6alwWV700orL
         yS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768452240; x=1769057040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FyJ1nwAoXFB46LdRdtLwHzhq+4ZJYtwrTRcf5CIjovw=;
        b=pHBRHLXDuKpJuwtCvex8os7JszxrtWh8lRDSMgVT9pQOkT02f5dlKxORcKbG++vBqU
         M5KKKIP5WrgmLW2wVymnGWJ1CnL3/wjPdo130WoNvMMFxiUGrA3htqO1lG7JALxfY5+s
         +O5MZMp370tT9iK/G94i+eG30CM/79cF7H6lq6zPppV5NgkVhyOwANceV6/dxYZEl5ym
         mcVNlOf6pa7THDEdD/J8X61+TZm+q1Mo4MbWcuIrwz8KsU/3LppLSVhj8x504ttx9+r+
         mUTpJCG3sln4ilJ0FOVD8rqFYvgH9i2ROVhL9hPN6WB8f1pD7RuX5Yxk7NO6xnpWqUXm
         vnhw==
X-Forwarded-Encrypted: i=1; AJvYcCW+fL45pCIyFPiNXQoIDZrJMqjx71cCweD40QMikKd9kU3bKNEf2YGE9E4WIDTZqptwV09M4H8AWE0Snvq9ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnBzKC+vk7jJk8ouvKdWoGZflOOY/VAuvLL3NKfQgkX5aTjfS
	CGj1L+CPvW6uHlVeFpFGgfH0NArmPhejloQbMF/fvjgeshFrdn05D/iuItU3lw==
X-Gm-Gg: AY/fxX7xb3TCYuz2jq/5uUWIU3Q4LXKbYfsV6E9FY1dER9m9Tzn8K2AagQpzXMgiVbc
	usB++m8AyAVu9X+At3/YvLULoGir0nEIJcwyiKccIQOtuyzq83UdW8iHHqtJUQ96PYj4ox4TKPA
	7+WGevA0ZsQVHZ9A+7LT7fy6dgsupQY8M8fxll1GY6icFtxhsv+P2Ag+Dff2DcWIV3FGizgz9fb
	KOhM9Qrq3z3KvhOyJ7uunItkS3H12w+1E08V42Apg05Wa8U8pAzfoR/lSW+wXb4lWS16srWppYw
	xjok67qg/3EyMBpnBSO6dkqWdnZ7fSkGX0wpKDriVw8+T4cK0WI2wnCsuI00PX/RCJQzpytu6Ja
	hQdFgvW7BtPsuaDFxy3VXCaqVUYlvgbTJdHjY31sZljmsSeEXNmXNwFbUTLvAVWRLe1bhwJTDBZ
	aVz5YGlZG9Gf0cYS/1nv5zw+rhp4wAyiqqMmECGadP9NbvPpMfq0LRBhXpZ4LyjzeiHvbPxCwXY
	rcVm2AXuetnNJjg3nrqya79eswGffs=
X-Received: by 2002:a05:6870:e194:b0:3e8:9b25:2fc4 with SMTP id 586e51a60fabf-40406f33962mr3217936fac.7.1768452240100;
        Wed, 14 Jan 2026 20:44:00 -0800 (PST)
Received: from nukework.gtech (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4043b1b0116sm82362fac.12.2026.01.14.20.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 20:43:58 -0800 (PST)
From: "Alex G." <mr.nuke.me@gmail.com>
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
 jjohnson@kernel.org, ath11k@lists.infradead.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: baochen.qiang@oss.qualcomm.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params
Date: Wed, 14 Jan 2026 22:43:56 -0600
Message-ID: <6267675.44csPzL39Z@nukework.gtech>
In-Reply-To: <89a61ef1-3e83-4303-ba04-cf5c5a4aae56@oss.qualcomm.com>
References:
 <20251228151408.2116108-1-mr.nuke.me@gmail.com>
 <5896283.e9J7NaK4W3@nukework.gtech>
 <89a61ef1-3e83-4303-ba04-cf5c5a4aae56@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, January 14, 2026 3:59:09 PM CST Jeff Johnson wrote:
> On 1/14/2026 1:29 PM, Alex G. wrote:
> > On Wednesday, January 14, 2026 11:24:19 AM CST Jeff Johnson wrote:
> >> On 1/12/2026 11:00 PM, Vasanthakumar Thiagarajan wrote:
> >>> On 12/28/2025 8:44 PM, Alexandru Gagniuc wrote:
> >>>> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
> >>>> is initialized in, core.c, a different file than the array. This
> >>>> spaghetti-like relation is fragile and not obvious. Accidentally
> >>>> setting ".max_tx_ring" too high leads to a hard to track out-of-
> >>>> bounds access and memory corruption.
> >>>> 
> >>>> There is a small ambiguity on the meaning of "max_tx_ring":
> >>>>   - The highest ring, max=3 implies there are 4 rings (0, 1, 2, 3)
> >>>>   - The highest number to use for array indexing (there are 3 rings)
> >>>> 
> >>>> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
> >>>> ".tcl2wbm_rbm_map", and name it "num_tx_rings". Use ARRAY_SIZE()
> >>>> instead of #defines to initialize the length field.
> >>>> 
> >>>> The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its map,
> >>>> so use a constant to express the correct value. Add a static_assert()
> >>>> to fail compilation if the constant is accidentally set too high.
> >>> 
> >>> Text related to static_assert to be removed accordingly.
> > 
> > Hi Jeff,
> > 
> >> I removed the last sentence in 'pending', please check:
> >> 
> >> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pen
> >> din g&id=26bb149b5e011b0f73f7b74421589cbd38e3304b
> > 
> > Re-reading the commit message, I think it makes sense to also remove the
> > sentence "The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than
> > its
> > map, so use a constant to express the correct value.". Do you think it's
> > worth submitting a v4 with this minor change?
> > 
> > Alex
> 
> No need to submit a v4. I can make that change in 'pending'

Thank you!

> /jeff





