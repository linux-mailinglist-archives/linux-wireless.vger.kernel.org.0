Return-Path: <linux-wireless+bounces-38679-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0YxwB9eVS2r2VwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38679-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:47:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7814A7100B1
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 13:47:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=J9E2wZkW;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38679-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38679-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FF1F30117A1
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 11:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BC741F7F1;
	Mon,  6 Jul 2026 11:47:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8163FD14D;
	Mon,  6 Jul 2026 11:47:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338448; cv=none; b=oHmO7gFUS069vXaWMwgSxN6CUDFv/KVx0cEkw4x9YVrFeFNkB3L6dR/xfMEhxg+E4Ryu2Q1nfjFPt/warc3PSBeTH/jwrBy4To9UKJB5yeCJC0IDCh+BdZbtXSkT4wLxK09o9wxl+svcI65wueUW12egMo06x5yK2x5FI9pVC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338448; c=relaxed/simple;
	bh=w/+dOqGuQIuH0grBXnx/cqJx/6F3mIWhizKWONFKFLk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u23RtAaQZ6w/f+jPl71ygXD4HRbRU5/4DrlifTw3XFOpgSrXUct/S/6l4lmILapPyqr5pIvpKbrcXhBL7dyxqDBhBEJ+5Hr9ASt/cn0BnwJ0YgMKQgsDZn++tWzNKSfwIvXZq8ega8Qs1qiX2pmK/5K0N1YzdtfA2BgCC6A2jTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=J9E2wZkW; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=w/+dOqGuQIuH0grBXnx/cqJx/6F3mIWhizKWONFKFLk=;
	t=1783338446; x=1784548046; b=J9E2wZkWOGarCKXCAlfFvQEi+z06jNg/avWr7glReGXQN+f
	KQPfyE6UWUdcTWsH0i8/ufG1Ed+do5OXuVEwlBf6VKy+vlEnCVANxtBW3MmeGcvY7K939AWVDhuMU
	4VfdMm7uVzMK754JX2pNa/frTy1qi0fZe3jg3Gi7/UbB6r4nvSjRthiLjcZi8nO0eeaVQuxgNJ7IT
	00Ud9ACWk3UveFLmxhyzMLJnkYMSyNah3KfHLIrafIBUaIlvQUfgYyQ/8269b0dWu7v8cyj4BFPjx
	WKhGNz2/vetbkeq8gL2S3/eT5PbngKSrRkI39XZIb8CFFJbB7MlkBST0hXCxp7Lg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wghnH-0000000DNfF-2SFk;
	Mon, 06 Jul 2026 13:47:23 +0200
Message-ID: <986fff6416ba2acd8d7a4e5fb2f6a89eb40e10d1.camel@sipsolutions.net>
Subject: Re: [PATCH net] wifi: mac80211: fix memory leak in
 ieee80211_register_hw()
From: Johannes Berg <johannes@sipsolutions.net>
To: Dawei Feng <dawei.feng@seu.edu.cn>, jeff.johnson@oss.qualcomm.com
Cc: jianhao.xu@seu.edu.cn, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org, zilin@seu.edu.cn
Date: Mon, 06 Jul 2026 13:47:22 +0200
In-Reply-To: <20260609074044.3745473-1-dawei.feng@seu.edu.cn>
References: <dffefec6-14e0-4a87-85dd-97d328fedb50@oss.qualcomm.com>
	 <20260609074044.3745473-1-dawei.feng@seu.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dawei.feng@seu.edu.cn,m:jeff.johnson@oss.qualcomm.com,m:jianhao.xu@seu.edu.cn,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,m:zilin@seu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38679-lists,linux-wireless=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7814A7100B1

On Tue, 2026-06-09 at 15:40 +0800, Dawei Feng wrote:
>=20
> Zilin is the discoverer of this bug. We are in the same research group,
> and he actively participated in reviewing this patch.=20

Reported-by? Reviewed-by?

> To better align with the kernel submission guidelines, I will add a
> "Co-developed-by:" tag in the v2 patch for Zilin to properly reflect his
> contributions. Would this be acceptable?

If he did development, I guess?

Anyway you didn't do that for v2, so please resend after you figure out
what you want :-)

johannes

