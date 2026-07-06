Return-Path: <linux-wireless+bounces-38656-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0jsZEFttS2rsRAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38656-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 10:54:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA5E70E553
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 10:54:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=schwarzvogel.de header.s=x header.b=JXBskQTw;
	dmarc=pass (policy=none) header.from=schwarzvogel.de;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38656-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38656-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6C9530432E8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 08:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B1B3BB687;
	Mon,  6 Jul 2026 08:19:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.schwarzvogel.de (skade.schwarzvogel.de [157.90.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D130676E;
	Mon,  6 Jul 2026 08:19:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325979; cv=none; b=NkYY+EAF83fXEM8qcbe8ZE3KJGoat4ywxRV2gny65AA+9NUS5DsVWlyWpwyICHVjPDrJwln/UqS40WHj1sKay85rEnFUjtfGOhm87L1IpVVQK6+znN/lOsFZ4UMm4oY7RUHUSKuvotYtNxKYY5dd1K9GDsxuhgW3E87ZvKda5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325979; c=relaxed/simple;
	bh=D9Skio9x3dM41ArZdBd5705/QiNYOtxzP4tQnVmBpgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsGQFdU3P+lNITmkHWuyOfuWWQ4DOUi0uctWrUVWKHAjeaZikEJEH5LN5N+8NxJitJPx9YXTwg2STSyaOKTV58K7THDUXyXHZs4P6vTBPZWK+MnGDxij4uS6qAmqtmz0J7QikFOr9sCHu7H7ClDJ2kfpcLMaCHobX2cm9AzVlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schwarzvogel.de; spf=pass smtp.mailfrom=schwarzvogel.de; dkim=pass (2048-bit key) header.d=schwarzvogel.de header.i=@schwarzvogel.de header.b=JXBskQTw; arc=none smtp.client-ip=157.90.210.195
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=schwarzvogel.de; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date;
	bh=eKAddAQnV4Mof49a5ZigeyhJcCiP49LYRA419jtb8sc=; b=JXBskQTw5CCzHgaZB+4VudI7mV
	68KcNcOXo9HHXyeRzple9XTDPxezjcRRiMisayRHEwz61yknMfqcDDHGxeQFR6L5tYp1QhihKgG3y
	4A0YzbYnkja529pgVOL2Wofr/hjV7S1dSQX9hU0MSBPvoElTgWWG+qZmte46uNwFDidJuaHUt9csb
	MKpWvzpSeHhUT02Mel+DgnQMWFbdfeEJnL6iUrfT5reNqLGof9H+6Vc5gAziPgX7fS5OdZGGYecw+
	hbwfhKr8FbJi4AWk7t6NND1ezyZG7mMFK5ww3sQmP5EdbsdDV5b5xMC9uWbwBJ7izR3If94qeSC3e
	LHJOewDw==;
Received: from klausman by mail.schwarzvogel.de with local (Exim 4.99.4)
	(envelope-from <klausman@schwarzvogel.de>)
	id 1wgeXu-00000000l0g-3HM8;
	Mon, 06 Jul 2026 10:19:18 +0200
Date: Mon, 6 Jul 2026 10:19:18 +0200
From: Tobias Klausmann <klausman@schwarzvogel.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH wireless-next] wifi: mt76: fix MAC address for non OF
 pcie cards
Message-ID: <58c4dee3-5b13-4faf-8803-3d52f59eba51@skade.local>
Mail-Followup-To: Thorsten Leemhuis <regressions@leemhuis.info>,
	Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org,
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Klara Modin <klarasmodin@gmail.com>
References: <20260630210215.400379-1-rosenp@gmail.com>
 <036cc81d-115a-4c0e-9542-71ed2ee04e9b@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <036cc81d-115a-4c0e-9542-71ed2ee04e9b@leemhuis.info>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[schwarzvogel.de,none];
	R_DKIM_ALLOW(-0.20)[schwarzvogel.de:s=x];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:rosenp@gmail.com,m:linux-wireless@vger.kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:regressions@lists.linux.dev,m:klarasmodin@gmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38656-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[klausman@schwarzvogel.de,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[schwarzvogel.de:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[klausman@schwarzvogel.de,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,nbd.name,kernel.org,mediatek.com,collabora.com,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8CA5E70E553

Hi! 

On Mon, 06 Jul 2026, Thorsten Leemhuis wrote:
> On 6/30/26 23:02, Rosen Penev wrote:
> > If seems the check for err is wrong as the proper macaddr gets written
> > to from the EEPROM itself. Meaning checking err from of_get_mac_address is
> > wrong as the proper macaddr has been written by this point.
> 
> By our submission guidelines and requests from Linus this afaics should
> also contain:
> 
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/all/ajRmlyx_AEGybykL@soda.int.kasm.eu/
> Reported-by: Tobias Klausmann <klausman@schwarzvogel.de>
> Closes:
> https://lore.kernel.org/linux-wireless/30a90714-02d8-45f2-a7f1-4cfe0627d50b@skade.local/
> 
> Both of them now CCed, too, to give them a chance to provide a "Tested-by:".
> 
> > Fixes: 31ee1582717e ("wifi: mt76: fix of_get_mac_address error handling")

Indeed:

Tested-by: Tobias Klausmann <klausman@schwarzvogel.de>

I've been running 7.2.0-rc1+the revert for a few days now with zero
issues (not that I expected any).

Best,
Tobias

