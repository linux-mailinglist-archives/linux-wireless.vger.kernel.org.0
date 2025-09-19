Return-Path: <linux-wireless+bounces-27516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F733B8912C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 12:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7415A5A9C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C8430C360;
	Fri, 19 Sep 2025 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="F7UQ4zUT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336C30DD2E
	for <linux-wireless@vger.kernel.org>; Fri, 19 Sep 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278033; cv=none; b=WtYXc+hWdjkyxjwQuNDFKOLNaNB8WH5zIRo9783fBqtCxt/1WxuLof5eDFsRh12c2umUd2dcQdq5yqIYFIVhaVBFfRocwMgkxlZwO245JUr+KRgW0WBbQBPIq77Q4CVZ9+5j9nSqch0cyymcia0TZrhp9aBm4qk7LnZDL6w6YRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278033; c=relaxed/simple;
	bh=NEkAnPgtNnJI98BslqSespzX2lakFKXxIyBVDF49iO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rxj/dhUSzPMQhYiLroLNYJUewLJ7DI9/HWKvISbIzxlJo2ug77NEVd87H4IH2VZz6pldFAhTkxDw4F1KTPAsJ2YHxWn/mM7A/4D/cfNJnq3G/sNxzBkFGikIr+Xe5nunt76cw50OWZkYyvi+EbpsobXVGRfOl9Q8b5FVqXAa9oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=F7UQ4zUT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Hwou754GvHA+8bTqs4YPsZeqUbAO7+6O9KVMLycF9qk=;
	t=1758278031; x=1759487631; b=F7UQ4zUTa1g0rwGGYeVC1prYAXBI+1j9IHrUhbJXOot6d5m
	o27gQc3UXzRmWWJNh5FGRJ9t4dXgW2rISYRX6D5lhhDqeG1Tusom0LPbC037WNXN3orCOGP64KCUZ
	jHq9++HDbtgm9Wk9AlIDS6wOHe+8qvfYcJrmbAj+yicjYzUeUQtaHmT5sYaa2IwNlQXUHinpSq1p3
	AH3yHqjsIlaBzAf8kyxlIP0vRNYjcrrjl0zXjqNBOINWFVjPrn7/7L2wPy73xpSeqRnWvqUy+dRuD
	kfA4CbqDkD9027tY5x9FXqNg50Fd8yCJy2FJ80JYwSRm6n8JDr14PXPaHbR+4+Gw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uzYR0-0000000Fi1A-3bq8;
	Fri, 19 Sep 2025 12:33:47 +0200
Message-ID: <f4e33ca572e77755c6db82a37c5372a99a8b7485.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/6] iw: util: support parsing link id
From: Johannes Berg <johannes@sipsolutions.net>
To: Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: linux-wireless@vger.kernel.org, raja.mani@oss.qualcomm.com
Date: Fri, 19 Sep 2025 12:33:46 +0200
In-Reply-To: <20250917055543.27499-4-kevin_yang@realtek.com>
References: <20250917055543.27499-1-kevin_yang@realtek.com>
	 <20250917055543.27499-4-kevin_yang@realtek.com>
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

On Wed, 2025-09-17 at 13:55 +0800, Zong-Zhe Yang wrote:
> For NL80211_FLAG_MLO_VALID_LINK_ID cases, MLD needs to assign link id,
> but non-MLD doesn't. Add support of parsing link id where the pattern
> is as below.
>=20
> 	[link-id <LINK ID>]
>=20
> If found, put NL80211_ATTR_MLO_LINK_ID and remove the assignment from
> the argv range.
>=20
> +	memmove(argv + pos, argv + pos + 2,
> +		sizeof(*argv) * (*argc - pos - 2));

Honestly, I don't really like this, it's a bit too magic? What if you
have something in there that is like

 ... ssid link-id foo bar

and then it *meant* the SSID to be "link-id", but with this it now
actually fails or so? I don't think it's a good idea.

So I think it should just be parsing it where it is at the beginning,
and then for the last patch just put it at the beginning in the help,
call parse_link_id() first like you did already, and we don't get any
such potential mixups?

johannes

