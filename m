Return-Path: <linux-wireless+bounces-22050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7542A9C21C
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 10:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07B41893714
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 08:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C921FF3C;
	Fri, 25 Apr 2025 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sK5lRm3P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97C2236429;
	Fri, 25 Apr 2025 08:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745571082; cv=none; b=h7gD/wXR4qr4JHKNlAsDsTfhPvwIlw8JReP5Hb/m6m+30PG4RoON/nUfgTwVGfH7ikK7UZXeZGyfG2NWpEO22R5uEA7ZRARygrdsb92awURjvmFBv6mI9fISKFozobtn0SJYGi1Q1wh1xAWkb3H/Da5BnjwaWBuixBsXWdjywgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745571082; c=relaxed/simple;
	bh=GsdKqhaZHVy1X7q+VEL9powEi92d1+8HwMYyPzldJWE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=spKwyRNYOyG91JBDYOZBsQ7klCvt6C4kZdOqZzoI9eb6NOUMUJTqhN9Naq7yPAw5Zyw26CTvV6863clFPD0Dw4o00XYWsFlkB8OxZalmlKcEaWSJfHLSjn+dECgPatsvp/FoZWQlcr34eyrfip/6t2WS7ih7fA17yWBi6d6wZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sK5lRm3P; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GsdKqhaZHVy1X7q+VEL9powEi92d1+8HwMYyPzldJWE=;
	t=1745571080; x=1746780680; b=sK5lRm3PsM7hk4mMlRrrsav3dgLVDWj6FnpLsQDwZi4Xba5
	O49e7LmLsg1RDzue6gqzs+vLjecaplW0lIZz1at2wIrOx5w/dUKqzrCWy+Kgi8AKClN40v0o4+qo4
	9D9W99aXgOGuUbahXPP0gtnUXj/ZCbRzNmIFqBBoWGo35GI8ygSgux/hPRhfwvfgQ61cQ7M5uxACe
	E5As2/SuiAbywOn9t8zYvJtkoo9AZjqEtAX56gdnOetmEQvRgcocFHoB9ds7EF5b8Vh/Bon048fa0
	kYNNk3apKMxR4yrIEkCNpmOPKpUWO43PoYDmoNUToQ5LpoTBB9t0M5N90tfiPeFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u8EmD-00000001B78-2fHA;
	Fri, 25 Apr 2025 10:51:18 +0200
Message-ID: <c03e8384c0c1e338ee9e874780f684d45ce1f1e1.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 4/4] wifi: brcmfmac: Fix structure size
 for WPA3 external SAE
From: Johannes Berg <johannes@sipsolutions.net>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, Ting-Ying Li
	 <tingying.li@cypress.com>, Ting-Ying Li <tingying.li@infineon.com>, James
 Prestwood <prestwoj@gmail.com>
Date: Fri, 25 Apr 2025 10:51:16 +0200
In-Reply-To: <95cbaef6-761b-4ecb-a722-a546bb034939@broadcom.com>
References: <20250424194239.2825830-1-arend.vanspriel@broadcom.com>
	 <20250424194239.2825830-5-arend.vanspriel@broadcom.com>
	 <850b42ab-a637-4dd9-af18-e12523983ded@broadcom.com>
	 <44916ff608ee53238d79e57ee31fcbf86dfb672d.camel@sipsolutions.net>
	 <95cbaef6-761b-4ecb-a722-a546bb034939@broadcom.com>
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

On Fri, 2025-04-25 at 10:49 +0200, Arend van Spriel wrote:
>=20
> Crap. Just sent v2 executing my plan as stated above. v3 or is the=20
> mai..eh..custodian willing to fix it up?
>=20

I'd say yes, but honestly I'm not sure I will get around to it today,
and will likely forget next week. Sorry.

johannes

