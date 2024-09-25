Return-Path: <linux-wireless+bounces-13140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B806B9852DA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 08:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA43A1C20D75
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 06:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930114F9E9;
	Wed, 25 Sep 2024 06:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s02RzJVN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607D14C582;
	Wed, 25 Sep 2024 06:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245188; cv=none; b=Vd9zsj3e1zVj6VcOQF0Cu47OlD0DjDI6FhEIwq1hlVi8fD/BU+CnZGvFxdV1Kfrt6xhuJNCHZrA+S8od8i2bg/qeo75bUn4xhAhqWrJSEAVRCv2l/PujBvZWMYaVW1Iuj7wQWpWT4/8Y/xeBCYCf5aXX/1g8Y+8kdXb/7RKfGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245188; c=relaxed/simple;
	bh=n9nDb3Wi4o/YeyVwY1aUIZSbkGwud/4Fwk8YQLrIdtg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ibTsOzSSps7BysIdMW8MKj8+gZodv5qsmAdfonCc0J5cs1IXYj3McV5rWt7RSB4Sd/3iZAHhuVUqrDH2Po83li4Ir117iRiaESGgT4/ESUSgZSTyhCaH0lhCuDpTT4cs8XGl4Ju64RHLokrNcUk0ebP/fZX8qEiy8r7MEYOSvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s02RzJVN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=n9nDb3Wi4o/YeyVwY1aUIZSbkGwud/4Fwk8YQLrIdtg=;
	t=1727245187; x=1728454787; b=s02RzJVNkSw6APTnUJBVU5qh/Npc6wdVpesMmSac+aeh357
	8rbR/3siYfrY/4yvqzm6pncKbIWMc27GIiXgmj+buo6EjpcBCqTSA9b5LaVAIQeZctd37TiI7lhI9
	3xEaCwLyyjGXn+ZhXA4c3xDKmzphqbbuvYxeFgxTTaY+Uhl5pwlUmIFV4zgYqKh9T5AnWy6oS7b1e
	42fauzIz9jMwNjj1/Cx0KZC/rROwffkPxjIoFGUhb0HuuJ0M1PMd1W64A4V8UefSHdq9LHi/7HSJo
	tt0Hr+J6Xz8sAjGmnjA2gGcV94cesxz9ONGOGlLQt9ttPg0O1ReMTrhNp0CGB4CQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1stLND-000000008go-0PBf;
	Wed, 25 Sep 2024 08:19:39 +0200
Message-ID: <13c3221f0cf2c5586dc34e8dcf6758c9e4e6cd4c.camel@sipsolutions.net>
Subject: Re: rtw88: rtw8822cu: Kernel warning in cfg80211: disconnect_work
 at net/wireless/core.h:231 on CPU 0
From: Johannes Berg <johannes@sipsolutions.net>
To: Ping-Ke Shih <pkshih@realtek.com>, "petter@technux.se"
 <petter@technux.se>,  "linux-wireless@vger.kernel.org"
 <linux-wireless@vger.kernel.org>, stable@vger.kernel.org, Sasha Levin
 <sashal@kernel.org>
Cc: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "morrownr@gmail.com" <morrownr@gmail.com>, "s.hauer@pengutronix.de"
 <s.hauer@pengutronix.de>
Date: Wed, 25 Sep 2024 08:19:38 +0200
In-Reply-To: <9d243087654c4f3492d0046b7444c6a6@realtek.com>
References: <80de30f72595480a2e061dc462191c9f@technux.se>
	 <9d243087654c4f3492d0046b7444c6a6@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-09-25 at 03:30 +0000, Ping-Ke Shih wrote:


> I think the cause is picking commit 268f84a82753=20
> ("wifi: cfg80211: check wiphy mutex is held for wdev mutex"), and
> cfg80211_is_all_idle() called by disconnect_work() uses wdev_lock()
> but not wiphy_lock().=20

Yeah seems like a stable only problem (CC them), this is with kernel
version 6.6.51-00141-ga1649b6f8ed6 according to the warning.

> I'm not sure if we should simply revert the picked commit 268f84a82753
> or should pick more commits.

I don't see why it was picked up in the first place, so I guess I'd say
remove it. We won't want to redo the locking on a stable kernel, I'd
think.

> By the way, I think the latest kernel will not throw these messages.

Agree, that seems unlikely.

johannes

