Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626213EFC54
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 08:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbhHRGYw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 02:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbhHRGYs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 02:24:48 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1973AC0613A4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:24:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so1627990pjl.4
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wNrSyu18+TQvxqozBk6dKmc83xjPuqXEkZM9+CZkQs8=;
        b=hq0RZc8pvhUdG6LQCrGBNQbN7VTMq2CkOF4QQtsj4WrxV2UTBN34Md8Gi7LkipMBy6
         xL7jSFJnNHOowLO3Jca2aK8bMlaJLC+laeAIEoH1LMm2sWoMULTrkMcKoRbBAsM8UOpd
         ihsdkkeDmGTdleDP1YZNWHcSi4UiGfzn3DsyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wNrSyu18+TQvxqozBk6dKmc83xjPuqXEkZM9+CZkQs8=;
        b=tCEqCBLlDIDKsVcVdw7pQtPM2OBh4xQ5TMrSmXQRx3/0GRQNoiwTmpCp3ZF/GJ5ALI
         hPNhpy5BvPJuxrO1nRC33A6xD/dP6wmGKNN2BKq9t/4kGJaqNliwuveC3FiDCMq7Ajsr
         wz8T9MMwCieCYSu47ZD6RUWDXN15nVmUXcywUZU0TvdxMpHdIvJWm1xA2Xg71VyXdZc2
         K/7hs5Q34L0MpRPNGkoOsj1g1Hi8O9y/DnLRXAjvumji9/QEr4ID84FFwH7VGta6+bxM
         VNOxi3eyc1UX60xGLXNrFvZaPOzz1oFqnndcDqmt4ldmfLljwWyhfzVV1mGUD97jJYyd
         pL/Q==
X-Gm-Message-State: AOAM532BU39etg+fRnikqG14E//iIGoxKrcvvIRUWbyo/9EG6xoO/toZ
        AFVjjymfg2qH/Px7Z2Ewc+/d4A==
X-Google-Smtp-Source: ABdhPJxMkEdSe0VUFwn+z4vxkdsUFqJ2UwImPieDkAd2A7unXagJo2uR8zh40lbVDVJdC8iJXw8UiA==
X-Received: by 2002:a17:902:cec3:b0:12d:92c4:1ea6 with SMTP id d3-20020a170902cec300b0012d92c41ea6mr5911733plg.36.1629267853392;
        Tue, 17 Aug 2021 23:24:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y13sm2710073pjr.50.2021.08.17.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:24:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 49/63] btrfs: Use memset_startat() to clear end of struct
Date:   Tue, 17 Aug 2021 23:05:19 -0700
Message-Id: <20210818060533.3569517-50-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1202; h=from:subject; bh=j07ODF9kjbRRiHohObgJ1N/RHPZCTrQAmspnQvku4YA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMpNf/1TOA8EHO13yPM2WoVQcddjcJSpXNg/q95 NGD5Kx+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjKQAKCRCJcvTf3G3AJiFDD/ 43YRq8chsycAfEPzeH3ODP8oX8vzyejO0KZxGwB29jISLONkndclAADo87JB841bplfSqHF4g/N0Yr 9BPUFM/u9aD6MYInBsgRcfvidkMVdvLwJHJroTXouReKf+wENJpCE42XqDFb6/OHW+qszfq48l2ZsZ vlrJcOJH5B/7MGz2vGlPOqarS6QPhKxELyHgWma5US/BF+fmqXoGyLI96PzJHBVwD8Fv1vRW+FZyYX mS0c778XSYdo50TMLiLEeybc58/w6WbytsuOe2gDRaDra0L+tnQU3bUemlEwF/otdXngLgjznL3aHr 03wBbU/uuuYnsF2VxKSH3eTmyOXxM0Fc0gfhMAHlPYOx3FWaj25UujliZBiwYTeajzJsMlNaMxhyYC CNKnLKNfyeqkcnmjrNFG0fLVNoy2o0OR5zMuoedsu9e9ywbM82GfxRkHbOU9ZMZ5GgY2NMQXjzSHXm JS7ECNId/+w48q42Qz1RDDbkk71kX5clz/7ywEULnxcdaVF9VLida+SAjBnEmtDTTT5a3LFsbnweA7 31UgpReo5DWgV9+9dvXi/NGJgP+uufVyB7FGtNrTHKNpqkfmCVfC6YFh7uVwrtuLat1U/8LUy3Rdgf RT0NM3pRRzNQ/fI9ZSg5+8wsIv5qwbvYlgUlhc046qXy22//QbKOPQkqvAQQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() so memset() doesn't get confused about writing
beyond the destination member that is intended to be the starting point
of zeroing through the end of the struct.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/btrfs/root-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 702dc5441f03..12ceb14a1141 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -39,10 +39,8 @@ static void btrfs_read_root_item(struct extent_buffer *eb, int slot,
 		need_reset = 1;
 	}
 	if (need_reset) {
-		memset(&item->generation_v2, 0,
-			sizeof(*item) - offsetof(struct btrfs_root_item,
-					generation_v2));
-
+		/* Clear all members from generation_v2 onwards. */
+		memset_startat(item, 0, generation_v2);
 		generate_random_guid(item->uuid);
 	}
 }
-- 
2.30.2

