Return-Path: <linux-wireless+bounces-36240-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOqOCSAXAmoZnwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36240-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:51:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B86A2513D34
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 19:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5218D307DFCD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0905D44B666;
	Mon, 11 May 2026 17:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gbPxxBcV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195F44B68D;
	Mon, 11 May 2026 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778520422; cv=none; b=ConFyF57GAOTTUpXexKBNCTRATCkRyN0WcHrSkDdojX44/bg6Yk4rwzI6ajMkuvp9nu+9D89/6J97ApfrrXdx5+eLYQgKfjOxk+jgJKGEF+4cppodz1IGT5oyT8DLKxMu44hpe7xJgTWjQqpZe/9tEWvFwdM49x0DJd+SP4vD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778520422; c=relaxed/simple;
	bh=kuEApQyEj97ByIMLgegFWF7Mud1PGueeYYdQqSdFRRk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWYEbUkBpVKvOc8/1aKF3Kz45a8CG/fApyoZoLVwAwy9Qe2UGg9LUWDGnHEkE3dNVKHNwhB1nEUAjcl9QdIdILwdTJuMH6J9Y/tAY2CKHmWwPngsZHQBFwsmvjO0ZszGhxxQw2ILTbiPZTcq2YVC3gPMjFq71BVc0950ZPlWDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gbPxxBcV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=TgixBug4UGfU0n8Acc3pU1th1dfSYhb8QObr/Ln36aI=;
	t=1778520421; x=1779730021; b=gbPxxBcVBDNP1bmmwCsbeK5AJV/pYPBXgqoPSHl8H2BjZHt
	43l83SrY4IChTIp3MMkeCvBKy0oOzHiiKiRkfFgk1Qejx8cOIUZIstLHUj/W7VnisDGe1d2AgK3R+
	waMPRNZAlVcziUoHCvADw2rphx/qKNEeFFMoG3J1+UHJDFZR2i7B3xAn6LfItBAUEDHOfHnc9R+RU
	VCdrf0aSeaz8AHlnvmlRHE9DNK2yx9aTql20obrTKn2xx9roTXj7bOp6hIrsVVegbLbEEN4I+EJLn
	9z+5QIeTSgue4UKtgd8oMNTH+mf02rVslpHaAXcepKDNXxcraH/Z9x6ec6n7ANEQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wMUPC-0000000FWNX-0uep;
	Mon, 11 May 2026 19:26:58 +0200
Message-ID: <6d553cffcb0ae84e141006ae1430f6f37909ad2b.camel@sipsolutions.net>
Subject: Re: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to
 USB 3 mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Devin Wittmayer <lucid_duck@justthetip.ca>, 
	linux-wireless@vger.kernel.org
Cc: pkshih@realtek.com, rtl8821cerfe2@gmail.com, linux-kernel@vger.kernel.org
Date: Mon, 11 May 2026 19:26:57 +0200
In-Reply-To: <20260511160811.17647-2-lucid_duck@justthetip.ca>
References: <20260508054421.128938-1-lucid_duck@justthetip.ca>
	 <20260511160811.17647-1-lucid_duck@justthetip.ca>
	 <20260511160811.17647-2-lucid_duck@justthetip.ca>
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
X-Rspamd-Queue-Id: B86A2513D34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36240-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[realtek.com,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 09:08 -0700, Devin Wittmayer wrote:
>=20
> +static bool rtw89_switch_usb_mode =3D true;
> +module_param_named(switch_usb_mode, rtw89_switch_usb_mode, bool, 0644);
> +MODULE_PARM_DESC(switch_usb_mode,
> +		 "Set to N to disable switching to USB 3 mode to avoid potential inter=
ference in the 2.4 GHz band (default: Y)");

We shouldn't really add new module parameters.

johannes

