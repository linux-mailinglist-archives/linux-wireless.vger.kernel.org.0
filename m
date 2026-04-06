Return-Path: <linux-wireless+bounces-34376-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAIJFZna02nVnQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34376-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 18:08:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD63A519A
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Apr 2026 18:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 957E53008760
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2026 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99133C194;
	Mon,  6 Apr 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVL+qkwh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552B388382;
	Mon,  6 Apr 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491697; cv=none; b=s8V6VKgzR8oAH/s/QaxG60D/KTjYc+tFIOGKRz6jnobfXTFXIH9Onl9uIc/w3Ifj4DApYMuztZ/ext/CvEBAIvFGCXKx0Va12Q8b7Qe0gv2O9dtvJ+srZq2wpn2PTl6jABL/HFp3vv8zYXbgpBZov8+LOY96bQJwhfHlhTLvAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491697; c=relaxed/simple;
	bh=OYsimdFILg66Rq4LvXe90JtypDml8yHs+AL6xpCSECM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgoJDegtl7OGmLJlscZbjzrOTpF8V0Z6bVttBEjkWk8Adj4tUSd6k9BkTefTxrvx3RoN8cheOCN7ApXi3XkEYRjmj4L2XfXhLOrFppz5zC7aOBQjUiMUrvEW9U/0nd4w//LICJN+5VuhyYqwLnxXTbIEbmmNBx78MW/EapqiK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVL+qkwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095C6C4CEF7;
	Mon,  6 Apr 2026 16:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775491696;
	bh=OYsimdFILg66Rq4LvXe90JtypDml8yHs+AL6xpCSECM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVL+qkwh2cE0JYr2sfsCtU3NhWf0LwL0YJUTsOa9MzoEb3Im1SU5U9EjHNs2cypFp
	 Ab1aYQCkezyvkqqzkm+FnD6zqH9XWA0WfRJ6bvOKoU/JV3NI/ZSBOY5AlDGejwLSV8
	 8WDMMz/StOc4pv1TseluetYYIOhLrLPQKwd8mtFpPWlMQVm6Q63scWVirumKDFLzE6
	 TllHCa0CeMCXl3shLQRnceesCocKEKhZ3dqDBDj7+3EbY8YWgKJan1zIS6bq8HJ6Al
	 NbifxHrIYJlRWoYXMD5tap9B7UAMyL8pcav4mplTd5T8X1j1twxgnFAyYohZf1a17n
	 ZlZt6BZPcFTCw==
Date: Mon, 6 Apr 2026 09:06:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH wireless-next 4/6] wifi: ipw2x00: Depend on MAC80211
Message-ID: <20260406160659.GB2971@sol>
References: <20260405052734.130368-1-ebiggers@kernel.org>
 <20260405052734.130368-5-ebiggers@kernel.org>
 <9a3cbef9-5599-48cf-8307-3114ac2de704@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a3cbef9-5599-48cf-8307-3114ac2de704@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34376-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CDDD63A519A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 03:41:55PM -0700, Jeff Johnson wrote:
> On 4/4/2026 10:27 PM, Eric Biggers wrote:
> ...
> > @@ -149,11 +149,11 @@ config IPW2200_DEBUG
> >  
> >  	  If you are not sure, say N here.
> >  
> >  config LIBIPW
> >  	tristate
> > -	depends on PCI && CFG80211
> > +	depends on PCI && MAC80211
> >  	select WIRELESS_EXT
> >  	select CRYPTO
> >  	select CRYPTO_MICHAEL_MIC
> 
> remove??

If you're asking for 'select CRYPTO_MICHAEL_MIC' to be removed, that's
done in patch 5.

If you're asking for the "depends on" clause to be removed from LIBIPW
(but not IPW2100 and IPW2200), sure we can do that as part of this patch
if you want, since it's not actually necessary in LIBIPW.

- Eric

