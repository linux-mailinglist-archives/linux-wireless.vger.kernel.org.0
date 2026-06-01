Return-Path: <linux-wireless+bounces-37248-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMlwB8dfHWojZwkAu9opvQ
	(envelope-from <linux-wireless+bounces-37248-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:32:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAAC61D831
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97070317F2B6
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 10:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C108039184E;
	Mon,  1 Jun 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="hL/zCb38"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F2E3A7F51
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 10:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308036; cv=none; b=lAKtlvjoKfwQwdX8M09VXPkyTj+TN9ZfBMBjJjxse7vpRP1NI9mBXcucYUoL4YDc/WIig/V09sxW7lWhOuqImz5q6gdWx05k2YHC9DOpjbE77CQ2ssP4V501JoyIxfIeoN1/fYkXgv2DKLyel/dJyx/HJXNzBgl4k7dHZExhxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308036; c=relaxed/simple;
	bh=ALxelowRe/st/FSQD1PVtuAT/WtYdJdHb5dA13qry3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+2fG+kfl3PpKy9c1H4aH6WjlNQmnnBcDZNrIOGhqeZATpV8PBtpYNdc7VK5FFnsoC7Kn/d5J8trQMiZT5BTXBYod0kYppkS+94lXcEz8O22jeoPSckZjyb2FaH3z2i2mm61CdzC8Bgnls97xk/KJ/qMF/FkeOjRIfvRwa1E77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=hL/zCb38; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304e58292d3so6244427eec.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1780308024; x=1780912824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gE6vND8ZxxZ3Sqca/Yz4B0giomZl9Owqw6OY3FAoZ5I=;
        b=hL/zCb38l7i7/fpFpJb3/TpUILEQitm4EzwuszFY7tcE9z45yN50mhm+bFt8jaeaKv
         EHpveyqutCVkFSsdtkOKu0PVuJUM1cJX7TM5/1ibr7Tdn4MkyNQwK51D95of2voQKFF3
         Aova5rSpoHq4hr4bcz1un0P0dkXJRn9YlC73LA79BZq3QSLRzQN2NoIdVQB5TrKaaiZl
         MtzeA/1hlYp6IC15ZkbWtOoIyMDf4NtbHLzWGQSSMfUzm3ihJkwH8GShsBe0Pc2powBr
         APidqx99JZWG0jIcqZyEZNnyHPCxVD4vZGDUFtmD+wCxZpjjly2Mz9j6yT23rDk8eP+j
         P6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780308024; x=1780912824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE6vND8ZxxZ3Sqca/Yz4B0giomZl9Owqw6OY3FAoZ5I=;
        b=qLvCBTAXYr7thYx++nWJ7DY6JbwttRkIXsRRaO6Z2MTz3GxqoCRzCofLnD10l9n03O
         0Eq9eW9qm45CqPyL24icpMvU7vyIAxwrZ3BbPVV83jEkNG3sPrBm9YPhNJ+fyfciRTIt
         wm7kIg8DFvr0aRzr9gDlRxiYjd8BYr0kVE6HYG7Oc7rYG21IWgLec6vwThMgdF5wM84n
         Z5uJOsGMkqW9KQS0j4cTuRrXAYevNcAB2jRM+a3t/jwcbtTkHdIw+9qdpdI2jCBJG9yw
         CJCj8uopaDTzpyEOHsVV6FuY2mxTJ2YW83Ql+Akj8GAx/LP/bot95X4+E5i/AOPOp3ja
         avSQ==
X-Gm-Message-State: AOJu0YwAGOtBP1gBsmudNSaFtxyCrIMuGdrBy/MdZsr6iv7sKudses//
	tkhzJVwHw0P4R/QAG+qtXejbIsyrIXxw76I0yxh6xnXyvuNZ/bFaM5HYdk+qFJ+k/Gs=
X-Gm-Gg: Acq92OHdz23VMCkmngK8i8jMxlB7p7D0ZGMzBgn85g/mNHwinZc1GrhU9lyVJrvVfO7
	iResgTsTpQLuCCj108lWIjnDkBBC29sjpx38LGwIEF2m1OWo3dCpIW0ng714R/BrpU9u5AE4lOQ
	aTyH2D4MYp2qbjvbMBiSPomo4rQljm/hJRmWko7Goa99/eKT8Sb0wuuCCkSXEHEkg5IXQYVxY0a
	+kZCEpxepz+UREVQI0uPuveq/BVB1tS7wDe6hQyv3wbzX0iKBuOCvkP271JFw3wxY+md9jrxXuu
	i/3LHkjWJa57EIMUbVJCCyqXWh2BK1Sm9Y2Re7PMhXry6JGRYt18FooA3k7zYSPWP5fnH9HpaOE
	T7BcvF0jywtJ2cjcFiwZSphcbVquSTIZYQrf54wDECxTQ1q6sAiUQICxltavOUQ1T887xbPDrOu
	oM61JG4uJQWpsVZWhyi5H9McIw2elyF3ubATxevsJb1GpzD7lMqroxV6VwswgpZwyMfUBZvwkEn
	B7cHhcl/hPCjg==
X-Received: by 2002:a05:7301:2e89:b0:2fc:9ae6:e5a8 with SMTP id 5a478bee46e88-304fa673941mr5104927eec.20.1780308024410;
        Mon, 01 Jun 2026 03:00:24 -0700 (PDT)
Received: from localhost ([60.227.167.223])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2c120csm8620591eec.4.2026.06.01.03.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:00:24 -0700 (PDT)
Date: Mon, 1 Jun 2026 20:00:20 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH wireless-next 1/2] wifi: cfg80211: remove 5/10 MHz
 channel support
Message-ID: <qdbu7wot6hbi45gl4viobmdbdjiwklsysx7nloajoaof3jj4f7@2b2jukgj73tp>
References: <20260529064502.37422-4-johannes@sipsolutions.net>
 <20260529084502.080c5885f0b7.I77cc94485b523c3c006005b9233db13cd4e077b3@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529084502.080c5885f0b7.I77cc94485b523c3c006005b9233db13cd4e077b3@changeid>
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37248-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: 7EAAC61D831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 08:40:27AM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Remove WIPHY_FLAG_SUPPORTS_5_10_MHZ and 5/10 MHz channel
> width support. We contemplated this back in early 2023
> and didn't do it yet, but nobody stepped up to maintain
> it.
> 
> It's already _mostly_ dead code since it can really only
> be used for AP and maybe IBSS and monitor, but not on a
> client since there's no way to scan (and hasn't been in
> a very long time, if ever), so the only thing that ever
> could really happen with it was run syzbot and trip over
> assumptions in the code.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>

