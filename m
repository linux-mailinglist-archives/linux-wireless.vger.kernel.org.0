Return-Path: <linux-wireless+bounces-6420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFF8A7D40
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D22814CA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFAD83CD1;
	Wed, 17 Apr 2024 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kO+i8v0B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA581AAB
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339274; cv=none; b=EibzHFy2+N+Heq8llZQYLHcgrzjZ97yPWCh7fWwMqgqTnd/3yzMKrdz9j730Bb6UJPya52SV1v4/E61ysY4U3jMKvT8uB0dmaqqcF6a/yqT2mRCIJnEIQMVKZnyKbLTIS/1CsidnfAKUG0v0/yyQfI/AA12VkgXt4ISNuB8d8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339274; c=relaxed/simple;
	bh=1JGOKwxcliRmYQDYSbhVcfOwaaQ5Au4rVTzPh/xqIvM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xs7iOY8OxropA8W2/z0KTkn4ghTeynS6crvU/we5/DA/pE0qmKFhx52F7XtmMq+phXmdv5A+NLzsiKEC4zRfvO0Ez0hWQaACisz+qCQJh5JdxEROHVSNISb1/+qRUWcqeVh/pn3YVjBuqdgHPiOwFt+IixxD8UdkqKjV+85A1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kO+i8v0B; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1JGOKwxcliRmYQDYSbhVcfOwaaQ5Au4rVTzPh/xqIvM=;
	t=1713339272; x=1714548872; b=kO+i8v0BkEhJIEL9YimZ9Y8xyKiUHwkrS4R4F2isJmDN2Ty
	FHzWwCcLiMx+4nRd1vpKhKVeBUv0ZAybwmVI9e8Vs9LyY2+DxhruCpLmuyj52U4tbzgzBzREeov5G
	hGWcOlLp7g25m9PBMciBgSlkhpPi7CBMwbj9/WMZ9cNM2n6pfofs/qXONLG3UTXcToxisBfEmJI69
	85ZyxDXgSFO6R4XbZpUfp8EUj+9YKWICyV3t6fF0nOHU/O5+RsGTbeZ1KEdPyEQ1N8qa5P7VgI5AV
	AquQJ4rmFezIgEnlTUndYnllcVD/QKv72ujhRo/b2iGeUyDhP21OVnirPHkgTuGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rwzoK-0000000AkA2-21SB;
	Wed, 17 Apr 2024 09:34:28 +0200
Message-ID: <77db8dd55656cc18c2b0662224231e7a4746dc98.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211_hwsim: Use wider regulatory for custom
 for 6GHz tests
From: Johannes Berg <johannes@sipsolutions.net>
To: changename <chaitanya.mgit@gmail.com>, linux-wireless@vger.kernel.org
Cc: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>, Chaitanya Tata
	 <Chaitanya.Tk17@gmail.com>
Date: Wed, 17 Apr 2024 09:34:27 +0200
In-Reply-To: <20240414173847.222809-1-change@change.com>
References: <20240414173847.222809-1-change@change.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2024-04-14 at 23:08 +0530, changename wrote:
> From: Chaitanya Tata <Chaitanya.Tata@nordicsemi.no>
[...]
> Signed-off-by: Chaitanya Tata <Chaitanya.Tk17@gmail.com>
>=20

I think we need Author S-o-b. Or are you saying you developed it at
work, but released it personally? :)

johannes

