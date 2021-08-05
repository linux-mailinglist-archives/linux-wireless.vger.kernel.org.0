Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7553E1842
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Aug 2021 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbhHEPjv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Aug 2021 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242220AbhHEPjo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Aug 2021 11:39:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FCEC0613D5
        for <linux-wireless@vger.kernel.org>; Thu,  5 Aug 2021 08:39:30 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l19so9845973pjz.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Aug 2021 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ot7k522t7tkww/gX8P+bxa/STMEn0jLnSSwzpwYPO18=;
        b=utic3nZYCnPeafOdB5uoaVtxojMNCLKIo2xKX9t82krXXWyGwcCFzlwckj6QdMlFXD
         GLaEhJvWYX/fOONI+vz9BZhMifJBlAX7PLChJVqO975qI1icoCW0CcG2fn6+7QMNkiCv
         Bg0U4OFesb9+eC+zI3YnpKcoJ/kRYrQa43DKeh/9Sv+Z+SSDfANVvAO1vOEFxlZ+N4IT
         sKWWy55sqWsuvjP9/U4zqxB7jC3jkswfeocRKI3S1TVRUu4Yt65+HoVc4qsmW0sl7sLI
         5jObu1fi7jCKCYeZkR3YoyedZnKfwKrB1WzmVfA2TuSTpUJE5LukyNcHwVWuU00AQdtD
         f0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ot7k522t7tkww/gX8P+bxa/STMEn0jLnSSwzpwYPO18=;
        b=o1j7EZktJRCYAhOxamCH9vqEz/kVZfNKjD6KOtzwhOlK0fstqk0cSrO4Dr1B6wEHGl
         6RxdGhzmidujSEbzy/uD6set1Nc9KCda05+Ki9vJ3vr4CI7tW+acOh5L0i5sdlca1hjM
         Pu0N2I4f/ar6dWiTzXtWCVocFdoCoik51VBBWdzFzEZyAiX90Ui+fGDP1XavYElg1HNT
         ss5A2or1TNA9NZHkAoIfxMD/GmoJReh8NjpnQlOll6GC6bPap6WcvwC3QGm2QtS89xHI
         6u7qPw363H5QzfhNxjW0yBb0evbvPCuFoPqenm2NYaa+VR+PmunbdDRtKzw471iXkgpM
         g18A==
X-Gm-Message-State: AOAM532RD0OlCt1S15pYNnC/BEDyAU+4B0ByVZvR8yBiAEEds6HyiXu2
        B6z21uHjE+pJXI/yfpCZBGg=
X-Google-Smtp-Source: ABdhPJzI6Osj7BruIbyH3v3jjgR8866LhUnUXyQp2+58ST7DxRr5rceLcY4XlVDKySf/AMl/sj3AYw==
X-Received: by 2002:a62:1489:0:b029:336:162f:3417 with SMTP id 131-20020a6214890000b0290336162f3417mr148817pfu.14.1628177970105;
        Thu, 05 Aug 2021 08:39:30 -0700 (PDT)
Received: from lattitude.lan ([49.206.116.229])
        by smtp.googlemail.com with ESMTPSA id m17sm7173437pfh.133.2021.08.05.08.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:39:29 -0700 (PDT)
From:   Gokul Sivakumar <gokulkumar792@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Gokul Sivakumar <gokulkumar792@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] iw: mesh: add new cmd to dump all the supported mesh config params at once
Date:   Thu,  5 Aug 2021 21:08:07 +0530
Message-Id: <20210805153807.645106-2-gokulkumar792@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805153807.645106-1-gokulkumar792@gmail.com>
References: <20210805153807.645106-1-gokulkumar792@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function print_mesh_param_handler() already supports printing all the
mesh config params when not pasing one specific parameter, so add a new
"mesh_param dump" command to help the user see all the parameters at once.

$ iw dev mesh0 mesh_param dump
mesh_retry_timeout = 100 milliseconds
mesh_confirm_timeout = 100 milliseconds
mesh_holding_timeout = 100 milliseconds
mesh_max_peer_links = 99
mesh_max_retries = 3
mesh_ttl = 31
mesh_element_ttl = 31
mesh_auto_open_plinks = 0
mesh_hwmp_max_preq_retries = 4
mesh_path_refresh_time = 1000 milliseconds
mesh_min_discovery_timeout = 100 milliseconds
mesh_hwmp_active_path_timeout = 5000 TUs
mesh_hwmp_preq_min_interval = 10 TUs
mesh_hwmp_net_diameter_traversal_time = 50 TUs
mesh_hwmp_rootmode = 0
mesh_hwmp_rann_interval = 5000 TUs
mesh_gate_announcements = 0
mesh_fwding = 1
mesh_sync_offset_max_neighor = 50
mesh_rssi_threshold = 0 dBm
mesh_hwmp_active_path_to_root_timeout = 6000 TUs
mesh_hwmp_root_interval = 5000 TUs
mesh_hwmp_confirmation_interval = 2000 TUs
mesh_power_mode = active
mesh_awake_window = 10 TUs
mesh_plink_timeout = 0 seconds
mesh_connected_to_gate = 0

Signed-off-by: Gokul Sivakumar <gokulkumar792@gmail.com>
---
 mesh.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mesh.c b/mesh.c
index 3797335..943edf5 100644
--- a/mesh.c
+++ b/mesh.c
@@ -11,6 +11,7 @@
 #include "iw.h"
 
 SECTION(mesh);
+SECTION(mesh_param);
 
 
 typedef struct _any_t {
@@ -447,6 +448,19 @@ COMMAND(get, mesh_param, "[<param>]",
 	NL80211_CMD_GET_MESH_PARAMS, 0, CIB_NETDEV, get_interface_meshparam,
 	"Retrieve mesh parameter (run command without any to see available ones).");
 
+static int dump_interface_meshparam(struct nl80211_state *state,
+				    struct nl_msg *msg,
+				    int argc, char **argv,
+				    enum id_input id)
+{
+	register_handler(print_mesh_param_handler, NULL);
+	return 0;
+}
+
+COMMAND(mesh_param, dump, "",
+	NL80211_CMD_GET_MESH_PARAMS, 0, CIB_NETDEV, dump_interface_meshparam,
+	"List all supported mesh parameters");
+
 static int join_mesh(struct nl80211_state *state,
 		     struct nl_msg *msg, int argc, char **argv,
 		     enum id_input id)
-- 
2.25.1

