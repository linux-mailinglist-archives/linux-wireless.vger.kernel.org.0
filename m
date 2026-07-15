Return-Path: <linux-wireless+bounces-39151-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QuYhLwuTV2pUXQAAu9opvQ
	(envelope-from <linux-wireless+bounces-39151-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:02:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1E475F1D8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:02:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dolcini.it header.s=default header.b=Sib5nQDY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39151-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39151-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=dolcini.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A27C3301FB36
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE8C2F3C3E;
	Wed, 15 Jul 2026 14:01:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6985D2F39B4;
	Wed, 15 Jul 2026 14:01:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124112; cv=none; b=H/PNKBIincTDlHSSl+ejWq0TWdAJ603BsaberbKrzFkJuOeI+4i9yjL9BHg3ql0eI/jDmqiHOqIlEf6hAOYFjPuaS7KCicSgWVjJiw99Yx0tX3iLaMN32JQOrqtdgUE7ofPJWOobs6GSv1l15hUCgkbt0cHoyS0tiXJ/i9TwIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124112; c=relaxed/simple;
	bh=uTMNPCRq8D0flY48pJnXGpzKYNKCwlS1FHUUgYwgar0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiQtL/TfLiSJc5lU7JCoF2EufYZnv3StOm6u2GUNTpbqFSqor8ySjE8Ob6w0As373c0rjZIBj2AqeR/KQcpHZ3g5pOvLgDBxW14B9hyD9xNsfYvJD4YGz6HYKwsRR6V/7oKhUCFIWODE1lYjuGuH/P1hcSf6+kcnAQYMiv+e1ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Sib5nQDY; arc=none smtp.client-ip=217.194.8.81
Received: from francesco-nb (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 12CED1FC12;
	Wed, 15 Jul 2026 16:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1784124108;
	bh=o9e56pBy+caxR+Chcucx0VwaDuQlyH1PFgilBztsuSw=; h=From:To:Subject;
	b=Sib5nQDY+Bj+oCMJJ5JdKrMn/z3dotAqATE4QLmZAswoVlu2XApO5y479nYKQyCCk
	 biBP+/65qTNmxRQDTonv2eusULiYYSqCG5K9FVjTMSnO9GnhlfFbw5d+Z2q/LuFqQs
	 Mq0leaFK7F/sidN2ACpJhHunClxtULQBufiwMiQttE7cb0yqtb3UxaiXszKlTosKot
	 QyZ62Fk2XYxYMCUzW+VOAlLZEhkVP+HiamhrEUBZKN2j+U/b5twp096QJjJcU/5BCU
	 RmiKdQ6+FVvl4N2LdbE+9lF2+5qCj6bSKWYGlEhEJQd9QHiv5/1Mpyzjuuf36tY73X
	 huOoN8kPDYJ0A==
Date: Wed, 15 Jul 2026 16:01:46 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kees Cook <kees@kernel.org>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: validate rate scope TLV length
Message-ID: <20260715140146.GC56330@francesco-nb>
References: <20260706091346.76985-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706091346.76985-1-pengpeng@iscas.ac.cn>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[dolcini.it,none];
	R_DKIM_ALLOW(-0.20)[dolcini.it:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:briannorris@chromium.org,m:francesco@dolcini.it,m:kees@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-39151-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francesco@dolcini.it,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[dolcini.it:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,iscas.ac.cn:email,francesco-nb:mid,dolcini.it:dkim,dolcini.it:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B1E475F1D8
X-Rspamd-Action: no action

On Mon, Jul 06, 2026 at 05:13:46PM +0800, Pengpeng Hou wrote:
> From: Pengpeng <pengpeng@iscas.ac.cn>
> 
> mwifiex_ret_tx_rate_cfg() verifies that a TLV stays within the command
> response, then parses RATE_SCOPE as struct mwifiex_rate_scope. The
> type-specific parser also needs to prove that the declared TLV payload
> covers the bitmap fields that it reads.
> 
> Check the RATE_SCOPE payload length before copying the legacy bitmaps,
> and require the VHT bitmap area only for firmware API version 15 where
> it is consumed.
> 
> Signed-off-by: Pengpeng <pengpeng@iscas.ac.cn>

Is this change tested? On which device? How?

Francesco


