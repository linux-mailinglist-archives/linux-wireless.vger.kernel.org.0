Return-Path: <linux-wireless+bounces-21932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A02A99497
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183DE9C11EA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877B0285401;
	Wed, 23 Apr 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fZydobDQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14740264A95
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423403; cv=none; b=paYRnyX/ywJZORmq+O9enreidEPae8FSY5pdZUwcYUr656NaY6jsYyzrtZXCUF0EOhaW8YFH66n83UPRMM60+5y4DVwWGSjP+hvqNIPnPApvim+IDKrog5iYFXku2QAuTnAHVrT0y2oW4l7AoxOCvemRb9RS70hf4IstV7PMRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423403; c=relaxed/simple;
	bh=cEgdOGtqAGprqQT0vj2e/VKff4T1zpwvjNkJiHHxDdg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pjSvzcVrS/k0I2jolUf9+LP1zz09+rqyFY2AQEchC2mkBmnobom76USA4tYzhEyVLEAQFgBjVntjT+rfBrlby5GZUYQ8DNtKPbt4uMCL37Jc+cOxVVNihZg79C3Yie92ZRIKkTvnPJnf2wYlwoS4+U5LR5GC0q7tIfHEW8oAY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fZydobDQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ChCFxOF45fE1+CQEtl9vrB4/zO7/49wQS3bN/6TB6ho=;
	t=1745423402; x=1746633002; b=fZydobDQECp7XkpI41wXUGayRcdUnn8hI5XHvVL32uGtg0N
	Dt9geG7dhjrU55AUsteIhm4tz/kCd15d6l/C6YtYYXXBNu1+Eyar+foc/n/lXo+25XuefhcgdDn1C
	0VAcjaQJcE6vcbvk9n0ktG0OXFfh12AYT+xYGwBqXke/1K/UN8KQrvwgB4kKkeilzGh0xYd2bWn6i
	mt8HmIPoO5jCqteh2rBgIMyjd9uY2CvWezzzXjMdB2Eelid+FLf2NItl8z59VkUwh5FuTjZxLadxt
	YU1WytIq2iZVzKo5fZ5XOb2umtzBzeu4QDJxUxCD074APR7mm2xa4zSd78wPpy8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7cMJ-0000000Eo9j-0Zgb;
	Wed, 23 Apr 2025 17:49:59 +0200
Message-ID: <bd43aa513f7e76c305a0ef75036347c35127c535.camel@sipsolutions.net>
Subject: Re: [RFC v2 wireless-next 2/2] wifi: mac80211: support tagged EAPOLs
From: Johannes Berg <johannes@sipsolutions.net>
To: Janusz Dziedzic <janusz.dziedzic@gmail.com>, 
	linux-wireless@vger.kernel.org
Cc: j@w1.fi
Date: Wed, 23 Apr 2025 17:49:58 +0200
In-Reply-To: <20250407183818.759759-2-janusz.dziedzic@gmail.com>
References: <20250407183818.759759-1-janusz.dziedzic@gmail.com>
	 <20250407183818.759759-2-janusz.dziedzic@gmail.com>
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

On Mon, 2025-04-07 at 20:34 +0200, Janusz Dziedzic wrote:
> When configured control_port_over_nl80211 allow to
> receive/send tagged EAPOLs.
>=20
> Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
> ---
> [v2]:
>  - introduce helpers
>  - enable only when control_port_over_nl80211
>=20

You still didn't check the frames are well-formed.

johannes

