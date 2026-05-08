Return-Path: <linux-wireless+bounces-36104-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CGEIxRy/WlzeQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36104-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 07:18:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69914F1D94
	for <lists+linux-wireless@lfdr.de>; Fri, 08 May 2026 07:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE7E130091E7
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2026 05:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308B303C97;
	Fri,  8 May 2026 05:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JV6C9VMG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73751B6527;
	Fri,  8 May 2026 05:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217485; cv=none; b=dxj8JhnVJMALKVWr+/eHgkuIc7hL6b88r2M0/qY0CY6XnzsVWpUxM/8Ru6mHkWYRFL/U3HtJNdRzbKX2lYhy3rX7hcH7dOLiye3UctckeEglXQzvJQnCD7XXALakjJuiQ4bE/FdvzBmX0UoGyJaiwGMO0eJIXzoJciIdJ8o4iAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217485; c=relaxed/simple;
	bh=psh94nB79rB5aviUtkBuKsPAPqf36rcORNeUwOy7HqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUQZ3Gb+H4e7fq5CpGW+/d7hZPBbND/uptxkAsUZ9/EUylAS9oEphCiOEJ52bzy1but8G7kzrB/VRi2Gnaf9zAcMOlUlnug5Ou+VXwwr4V2Qk0j7H36qXDBumVmB6vJT1MSnvulJfE/6zZgoBg8WtIv+lmUwivbvu80qUN7ycjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JV6C9VMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12A5C2BCB4;
	Fri,  8 May 2026 05:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778217485;
	bh=psh94nB79rB5aviUtkBuKsPAPqf36rcORNeUwOy7HqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JV6C9VMG9Isqa1BqG+6zOBzNmOBnBsAjccIamHBjP8i8p1af39DTooYzO9nVMu2oJ
	 NgtBpPv9XOSnwMh7RVyPzmqHgDzP9YDVOalnViqBLoQo/mf2q2pWHMhMbhLlCPFdQ1
	 3ynzJ3Senf5qWW4p6Ce4foSxun8zS9c5Jax89Anc=
Date: Fri, 8 May 2026 07:18:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
	"mingzhu.wang" <mingzhu.wang@transsion.com>
Subject: Re: [PATCH v3 1/3] lib/string_choices: Add str_alloc_free() helper
Message-ID: <2026050848-engraving-imposing-09fc@gregkh>
References: <cover.1778051552.git.jqqlijiazi@gmail.com>
 <9663db399276de3ce91a77b8a8be8220132e74a8.1778051552.git.jqqlijiazi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9663db399276de3ce91a77b8a8be8220132e74a8.1778051552.git.jqqlijiazi@gmail.com>
X-Rspamd-Queue-Id: E69914F1D94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36104-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,transsion.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 07:03:22PM +0800, Jiazi Li wrote:
> Add str_alloc_free() helper to return "alloc" or "free"
> string literal depending on the boolean argument. Also add the
> inversed variant str_free_alloc().
> 
> Tested-by: mingzhu.wang <mingzhu.wang@transsion.com>

Needs a name, not an email alias.

thanks,

greg k-h

