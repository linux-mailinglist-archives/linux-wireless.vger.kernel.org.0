Return-Path: <linux-wireless+bounces-37056-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKIzKjH9F2oTYQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37056-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:30:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196925EE990
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECFBE30CDA26
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 08:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315BA378D64;
	Thu, 28 May 2026 08:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="PBgn6JKO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpdh18-2.aruba.it (smtpdh18-2.aruba.it [62.149.155.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB3836A374
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956723; cv=none; b=oceXlL0359VyCPOa5mhgLVB2XGSPI70w1NurEluup2rqtZQ8sm3IE9luE9kN+DNUp+wuMV5ix12fv6peTCCN18L5flIEXpJh5Kz/nQUX24Vn1/HlFaGwxcC9/tAdzDc0ASaVszHDAGnEBiN8Cb/PQmC0pvZiJu6glyN/wzydiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956723; c=relaxed/simple;
	bh=21SAsR3WJl68rB2JCZ9NOEaBf2TL1vh7yn+L5rZBWF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uo3TpATTNS4ic4AqPfgEagQDxYnt6sKyZpsXYY04GEB/WPNYyhXHPI9AeMUUuwRKI/KXjoLHnJRNBBdCJk5b9UvGw5zF4bVEZWqyZkjEb/gI6XyhzY655Mtvp9WKEX1NdGn60oZgFmJPghLazQv/h1+QDC4CFuM6G4kNAHzYVhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=PBgn6JKO; arc=none smtp.client-ip=62.149.155.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from DELL-MOBILE03.ad.smart.it ([77.89.54.34])
	by Aruba SMTP with ESMTPSA
	id SW0Hw2lBE5SteSW0Hwb4Nw; Thu, 28 May 2026 10:22:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779956530; bh=21SAsR3WJl68rB2JCZ9NOEaBf2TL1vh7yn+L5rZBWF0=;
	h=Date:From:To:Subject:MIME-Version:Content-Type;
	b=PBgn6JKOAtCLp1mbxzN6c7SNCPJzvYJrbHTHy79yexNzG9GBn0fsGv9uL1rp9Q57x
	 KFKizEPijlbsKDzyFsHes8VDUHhA0HvPHSB9i+MgNxwSYRGKIXGzfVHWhc9df/j/st
	 UCW/IcFvz/VbkNpFwzK6qA4zDjXmPbsfTFerAmEDlxR8901gld4lTuqD72fvhxDwPD
	 V0736V/3a1567UWCONqf6Om4XXQBeblkaiwbMGeIzUygUcYotwFdY9rkRVSuDrLAMp
	 j6oVd2taUtQKGxLC2+/E4Xrx6Aayh8Wi7kVCkXnJlJBXKOxu6GWofSJdlxr3+E72Ym
	 gnYIQSA8Norlg==
Date: Thu, 28 May 2026 10:22:08 +0200
From: Alessio Ferri <alessio.ferri@mythread.it>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] b43: add firmware mappings and remove comments
 wondering about rev22 initvals
Message-ID: <20260528102208.12dee646@DELL-MOBILE03.ad.smart.it>
In-Reply-To: <5e8cdb04c12490dca37777975e921eb1842b6b4c.camel@sipsolutions.net>
References: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
	<20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-1-cdad2c8526c6@gmail.com>
	<5e8cdb04c12490dca37777975e921eb1842b6b4c.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfK+21eEnj4S1MjFANDpBTif2ZZJMYtCEuB/PTMyyjRI2/rFCZYAFzQPBDhcv40y+LEP7YyBKKUUi68q+H9sWUzVy7xiZ573uBtNbvsQ829dYFYNkEtnD
 EEwZq/Pg/PilKG8ez2yu9Hx0BBKWPCCotHrpnKSBDWcA2XcOBySR25klBoY3BObq3Io4W8+vwS3ZbOz29EPIgDOgaPe2sQfgzLtDrQ7hESEqbceQq1NAkIIS
 vyatAfovsXmLWVznLiTYnEDhWA5x5xq4N5Dak2/EeJMCG4c1D0NQiNhGDpCVaRMTZFpRUXQVBvf4prd7EkgEfHhQBJZ5tZ7wSYebYsVozw0=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37056-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,mythread.it:email,mythread.it:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 196925EE990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 09:43:58 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Sun, 2026-05-24 at 23:56 +0200, Alessio Ferri wrote:
> > Assisted-by: Claude:claude-4.7-opus
> > Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>  
> 
> Please don't squeeze the entire commit message into the subject and
> then omit the real one.
> 
> johannes

I see, i'll resend later a v4 with the correct split between
subject/message. 
By the way there is anything else i need to correct?

