Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AABA0118AFD
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 15:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfLJOe3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 09:34:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727272AbfLJOe3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 09:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575988468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lzMmmKug1G8gwHz+oRjF0NKAUOL4rbBl1hsaSc/VVTs=;
        b=g+h3cQMBdhWnk7aA0ijT9VfOtkCrgAStqG/86rH7RBx7Yp3JFCQ7PbyU9kqe/JJXk+U2w0
        3K0TUJPdZCXg9PxQjVvX7wCa/lkwv/adhdVnGZK7dJv5wyVZKeLfQdec+OFb+dU/vqiygT
        JaMmqA7e9VzqI/R+z1XfPqIMRPHJEIM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-GtqMFMcKNrW_ZqSQhBQS6w-1; Tue, 10 Dec 2019 09:34:26 -0500
Received: by mail-lf1-f70.google.com with SMTP id f22so3156682lfh.4
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2019 06:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/AAZO7EnLn1/Vzkz1GwdCY3hplFRzl5MVDjWzY9hbw=;
        b=LMlx/H6ULOb3Rd5lAMP5B2YAjcVsT5OM7fTOC6E2Ktmbq7K/Bp7dMkSDUMJ8U3ELXF
         /anCfoiFxQ5rO1a5IlswJE+bfwzkw/fQfu/Cbhdpi39s962sLzOvx5srcl5X0hJrcDCW
         Hv6B9zQ82A7wY1K9CH43I9l4/sQec2l7nBQxLBQ4UFyz6tJn7L1AMmrsawz61u3ym1Em
         VhW1LJuCNggZ+6rWwIbHBGhSYtzvfGJBRQ4A/saOrv+8TVmb71uwAmrZJLIWpNYc8DuE
         IeNviR25JflJMfs1u4kXukfct41u75UR9etBkpNU6NiiwXqXHC9JSyqYeo17Qc0j1SMV
         xULg==
X-Gm-Message-State: APjAAAVipjxmU4dhnU6IxkvQ959pTwaOu6hqiNYGl3szQuYLd631XIVF
        h1vEWCWBAvWlfPixdmItOXeUJrUJcd3r7WzQVpvWFSZj5WZTNUyib7QwkuKVYv44Fl0FX3q1ksh
        wv7vFkrxq2ljNL3QXxP8769EJlRM=
X-Received: by 2002:ac2:4316:: with SMTP id l22mr3736971lfh.115.1575988465099;
        Tue, 10 Dec 2019 06:34:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwi1cS/XVFeT/Z/PH0U3BjoiVCHltOW9msmr2mScRwrUPR6NxUTNY0OmctXd2apserYpIVWg==
X-Received: by 2002:ac2:4316:: with SMTP id l22mr3736956lfh.115.1575988464860;
        Tue, 10 Dec 2019 06:34:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 207sm2287558ljj.72.2019.12.10.06.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 06:34:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id CAC35181AC8; Tue, 10 Dec 2019 15:34:22 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] mac80211: Always show airtime debugfs file when TXQs are enabled
Date:   Tue, 10 Dec 2019 15:34:17 +0100
Message-Id: <20191210143417.142964-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-MC-Unique: GtqMFMcKNrW_ZqSQhBQS6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The AQL statistics are displayed in the 'airtime' station debugfs file, but
that file was only shown if a driver has enabled the airtime fairness
feature flag. Since AQL can be enabled without airtime fairness, let's
expose the airtime file whenever TXQs are enabled, so the AQL data can be
read.

Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 net/mac80211/debugfs_sta.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index b3c9001d1f43..c190c29fe0dd 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -989,12 +989,10 @@ void ieee80211_sta_debugfs_add(struct sta_info *sta)
 =09DEBUGFS_ADD_COUNTER(rx_fragments, rx_stats.fragments);
 =09DEBUGFS_ADD_COUNTER(tx_filtered, status_stats.filtered);
=20
-=09if (local->ops->wake_tx_queue)
+=09if (local->ops->wake_tx_queue) {
 =09=09DEBUGFS_ADD(aqm);
-
-=09if (wiphy_ext_feature_isset(local->hw.wiphy,
-=09=09=09=09    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 =09=09DEBUGFS_ADD(airtime);
+=09}
=20
 =09debugfs_create_xul("driver_buffered_tids", 0400, sta->debugfs_dir,
 =09=09=09   &sta->driver_buffered_tids);
--=20
2.24.0

