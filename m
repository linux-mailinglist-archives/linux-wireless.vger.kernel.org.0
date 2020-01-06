Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D878E131BB0
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 23:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgAFWnT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 17:43:19 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50501 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgAFWnS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 17:43:18 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so8141602pjb.0
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2020 14:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RdNkbYZ+RFZlefMkKQtcxx/Dp7xm2bgzJO9aSRTQLY=;
        b=QhMRk2miiCccImpiN7ngaz8l/5k8dYIz8H5fJO42jEYHW27vEkedCNTlRho3fGndFu
         5QmOFMEWE8InP1O3SYox05L915GR/CiaWoBoJFatws6hS3VnOUZSc3Ytvy7bbW73JK9h
         otvV+5+5GpT6ehoJbxJ1SbUkyFxd8cNJLUYgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4RdNkbYZ+RFZlefMkKQtcxx/Dp7xm2bgzJO9aSRTQLY=;
        b=IfiiUPhM7fs35xC+xFqe9roqho1/MYSCmD46zajkyuVAcjuQvWHXFyWCOVXfieGMXX
         zH+nircTveSoiJ6BZGy081P9xZfbliz+UNUTldekItrLXyB/YpKDGUtpnsM4NpZ/MU7a
         pWuJMbiSsZv8RoBC/R+0IClLsA4Lul8Q5PZSq5twrINAmV7hyx+JPmA/XBRcNx6ZdZGS
         Tw/TK+J91l5K0pl+DBZoWCmTyfGYRWNAm5/RGbF1hoMGgZ3KYNE8J4AjYrU9GDcGgZkq
         Xa5zGqK+e5HuXFq3t2Ytt2y6GB6YGUYF6fMLEaZBdx3IRllsSRxtUwC2wpqycU8+MJkO
         Wl2Q==
X-Gm-Message-State: APjAAAWpCKgtbwYzGgHAoTLRXANXjwrljtrl3teeQEtkAmhVZfaEaiUW
        FS0oDhK9WmYhVpTr2Z8uwPuGq2Ml4lk=
X-Google-Smtp-Source: APXvYqxGo7WUNXWWAK/AkTd2VsWCEWtIq05rE0cnXnQOct/PG90XE4sHAB+yXBghEH929maGJR8hkw==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr45627715pjn.60.1578350597921;
        Mon, 06 Jan 2020 14:43:17 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id b12sm4360280pfi.157.2020.01.06.14.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:43:16 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     linux-wireless@vger.kernel.org
Cc:     <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        stable@vger.kernel.org, huangwen <huangwenabc@gmail.com>
Subject: [PATCH] mwifiex: fix unbalanced locking in mwifiex_process_country_ie()
Date:   Mon,  6 Jan 2020 14:42:12 -0800
Message-Id: <20200106224212.189763-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We called rcu_read_lock(), so we need to call rcu_read_unlock() before
we return.

Fixes: 3d94a4a8373b ("mwifiex: fix possible heap overflow in mwifiex_process_country_ie()")
Cc: stable@vger.kernel.org
Cc: huangwen <huangwenabc@gmail.com>
Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index 6dd835f1efc2..fbfa0b15d0c8 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -232,6 +232,7 @@ static int mwifiex_process_country_ie(struct mwifiex_private *priv,
 
 	if (country_ie_len >
 	    (IEEE80211_COUNTRY_STRING_LEN + MWIFIEX_MAX_TRIPLET_802_11D)) {
+		rcu_read_unlock();
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "11D: country_ie_len overflow!, deauth AP\n");
 		return -EINVAL;
-- 
2.24.1.735.g03f4e72817-goog

