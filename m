Return-Path: <linux-wireless+bounces-35447-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE3dFpFn8GkITAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35447-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:53:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EAC47F53D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08F6A303DA27
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E2F221DB3;
	Tue, 28 Apr 2026 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qhY86nZM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25DF2836A6
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361902; cv=none; b=CK0Tga0rmmqw4dEcFPgtJxF9NJYBjHEb8t85jVREdrPD/9uMmiE3BKBvbfkWlQZ3lsj36cmASULOr6udxmV/eBwmo5B4qsbyBay3KDg0cWXeJ4KCK7mg+sHyiy4psV1O/BHZ/hsF10SlmkQbmiSZLBjHTSVm4TxKRID5Q/C1PjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361902; c=relaxed/simple;
	bh=PKZjXV+eX8pijZHkSm3/b1csnQl/dFw/8qvuicfBnv0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOyHXzFhGQeiqbqQaCrg5UZRW0z5YrhBSVgLyjOKnhdxeM/6x8cGqDWBouu1nJcGdXW0fKRrMO+avlsU1ny7/8sqIsWRtZ6ybxktlhD5cXTneTFwqCKb5/U1TVWfpAJZnlkz7PLH1X++vP5JURfJfGQ/w0gf1nmAKsWqRUPp0Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qhY86nZM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PKZjXV+eX8pijZHkSm3/b1csnQl/dFw/8qvuicfBnv0=;
	t=1777361899; x=1778571499; b=qhY86nZMew9l8fDZZ8+xkswIOfGDJJm0UUxye/YsxW88rhg
	FSBgTOTNWcJSVJqdOQLdA7SlLACkBCBuM+mmSjfpGeFWrp2QFxA1xklR37qP0w1mViIji7iKcbNsP
	gs0xqJcHBHt2KN8NnWr+rSgK0V2OAkROsOH0++aBqZgO5mwTvCP6tLHZ4L5eWhgFfTy+gAIh1ddHK
	U5kFw476joaQ3strUqWC4V2mbEipDyddHMZYK7EPNFcetiS6hYTZIt90W34Hl6Solwvn0K/yYo6J3
	1OYjtJpLd/WR44wASalftvtDrd8bHW1yPp8ciucyIdMZi/kuJsE0y69lg0njTTuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHd1M-0000000H4sK-0gU1;
	Tue, 28 Apr 2026 09:38:16 +0200
Message-ID: <e3fa97dc1d0bc69477d3a2d2b2bfec6ff0ddff4e.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 2/2] wifi: cfg80211/mac80211: extend
 cfg80211_rx_assoc_resp_data() for assoc encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 28 Apr 2026 09:38:15 +0200
In-Reply-To: <20260427150735.2391680-3-kavita.kavita@oss.qualcomm.com>
References: <20260427150735.2391680-1-kavita.kavita@oss.qualcomm.com>
	 <20260427150735.2391680-3-kavita.kavita@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Queue-Id: A2EAC47F53D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-35447-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

On Mon, 2026-04-27 at 20:37 +0530, Kavita Kavita wrote:
> Extend cfg80211_rx_assoc_resp_data with a new assoc_encrypted field to
> indicate if the (re)association exchange is encrypted.
>=20
> Currently, when epp_peer flag is set, unprotected (Re)Association
> Request/Response frames are dropped. This ensures that by the time
> the (Re)Association Response is processed, the entire association
> exchange is encrypted over the air.
>=20
> Set assoc_encrypted in cfg80211_rx_assoc_resp_data based on epp_peer
> flag when processing the (Re)Association Response.

I don't quite see how this is necessary, even in nl80211_send_rx_assoc()
the whole frame, including header and protected bit, is available. Why
does this need mac80211 involvement? One could ask why it's needed *at
all* when userspace already gets the frame and should probably process
the frame RX preferably over the connect result indication...

If this is needed for some reason please outline it in the commit
message, and reshuffle the code to properly split between cfg80211 and
mac80211 in the commits.

johannes

