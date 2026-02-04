Return-Path: <linux-wireless+bounces-31542-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBlbFhFug2kFmwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31542-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 17:04:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED60E9D25
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 17:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31170306EECC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 15:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5321B27702D;
	Wed,  4 Feb 2026 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="xNoMrdXe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9F2D0292
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219161; cv=none; b=IGFwU2ElxFGH9HZPtDMj02GLd+ZCjfMmBuVx+mt9Rbn+dfXwjFmuft9fosJx8+5OIF2jqzIqtnikESWSefSUOpJL2J83i++/3wBOcJz4zLrmo6BWU8ndH5TW0NS289zBDbWNEZoOsB/+0oCE7pumCAFseXO+St/yZJu/cwWuio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219161; c=relaxed/simple;
	bh=seR9ckCDQrrLZQ+bGiJT7Q9b2WFmI5hOTYlGBjWy6g0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8zO8691YJsAra7xffDZIuPBM1PhNw2DqgwaLcNz0DI6KVgBB2tUX9EONs5crYqErYwT40nmwJGecCCvSkvu+YgSLbam+53/BhJQBaIVeFBUjNbt6ZyRSVAJ/nU3Xcy65SHCaaBQx4sQ251EAjPyXQdl677c88S1y3yA59Mdtnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=xNoMrdXe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ajl+w0tQCQH9W8Rznf4XJm8ciXAafXXOIgiya5oQsSM=;
	t=1770219161; x=1771428761; b=xNoMrdXeT33eN7jFC9PkQRC3C6IqxTr8qB2M5W3hpaTpCL5
	QptxMoY7yyKwP1iKLn2405Mz3FlDU4pxaumNuYtZvKVJ+AxjBvuZtsl4cEccGL88QuZcZfXo1HDgX
	lMihQEfSrTC95XwfHheVY578ZuFvFZSzG/DIzfXKw8UJMpHoszzCZqQ9I9GFR4IIrNhUnt7dCeZqA
	WsUHOoIJQI3tnrgAfeAq82b5BBDW7o4qxZ01uVq/cHB8SjkcgkbjSzi3+eM3zU6uosLkCx/Lqq3fo
	qiKJJw4+SPzr4xSU5x8uvzOt3rjqesMpmYsLjoNPzHtCBqgOZlZ8DbDJ6nEXHKSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vnert-0000000ETqQ-3Bou;
	Wed, 04 Feb 2026 16:32:38 +0100
Message-ID: <da71512c862e91e6394184f2b6c39dba009a87b2.camel@sipsolutions.net>
Subject: Re: iwlwifi: Null deref in iwl_mld_reorder
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Date: Wed, 04 Feb 2026 16:32:36 +0100
In-Reply-To: <ed9ab029-a762-4666-85ed-7a67ec7c1b52@candelatech.com>
References: <ed9ab029-a762-4666-85ed-7a67ec7c1b52@candelatech.com>
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
	TAGGED_FROM(0.00)[bounces-31542-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: AED60E9D25
X-Rspamd-Action: no action

On Wed, 2026-02-04 at 05:41 -0800, Ben Greear wrote:
>=20
> I guess the compiler optimized this somehow so that crashes are not actua=
lly
> seen in this particular code path.  Also possible that it is somehow exac=
erbated
> by some local patch in our tree.
>=20
> But, probably best to assign mld_sta after the NULL sta check.

Admittedly not great, but

>          struct iwl_mld_sta *mld_sta =3D iwl_mld_sta_from_mac80211(sta);

That's just a pointer calculation, ie. mld_sta =3D sta + offset, so
there's no actual dereference.

johannes

