Return-Path: <linux-wireless+bounces-11840-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A9595CA91
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 12:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A497B20CFD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 10:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B2613AD33;
	Fri, 23 Aug 2024 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="M8aNpspF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326737144
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 10:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409436; cv=none; b=CB8lhmwyCG8OdIOXAbBN/Ap3xQk032AiFO/xURgfFCtmo1i4GORtrBfZiQJK6I/wIU8Z9eat3wQMNAkBvXud/1/sYGC8wm2MfZldVE5NaaTQgNcSl1WkmfFWCN0sFEawDWKeF0I0laDR9oP3FxOBPCzyikolNax71gWEvXIwtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409436; c=relaxed/simple;
	bh=LfcZqkgy+H4T5CCXFyqLZB/nRXXqOXe+8Ni/TYxw01w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oEYA365PKcc1hHuMnGqdPnfM0u17+2rWd24g0eahXhWXLVPTeyrpkx4wVWSP5ckD06IWqcmUuNPGOeKcIrzpggAmN81ORBNKn+49+Y9jmQmkElmIefX9/b+1G8B+mlfO5Bii1tiDDy6Lzkcg8m45fs/wmfaINN4tKBJ7jsPop2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=M8aNpspF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=LfcZqkgy+H4T5CCXFyqLZB/nRXXqOXe+8Ni/TYxw01w=;
	t=1724409434; x=1725619034; b=M8aNpspFCbJmmNJSGcr0LlO7h3cVHMgnn1UMZX4FJ9VjCVj
	hN2rc7VCpb2abGP5c0Ze2jW8lv5mArgnvSEGPZADkDz+GgGL9PnJz3oT9pNq/UDztMP9GV4RI5sT5
	NoEpWiLDhv8eIvCrF/KtMHq07/IihPwfw4nNAakhHCyumLWKIMqH3kbCZgUIIkALV0hqWqbEwRMlE
	Wx5+c1X84SdW2Z1a+KY8ZyFblDkCJnn4eqIp9W3xmpI22NgguQbfZ5+vF1b1rknZ/LUQ5LSMdr2fB
	t8fWibalTNqs/U5WSbmPoiJB6uMniB5bWwaAQmNsS+rR2xPXy2tZ0YiSIW8DxG9w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1shRfL-0000000FRnO-0ucs;
	Fri, 23 Aug 2024 12:37:11 +0200
Message-ID: <30ec97d6ecfc4bf83fbd1477c0dba255bce9e6fa.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: override HE/EHT capabilities if NSS is
 zero
From: Johannes Berg <johannes@sipsolutions.net>
To: Ajith C <quic_ajithc@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Fri, 23 Aug 2024 12:37:09 +0200
In-Reply-To: <20240807041933.3196761-1-quic_ajithc@quicinc.com>
References: <20240807041933.3196761-1-quic_ajithc@quicinc.com>
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

On Wed, 2024-08-07 at 09:49 +0530, Ajith C wrote:
> Currently, when some stations send association requests
> with the "Support for 320 MHz in 6 GHz band" flag enabled
> in the EHT PHY Capabilities Information, but the Supported
> EHT-MCS And NSS Set for 320 MHz is filled with zeros, or
> Support for 160MHz in the 5GHz / Support for 80+80MHz in
> the 5GHz band flags enabled in HE PHY Capabilities
> Information, but the Supported EHT-MCS And NSS Set for
> 160 MHz is filled with zeros, Causes the
> ieee80211_sta_cap_rx_bw() function to choose a bandwidth
> which has Supported NSS value zero.

Not following here ... are you saying stations are sending bad
association requests, hostapd/mac80211 accept them, and then we get 0
NSS? Why are we accepting them?

Or are you saying we're sending them, but then that seems like a driver
bug?

johannes

