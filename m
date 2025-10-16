Return-Path: <linux-wireless+bounces-27995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F7BE2713
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 11:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F1388502804
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F60C3191AB;
	Thu, 16 Oct 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="AzvnOVGo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758C31A544
	for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607276; cv=none; b=eNn9nrSvEeu3/9lH3UR1NvP/tCkq3ZjHe4c3CtjIoM6SCCsDV+ukTYlOLGYPXDcYCOQvD87urjC56F97h3WODTIT6h8INFIwNs7fVOxhJ0sqYncf6F2eVUTViQ/I2DSr41gY03l9qbOLbvDQGhJhkvKghNr6W4vq2bf3/DBKf60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607276; c=relaxed/simple;
	bh=ukUP9Gub5S3CFm/7Z681FtIY90ovj4unaCC6QPHHDKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9ikd3ECFkw56rnF1et3Scr/S9oXlvC7aTJ8/9eeDw3gjqCFl9YAGr3ukkQu7QWlLYBn3GipnSpGZ/brHTItliISauyUftJP3kXFPDRsZoyhU+WGp80het1XLNEx8aGfSsoXnevPmgZk22SbWX9J7r0E+hYv2aKJH/1hNXUP654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=AzvnOVGo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811fa91774so502487b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 02:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1760607274; x=1761212074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1lXSqc6ztdc/gaHXPdaYXTLqiiANaESgHFbEEhkOO24=;
        b=AzvnOVGoQIegxe4WnXSX87wtPVs5A5NBaEPECsTpJRoTUHnYsasqeGH+Rv804qxtrY
         0+na3ZZPa72cNK870X70lPr3OzejOSF3Kz/OpvIGxlWjCOxJUgITOt1qUlJL/POL1MHD
         VmfzOcZ2YgRVeH87fsJ2UVEipRTn5SIMJXAgCtaIKi91ZZm3CE9IMoVceTVhPty2SBwA
         Os1z5Usqe4if+4kNLtIfPqNDtmuCAKu8RfeEVETk9Iq1nISJc46QLQH83aNFIe3wbXCK
         VTJeIWm76pXP7UCgRiHqGK1LVZZlM9HeigRCWBwcdzFcxdc4glZMWwlA9a/TIwDjLW5K
         8wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760607274; x=1761212074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lXSqc6ztdc/gaHXPdaYXTLqiiANaESgHFbEEhkOO24=;
        b=h/nlVw3ukpslFeR3rMMBlue17LpX+xX5NY7zMdF/kc+HeQ1vBCiOjKXM4eSw9gIHnN
         mp9pGjM2yXIerJchIlftcfO++sJ3eRfaUMyXICmMP8VggKb4RdnUeCN2018VR6FA5tZa
         hD9WnhM8jjIQaEsqqH4JvyAF57qqJZfCRxuILsjOfIKEwhNCFUnADANbZX05FhzscOP+
         9DceO4PXzVx+Ojqm7wxYhfG5MOG0Mvim43w+zRAvnFJFUWaxPdZGN14AKfBiHw/ZqgCZ
         DeWXpIqCNal+rKdntUqJNIXiaToMeuprsnXRZzSanu+/X8L6/0fVuFWtxuxoYuzR3uiD
         HtdQ==
X-Gm-Message-State: AOJu0YzO7O1wy0EsIOBm1JLkFn8OMzaOm9Xdmtog3od8uJUcDWPYJMDW
	29es3DSQKOfjD0y7CMgf7fJKyf032+fMnQ24SKEvhuU+HvuRwqrHJN1CtcxpVjmE750KarKVb1V
	zjFzyDP4=
X-Gm-Gg: ASbGnctR8+2DnWF+UE3YK5XXeYviyk43qGY0nPYV13QXLRHeeB/whG/ihiLgoLD9xSK
	HSolFqJxU2nvwyzhet/ArTzrkp+UVoXjNUrS75S/GK509s0X5gzPUbZ+98bs7IXV4WbEar7jZrv
	h8V9qSzKD1mlORTTHiC9/xrFYT9q4uCSHeKwQ9SNyQoa+qdb4f/+9Ps+OaHHOhwwEqEL41OP4W7
	vw9gHE5WKSghIQC4NyHmBqw0qLWWroHUuqhedk+UokRw0MXO70NKK0lscN5V+1sPrmw1AMcQ8+c
	Dqrv+seVl0BD4XITd91zp5257ZaiN1BdYovW/tauG43e2FwTkNlr6smHr7D2J45X/ctIgXKRnr/
	RGMVi6C1lzmb3V7nfyixf4gJiifIBsmTmDD4oIuBWbBGXkyVYFOXKnMc114HftHoLZT3wn71M8P
	rp21JSsbiq7qlP4SVs2w==
X-Google-Smtp-Source: AGHT+IF0uqg1OehBE+UGEzYh27PaO9U8LZjXW4AlrD9RNfWJYWCT5fbF6mgFS7fXtrIuzqsarQBf4w==
X-Received: by 2002:a05:6a20:9787:b0:334:988d:a9a1 with SMTP id adf61e73a8af0-334988dadd9mr2644842637.16.1760607273861;
        Thu, 16 Oct 2025 02:34:33 -0700 (PDT)
Received: from localhost ([1.145.24.210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22b7866csm2181126a12.19.2025.10.16.02.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:34:33 -0700 (PDT)
Date: Thu, 16 Oct 2025 20:34:30 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: update S1G channel
 list
Message-ID: <ir77qmw6omyeh3gy5xphdexdioicval66ps7twovjcyzdxju4q@ijcoeappjknj>
References: <20251008013903.219169-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008013903.219169-1-lachlan.hodges@morsemicro.com>

On Wed, Oct 08, 2025 at 12:39:03PM +1100, Lachlan Hodges wrote:
> Update the mac80211_hwsim channel list to represent what cfg80211
> expects drivers to advertise, that being 1MHz primary channels.

Hi,

Please decline / defer this for now.. I have found the recent S1G channel
changes _may_ require some more work / refactoring so lets keep hwsim as is
for now.

lachlan 

