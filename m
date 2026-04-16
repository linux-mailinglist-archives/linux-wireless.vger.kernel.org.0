Return-Path: <linux-wireless+bounces-34903-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOpHCeI24WlFqgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34903-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:22:10 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7C4140EF
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A15307E83E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7FC395DAA;
	Thu, 16 Apr 2026 19:22:06 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086283859CD;
	Thu, 16 Apr 2026 19:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367324; cv=none; b=IJeHQaEMm9m5IpLivXrygyXrAFjgRQNRBdtaWqgkl5sYOS6xeAI8s+liK3Bg6MKru/XaUqfWMygasWcDJy5bjVJjaLDcvs0OHqsdrXar6Mnh2NU6Ene0k0O6BXL5YWTBoBcrlu19vMN68Wj/px3p4XDD3Zcg8pSYWFWI/aq+zgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367324; c=relaxed/simple;
	bh=RqjpDfzr6mWsC58JDYwLA0IHSoBSW3XysjQDAAjlM+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSdmeF4ZfZ/9ERl7hqvtPJs87pWFeWHA+ZUdBWH1ozN341UPJBdS6ssSx67egHp13R6P3m3y4l99r9MxY7p1IdUi+Cur4aUKOCWvDAMarZWcWadhUvStoU+6PbAze6WjT7kJoXlblfpvu5iL4tZ9jkN7w4gXJL/sljt4meXrKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath9k: use kmemdup and kcalloc
In-Reply-To: <20260223224445.27352-1-rosenp@gmail.com>
References: <20260223224445.27352-1-rosenp@gmail.com>
Date: Thu, 16 Apr 2026 21:21:54 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cxzybtil.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.25 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.71)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34903-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toke.dk:mid,toke.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42F7C4140EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rosen Penev <rosenp@gmail.com> writes:

> Simplifies the code slightly by removing temporary variables.
> multiplication overflow is also gained for free.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

