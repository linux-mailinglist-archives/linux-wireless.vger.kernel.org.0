Return-Path: <linux-wireless+bounces-52-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA2F7F788B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2EAB20E06
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0BF33CD8;
	Fri, 24 Nov 2023 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cOzuc7OR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72581B5
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 08:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bUNvOqqggWwhAX95ciZIYIHT3LQIMQE0hwKjtYGZUh4=;
	t=1700841990; x=1702051590; b=cOzuc7ORs9i9qBOOVPF2ilAYj8Z6qkyjIFeH/O7MW9haTyy
	h2odeb5G3uuNVtI9tSjODxiS2/gC/5Z/jd4EVyAGzjEMEPn0dRYazmifys2gEKwxbIJiPevR8QFS2
	j8ILvdCeTdK6aJrSoVyYATpcOjhyUTAtd9jOs2VQPoCdPYClfaWxLS2/XGDuwrhx9umLdgbwLlmCn
	ZK84LyJr06JmzqXckyk/t8bCtGJQ3S9zQpJQhW8zxhIOmNLDZohFv9tzQrzyG2akJNBSnNYb5/wW/
	4/sQEEnBp4e/kwjdCui5xJyC15gltU7ftY+5mV0vOlgU/ZVDZlCnp7WrkPBUVxvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6YhI-00000002eO0-1r8X;
	Fri, 24 Nov 2023 17:06:28 +0100
Message-ID: <4ea5bf5ac1ddd64cfac7802b0c31822d71da7ebb.camel@sipsolutions.net>
Subject: Re: WARN_ON(!cbss) at net/mac80211/ibss.c:488
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Date: Fri, 24 Nov 2023 17:06:27 +0100
In-Reply-To: <1bd8f266-dee0-4d4e-9b50-e22546b55763@yandex.ru>
References: <1bd8f266-dee0-4d4e-9b50-e22546b55763@yandex.ru>
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

On Fri, 2023-11-24 at 17:56 +0300, Dmitry Antipov wrote:
> I'm trying to investigate a WARN_ON() in subject, seen at least once
> with 5.10.200 under syzkaller. Surely this may be a weird artifact of
> using the syzkaller itself, but is there a scenario to trigger this
> WARN_ON() in a "real" environment? And, looking through the code, is
> it a good idea to call 'cfg80211_get_bss()' without checking whether
> the corresponding BSSID is non-zero?
>=20

I feel like we should probably just remove the WARN_ON()? Seems this is
either triggered by a strange CSA request from userspace, or a CSA
happening while also leaving the IBSS?

ieee80211_ibss_finish_csa() is strangely checking for
is_zero_ether_addr(), but I'm not sure how that happens when the state
is JOINED? Maybe there's somewhere a check missing that we cannot join
an IBSS with all-zeroes BSSID?

But I'm not sure how much value there is in digging deep into this ...

johannes

