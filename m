Return-Path: <linux-wireless+bounces-30832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A67D21577
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 22:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A9DA30086F5
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 21:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9821308F28;
	Wed, 14 Jan 2026 21:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="We5RIyOx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7482A285041
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768426198; cv=none; b=lFu6rH6zNG6Y7xZ5DwFeJi/4Iqiy1Kc+VwU5dsID5Z5U2dy071hOwVb/0O61IdQy4AEPTGFXI4rjrpNLgy7H57X1LMIZeDhjIqa2XSoMPyjYMSxeCDYVPo+sMErrchsqO2SDc+cMW1J9583UKTaq9n5rWPNenVHnSB9e4oqZVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768426198; c=relaxed/simple;
	bh=yFwvgYlgUWobYU83a02w2lNuzCm7Px3oSpH/3n3nv0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmQnVoWrxcXPU49P/y8AK/zXE1fFpjCz8hUsDpJTonlmHyolO6KTPz2uPwZHY9oM//KZ6uLOcmVr/hF+oC9NhR5qjSLrzlklPLnHmhMMUtx936sl+v8GBe2JKl/Wnj+Ka94A3faVLL6srVYi2TzaCJeX8P4S0NS13eFwDJsWy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=We5RIyOx; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cdd651c884so165358a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768426196; x=1769030996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Pcz4WIDueT+6V6+NVL3CX0OqluBuGMzBiT0dhMMZoM=;
        b=We5RIyOxm0JZM9feRXt4Zd7HQz5bvy4n9I+RSPJQxzh5PPce3WHzsCo37gMqBFVTfo
         si8qtXvaI90b+IHs4SvEbVH8ZrizbcbqVkt5QsmIp9DvNW4CEIXJs1QCuzihzUUkpri3
         zsxC0pA2OsCzYWBOh+Z83yeSQDLDXufqmtNh87TZhktQz5f9JdeYKZKpR3q7WtdBvfJ3
         ARVsSo31HgsoEQFNU9HkWvz4GQgDsOfnczcthLBafnawCE2qFzNHfWlH+hQfuG2qMcKu
         U+e4issQd4vybL5LFhpx9F+hELCA2TiScwIMRG3AbVsyRL3DXfTGESiqQra1vB9kocNt
         cppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768426196; x=1769030996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1Pcz4WIDueT+6V6+NVL3CX0OqluBuGMzBiT0dhMMZoM=;
        b=SWtEveNysdOkFgUM/v+CHWLYQtgSicIjnTakZJOoYpR7vb49v5bITZ8zUQ7+bbKKWL
         UJ/6Bv6IHj95ETRdscrwtfthBTYSJwT1UR8hEv4ZGDKOhpUb8qpKOdrIUV7+7lggStoB
         VmMtXTFcmrUdpXM3S890bpLq6z71eTaiEU2Z3/1KDGL+BJ8B/eKKlyZ3+WSJM1WHFgYu
         0G2NwLV0pGsymYSLx7AEaCDEBfaXU1boXFs71BOzkC3MRMpMyRnjeNpqeUkjYYC625fM
         b+12XyJnXLxCO0HvQIbYMF6YYKn1Eh0mUv7OkuIlRD4n1Ywe582h8mKw6nTNde9ivY5+
         gJsg==
X-Forwarded-Encrypted: i=1; AJvYcCXrVy+ZLtDe2RrKZuLmE7rNCcBqg7dvFKbbsARGHQd1xoSlER/iOTg7qW1QA4YFv7vawoLZAiVzM6r4oxBANA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLDXsAAzdrZTAzkbgSQGI8vJexKR5SNOGJ/syP74cQQq91Q9s4
	h42TDwxuxERlS5C65JkEeXF7V7QesKg1N/sfddsNEzu6oS2lD8WMlcc+
