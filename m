Return-Path: <linux-wireless+bounces-35445-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAwPG7xk8GmWSwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35445-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:41:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC38447F11F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBCDF318DE36
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBF43D75D2;
	Tue, 28 Apr 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUpsCyI2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524BF3C1991;
	Tue, 28 Apr 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361533; cv=none; b=t/cdCtPnJPOCM3blDQQKeeNvU/OWw17DJslYkn9B0nDlSUlid1Av3LvyVr5tCQhgFdQfWgUdQdFhjPpsqFl96+6e+3fYJq07mnvuG9PUxPqCO5aJ6VDAdaYS6v5sb3UthnSXl/2h/N1ISg3/1hXPFgjy9KKSEQXOOfmE35wX4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361533; c=relaxed/simple;
	bh=ta679nTBF0qF6aMOX98uSDCs95HnVt93Xv2e2aIkGPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuG4ZNYHrW9Ilx5KHt2Xg207ae5e41t5VDJMvwQMtTGXGmagjeU3aAq2vETJowKPE1n7ji1F+bcNsmH39ZLHgeP28Q84QHqT67yBNHleJWXv+fbMrIC1E/NBQrv7ht0ewN0NBORnhBE7/M2Mq6D+Fzb88ul+Y10XI8lmYpGNYbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUpsCyI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B1EC2BCAF;
	Tue, 28 Apr 2026 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777361532;
	bh=ta679nTBF0qF6aMOX98uSDCs95HnVt93Xv2e2aIkGPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EUpsCyI2+DA1zj1aLq3/uH2I9xi8Ml7HOIKsjSytN7397tXIUNBiyt778dgIoqTwR
	 DPLc/tMCEbXtYki8jr7nr7MSaOGRw00kwdlQjzS6bPVuLpt87oe0REVKfcsNh7PxXN
	 XNgrarQdDFssxlrb4X4pcsuqW5Ma9PRYx7bD146iqB0DBoKkQ/jv9e+LIpy3uQ64nJ
	 5ivECba5BwftL0494sEsG9yTN2yGNazpyFAs61cAkUbWxfMUalk0FJyHZAzN1IhUWv
	 lTZD2PRq02vEl59ssnaFY5eGSmt1VJ686RjDJFxUYMbmxIVcf+5FGNV+wYri/RgGyv
	 f7UVKfGdxYbWQ==
Date: Tue, 28 Apr 2026 09:32:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: devicetree@vger.kernel.org, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:MEDIATEK MT76 WIRELESS LAN DRIVER" <linux-wireless@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "open list:MIPS" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 3/3] wifi: mt76: remove mt76_get_of_data_from_mtd
Message-ID: <20260428-prophetic-rat-of-ampleness-a20a4b@quoll>
References: <20260427034427.881389-1-rosenp@gmail.com>
 <20260427034427.881389-4-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427034427.881389-4-rosenp@gmail.com>
X-Rspamd-Queue-Id: BC38447F11F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35445-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nbd.name,kernel.org,mediatek.com,sipsolutions.net,gmail.com,collabora.com,alpha.franken.de,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Sun, Apr 26, 2026 at 08:44:27PM -0700, Rosen Penev wrote:
> mt76_get_of_data_from_mtd has been replaced by
> mt76_get_of_data_from_nvmem in all usages.
> 
> Remove it to prevent people from using the deprecated
> mediatek,mtd-eeprom binding.

Where did you deprecate it? I cannot find it.

Anyway, as Conor pointed out, this is ABI break and really poorly
explained. Cleanup is not a reason to break ABI.

Best regards,
Krzysztof


