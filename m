Return-Path: <linux-wireless+bounces-26578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE7B33882
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 10:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65E36200AB5
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F648393DE4;
	Mon, 25 Aug 2025 08:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="RfJn0GTx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DF29B77C
	for <linux-wireless@vger.kernel.org>; Mon, 25 Aug 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756109508; cv=none; b=Gm0//mD8QKUG15qxfDA+Hsa11IL4wOBVbxbKOfqpRGN8Br2IzJiFEvp5gAdKqKEtID01ns0V3DorR4fko9O5X4n0uv+M6hurHGfdD5p42URNgBTR0RYM0T5Ylx6gR0EV+z4IQVHrRI7DDISadWQMD7THckYbq/2eKSDnXjDvIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756109508; c=relaxed/simple;
	bh=wquP6nheDNhSM556UVhaq8Yu3VMpUxjGqdghLKMSPcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IjXTVAFPDbAlZMLVoOXcOjipD8jkrDZpnoSCyCCAhta/ujmOZ0gyPnFXsWbhlRK6Blkt/Mbq+4kqiD4fRP6RqbIvV7wBca4LmFSE//11D2PYKfzWtYa++AU6vuAqdIidOIWckkGDR9HuM5NGgMsZzeM1E+6QnGoc2khxjUDxeQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=RfJn0GTx; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wquP6nheDNhSM556UVhaq8Yu3VMpUxjGqdghLKMSPcE=;
	t=1756109506; x=1757319106; b=RfJn0GTxH/bBCpjojZ3nEbDu4xY7jFWyBORqsEi8Jc+aXLn
	lQTGZkAFaaFvvOFKr94eo9WG718eGfHipq/9b0e4CwAOiBS5yvU7NfPKuQ1saVJzexTrTlnk9MbEH
	MFzmxwYeodZPUa8himgFPdcXnR8JfYpU2dAct9482GmYqcsmc2Syf5VF2RoqM/mnzXOyZrk+JMRqK
	aL9LA8LF1loAzNM2tTbsoh2ZmvI53tqAlttvI9kJASijIdOPr4xN8t0HZEpzLBYHIdqcUoXbTZYm6
	g9uHNOZVCEqRmMvEyITdLzK3WKqMm949Wjmk/bTkUSEoCzl/bph8T+2d7v6gGiPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqSIp-00000001bMY-1OuB;
	Mon, 25 Aug 2025 10:11:43 +0200
Message-ID: <6f1207c84db7663c646f0b1211ab7894c53f397e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: cfg80211: Increase netlink buffer
 size to 4096 bytes in nl80211_get_station()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Mon, 25 Aug 2025 10:11:42 +0200
In-Reply-To: <20250822050204.476919-1-quic_sarishar@quicinc.com>
References: <20250822050204.476919-1-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-08-22 at 10:32 +0530, Sarika Sharma wrote:
> Currently, the buffer size allocated for the get_station command in
> nl80211_get_station is NLMSG_DEFAULT_SIZE, which, in some cases, is
> insufficient to send complete output to user space and results in
> "no buffer space available" error. This is especially evident in
> setups with 3 links, where the amount of station info exceeds the
> default allocation, leading to underflows and incomplete netlink
> messages.
>=20
> To fix this, increase the buffer size to 4096 bytes. This ensures
> that the nl80211_get_station() command can return complete station
> information for up to 3 links without allocation failure.
>=20
> Fixes: 82d7f841d9bd ("wifi: cfg80211: extend to embed link level statisti=
cs in NL message")
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> ---
> While this static increase is a practical short-term solution

We haven't released this code, so we don't really need a short-term
solution? We could even just disable it from 6.17 instead.

So please let's see how big a real fix would be, or maybe we revert
82d7f841d9bd in 6.17 and do some other fixes for 6.18?

johannes

