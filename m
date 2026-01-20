Return-Path: <linux-wireless+bounces-31011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AFFD3C245
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 09:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91121601F9B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99C36B05C;
	Tue, 20 Jan 2026 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VYK818+Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABF341ACA;
	Tue, 20 Jan 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896972; cv=none; b=vEWMmkbUMmssTUYH4u+pMqOq+L4V6bzkdfkoBcD+6eY4yDemU2dSd+yGn8WsxfUXYWoDwYy9t8p8EF0zHpMAEPJDlonOpN0KdwIiTSphO4oeiL6Vg0Z0piCiC57sC+LVSSEXA8gXACKt0Qrfwh8oQSH/wTGFYdm1k/shYydS62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896972; c=relaxed/simple;
	bh=zRoVZahxux2dU7lywSXWdWrWi3I8qtW7f6fu7/bs5+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=el3mmuxACuO5eH2oBIQZKb6cn0GELlyudbtz4tjnP+f2luqTd3jWlo8mnLmQ2MSK9kalDhFZu0WIgb/RMbItK9DAKA32hYruaC1feADefgD8MqObRrGixr0xRAbQI/BcHunC9/HdCeeSFlRBUkeSsBlGPPtuaK3MNpTx/Y5wR74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VYK818+Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zRoVZahxux2dU7lywSXWdWrWi3I8qtW7f6fu7/bs5+M=;
	t=1768896971; x=1770106571; b=VYK818+Q8go30HrB7N+fgsDHs8K5uwW2TXJzTF7DW6UhJDd
	z5/ntQ5CCQXPl5WAuR+5FCmumOi0pe5FaQZywrWIeYylZGm9Ts+zUKNUGuVNY6BccgDy7c3sJqf/r
	Aa2grgWzpwnJ5TH8gkb5v3vjST9E1iVu40w+AwLebAlWsNpgjCv4AnhFDCkjbNnr5NfVYSI1DIDQY
	JXlodCX/UJ6nf6h8gEqrTn4YaxydhjOKoxEDiUU6QjUaObhi3BxwXe28/vIH6w1P538zD9fm+Xg/U
	b0YRrmzCY5ssT3Nwq8v00QN/91AwnXzxcZ8fdT2Eq+tbz9inFGlFRHmrqGk6UrUA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vi6uE-0000000GhiD-3mt2;
	Tue, 20 Jan 2026 09:16:07 +0100
Message-ID: <01724c7be8e023f6b5cd0ac6b48c3e125bc1fd9b.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: p54: Fix memory leak in p54_beacon_update()
From: Johannes Berg <johannes@sipsolutions.net>
To: Zilin Guan <zilin@seu.edu.cn>, chunkeey@googlemail.com
Cc: quic_rdevanat@quicinc.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 09:16:05 +0100
In-Reply-To: <20260119113145.1433315-1-zilin@seu.edu.cn> (sfid-20260119_123712_933163_D9FDF740)
References: <20260119113145.1433315-1-zilin@seu.edu.cn>
	 (sfid-20260119_123712_933163_D9FDF740)
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

On Mon, 2026-01-19 at 11:31 +0000, Zilin Guan wrote:
> In p54_beacon_update(), beacon is allocated via ieee80211_beacon_get().
> If p54_beacon_format_ie_tim() fails, the function returns immediately
> without freeing the allocated beacon skb, leading to a memory leak.
>=20
> Since no other references to this memory exist, it must be freed locally
> before returning the error. Fix this by freeing the buffer using
> dev_kfree_skb_any() in the error path.
>=20
> Compile tested only. Issue found using a prototype static analysis tool
> and code review.
>=20
> Fixes: 0ac0d6cedf61 ("p54: Move mac80211 glue code")

That doesn't seem right, although that commit didn't really "move" code,
it added unused code ... but I think that it probably could go further
back.

johannes

