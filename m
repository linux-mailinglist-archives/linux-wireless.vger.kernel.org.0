Return-Path: <linux-wireless+bounces-28809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A2C47EEA
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 17:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9C154EF664
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 16:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027A26CE05;
	Mon, 10 Nov 2025 16:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b="dBdFQ+YF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217A27A927
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762791839; cv=none; b=LmUaPUswUYiSpigItP4PSEAx7p3zsUn4S31fHAp01EMMf4FF2fZnOHjuGkw+zKdEPUk8Lqoa2nasWHL/b4e6GBnFyEzjsdNpJvB1nJC0wMFyrTNwQcPCuwb3zJ1Wk0Tn+XPNu1x8Z8oXRngj23QFzswjAo7V1I9XuQGXXg7j4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762791839; c=relaxed/simple;
	bh=4RmZvqPGteLpQaP+Rg8fY+CpJ27PemiIjQ+OhFYZB7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFX5+CdpkE1bYUkdleVj0fNm/gKRin+s7eySG9i4FCMHXxFROdJkEgtH2SU0t28UIJJAOl6NxAQYeKP+/ttXUZ4ZSIhrytaQ3Blju0CgN4ystCaoWhfJsQ19/9d0Yxs6100MMGrxuMlS8uu2DXEp53e73vx/179D+YgevpZg+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=dBdFQ+YF reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerlync.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297e264528aso20688725ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 08:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1762791837; x=1763396637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lamLCycPvZ6qxMMSd5dWCjwQxGtQYpYj0GU4PEFC0tM=;
        b=dBdFQ+YF7wxvryTuu4l4C0AVQmmxMPbZHic8A4lUKXCfxCoBIPghsUM/EELbapNSjL
         K2hss9Ph6WyyMC6NmKLeCcKDWmdJj6Ex4bCrxmOIRug1OtShnPGsJrCAYOif8JFrmZZ8
         DmtC/43f84XgpQXLCyUIGkNCfqVg2WGy/Vi1a/RBeEWWWgMpNjOp/cAeP2za2pzh1fYr
         VjHEkHdx1Z83n1d3ttBkKmVfa68kK2dssrOZuEOUFHTNjBoTWZNI7YmB3jceNF+Sz++X
         BRk0HVHZz7MpXxKIIk9UtYpnmXtJ9JmtodXWiJp9zDcAqNH5sjM3xintdewUOe+bJPK1
         x8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762791837; x=1763396637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lamLCycPvZ6qxMMSd5dWCjwQxGtQYpYj0GU4PEFC0tM=;
        b=WTXisTVOGPlrE8tZQIZ6oe+fOCzz5LL2srRK5/N4VgXu3sd01oPtNRu/dKRdvUHWNI
         xvBTPUqVvw76MJFBwxQb4ezyEoEHuKixkR3XTBDUhK+/k6d672b8+Y40x9xowoNjW0/H
         JF7THtRi1pfqEcnNsPRFnb4TeH32IxsuVtCe9dDQpd9DM/ZtjZGNmPVVjdmIorQ/M9o/
         3qH0qiEmr8l6Ukub/Jk08Q7dfzG0+8X1eo/IZ5KEMvbrrUN7/lLcuwrWZqCDfW4O1WUN
         xv5QskZ+/MW0YpXGHHFt+zJU95ReZTtArdfMllvx3SxnvtlOsttMXHMXUpn0ASucjul2
         +mCA==
X-Gm-Message-State: AOJu0Yzxc7rRa9twGdn0ujWbJUWPLozLc/XXafF/GQLDXGOxRudxRkMH
	glH0zmTuvqPecSfNka0tCRcsCffdcBj2faHrEm9dbCyTGgHejjPcI/N9cuSLpdrEqs40A9jen4F
	8r2q7
