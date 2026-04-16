Return-Path: <linux-wireless+bounces-34872-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJIJLQOE4GmmiwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34872-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 08:38:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EE140AB49
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 08:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15EDB303B7D2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 06:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852D823E334;
	Thu, 16 Apr 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oyojODeR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C349157487
	for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2026 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321536; cv=none; b=HuoV7ZBgvlq9nQcWSr+P/qwHlH+h4NWgA+9xCS/xADdEJ3IEXhgTPrEvRIcDDSkvEeo4BVP0LaQ2Kyo/r8kKd9VgChEsH60Wpgj/OMjvtH7gsKP3sUt+C4nztnCARiB4buC8FAZDWjvZdZIwvhp9twUIaClexInbWzUing8zESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321536; c=relaxed/simple;
	bh=WQVZeYPPodz++yfLmZzU5+6zsLpiws+EGXYKENVYqbU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aI8MfrwefJNMXIWoj/KER7kTSCWJligbMjFzSVPRsVTSsKJiB1JdGFuU1CKzrI8b9BjT3GT8vIi9Q81EIR0A8yj5PyiNMpXoPHygyolrKP3Lk1b2xqkVSYIS+GC77Deq7LOGY8i4+flL9i/6mgSvrpA0RoaVjjV7ud2XrKucRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oyojODeR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WQVZeYPPodz++yfLmZzU5+6zsLpiws+EGXYKENVYqbU=;
	t=1776321535; x=1777531135; b=oyojODeRiTHkMMs132dZtzEgeCf2rsPY/hGAbrahQvu5pHa
	rmhGzLvC9tn1SjA2fu4UnIsG5OxTxr2+IlrFcceang9CxyiOy2S+Gj/g9jIXWTXbcAvl3jftjR1WQ
	3JNooFGKLn/mOpcP4Z8cWEqvJ7TgczswR9Srtv09UnHOQRXLWRCe5WsYlAeE7KiSUlXI5nX8ntpLn
	vTQmFfF1p3uqszgTEipqdzIrTdZ1K426dCLArkcMv/wRab1dlPlDQtA1doI8N0x5fiHe2LHyzPAmC
	9EoqUl+MNfVszDxoc//el3L6UwfwJ9fECJPAzOqy5RyOFYiFwOq5YW+jH7j1mFRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wDGNH-00000007HQj-0ZKA;
	Thu, 16 Apr 2026 08:38:51 +0200
Message-ID: <0aa3ac54dd3441cc69e9d58738498e0b72647dc0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] wifi: wcn36xx: fix heap overflow from oversized
 firmware HAL response
From: Johannes Berg <johannes@sipsolutions.net>
To: Tristan Madani <tristmd@gmail.com>, Loic Poulain
	 <loic.poulain@oss.qualcomm.com>
Cc: wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org
Date: Thu, 16 Apr 2026 08:38:50 +0200
In-Reply-To: <20260415223710.1616925-2-tristmd@gmail.com> (sfid-20260416_003714_987241_61E10900)
References: <20260415223710.1616925-1-tristmd@gmail.com>
	 <20260415223710.1616925-2-tristmd@gmail.com>
	 (sfid-20260416_003714_987241_61E10900)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34872-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 56EE140AB49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Tristan,

On Wed, 2026-04-15 at 22:37 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> The firmware response dispatcher copies all synchronous HAL responses
> into the 4096-byte hal_buf without validating the response length. A
> response exceeding WCN36XX_HAL_BUF_SIZE causes a heap buffer overflow
> with firmware-controlled content.
>=20
> Add a bounds check on the response length.

No real problem with these patches etc., but it seems implausible that
you're not using some kind of tool/LLM assistance, which you're supposed
to disclose (or at least I guess I'm supposed to ask you to):

https://docs.kernel.org/process/coding-assistants.html

johannes

