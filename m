Return-Path: <linux-wireless+bounces-38453-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MsG9CbEaRWo/7AoAu9opvQ
	(envelope-from <linux-wireless+bounces-38453-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 15:48:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D636EE558
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 15:48:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="f/vNQLW8";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38453-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38453-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3ECF8300230B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D298B24A047;
	Wed,  1 Jul 2026 13:48:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC722AE65;
	Wed,  1 Jul 2026 13:48:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913708; cv=none; b=bnbEffxp0LA4RTdmRsHOqLrC439kVAf3q04vY9Yy5CsEnr+HE2gpNSt6hiv+29uGKIrZIOyGzRWBAzPVQGqgGxe0tVmb0ocpYGTIUmobVhRd5FxZdaa5lBm4/Ebdd8zsDa1dqbFzewgvwB+mSvB2G8sPFb4svn/P4fKbQgGaPQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913708; c=relaxed/simple;
	bh=0aF0k3dCXbDs8EWzDI+K1JXtdj6+IiLNyBGGmcZ1U/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqn6cd48QF5nLEIovsdw1NhI6GZPgV37vB57a7ccB/LBir44TFFDGvBEgSnTGT3Pldt3kF9pzsdcCOZV734qA0IfBO6DVCuq5JaQ3lGIvDZXlCvHeQ+0DvK8kFu6UJOrIqs5k5vETCjzrvRYvAmuM+6FME8P4KspCq1cysRyyBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/vNQLW8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA31F1F000E9;
	Wed,  1 Jul 2026 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782913707;
	bh=77oBzAV2L9TMXx/bROM6lzOXrpNGNQibPHkuk2PAc5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f/vNQLW8ImL4jHyjGc8nEK6bGmRZFup8Jt35n8uPPAo733kpsB+g//kU0VwI4IRJz
	 H/aA6pzVHbubiCMYOiYOygF9QbBkcXvmsgwkdY8s/0KKUojafMTNChZAe6xb7g4mUi
	 ARdTZH/zPBnd3w2LQYfHNaY9qPewv9ltfU6nkg50=
Date: Wed, 1 Jul 2026 15:48:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jiajia Liu <liujiajia@kylinos.cn>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Leon Yen <leon.yen@mediatek.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] wifi: mt76: add wcid publish check in mt76_sta_add
Message-ID: <2026070127-footnote-usher-160d@gregkh>
References: <20260528033814.46418-1-liujiajia@kylinos.cn>
 <b143b62e-ca11-4f00-ad60-f71ae55213b9@leemhuis.info>
 <akSoHk-BozrpWPmZ@nature>
 <dc7657b2-e3d5-4777-af52-1169fe743761@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7657b2-e3d5-4777-af52-1169fe743761@leemhuis.info>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38453-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:regressions@leemhuis.info,m:stable@vger.kernel.org,m:sashal@kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:liujiajia@kylinos.cn,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:mingyen.hsieh@mediatek.com,m:leon.yen@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:regressions@lists.linux.dev,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nbd.name,kylinos.cn,mediatek.com,gmail.com,collabora.com,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gregkh:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C7D636EE558

On Wed, Jul 01, 2026 at 08:16:07AM +0200, Thorsten Leemhuis wrote:
> On 7/1/26 07:39, Jiajia Liu wrote:
> > On Tue, Jun 30, 2026 at 01:29:51PM +0200, Thorsten Leemhuis wrote:
> >> On 5/28/26 05:38, Jiajia Liu wrote:
> >>> Since mt7925_mac_sta_add publishes wcid, add publish check in mt76_sta_add
> >>> to avoid reinitializing the wcid->poll_list.
> >>>
> >>> Found dev->sta_poll_list corruption when using mt7925 and 7.1-rc4.
> >>
> >> Jiajia Liu, Felox:
> 
> BTW: @Felix, sorry for the typo!
> 
> >> given that the problem seems to be in 7.1, should we
> >> ask the stable team to pick this regression fix up, as this change was
> >> mainlined (as 20b126920a259d ("wifi: mt76: add wcid publish check in
> >> mt76_sta_add") [v7.2-rc1]), but lacks both a Fixes and a Stable tag?
> > 
> > Yes. It seems to be related to cbf5e61da660 ("wifi: mt76: initialize
> > more wcid fields mt76_wcid_init") [v6.14-rc1]. But I didn't reproduce
> > when I checked it out and tested. So Fixes was not added.
> 
> In that case:
> 
> @Stable team, you you please pick up 20b126920a259d ("wifi: mt76: add
> wcid publish check in mt76_sta_add") [v7.2-rc1] for 7.1? It lacks a
> fixes tag and the problem might be older, but I saw two reports about
> this with 7.1-rc -- so it seems some recent change made that problem
> more likely to occur, so it might be good to fix it at least in 7.1.y.

Now queued up for 6.18.y and 7.1.y, thanks.

greg k-h

