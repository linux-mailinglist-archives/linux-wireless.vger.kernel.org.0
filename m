Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938D741FCA1
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Oct 2021 16:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhJBO6N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Oct 2021 10:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbhJBO6L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Oct 2021 10:58:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DE3C0613EC
        for <linux-wireless@vger.kernel.org>; Sat,  2 Oct 2021 07:56:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b192so9399409wmb.2
        for <linux-wireless@vger.kernel.org>; Sat, 02 Oct 2021 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuqU3/qf0QEOzXp6/1SczmkZm2z7Yd4NQ9/T34Z1upw=;
        b=VsdBfFwdQoL14nnKQlqnCo6UvuLL0hQtfuY1vpxsF32n3nuqFn7DTBmpGlaJ7GGr2M
         rEEE1MMZbp7FFYQLSqM4BZVnE3XZUSIouSLLgdmU9pz9lqnhouzfDEm8wB9ZGTBCd1Zr
         CIQXLGJ97okZ6DSEhw23BvcYDkn+xIxmkCrDMgF4csvCyz8wBea8oX4KeudLV/y0tUG1
         3Lq5AVPsSL2kzhJcUUL8wEuhqbmLIwTGSXpZSKQAbNT+l+0SgvOi28FfCjRWoTyU3sdI
         W11UfWeKdD5gKLOtOyR2UVgquUdoohRo7CCAOLk6NrmCdDHe6H1O0xYS7Vge3E9iI8VI
         qbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zuqU3/qf0QEOzXp6/1SczmkZm2z7Yd4NQ9/T34Z1upw=;
        b=XRRab7w2jhl0FaBPi9bxGHZul5QwON8O/4n2BFnxLdgB9OfNOFBcOMNd7TKWwDaNXl
         wtee56lTFSChQAPPCUsUpJwLE3w3ZPggiNEXilB+SLcw6C3K6YnjV1CFHvghW6eh5q6e
         y9+2vaU6TUFiEbE9pkjo4sRyxRpuOQ61bvAo8aZKFKV8Kulr42ezmoZSM/oqNWjgOCkl
         8OBEgl+Mp6Mz4f6tgUtKG+8ylX0Y4E+60oYYEIFvEl8kwYeglNeE21q3HIi1Sd1J8Hkd
         Aw8Zy03Yv1MH3FuambTEav70kj1wE4O1IQX3F1tfRJaY/TaM6/2Q2buClRBLMqZwGVSY
         AoxA==
X-Gm-Message-State: AOAM530gYj2CcLLPXQONFg5cmUF1TTRZpy+mI3hBfYgdm+xDNBAfEsUS
        y+eAM4sZVi3uPiDoq7yOwKQ=
X-Google-Smtp-Source: ABdhPJwGp5bA2jQ58bxo6q/DBNWOOoKsaB7yo9E1iLiqkmlgmJRkWcuGatyz37oPOcjGJbXZntDW1A==
X-Received: by 2002:a1c:f703:: with SMTP id v3mr9510956wmh.177.1633186583224;
        Sat, 02 Oct 2021 07:56:23 -0700 (PDT)
Received: from localhost.localdomain ([156.196.57.245])
        by smtp.gmail.com with ESMTPSA id u1sm8943112wrn.66.2021.10.02.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 07:56:22 -0700 (PDT)
From:   Ahmed Zaki <anzaki@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, anzaki@gmail.com
Subject: [PATCH] mac80211: fix a memory leak where sta_info is not freed
Date:   Sat,  2 Oct 2021 08:53:29 -0600
Message-Id: <20211002145329.3125293-1-anzaki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The following is from a system that went OOM due to a memory leak:

wlan0: Allocated STA 74:83:c2:64:0b:87
wlan0: Allocated STA 74:83:c2:64:0b:87
wlan0: IBSS finish 74:83:c2:64:0b:87 (---from ieee80211_ibss_add_sta)
wlan0: Adding new IBSS station 74:83:c2:64:0b:87
wlan0: moving STA 74:83:c2:64:0b:87 to state 2
wlan0: moving STA 74:83:c2:64:0b:87 to state 3
wlan0: Inserted STA 74:83:c2:64:0b:87
wlan0: IBSS finish 74:83:c2:64:0b:87 (---from ieee80211_ibss_work)
wlan0: Adding new IBSS station 74:83:c2:64:0b:87
wlan0: moving STA 74:83:c2:64:0b:87 to state 2
wlan0: moving STA 74:83:c2:64:0b:87 to state 3
.
.
wlan0: expiring inactive not authorized STA 74:83:c2:64:0b:87
wlan0: moving STA 74:83:c2:64:0b:87 to state 2
wlan0: moving STA 74:83:c2:64:0b:87 to state 1
wlan0: Removed STA 74:83:c2:64:0b:87
wlan0: Destroyed STA 74:83:c2:64:0b:87

The ieee80211_ibss_finish_sta() is called twice on the same STA from 2
different locations. On the second attempt, the allocated STA is not
destroyed creating a kernel memory leak.

This is happening because sta_info_insert_finish() does not call
sta_info_free() the second time when the STA already exists (returns
-EEXIST). Note that the caller sta_info_insert_rcu() assumes STA is
destroyed upon errors.

Same fix is applied to -ENOMEM.

Signed-off-by: Ahmed Zaki <anzaki@gmail.com>
---
 net/mac80211/sta_info.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 2b5acb37587f..35fb885040b1 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -640,12 +640,14 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 
 	/* check if STA exists already */
 	if (sta_info_get_bss(sdata, sta->sta.addr)) {
+		sta_info_free(local, sta);
 		err = -EEXIST;
 		goto out_err;
 	}
 
 	sinfo = kzalloc(sizeof(struct station_info), GFP_KERNEL);
 	if (!sinfo) {
+		sta_info_free(local, sta);
 		err = -ENOMEM;
 		goto out_err;
 	}
-- 
2.25.1

