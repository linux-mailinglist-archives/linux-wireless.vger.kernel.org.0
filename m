Return-Path: <linux-wireless+bounces-37389-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pd9BKQ2DIWrrHgEAu9opvQ
	(envelope-from <linux-wireless+bounces-37389-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 15:52:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE164089F
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 15:52:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kemnade.info header.s=20220719 header.b="C2BcoI/w";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37389-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37389-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=kemnade.info;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AE48314B63D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308847B426;
	Thu,  4 Jun 2026 13:39:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958234014A1
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2026 13:39:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580371; cv=none; b=Fb2RAu059rN9c6SMkIXKMOjJgNrX43e295qqGKWGBGntJ/TH2KfxbU2jmEoIUk8krTGJxkTL5x0wxmHWSUCxNBg/muX7ypOLr5ziLamd1IPXxjsl16NToNhfGk+5jPcZW+xTB0V4Ulg919/VqFkHwEqScLJWs/If/MbDIvJJeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580371; c=relaxed/simple;
	bh=ufoXaxiYsa2bG9ZjHmm/5L4CuJBaVbmrT5USaEdQVO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JShAhRw5gRd09HA/JS/r6ay4bA+4Ym0JJ4ySN7SkLDEb34ldGF5WZv76TRrPAEzU9Y6NLkEycPq4TOVdHQkW5wERxHNBgMv6mYvrTjpB8Sgp0q0jka+j7eDN+K/3AuTiaEFHeFy5nyQSLbJSiDVn5OKvnyoDb3UygG1KiwJHCCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=C2BcoI/w; arc=none smtp.client-ip=178.238.236.174
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FwDtil1b5c2ozslQpfv3XA79naScboKEasjU5P2mLEw=; b=C2BcoI/wYK6V+yd7Bpr753+sx8
	doYHiz95WY+0u58VOqFA4Olz/t08oA+BaKfbIngf+YqI8brTjxLHalNjD1Jtm9Lk7UnbvYK+k7fG0
	lwe+ZBRAvdgVNW0dMdIa4JM2IsG1Bj1uHosD/y2sx+m18FoaAXvAunMu+fmDs3nVbKr8kEtGuvmsy
	jGfVJn70qWUcDpflGsVcWAJzNuJkBAG/diqctpk1YxYSDUn5w3r3y3BF1gklut9HUmfcMKw7wNfXd
	eI8Qo9m+EwNgFoVjy2JPkmp0LuOUqaYS/9kX3/7F5QJ8UVeVxBeIb9KvmiAV4DRSGylzT8WpIZhV9
	7S5bKNRw==;
Date: Thu, 4 Jun 2026 15:39:17 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Peter =?UTF-8?B?w4VzdHJhbmQ=?=  <astrand@lysator.liu.se>,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: wlcore: Add support for IGTK key
Message-ID: <20260604153917.4c065791@kemnade.info>
In-Reply-To: <ba6e767a75b02c11d4bec542c971c1affda77df9.camel@sipsolutions.net>
References: <0d3df7ab-6c41-c3cc-83cc-5ba55fe4e4bd@lysator.liu.se>
	<20260508102403.4e2fb1bc@kemnade.info>
	<a2040dcc-af47-1de0-b731-defffe3ce4cd@lysator.liu.se>
	<20260604120834.508f606f@kemnade.info>
	<ba6e767a75b02c11d4bec542c971c1affda77df9.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kemnade.info,none];
	R_DKIM_ALLOW(-0.20)[kemnade.info:s=20220719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37389-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:astrand@lysator.liu.se,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[andreas@kemnade.info,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andreas@kemnade.info,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kemnade.info:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AFE164089F

Hi,

On Thu, 04 Jun 2026 12:23:50 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> > >   
> > btw: if the firmware is started for a second time, it will also decrement again.
> > So after some reboots we end up without any cipher.
> > And afaik the firmware ups at any ifup.  
> 
> Maybe just send a revert for now?
> 
I was preparing something while you wrote this. Do want anything simplier for
now? 

Regards,
Andreas

