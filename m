Return-Path: <linux-wireless+bounces-15417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCB39CFF3E
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 15:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05E62842FC
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 14:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED30F507;
	Sat, 16 Nov 2024 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8WFeiLz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A75C96;
	Sat, 16 Nov 2024 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731767290; cv=none; b=IBSuLZjRWsG60mhRFoATqqdYKBbUolmIEPWmYwpHtzyVUcfHlkFs9JgCWAGZMBWV+fGGTTf//ugrzxLUR273tu49+DUYUWL+K0KS5K0632RTJ68rrLm39c1IHvjoVgpk2O7wdD924n9teGnf2Xxtw6TX1iLnBxE0MvoTBgj1DqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731767290; c=relaxed/simple;
	bh=/+BRHFKtDv5OOism7HoKo3mEcQ5eSgwW2lahIdxhs3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKIGFV3bxBHrBpKKtY+Nhj+gUWEtMGfMgjK8uYAqAPEljcAY2/haQQ6ikSA7m5lQxuX7fYlMtxVRq+veIUIZZ3QaAXnskd3tTwpGEk6EzjhS4P2qIVknUlEwRW77R5Dm62sK0c82fNBiCnLlc8AQgF2yTBhPyli1OVvkfxkjAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8WFeiLz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c805a0753so27111925ad.0;
        Sat, 16 Nov 2024 06:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731767288; x=1732372088; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6raVG2PvM5oLKZI+o1c1xQV1UUm9z+1CyTiZkqupZ5U=;
        b=B8WFeiLzVAFnvgw53SVK3mXRRbN3z80eFp+/a2Levj2SrJb95YDj2B8jGjEFgArXTX
         oqikPvJFJ5Sx2l3Gr2Vq6yZ7q8FdR1tthPuGaxernotBlrmzhVTkgpZSaQX0h3a/2zNI
         q1YPaUHU5b2Kyb8Wi/tK/7CV9m3tDMjoKhUeG8pJirP68uU9Ee8Zj4ErKTVEc3X64HI2
         gD8lb2BlWR312x2YfWtUnkdpxFsR1bu6udSZTKnSYYFWEKSzxwVDv3jtSyLrPmaOmRDZ
         cEVoJD1Ty+AnlT3E3qPb3BwiI1A4HhoxPeaTAHvA/n83uEIK86YRhUuoOnF5wL9/n24Q
         FvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731767288; x=1732372088;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6raVG2PvM5oLKZI+o1c1xQV1UUm9z+1CyTiZkqupZ5U=;
        b=ggz9PXN/mAM578vSzshdLGVyLY/0V4AKuxQf+a4OGZyF/2hmxQhvjA6fHcz/2VjRHO
         /Vmawo+n+0sCQNXaqe4itKzymON2hqh1SDz+uMu3+rZYu7LHbitCLGpFRtW5G4hZtnXb
         JdlOcSx6Zxo0//QEuoetBO3oWbTo5bnd43kvHd+NuaFO/9txSneXvhyErv/zsj8mRQLD
         Cj4+apCMl2Otp37BY9KVapZpncoTL6Kzpihm9IiRDIXloTVubbGgtFrBXRT04iEJqqmx
         KhOcio/AOBIfAH3TTb29Xtpb1H0OZ7dr3rh6TPlKLVppPYU9bbS/QJc7p1bqGiQWRMKV
         JV2w==
X-Forwarded-Encrypted: i=1; AJvYcCUL6vQ/hTaAbwcvyA6hatggiicr39Bc7W5phcyS5Bv4DeCTlba890cx5KqHhXzuypVry1nojA6sB74oPdp2l3bk@vger.kernel.org, AJvYcCXCV5iFjoP47+FZeO9kFhrFomBPw8kJhQjm4tNT/BnyIamO46fTp2lj9taNqwQpzxw1HQaoYhSf@vger.kernel.org, AJvYcCXddEOf3tJfj+jHI73h35VsGRF1XKVz/rH5yO+SAOKX+x9jHGqsG+QRzcV6GnP2vO2wXB1E01KhEwFj5jy2Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkdcVi1WVMajyEQWooPNwsvul/eXYqhSZR7I5ZMRlFVQXp8j0R
	VNMUibY99RsFD1Yo7gS2yCB3IaXN/hIW65vHihrr8x9/+5QmPSDD
X-Google-Smtp-Source: AGHT+IEZwHw2wToo5anBV/zM0NtW9PAvoZG8HT9AVZD2y3uvmuv1B88Z4M0nJ0KNaPpXvpjqAmQN6A==
X-Received: by 2002:a17:903:944:b0:211:e9c0:31c6 with SMTP id d9443c01a7336-211e9c0344fmr48014405ad.12.1731767287791;
        Sat, 16 Nov 2024 06:28:07 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec7b9csm28436735ad.73.2024.11.16.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 06:28:07 -0800 (PST)
Date: Sat, 16 Nov 2024 06:28:04 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, pablo@netfilter.org, linux@armlinux.org.uk,
	johannes@sipsolutions.net, loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com, dsahern@kernel.org, wintera@linux.ibm.com,
	hawk@kernel.org, ilias.apalodimas@linaro.org, jhs@mojatatu.com,
	jiri@resnulli.us, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, netfilter-devel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next] net: reformat kdoc return statements
Message-ID: <Zzir9EH83f2jRgQU@hoboy.vegasvil.org>
References: <20241115163612.904906-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115163612.904906-1-kuba@kernel.org>

On Fri, Nov 15, 2024 at 08:36:12AM -0800, Jakub Kicinski wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>  * Return some value
> or
>  * Returns some value
> 
> Having the colon makes some sense, it should help kdoc parser avoid
> false positives. So add them. This is mostly done with a sed script,
> and removing the unnecessary cases (mostly the comments which aren't
> kdoc).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> LMK if I should have split this into smaller chunks, I don't really
> expect much review here, TBH.
> ---
> CC: pablo@netfilter.org
> CC: linux@armlinux.org.uk
> CC: richardcochran@gmail.com

Acked-by: Richard Cochran <richardcochran@gmail.com>

