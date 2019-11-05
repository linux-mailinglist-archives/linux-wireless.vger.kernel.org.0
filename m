Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0DF01E8
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 16:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390014AbfKEPvE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 10:51:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389571AbfKEPvD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 10:51:03 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71F9885363
        for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2019 15:51:03 +0000 (UTC)
Received: by mail-lf1-f70.google.com with SMTP id k30so3592471lfj.5
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2019 07:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0dV3sa3iQTivjDRJmppOUx6O6Df8UUVFYaPoLAUNkI=;
        b=I3TGkysj1tNqW+yhIXKasGCI2P/CkTRTd0Zt2+g6TeLjBHynZxr8CmFHs6R4sd5i5X
         IBWB+MCbWHOT9EY+OAYbMXNIGNHdCkjiWn3G7qZOVjuYRscVqZ7FzIhxk6aSFcczRQfy
         BkWgff1aqqwxedUYxuXusLlVbUSJLESzhrjUXi3KzHwqkakVhL1I03OdtXJ5b4YLJ2vj
         GXEBxgsb/A9mxphLudFA2cXKUTXaRO9bjWhZWurk7Bu2D4O3av2BGuO5442cJw/HwbG6
         Ki3/54kJMuwVehpli7jtpUSxI7DRPxpk889R+KtOUHMbkXHy9vzniBJNDkuYA5mMBgGK
         Kldg==
X-Gm-Message-State: APjAAAUL9lRCf2oIYXQZrwvOC589ijRqLqOMujU0+U5QJ4i+pgILti6L
        N10pYt2aJuzKqTLBgM5BgLxbmHu72VZ1WrFquo+1uuUE0qSrvNH7bj3X9JvZQLjHC7+kRUhwq4E
        D9yS7Eu23/CJV/fP11TmEVLD1hIg=
X-Received: by 2002:a2e:8204:: with SMTP id w4mr24160633ljg.212.1572969061534;
        Tue, 05 Nov 2019 07:51:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqylItkXXsXxJ+69zD02VX9P9gYNf/nFjKrN28EuRMkPTsX6Nm+Ew7FzwGuwPYi4Ua/MkLob7Q==
X-Received: by 2002:a2e:8204:: with SMTP id w4mr24160622ljg.212.1572969061379;
        Tue, 05 Nov 2019 07:51:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id c14sm9276346ljd.3.2019.11.05.07.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 07:51:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E03F21818B5; Tue,  5 Nov 2019 16:50:59 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] net/fq_impl: Switch to kvmalloc() for memory allocation
Date:   Tue,  5 Nov 2019 16:49:51 +0100
Message-Id: <20191105154951.546285-1-toke@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The FQ implementation used by mac80211 allocates memory using kmalloc(),
which can fail; and Johannes reported that this actually happens in
practice.

To avoid this, switch the allocation to kvmalloc() instead; this also
brings fq_impl in line with all the FQ qdiscs.

Fixes: 557fc4a09803 ("fq: add fair queuing framework")
Reported-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/fq_impl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index 107c0d700ed6..d3873db91c71 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -313,7 +313,7 @@ static int fq_init(struct fq *fq, int flows_cnt)
 	fq->limit = 8192;
 	fq->memory_limit = 16 << 20; /* 16 MBytes */
 
-	fq->flows = kcalloc(fq->flows_cnt, sizeof(fq->flows[0]), GFP_KERNEL);
+	fq->flows = kvcalloc(fq->flows_cnt, sizeof(fq->flows[0]), GFP_KERNEL);
 	if (!fq->flows)
 		return -ENOMEM;
 
-- 
2.23.0

