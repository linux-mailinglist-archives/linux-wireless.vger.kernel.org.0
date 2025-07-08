Return-Path: <linux-wireless+bounces-24948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77057AFCD13
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 16:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3257AB3CA
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F5B2E090E;
	Tue,  8 Jul 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzSPBN3t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4F52E06F8;
	Tue,  8 Jul 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751983926; cv=none; b=CZSswSNUhV+ieUITZYkZqtAYt34DvPUtbF1TLGTp8096IbrraBsQ+vc28496NlyGMGNJORDR1TFWEh3MizLsUHpkmrBfdaqoS/YaN7WqPiPUIjctqJsarTkKyiForApiv+fTevWwWxnzWoMkESvrV7pHgmmao5mAamAH5rZDGFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751983926; c=relaxed/simple;
	bh=69kRkm6EgMW7idav5pc9DCpei/xJJlkEyeGgKUwRGE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBOjhm7JhcA9IOh0/KbKhOjBLRjRfb8gjAQLOI62sIscYmfqDNAKZNUnXjWrqJoJTQMlt02nfUkVFMepEj19YCAO/glw2VcXTspGSQgYjnsCNa5TQ/3XRuXrZU9gueKqkvQLooD02Sfjv0cTD+omleO0o2qGE1QAqySQ4PrVUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzSPBN3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E42AC4CEEF;
	Tue,  8 Jul 2025 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751983925;
	bh=69kRkm6EgMW7idav5pc9DCpei/xJJlkEyeGgKUwRGE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BzSPBN3tj97lE4r31NyH+0wfxQ6tXnjWLA9zhcUYkFb5a8nO8Z6Y0w9k/43WAyB8I
	 hlWEjyFgE6A6q152X2lw5pCqK0v6945Xp8+F3PRouG1g25vyXQxC3ysOgQUMJigSvH
	 JrHaz3XxysnrgqrABvIqUnFIScqYLjbuDkB7vIM7CbJN6dow+pYAFD1p4WOk3uMt/x
	 NjAW9ngMbmaGzph6BP/zEngwyYdBAFGe2NP8DETzlsIi3BO1Z16oF1nsdlGSa1zSGw
	 LnSSvFJFchRzSyuTu2ApCpCKAoLUqWZaJzghkleeRObbhNRtIjbrPdTHGqTGa7dicX
	 u3sDXugikt5IQ==
Date: Tue, 8 Jul 2025 07:12:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Potnuri Bharat Teja <bharat@chelsio.com>,
 Veerasenareddy Burru <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Louis Peens <louis.peens@corigine.com>, Shahed Shaikh
 <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Jiri Slaby <jirislaby@kernel.org>, Nick
 Kossifidis <mickflemm@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, Arend van
 Spriel <arend.vanspriel@broadcom.com>, Brian Norris
 <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>, Ajay
 Singh <ajay.kathat@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Ping-Ke Shih <pkshih@realtek.com>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Benjamin
 =?UTF-8?B?R3Jvw59l?= <ste3ls@gmail.com>, Hayes Wang
 <hayeswang@realtek.com>, Lucas Sanchez Sagrado <lucsansag@gmail.com>,
 Philipp Hahn <phahn-oss@avm.de>, Aleksander Jan Bajkowski <olek2@wp.pl>,
 Eric Biggers <ebiggers@google.com>, Wentao Liang <vulab@iscas.ac.cn>,
 Johannes Berg <johannes.berg@intel.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Ondrej Jirman <megi@xff.cz>, Jacobe Zang
 <jacobe.zang@wesion.com>, Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo
 <kvalo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Aditya Kumar
 Singh <quic_adisi@quicinc.com>, David Lin <yu-hao.lin@nxp.com>, Roopni
 Devanathan <quic_rdevanat@quicinc.com>, Rameshkumar Sundaram
 <quic_ramess@quicinc.com>, Marek Vasut <marex@denx.de>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Arnd Bergmann
 <arnd@arndb.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@corigine.com, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, opensource.kernel@vivo.com
Subject: Re: [PATCH 00/12] net: Use min()/max() to improve code
Message-ID: <20250708071202.6b65bc30@kernel.org>
In-Reply-To: <20250708135632.152673-1-rongqianfeng@vivo.com>
References: <20250708135632.152673-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Jul 2025 21:55:50 +0800 Qianfeng Rong wrote:
> Use min() to reduce the code and improve its readability.
> 
> No functional changes.

I don't see any patches on the list, 15 min after receiving this cover
letter. But either way, this sort of changes are not worth the churn.

