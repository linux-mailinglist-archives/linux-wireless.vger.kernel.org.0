Return-Path: <linux-wireless+bounces-11877-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6A95DC7A
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 09:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F2C282A3C
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 07:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06315155315;
	Sat, 24 Aug 2024 07:33:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5E14A097;
	Sat, 24 Aug 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484801; cv=none; b=eUFT2QVw3ewRKp2iqPSPSsDsKdy56B5s5WSf9gLqTYB46cxzQiss3XgjMGQeOSqyMqP9OWRJlz4gtbCBt/9Y3+oaZ45UA+rHcTS0wdFMK5ASRFuSXZH8Zlo1hgm5z8xC4/mNavxMUrl3Nyg1ipgE31p2PzCjpKT2jbgTKZ37ZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484801; c=relaxed/simple;
	bh=Hg9xoc/VMJOfZVi9w3hSPZJTv1xSTk3qVJsXRjNMXc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u/JGuwZFc1hEfrf88+IJg0lvfDf5awNTsTmRnIS3UDPrV1w8kjg2ZRrjI0lpwVjfSCH4Wej1fksDyPGNYHb00ZxJsldu7vxJCffV6N8iO2+jsw6keefpo2nHLe5PtmWAx+ESpRtIGDQDjURTHjhwNA4mgKCHpIu+DBpEVSdAd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WrT7Y2gHqz20mPt;
	Sat, 24 Aug 2024 15:28:25 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 3097814013B;
	Sat, 24 Aug 2024 15:33:10 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 24 Aug
 2024 15:33:09 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <allison.henderson@oracle.com>,
	<dsahern@kernel.org>, <pshelar@ovn.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <dccp@vger.kernel.org>, <dev@openvswitch.org>,
	<linux-afs@lists.infradead.org>, <lihongbo22@huawei.com>
Subject: [PATCH net-next 0/8] Use max/min to simplify the code
Date: Sat, 24 Aug 2024 15:40:25 +0800
Message-ID: <20240824074033.2134514-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Many Coccinelle/coccicheck warning reported by minmax.cocci
in net module, such as:
        WARNING opportunity for max()
        WARNING opportunity for min()

Let's use max/min to simplify the code and fix these warnings.
These patch have passed compilation test.

Hongbo Li (8):
  net/mac80211: use max to simplify the code
  net/rds: Use max() to simplify the code
  net/ipv4: Use min() to simplify the code
  net/core: Use min()/max() to simplify the code
  net/dccp: Use min()/max() to simplify the code
  net/openvswitch: Use max() to simplify the code
  net/rxrpc: Use min() to simplify the code
  net/ceph: Use min() to simplify the code

 net/ceph/osd_client.c     | 2 +-
 net/core/pktgen.c         | 6 ++----
 net/core/sock.c           | 2 +-
 net/dccp/ackvec.c         | 2 +-
 net/dccp/dccp.h           | 2 +-
 net/ipv4/ip_sockglue.c    | 2 +-
 net/mac80211/driver-ops.h | 2 +-
 net/mac80211/mlme.c       | 2 +-
 net/mac80211/scan.c       | 6 ++----
 net/mac80211/tdls.c       | 2 +-
 net/openvswitch/vport.c   | 2 +-
 net/rds/info.c            | 5 +----
 net/rxrpc/input.c         | 3 +--
 13 files changed, 15 insertions(+), 23 deletions(-)

-- 
2.34.1


