Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4522C728C
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Nov 2020 23:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbgK1VuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Nov 2020 16:50:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbgK0Tpr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 14:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=31NOEUXtFUEIoIEb6DlkLDhejAmEOpd+ygD8P/D1wQM=;
        b=Uih4f8lLdRqqPFfjpjGNRoe0L0WH4G3S3iNiu5WMf2ImlTkrPhSpFSu38Sq50NKIYWnEGc
        8/5zAfpa3+1C6RFUj4Zt6EBqBXKQsU7btqHMuSNvZXyxUdDW+n/+jFrmfXMl422lWSANSY
        Diw9NIDXgdWnvxWxA9ELm1OcnFVAL5o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-xjvlDl-BMTKlS8C85CwJog-1; Fri, 27 Nov 2020 14:38:49 -0500
X-MC-Unique: xjvlDl-BMTKlS8C85CwJog-1
Received: by mail-qv1-f69.google.com with SMTP id q6so3564375qvr.21
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 11:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=31NOEUXtFUEIoIEb6DlkLDhejAmEOpd+ygD8P/D1wQM=;
        b=gXh0ZjbHogMgqvwNgVJiu9jmNMp/1qiacXLgjmy4nC2Si7kgYbS/nCQcytHMWViHdN
         Hf3IJ6e2BgFTO82GedFmRos9ZNhQ7BrI2iF1LtiGF0Q/6AmNdOKftkrBTFcSGVwOog+f
         5HJr+rl7f39GUYMNTeOTOXeEqyUIQ9n112yrqlQ2D2igqJl7HUHc5nQgxDwrA2N9QFKS
         Ln2+9nKX7JxBffNaWFpK7DLbUZFNVDew5up1QJxep8mHya+TscTzb3DiMQKhvwTt5w9b
         ZVfhq4p7IYSQqcxF15BnMsmRZhCdgL9RojJQZHrv0nx8bUZfKQv4QtIUDphBOajELBy2
         eoQQ==
X-Gm-Message-State: AOAM530jQ5cD5o+k/VklrfVG+UbeTTpDWdTscwGSFBfpT6+34AMCrF47
        aE4M57ZoEJzF5VO9UEe5RYNPve1eRVcCu7fr0nCxzEUS+n3gjvA9apYUGv7zE3GqrmnFiPOMyUG
        AwIg4XXhU0I8LIQQ85YDWGg0xYDg=
X-Received: by 2002:a37:951:: with SMTP id 78mr10345095qkj.47.1606505928154;
        Fri, 27 Nov 2020 11:38:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNdAzcStuIXMbmSP+HLLVyItdCLz8IAxD+7vIdJYPeS0NmSpe1Cx1gjQIUHKU6nd921G5yKw==
X-Received: by 2002:a37:951:: with SMTP id 78mr10345076qkj.47.1606505927966;
        Fri, 27 Nov 2020 11:38:47 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v31sm3444876qtd.29.2020.11.27.11.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:38:47 -0800 (PST)
From:   trix@redhat.com
To:     johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] mac80211: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:38:42 -0800
Message-Id: <20201127193842.2876355-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/mac80211/debugfs.c        | 2 +-
 net/mac80211/debugfs_key.c    | 2 +-
 net/mac80211/debugfs_netdev.c | 6 +++---
 net/mac80211/debugfs_sta.c    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 90470392fdaa..48f144f107d5 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -53,7 +53,7 @@ static const struct file_operations name## _ops = {			\
 	DEBUGFS_READONLY_FILE_OPS(name)
 
 #define DEBUGFS_ADD(name)						\
-	debugfs_create_file(#name, 0400, phyd, local, &name## _ops);
+	debugfs_create_file(#name, 0400, phyd, local, &name## _ops)
 
 #define DEBUGFS_ADD_MODE(name, mode)					\
 	debugfs_create_file(#name, mode, phyd, local, &name## _ops);
diff --git a/net/mac80211/debugfs_key.c b/net/mac80211/debugfs_key.c
index 98a713475e0f..f53dec8a3d5c 100644
--- a/net/mac80211/debugfs_key.c
+++ b/net/mac80211/debugfs_key.c
@@ -319,7 +319,7 @@ KEY_OPS(key);
 
 #define DEBUGFS_ADD(name) \
 	debugfs_create_file(#name, 0400, key->debugfs.dir, \
-			    key, &key_##name##_ops);
+			    key, &key_##name##_ops)
 #define DEBUGFS_ADD_W(name) \
 	debugfs_create_file(#name, 0600, key->debugfs.dir, \
 			    key, &key_##name##_ops);
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 9fc8ce214322..0ad3860852ff 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -642,7 +642,7 @@ IEEE80211_IF_FILE(dot11MeshConnectedToAuthServer,
 
 #define DEBUGFS_ADD_MODE(name, mode) \
 	debugfs_create_file(#name, mode, sdata->vif.debugfs_dir, \
-			    sdata, &name##_ops);
+			    sdata, &name##_ops)
 
 #define DEBUGFS_ADD(name) DEBUGFS_ADD_MODE(name, 0400)
 
@@ -711,7 +711,7 @@ static void add_mesh_stats(struct ieee80211_sub_if_data *sdata)
 	struct dentry *dir = debugfs_create_dir("mesh_stats",
 						sdata->vif.debugfs_dir);
 #define MESHSTATS_ADD(name)\
-	debugfs_create_file(#name, 0400, dir, sdata, &name##_ops);
+	debugfs_create_file(#name, 0400, dir, sdata, &name##_ops)
 
 	MESHSTATS_ADD(fwded_mcast);
 	MESHSTATS_ADD(fwded_unicast);
@@ -728,7 +728,7 @@ static void add_mesh_config(struct ieee80211_sub_if_data *sdata)
 						sdata->vif.debugfs_dir);
 
 #define MESHPARAMS_ADD(name) \
-	debugfs_create_file(#name, 0600, dir, sdata, &name##_ops);
+	debugfs_create_file(#name, 0600, dir, sdata, &name##_ops)
 
 	MESHPARAMS_ADD(dot11MeshMaxRetries);
 	MESHPARAMS_ADD(dot11MeshRetryTimeout);
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 6a51b8b58f9e..eb4bb79d936a 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -985,7 +985,7 @@ STA_OPS(he_capa);
 
 #define DEBUGFS_ADD(name) \
 	debugfs_create_file(#name, 0400, \
-		sta->debugfs_dir, sta, &sta_ ##name## _ops);
+		sta->debugfs_dir, sta, &sta_ ##name## _ops)
 
 #define DEBUGFS_ADD_COUNTER(name, field)				\
 	debugfs_create_ulong(#name, 0400, sta->debugfs_dir, &sta->field);
-- 
2.18.4

