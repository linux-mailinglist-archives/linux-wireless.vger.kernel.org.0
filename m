Return-Path: <linux-wireless+bounces-27521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB235B894C7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 13:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCB07C4BA2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE403093C9;
	Fri, 19 Sep 2025 11:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="U1gl3/mO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442E19755B
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758282041; cv=none; b=iuHNjzy+CjDmqIiN3w3yE5WCgJul+AHvEEF4dSRFay36mOEkfybgc0gvE9NhjMbirjCAxobRieNGi2vgFcZ/1UdyKu0SQAnUAU8Mi1vVTsnyiqkzFjSZTYloLIkFK3Pphtp66yITp4QG0p7OXvLaRmoPHRu+/alD9WX0NQE24tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758282041; c=relaxed/simple;
	bh=3zYoRj+hLHtQ+jJLgjkaToa3zK+9DGDdIc8FD46cwGI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0sJ6dgidjc56CGa4N+iFdI8aL4FhJISF2JKUMRt1e1/ydkSZFxxB3p2vDVCpak6ux3gBg5Hhy435OxPWOkhRi9v+hhak0qbZ+RT1XMbuGC0M9wbbSaVBKzy7O7dDwhAhy7OgiUaGzlR3ZohFCu1vNpTqlknsXreh3ntjy7ObrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=U1gl3/mO; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9jKSDppvGrKR6LWbEvn6aNqdcpt2C37/ycGovE6WNFw=;
	t=1758282040; x=1759491640; b=U1gl3/mO77el6P+SjPlxPP2aX6T2Dv9AtPOmnw5AmnE2o01
	WkRQ1tkfjELvy1C1FqHHSO03+xhJLsALP1POvtWLvLMKMDnD9xIan0SId6expTzWiUl95LWrUIdq0
	L9RIZRADOnm/EnV11JXZdPsm7qmBgTb7MO+VRvIBtHHuRBMOPdlPr1WKBa2G8gnLAcK18Gd5XNT5f
	ZNWlrfqO7OXIzl1DiKy/pCUBrynkxoWuurozsKFxETEn54w56kyGk5o4fDsKPo7bcWtKi6xe+g4Z/
	i8g0LsDxMSRTtgLw/6P2Gx5SnjTuSHqGbBTZjz5j/PrDzZQy2ui3ezM0/EO0cnUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzZTh-0000000FnN1-2qvp;
	Fri, 19 Sep 2025 13:40:37 +0200
Message-ID: <ac74d2208fb1aaaf93dc6201b09f11201233bf1c.camel@sipsolutions.net>
Subject: Re: [RFC wireless-next 2/3] wifi: cfg80211: set and report chandef
 CAC ongoing
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Date: Fri, 19 Sep 2025 13:40:36 +0200
In-Reply-To: <20250914174622.479249-2-janusz.dziedzic@gmail.com> (sfid-20250914_194653_418370_D063461E)
References: <20250914174622.479249-1-janusz.dziedzic@gmail.com>
	 <20250914174622.479249-2-janusz.dziedzic@gmail.com>
	 (sfid-20250914_194653_418370_D063461E)
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

On Sun, 2025-09-14 at 19:46 +0200, Janusz Dziedzic wrote:
>=20
> + * @NL80211_FREQUENCY_ATTR_CAC_ONGOING: Channel Availability Check (CAC)=
 is
> + *	currently in progress on this channel.
> + * @NL80211_FREQUENCY_ATTR_CAC_ONGOING_TIME: CAC ongoing time in millise=
conds
> + *	since CAC started. Only present when CAC is ongoing.

So reading this, particularly the "only present when" bit ... what does
the NL80211_FREQUENCY_ATTR_CAC_ONGOING actually do that's useful? The
presence of NL80211_FREQUENCY_ATTR_CAC_ONGOING_TIME already indicates
the same thing?
(Maybe internally you still need the value in case it starts at
jiffies=3D=3D0, but in the API? But also see the next paragraph:)

And generally, yes I know we have things that report in relative
milliseconds, but it's a bad idea. We have started reporting started-at-
CLOCK_BOOTTIME values instead, and it's much less subject to drift due
to time of creation to time of use for the values.

johannes

