Return-Path: <linux-wireless+bounces-36661-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKWFFEx1DGqihwUAu9opvQ
	(envelope-from <linux-wireless+bounces-36661-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:35:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99349580A6D
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 16:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EC01303FF2C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2026 14:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1631ED80;
	Tue, 19 May 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb/kkxQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA127FD75;
	Tue, 19 May 2026 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201057; cv=none; b=Ur2seybhjdIdGAtHl7sv+tzZy3xjCmnX4VqnneD3uu8MHuo044gW8f146giu09YE1bH/JbiASiOriry4M/tzrpNvofqVHr+amozdnvLSuiV9y9f+uCW84PvGT/UAUBnYM1VoRQeWhCkO76WmRQYquMu6/Pzfgd9xmO7kqRTvOIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201057; c=relaxed/simple;
	bh=vJVEETkGBWUMQJVVpXvXyDV7q+8Z00I8HhFUkr6tm10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gU5ebA9YyLnKBVbvqxeDVEb0VMEEGVKmOAt8yoDIz+cDGN3MJQlsCJtlAFc9B/Rgjh3slmLTyoIObpu6Mc6Y9i81CgHLfj3z6iKNqq+NJc41SnAoMQKWN/ECv6RYGx4gUVIxtCT6hOWYJqWz4IjXbOjEU9cMdq4hjp/q+jVJKMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb/kkxQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92F5C2BCB3;
	Tue, 19 May 2026 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779201057;
	bh=vJVEETkGBWUMQJVVpXvXyDV7q+8Z00I8HhFUkr6tm10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Hb/kkxQuZMcHG+E12HLmGO9AJ4R//w787E55fajhj+XnKCaOXgyjnAmIt5BteU4/a
	 5yBte2UVlcVhijYUEtL4DVJ+t4AgLCbb8j73KFc0hn22meqZmfGJqPS6NcUlLAINKs
	 MYJ8drBkkkA+RSiHv4iwKVmeCNxJn9fRw3zs42m1Ahb/pBlZMc+I+V/aQ6fScnTGdO
	 Q1AWL0OWdAAvmpuUouDXLwy3hEX+dLSnN1aS/fGt9mN1cYditYYPOwUUGI/DPDevd+
	 3hvlv5pMYxCaG/MEunCS3RQgrPL+kHOC6D7uzslZJ2X2a/NmAPD6nJVe7ASaWtJHeb
	 XtZ2dYGVtitAw==
From: Thomas Gleixner <tglx@kernel.org>
To: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] genirq: export irq_can_set_affinity() for
 module drivers
In-Reply-To: <20260519011627.713068-2-hangtian.zhu@oss.qualcomm.com>
References: <20260519011627.713068-1-hangtian.zhu@oss.qualcomm.com>
 <20260519011627.713068-2-hangtian.zhu@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:30:54 +0200
Message-ID: <875x4jxyht.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36661-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 99349580A6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

eviewed-by: Thomas Gleixner <tglx@kernel.org>
On Tue, May 19 2026 at 09:16, Hangtian Zhu wrote:
> Export irq_can_set_affinity() for loadable drivers that need a runtime
> check for IRQ affinity capability.
>
> In hierarchical IRQ setups where the effective irqchip path lacks
> .irq_set_affinity(), drivers may need to switch to a fallback policy.
> Without this export, module drivers cannot use the core helper and have
> to open-code equivalent checks.
>
> Signed-off-by: Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>

Assuming this goes through the wireless tree:

Acked-by: Thomas Gleixner <tglx@kernel.org>

If not, please let me know and I pick it up.

