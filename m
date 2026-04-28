Return-Path: <linux-wireless+bounces-35446-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKQSGMhk8GmWSwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35446-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:42:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CEA47F12D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA9FB3252FD5
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B63D1CB1;
	Tue, 28 Apr 2026 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpGy7DVF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74223CCA12;
	Tue, 28 Apr 2026 07:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361583; cv=none; b=aOe+oIQEi7Z1qsAQtgotPWGaAaFV3mDoK2tlLC8NcYBjQSYNRBQpcIw3h3JnwBOxRpMHMIzliIAuRyiqsLHmIJ7R2ogCBfR5OBYBOaH36nXE08qovUemdjRaK0gUzchCQyY8r63XsbgFA3p2P+tojY56A8cXFmFrffXwQDauEW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361583; c=relaxed/simple;
	bh=6fTlJi+u/tA4P3ALw32S+WETC0LTfCt2D17LQA//3Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ceM9sYHhug0BEFIuuCyEa0vpucbsmLNqgt+Xt6ow0cjJoE2ptzL78MlHs9md1K4rKUgNJN2DU46tMosfEWJUC4aA/ipJOzwooTZ45kBzOEuzvgMcNaxW7waFkN457jzPs/Y4U63+z5D5PFqE02mONWqY6rP+q9u9LazjI1aN2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpGy7DVF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A9AC2BCB8;
	Tue, 28 Apr 2026 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777361583;
	bh=6fTlJi+u/tA4P3ALw32S+WETC0LTfCt2D17LQA//3Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpGy7DVFCqc2tz+PaWmZ2p7pRNgg8LFETk0UaUVr5ifYJTOWvPRBN+vpeP22WoWDq
	 C56OEtBNx7Q1r3apdzOEvOAq1SMo8UctK/m1K2F1bGNwyIU+N1WEjfDXxisU1KM4xg
	 BjlHJzkvzY3wzGUoPkAmSdvm5YxZgECJPhZ9OMPH6fdM+B+h4498MOM+78ScIjw5/u
	 fB46I4mKXaiN4n4YiZgYyk58xm3XVdkWLXwNVlXTGehM53Xc9jRizBsA4LXTZxredB
	 6a1BmClEmFGmfrQPJPr1IVj8i7gFV4T4F850Sg0qTXIIw8fAJLEPqQgHbD8Y9B80F1
	 TCH5DwTMzfA1Q==
Date: Tue, 28 Apr 2026 09:33:00 +0200
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
Subject: Re: [PATCH 2/3] dt-bindings: net: wireless: mt76: remove
 mediatek,mtd-eeprom
Message-ID: <20260428-mustang-of-therapeutic-upgrade-a95f9a@quoll>
References: <20260427034427.881389-1-rosenp@gmail.com>
 <20260427034427.881389-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260427034427.881389-3-rosenp@gmail.com>
X-Rspamd-Queue-Id: C7CEA47F12D
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
	TAGGED_FROM(0.00)[bounces-35446-lists,linux-wireless=lfdr.de];
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

On Sun, Apr 26, 2026 at 08:44:26PM -0700, Rosen Penev wrote:
> mediatek,mtd-eeprom is a widely unused binding that predates and has

I clearly see a user. Please use `git grep`.
 
> been replaced by NVMEM. As there are no users, remove it.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 

Wrong order of patches, you have undocumented ABI.

Best regards,
Krzysztof


