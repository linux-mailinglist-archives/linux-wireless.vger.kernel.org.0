Return-Path: <linux-wireless+bounces-34901-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIorOg824WkEqgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34901-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:18:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 631EA4140A9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 21:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85352315E6AF
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 19:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0A635BDC2;
	Thu, 16 Apr 2026 19:16:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196922765D7;
	Thu, 16 Apr 2026 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776366964; cv=none; b=nWQlwxWU+TVZmqPzZJ1oBZt4WF/75QQa7L7T10bVPAokfEgMmmSOsZsJBzoSN1iu7CnZHl3Zn+dXw9Iz47GkzNWJh/8V92+IM+Y576rtsqFSxtCEKt5NwmmWkZwjsk3fKHzzWHz/IDkLQAlK9z9DdGdv9W/GLpLasDUTu1+HCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776366964; c=relaxed/simple;
	bh=SLAVdoNO18AUUku2BU6T3beDzbXwGJYaFeE1g2rm2ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pb3cHB9rqMVpBRocvS32MizcJtencxj3rYxe7Q1n3GQVpYTMuy+06t6C0iueza/x5rutRwSnLzLRTnqLCb0ViyRaiWSU8hVQ6s4PhYkdDhQ4AEZhNPSNH5E9WjsnZ8JUqgihifB05/Ya9qoH6XjGPGZ+x1LE6g7qmJfsipgxZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Tristan Madani <tristmd@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] wifi: ath9k: fix OOB access from firmware tx status
 queue ID
In-Reply-To: <20260415222343.1540564-1-tristmd@gmail.com>
References: <20260415222343.1540564-1-tristmd@gmail.com>
Date: Thu, 16 Apr 2026 21:15:51 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ik9qbtso.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [1.10 / 15.00];
	DMARC_POLICY_REJECT(2.00)[toke.dk : SPF not aligned (relaxed), No valid DKIM,reject];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34901-lists,linux-wireless=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[toke@toke.dk,linux-wireless@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:mid,toke.dk:email]
X-Rspamd-Queue-Id: 631EA4140A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tristan Madani <tristmd@gmail.com> writes:

> From: Tristan Madani <tristan@talencesecurity.com>
>
> ath_tx_edma_tasklet() accesses sc->tx.txq[ts.qid] where ts.qid is a
> 4-bit hardware field (0-15), but the txq array only has
> ATH9K_NUM_TX_QUEUES (10) entries. A qid >=3D 10 causes an OOB array
> access.
>
> Add a bounds check on ts.qid before using it as an array index.
>
> Fixes: fce041beb03f ("ath9k: unify edma and non-edma tx code, improve tx =
fifo handling")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

