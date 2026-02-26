Return-Path: <linux-wireless+bounces-32210-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IZpJu2BoGn6kQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32210-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:25:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F02BF1AC560
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B81034739FF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E594279E6;
	Thu, 26 Feb 2026 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="lzwJm0tb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i670.smtp2go.com (e3i670.smtp2go.com [158.120.86.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C65426EDC
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123019; cv=none; b=iAiRAoG1ThQlB1cHKxC2MdNJ7tXOKXy8rw/1clJH3Kd2iKuLG1NqUa3jZ7wF30FdOf/33cT6cezEPQWv0hpOM9j0TBVPLsV/9m7VwJ1aPvMiedmrk2q2zy+/Q90fuW8jZigzSinFNMSPQYuep7EgNMFCaG5Yo0ilOzxRIspwJqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123019; c=relaxed/simple;
	bh=4OlT4z6nXwiQ1hsBUOWkFfhSKpAvXJIKhb8uEx+N/n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXjslhnvt9pkZkM6z+udKKeC0gBjLgQRkKwNqI1tcGVIj4909R0+7KbnYjvyMOldX+uqnZQQi0MsH8WaTu1PNIOve6SvQLVhfLUenQxx0E2MrgJLSggTeB2uQkpgRrlg+F8yB+s995aTyKTp6AlKhS+pnSb6HyQX09gu6jkl5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=lzwJm0tb; arc=none smtp.client-ip=158.120.86.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1772122108; h=from : subject
 : to : message-id : date;
 bh=lzPuixvWghzNpH0Uka8bHYTOqSCBdAw6KoT3MIt+FGg=;
 b=lzwJm0tbya3yKpnXn6VJiHIrVuLpp0LHtmFzfvyt+vKHcISHzrR4V+oTkKPJ/EmVBp2fv
 hLh3lx0NjvvMpTvDmrNQgt4NN4tFu74ILa2MEJQsM6HPOlICg/DxV4yT4ueayr8vAlvcZah
 opEsDYvf86gGtPad8suyOdAizsqNbpt4WOzR9du8zKk023AzbfRT9yGRGjIWFwDzNJDAX1y
 MapCgI8LACaARuemcqDDbAA0XFNFkJ3iGz0aSySY6Ud14yoTpsjhj02FcrvVkG57WIiv9tj
 wXAwd2jbmAB78/xyNF5CSl5cCWh+Bnuu0KZVXkNph9hyF6x6Er6ncOouNMlQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vvdub-AIkwcC8mKyv-HS7t;
	Thu, 26 Feb 2026 16:08:25 +0000
Date: Thu, 26 Feb 2026 16:49:31 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless] wifi: mac80211: Fix ADDBA update when HW
 supports reordering
Message-ID: <aaBo7rnVkRFz3h-U@pilgrim>
References: <5806bab7e46506d3c300ab4eb66989d42936aeb0.1771323902.git.repk@triplefau.lt>
 <f1243e86eea72999581d33c6f97ff9015ce71542.camel@sipsolutions.net>
 <aZRnlPA_uY9uWuKr@pilgrim>
 <d142f76473a03c76c780390f0352ffbb03566e48.camel@sipsolutions.net>
 <aZR9eQlhy55iD6IN@pilgrim>
 <6ed3a0ee5e15c73f304050d303e74441cdf61659.camel@sipsolutions.net>
 <aZsmk0lUpL0UBd6Q@pilgrim>
 <0f0703e2749185f9a334b3435ffe247b42e6923b.camel@sipsolutions.net>
 <19061b55-a211-4448-8c49-ca8daa6d9d61@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19061b55-a211-4448-8c49-ca8daa6d9d61@freebox.fr>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sbru8S-D2W
X-smtpcorp-track: nUy9xRlBd2r3.T2VmRAQcviVA.l8N8swOZyRD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32210-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,triplefau.lt:dkim]
X-Rspamd-Queue-Id: F02BF1AC560
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 02:25:13PM +0100, Pablo MARTIN-GOMEZ wrote:
> Hello,
> 
> On 23/02/2026 12:50, Johannes Berg wrote:
> > On Sun, 2026-02-22 at 17:06 +0100, Remi Pommarel wrote:
> >>>> That does make sense. However, if I understand correctly, it means that
> >>>> even if we end up storing the timeout for drivers that support
> >>>> reordering, a new IEEE80211_AMPDU_RX_UPDATE should still be introduced,
> >>>> right?
> >>>
> >>> I guess in order to do a no-op update that doesn't change the timeout,
> >>> we could? But not sure it's all worth it?
> >>
> >> I was going to say it would not be a no-op for a buf_size update but,
> >> if I understand correctly, even when SUPPORTS_REORDERING_BUFFER is not
> >> set the buf_size update is ignored completely and the reorder_buf is
> >> not resized yet a successful addba response is sent. Don't we need to
> >> check for buf_size change as well as timeout also?
> > 
> > I was going to say that I thought buf_size is not allowed to change, but
> > (re)reading the spec doesn't seem to bear that out.
> For once, the standard (802.11-2024) is really clear on this (10.25.2):
> 
> A block ack agreement may be modified by the originator by sending an
> ADDBA Request frame (see 11.5.2, except that MLME-ADDBA primitives are
> not used by the originator). All parameters of the agreement may be
> modified except for the TID. If the request is not successful, the
> existing agreement is not modified. If the request is successful, the
> behavior is as if a DELBA frame for the block ack agreement had been
> transmitted by the originator and received by the recipient immediately
> prior to the ADDBA Request frame.
> > 
> > I guess we could just unconditionally reject any updates. I'm not sure
> > now why we ever added the update in the first place. Perhaps some
> > implementation was doing no-op updates and failing on negative
> > responses?
> > 
> If the originator is compliant and trying to update, unconditionally
> rejecing any update shouldn't have any side-effects. But if the
> originator doesn't receive the ADDBA response, it is going to resend an
> ADDBA request; for the originator, it is just a retry, but for the
> recipient it's an update, so the originator is going to receive a non
> success. And unless the originator sends a DELBA "by default" at some
> point, it won't be able to create a new BA (for a given TID) with the
> recipient.
> [...]

I’m a bit concerned that ignoring all ADDBA updates might break STAs
with finicky aggregation implementations. For example, I’ve observed an
ath12k mesh point get stuck in a loop, repeatedly sending the same ADDBA
request (with unchanged timeout or buffer size) only for us to keep
reject it each time.

But I am, of course, unfortunately unable to reproduce that easily.

-- 
Remi

