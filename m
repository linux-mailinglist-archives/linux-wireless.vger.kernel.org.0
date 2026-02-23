Return-Path: <linux-wireless+bounces-32097-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKvjMNgPnGml/QMAu9opvQ
	(envelope-from <linux-wireless+bounces-32097-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 09:29:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A211730C0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 09:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43C633017C23
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAB92BE03B;
	Mon, 23 Feb 2026 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="plPB0BQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03134CFC4;
	Mon, 23 Feb 2026 08:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835272; cv=none; b=QHbsYDrbvgdkMBauQPkdkrLraxei8nDML5QqBwBHPu4OcVOmPFggmQdB+qZg8FFk9dI6Og8TCurnnlBgtRA953M1wHBD27LnGy3ZDAiCNlmPZXd9vqWI3jexG2m36H8RqYqro40dPyuK5AsG/pYetpSrBhEfnBhZ79MafuwuM9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835272; c=relaxed/simple;
	bh=lz2l8y/OixmitdHTZL6EB6R3yGHwFZ8vgupr6hzLVlU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+mBV6xoB57zwHB9nI951owpcN2e7cZHgvbZyUApbqXbGipkG2gwX5VFm567pe5FAtMMDKbftAUmmX3vSX9K5IoHYi0eJ3eBQu/1LjXwdEAZTvivURJsjLZKXPIJ9G0ZwF2kVB78IaOkOyMYT9bBrY0EtB2/0o47Y0UTeSvnmhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=plPB0BQv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=lz2l8y/OixmitdHTZL6EB6R3yGHwFZ8vgupr6hzLVlU=;
	t=1771835271; x=1773044871; b=plPB0BQvDrrpIPsIS3++FwpGJWZmZ7jPP3IrS7YFY3IjJ5w
	xmufHK8RCE2iHeoapTlou2qzR9cQl580w5hB5efZZFKc08rw76wqNcGq7a6RABQ3EXkvqsYgsiiBi
	uupQuP+NqS2qX9X7XAFHsFVcIOUA6trbItfGJF7y9VZ+Aaes0MWr6mmtZM9IOUo9ZdbshD/PDKGDH
	kCvE8DrJyhJWugpK0CluI60czgvzpL2Z+kdh6dCaV1ee53UfwHRDO1dvJDX9WIVg8VbrDeXcO2riJ
	Tk2gH8vYbPvSN4RknGEHLcZXKn5pxcvZAHz7CiW/xawlz2724+/UU3vtQgoqR/Jg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vuRI7-0000000Gv0v-1B8Y;
	Mon, 23 Feb 2026 09:27:43 +0100
Message-ID: <5f7f9b57c0a3909509b6413c41883bb8aa12caf0.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: rt2x00: use non of nvmem_cell_get
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, open list
 <linux-kernel@vger.kernel.org>
Date: Mon, 23 Feb 2026 09:27:42 +0100
In-Reply-To: <20260220020908.40115-1-rosenp@gmail.com>
References: <20260220020908.40115-1-rosenp@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32097-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[wp.pl,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 82A211730C0
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 18:09 -0800, Rosen Penev wrote:
> The library doesn't necessarily depend on OF. This codepath is used by
> both soc (OF only) and pci (no such requirement). After this, the only
> of specific function is of_get_mac_address, which is needed for nvmem.

That makes sense, but at least to me the subject doesn't - can you
please rewrite it?

johannes

