Return-Path: <linux-wireless+bounces-28837-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8D0C4D1A6
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 11:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F755189E62D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AAF34F254;
	Tue, 11 Nov 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bE9p2S6/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5934EEFD;
	Tue, 11 Nov 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857482; cv=none; b=Cbet6jAsuPQN9R1cMsegJMcxHwYrTLcVtNC72F8nLTysh/HbVnVZ9YGjcWm66ScmCnIPLfNdz+mHbTbSaGmgEzKfw/uTbogejkJVkkX6cCWrlOuaCpygXetps2HYpypG0U+8/orhwum09VwA3c6DT8pTu3Pd6V1JX8grIDA5LOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857482; c=relaxed/simple;
	bh=O9ExOg0yKLZyNmbPDTOwbWAHpupzhy530qR9/3ZGr+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+gD8QAl+dWQ9ZswVsFOesyTH/k3T33FMdWOYoPYupwLHUXjB4t2UHtmRVl/HxuAYh6sbeZy1+e4qkf5THtb2wp04TqUt+C5ztq0x+hLfaIpBs4AzxIGdlmCafllm3Bl1Es42KwbPnbPP6Ij1QthdHd0suBQUHydunSLYpGGWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bE9p2S6/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RPfgqO/sDrhGLaAy63MtQwxM65Vqarp77g2HAO5cYOU=;
	t=1762857480; x=1764067080; b=bE9p2S6/j2kCn+ncoVWIGBN/8fROujkTx1sjwB0khrnUEQd
	6tuE1+XoWpvKIRasMSgeqJ8X/VmdiRgPl+NLdaHOxpIsxYI5FBZV2Tb8ql0BM+iSVRjL7+Vsqpmpq
	wevZ6UkxZjmitGYsyldBlsAa4PCsJZ7w7D+0DeuXOMPhFeZpXjTGcwPkqHeA89J1A06pC//ydAqGm
	KGEfODu6l3mGkpHVn6fVIIhdgHeHrUAWLARmwNf8aaaBrddOhw+T6QFuFL9H7Xavl1fbexpRTH36S
	BM8wjwFHxS86560k5a+XQJ5HkMhj2oKhsbLNJJJiwp6tjiAQ+6t/7YQSytmXXmsg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIll7-0000000FSlW-3UZn;
	Tue, 11 Nov 2025 11:37:58 +0100
Message-ID: <4eaa11d66e9b788d9824c5b8ab1f1618791b53f3.camel@sipsolutions.net>
Subject: Re: [PATCH v6 00/22] wifi: nxpwifi: create nxpwifi to support iw61x
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, 
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de
Date: Tue, 11 Nov 2025 11:37:57 +0100
In-Reply-To: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
References: <20251105104744.2401992-1-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So ... I thought I was just going to pick this up now (removing the
'inline' in patch 4 that shouldn't be there according to the bot), but
... it doesn't build (cleanly) for me.

First:

  CC [M]  drivers/net/wireless/nxp/nxpwifi/util.o
drivers/net/wireless/nxp/nxpwifi/util.c: In function =E2=80=98nxpwifi_rxpdi=
nfo_to_radiotapinfo=E2=80=99:
drivers/net/wireless/nxp/nxpwifi/util.c:648:12: error: variable =E2=80=98ex=
t_rate_info=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
  648 |         u8 ext_rate_info =3D 0;
      |            ^~~~~~~~~~~~~
cc1: all warnings being treated as errors


Fixing that, I not only get a LOT of sparse warnings such as

  CHECK   drivers/net/wireless/nxp/nxpwifi/util.c
drivers/net/wireless/nxp/nxpwifi/util.c:654:40: warning: restricted __le32 =
degrades to integer
drivers/net/wireless/nxp/nxpwifi/util.c:655:38: warning: restricted __le32 =
degrades to integer

but also a bunch of sparse _errors_ such as:

  CHECK   drivers/net/wireless/nxp/nxpwifi/cfg80211.c
drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1043:17: error: typename in exp=
ression
drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1043:24: error: Expected ; at e=
nd of statement
drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1043:24: error: got const
drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1043:17: error: undefined ident=
ifier 'static'
drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1058:32: error: undefined ident=
ifier 'legacy_rates'
drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1058:32: error: undefined ident=
ifier 'legacy_rates'
drivers/net/wireless/nxp/nxpwifi/cfg80211.c:1059:40: error: undefined ident=
ifier 'legacy_rates'


Can you please take a look at that?

johannes