X-Gm-Gg: AY/fxX5xQZ59vKqmh41rbJKD+/2guhfspG13e4VyWyZjfQMnZkCIZF99LCrXVcbGNQm
	zm1FtFM/dKfHPguULza+SoI+GumKm6NAx+xofmUB2/iB18x1qkcoiaiUUtClEWh4dEVo4TqPzrl
	WJkP3pQbVuAFrv9VGmMlSbxmfTEy+Y5KLsoQ0MRDE7KH1VEtoSw1rEaxSHvXfh8FuIPmsFY5sOh
	ohIh+Z0GZiasFOq8cDkjFi5ezYMIRFMc6B9Pw0MHF263jk0NwsUturtDJ8kyjo7dc+LoIv5llIT
	XbBXU/mqQns/WygiqWZBQ8O3B0qw03mQhrCSgNG/8FxL1L3w0ZVsKD/WbFwhhfSwbeiEG1wGlhn
	BLFHWZ0RYnmsRnu4z/T8M/MiTI6l4wbkrNc0K0vodKb9EAWmfMSSXEzH734o6JPHifgzp3utWoS
	EL/C9W9dqxNVCurlDTzOX9C3yoxj9j1Z8Xj3MAocAuPUXvV1EMbqrFKpf7DDzR5+jih/xob6hmN
	TMhiALNF1vLdiIeMhGaLIFzjZCYfMY=
X-Received: by 2002:a9d:7758:0:b0:7cf:cbff:85e6 with SMTP id 46e09a7af769-7cfd467608fmr502626a34.12.1768426196311;
        Wed, 14 Jan 2026 13:29:56 -0800 (PST)
Received: from nukework.gtech (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af494sm18524978a34.17.2026.01.14.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:29:54 -0800 (PST)
From: "Alex G." <mr.nuke.me@gmail.com>
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
 jjohnson@kernel.org, ath11k@lists.infradead.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: baochen.qiang@oss.qualcomm.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params
Date: Wed, 14 Jan 2026 15:29:53 -0600
Message-ID: <5896283.e9J7NaK4W3@nukework.gtech>
In-Reply-To: <c8456b52-f14c-4bcf-9385-580e9607219d@oss.qualcomm.com>
References:
 <20251228151408.2116108-1-mr.nuke.me@gmail.com>
 <56c6471b-c878-4afd-8e8e-d56266ca9c64@oss.qualcomm.com>
 <c8456b52-f14c-4bcf-9385-580e9607219d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, January 14, 2026 11:24:19 AM CST Jeff Johnson wrote:
> On 1/12/2026 11:00 PM, Vasanthakumar Thiagarajan wrote:
> > On 12/28/2025 8:44 PM, Alexandru Gagniuc wrote:
> >> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
> >> is initialized in, core.c, a different file than the array. This
> >> spaghetti-like relation is fragile and not obvious. Accidentally
> >> setting ".max_tx_ring" too high leads to a hard to track out-of-
> >> bounds access and memory corruption.
> >> 
> >> There is a small ambiguity on the meaning of "max_tx_ring":
> >>   - The highest ring, max=3 implies there are 4 rings (0, 1, 2, 3)
> >>   - The highest number to use for array indexing (there are 3 rings)
> >> 
> >> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
> >> ".tcl2wbm_rbm_map", and name it "num_tx_rings". Use ARRAY_SIZE()
> >> instead of #defines to initialize the length field.
> >> 
> >> The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its map,
> >> so use a constant to express the correct value. Add a static_assert()
> >> to fail compilation if the constant is accidentally set too high.
> > 
> > Text related to static_assert to be removed accordingly.
>
Hi Jeff,

> I removed the last sentence in 'pending', please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pendin
> g&id=26bb149b5e011b0f73f7b74421589cbd38e3304b

Re-reading the commit message, I think it makes sense to also remove the 
sentence "The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its 
map, so use a constant to express the correct value.". Do you think it's worth 
submitting a v4 with this minor change?

Alex

> >> The intent is to make the code easier to understand rather than fix
> >> an existing bug.
> >> 
> >> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> > 
> > With the above minor comment addressed.
> > 
> > Reviewed-by: Vasanthakumar Thiagarajan
> > <vasanthakumar.thiagarajan@oss.qualcomm.com>





