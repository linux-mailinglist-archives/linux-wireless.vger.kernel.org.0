Return-Path: <linux-wireless+bounces-2808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0784242E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 12:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07071F2D2A8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 11:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AE6679EC;
	Tue, 30 Jan 2024 11:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Bse6hNjW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE967E77
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 11:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615686; cv=none; b=Lm0/T9YVIa2qE+DaB4zaADykvH0vP5ZZijMYo3J6ZeLoO2MCOREG/OdmMJv6xjYNT3mffuAh+Q7hNe7Kfd8CtI3kclvDBgOmtoqwWDKSLCqfa31FKFuG9h5SgZsqh+/qHBjRzqENIuEh/Ibmzzw986OnvdF9FmfLDVJ5Lg1ylEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615686; c=relaxed/simple;
	bh=i7OMLvm9oEYoKU8KJ/5tXESnerSHEH/rzOiZG7Zlquo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3GIY+4zwV9rJt8d6xQpBHtPAmovo21rabWJ8I8N4rZmjBmHmDGlLw3MkY/DyZ9OT53eEih6ziWAea1e2dEt57D86BwxiJbJKtpS0S5bohNo93rentGWxOeJqi+fcRnA16eqcBvNIyj2dqF3/tqBf25IGzobi9/kfKGEvvEfSy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Bse6hNjW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i7OMLvm9oEYoKU8KJ/5tXESnerSHEH/rzOiZG7Zlquo=;
	t=1706615684; x=1707825284; b=Bse6hNjWo/pnLY10B6M07SXdo7q3yF/tiPkXFRkQewt9rF5
	QaoaF6/jJ56wmCfEgC6YUDlQYaKcNU/FtoF/t6hxM9tyFcmXgtJU46Qepqv9y0GTi2yrvwplq8BKE
	s1YuP0XWy0hNDT7mzB9Ij2TOgFWH4lOPM50U7EfWc3JnN1btgG0X/kjEBKlLQloz+1orq7h872J6+
	Bah44NApqRYdzcetDsCyCsSfUXrVhgH0bYCJVTFflFYBAvmxFDV57Lqh6V4ROzZj9sayqjVhOU0hu
	VQtLgFTam2rn1tt1rGicR7NDC6azmKfI9LUB+GWnC6q3KvmdVZIlIle48Vn3GP1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUmhN-0000000624i-09yz;
	Tue, 30 Jan 2024 12:54:41 +0100
Message-ID: <c67b618f9e40c2629c3eef825788dcf07da76479.camel@sipsolutions.net>
Subject: Re: [PATCH 1/3] wifi: cfg80211: add support for link id attribute
 in NL80211_CMD_DEL_STATION
From: Johannes Berg <johannes@sipsolutions.net>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 30 Jan 2024 12:54:40 +0100
In-Reply-To: <a9e53f21-82f8-450e-bb73-84735e919bee@quicinc.com>
References: <20240125125855.827619-1-quic_adisi@quicinc.com>
	 <20240125125855.827619-2-quic_adisi@quicinc.com>
	 <61ad9e10e42c9f114c2a7de534690f8c0133bf58.camel@sipsolutions.net>
	 <307eaecc-fd88-4fd8-8857-dd3910257d34@quicinc.com>
	 <52287b3162cf6632e7999216cf1ad97b2280b584.camel@sipsolutions.net>
	 <a9e53f21-82f8-450e-bb73-84735e919bee@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-01-30 at 16:41 +0530, Aditya Kumar Singh wrote:

> Yeah :). Even I haven't seen kernel not removing the entries while the=
=20
> interface was going down. Was just thinking out loud here. Tbh, even I=
=20
> don't know the exact reason it was written in that way. Was guessing.

It's probably just old ... :)

> > Note this raises an interesting point in mac80211, in that there's one
> > link ('deflink', the link the STA used to assoc) that cannot be removed
> > from an MLD station even.
> >=20
>=20
> Good point :) I did not think about this. Let me think again how to=20
> handle this case. Thanks.

You don't actually have to now though - you're _not_ removing just
links, you're removing the whole station with all links, as long as it
has a link with the relevant link ID.

johannes

