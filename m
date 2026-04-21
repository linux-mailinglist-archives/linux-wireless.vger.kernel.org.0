Return-Path: <linux-wireless+bounces-35196-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MVJAWEJ6Gn2EQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35196-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:33:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419744097F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 01:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CAE3307035D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 23:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BAE35DA5B;
	Tue, 21 Apr 2026 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P4xPn4Dk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DD4A23
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 23:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776814259; cv=none; b=LwuC08bCpJIWOCLEJgzL29nKHoVQXnrmbu6m8LLR8TD6uSIMxz81FF+bc7V0Rnd4vQcMXjIJBoGWIi7fm++wFBtgPYyJAZw9Tsq72ffcR27+E74FKUVr5J9vVtdtkSByR11MeGumASbPG8LsITlE7RX92wtsbXygj5teg5t9W4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776814259; c=relaxed/simple;
	bh=Npo9yU/Y5MToSB09j5Eo1tYq8KpB7L6P8ASgou4SDos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8E/K5uNhTlRYcW+XG9NAF0JsozywbT0z+OFYM9D66lsBSnM8sCZrcSFwgKzrP7FM3lZfJXI2X4ZrC1uqcBi5QpHusp2xDIJSxYz0MXTEoz09HREX3mGCqv+z97FNqB0vPTpcx9K6y2Wkqoq2lQ2mHVDxqdum0+i7LgwZIn832I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P4xPn4Dk; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c7fb2e175so2250288c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 16:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776814258; x=1777419058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOjsAEmnKUhU7Dga6FzvW3J5thoc9d9mrz97vlt0VC8=;
        b=P4xPn4DkoL/4S8BqszmhMkInYUMJ2TaVLlYquD+JlC7uLGYxXORCAk1VRi9f6zLmDI
         sWzy9gjuTsvu440cdCFHiFU5HWP0N0BpJr/mt+Hs9IPoWcRzx9j61OAaCaoBaVUaJLVg
         G0EX7tpm33gvcLz7CDjp0NeOPOuDToaVOC4U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776814258; x=1777419058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOjsAEmnKUhU7Dga6FzvW3J5thoc9d9mrz97vlt0VC8=;
        b=q4K2oFErNSb45ZJplXoz/EAV14GLhLhdODZvTNBU+XmjD2619zXVWFfbKhnZG2p89x
         Cm3TLxDzr8GDAAHUbxLZGEAh7Vz7EyeCDUnQMFidCHobSO2HdVSIKsiI+05xCYbOBinY
         AIsvfCO4OYYjWSXTlE5mzYB80DrTeOSSAWAcd4Dg85Ul5fSrsgCoFxIU3AF+zQQ31+v9
         tI/uo2k2mGj5yfsQJRYTqjErSjLQBLmDPeFK6+3csnUBnQYuw+pOtQw9Q5xqA+Y175km
         pdFTVG+vVsUZDmDkddrjMcdltotG3bIrNSL6/UNUuMWsGfp+W8shUWWIBl4yL+9xd8Pw
         uDyw==
X-Forwarded-Encrypted: i=1; AFNElJ/cY/cZ+gDLQGLEIXpSPZ6zDhyp4x6OzoGjB4idZAJ1vlBYxuw8vulHnwy+I4CA8zgD9vJcy/HC2UzZLLpOQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKnDSo7oknhZHQIbZUSLaJKNwPr49utb+2F+81o6CW5GxslpFc
	zhaZ1efI/ypZP3y/Myc9VgNR/dacAtwAuKJ4AfrXRZZpHAAphKNbWrWbCovVuQYGgA==
X-Gm-Gg: AeBDietCko3rRk3kP+wJMwKaWlsMm52nM5APa5Y9zLnGUCmwu0sxxaOucTbjGdQn596
	Couqk2qDQv5qjGaDEEHUmv29NoAU+X7Q5LOc3NnEeuYvRATlh+DeSxiy8td2hAUda5rI7VnRu/u
	Lq+7ctc5XfSMFtlOYxfb2nOZvzbyRBhznFfX8s14ywSrqNbvqbB9tSUnMhatdRyhu73RtNXuCcU
	aeB4uoml79ozbruwazx4qpICz/ib26SwHIJOPpnxgZpKYpfgrh0QB93BEXspWIm/WZ//emHIPqg
	v+VqVoWQADrRJKsZPgw74Xpdp+HnKL3qTpb53vyMgfR/BqKsoXILd6E1lDki6ExfXWTrqLUa6Va
	D8XwzMWG+eXIYnrm8ZDTxDaQ8//a/VNUKlLA3KJAI4n8hQ6yAsY84NfsHkar50d0feuESk1l71q
	KDugOwHEiB1iq1kwmks/FgrKP0rKq0lBPt4OO+oyisymAA3SpeSYyi31RH/lro9yRn+lFJyvfg1
	wOfhdcEtYU=
X-Received: by 2002:a05:701b:2504:b0:12c:873f:eba4 with SMTP id a92af1059eb24-12c873feda0mr5099090c88.6.1776814257594;
        Tue, 21 Apr 2026 16:30:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:50be:3375:972d:9e1d])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12c770516f1sm19900053c88.7.2026.04.21.16.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 16:30:57 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:30:55 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 2/6] wifi: mwifiex: fix OOB write from firmware TID in
 ADDBA response handler
Message-ID: <aegIr-6KrRaWklSJ@google.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
 <20260421134938.331334-3-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134938.331334-3-tristmd@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35196-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briannorris@chromium.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[chromium.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6419744097F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 01:49:34PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The TID value extracted from the Block Ack parameter set is a 4-bit
> field (0-15), but aggr_prio_tbl[] has only 8 entries. A TID >= 8 causes
> an out-of-bounds write to adjacent struct mwifiex_private fields.
> 
> Add a bounds check after extracting the TID.
> 
> Fixes: 5e6e3a92b9a4 ("wireless: mwifiex: initial commit for Marvell mwifiex driver")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> Changes in v3:
>   - Regenerated from wireless-next with proper git format-patch to
>     produce valid index hashes (v2 had post-processed index lines).
> 
> Changes in v2:
>   - No code changes from v1.
> 
>  drivers/net/wireless/marvell/mwifiex/11n.c | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Brian Norris <briannorris@chromium.org>

