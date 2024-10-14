Return-Path: <linux-wireless+bounces-13945-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6705399D8A6
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 22:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB27CB2202C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 20:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F151D0796;
	Mon, 14 Oct 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SYajZ/Dk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF726296
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 20:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939358; cv=none; b=JXs12KFIOv6PK/xWbIC29NaBCtikTQqx7GZPTAf1YmsWwuZC5mgZG3yiPOKvQ265oy2jhvJkfAoyvzTar8XLGY52PDgFKJNNNM0UPbeufM7gX7tMKm7riXaB45m91wMnhRxhZHyQHHf/gYPlLz0v6C1csMAIJs5vNM04159y+ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939358; c=relaxed/simple;
	bh=iJ7RFNChVuYPtkKskakOBJCFDqv5YnhM2b13fPP3Gso=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t3OswXUmjCD6U0bRuHhbL46O69PGYW8MK4XXKMs1J2DTJbdv50UB2vjQgQ6x8CP8APw8ncX7/7PVYSD7sBqY4qR0+mg8067q9HB728goC42WMdUrprJYw3VZBee5yffdjHFC/uMhPnUpEeiJoxnq0H8mOi7KjoA1OppD26dcrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SYajZ/Dk; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728939357; x=1760475357;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p47nYekNtMblN9yW6GABV9HnQUZlc4cvZt37e91UI/s=;
  b=SYajZ/Dk2e3HIXzlZAD33DpK/aNSnZ/b1ip/L+SPFmeKZwQgZgW9z1IY
   S/tKwUOlbLXAo2VtvRlnVBiPXqaPeB1DoVTlVx5k0J6qLFGvQZ0OpdMB6
   e6/Ti/9/VFnBaaHAu1KStSjlfl09TEGqN860HHGKqY8TVF9HIDhJApJob
   k=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="376090981"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:55:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:57057]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id 8251efab-5c24-4362-ae25-93591d912438; Mon, 14 Oct 2024 20:55:51 +0000 (UTC)
X-Farcaster-Flow-ID: 8251efab-5c24-4362-ae25-93591d912438
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:55:49 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:55:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<linux-wireless@vger.kernel.org>
Subject: [PATCH v1 wl-next 0/3] wifi: wext: Namespacify wireless_nlevent_flush() calls.
Date: Mon, 14 Oct 2024 13:55:40 -0700
Message-ID: <20241014205543.94787-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, wext's netdev notifier calls wireless_nlevent_flush()
for any event of any device and iterates all netns.

It happens even on a host without wext devices and is problematic
if the host has thousands of netns & devices as reported in the
thread below. [0]

This series will address the issue by removing the netns iteration
in wireless_nlevent_flush().

[0]: https://lore.kernel.org/netdev/CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com/


Kuniyuki Iwashima (3):
  wifi: wext: Move wext_nlevents to net->gen[].
  wifi: wext: Convert wireless_nlevent_work to per-netns work.
  wifi: wext: Don't iterate all netns in wireless_nlevent_flush().

 include/net/iw_handler.h    |  4 +--
 include/net/net_namespace.h |  3 --
 net/wireless/core.c         |  2 +-
 net/wireless/wext-core.c    | 69 +++++++++++++++++++++++++------------
 4 files changed, 50 insertions(+), 28 deletions(-)

-- 
2.39.5 (Apple Git-154)


