Return-Path: <linux-wireless+bounces-35227-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCDLNyQU6WmtUAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35227-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:32:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 485F5449C16
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3291C30BC7FA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 18:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E83AA187;
	Wed, 22 Apr 2026 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g8zggCdt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53719D08F
	for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 18:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776882484; cv=none; b=ORz6mMhrZ0qLqrzyTvM13gYakHswG6ltlK2ry4GTYsvahGfoeZDIhT4WgWWrW25x3zDBa5xTV+OO8whGElQT+bl8bbWjh5tJI8SALELLL6wLDepqU8bdAcAE0jMpUktUHQLBMkBYdPbDB203s2pZi1oIt8ZiQSeg5o4vQNsEKHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776882484; c=relaxed/simple;
	bh=s984LsuMSBwa5E63MoeYnkIU+EAlcpIYQ/pfInvgcBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTus9l5quqkpUuADphQIE1IanD/aT88P8VUaE7AV+L2ShN3lZIwPj4X8ls+KbJM0CZH5GLpSak6xtNeVfS2NwicuJiL1kbL4E/vKR2PdJ2ITeEFOR9GUFVxKqEOHY2/t9s07ZLjSbNe3sld/f1JN6pgvsV7zHz39t29xbp8zGmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g8zggCdt; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso6127489eec.1
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2026 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776882482; x=1777487282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSiVYGJAXxvkTZ3yDORxL7em6ExxplxKE1r9vCAX3Q4=;
        b=g8zggCdtd7ueFa0s2tuhXKvsV6StuQXqC0suvdScd2h5n65IcwMR15r1yMxsFkSsf7
         2j2RyP8t69WmqunW6NjIBx7LxjWovOF8MUYx4Bafe/ZlyCRgkXfj9e/sAGB5WERD+ixm
         U+TWk0IeIOtE9xOkYYOWoEJqxnaeyP2qYEeK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776882482; x=1777487282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSiVYGJAXxvkTZ3yDORxL7em6ExxplxKE1r9vCAX3Q4=;
        b=j0ihEOOXcvS3N+Q3aP8cBh0ge1IShUQFiXmcHX7jvChWWeSOJNPR+PNAvo6FEYzclj
         7HfW28IIkYtRWlHOj/mwSh5WNfoMEK6kC6fo8Vi5zo0AIY1yrTFcIDl9Uti973tkd58A
         Co4hUd30aF5nRCy5cB0gprxn6C2ii50HgPKAGJRIJGMB7b5bgvMPDHjVSexJjNdk6kGw
         Zo0eRIG75wcy3qGU3j3T4Vhv+cjrkaaMpgcDMK0oV1OB+0aeIcN6nHABZTgpBVDnKjzn
         lPnMmDhqGsmI3KMfmK9Q5k/oM8gM00GnGGnCUmu5MVlRHnaTzWyZ+ZBdSqbsdx43fz6C
         g05A==
X-Forwarded-Encrypted: i=1; AFNElJ91MHc1x5oEli8gBwI56UcutjY793rCaweXTudtdPt5DXqnPSYAvqlwrujH2eXO307P/m/ZUXYcWpE3jaD47w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRzg8xeZUYzRVCk79b3Ywx+mKgocSzJl4xutFWxCbPUWqIhG/
	caWn9UmuduPkKV9EEGM7JkCyb3mVDQQkH+a01neOYw1n+vqmxAlQHDSVz4rjqhOxog==
X-Gm-Gg: AeBDies/rT2pURREf0XjSjlKvnEm+biz3GiyXnYPDYM0Pc/t2D24dntWeK8D4dB2gvB
	UXqWI9iM8gfDIEx9wINfIZUzeX6OpXMHRjqaByR5IQ0KJqKsa4Lq8ff2KvdnSkslhIFHAEDgggj
	Lr6esqjHjgZqpvcmYBB4U0DY/OnR8/O5JfY1BNxcwLkynYtozaLTC2OzMfwTgU/+Ymk1WkZ+1nG
	a7bXVgazHOkIRnpEo/vjNa6LRIPbDdClplLYz5zT/HNPOJlsYdPkml1p+d8gFz72btS3Twe4Lx9
	xsnwyQwVjcKhw79veAGxW6dcuasL+IAwod+j6AwM52AmnN0WNsgvpCvOb2eMiAjuMc5bVXZlvEW
	CWF4dL8B6ZwI8LkdLdN9k/TOYRwC0MEXA74yB3+Jl3njRbNoak9TU/C8hbfIR5CGb0nUvKf43Kf
	3b6+K/4woCWNOg8V0McpX857UwJ037TjvyHDFGy7QTnu7OpCozOZzFdRRVs3ll5sxVjWZLt5yJ
X-Received: by 2002:a05:693c:2c09:b0:2cb:4b8f:b2bd with SMTP id 5a478bee46e88-2e4646cd2bemr12594888eec.6.1776882482166;
        Wed, 22 Apr 2026 11:28:02 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:e136:eb5d:6ed2:47d5])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2e53d2cfc1dsm23599847eec.22.2026.04.22.11.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 11:28:01 -0700 (PDT)
Date: Wed, 22 Apr 2026 11:28:00 -0700
From: Brian Norris <briannorris@chromium.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v3 4/6] wifi: mwifiex: fix OOB read in scan response from
 mismatched TLV data sizes
Message-ID: <aekTMPJTltIzuAUE@google.com>
References: <20260421134938.331334-1-tristmd@gmail.com>
 <20260421134938.331334-5-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421134938.331334-5-tristmd@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35227-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 485F5449C16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 01:49:36PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> The TSF and ChanBand TLV arrays are indexed by the firmware-controlled
> number_of_sets without cross-checking against the TLV header length
> fields. When number_of_sets exceeds the TLV data, the loop reads past
> the TLV data into adjacent command response memory.
> 
> Stop using the TLV data once the index exceeds its reported length.
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
>  drivers/net/wireless/marvell/mwifiex/scan.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

My brain cries a little every time I have to read and trust this sort of
arithmetic in C.

Acked-by: Brian Norris <briannorris@chromium.org>

