Return-Path: <linux-wireless+bounces-19243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDFEA3EB5B
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 04:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B43A3B11B2
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 03:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005AB1F8BAF;
	Fri, 21 Feb 2025 03:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SsumWSgq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF03594E;
	Fri, 21 Feb 2025 03:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740108412; cv=none; b=dQNBHEtq9TiYuJBNdIx+/Mfa0Zk9P/bGtvUVUzA8mh3yfp0eqK/yuGw5M0Ud3H5LEKFdqNka4RW85EMhoX99UrjomIl+NxvAjNr7B5WkKczgvmTbQobOBNheR3IDtMECrRDY5nY9qKHt+w0xKstUhVmC+hWOZCdrzLPGymJlIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740108412; c=relaxed/simple;
	bh=V0I7DNs/D6+NfwBc/Eq9hVMaTs7EG7uGDTOlZXN3hrc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDwzxjzNCgBs9oIiZNBrUNpDmFrn5hRvkr9W3YZctwMy0le0s8vIeC2vytnhNUjuRTdf96xUXN6MrlvqkZcOydZmNTGtNxOap/5Oj5Aeq+/FEpcHDE3WqwJp0u9LBNL/d1KfK77Na+KmLjzlEClte4Pp5RIlmYV+yKZxPYQggTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SsumWSgq; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740108412; x=1771644412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8mNjS6ciQxTju2qMj3xcfBbIY4//EJ+QLkySghPDl14=;
  b=SsumWSgqg68LKZyB91KDw/ZFXQslCv8Ftn0cOp1wjEgB0qUto8TV00WB
   BKgfiwq6rwyhxvoaKe8/pIJHAJwrqXfAh40tUrFnrPynaFanbmvfaWw1w
   WhDlpzpJEUL6etnT6uwOgSs1kj2yFgZBwVSwEVZuetiwKAksmjBNYnf/n
   U=;
X-IronPort-AV: E=Sophos;i="6.13,303,1732579200"; 
   d="scan'208";a="800651343"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:26:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:51797]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.70:2525] with esmtp (Farcaster)
 id 0699b55d-301b-4263-9bf9-a0cbd11131d6; Fri, 21 Feb 2025 03:26:43 +0000 (UTC)
X-Farcaster-Flow-ID: 0699b55d-301b-4263-9bf9-a0cbd11131d6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 21 Feb 2025 03:26:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.209.63) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 21 Feb 2025 03:26:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <alex.aring@gmail.com>, <andrew+netdev@lunn.ch>,
	<b.a.t.m.a.n@lists.open-mesh.org>, <bpf@vger.kernel.org>,
	<bridge@lists.linux.dev>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <herbert@gondor.apana.org.au>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-ppp@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <miquel.raynal@bootlin.com>,
	<netdev@vger.kernel.org>, <osmocom-net-gprs@lists.osmocom.org>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <stefan@datenfreihafen.org>,
	<steffen.klassert@secunet.com>, <wireguard@lists.zx2c4.com>
Subject: Re: [PATCH net-next v10 05/13] net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
Date: Thu, 20 Feb 2025 19:26:29 -0800
Message-ID: <20250221032629.73823-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250219125039.18024-6-shaw.leon@gmail.com>
References: <20250219125039.18024-6-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 19 Feb 2025 20:50:31 +0800
> ip_tunnel_init() is called from register_netdevice(). In all code paths
> reaching here, tunnel->net should already have been set (either in
> ip_tunnel_newlink() or __ip_tunnel_create()). So don't set it again.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

