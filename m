Return-Path: <linux-wireless+bounces-30582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456AD062FF
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 22:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C330930191BE
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 21:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFC3331207;
	Thu,  8 Jan 2026 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="CkY9L36x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B305332C33E;
	Thu,  8 Jan 2026 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906067; cv=none; b=R+lVzLwOUuUE480U3mBJFb7XABEeeRwZwEM/siOUxt8ft4kqxeoHQ7WeGcw+Zmz/XP1DDdW67cMZkOev/oOUCN6+RNmEVV1GzSy1M25pRAjYxYoGmFyjOytHv4TgmYCce9XMY1s8/SpXD297xyInpWT5NhCUccd2rI6+O1GpcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906067; c=relaxed/simple;
	bh=BbFOPKtICU12KDM/+ShyhCJxoX8pKD/+VzzvP5dsT4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vCparJ0tz4MUXCjM70sO6nKNkp1eyQ2mhWDkrHzHqhjkv78fMBiFXEUNpW82GQCRVdZUOg3UE1CwcPl69WCv611filzcMaHYVTDlddvnFax1zvQz0X/vcRxSrJUZbLSrrnAnnDL0nLW3/0Egp5YDyZRwVcll/GQWiI5HXZxSuGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=CkY9L36x; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FKc/gUSESEyiCZn/ICjBaYugtGVm9hDBauiqQssLMpg=;
	t=1767906066; x=1769115666; b=CkY9L36xLJDb0d1Q219cgaw/2ZgEkHhYIzEEw0gOzIlscgT
	VwguF9pwF3e3RX20JKKjt84uEvnsA6KOC9gqPEydLZVXcCSksLXeRi0nJQInb5hzEacZtXAq4qhxJ
	QsOb9y48OhKfam8DytP8NQQbd7btG2jRbZcuQ/qr1/hB4hybxpp7bhP3ouyTPH4WKLblA5TKO18zl
	W+WtTYGOHt7xxUfktP1/1I3xyovwGdMTUiph4jVAWQwiJH06jLhSRtBqKQs0BlYixAeZ+4448Izyc
	teAFETt5VGvdJK2aYQnmWU1Ayuhpc7BrgnWsxJoSo/cgy1ZenyUlRo0G5gJ41h4Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdx7u-00000006j15-1fql;
	Thu, 08 Jan 2026 22:01:02 +0100
Message-ID: <e4f3a3d9775d975f33c307bb5b01b26d3ad9daff.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mwifiex: Fix use after free in
 mwifiex_11n_dispatch_amsdu_pkt()
From: Johannes Berg <johannes@sipsolutions.net>
To: Dan Carpenter <dan.carpenter@linaro.org>, Amitkumar Karwar
	 <akarwar@marvell.com>
Cc: Brian Norris <briannorris@chromium.org>, Francesco Dolcini
	 <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>, Cathy Luo
	 <cluo@marvell.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date: Thu, 08 Jan 2026 22:01:01 +0100
In-Reply-To: <aWAMMdynZDz1uWAi@stanley.mountain> (sfid-20260108_205750_303869_85C5E54E)
References: <aWAMMdynZDz1uWAi@stanley.mountain>
	 (sfid-20260108_205750_303869_85C5E54E)
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

On Thu, 2026-01-08 at 22:57 +0300, Dan Carpenter wrote:
> @@ -44,7 +45,7 @@ static int mwifiex_11n_dispatch_amsdu_pkt(struct mwifie=
x_private *priv,
>  			    ntohs(rx_hdr->eth803_hdr.h_proto) =3D=3D ETH_P_TDLS) {
>  				mwifiex_process_tdls_action_frame(priv,
>  								  (u8 *)rx_hdr,
> -								  skb->len);
> +								  skb_len);

I'm 99% sure that should be rx_skb->len at this point, it can't want to
handle a single A-MSDU encapsulated action as if it was as long as the
entire A-MSDU that held it, that'd likely crash (too), especially if it
wasn't the first frame in it.

johannes

