Return-Path: <linux-wireless+bounces-32037-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EF94IgKAl2kOzQIAu9opvQ
	(envelope-from <linux-wireless+bounces-32037-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 22:26:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CC3162C74
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 22:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17CC0301083F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 21:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B38329373;
	Thu, 19 Feb 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8KM43Xh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAE329363;
	Thu, 19 Feb 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536373; cv=none; b=gZiJPqHylE1qBgDLLij3mZwCruzYEsmmU3chjRMcuP92/iiouBz8wXSPvbGDgwtDcW33RRbsPPOcIdtwrZ3upMtsk5HIX3yyYTHcBRqdrFpCv2ND3EG2qPSP2HZSNtYF7puOk+im9xv66gsmxdWi3n04lyf/YWoJzRC+pHc1yFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536373; c=relaxed/simple;
	bh=k3eIOjmh31KGZ2V8juxtChJ2D5hufhrXBQDrTquxias=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXRlFWsHqdy71k/5FwSDkdgDKcq9mHNLJrA5b//FGEy0l75QeF5zLY3Zktzldhl9PO3BeeTVbriDaWBsaUxwYMkxXL+goNgM06tMaQ5CfjwQlyt7K/ED0zeBV15x58m3rp5e0/jv0QceZMhK04we3yQ3zeMmc+8IuuOvmbUbP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8KM43Xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FF7C4CEF7;
	Thu, 19 Feb 2026 21:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771536373;
	bh=k3eIOjmh31KGZ2V8juxtChJ2D5hufhrXBQDrTquxias=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8KM43XhU0arShApnLbNpQww9PEWG6/97TNtfrZH0HjUr+Z4brlGSTbbhezLDlMsp
	 7jRtxA5Rb4YgrJdXftmRS7RSuHwZjfCEaShZ5FtoJ0qqtroxhhFs1/HQflZDllFqPo
	 9nRUFgJP23iqKE7nTRZZ5tPo4o8sh6y7sVtPMyMLMxtHrHMDKpsI2kyWe1NJFem/hT
	 XNDR9844+LCMGcGqyKi6tFGesrq2mhy6kfLQrVZLi0Y3wUY7qGNdWilcEnfwkN2cwy
	 f2kW9UBgKQYQ+i4F9p5tDpmxIH8q86oGB2a2jQraPI0fjzf1YZxBUH6oNNqyKXrYL6
	 ROaXgwKdprhpA==
Date: Thu, 19 Feb 2026 13:26:11 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 03/15] crypto: arm64/aes - Fix 32-bit aes_mac_update()
 arg treated as 64-bit
Message-ID: <20260219212611.GA32578@quark>
References: <20260218213501.136844-1-ebiggers@kernel.org>
 <20260218213501.136844-4-ebiggers@kernel.org>
 <21d30582-9cb2-4e7a-9aa8-36e16aa45ff9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d30582-9cb2-4e7a-9aa8-36e16aa45ff9@app.fastmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32037-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4CC3162C74
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:23:39AM +0100, Ard Biesheuvel wrote:
> On Wed, 18 Feb 2026, at 22:34, Eric Biggers wrote:
> > Since the 'enc_after' argument to neon_aes_mac_update() and
> > ce_aes_mac_update() has type 'int', it needs to be accessed using the
> > corresponding 32-bit register, not the 64-bit register.  The upper half
> > of the corresponding 64-bit register may contain garbage.
> 
> How could that happen? Setting the 32-bit alias of a GPR clears the upper half.

The ABI doesn't guarantee that the upper 32 bits are cleared.  Try the
following:

void g(unsigned int a);

void f(unsigned long long a)
{
	g((unsigned int)a);
}

Both gcc and clang generate code that simply tail-calls g(), leaving the
upper 32 bits unchanged rather than zeroing them as per the cast:

0000000000000000 <f>:
       0: 14000000     	b	0x0 <f>

So it's possible.  Now, it's certainly unlikely to happen in practice,
as the real code doesn't use truncating casts like that, and the
instructions that write to the 32-bit registers clear the upper 64 bits
-- as you noted and as I've noted before in similar fixes (e.g.
https://lore.kernel.org/r/20251102234209.62133-2-ebiggers@kernel.org/).

So does it really matter?  Probably not.  However, given that the
correct behavior wasn't *guaranteed*, I think that to be safe we should
continue to consider patches like this to be bugfixes.

- Eric