X-Gm-Gg: ASbGncuZi18t9yuqL3+lELqXqgnEe2S9cqkFG4Wg98/yhhUZvO06Lm5IpJRouKxlsLq
	henTa3h9w3ZO5scwR042arrm59euwH4+WRc7m+WAYatyrojliuq1Xg90VwUDVh1BaTEcPQBzR0x
	AJYLv+Uodkzj8LXq2ruhgyhFX8Ckj8sYdno1ap47nNRxeSx90ykm52HczHu8GS4JJSzfhGqL5gE
	eLA2FyYN2B7y4XybFsDRsuIyCDq0j2tfbnqZtQ+scVuAclMklREYc0HQpUt4HPD46wTD6UkiXZx
	eSP+ifzsLlrXyIp0Z13pAbHFUHM5adOnXVdsXoC9+RwvcjvRlycIZvjRtuVmVtDKNQ8sWDBTWCA
	hdQsCUq7hsO3ky+885vo3W6DAS5fjdzU/Ln30pUgEVvUxTlA2HAx1k3+gcZZVR/pqAII9IJa2SR
	oLkEOqYKVkpq/cny6N3rW+vaCZhgVwZrrUNy3jr2kQWg==
X-Google-Smtp-Source: AGHT+IHS0J/P0Q+0p6kIWW6Bhuw9kC6oUUNrtxalYb1iLlJHS+ReMwxYzFG2U/cfVNoJ/ulOHlXG+Q==
X-Received: by 2002:a17:903:11c6:b0:295:7453:b58b with SMTP id d9443c01a7336-297e561c718mr103740675ad.4.1762791837344;
        Mon, 10 Nov 2025 08:23:57 -0800 (PST)
Received: from localhost.localdomain ([49.206.118.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm150058075ad.108.2025.11.10.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:23:57 -0800 (PST)
From: Sayooj K Karun <sayooj@aerlync.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sayooj@aerlync.com
Subject: [PATCH v2] mac80211: mesh: handle RMC cache allocation failure
Date: Mon, 10 Nov 2025 21:52:26 +0530
Message-ID: <20251110162228.15064-1-sayooj@aerlync.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109114321.10120-1-sayooj@aerlync.com>
References: <20251109114321.10120-1-sayooj@aerlync.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow kmem_cache_create() in ieee80211s_init() to fail gracefully
when the mesh RMC slab cannot be created so multicast forwarding
continues even without duplicate filtering.

Signed-off-by: Sayooj K Karun <sayooj@aerlync.com>
---
Changes in v2:
 - Retitled the patch to “mac80211: mesh: handle RMC cache allocation failure”
 - Added more clarity to the commit message
 - dropped the extra pr_warn() after kmem_cache_create() failure

 net/mac80211/mesh.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index f37068a533f4..eae78d9528ac 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -2,8 +2,10 @@
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
  * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2025 Aerlync Labs Inc.
  * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
  * 	       Javier Cardona <javier@cozybit.com>
+ *	       Sayooj K Karun <sayooj@aerlync.com>
  */
 
 #include <linux/slab.h>
@@ -25,9 +27,12 @@ bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt)
 
 void ieee80211s_init(void)
 {
-	mesh_allocated = 1;
 	rm_cache = kmem_cache_create("mesh_rmc", sizeof(struct rmc_entry),
 				     0, 0, NULL);
+	if (!rm_cache)
+		return;
+
+	mesh_allocated = 1;
 }
 
 void ieee80211s_stop(void)
@@ -35,6 +40,8 @@ void ieee80211s_stop(void)
 	if (!mesh_allocated)
 		return;
 	kmem_cache_destroy(rm_cache);
+	rm_cache = NULL;
+	mesh_allocated = 0;
 }
 
 static void ieee80211_mesh_housekeeping_timer(struct timer_list *t)
@@ -231,8 +238,8 @@ int mesh_rmc_check(struct ieee80211_sub_if_data *sdata,
 	struct rmc_entry *p;
 	struct hlist_node *n;
 
-	if (!rmc)
-		return -1;
+	if (!rmc || !rm_cache)
+		return 0;
 
 	/* Don't care about endianness since only match matters */
 	memcpy(&seqnum, &mesh_hdr->seqnum, sizeof(mesh_hdr->seqnum));
-- 
2.43.0


