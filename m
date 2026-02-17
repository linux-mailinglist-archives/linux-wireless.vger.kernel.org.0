Return-Path: <linux-wireless+bounces-31953-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCGVMah5lGkfFAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31953-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 15:22:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D9914D1A5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 15:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F6A301E3CF
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B0836B066;
	Tue, 17 Feb 2026 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jorqEAYX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78D36AB7A
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338109; cv=none; b=QOCHcRWAXNYiELTqSXoso6oFEw4UzmAg73gqlj47xnYlAkO2D5GnE6Q56lmUmSsOnjpBrtiz5NAUr0ALRs9OD/lo5OPirW0NUVyaWyFwNSiyIE8Xe0RS9qA/d/PFhWaI4Azhm2o16g/4wd++gFAkG3FJa+uZSBxPaQ3Jree0dwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338109; c=relaxed/simple;
	bh=AduYWLpT1kbOT7xBIEbrz2/YRLmTA61HWvD/yWHod+s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OikvGUmaBm0MiW0ygM1gZlwT8yQjPi9z4i7BdMoRDp0TUxhKsVWzQCTZCY7/P5AB++Z+Tbua22pPNro0/XC7z5XQYgupQ3iBAYLYqO6bDQpG0rFHB9h7c5lK/PUdSjU55ZPn8zjIHYEJEBspqiHjHc/bIxr2nWwGwSleUBga0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jorqEAYX; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=CUxHkIRkmraeLsyQecCzOOsEHcF2v6Vh+99t9alxL4c=;
	t=1771338108; x=1772547708; b=jorqEAYXIli5NB6rDG1Qd2DfI5Cp/VQCvAYBFaOp+0J4FtY
	jt4D4zPBUbnHQnhliDjv311HFN2A7Pj4cnxnmEcnEJSiMF26SK5myAx6+LEeTYnJtUwUQz+q1X9DJ
	M8eKXy4M2duiqdl3qpNY9jvrJMt7plp9T3zL46I0WqebQJty69YdLWyD7zpA6umy+nCWKMNXSIfOR
	H7RXaAwIhp5xYdmwAyz/Kl5NhyeBVnqMjsMHpvjlqHIcB8BO1rgnrZLm6jdYuZLwfH5Tn+M2EZvpM
	oNj83Kr/IuyMIstpCaAQfiHWbGeQLnYlfmNc2liD9lZ4Psel2wWRgNY5q2KbRStA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vsLxR-0000000BR09-2i8H;
	Tue, 17 Feb 2026 15:21:46 +0100
Message-ID: <b2d66cfe2e3e4b1dd51f2bd15ae68932bbd6ec2f.camel@sipsolutions.net>
Subject: Re: [PATCH v3 wireless-next 08/15] wifi: cfg80211: add support for
 NAN data interface
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Date: Tue, 17 Feb 2026 15:21:44 +0100
In-Reply-To: <20260217134342.2d455362bd3b.I92973483e927820ae2297853c141842fdb262747@changeid>
References: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
	 <20260217134342.2d455362bd3b.I92973483e927820ae2297853c141842fdb262747@changeid>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-31953-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13D9914D1A5
X-Rspamd-Action: no action

On Tue, 2026-02-17 at 13:56 +0200, Miri Korenblit wrote:
>=20
> +void cfg80211_leave(struct cfg80211_registered_device *rdev,
> +		    struct wireless_dev *wdev, int link_id)
> +{
> +	ASSERT_RTNL();
> +
> +	/* NAN_DATA interfaces must be closed before stopping NAN */
> +	cfg80211_close_dependents(rdev, wdev);

Turns out an equivalent change is missing in cfg80211_destroy_ifaces().

johannes

