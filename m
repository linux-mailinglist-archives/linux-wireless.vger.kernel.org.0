Return-Path: <linux-wireless+bounces-37288-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPisLxh7HmrejQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37288-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:41:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 406146291CD
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 08:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01E3D3010251
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 06:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131B52EAD1B;
	Tue,  2 Jun 2026 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="KgJgyzOk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7725B093
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780382426; cv=none; b=tSx1XS0ksuTE4AQFJFbqKv04WyFTtF6hmCa3ErMsDGr6p600V4rixmEPR/rF05azSQSmktue+cR3F7usZeUA8CDYxOtZMBF2SZSWlBwixTdSuLORd2JIuYuq6L7X7TWqNxxoLpwNx6HoDRCsmNvMhiTcoWIs4TL7CA1EoQ/GEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780382426; c=relaxed/simple;
	bh=BAFkEt6Pb8vA6iN2+j3tlYBbM+zoS1nBQuyLpLw5Ubg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUTJ5hwDJKsgMBCN1zqMenEQrfx7Im40IfaGBuca3WSnzNU7wu5oV7eDQn/jykACqZ29ROBZNOUIIQd8QbCkK1X9OZ6e02bqvhI6ZEdfLLr3vceYGWNSJygk2G6UXzRgOv4sMF2S8voGFi67vtbZOGI23K33Z+mtpMvNHdcte+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=KgJgyzOk; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8423610ec93so1827084b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780382424; x=1780987224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXuAh7KNgK/+wO/AYwWBAoE77f1hNy+rNed/BxYn/LE=;
        b=KgJgyzOkYTTg6cZ2tUHAzaJIaXsPlbfe14r5nafFeaCIGvCIO6tGkYMCz+DaCiOpXy
         F9104Ou3+b2+hKXkI8B3chbG5+YYsRv2V5WBxHj9cQIgtLBt84k6rDxWlvHF+vDVonZh
         MYV3EESsgx0sJDZnBh1TBosPYjNNNITVOzchf5y83W0dJ47WJ+jTgiWDglb5GBkRLFjc
         MQsxaFGs2Nmzo/juoao4WgZ97EB2A0eooGWJgJjA4KcIC2TWOwFYMiJWvnKD8XDSaIjc
         eUd+/d2Bxhxb+IgOr3/CqeTMvIPpwG3zrNGWVXgVWL6F1QbkgQi+TFdI2MCRlR9rg+AX
         Ar/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780382424; x=1780987224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eXuAh7KNgK/+wO/AYwWBAoE77f1hNy+rNed/BxYn/LE=;
        b=U4a4ULxMjQ+M+mS/TAgDt+ogDeDt9DUzy2TVcShfR6aF3MWRBUFg0ulCB+znt4qIS/
         xMvxSBNj8mO7UhO4FqPBX5zya4E7g6LP/Rcji9BgRkxjG88rBiqa18axl6SJhIHcJbaX
         tISyGtfrWl0YMkCnsUORRCAjKDFSiuBJXG3UAiwLdj+ZXQh+LGpFCYTflvqujbPQPYCQ
         Rl9G/BKj5v21yCgtDJWvkflZP3BKblkJ8M1J+JeKhwxYqJRSDmqA+CHX5P/5s0O36L32
         pBdtH3GvklANoOfPF3l1R0+carPhOYD/LdE9RQXQO8Pi11mVz81egvI5jCu4OCzAN4oD
         MUjw==
X-Gm-Message-State: AOJu0YyY7BhXgYFUPlJ164HwTaK+pkbfQIH6RvS6SV7wbr+DIfeXgb3o
	taxKboGEKsOO46qJbgMYN8qkRz9QwkGDQASLxjgi9nw2inXJG4tiSanXyfsK5IcoFuY=
X-Gm-Gg: Acq92OErKn1W4zgO+uepAwWLmg5Qs8SZLWmyr9z5ncprLyC/nwBEutXH2hsKBl5h+KT
	n/lYbVvmrrdouTk4NGIkhbAcALN9k769of/9vpaqaEA5OPNs2xmYNJjPwO57Sr8oAtz2YTCfhxJ
	9I71aPLc7uRGaQ9uV0DymGy/or21sSqGv698yaulDALlrdnqKkebbexizO3n8peRb/SdMBdiOT0
	lKpGRMyxNBPBjl1RVpAPTLCVlVRLrh9ZoMkfj3mBCNqQ9nUq9nEwsZjiVe0ywbv9UNkjaBsS1FL
	htcpi3PtHy8KSM9CbwR5e2HLVmbgq5QKMB/lTTZIstnV1bSB0lKruGaaa4QOIv6WVXGhWB2aYAF
	CiHtE69Mvou47lBRDejSs5WkCkbGzCRtqgCEE6i4PezTbC2w4TIZ5wTB+33Q7uaM/PWRTrRLye5
	JJhffElt4THPufAVgLAjRFJi7B6sj/m7qGrGUYsQ2dkduteTklGb/Tr5Hsyog5kEfUw59bwwNQY
	XM=
X-Received: by 2002:a05:6a00:23ca:b0:842:55b6:f5a1 with SMTP id d2e1a72fcca58-84255b6f93dmr7231018b3a.6.1780382423919;
        Mon, 01 Jun 2026 23:40:23 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214affe1dsm12004492b3a.1.2026.06.01.23.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 23:40:23 -0700 (PDT)
Date: Tue, 2 Jun 2026 16:40:20 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: mac80211: basic S1G rx rate
 reporting support
Message-ID: <y37p2nq34u2nqtmwr7d2fxujqkc7snbpgpedcwhqp2aee6okzs@6fofx7mozmrm>
References: <20260602062224.1792985-1-lachlan.hodges@morsemicro.com>
 <2enlvwdxco5ezmpfosvvp3frreharqiiuspf67veztsmjwfcbd@rk3ej7yh4wow>
 <d6e543046d8b2ba7e681c137a23a55a21f4d19e0.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6e543046d8b2ba7e681c137a23a55a21f4d19e0.camel@sipsolutions.net>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37288-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 406146291CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jun 02, 2026 at 08:37:48AM +0200, Johannes Berg wrote:
> On Tue, 2026-06-02 at 16:32 +1000, Lachlan Hodges wrote:
> > On Tue, Jun 02, 2026 at 04:22:24PM +1000, Lachlan Hodges wrote:
> > > Introduce basic rate encoding/decoding for S1G stas such that the
> > > usermode rx reporting is relevant as it currently uses VHT calculations
> > > which are obviously wildy different to S1G. Sample iw output (with the
> > > associated iw patches applied):
> > 
> > Johannes, there are obviously some driver changes associated with
> > this - I'm not sure if you prefer these to be included in the v3
> > since I have to fix some things anyway or scope v3 just to review/bot
> > fixes and then send a subsequent pull request once it is in tree. I do
> > not really mind.
> 
> Unfortunately, given demands on my time, I don't think I'll be able to
> merge the driver for 7.2 since that'd have to happen in the next week or
> so. I think it's fair to just include them in v3, ideally once this
> patch lands, maybe I'll get a chance to restore the build bot too.

That's not a problem at all and sounds good. I know the NXP driver is
also under review on top of everything else... ^.^

lachlan

