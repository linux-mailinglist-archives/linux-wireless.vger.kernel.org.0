Return-Path: <linux-wireless+bounces-32159-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XkulJQ8anmnfTQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32159-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 22:37:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EF018CCED
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 22:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65B18301C14E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 21:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D191E33BBA2;
	Tue, 24 Feb 2026 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yUEi817e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B684317D
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771969036; cv=none; b=FnY5vL6kEvccsR2Zs7IfEO0FniJKTfPlcSmlCx/WFRURy2FLlxDfd/cYeRKGs6hOsJMbWDkei2117KCytcvuWVzhm7C/5NMnYFjAUJjE8adWC5LSJByktZyuFViD9+XF7ckKucMmi+MXuZvOam+g6vPsEsFPd4/GOeEe1Y5xpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771969036; c=relaxed/simple;
	bh=GAYgGCv4lVRyKW6GrMlQkVv5krRijQPDO0xI2Deyph0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qR/84phJt1StdQm6GuKWFsi8u4WQ9jMUMMRzcvxbeb0zCd7nvv3xGQvLGIUe5+8M5e8KYDAfqVBZRd7EtrdiO3KtllgDeQ2t7tLpJsyvl+TE+UDdCuU9zPMWHsAw8ZxZJskAwP5ojzx7pc9LXfqMhENH3BreL2bbcLo4v7sVFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yUEi817e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606F0C116D0;
	Tue, 24 Feb 2026 21:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771969036;
	bh=GAYgGCv4lVRyKW6GrMlQkVv5krRijQPDO0xI2Deyph0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yUEi817eZjvrNRDUD981aYX9U/g0tfSC/9LH9MU8cbzke26imS9kIoGjNnBOXfs8n
	 qwf4crvfrK2kRK6nHYPOqOz/y+j8QANPUhKkMbaSNlqd02uZu/+hPtE/3RpaccefcT
	 QqU8tI/TzMBYCBdgvHDGDsvledXSkWb6Ep53JRro=
Date: Tue, 24 Feb 2026 13:37:09 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org,
	Rajkumar Manoharan <rmanohar@qti.qualcomm.com>,
	"John W. Linville" <linville@tuxdriver.com>
Subject: Re: [PATCH v1] wifi: ath9k: Fix typo
Message-ID: <2026022405-mundane-caucus-6aa9@gregkh>
References: <6ab107cf786f9d05dc4d84ea4e2d1b219ce108c0.1766355822.git.alx@kernel.org>
 <871pibo5fj.fsf@toke.dk>
 <8beecde0-1280-4852-bb82-120590347fb3@oss.qualcomm.com>
 <aZ4Wq6h-nMt-G3pC@devuan>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ4Wq6h-nMt-G3pC@devuan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32159-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: D4EF018CCED
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:27:56PM +0100, Alejandro Colomar wrote:
> Hi Jeff,
> 
> On 2026-02-24T10:45:02-0800, Jeff Johnson wrote:
> > On 2/23/2026 7:17 AM, Toke Høiland-Jørgensen wrote:
> > > Alejandro Colomar <alx@kernel.org> writes:
> > > 
> > >> This only worked by chance, because all callers of this macro used the
> > >> same identifiers that were expected by the macro.
> > >>
> > >> 	$ grep -rn ath_for_each_chanctx
> > >> 	drivers/net/wireless/ath/ath9k/main.c:1576:	ath_for_each_chanctx(sc, ctx)
> > >> 	drivers/net/wireless/ath/ath9k/main.c:2554:	ath_for_each_chanctx(sc, ctx) {
> > >> 	drivers/net/wireless/ath/ath9k/channel.c:165:	ath_for_each_chanctx(sc, ctx) {
> > >> 	drivers/net/wireless/ath/ath9k/channel.c:291:	ath_for_each_chanctx(sc, ctx) {
> > >> 	drivers/net/wireless/ath/ath9k/channel.c:861:	ath_for_each_chanctx(sc, ctx) {
> > >> 	drivers/net/wireless/ath/ath9k/debug.c:717:	ath_for_each_chanctx(sc, ctx) {
> > >> 	drivers/net/wireless/ath/ath9k/ath9k.h:446:#define ath_for_each_chanctx(_sc, _ctx)                               \
> > >>
> > >> Fixes: c4dc0d040e35 (2014-06-19; "ath9k: Fetch appropriate operating channel context")
> > 
> > I'm dropping the Fixes tag since the existing code actually works and hence
> > there is no need to backport to LTS kernels.
> 
> Sounds reasonable.  Alternatively, a line next to it saying
> 
> 	[Do not backport]
> 
> would work, I guess.
> 
> Greg, I've seen this situation already a few times.  A Fixes tag getting
> removed to avoid triggering a stable backport.  But I think keeping the
> Fixes tag could be useful.  Should we have a standard way to document
> that a patch fixes an old commit without meaning that it should be
> backported?  Maybe something like this?:
> 
> 	[Do not backport to stable]
> 	Fixes: ...

As per the in-kernel documentation file
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

	There furthermore is a variant of the stable tag you can use to make the stable
	team's backporting tools (e.g AUTOSEL or scripts that look for commits
	containing a 'Fixes:' tag) ignore a change::

	     Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present

So I think it is documented already :)

thanks,

greg k-h

