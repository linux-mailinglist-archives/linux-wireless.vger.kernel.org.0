Return-Path: <linux-wireless+bounces-13236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1DC9879BF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 21:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 569E1286C8C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 19:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCFC172BD5;
	Thu, 26 Sep 2024 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hOzkc+GI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424815C148;
	Thu, 26 Sep 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380322; cv=none; b=napgZ862y4sFR8BYXLhpzHEDXcifrQWoCUOmfETNZ4c7bR4W02G1Ms+7FIqwclKkPZi0cXblCg8QAsORdblYQWWZbeXRGXO7EczuI9C8oYGrm+vVlYEWpa4zriVJfMVYwX8FbfuBGcjAXeoF5BEsic9nMW9F5Djvaza0pVmLzjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380322; c=relaxed/simple;
	bh=FYaGzEAYyqgNgYBUb24PUqDIm62w1I3gjxUTRElVur4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YN8ACtJg3kr1xb3m4WMgfXwV0slgHz5yZEemMs8mvQF/SisfL5CQO1PbC5PfiFB2KaiGEy6j8hwIW2O4b5SMBIkx2f7ZfMdMuFbfsjGBCtRLpjLy6U87achXV1TLLfJVUYxO2pApR4/H3WFi6kBrjwW2oG+/ARdY8/2NyZTwdz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hOzkc+GI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SMnlFNQGeesfMLq1tSK0KYLMpf5uGbkeejNqMXWx3CI=;
	t=1727380320; x=1728589920; b=hOzkc+GIwmUMNScNGIJu/uBQD6BBVNy1I81FzkrJB4/zgcy
	GSZLjDfiIvi/0nWHUwHZNF5yJE3gfOlUOS9kNwL2R58TNLfp4nfksN6eBZQmzv/sy8p6ezf7jy+Fp
	m/VTbKrF9bMHGfVMjmXz90IdPMNWjkrrbkROn99xFs8kfKXcAXZ3zJDbVlvEfuijl16lLwpwXXDOI
	/wfucmbsEmQGK4BRO+TuIkFlwy64we69bFQbHkU3M32G7ys+UAsRJf9pyBRlam7DyCptYVfzL1qlO
	LLw4VENis7RnNgmiKkAIUaqTNmC41ZTB+MP4JT1ifq/l2Kux/ujW033ggiSSll8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1stuWg-00000002UmC-2eXT;
	Thu, 26 Sep 2024 21:51:46 +0200
Message-ID: <84336e03a2634f0d1305cfbdfbae516a7a67364a.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: Convert WARN_ON() to warning message
From: Johannes Berg <johannes@sipsolutions.net>
To: Vladislav Efanov <VEfanov@ispras.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "John W. Linville" <linville@tuxdriver.com>,
 linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  lvc-project@linuxtesting.org
Date: Thu, 26 Sep 2024 21:51:45 +0200
In-Reply-To: <20240926133446.25445-1-VEfanov@ispras.ru>
References: <20240926133446.25445-1-VEfanov@ispras.ru>
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

On Thu, 2024-09-26 at 16:34 +0300, Vladislav Efanov wrote:
> syzkaller got the following warning:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 9992 at net/wireless/ibss.c:36 __cfg80211_ibss
>=20
> This warning is the result of the race condition between the following
> events:
>=20
> event1                          event2                      event3
> __ieee80211_sta_join_ibss()        |                          |
> creates new cgf80211_bss           |                          |
> structure.                         |                          |
> Calls cfg80211_ibss_joined()       |                          |
> which will scheduled               |                          |
> new event_work.                    |                          |
>                          ieee80211_ibss_disconnect()          |
>                          is called due to connection          |
>                          dropped/ibss leaves to               |
>                          remove cfg80211_bss structure.       |
>                                                 event_work starts.
>                                           __cfg80211_ibss_joined()
>=20

Seems almost better though to solve it by removing the pending work when
disconnecting?

johannes

