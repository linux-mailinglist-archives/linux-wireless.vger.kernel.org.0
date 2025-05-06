Return-Path: <linux-wireless+bounces-22692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7539AACE51
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A463464B7B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD401207A27;
	Tue,  6 May 2025 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BAGb74G8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E23842AA9;
	Tue,  6 May 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560724; cv=none; b=QqsitXOPZXEozVCvLMiCGE4VTmVL/kcshsfr5lOmCuaK33jDxlEPRQCAusy5XtXDlPuDdyd0Yjfn/hV3PaDbCCYqUIkylz2Z64wcwNXBrhTRyreaUlLI7ww8Yjlq8hWGiN01GAvOKVQrHyo00vkMj6Xe+ylRumIjhLEsFHVMLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560724; c=relaxed/simple;
	bh=kp1bMGzdGurJfc6hPYEwzm56tHB4KU9iWtWa4p+Esaw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FusSkk2l0d5YU3coTmh331p97UijhHzcdglAuUVER68mleTiHuBl2DmxRp1295/p7A0mdwvbN6r6/tLRU9W/87tSd4JKQWhvvlMh5ecDSjmwnAJ68bFwSoZbZbvTSifmxnynqdbXq73fYMMWyBewd/ulFLjKl7AxhjuGQo6xmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BAGb74G8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=kp1bMGzdGurJfc6hPYEwzm56tHB4KU9iWtWa4p+Esaw=;
	t=1746560723; x=1747770323; b=BAGb74G81evAfO1kg585ed/Il+uMSYmsXyE3hlJFSqp7d8O
	VP0CpE8L0nEMvImQamMoqp40/bsWRHcks0Zzd5CX5+3pUxEI6rGsFT4Pk9tEbigt6AhOnNoCJL7ao
	hy+u04rTjGvgM4aPI+TI7bjk2TiC/vOzGqU2vLjvZKPNXGHtIwPrzn2mORezrj7+xGqfN49DOP80l
	LSAVJPtATUjgKWCPWy/c1xFxTLkhLYhdLLXEQevDvBlE97rDS2tGeejPlPeL5nQKTZdfS+iEIzoJa
	sUGf70jgvD7ZC0gezWG9PU6I99tsciIZByZJU892qW6bNBm1eAH2yjPorPV1Xl/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uCOEC-00000006KUD-3JpU;
	Tue, 06 May 2025 21:45:20 +0200
Message-ID: <70308a97ff41d334e9a8f9c42705d83a33122349.camel@sipsolutions.net>
Subject: Re: [GIT PULL] wireless-next-2025-05-06
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Date: Tue, 06 May 2025 21:45:20 +0200
In-Reply-To: <b1991732077354adcaf3d318a008bee9258efe0e.camel@sipsolutions.net>
References: <20250506174656.119970-3-johannes@sipsolutions.net>
	 <b1991732077354adcaf3d318a008bee9258efe0e.camel@sipsolutions.net>
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

On Tue, 2025-05-06 at 21:37 +0200, Johannes Berg wrote:
> On Tue, 2025-05-06 at 19:45 +0200, Johannes Berg wrote:
> > Hi,
> >=20
> > Here's another set of patches for -next, but I know there's
> > more coming, especially from iwlwifi.
> >=20
>=20
> No, wait ... I'm withdrawing this, I need another change for iwlwifi
> device IDs. Sorry.

No... I should go sleep instead. Please do apply this.

That change will go to wireless, and cause a conflict, but we can just
ignore the wireless change later for that since the changes going into
iwlwifi-next will also fix the issue I need to fix in wireless.

johannes

