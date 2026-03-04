Return-Path: <linux-wireless+bounces-32431-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBjFGISfp2nTigAAu9opvQ
	(envelope-from <linux-wireless+bounces-32431-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 03:57:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B11FA1B6
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 03:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBDF230405D4
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 02:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118773537CB;
	Wed,  4 Mar 2026 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="rJ54U7gl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81D30DD16
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772593024; cv=none; b=fVzkbFEmMYssYER4WtsII0sSj1LO4kUa3rv0ZLPfZHOJSPoRWVTcAma3mFhVY4y1G/qfN0xrwltc6cIW/RuKHrQLG8EfsPPbKCOC4fg0GB5OYNlG98bdtiCSBDMfNgWJUxr4p+iFoYIg44QgckV9gdG1z9qs5zEmZDJgQmXVYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772593024; c=relaxed/simple;
	bh=+b0unGRaP2MRMvUHQ3WsiAEj7LnkBiuCF4gRSAFQW40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xgu5Npi2W1URrCzfiSk0/zlJgz5hYsx/MgY9UATWfFSO4q4eVpveYAzEo9HL3t0uPe99NSwgFC6xW7EeWJwpGP8YCtIlQwsIXOrrzm5Mn+spp+guAh+2OV7CDP0wv7wRF2DG8DcrILZZrWAaYS62hHcrGFHkyBpwz1SBX9h6skg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=rJ54U7gl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81df6a302b1so6873297b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 18:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772593022; x=1773197822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iN5/FO5+j49w565NDzMjSQFDSqPJgLOwNVvj4QLnCJY=;
        b=rJ54U7gl3glgU7TmAgwwqoGSmFTWeUBTB9CWtQw3Bal6NkvfsKy8jwzk7Zhjiymeta
         w0qoNL+a7jV5GG08A7J4D0esS07Fn449L2zh/tQXCSI48qh5ONLGZp3c5pOylpEuMXHu
         WTSzUpGIoxHQs4aO3Fr/GVYW81aYAvJ5fYVBq5l3rlSAEd8Vt70fDqSEPW/W0SEnRnGY
         JMTKwJIGMxtnFQgoPgq9oAiIScPY1Swf79qLuq+cYNsSOyDnYDXWUu9GaC9c64oDuZ9s
         rXrLx1C9CZRMjY3rRDfiMPMaYb3Rw8ibIBX/uz8J0nEO/8gQ1RpBHB66q34me8km4pax
         ASeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772593022; x=1773197822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iN5/FO5+j49w565NDzMjSQFDSqPJgLOwNVvj4QLnCJY=;
        b=ftK1Mo4Ldpyv/4QRrDZyA+V4+Z0948GQz2U1OXILMzt2a5UL7cCGKdR3kDYydUyfp0
         mSmA+JDh/MXsHtIMI8arZvveGsl0Vy+OSnYZeb9n1bFYbkb+V+qw6iwA4lyyKxRzymMk
         7svWb69HzrgHvswUxWi9HiOLi4jH3YRXvko5kG27mNxqxKnEI0rxndLcLUDT5pCF8a94
         i3MwELD13b/rcimHyJ2B8W6k0Bu+kpvD0LPx8Z/J6cSVvx/47ffm83C/pCbe9Bl8tFY0
         MF59F+c1n30srqrw79bbQoN/OgW+O13B4WMJMk3CigUD1Aqju/OHfitUZAuBDNj5kTR1
         Zg2A==
X-Gm-Message-State: AOJu0Yx0iR7+z0qXBTM2hjNOwt/IgM0wA8CdnvUkysTV9pXPfeUFBtf8
	us6J+z+ZIwFzV/o4YtSlelaQpxeYjhv0x+yHM0katg9pMpzMCukZ/tsxzMOJW4NKskjrl/ZBFqy
	Rqj/q
X-Gm-Gg: ATEYQzyyk/SqTssUEV9WY9+RzgAhjCRlk+HZPmxfEEsRjJwEEW/jJPsn0zR8cnm4fyE
	ZDnJZGeB13raB4Uu3pu4QTKq6JVc8teyTi93VA6r9NxKF9LxkUFW7RlkDq/6jokewfFhsO8+ET/
	Ne1YK9lbQ966XCjR8boW7bc2n+fxMoVkS7U/cQ5GgbSoS3x+wQvkDSWCZQys2EE/MI18xSDFfKz
	4Wf3GYrteEUrcdXn+SOHVyzCAGY4jr40AFE5Zy3o2gQ5joMaH0umtR8qTqJBVksTt5lrKuQkrsV
	cGpYnD6pceOj+Wh+74qsM3HP5WU4AK55/W/1XNv8WOvHoM0ODjlCCDt5igeMEEuvgumKh1fqU9v
	4bXIk5aUoHMjWOfxn004bkyY3Bqun3hfVKOfrsZ6Bto8do1RyVeN1Z9Zt9oQQhSPWVdQTbtQUei
	VvZBBqeYAEsMkR54pcoN5S2mnkmAYNrFEtv9880WZhdeC/8EvVg4+VBOpmvExj2EyesSpPFcX9O
	FQMbpWt5X2zUBHRbSqOw3w=
X-Received: by 2002:a05:6a00:4090:b0:827:2c4a:a03 with SMTP id d2e1a72fcca58-82972b5f702mr473852b3a.24.1772593021972;
        Tue, 03 Mar 2026 18:57:01 -0800 (PST)
Received: from localhost (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d544ffsm17492507b3a.12.2026.03.03.18.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 18:57:01 -0800 (PST)
Date: Wed, 4 Mar 2026 13:56:57 +1100
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC wireless-next 8/8] wifi: mac80211: set AP NPCA parameters
 in bss_conf
Message-ID: <h6zaryfx46dg45gmysd4joxecawzkj256pu6uy2g2dbmzwpfxr@apaq4cud4rmg>
References: <20260303143434.273141-10-johannes@sipsolutions.net>
 <20260303153435.75b65c3144b6.I3db62b48d6afefd23b50fd14663f863e6f9974ca@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303153435.75b65c3144b6.I3db62b48d6afefd23b50fd14663f863e6f9974ca@changeid>
X-Rspamd-Queue-Id: C76B11FA1B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32431-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

> +		npca = ieee80211_uhr_npca_info(params->uhr_oper);
> +		if (!npca) {
> +			chanreq.oper.npca_chan = NULL;
> +			chanreq.oper.npca_punctured = 0;
> +		} else {
> +			npca_params.min_dur_thresh =
> +				le32_get_bits(npca->params,
> +					      IEEE80211_UHR_NPCA_PARAMS_MIN_DUR_THRESH);
> +			npca_params.switch_delay =
> +				le32_get_bits(npca->params,
> +					      IEEE80211_UHR_NPCA_PARAMS_SWITCH_DELAY);
> +			npca_params.switch_back_delay =
> +				le32_get_bits(npca->params,
> +					      IEEE80211_UHR_NPCA_PARAMS_SWITCH_BACK_DELAY);
> +			npca_params.init_qsrc =
> +				le32_get_bits(npca->params,
> +					      IEEE80211_UHR_NPCA_PARAMS_INIT_QSRC);
> +			npca_params.moplen =
> +				le32_get_bits(npca->params,
> +					      IEEE80211_UHR_NPCA_PARAMS_MOPLEN);
> +			npca_params.enabled = true;
> +		}

Minor nit, and I can't really comment on the actual UHR code - but would
it be nicer to have

if (npca) {
	npca_params.min_dur_thresh = ...
	...
} else {
	chanreq.oper.npca_chan = NULL;
	chanreq.oper.npca_punctured = 0;
}

instead? I have no strong feelings of course, I was just perusing and
felt it was a bit strange to read.

lachlan

