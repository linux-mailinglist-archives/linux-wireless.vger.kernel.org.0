Return-Path: <linux-wireless+bounces-19476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BD4A45A31
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9F31894DBC
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98ED22425F;
	Wed, 26 Feb 2025 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aFUYyq1n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8664642D;
	Wed, 26 Feb 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562608; cv=none; b=AXRaZEy28oCKHsazltqxvXdqMfXTcbb1dzPxfjp3rNjTHouazFj4yzuSfJIKI0SbfSC0i7Pm+EhY3yVcAJpY2EyFVZKh6BKbEGy5ebRannNgSveAvWoZplwfksATOOB2xaNthnu0sQOKu3ZX4SEa7tX+lfaeGIbPzLAcQC0qkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562608; c=relaxed/simple;
	bh=n2WAbQXSXaGvM32JXh/SdBxTvg3DTs4VP0FUGSg+rI4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CyEcyTvosYQ8JJ4iL0dYszXKlVK4wCKkBa35oaomYIw//3DS1NmR2ou0zJoK3z0V76YJtYnUFOLL6SL/hzvSxFuJ0y6vy7t6OhIARtLg8fkuC1ekraltDWbqP6F8L9B7zjBXrmhXZKoFSOOGctG49a3NDaI9lUxQMc0m546suaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aFUYyq1n; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=n2WAbQXSXaGvM32JXh/SdBxTvg3DTs4VP0FUGSg+rI4=;
	t=1740562607; x=1741772207; b=aFUYyq1nNFV0N/HcjKyQxbEeyHmsG9ccMjJuCSlmLAGcs0k
	vAxsmHjSVDMjHdStOUDtt4xtdTPphhe0j1Ck6pyU0WIxP1H5UOeiHZbACNNHa9oEXUq+KawaDbIrX
	Yro30f3fKKieEplf3FE632alVUKaa61mUlr9JqNczS9f4aDYNwvsnOpxUAPhX1zkapZSGFksoQbLR
	F5eLL/OIMnvzU1XfAyIKvHYa3zkfjOjBhhUDn9fpfNqB8sFrWSS+zkvNoHou8yuz3QX/F+UMkAgRe
	UaT43Swdrus7x6vsLz1bWlTsgh5HEAq5hbRJZpAeq8m2lisgLVUHiTgUg66HYG7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnDqH-0000000BLoK-3nhb;
	Wed, 26 Feb 2025 10:36:38 +0100
Message-ID: <cb87ed76c1cd85611f0a7c1ce1f248bbe0e2d978.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/6] Revert "wifi: mt76: mt7925: Update
 mt7925_mcu_uni_[tx,rx]_ba for MLO"
From: Johannes Berg <johannes@sipsolutions.net>
To: sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com, 	linux-wireless@vger.kernel.org,
 linux-mediatek@lists.infradead.org, 	stable@vger.kernel.org, Caleb Jorden
 <cjorden@gmail.com>
Date: Wed, 26 Feb 2025 10:36:36 +0100
In-Reply-To: <20250226025647.102904-1-sean.wang@kernel.org>
References: <20250226025647.102904-1-sean.wang@kernel.org>
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

Dunno if this is because of the tree it got applied to (Felix please
send me your tree info!), or something else, but check out the automatic
checks here:

https://patchwork.kernel.org/project/linux-wireless/list/?series=3D937821

johannes

