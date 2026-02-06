Return-Path: <linux-wireless+bounces-31610-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GTxfKOIzhWlf+AMAu9opvQ
	(envelope-from <linux-wireless+bounces-31610-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 01:20:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EEBF8902
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 01:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 258D23016938
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BBA1E2858;
	Fri,  6 Feb 2026 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWfudXEu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B045464F;
	Fri,  6 Feb 2026 00:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337245; cv=none; b=LGkc7XBTG/3Zkb87PIwV58kcXb6mZaqmtOBgj7cNGfWSCCYo/uc2ngxFJatZHFzrN2WlRTF6xYMcEbzmegOZ6CULzxfLAMjx2jBGwS0hGm2FTsj8v+6KhE9GhMZSGPSd4gYbVTTgPrywqsM/J35RPylbEcrsPLb3I0hOMrIk6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337245; c=relaxed/simple;
	bh=ubKJbnulOAyzDI9B4u1CgFhXfA/SNhowArR6YqnHVIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXyXEYqIijZsF482AXE/faaC3lRgvH0vudLniz29Jk7GxeSjWNB0cuMichGjjSypNnJQa1XxGU23OQnaYQ6n4LkAe06BAKkjCuxbU73zyTNus6V55FY370pKL9o/7SWbjQ6P3bunlyC56L9h2l6QKgI+Ce4MuoXZytnI+NomyYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWfudXEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84415C4CEF7;
	Fri,  6 Feb 2026 00:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770337244;
	bh=ubKJbnulOAyzDI9B4u1CgFhXfA/SNhowArR6YqnHVIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EWfudXEubGovkjWKLOGSdR1BNcLbO9WiToWG+aMLD+GAJDAAbL6esi2pch82SKqfv
	 yZ7V047baeR8O4lw7AyIdQfNH1/br6Vz/wpbS6Tz7bPChP01dORhHAeNZcYGXzgWXN
	 aNcHvB+rZ8H2TkkpbPfemoiUYah8WvBEvq3NnnNsn3dtnGxznBxz2IUVqdaBBsqCMM
	 BmvEZxy6sS0xFA8cgY4mxqUuP/fuZSWZJRJb1o9tdC/bqSGTSjTUbywrAPP0SloWsn
	 2L6MO3hMYIhysLCSGsZ+ZnO8PgJabC7omOAz3TBJFwFW+GWFgDBXVPQ79vuIMx4sai
	 g/0MGcOP9as2g==
Date: Thu, 5 Feb 2026 16:20:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dhyan K Prajapati <dhyan19022009@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Johannes Berg
 <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org, Dhyan K Prajapati
 <dhyaan19022009@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v6 wireless] mac80211: fix NULL pointer dereference in
 monitor mode
Message-ID: <20260205162043.7c4530bf@kernel.org>
In-Reply-To: <20260205175213.5005-1-dhyaan19022009@gmail.com>
References: <20260205175213.5005-1-dhyaan19022009@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31610-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,intel.com,vger.kernel.org,gmail.com,sipsolutions.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68EEBF8902
X-Rspamd-Action: no action

On Thu,  5 Feb 2026 23:22:13 +0530 Dhyan K Prajapati wrote:
> Cc: netdev@vger.kernel.org

If you have to CC netdev on your failed attempts to produce a patch
please follow our posting guidance:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

