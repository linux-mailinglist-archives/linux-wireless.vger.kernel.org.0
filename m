Return-Path: <linux-wireless+bounces-14026-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A0E99FD60
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 02:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB287B22406
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 00:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC93C156;
	Wed, 16 Oct 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OtCIbM7i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C874C98
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 00:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729039811; cv=none; b=KwjiR3Oj8TIIMC5Kg9eX+4idHGprL1omvnBUc6GKP1JeLVXZnZ76DCWhpifbYhSqX4s6nxaxmytNPlux5DmNfhfmrWv6oO44zZi0fUQvCon/qfzUbm22804x7AoCjPkVpDt2KOgrHmPEDWqZ02BwnaMSroOEd3U+aDFItJ5Fp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729039811; c=relaxed/simple;
	bh=cHL8WzzDKNEPEYnuq4BafCchccjxxp6NtEVi9Kwj05w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MncOxZYsYSp0uC7BrP4rom2zznWspu5m1rKb0YQHGfBBfXhUDIvGdLw87xbANtt5DFJ15F8uR6wwIr2XVY5IFD9dDE0Ms7sFdsVEcKa+WrM8Xnh+qiMM2kQAbzBAvWAFGRDU2hAXE3PqSlHAGt2LwsXb/eXOyAe1ImaHofhP8Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OtCIbM7i; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729039810; x=1760575810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ir6jjsOg5lrec8/lftmnTe9kqY1Fyi30/eseCpzwCQU=;
  b=OtCIbM7iPRN1VCRAsvALUIOkQHAvmNN2DLT46xqpWq8UPCvaoQN5luyM
   NZ9ThEZ85BiLTbBwNRpbC+kiCydRg0x94d+bFJDrOp6haWtr5vImXk5fC
   xi0GvM5rZqwfbFK7F1WDILHnE9iiYG89ajggUcWEOUaKdF3TYHmCqzEJz
   8=;
X-IronPort-AV: E=Sophos;i="6.11,206,1725321600"; 
   d="scan'208";a="766907367"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 00:50:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:28126]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 7ed5a2d0-9c4c-407a-a458-7547516dde20; Wed, 16 Oct 2024 00:50:02 +0000 (UTC)
X-Farcaster-Flow-ID: 7ed5a2d0-9c4c-407a-a458-7547516dde20
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 00:50:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 00:49:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <johannes@sipsolutions.net>
CC: <alexandre.ferrieux@gmail.com>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v1 wl-next 1/3] wifi: wext: Move wext_nlevents to net->gen[].
Date: Tue, 15 Oct 2024 17:49:56 -0700
Message-ID: <20241016004956.74702-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <2d4bc83dffef3b773312aa08d55bb310f2dcead9.camel@sipsolutions.net>
References: <2d4bc83dffef3b773312aa08d55bb310f2dcead9.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 15 Oct 2024 08:36:24 +0200
> On Mon, 2024-10-14 at 13:55 -0700, Kuniyuki Iwashima wrote:
> > CONFIG_WEXT_CORE cannot be built as a module
> 
> Isn't that precisely an argument for _not_ using net->gen[] with all the
> additional dynamic allocations that implies?

Exactly...

Recently I was thinking most of the structs in struct net (except for
first-class citizens like ipv4/ipv6) should use net->gen[] given the
distro kernel enables most configs.

But yes, WEXT is always built-in.


> I'm not really against
> doing this, but it does make the third patch more complex, requiring the
> new wext_net->net pointer,

Right, FWIW, before posting this patch, I checked 5 structs have
a similar pointer.

rdma_dev_net : possible_net_t net
pktgen_net : struct net
netns_ipvs : struct net
bond_net : struct net
afs_net : struct net


> and given allocations (rounded up) will take
> more space - for something always present - than just going with the
> existing scheme?
> 
> What's the reason to use net->gen[]?

Probably because wext_nlevents was just before a cacheline
on my setup ?

$ pahole -EC net vmlinux | grep net_generic -C 30
...
	} wext_nlevents; /*  2536    24 */
	/* --- cacheline 40 boundary (2560 bytes) --- */
	struct net_generic *       gen;                                                  /*  2560     8 */

