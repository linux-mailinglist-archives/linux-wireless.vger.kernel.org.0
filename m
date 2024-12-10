Return-Path: <linux-wireless+bounces-16176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA29EB6BB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B691883BFB
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 16:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2093207E0C;
	Tue, 10 Dec 2024 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jj4mIhmN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450831D5171;
	Tue, 10 Dec 2024 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848961; cv=none; b=jf/3Gnudi39eeLCvLhCcLRmm7ndq511C2SDOeHL7ma1tTMLgDvlMbO5EOhtultktAUbki3XztlGxWHSgkh1i+Gy+RGuzTF+tQYeFvQ9Gb6nQX6nBnWDv3Cf+dgDzI/WlLh8saeXcUWBFsxXexUKeYXclL9VTvtCUPvKMcuktKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848961; c=relaxed/simple;
	bh=du65EmctrjFOWR/rDQAvwY6K/aqh29+WeYpDuCqCVts=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C44j82m6nE57bXnFPpowP6ZXQ8rVnfal/wNXUNMDiKUvcroS3EQ89lQHnuhsdN7LJeZFuN5BtKuWB/rfyfVknwURlAzNAI9cAIIOz3gITes+bvxGku0cSPXr48Iism+6o3YAkbiv/sNjMp9tR35sllJhDTGdgJMeaX2J46cxu3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jj4mIhmN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=du65EmctrjFOWR/rDQAvwY6K/aqh29+WeYpDuCqCVts=;
	t=1733848960; x=1735058560; b=jj4mIhmNzB+9Zi9Y7WMoJQkauVYrwqaMfb2vWnE27dmEvby
	zr1aw1YfC64FY8huxQm4cyQpV069BXoLYahgFZ/px7BzRo6wFcdUiuUivymB2hJ8HkH19dRBIvZGi
	DeLc4PX7qUe2+EYtTdySxS0c+yAIUUu6b9MuvY5fLbGuyia8Ksf3wTGioYd9NxkmHIyaM1/7c83yT
	9880qJ2+PCbz+PCg6nP+aTS4Dtrv2D6EhKIeX7SLmSzp4YaxOXtCgk+JPFxTTRKpLRK8sY8L5rt4l
	GSiwiDPGLsBQ+SbODUnb9J9g2WS4ZGVA9fnffJDonchwwqsCZVt1R1cDIwhIBhqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tL3Jl-0000000CT80-11Ib;
	Tue, 10 Dec 2024 17:42:37 +0100
Message-ID: <cded5fe5b061e76e00473d0bf40c58b90659d3a1.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: cfg80211: annotate struct
 cfg80211_mgmt_registration with __counted_by()
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A . R . Silva"
 <gustavoars@kernel.org>, 	linux-hardening@vger.kernel.org,
 linux-wireless@vger.kernel.org
Date: Tue, 10 Dec 2024 17:42:36 +0100
In-Reply-To: <20241210143951.5685-1-dmantipov@yandex.ru>
References: <20241210143951.5685-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-12-10 at 17:39 +0300, Dmitry Antipov wrote:
> Add the '__counted_by()' compiler attribute to the flexible array member
> 'match[]' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE, adjust 'cfg80211_mlme_register_mgmt()' accordingly=
.

Haha. No.

We _just_ discussed how much pain this causes.

johannes

