Return-Path: <linux-wireless+bounces-31398-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGYsHT/ZfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31398-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:15:59 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8819BC717
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E96730087A3
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADA31E5718;
	Fri, 30 Jan 2026 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JYW+mo9U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F92AD0C
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789756; cv=none; b=i+AXG/H7b6XLoYN3KYWNwBLnPz658qYSKo32vP5YCKyqxmdedW/oUWdteOqBY/2aN+R/k+1UcH7f3TDCJPAK4DgRkH3gQ5ZdfQCRPX8paZF/uerVbqtCtt00MGA3kkjNTlkR04MQzQdxzbjL/bTOgupTud+H84asdwR3DN6x9Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789756; c=relaxed/simple;
	bh=DLmWUpgOCTmIu9JVjhnpKf+0O7WMWcfPo+XLt25ahjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rK+RYtR3L6igb1CL0megSRoC/P+0ueg565t+1kPuZu7i5UqBzS7CJpEtiOcYaIlaZLYw4lf3lx1vsSgIwN5QUK66uJyoJq3hE5JrbzeomIfaqLj2v4548EiCRarjLU7NUZ++OvUsY9HPwszgDIjdLf+HzVC140k7v9lWkqs9hlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JYW+mo9U; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DLmWUpgOCTmIu9JVjhnpKf+0O7WMWcfPo+XLt25ahjc=;
	t=1769789755; x=1770999355; b=JYW+mo9UqtxWyjk4ARsb1PI9tZmoL79cbpfpZ9qgGzeoXV1
	lOrofc9cro7VgU9syFFAlYjTpOBZSjLkzYFg5DUJxbuFYCssUCWVtVrkulm9HfkrZMeNNxtoG6/Aj
	OrRAV+q2zHjBiPBveJ6B82dx6qhXLA26NS6xUObrZq+/Up8x12owk8/hS898h6PvNMt1/zTzX/Adh
	KVXTR2bZzZeKhh1BDyKGtwi5mDlOyk22iyOld4NtPJRBU510LITEzdIkylbKtZBLZqSMd2X4qCLu5
	P02WYGQuiOODKjKGOZVOdA2GsPS2rFqiu37dTqQ+p/MKBnKWHQzuk+G7DNrzAiQQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vlrA0-00000007xt4-1Uby;
	Fri, 30 Jan 2026 17:15:52 +0100
Message-ID: <8dd352f984cfd23ed178d5917419e15af0c201e7.camel@sipsolutions.net>
Subject: Re: [PATCH 05/13] wifi: nl80211/cfg80211: add peer measurement
 abort command
From: Johannes Berg <johannes@sipsolutions.net>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 30 Jan 2026 17:15:51 +0100
In-Reply-To: <20260130160039.2823409-6-peddolla.reddy@oss.qualcomm.com>
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
	 <20260130160039.2823409-6-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31398-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8819BC717
X-Rspamd-Action: no action

On Fri, 2026-01-30 at 21:30 +0530, Peddolla Harshavardhan Reddy wrote:
> Add support for aborting ongoing peer measurement sessions
> through a new NL80211_CMD_PEER_MEASUREMENT_ABORT command.
> This allows userspace to cancel continuous ranging or other
> long-running measurement sessions before completion.
>=20
> The abort operation is identified by the measurement cookie.
> When a matching request is found, it is marked for cleanup
> and the existing free work is scheduled to handle the
> abortion and notify the driver.

Originally, the idea was that we don't need this, since it's easy to
just close the socket. Are there any resource constraints in socket
handling in userspace that make this necessary? I'm not necessarily
totally opposed to this, but you also haven't explained why it's
necessary at all.

johannes

