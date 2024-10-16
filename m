Return-Path: <linux-wireless+bounces-14110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D692E9A165F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 01:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B6A1C20D63
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 23:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB091D54CD;
	Wed, 16 Oct 2024 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mIu6f019"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E371D5168;
	Wed, 16 Oct 2024 23:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123141; cv=none; b=WFIHznSWawx05PmQNuVBLr83jIcteTEkNOy+O0G41MSOjb9GmC5zj8JKjln90+g21FCZZ2lPqQE6VzB4M6fowlsGONTFfHVqGfTOIMAosIQlxxHtkvCBxE+3xBRX/pcEK42ZvBu2lJJ+Gcs+9wdXl2B6ZeJz5Yd9a1HExJMkKlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123141; c=relaxed/simple;
	bh=iZqdpAIYCAdpsvh2o5vIMQL91GsNm3g5JEE8xPnTxbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hM/ZPdn2m0QWKFIeieBFvEvKTkzSbWkanoOZslBaPqOsU+TsAqKrICWKkka5reJuA5tEza7o7g/UISvPuvGIjVDGmjaXWFDeVqTqkZho8n9XDi+Vc3nhOXS2EuxDS13YmEXyX/Ua7MOE1QWMtMLkuC2CKLBLs+jLgJdI5BeopuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mIu6f019; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729123140; x=1760659140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Id/l01nSeayy7Ttal/hLOGBbUMzpZ1OImbzEKyUIL0=;
  b=mIu6f019q+E140tQ1hWBwNhigOC4qAmK1SH4XDpJNhLMGh/6frrOGCC0
   3bOWcz7kCxoihdVZJ4W0mF2cUEXTnESpl4Z5DItB36/t8yQdKrDfk95sT
   8IULdCNl2ttwUvS8RjCoDqmHT95ZzRE7wxtgMA1aixRSbg6ZPHh8+dizA
   0=;
X-IronPort-AV: E=Sophos;i="6.11,209,1725321600"; 
   d="scan'208";a="432097324"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 23:58:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:15229]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id f4176c88-2464-4500-b1cd-73ce946b38b0; Wed, 16 Oct 2024 23:58:56 +0000 (UTC)
X-Farcaster-Flow-ID: f4176c88-2464-4500-b1cd-73ce946b38b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 23:58:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 23:58:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <johannes@sipsolutions.net>
CC: <alexandre.ferrieux@gmail.com>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 wl-next 1/3] wifi: wext: Move wext_nlevents to net->gen[].
Date: Wed, 16 Oct 2024 16:58:50 -0700
Message-ID: <20241016235850.29495-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <f677361da9e1e4bb032e62301255ab705252e016.camel@sipsolutions.net>
References: <f677361da9e1e4bb032e62301255ab705252e016.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 16 Oct 2024 10:56:44 +0200
> +netdev, I think we're starting to discuss more general things :)
> 
> On Tue, 2024-10-15 at 17:49 -0700, Kuniyuki Iwashima wrote:
> > From: Johannes Berg <johannes@sipsolutions.net>
> > Date: Tue, 15 Oct 2024 08:36:24 +0200
> > > On Mon, 2024-10-14 at 13:55 -0700, Kuniyuki Iwashima wrote:
> > > > CONFIG_WEXT_CORE cannot be built as a module
> > > 
> > > Isn't that precisely an argument for _not_ using net->gen[] with all the
> > > additional dynamic allocations that implies?
> > 
> > Exactly...
> > 
> > Recently I was thinking most of the structs in struct net (except for
> > first-class citizens like ipv4/ipv6) should use net->gen[] given the
> > distro kernel enables most configs.
> 
> Wait I'm confused, to me it seems you're contradicting yourself? :)

Sorry, I meant the above is for module :)

> 
> If we agree that making it use net->gen[] is more overhead since it
> requires additional allocations (which necessarily require more memory
> due to alignment etc., but even without that because now you needed
> wext_net->net too) ...
> 
> Then why do you think more should use net->gen[] if it's built-in?
> 
> > But yes, WEXT is always built-in.
> 
> I can see an argument for things that aren't always present, obviously,
> like bonding and pktgen, but I don't see much of an argument for things
> like wext that are either present or not?
> 
> > Probably because wext_nlevents was just before a cacheline
> > on my setup ?
> > 
> > $ pahole -EC net vmlinux | grep net_generic -C 30
> > ...
> > 	} wext_nlevents; /*  2536    24 */
> > 	/* --- cacheline 40 boundary (2560 bytes) --- */
> > 	struct net_generic *       gen;                                                  /*  2560     8 */
> 
> I'd argue that doesn't really mean it makes sense to pull it into
> net->gen (where it gets accessed via two indirect pointers)?
> 
> That's an argument for reordering things there perhaps, but in struct
> net that's probably not too much of an issue unless it shares a
> cacheline with something that's used all the time?

Yes, avoiding false shareing would be the only reason to use ->gen[]
for builtin.

I'll drop the patch 1 in v2.

Btw, why WEXT cannot be module ?

