Return-Path: <linux-wireless+bounces-21205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A389A7E85D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3393F17D033
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 17:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1221B216E2B;
	Mon,  7 Apr 2025 17:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HG/bqvnK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BE211706;
	Mon,  7 Apr 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047056; cv=none; b=PeiBIYArUlqXFRPI/wfSOKnuSdC9AjldEMzz3rcyKQx7HJu7LP6E8FGYs5VTru7E6ixl+mP3m1vbkiz0xJe5edLR+32xtjDrCxqKFpebo7hL/tkUv6z4eohsjw8fwXf7nfNe+dXaCHCafZysRSH6/qj/ov7z17KQRKGuXre+JxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047056; c=relaxed/simple;
	bh=wnUA7OCiDXFrjQ7bMpg3N+TPEOBGeBxBjWaKqp+LSu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtHkJlHA9F6ZkuOSTT08s+yiCvfQIxW4khU7OYQphgaiSmqpVEya3jmG0kxcvTpAujcgTo4bO31M+xHvxbjDXDyQvpFDWm7FPUad/5UrmEk2VTg+OO+TEN9mEuOZMZTmEI7lIPN/vQGJ30+wC47OBJK8KZNbcxiUsVL5iVJxQf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HG/bqvnK; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744047055; x=1775583055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mRKOQft2e0z8EF/8NpjO7vWzzUvKq2R+xjep8L7DnXQ=;
  b=HG/bqvnKTmfi1R2bpGk74kbWoLWB2brqpOeeWdsTD7wmXn23Ta4Z3EM6
   0n2/cvLN79LzczVYkTDKt9R379HE3PYhuEpVzhd+nCXwN2gLPeGXcYuNg
   7HxOlLI8gcZ8gfKygGQb3IXFxKAAwMkMy3HJswZajxO1TRl8qloWet1ms
   s=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="481076549"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:30:50 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:30895]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.226:2525] with esmtp (Farcaster)
 id 3f7e1099-9221-4c0b-bc80-36d24bd3665d; Mon, 7 Apr 2025 17:30:49 +0000 (UTC)
X-Farcaster-Flow-ID: 3f7e1099-9221-4c0b-bc80-36d24bd3665d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 17:30:48 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 17:30:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <i.abramov@mt-integration.ru>
CC: <johannes@sipsolutions.net>, <linux-kernel@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Avoid calling WARN_ON() on allocation failure in cfg80211_switch_netns()
Date: Mon, 7 Apr 2025 10:29:57 -0700
Message-ID: <20250407173036.30549-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407125345.1238818-1-i.abramov@mt-integration.ru>
References: <20250407125345.1238818-1-i.abramov@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Ivan Abramov <i.abramov@mt-integration.ru>
Date: Mon, 7 Apr 2025 15:53:41 +0300
> This series is inspired by similar series in ieee802154. As far as I know,
> there were no WARN_ON triggers in this code so far, but since it's almost
> identical to cfg802154_* counterparts, same changes are proposed.
> 
> Link to ieee802154 series: https://lore.kernel.org/netdev/20250403101935.991385-1-i.abramov@mt-integration.ru/T/
> 
> v2: Add 2 patches. Also make sure to commit against latest
> netdev/net.
> 
> Ivan Abramov (3):
>   cfg80211: Restore initial state on failed device_rename() in
>     cfg80211_switch_netns()
>   cfg80211: Avoid calling WARN_ON() on -ENOMEM in
>     cfg80211_switch_netns()
>   cfg80211: Remove WARN_ON() in cfg80211_pernet_exit()

Let's see how this thread goes first.
https://lore.kernel.org/netdev/CANn89i+UQQ6GqhWisHQEL0ECNFoQqVrO+2Ee3oDzysdR7dh=Ag@mail.gmail.com/

