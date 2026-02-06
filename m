Return-Path: <linux-wireless+bounces-31615-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOhTBY2jhWmSEQQAu9opvQ
	(envelope-from <linux-wireless+bounces-31615-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 09:17:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66488FB5A4
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Feb 2026 09:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19F4D306FF68
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Feb 2026 08:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EED2346FB6;
	Fri,  6 Feb 2026 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="c+W+VkTf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6976346FB2
	for <linux-wireless@vger.kernel.org>; Fri,  6 Feb 2026 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365585; cv=none; b=tdo3BCNCW7fKHS7/UR7mmqznVj0FTphuVhaKyD0fRgWoBUqQAT3aDH909e/f4nkRAj5h/zSdyiOAaIPUEteOP8h226jPHqUlsPM3zcAoHkuH+vjiPOXHJhGiEu0dfPBEBQzf3odmzWb3tGRQ669s7FTSPs/W/mlTi+3f1B1mh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365585; c=relaxed/simple;
	bh=RGWtVZkZ8ALF1ZaNmWZolFkwtEwg74tJM3vcrTExLY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mOlBKZ0OkkzoaOm3+qFskuNXpBRE34Q4L10nRSv1QvN1CatWOqjZoJIcQ3HeE8tbTHmFJ3zHfThl9RrDcOmEiiy07RTnNnv2+M83slhWz33b/InXqbdbhWGSTOtHwWC1ixZBrYKb1lqiirE0eRvLiDPs/4Z7EWS2faBQlg2JOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=c+W+VkTf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Mu4jYXSv84xzkWxUrE0xMdWlnrt4DEgMlpXu3jIcPmY=;
	t=1770365584; x=1771575184; b=c+W+VkTfa8YuG+K6/MKcahxzJjWtc7ZEnq0XR8LCCLD2iod
	KWNoIbwGGALmpG0lMK7Kyn9KdRC9O/zUZRD1opDUV7K7NfxJW/zeasSH4gb0GNztJtAM49yFTL8d5
	EfojOGeZJsGp71i3RNpzcfjvH+Lxv1w910iA0xk6J78fuZhdY0fvxquPDvGICwrmxr5pr+YB7F/yK
	yS87R90P8S3iWz+h2zSKQpR+F9TQNN1Pe/qAc4DC81VB3qqq74qSIlzk1WdY8g7DCZWmrFdhBYy7u
	RnHczDBXt9vOBxc0Bwr2JmcXN4KOOG1a5a/IoO6tgm1DamugmOLysXe77aTEjj+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1voGxa-0000000Geay-1oqS;
	Fri, 06 Feb 2026 09:13:02 +0100
Message-ID: <b1ca0fd035801004b11b7e00929dd9176f58eda0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/4] DFS/CAC changes
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 06 Feb 2026 09:13:01 +0100
In-Reply-To: <CAFED-j=jC=Czf37TqeKqJy15on1pdDM3bxG4WCDbMWV2jrXxug@mail.gmail.com> (sfid-20260204_180815_712851_32C67E67)
References: <20260203185717.103810-1-janusz.dziedzic@gmail.com>
	 <6c4341040006e667e0bda79aa8a46111c6ca9ae3.camel@sipsolutions.net>
	 <CAFED-j=jC=Czf37TqeKqJy15on1pdDM3bxG4WCDbMWV2jrXxug@mail.gmail.com>
	 (sfid-20260204_180815_712851_32C67E67)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-31615-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:email,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 66488FB5A4
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 18:08 +0100, Janusz Dziedzic wrote:
> =C5=9Br., 4 lut 2026 o 13:05 Johannes Berg <johannes@sipsolutions.net> na=
pisa=C5=82(a):
> >=20
> > Hmm.
> >=20
> > This patchset causes dfs_cac_restart_on_enable and
> > dfs_us_chan_switch_precac tests from upstream hostap to fail for me, so
> > I'm dropping it for now.
> >=20
>=20
> Doing smth wrong (hostap/main)?
>=20
> janusz@hp:~/github/hostap/tests/hwsim$ sudo ./run-tests.py --long
> dfs_us_chan_switch_precac

I guess you're running on HW while I'm running on UML:

$ ./tests/hwsim/vm/vm-run.sh dfs_cac_restart_on_enable dfs_us_chan_switch_p=
recac
Starting test run in a virtual machine
./run-all.sh: running inside a VM
./run-all.sh: passing the following args to run-tests.py: --long dfs_cac_re=
start_on_enable dfs_us_chan_switch_precac=20
START dfs_cac_restart_on_enable 1/2
FAIL dfs_cac_restart_on_enable 6.219229 2026-02-06 08:10:21.198402
START dfs_us_chan_switch_precac 2/2
FAIL dfs_us_chan_switch_precac 68.059958 2026-02-06 08:11:29.258403
failed tests: dfs_cac_restart_on_enable dfs_us_chan_switch_precac

Oh! It fails with a kernel warning:

WARNING: net/mac80211/driver-ops.c:366 at drv_unassign_vif_chanctx+0x1d3/0x=
39e, CPU#0: hostapd/496
wlan3: Failed check-sdata-in-driver check, flags: 0x0
Modules linked in:
CPU: 0 UID: 0 PID: 496 Comm: hostapd Tainted: G        W           6.19.0-r=
c7-01110-gad3a0d7c543a=20
Tainted: [W]=3DWARN
Stack:
 00000000 00000001 ffffff00 60a32e7b
 6d56f5a0 60031ac4 6d56f520 6003a286
 00000000 60b341d8 60730181 00000000
Call Trace:
 [<60031ac4>] ? _printk+0x0/0x49
 [<6003f6f9>] show_stack+0x10e/0x11a
 [<60031ac4>] ? _printk+0x0/0x49
 [<6003a286>] dump_stack_lvl+0x74/0xbc
 [<60730181>] ? drv_unassign_vif_chanctx+0x1d3/0x39e
 [<6003a2ec>] dump_stack+0x1e/0x20
 [<60058e4d>] __warn+0x113/0x221
 [<60059008>] warn_slowpath_fmt+0xad/0x108
 [<60730181>] drv_unassign_vif_chanctx+0x1d3/0x39e
 [<607a8422>] ieee80211_assign_link_chanctx+0x176/0x4fd
 [<607aa0ee>] __ieee80211_link_release_channel+0x171/0x1c4
 [<6043bae1>] ? rtnl_is_locked+0x0/0x23
 [<607aaa2f>] ieee80211_link_release_channel+0x94/0x9a
 [<6075e998>] ieee80211_link_stop+0x143/0x14b
 [<607570e9>] ieee80211_teardown_sdata+0xd1/0xd6
 [<6075d453>] ieee80211_if_change_type+0x384/0x3b8
 [<6076b076>] ieee80211_change_iface+0x88/0x194
 [<606ba5b2>] cfg80211_change_iface+0x36e/0x4b7
 [<606f4f9f>] nl80211_set_interface+0x24e/0x2b2


But it's consistent with your patches, and doesn't appear without them.

johannes

