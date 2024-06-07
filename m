Return-Path: <linux-wireless+bounces-8682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D85900095
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 12:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA72028686F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11B15D5DA;
	Fri,  7 Jun 2024 10:21:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0215B99D;
	Fri,  7 Jun 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755664; cv=none; b=BGghh8Zx4rFhEJoRChRbBw2AGCSkOD7C/afiufp85LESP61YheKe4PGd92VLhXn29hUVUwkLdubz0zz5KoBVjsa3QXba0yR8deHixB7vBfJx+ndaxk96LGf51CfjjVRlelJWk2ngpoFfwdDjuKGZUbIgBuOKnxBmVmo7thJWU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755664; c=relaxed/simple;
	bh=gbzkN+HnRQiOXaIoiH0HNihHOHVKYAf+aBcWP/Am+xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fe4IOT7M6QjxWn5o8NtaEQ5NN+xNA4nsCWHeeqdq4FuSmXOfoG2B27F84pJucVmrUjXwETQiiG53FxajvFjkxeDmm9xL7mqAQFnU5o7Bax2FGzpSSr0QLLJnVHT528kazPZDwxkt4+NwDFmtm8JOcM6KWtdmJADA/bJcK3HF/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a32b0211aso2565765a12.2;
        Fri, 07 Jun 2024 03:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755661; x=1718360461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3nNU9KpHJb0ZPufRdlZofVOg4CGXOzM45QLGnUwPxc=;
        b=fQnB0ABsnatbKNQUAlmC4rP14ggXYSqiPxCPk8U5PjuD3HwHsUbtXSxT6kDJECXkpA
         oRisKhRDz9rQFJjwZAfqIWTDacQAC8AxZXV4zoVlln9f3M+2/dG/BnvbZqMIoQJcuTFA
         EQPTOqxItOYwoRLREaBs9o3fYZ2rlKq4MzS1fxnpJBgrVYARNl4TkRMnmEH2OueHIFSh
         8kVQ+gtY7teDLDJaNOa2rqts6GwsXw2iYRlGWf+ZBy8UrkkRZYP49QEFa5Y30brjSH3s
         hXWWm4ag3/6Li14wa1wClOFlNYqbqxgM98sTnfmdHrG7DFKjAWe8wVZlEx1wqTx8hoHW
         H3pg==
X-Forwarded-Encrypted: i=1; AJvYcCXIraZj0W5FjV6m51tqnq0siNYK6mQwPV0skiWA/p3NpinqM6PkWmsJBDjbfh7Ty2HHetkExv/twDnkcD73hI7j0rJskswHz0OZDyr13rTRPDNVe4+Gztb0B9BtAe3XqBpR9G8Jvkmj0BFNqPmKYn6zUgjPNWO+/DfW53QWWZcWzEGE7+4=
X-Gm-Message-State: AOJu0Yy79jzLa69tVl7vCjWxx836gnGrT/CiernHyQVdqNGcnb2jM24K
	lEfE5nKHWvYUqZdSeHTTfrAnt66QAD1E1OaHx69UOPJ70SINNf8I
X-Google-Smtp-Source: AGHT+IFCVIxpP0OHrnh8NVA0zJEQxrVUDOw/7dZQgh4PFibqT5y/SjiCjtNuNTYPTxThSL3gNeMhTw==
X-Received: by 2002:a50:8d1c:0:b0:57c:5f4c:b229 with SMTP id 4fb4d7f45d1cf-57c5f4cb36dmr565366a12.33.1717755660723;
        Fri, 07 Jun 2024 03:21:00 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae142816sm2519919a12.58.2024.06.07.03.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:21:00 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	sbhatta@marvell.com,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH wifi-next 2/2] wifi: mac80211: Remove generic .ndo_get_stats64
Date: Fri,  7 Jun 2024 03:20:44 -0700
Message-ID: <20240607102045.235071-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240607102045.235071-1-leitao@debian.org>
References: <20240607102045.235071-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

In this driver specifically, .ndo_get_stats64 basically points to
dev_fetch_sw_netstats(). Now it will point to dev_get_tstats64(), which
calls netdev_stats_to_stats64() and dev_fetch_sw_netstats().
netdev_stats_to_stats64() seems irrelevant for this driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/mac80211/iface.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 605305cb3ff2..8f5d5f5deb4d 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -815,12 +815,6 @@ static void ieee80211_uninit(struct net_device *dev)
 	ieee80211_teardown_sdata(IEEE80211_DEV_TO_SUB_IF(dev));
 }
 
-static void
-ieee80211_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
-{
-	dev_fetch_sw_netstats(stats, dev->tstats);
-}
-
 static int ieee80211_netdev_setup_tc(struct net_device *dev,
 				     enum tc_setup_type type, void *type_data)
 {
@@ -837,7 +831,6 @@ static const struct net_device_ops ieee80211_dataif_ops = {
 	.ndo_start_xmit		= ieee80211_subif_start_xmit,
 	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
 	.ndo_set_mac_address 	= ieee80211_change_mac,
-	.ndo_get_stats64	= ieee80211_get_stats64,
 	.ndo_setup_tc		= ieee80211_netdev_setup_tc,
 };
 
@@ -877,7 +870,6 @@ static const struct net_device_ops ieee80211_monitorif_ops = {
 	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
 	.ndo_set_mac_address 	= ieee80211_change_mac,
 	.ndo_select_queue	= ieee80211_monitor_select_queue,
-	.ndo_get_stats64	= ieee80211_get_stats64,
 };
 
 static int ieee80211_netdev_fill_forward_path(struct net_device_path_ctx *ctx,
@@ -945,7 +937,6 @@ static const struct net_device_ops ieee80211_dataif_8023_ops = {
 	.ndo_start_xmit		= ieee80211_subif_start_xmit_8023,
 	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
 	.ndo_set_mac_address	= ieee80211_change_mac,
-	.ndo_get_stats64	= ieee80211_get_stats64,
 	.ndo_fill_forward_path	= ieee80211_netdev_fill_forward_path,
 	.ndo_setup_tc		= ieee80211_netdev_setup_tc,
 };
-- 
2.43.0


