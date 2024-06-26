Return-Path: <linux-wireless+bounces-9607-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A40A79180FC
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABDC1F23651
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835D110A11;
	Wed, 26 Jun 2024 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WZLa+sTD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FA71E51D
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405347; cv=none; b=SEx8jvysgAKJsow+orELcGwQlyFHm2yOUPAkXXdDT5To7AtZDNZ77VCciBpdD/0edG/CeRke5Nofo4wMpZXe+0vfxa2HgV/jeS266vleh3/1EXbrCq7pH8xwefidnx7AeILcREG7S0JU0gkdROlbtmRtptIOPmMMqI9WDbNEzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405347; c=relaxed/simple;
	bh=Atpd7md36goCPjKH2hhLTZY5by0QBTsu6OzRGcVgNkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qr6THb/i3yWYxSN7YIhQpuBDImaOCBU3RNih3yk/zrT7bCQfQ1Zj0K2oUjebsiLt+3rNU2tHZByHYEGTo2BEo1Mcvl37ev08uBfuVYktZYGfDev8nvN+WrjN9zkgwQh33G51rACA+j+6UhWqd5dxVHKcMfIB4Vk9KreLaa0S1AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WZLa+sTD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gtCC8KCoqnosUqDKC0PCDJszxkJwE6tkC7vlEO9WAeA=;
	t=1719405346; x=1720614946; b=WZLa+sTDItRxsNd/5QwtA/16FLfXlkwjO2ciVA2GIzLNAl8
	6CiTcZ/F82WGc38etcgeVjwcrnUvNiRWo1epdNMOkOhdoHOEy2XcWyCZtRt6kLt4oNeyka7+Abg+3
	S4da3hqzd68CRzG0njaVzeVhsLUTsJwKGoJZ+enM0hAJ3Oe1HrdyWUhjKQo7zbzUh6MuVDvRNEWcj
	xnpcMMNyMKLLZquT7ZF6svw2A5QZm8+MZwjo9Kt4jrTOqg1QbAyZp0alUH0zCUto4HpJYx4gPClZt
	XmqfqoPa1yVXTmhVoN+Rj8C61T63Xz+lqkXJ0cqGM2qHexADwrRLmQ3UwTpPlEuQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMRsE-00000003eLs-43QT;
	Wed, 26 Jun 2024 14:35:43 +0200
Message-ID: <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
Subject: Re: [PATCH v2 8/9] wifi: mac80211: handle
 ieee80211_radar_detected() for MLO
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 26 Jun 2024 14:35:42 +0200
In-Reply-To: <20240626045216.3754013-9-quic_adisi@quicinc.com>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
	 <20240626045216.3754013-9-quic_adisi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>=20
> Hence, in order to support DFS with MLO, do the following changes -
>   * Add channel pointer as an argument to the function
>     ieee80211_radar_detected(). During MLO, drivers would have to pass on
>     which channel radar is detected.

Makes sense, maybe?

>   * In order to pass on this channel information to the radar detected
>     worker later on, introduce a linked list 'radar_info' in the structur=
e
>     local.
>   * When driver calls radar detected, a node is created and added to this
>     list and work is scheduled. The work handler takes care to process ea=
ch
>     node and take further action.

Not sure I like that so much, it adds book-keeping and all kinds of
extra things.

Couldn't we just have a flag in the channel context or so - there must
be one, after all? And perhaps pass the chanctx from the driver instead
of the channel?

Actually, we're already having to do a channel/chanctx lookup in
ieee80211_dfs_radar_detected_work() so it seems pretty weird to add more
complex logic to it...

Please consider just passing the chanctx, and then we can set a flag
there, and not have any of this.

johannes


