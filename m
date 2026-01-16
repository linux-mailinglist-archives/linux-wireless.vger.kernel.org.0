Return-Path: <linux-wireless+bounces-30896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B9D2BFC4
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 06:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BDE7300DB07
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 05:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31459343207;
	Fri, 16 Jan 2026 05:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="w93NqWyP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF522C0268
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 05:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768541525; cv=none; b=tLYThy6IVvUOstIGEa77jA836Hxhhdi1yPCdmAlB/LGJrAhc3GufcNXwxfPNeckYsgQwkcxNsszRaWP7LTYHJhf2iRvWJ4ExZUuBdk0zk0fwc4COvsQDFF11tMwT+POhlhddM1wtCJatE+7WeSgyMSuXCc2hOrbi1Thmst6XlsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768541525; c=relaxed/simple;
	bh=ku7YT9gmbBSUVCBYCdQU/tw7Ke+PZUAh8Xz0WCcBq8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqWEBvffQrBl5JAHsv0mVjlPZFEHs52RTW+S2JeMCCIpZGTbgQKpdcVjX8S4hQ/XdVMVlqwybmqaunl5ubwptzjXQSqF9qgql1PH8ANqglucipmFZh2wHhFJpIv3W2CkU8rFAjFDWRw6Tn595t5184pe1T2IsMoJVONsc092fzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=w93NqWyP; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c2dc870e194so697256a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 21:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1768541523; x=1769146323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yUam+uyFjTjIenw7xSY6wPEANUC0mRg5fzP+zuMHuJ4=;
        b=w93NqWyPIAdeakPfbyREBuASlRJOKiAKzMYLLwigPPvqVZ5oGYBYVad6n0vTK3ec5u
         S+GELHY5hYWYmkmCNH3al1Tm7xkiQRxJIlQhUyGSE5678iFYtuyiDW6XAJp6NG8H17BZ
         +gPyQvmpTKQZrUStsEhk+VCozKgyS+xK9X0WoMSmzT4/Eo5ErM7xci3/WnNHvtEyVHFs
         SMTvu4xqZ7CS+wLlMcIkqqWK6lgODD2Gd1/QlHJMizCUjNY8xOYHvdRhSgo23jV1q8Nv
         RI5CR2Oh+PHhT0MUnGoECX2k6tY6LLBi/QQ5wpmqKaSLTfEk0yeXbH174F4pJxdfN0td
         vjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768541523; x=1769146323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUam+uyFjTjIenw7xSY6wPEANUC0mRg5fzP+zuMHuJ4=;
        b=SfaZX3b6XEV68yqvB/16anLpEwYrikcVpVm3HAKdOV2GH60PRirdRlq8j2vZ2isZYw
         J52pBoSM3bwmKk6i8UyYscywvtQsFILZi7yagQXrDLJkaZlbbvE/dlftLecOuM2YMpbL
         RL+5EDfu8pNLUAHKiRhtSYrcq4WT7MnPF/6xphvKrBKUKLjL9dcDEvuJdZ+4nNmGdjO7
         gN30nX2EEWlnCPCHkogIRn5PweW6y8+s5TGKAnuty4FN0hNaJg4zDFfMsRbxGS2gJbAm
         cOhxi8IzvByBUecsoFrcnu3r0/ahoodg3GV5SJjrLiThfxNzy0JDEcolOTcwXSiT9fSq
         Sm3g==
X-Gm-Message-State: AOJu0Yw47EW/w9QO5QNS0/rD0UEjCQwHzgBepX/dkvJVVL63X5i4Ex4n
	4t2N9nCdRxJbiPTGEMzky5Xbbyr+QYr3CVdES3dFwMlozE2TZdsfbsBkSjW1HuhJIQ==
X-Gm-Gg: AY/fxX5wONjWJ9ae14xDmt/G4S9KKJDqgyA5aqKXS5AkpfFJ2oztZZYWNiI+pqIRmYO
	DUpUg4u62o5SontFnOReugWBSIUH3Tt+2PB8RhoM5ODV2mS2HGGLurBESeccLU2KQUAqL+BJhtF
	2QPoWhECNy9ALk4280EppI4l1mdamTwR29fXWywYeFklh2J4cl2YigJ+/sOt/gbZXSHDIKI0tpp
	6mcVHPKM6DXZqulnmAOKfO4/rPlbq9GY+bIX1jZ6bzjLKjeCUbj0rz2BOuQNYdmghU6BdFm1xTB
	OgmhOfkYxnYpNC7d+qCVzJDacSAVEwRX+gAUnW68NUTlw56V5GJ85+fYEW+JvUYA55Cu00PXhRw
	Ss3o8XOYMcT4X6pF3l+HTsU5FYHxRKNI7ncLV6kmcviu9l+n0yc8mdLYt0Cs0HlXLJ3bowHevZn
	tg8Byi8A2XHLWaDUix/LgI1Rk=
X-Received: by 2002:a17:90b:1c0f:b0:340:c060:4d44 with SMTP id 98e67ed59e1d1-35272edb230mr1580713a91.14.1768541522933;
        Thu, 15 Jan 2026 21:32:02 -0800 (PST)
Received: from localhost ([14.143.244.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527313c2a9sm943117a91.17.2026.01.15.21.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 21:32:02 -0800 (PST)
Date: Fri, 16 Jan 2026 11:01:59 +0530
From: Ria Thomas <ria.thomas@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com,
	arien.judge@morsemicro.com, pradeep.reddy@morsemicro.com,
	simon@morsemicro.com
Subject: Re: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add support for S1G
 Response Indication Configuration
Message-ID: <20260116053159.kvhpcp7jtrilb4ar@1207>
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
 <20251209062424.3926297-2-ria.thomas@morsemicro.com>
 <9eb13765529bac88337ab2fd1a13769fa4519f52.camel@sipsolutions.net>
 <20260109040041.tnk7e6uewo24u3tr@1207>
 <048c2715d08822d7f79b082cbe332f982d8ced61.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048c2715d08822d7f79b082cbe332f982d8ced61.camel@sipsolutions.net>

On Tue, Jan 13, 2026 at 09:50:44AM +0100, Johannes Berg wrote:
> 
> Actually, reading the spec, are you sure it's even on an *interface*
> scope? A lot of this seems to me like it should be per intended
> receiver, and you need to know its capabilities for generating the
> intended response?
> 

After reviewing the IEEE 802.11ah specification and correlating it with
the WFA HaLow certification tests, it is clear that Response Indication
is not intended to be a per-receiver or per-peer configuration.

Per IEEE Std 802.11-2024, 10.3.2.17, Response Indication is a
TXVECTOR parameter set by the transmitting MAC entity (AP or STA)
to advertise the expected response type for a specific PPDU and to
protect the corresponding response PPDU expected SIFS later. As a
TXVECTOR parameter, Response Indication is selected for each
transmission and applies at the PPDU level; it is not defined
as persistent state associated with a specific peer STA.

The selection of a Response Indication value is governed by
the established BSS context and the protocol rules defined by
the standard for when a response is expected, rather than by
any explicit per-peer Response Indication capability negotiation.

Accordingly, the implementation treats Response Indication as a
per-interface (per MAC/VIF) transmit configuration, applied when
constructing the TXVECTOR for each PPDU. Response Indication therefore
remains a local, per-transmission decision, governed by the applicable
protocol rules and operating context, rather than by persistent per-receiver
configuration.

I hope this clarifies the rationale behind the current approach.
I am happy to discuss further if there are specific scenarios you would
like to examine.

Ria

