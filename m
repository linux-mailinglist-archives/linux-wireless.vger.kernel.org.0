Return-Path: <linux-wireless+bounces-22443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE118AA8DA8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C3173D08
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3051DEFD6;
	Mon,  5 May 2025 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="hYZnkhju"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841D82AD02;
	Mon,  5 May 2025 07:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431821; cv=none; b=hoZX+LLDgjHnt4W9fmDgMF/th29x+u4vxqbqwphVab2/8o2PUCnGOMwXJdrChv/h2wdhkAuODoKmOzeh/hP0XjMVBP3Nqpu1OX75USHzVCs32Fd6DpV1AYXxfdRn7LtPf5w0FyheNdAA6Yr7UsRo6m4HJBO5oopYgWM+TpmIksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431821; c=relaxed/simple;
	bh=pPbHgMeWQFl09puflyy91yrOnKHCaxWw5ctlxddRTrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDcKr4UVfoMjiGspWiuTd+I5d6HxJNZbK0lJ6eXvEuyVF07pdccv8n81ACEC9E/BqzCsODLd7AuaWisMhPjUBTxdBHDfWuOWqJ4oRHBOpfJmpWLqX8TEFGsbd71m9/cKcBkYVX5vWOnukWRrcrXmRHpo2GdzFU4nBHKiEpMLV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=hYZnkhju; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6PnQcu1pC8XXIZNueGWlVL3jq98sHlqXTtUErxjHAyU=;
	t=1746431819; x=1747641419; b=hYZnkhjuNZfumw8OCMGMTDGnOgM2DzmTUTj9vvY6DVBk3NK
	IoYClOUCktud1uA6DEVe9vtkE8xsCY6GbdmczUUe+LDF/H38YZSTJ9XPlUDYTG/hBspNDiTtIfZ8i
	s+QD8rR7XWMyBwRd3duRW2LxAJSAJa5raWFG4kmj83fA6CtXN5+jbq9wScjndFZS8Mxj5pGR6PiSk
	3VGGo9jmGowsAu9P2B0FedAw5mVkI8Zj854MfNpsuEwfJjSd1PVBlETx/qTI9/tU15c51l9F9XLUV
	o0JpUEgGK60YQmDzCVPhetKFFYdTjdDPrD+VxP37yy/WNVWgIhNTnBkk3YPyrLkQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uBqgx-000000041KW-3WAJ;
	Mon, 05 May 2025 09:56:48 +0200
Message-ID: <1e1912191137ce827484a4f1b25d6c9a261df68c.camel@sipsolutions.net>
Subject: Re: Introducing iwlwifi-next Tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, Wireless
	 <linux-wireless@vger.kernel.org>, linux-next@vger.kernel.org
Date: Mon, 05 May 2025 09:56:47 +0200
In-Reply-To: <20250501084545.2c9de121@canb.auug.org.au>
References: 
	<MW5PR11MB5810F9A009F45F1A58AC0E63A3832@MW5PR11MB5810.namprd11.prod.outlook.com>
		<2d3c5c2946e4356ba99edb4cca4fa205149c0356.camel@sipsolutions.net>
	 <20250501084545.2c9de121@canb.auug.org.au>
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

Hi Stephen,

> Added from today.  Currently only you, Johannes, are listed as a
> contact for these trees - if you want more added, please let me know.

Thanks. Please list Miri (in the CC list) as well, since she's going to
be maintaining the tree, at least most of the time.

Thanks,
johannes



