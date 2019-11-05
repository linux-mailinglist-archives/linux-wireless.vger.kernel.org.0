Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D45F0200
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 16:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbfKEP6G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 10:58:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59924 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389571AbfKEP6G (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 10:58:06 -0500
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C408437E80
        for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2019 15:58:05 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id l12so1776559lji.10
        for <linux-wireless@vger.kernel.org>; Tue, 05 Nov 2019 07:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Xfcnm0jBIdnmgfOl/SJRg+y/i+rCq9+6PaLraaGHh8=;
        b=cQrCPt8BgsA3qv7NONtv18H1TNV0c7MRT/CsqAyG/Ma9/B0RrAgmAN9sNzWT4sEor9
         MtP84HX8fzrbFnVjrfUH3RoYBD9/xNyEwRFStQ97qXfARghwBxQSpcq21ojKOA6ZkLAg
         64Zj8GWgmVvxguA3W/yqM14u5qOEEN4CsPrOYcUxfOWw3pcnkWlsC0HIWE73LBaBBI9m
         4EllYqvyM8R+96dX0x0fSQ18JlU9Lw59pBygblRnX4fKA6GtLGPCwbYUwqZ75ceVmGae
         BAigYgWzBLDkqlNrGUojU/i4ja3M1HawKNZlkFKmubo+ESL7fqR/1JjBv7QZkV/AoIw5
         bQzg==
X-Gm-Message-State: APjAAAWogKEBiP3JQLcfWTAz5MjBOjIBvHSf5YegTGbO8jSEaQ95ce3v
        h96cw5U0xIj0L1bD8YTM/Ps8h0DK0CsC0W3GdR9DHOSOBZIB4GmDhZi5VmERS+UA6yhZIoQeT/u
        3cba6Ynfqri6qRYE4Dwik9GZ07cY=
X-Received: by 2002:a2e:9905:: with SMTP id v5mr13192225lji.213.1572969484270;
        Tue, 05 Nov 2019 07:58:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxB8kP/3Dk6HNT4zZdZ0QwZjCCAvcOXhfnKLdfFdMFWmDfanzQQwM50dyM+YToY5UaD10F5Ow==
X-Received: by 2002:a2e:9905:: with SMTP id v5mr13192205lji.213.1572969483988;
        Tue, 05 Nov 2019 07:58:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id n25sm8744528lfg.42.2019.11.05.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 07:58:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 911531818B5; Tue,  5 Nov 2019 16:58:02 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] net/fq_impl: Switch to kvmalloc() for memory allocation
Date:   Tue,  5 Nov 2019 16:57:50 +0100
Message-Id: <20191105155750.547379-1-toke@redhat.com>
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
v2:
  - Also change kfree()->kvfree()
  
 include/net/fq_impl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index 107c0d700ed6..38a9a3d1222b 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -313,7 +313,7 @@ static int fq_init(struct fq *fq, int flows_cnt)
 	fq->limit = 8192;
 	fq->memory_limit = 16 << 20; /* 16 MBytes */
 
-	fq->flows = kcalloc(fq->flows_cnt, sizeof(fq->flows[0]), GFP_KERNEL);
+	fq->flows = kvcalloc(fq->flows_cnt, sizeof(fq->flows[0]), GFP_KERNEL);
 	if (!fq->flows)
 		return -ENOMEM;
 
@@ -331,7 +331,7 @@ static void fq_reset(struct fq *fq,
 	for (i = 0; i < fq->flows_cnt; i++)
 		fq_flow_reset(fq, &fq->flows[i], free_func);
 
-	kfree(fq->flows);
+	kvfree(fq->flows);
 	fq->flows = NULL;
 }
 
-- 
2.23.0

