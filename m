Return-Path: <linux-wireless+bounces-19735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D190A4D12D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 02:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795FE174024
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 01:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20738FAD;
	Tue,  4 Mar 2025 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nlG5pdNz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF71BF37
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 01:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052713; cv=none; b=R8axb7Hn77I74qoujtBIrYPWzxeffQx1Y2Lzul8TQ5FDSX+JSi2nB7QjjihFhBa53YF5uGfl/8aH0GKwwR9oAsD3sbg2kRVaGXru7XZgrL2U83Zu6Z5m9wQnQjZw6XUiUnxGnmlYb5o8pHB5P/MPwSRxQYKhQykuBDQylRUE/50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052713; c=relaxed/simple;
	bh=1hbBKhKn+M9MITSVZz04JZt4RK2NO2PHHwHQXMnuHws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKsJH2U3IQEIi3HTcJHSJV4SyBJxKRS9WxGk39JpKYYXlSw4F0WyKgsz42rXTSAINoxK2YjpQDjKGlt4k5coQeGB4Wt/l/3oH9WHF07YmfMof43Y775W1/C9QaOfVVvy3ZFYgi05KOi+KLPlIVbbVlD6P6d9ujg0P3KXLT85qQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nlG5pdNz; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2232b12cd36so68562375ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Mar 2025 17:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741052711; x=1741657511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9GZZp8+oIePiapzrIPxDWnNkQ4bhl4hE+C4f4poaQfU=;
        b=nlG5pdNz/6nXQ0DxRhf1WxmJWqGTcYnAY4dnOScJXBStiJwfmFF4vOUTmaG5jyfJTf
         oQ8w6zFwFubsRQ5ByhC7NJvOugh81dgXvgMpDrdxLGauMdx7fY8ZEimt+iP4/qK9hXp/
         OSjUAkhwc4bKA1mLD1xh3w17SguoTxXoGIAec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741052711; x=1741657511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GZZp8+oIePiapzrIPxDWnNkQ4bhl4hE+C4f4poaQfU=;
        b=f1qSxH+r84ukvO1eXzdmeU58s5G3AZLiyrdR0ytmzpPWTvUyCp95uDFLWXAqxNC7ub
         zd9Dof68PbkHBXu3IxJiqC4zwPynaevX18NZBnnD/cQvbeSah7FdayCnlWBxupklnwB9
         kNiV01frZFux8B04Qf5XAjU85u00z/x/dA6Igznd13BKGmupgV5njeET5Xg21dBkHfQz
         /54VB+Iy+KkAqrd5S5CtPB5pSaR054w2T/IuhV3Q5X/KxTX1jfhfseS6WgAIYtFi/Syo
         XNr9DKeA4gicDbsJPVmmvSYugoZHdx35xhy8QVngeFq1+IW4liHWoiFuH2olr/jZh1Z9
         z5PA==
X-Gm-Message-State: AOJu0Yzl2f8TPLbe2rytjTKpotH8yN0US9mPNKW9LZli1Fw5bDhqyh80
	xZXLcM8kkeossjep/i3m6raZv+0U/7gkC9tFjc5itLyZA+1ks04xnb6zVQkACw==
X-Gm-Gg: ASbGncv0DyzyvGOR7x6UDU75l7kiLT4pbLlxga+0uvx/OOUm56z74B7SIjd+tsk7XyY
	1yjTx0esOrRanUjMZfQOqFjV1lxfk9nW1xnUi51p/zLKeik4hgwD1W+60/MZR77KY1Swjd+M6uE
	4KAAROe7vKTFn9EXeICTDz+qsPJMyLBljcuvpYzBbOIdtKeauTvtCHV4YqomerCvS+k6RRgHU8R
	NFPcjfDiHc5aVq040aASEHv63rZHX65Ya1fSbpYIR2TUE+B52/Nd5tnWOgi+8MPUZyrkabc31O7
	CGJyPx5MSxSvtcKFc/KK3nfyOCjz4MQ3Y+XXvaukn/Qn2NKwHc41TgPYiarn4PV/MYva2/kbvS6
	LPFvqSYQ=
X-Google-Smtp-Source: AGHT+IFBjz9u5c57YZEu8MeorcMPm6BUOCBh4Jp5gkOE1eMd5wHIrbNEkucTTNlGtQhtOGq45+KIJg==
X-Received: by 2002:a05:6a20:12c8:b0:1ee:c598:7a96 with SMTP id adf61e73a8af0-1f2f4cc0cafmr27333210637.16.1741052711321;
        Mon, 03 Mar 2025 17:45:11 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:1058:3168:66a5:183a])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aee7dcb4611sm8948428a12.0.2025.03.03.17.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 17:45:10 -0800 (PST)
Date: Mon, 3 Mar 2025 17:45:09 -0800
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>, kernel@pengutronix.de
Subject: Re: Future of mwifiex driver
Message-ID: <Z8ZbJYmxgnvd7Q1O@google.com>
References: <Z8WM9jn1QFscWZBQ@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8WM9jn1QFscWZBQ@pengutronix.de>

Hi Sascha,

On Mon, Mar 03, 2025 at 12:05:26PM +0100, Sascha Hauer wrote:
> I am worried about the future of the mwifiex driver. NXP has an ongoing
> effort of forking the driver to support their new chips, but the forked
> driver lacks support for the old chips supported by the current mwifiex
> driver.
[...] 
> I have a series here [1] doing some cleanup work which I'd still like to
> get forward.
[...]
> [1] https://lore.kernel.org/linux-wireless/87ldwyumvq.fsf@kernel.org/

I'll apologize for that one stalling out a bit. IIRC, 11 of 12 patches
looked great, but I got stuck on the "fix MAC address handling" patch,
because it's a lot tougher to guarantee it doesn't break some use cases
while fixing things. But really, it's probably mostly a bandwidth thing
for me, as I really don't have many cycles to spend on things (and
especially when it gets beyond "obvious cleanup" and requires
substantial testing and/or reasoning).

> Any thoughts?

In no particular order:

1. even if NXP (or you, or anyone) does great work, I'm not going to be
   a super helpful maintainer. I simply don't have time to review and
   test substantial contributions.
2. I get the feeling linux-wireless may have problems like #1 in
   general. Johannes can't fill the entire gap Kalle left, for one.
   (Feel free to correct me if I'm wrong! Or if other excellent people
   have stepped up on review/maintenance.)
3. Other drivers may look somewhat similar, and yet fork for good
   reasons (like, firmware API revisions; or 802.11 generations; or some
   cross-section of both). I'm looking at rtw88/rtw89 (that I was
   involved with quite a bit), or ath10k/ath11k/ath12k/(have we made it
   to 13 yet?). So forking even with quite a bit of similarity isn't
   necessarily inherently wrong.
4. A key difference between #3 and mwifiex is, like you say, that
   mwifiex has a pretty low quality baseline. If I were maintaining it
   from the beginning, I probably wouldn't have accepted it.
5. I'm open to good people stepping up to fill in #1 -- i.e., include
   more maintainers that have a stake in larger contributions. Frankly,
   my only motivation here is to ensure that existing hardware supported
   by mwifiex doesn't get worse.

So all in all, I think I probably agree with you. But speaking openly, I
don't think I can be a large part of the solution here.

Regards,
Brian

