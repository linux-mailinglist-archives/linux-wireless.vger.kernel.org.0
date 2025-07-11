Return-Path: <linux-wireless+bounces-25240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0406B01081
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 02:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18CE765F8C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7221828691;
	Fri, 11 Jul 2025 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FU/vnpdK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0E7111BF;
	Fri, 11 Jul 2025 00:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752195565; cv=none; b=Xy6Aur91oocNIcnRSq6xAB5W3xPRIbRbxzGw9ETuDOqSN5PmcGoxwzWXY/Q0J9lEQq+NLUE4iDMvh+XxxoX9gvXsfFa27nGMBd36lHW7SHlbq0S+0IA8savAGi39qTpCZnSy9NG8v/qeuhEQk/0qBZAy9lLLxPCBDIRe5bJGGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752195565; c=relaxed/simple;
	bh=6kbqF4KKi/QRVp8bBz3dPkp4zvRQekHMP/AMbhz2TdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwGf4incipByLvmgQR5iW9oub3Y9gii5s4mvDtcwnEW1DTRZUWhZhwBZuyHFc508NN0k6B9KbGDoPr9RwYKvp20qFGG7oXhf2/zUGpkCaiuMouXHdzsgQA0DztH9DpUIc8P8N6A33SRRRCKQEry1ginD/KIZYAFQdYemC3HeZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FU/vnpdK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF62C4CEE3;
	Fri, 11 Jul 2025 00:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752195564;
	bh=6kbqF4KKi/QRVp8bBz3dPkp4zvRQekHMP/AMbhz2TdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FU/vnpdKKG+wfwPSK/pWWOc856lEG5byID/Rp/rjLj+iTzjeO6JmK+emujGYts7dc
	 vtBX6OhAqS/oZj9zgI3dkDQlf6upgRoZkbLLD+qfXuYycOxmLijDcvLi81k0ZLC24M
	 qx2xCxxUozPG1Om0pYTRdG62JFcOADlX/HnKHewpUNNLjy9uemVXSgci+2N1FthHhe
	 fAspijyuf4YHYsaiqkNWxsj7rto8tNNbM7INcq+oRfRfAMxYxFdyru9Ymek67laAW8
	 TRW7GJ1NORp8CvoGkabhqUYWTHYEIgBnsD3CAC96RiLH6AV7FGMAGzKfXuo0NALqj8
	 HFVQBCVcOvMaQ==
Date: Thu, 10 Jul 2025 17:59:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Louis Peens <louis.peens@corigine.com>, Shahed Shaikh
 <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com (maintainer:QLOGIC QLCNIC (1/10)Gb ETHERNET
 DRIVER), Jiri Slaby <jirislaby@kernel.org>, Nick Kossifidis
 <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Arend van Spriel
 <arend.vanspriel@broadcom.com>, Brian Norris <briannorris@chromium.org>,
 Francesco Dolcini <francesco@dolcini.it>, Ajay Singh
 <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Ping-Ke Shih <pkshih@realtek.com>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Aleksander Jan Bajkowski <olek2@wp.pl>, Lucas
 Sanchez Sagrado <lucsansag@gmail.com>, Philipp Hahn <phahn-oss@avm.de>,
 Eric Biggers <ebiggers@google.com>, Hayes Wang <hayeswang@realtek.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Johannes Berg <johannes.berg@intel.com>,
 Sai Krishna <saikrishnag@marvell.com>, Jacobe Zang
 <jacobe.zang@wesion.com>, Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo
 <kvalo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, David Lin
 <yu-hao.lin@nxp.com>, Aditya Kumar Singh <quic_adisi@quicinc.com>, Roopni
 Devanathan <quic_rdevanat@quicinc.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Arnd Bergmann
 <arnd@arndb.de>, netdev@vger.kernel.org (open list:CAVIUM LIQUIDIO NETWORK
 DRIVER), linux-kernel@vger.kernel.org (open list), oss-drivers@corigine.com
 (open list:NETRONOME ETHERNET DRIVERS), linux-usb@vger.kernel.org (open
 list:USB NETWORKING DRIVERS), linux-wireless@vger.kernel.org (open
 list:ATHEROS ATH5K WIRELESS DRIVER), brcm80211@lists.linux.dev (open
 list:BROADCOM BRCM80211 IEEE802.11 WIRELESS DRIVERS),
 brcm80211-dev-list.pdl@broadcom.com (open list:BROADCOM BRCM80211
 IEEE802.11 WIRELESS DRIVERS)
Subject: Re: [PATCH 00/12] net: Use min()/max() to improve code
Message-ID: <20250710175921.09212fab@kernel.org>
In-Reply-To: <20250709022210.304030-1-rongqianfeng@vivo.com>
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 10:21:28 +0800 Qianfeng Rong wrote:
> Use min() to reduce the code and improve its readability.
> 
> No functional changes.

For net/ethernet/ this is not worth the churn, sorry.

