Return-Path: <linux-wireless+bounces-11835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7195CA39
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 12:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5EF1C24782
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15BD183CCA;
	Fri, 23 Aug 2024 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P73hFo6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150816DEA7
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724408068; cv=none; b=syDBkTuS0Gq5gLeijw2wuq60E5nFplXvV3JEtL5AJtiiofoFHp71To/HB+yqnphP/Yy0nQ2WTnvr9s8F7mo68nI/t8DTClwLBqzwbQfIcFUwuXKECPUogMqgCKVIN+P39RarsViZPi+QgYZJe9G8OZeDogGatuYxaduAi4AQ1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724408068; c=relaxed/simple;
	bh=REfnr3x4srU/F9eEMp6mdAInkt8DiMW5F8sKK3YBm2c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tjBFnCM+v4MMviWKBXdlpgeTyEamxgCU0PAq1PwSXTHv98aHhh1UtYy1Or3npqSOEq/TSJ9FUehxTFI92y/SYsDU5pqU5YyWEU7k1MLuKJBVMgOpl7KIpigIGVnrx31m6dlL9zUGWVZkqZ29RfMM5+LaG3hci1eRxlwgwQyDsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P73hFo6Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=REfnr3x4srU/F9eEMp6mdAInkt8DiMW5F8sKK3YBm2c=;
	t=1724408067; x=1725617667; b=P73hFo6QZGngVCg6hEbkxygWpJy8TLOOahQdJepFk8sx34a
	HHq/c9j8w8c2IGYWV6Y82dqtNQROXeO/vSRy6BIy2Y7VnWudYjMcAf2d4n3801kf7UXf8iO7XSL4K
	k4q3GX/LWTPDcPWRovJA1MLomDs/Qn5g/hf+AW4UoBx51+kgm63bJJwDQWbD3kvGiDqH7l2bXPjLE
	q8TSLaMYhmdtu8g9fEJZd6I0zhrLbEVWptx3TLrmi6ipY1ozz8EatYjTbNy0ibBQj++wWG7Y0u4EG
	D8yiV5AclOiYx4Ix+YjsLnCievNp7RySl2+MhB+qaYfCrDZPzVHHo9lq5KtQ7kmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1shRJG-0000000FQIc-2N7Y;
	Fri, 23 Aug 2024 12:14:22 +0200
Message-ID: <d222feeb1f584428760236f7dfef5b506874b2b2.camel@sipsolutions.net>
Subject: Re: [RFC 0/6] wifi: cfg80211/mac80211: improve support for multiple
 radios
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Fri, 23 Aug 2024 12:14:21 +0200
In-Reply-To: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
References: 
	<cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
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

On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
> This series adds support for restricting vifs to a set of radios.
> The allowed radios mask is used to restrict scanning, off-channel activit=
y.
> This is also used for per-radio start/stop ops, monitor state and filter
> flags. It can also limit per-monitor-vif rx to specific radios.
>=20

I see the idea, I guess, but but honestly I don't like the way this is
all mixed up between cfg80211 and mac80211.

I think more of this should be in cfg80211 (e.g. not sure why the
changes to ieee80211_change_iface, nothing there that cfg80211 couldn't
do; and generally would prefer to have the patch split), but since it
can never be perfect there (internal scans like in mac80211, etc.), I
guess it really also should come with a feature flag. That'd also make
the series more robust, with enabling the feature only in the last
commit.

johannes


