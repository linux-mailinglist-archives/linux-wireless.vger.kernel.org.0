Return-Path: <linux-wireless+bounces-20747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F11A6D9E5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 13:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19901887F98
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505161DC985;
	Mon, 24 Mar 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="SQzDlLxo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8844C94;
	Mon, 24 Mar 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818455; cv=none; b=j5w1gO7K//poaXDCYp88+qxlVZ+h3VEdGb4yKAtHKZ/R/Ibh7vjqtBu9zCZFu5+TEHWeuivlcfiQJ0XdMPS3C8gwYS8WyTpZh9pC1gAnkaZdv3a6wyS4Wr3h0rD60VIPzhd6qj2Z4Sk32e2LOG9JFjcQnq2+61E02stbUTRnj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818455; c=relaxed/simple;
	bh=tZFx1JtKjwXHIsPl5kXPKqku9E/DMXdkMhCXftAhfFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bi5Xg41cqfQf3sa7INx1nEv+nZlcqdXTsmT9yG/gtQdgL74NzUYuxn3pMi17IFPWlS0vXuMhTI+a1Kt4zUtetQzMjz60rrRSFPE5YftmNeulVnRTu6Z1pVPECxWooYf4B5OcseWvzL7fZQf1uzMnjCJJAaP7QUPczn9m2z032uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=SQzDlLxo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tZFx1JtKjwXHIsPl5kXPKqku9E/DMXdkMhCXftAhfFY=;
	t=1742818453; x=1744028053; b=SQzDlLxomT/Of7V+qG2sh3xilMV1sLfc9UJGCP2XG9w/lJ6
	gg60tTMGyVbxSmbD1mehAN7azBtpA4h1mZZ7Mci2o4D8pSy3r/q+DIIC6YTMNImuGrt5dbY0ABN4y
	Jd9417GKXR9MmwNTG32oVyiFyvNnTTTFeb/+F2LJTnog1hBKrbNWsuVt6LvoBekjz3F2/QJ45XAA9
	mJGMwN9yaRzkZUiAKqumcjbBqbYywlSMMHX47b4urX7d5tbvZDbq6L3AA6zJreE9Ndgs2wXOC43o6
	DVk+yRBzy17wRmbZTzzZOrhHx7fjbz6CgCXj5Nx/FBXCnjlBF03FHo5vBUO3bm6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1twgh0-00000003zCm-45dh;
	Mon, 24 Mar 2025 13:14:11 +0100
Message-ID: <ca69081330005ec6f90b20d2ab8b1b594b90da50.camel@sipsolutions.net>
Subject: Re: [PATCH v4 00/10] mwifiex: cleanups
From: Johannes Berg <johannes@sipsolutions.net>
To: Sascha Hauer <s.hauer@pengutronix.de>, Brian Norris
	 <briannorris@chromium.org>, Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, David Lin
	 <yu-hao.lin@nxp.com>, kernel@pengutronix.de, Francesco Dolcini
	 <francesco.dolcini@toradex.com>
Date: Mon, 24 Mar 2025 13:14:09 +0100
In-Reply-To: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
References: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-03-21 at 09:50 +0100, Sascha Hauer wrote:
> This contains several cleanup patches for the mwifiex driver. I dropped
> the MAC address fixing patch this time as it needs more discussion, but
> the remaining patches sent here are nearly unchanged from v1 and should
> be good to go.
>=20
> Sascha
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> Changes in v4:
> - rebase and test on v6.14-rc7
>=20

Should probably rebase on wireless-next, it doesn't apply there.

Also please tag the tree in the subject, "[PATCH wireless-next NN/MM]"
so the bot can identify the tree better.

johannes

