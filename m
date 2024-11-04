Return-Path: <linux-wireless+bounces-14895-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56F9BBD35
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 19:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2E22846C4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 18:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D21CACDE;
	Mon,  4 Nov 2024 18:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBWwq264"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA861C9EAF
	for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2024 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730744464; cv=none; b=fzhPG9JeeP5GcWtLtLFBp3mj6ZvCZQFAn79jTEVbHY0F9XaaHR0rHeKB9cQOpFF2CE5bGKsc+OqLTyl+MO6VIGlGNFZxTdxS76gfzndbaJKHKvCwRmoo4Yfvo+6jj5vTQ5Q/bjws+XiYAejMqGB1mAUdoJgTI7ctuqIvznleGDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730744464; c=relaxed/simple;
	bh=M6xDzNAKcs36VWJmqh7kjILMTWmZO9OGbW4mqT6HmyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANXxve2sQmLU4Jj60COSoUf2kJAZm6f/Fd1ECN28LhQuZ+59QrR2HYz5naVczhv+PfQxKZMeWuU3rociMxlWzulMvMjPsaVNxbf1yGzJp/4z4zVn72kDHK2QVN9K/poyXKTTUyj/L7pajOLOF2ye0FfEcWortLv+Oar1psi0TIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBWwq264; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431616c23b5so28076175e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2024 10:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730744461; x=1731349261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HvgKojtjxMMS6cqT1h35DY7bZCxI4idU/B1S0RQ7cd4=;
        b=kBWwq264szWaphLKiF9s/eMuSNA6tvH37jOs/B4TBl0RQzxPmKzZu4iIgfXEDqj0VA
         G/LZ0wi9JpyPtN9tIY9orcifFYVpXCs/rxRhPtGypf/CTWso/LZlpUJde/EjzZN77SKr
         qjbyewRA32ztUzEUzTMGwCj9jC7DMtvFe5bEjB9faQPrUMmcIiLWEyWae2N3tNDPUAtO
         oOXjHeUnwiUl3csBUYxMQtHTgOSKmy1eX+XwSRAbBQ3I4mZRJ7HqNryhA7fEf7lgLVtf
         Hj5q72WFEL4lhxNT+FEWJ8jdhQ8LAZ4+tBoLTyF6DHogJhlRSejlrxD7WLhykz0IScT3
         DsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730744461; x=1731349261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvgKojtjxMMS6cqT1h35DY7bZCxI4idU/B1S0RQ7cd4=;
        b=nwWQU+Tua7ogCWB8d6rA/DnphMwgZvYNSjnvdXXNVQXmBbTRZ0+vIllbCtZrAzwxjL
         4LClFxsBUPJg2UrqD5IC++Ql3A5g/DLiKT2oiynGqDCnN3ztOPo5iACVZvsNloI5Fr1k
         PI/N+ZPC77susSYfnFrDJFNOlVDrt95oC3uMHe6y0y9ZZDEPt4DQt57xDrM6oOSyjfVs
         uWqMaX1BzLLbUYJs6iN1jRvFHWtT7dc8N7dK8h69qrFAFTbgbLQQcPKXTpMHO9lIKH4i
         UDUtVgtjfFvXjXzp1sOfSxZu8BSmOOktDL0WZwfxWH8UPDhOe/R2jRQp8Eb5Rx8vh7Gk
         3kVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMzxYPFeT7dDdVwbuCEL6qYhnCcQ/96H1CmRpovT21iQvjfVCuEhpSJUQsRDXaSeAtpEebnp6ovVLUjJNAdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrBV02m2jX0kGcjTFUQJB8rFev9MEoq50Cxj5ezCCJd6OMdy0N
	yChCtd/1P/VEEKEM5X/GrqpqU5JyeaMJXA6/uG3+qzF//dEEt7Rao0BIL754lA==
X-Google-Smtp-Source: AGHT+IGCf2kXxmfohJmBXmuH3j8pJHDrbqFMRzviLHJM7ILP9HJYPdAB1K5kN0pfn2Myr89luXLdlQ==
X-Received: by 2002:a05:600c:4449:b0:42c:ae4e:a96c with SMTP id 5b1f17b1804b1-4327dac7732mr131855855e9.16.1730744460604;
        Mon, 04 Nov 2024 10:21:00 -0800 (PST)
Received: from localhost (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7e2dsm13835508f8f.11.2024.11.04.10.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:21:00 -0800 (PST)
Date: Mon, 4 Nov 2024 18:20:57 +0000
From: Aleksei Vetrov <vvvvvv@google.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] wifi: nl80211: fix bounds checker error in
 nl80211_parse_sched_scan
Message-ID: <ZykQiY0jvxKqrCIb@google.com>
References: <20241029-nl80211_parse_sched_scan-bounds-checker-fix-v2-1-c804b787341f@google.com>
 <0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bc2e4b0-4dad-4341-a41e-a98fbc4b1658@quicinc.com>

On Mon, Nov 04, 2024 at 09:12:09AM -0800, Jeff Johnson wrote:
> Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> And it is exactly this kind of issue why I'm not accepting any __counted_by()
> changes in ath.git without actually testing the code that is modified.

However, I was really lucky that my setup used nl80211_parse_sched_scan
during normal operations and triggered bound sanitizer. After the patch
was developed, I accidently wiped my device and couldn't reproduce the
bug again normally, so I had to use iw tool to trigger
nl80211_parse_sched_scan manually to test it properly.

I looked for some tests that cover this function and that I can run on
the device, but couldn't find any. It would be nice if you know about
such tests, so I can check if there are any other places where bound
sanitizer may be triggered. I only know syzkaller tool that may be used
to get more kernel coverage in general.

Best regards,
--
Aleksei Vetrov

