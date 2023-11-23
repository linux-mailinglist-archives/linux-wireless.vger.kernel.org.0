Return-Path: <linux-wireless+bounces-22-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A277F690F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 23:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 149131C20905
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Nov 2023 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA493E461;
	Thu, 23 Nov 2023 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cM06JoaT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97421B2
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 14:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=95guUuv+ogl9ajTD16KV9pDS1vta6fm4xGG9ISOeqts=;
	t=1700779092; x=1701988692; b=cM06JoaTFKp7y8ZKxSVlt03nckXP8/0UdVYWJe+iE85VgWQ
	mYCG2uNMYXO8mKKFW94WHV4iqw0dwSbk+3oEjF+T5970Kzsh9xOoR58km5Cbzky5pbUJUydlM1mo0
	dDiKH7MbdyElfMEDvkHe+o8gMhZZviDCN6ganXZNke7Qi+CD6c02kdNou0noH3/L+VlT0osXUpGKj
	O3PLOBZRgYlmE0oKEMbQ/GW7i42wCMX53EDMyME55psSDvI6VbTwGJ7h398lKbSSPymgE09+O8HtS
	0nA0iOE/S512leWlgdtucUKRsk4BSAaG4eTpHs2ohWNHdnJd3o9D5FkvWFw+DlHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6IKo-00000001YYJ-3OKG
	for linux-wireless@vger.kernel.org;
	Thu, 23 Nov 2023 23:38:11 +0100
Message-ID: <8353fe1ae02b4cb3ff0f9e663f620416c475ae8c.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 13/13] wifi: mac80211: support wider bandwidth
 OFDMA config
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Thu, 23 Nov 2023 23:38:09 +0100
In-Reply-To: <20231123231437.e13d689aff72.I939d04674f4ff06f39934b1591c8d36a30ce74c2@changeid>
References: <20231123221436.143254-14-johannes@sipsolutions.net>
	 <20231123231437.e13d689aff72.I939d04674f4ff06f39934b1591c8d36a30ce74c2@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2023-11-23 at 23:14 +0100, Johannes Berg wrote:
>=20
> + * @IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW: Ignore wider bandwidth OFDMA
> + *	operation on this interface and request a channel context without
> + *	the AP definition. Use this e.g. because the device is able to
> + *	handle OFDMA (downlink and trigger for uplink) on a per-AP basis.
>=20

Err. I forgot to ever check that flag.

johannes

