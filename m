Return-Path: <linux-wireless+bounces-34902-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK/BFus24WlFqgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34902-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:22:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CFB4140FE
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 467E93078853
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 19:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2BE3783C9;
	Thu, 16 Apr 2026 19:21:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5DF377EDB;
	Thu, 16 Apr 2026 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367283; cv=none; b=hsufBrmF/ZJPzAlisb4YK4Om2S4L8rFMKA2Z/zCkCTWgNgpGLgA+mNkNLiqFv9hbNWryb/JKi/gT64xmJBOiybS381FooHVYhPLDE4cUQdhE47ZtbqqwVQAW+nd3oGBqZOMCA1q32j+DCIGyiHCrETKrco+aO6SdM1v4sc9/TS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367283; c=relaxed/simple;
	bh=TmytUfmzuxhfxOeP1eqiJ5faxsDgBOpvZsoqAbGEPTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZN8TW8qz3/Nk6qfdOWlT/DVgIWOjApMWR8MvLaxGZU7LeCGaZf8hIJPU3a8TREevSJb0Z3HBXrNMQPgAanPt9zy0eU8CVtwmYU7ezqQ3Cl3PtFACvILQwzFJ97Ws9wnLOPuPD83csB4uphyMHXW5TLT98cmP8cQW2fwidPrE+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan
 Sadhasivam
 <mani@kernel.org>, "moderated list:ARM/ACTIONS SEMI ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/ACTIONS SEMI
 ARCHITECTURE" <linux-actions@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath9k: owl: move name into owl_nvmem_probe
In-Reply-To: <20260223224254.27081-1-rosenp@gmail.com>
References: <20260223224254.27081-1-rosenp@gmail.com>
Date: Thu, 16 Apr 2026 21:21:16 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fr4ubtjn.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.21 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34902-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toke.dk:mid,toke.dk:email]
X-Rspamd-Queue-Id: 29CFB4140FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rosen Penev <rosenp@gmail.com> writes:

> There is no need for dynamic allocation for a simple string.
> request_firmware_nowait copies the string internally anyway.
>
> The error message on failure is also wrong. It's an allocation failure,
> not a find failure.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

