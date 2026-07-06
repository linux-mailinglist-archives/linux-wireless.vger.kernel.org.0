Return-Path: <linux-wireless+bounces-38680-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rRITEQiwS2omYgEAu9opvQ
	(envelope-from <linux-wireless+bounces-38680-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:39:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C377115D7
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 15:39:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b="V/alNT4L";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38680-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38680-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DA653030B16
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 11:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F141F7F1;
	Mon,  6 Jul 2026 11:50:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6628F3BE17F;
	Mon,  6 Jul 2026 11:50:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338647; cv=none; b=EU6QPovESJbc3eQgz3aEDLlYgfMF6a5AOB/gAmc0iGyNCQmcucuQFWFgmtsMWwLYH5rq7cWte5CS78pXBx2RYqhvSO2NbygS8H1jE8DhaY1JssEMKI7KcV56jhDxbMJyAtn3lAHB5BHeE8m6/xcqir03GeMrZ4bFI2has5sRG1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338647; c=relaxed/simple;
	bh=HXUcfuHOZrrP1VZnW2aHgFlqkUZyaY85JueyXtjKaPw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XX3lIVl8mgP9OAmRSthW+J2nhvM3P0GfSvCnQUl+xhGAei70RwTVTsJk9HfS7te3MdGnQ2Ldi04RuFoYPY2xrehwwjKg3Y1Fnx2Uzm87ufJilW1BQuRegxgOnPES0BHH8WhNYYt7oX4shthoFo5A3ehHzJABAYQx2UgMbI63JSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=V/alNT4L; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HXUcfuHOZrrP1VZnW2aHgFlqkUZyaY85JueyXtjKaPw=;
	t=1783338645; x=1784548245; b=V/alNT4LGUqQMgZcTpSV8K+CRIVJPrgxOvaP1BOjo2YAraA
	6TOG/Hfxz7rEb7ZDY0kzEXRKlJ56QACU6SAbG8N2BOWx+K3iW1SkQGRQra7Op38nBwFMgY8dxpDbh
	ArHHfoQFF05FksFLPSM95G+sTAbG8V2amTtXhB1NRVimXFUZgF16RYFSHXGnZ0yvbqxHcaLssb2Gf
	gdo+O2LlhORowCW94PyEFcgnXTu9KL7Kb4Wc7iC+YDofeZPbjzX+uGR1QDmtHPXYrg/CnJr3xh/oU
	lxiGCzlE0UDa1b+vQ4HCgFD3vo8jK9SlMNyC2vit6vt2678sB8mqgyYsL3UNahew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wghqU-0000000DNmg-2eGs;
	Mon, 06 Jul 2026 13:50:42 +0200
Message-ID: <daa380b58ab0cea0c496cdb04c5b6c8b10fd6ee0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211: clear beaconing state in
 ieee80211_do_stop()
From: Johannes Berg <johannes@sipsolutions.net>
To: Hojun Choi <ghwns6743@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Deepak
 Karn	 <dkarn@redhat.com>,
 syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com
Date: Mon, 06 Jul 2026 13:50:41 +0200
In-Reply-To: <20260628141311.12488-1-ghwns6743@gmail.com> (sfid-20260628_161235_921778_27378788)
References: <20260628130802.7698-1-ghwns6743@gmail.com>
	 <20260628141311.12488-1-ghwns6743@gmail.com>
	 (sfid-20260628_161235_921778_27378788)
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ghwns6743@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dkarn@redhat.com,m:syzbot+ca7a2759caaa6cd4e3db@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38680-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,ca7a2759caaa6cd4e3db];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:from_mime,sipsolutions.net:dkim,sipsolutions.net:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92C377115D7

On Sun, 2026-06-28 at 23:13 +0900, Hojun Choi wrote:
> Following up with the concrete path, since the question is whether
> cfg80211_leave() already covers this. It does not for AP start failure:
> ieee80211_start_ap() sets enable_beacon before its fail-able steps, but
> its error path (cfg.c:1930) only releases the channel, never clearing it
> (unlike the IBSS/mesh paths), while cfg80211 leaves ap.beacon_interval at
> 0. A later interface-down then makes ___cfg80211_stop_ap() short-circuit
> (-ENOENT, net/wireless/ap.c:30) and skip the stop_ap clear, so
> ieee80211_do_stop() runs with enable_beacon still set. I could not get a
> driver to fail start_ap() there, so this is by inspection, not a
> reproducer.

How did syzbot hit it then?

> I can fold this into the commit message in a v2, or instead fix the
> producer by clearing enable_beacon on the start_ap() error path
> (mirroring IBSS/mesh) - whichever you prefer. I used do_stop() since
> you suggested it might need to clear that bit.

Who is "you" here? I guess not me?

It seems to me the cleanup paths make more sense though? This looks
really quite out-of-place in do_stop() I think, especially the
offchannel bit? How would that even happen?

johannes

