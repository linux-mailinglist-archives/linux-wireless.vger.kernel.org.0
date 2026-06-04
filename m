Return-Path: <linux-wireless+bounces-37388-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LM3aAMRvIWqeGQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37388-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 14:29:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CB963FDE4
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 14:29:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=WSBn5XQL;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37388-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37388-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD83A30945D6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEE43909A7;
	Thu,  4 Jun 2026 12:20:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CE18EB0;
	Thu,  4 Jun 2026 12:20:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575630; cv=none; b=E9/ub6eKe2fJomRkAw5VygC0DheXxiseVnspN+JIyEIoHQiGhO4aaK9IJthYNtcnOg56j2xWa7GD73suYWxYBSwjEYyhlzA953pFQPsJRPgOecTWfl8pTxW7U8IrXV5bms8MK8ZaYHpAODgnp5xaa3X27Y4F5PpBLf5ROkdkuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575630; c=relaxed/simple;
	bh=krSq2+uB4rUrgmlMiYugwrJtTJ3HcqQLQOaI/vb+E2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uAWK+cj0NpJVQ30O71Cz4vQPo9+1pf517FCzEwucrw9cwu7yhMDkNO3J+zdyUeVll9qS4vMEZ8Zy8kJXe5gjB/H4GmHPuWJCUn6Nsj1GJxSnkYUqtwYozrXjthCi9S2JcJVNkG2wFLEnSrIw7K9Cqs0AMXONnS3ZjUbtb8zmzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WSBn5XQL; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=C/MpNNM+9zhiM9ebOzU3o3ld+8lWdyy3/7LymgZkFX0=;
	t=1780575628; x=1781785228; b=WSBn5XQLbaNeXgFzXU5aeAQ0mIuJRvpLyFohEUeQmUxOmHJ
	zZq8a2iUs1QlIZfClxwHCPougG7f2XWw1JOWS+hnrIpaF2v5P/gO/32Fpn2Xk6T18r9OhGUlnGdo4
	qeSaFw7t9YPi7y4eSi5F4j7zxGtazlFvbgv+xEsQz29COwHXEezUSBAK0qtBWG8riQmSR/gDp3yVs
	bZ9c4J5iO8upB5sZYkQSDJmJxoDp/CWQt0PNHm0xkAcQwJu1DCpAzxMXBuGU81D8MMBuowt47olMp
	gMYSADg6AqiNhf8u3AIDCvbRqusDMhHjat8HR6YBg2YqpBFvwCX1Gpl8Qulv6kSQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wV73i-00000000Thl-0R5i;
	Thu, 04 Jun 2026 14:20:26 +0200
Message-ID: <64823ef6ba20312cf81eae281740873f5ae6e6f5.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: fold tid_ampdu_rx
 allocations into a flexible array
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: open list <linux-kernel@vger.kernel.org>
Date: Thu, 04 Jun 2026 14:20:25 +0200
In-Reply-To: <20260604001427.16466-1-rosenp@gmail.com>
References: <20260604001427.16466-1-rosenp@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37388-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:from_mime,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75CB963FDE4

On Wed, 2026-06-03 at 17:14 -0700, Rosen Penev wrote:
> Convert the separately-allocated reorder_buf pointer to a C99 flexible
> array member at the end of struct tid_ampdu_rx, and place reorder_time
> in the same allocation immediately after it. This collapses three
> allocations into one and removes the corresponding kfree() pairs from
> the error and free paths.

As I pointed out before, I'm not a huge fan of these "doing a minor
improvement for the sake of it" contributions ...

> @@ -241,7 +241,6 @@ struct tid_ampdu_rx {
>  	struct rcu_head rcu_head;
>  	spinlock_t reorder_lock;
>  	u64 reorder_buf_filtered;
> -	struct sk_buff_head *reorder_buf;
>  	unsigned long *reorder_time;
>  	struct sta_info *sta;
>  	struct timer_list session_timer;
> @@ -256,6 +255,7 @@ struct tid_ampdu_rx {
>  	u8 auto_seq:1,
>  	   removed:1,
>  	   started:1;
> +	struct sk_buff_head reorder_buf[];

Given that sizeof(unsigned long) =3D=3D sizeof(void *), that would probably
be far simpler as

	struct {
		struct sk_buf_head buf;
		unsigned long time;
	} reorder[];

or so.

johannes

