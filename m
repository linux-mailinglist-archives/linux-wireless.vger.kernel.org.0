Return-Path: <linux-wireless+bounces-4800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F3A87D7A8
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 01:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64708282D3B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Mar 2024 00:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E15A1373;
	Sat, 16 Mar 2024 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q/XqFVJZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA4EC7
	for <linux-wireless@vger.kernel.org>; Sat, 16 Mar 2024 00:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550184; cv=none; b=W21Gxf2QvVIPeM3zx3cKVmW55BeauXQA4/mvic25++lWsN62Z3ye7Zo0Zhx72aG6scEMyPisSTl1lujdNTEtqqzidqBr2Fc+uqLk7Is9E2am3mw7axchlFD8nyA0uqTAcZaXnsc80QX3I7akPKkHqZOu47uMl6L6u8vgW/ws644=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550184; c=relaxed/simple;
	bh=G85EgciO0r4nmSjbRTtD8XIjqE1Rp5YnqXQx5v9ClDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5r1+yAC4htTlNLD4C1rk0i3ujBoRRgBBBwqMFO43LNhE0HEsjiSvkkaWWnBYGfLuXWZY6o4jNNPdM0HPuODCmYXiJf3lJErh9yNMLtNxdJokZjCCngU0JNqQ+oOYQLDwg4lZbHRsQ9c0kWQD+6NdD41/xFQuYhu0taS+rdELec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q/XqFVJZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1def59b537cso8203255ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 15 Mar 2024 17:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710550182; x=1711154982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLLMWAavvENcilhjepbChj236Q1l/3BRdqQF+Z6+ICc=;
        b=Q/XqFVJZkdHQC+WqbPGNwSCqviPSx4wrNfJHL4AH59VCPXaLxZLYoj8PP7DxH0bOot
         DiE4kiB3VCoJj/Pp9UFscau1fdxJ2iYrqma8rMaM4YAbhBiHeUIDFg3U9gFBia2oW0Z5
         NOjTAzO+TjRveQ17+dDWCODOryal/jMajHjSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710550182; x=1711154982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLLMWAavvENcilhjepbChj236Q1l/3BRdqQF+Z6+ICc=;
        b=XZwQ4eYCw60qwRdJBaSx1697JTxx0vg1HRnbyz5jtTDwwAm47Uf7r2KE14qMmW3P16
         Vt3VcY6Xa0ZlfjaItMkpqLovMlLOHMsw84vFpDgJGn2MKvUTrq8sW5cZyAuHhaQtmTY+
         7+5aOk2EvMNoq22uP4PA98fAJ6I7VDy9xzf0vpruCZ+7IuO+2zqHLS3T1pAd2T1grcwh
         pAE+I5DgIN8+O+5uEhIHwa8ZSM6ZZWBEUeQ4ZvHmAB5pieUB8mnrtFOKxxecPTfn8+nf
         cgFtvwxMB/6Z3ADonMhi0TGAcnNl1kqBQtgwjzUY53h6s0Dxr2FG/qwnUwPYBCfkgQEB
         rv4w==
X-Forwarded-Encrypted: i=1; AJvYcCU5eKchywJ8HhiPlKweu/wG1Xn2QY2mLWVW+6Kwci95/Rl11ut87Vv2OYktmn0yW7aSOQXHNG56XbON92pJARycd4yFsVAjhc/lE0PVd6o=
X-Gm-Message-State: AOJu0YzgPpaJ8tlGzRVw8P2e6T19D0Fx4oHWFaqy3tr7GHbWmSkadk25
	2hWd4GCVVgy/UUMdXCnZG1kOV2wk3PGcN2DcReFzJRhky5NAHgGc9jFu/Bp4qQ==
X-Google-Smtp-Source: AGHT+IF49s3BVLjwTtIqW/ZinzEWsq+sR3dtAHnTmciy4asa47AzJHmA7FbMbWEg7vNUNVjSKMkz1w==
X-Received: by 2002:a17:902:efce:b0:1de:e4bd:73fc with SMTP id ja14-20020a170902efce00b001dee4bd73fcmr3808885plb.24.1710550182376;
        Fri, 15 Mar 2024 17:49:42 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:39af:f807:ea8f:1b15])
        by smtp.gmail.com with UTF8SMTPSA id ky6-20020a170902f98600b001dcfbbb1ddesm4521261plb.7.2024.03.15.17.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 17:49:42 -0700 (PDT)
Date: Fri, 15 Mar 2024 17:49:41 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: kvalo@kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	tsung-hsien.hsieh@nxp.com, rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <ZfTspRKFgrO9xCTH@google.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315094927.GA6624@francesco-nb>

+ Johannes

On Fri, Mar 15, 2024 at 10:49:27AM +0100, Francesco Dolcini wrote:
> Hello Brian (and Kalle),
> 
> On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> > This series add host based MLME support to the mwifiex driver, this
> > enables WPA3 support in both client and AP mode.
> 
> What's your plan for this series? I know you raised some concern when
> this started months ago and I'd love to know if there is something that
> would need to be addressed to move forward here.

Now that I've looked a bit closer today: I'm realizing this may(?) be
one of the first "full MAC" drivers trying to implement its own MLME --
or at least, the auth/assoc bits. I wouldn't really consider myself an
expert on the core wireless APIs here, so this might be an area that
could warrant some extra look from Kalle and/or Johannes too.

Brian

