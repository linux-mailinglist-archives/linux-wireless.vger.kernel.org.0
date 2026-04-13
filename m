Return-Path: <linux-wireless+bounces-34699-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK18L93r3GkZYQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34699-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:13:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3033EC6F6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFAFC300B9C7
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39AB3CAE8A;
	Mon, 13 Apr 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="UMywUjsg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996DA239E60
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085979; cv=none; b=Zj7JA3oSZKnn53WxCLQ+ab2hn7kdsg1r9c1fSyxbTTYiptPOM8WYGbBuaVj7YKw/J95CVajzkEg/dIKDEfbdHrTuYjle2hKSQ1jvLHWLun8bdK6TyxBL6zc0QeSgiW3hBQymkFpmGxvE6zXj4R7ZMAas5Bm0yrHQw4MmLGp/Nt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085979; c=relaxed/simple;
	bh=Ugc03GiV/ut0gjqzpQ+CheZ07lUN7AEGOFkQoJ5d05Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FA4yiewBAsYMzOt8LTNYzFYnrom8VSo0FYDebxIwDZGrx0/PRUb0NdwU9Yluu1+vYLT8U5eK5JDoafTjHdsVMyonUYZsfQNUmaJsYS1feFt7mNFkfeakKpEO3K2RL6pgKRKLhZTEkBYdrBYsRAs4gTBhKZjzy9eFovgWzbFJtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=UMywUjsg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3vgSn01G7LbL2yb6VBacYILdpYbDpcNCMeJNJkhfs2M=; b=UMywUjsgsm4BuQ4kqpsLYXu47z
	RO0Jqo+IpYu2xZSH1Re2hiSf63sQWe4cO9BTf/QXqAnKV/I+XivORQ3CLXJbeWIJEfDGdeK6i3EGJ
	JktZNlNVGslU84po2RtR/Q8gqsy54KXCD3PjmarNnobKHE4JdEBXjbHe+WnV9kp0tvpaSz+s1I4Qz
	K79Wb6ONxV5NMbfC1ljI4H7hHuFMBemAgcD7guj826mU01KAoUBGWxJkPBitzC9Sf14NUKQPN31sk
	Jx7ABDToHYHfMUVp0FXhP2aJWZZFxln7ARERxxJ2MS0ceBFlNZlDQfqWzFrLdsM+aWVUD7EPPK00v
	V9220Ddg==;
Received: from 179-125-87-248-dinamico.pombonet.net.br ([179.125.87.248] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wCH5t-00FPsy-9i; Mon, 13 Apr 2026 15:12:49 +0200
Date: Mon, 13 Apr 2026 10:12:43 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>, Yan-Hsuan Chuang <yhchuang@realtek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [PATCH] rtw88: add TX power limit support to 114 and 130 channels
Message-ID: <adzry4z-LLhfor4e@quatroqueijos.cascardo.eti.br>
References: <20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com>
 <55c23c5551354c6f8752d620f268b37b@realtek.com>
 <adjN1Tl1N_xpzBHd@quatroqueijos.cascardo.eti.br>
 <f347beb33eb142cba384bbe9378a061c@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f347beb33eb142cba384bbe9378a061c@realtek.com>
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34699-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.917];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 4A3033EC6F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 05:56:17AM +0000, Ping-Ke Shih wrote:
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > On Fri, Apr 10, 2026 at 03:56:11AM +0000, Ping-Ke Shih wrote:
> > > Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
> > > > Though 114 and 130 are not usual channels, they are found in the wild with
> > > > setups using 5350MHz as the center frequency of a 80MHz setup.
> > >
> > > What did the AP setup? channel 114 160MHz?
> > > I wonder why rtw88 can select a not usual channel 114 80MHz.
> > >
> > > Please share your environment setup.
> > >
> > 
> > This is a Mikrotik that uses channel 130 at 80MHz.
> 
> I'm surprised that an AP can work on this not usual channel/bandwidth. 
> Can you change the setting to usual channel/bandwidth? We'd avoid using
> this unsupported channel/bandwidth by [1].
> 

It seems to be "well-known" that some APs do it and it has caused other
issues in other drivers. But it works just fine with a lot of other
drivers. So, I would rather make rtw88 work with that setting, even if it
falls back to 40MHz, for example.

Let me check what happens when using the proposed patch and I will report
back to you.

> > 
> > > >
> > > > rtw88 supports that, but issues a WARNING because it cannot find the TX
> > > > power limit for those channels.
> > >
> > > Actually, rtw88 hardware can't support that, so we are working on patch
> > > to avoid selecting unusual channels. Can it work properly with
> > > the AP after this patch?
> > >
> > 
> > It does work just fine even without the patch. The only issue is the
> > WARNING that is triggered.
> > 
> 
> As internal discussion, hardware doesn't work on channel 130 80M,
> which means connection might be well, but it can't yield expected performance.
> More, the power limit is not really verified on ch130 80M, so we wonder
> that the signal might not in expectation.
> 

The rationale behing my patch was exactly to try to set the power limit to
the lesser one of the adjacent channels. I am not sure that the expected
performance was not achieved. How would you suggest that I verify?

Thanks a lot.
Cascardo.

> By above reasons, we'd avoid using channel 114 and 130.
> 
> [1] https://lore.kernel.org/linux-wireless/20260413053601.13037-1-pkshih@realtek.com/T/#u
> 
> 

