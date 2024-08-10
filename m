Return-Path: <linux-wireless+bounces-11247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BCA94DB74
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 10:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E851E281D55
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Aug 2024 08:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427E14A604;
	Sat, 10 Aug 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="JZuDsqR7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB6F14A4E9
	for <linux-wireless@vger.kernel.org>; Sat, 10 Aug 2024 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.239.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723279059; cv=none; b=VcxatPDOXm6KBXjyrun1R5w9LWuGYRIuckGdue06c0ZcPTOBv+nIMuDaxmNtMnbcC6vgYlTFD7RPRYmcD4gQ69ADs4fePAhlBf+qnWR+zXQWjnF/Ko1wFqdxUXMOYund0H1ibrIlx7dI3krGIy1OB1iJ+YL/Xq6E5pSUYVflctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723279059; c=relaxed/simple;
	bh=c19io5mUd5VfK2Ovfhvg6pV/p84vjjrCgNwK5/p2uXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtm6bwB1FohfBrtrQlhkXTCjgXm1do2Tm1O/d0hz1wOkt4FcvJiJOe+LbsMWdWkU6nPbAbcQauuvhS2jycQI54rOYzGGh8GjGQUt9Eubq3NI4IW4dR6hU4GudmOgUBbHvOQAuf9qNk9Hvzcw37U+SaCa9GUrkNvW6wGTXa+WcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi; spf=pass smtp.mailfrom=w1.fi; dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b=JZuDsqR7; arc=none smtp.client-ip=212.71.239.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id C400A11B35;
	Sat, 10 Aug 2024 08:31:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCILicMdTsnb; Sat, 10 Aug 2024 08:30:39 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sat, 10 Aug 2024 11:30:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1723278639; bh=c19io5mUd5VfK2Ovfhvg6pV/p84vjjrCgNwK5/p2uXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZuDsqR7H0u9g9hrm6smUwFg0J5HtG5JJrJrVFf74j6UZC+hZPhQ4pWe0YJjCmcR6
	 wGh6uKl+qHImcni+AyVUZzLAElsrbKPnbXDa8UnZkdwgTGb0VG6y5UPkZNn2uJMo2X
	 JQ6unXNP//LuXxknWITWJ5zMzp/jiZaQYl5S2pI4pj/gSWxWmcwo695LNM2Yc67b92
	 2LVs2F3P67srsdN8CFbDRjgUQxmjq8KwWw33qx22To1TwHlLnYcMzBavLxRA5nVrfR
	 r/8bU07CHamWq72XTaIf+mVL+ZpC8XP9vYuBiIiLuJ9sTDWo3/H1+8yssUF6t2ktEz
	 aL1hiPexRShBA==
Date: Sat, 10 Aug 2024 11:30:36 +0300
From: Jouni Malinen <j@w1.fi>
To: Janne Grunau <j@jannau.net>
Cc: hostap@lists.infradead.org,
	Vinayak Yadawad <vinayak.yadawad@broadcom.com>,
	Aditya Garg <gargaditya08@live.com>,
	Arend Van Spriel <arend.vanspriel@broadcom.com>,
	Hector Martin <marcan@marcan.st>, linux-wireless@vger.kernel.org,
	asahi@lists.linux.dev
Subject: Re: wpa_supplicant 2.11 breaks WPA2-PSK / WPA3-SAE authentication on
 Linux' brcmfmac
Message-ID: <ZrclLHJ63RxnG/B3@w1.fi>
References: <92fe4dd4-21a4-4559-8441-32ef86672de6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fe4dd4-21a4-4559-8441-32ef86672de6@app.fastmail.com>

On Sun, Aug 04, 2024 at 02:23:56PM +0200, Janne Grunau wrote:
> wpa_supplicant 2.11 on Linux's 6.9.y / 6.10.y brcmfmac driver runs in
> authentication timeouts with WPA2-PSK and WPA3-SAE. This was reported
> with Apple silicon devices using Fedora Asahi remix with a patched
> driver as well as other devices without additional brcmfmac patches. See
> https://bugzilla.redhat.com/show_bug.cgi?id=2302577 for some reports.
> 
> I've bisected this to
> https://w1.fi/cgit/hostap/commit/?id=41638606054a09867fe3f9a2b5523aa4678cbfa5
> "Mark authorization completed on driver indication during 4-way HS
> offload". Reverting this commit on top of hostap_2_11 properly
> authenticates the connections. Looking at that change and the code it
> looks clearly broken to to me. As far as I can see is
> `assoc_info.authorized` for the nl80211 driver only set when
> QCA_WLAN_VENDOR_ATTR_ROAM_AUTH_AUTHORIZED is set (in main, I did not
> check older revisions). This doesn't seem appropriate to expect this on
> chipsets from different vendors.

This commit is from Broadcom to fix some race conditions with the 4-way
handshake offload which I'm assuming is for a Broadcom driver.. Whether
that is for brcmfmac is unknown to me, though.

It looks like the goal here was to move completion of the connection
from the association event to EVENT_PORT_AUTHORIZED, i.e., the
NL80211_CMD_PORT_AUTHORIZED event from the driver. Is that event not
delivered by brcmfmac? I did not see any full wpa_supplicant debug logs
for these issues based on a quick look, so I could not check that
myself.

> A revert looks to me like a possible/proper fix. I can send that later
> if no alternative materializes.

I'm inclined to revert this if it is indeed the case that
NL80211_CMD_PORT_AUTHORIZED is not delivered reliably by the upstream
driver and this commit was tested only with some non-upstream versions.

-- 
Jouni Malinen                                            PGP id EFC895FA

