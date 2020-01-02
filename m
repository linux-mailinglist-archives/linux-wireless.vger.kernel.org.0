Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E84B512E1C9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 03:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgABCuH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jan 2020 21:50:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45954 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbgABCuH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jan 2020 21:50:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so21382091pfg.12
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jan 2020 18:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zVd40d6mMStuYAtkdWEGqAp6oRjkuiyCK1HTnRYaNNU=;
        b=Kyc0ib+rwFivG2sn/pnZhn7JF4Ci7nxXbMZtnEBd5bC04fAd3/vUAPuOR2wXHfazss
         S+/lH9BD/xwoHrAFeCq7squLzKpBZjJh/w4QoTg65MHNz3N4Ybf1Nt6thig7vN8jLTH0
         dQglp2lQc5ntKdqS6wjNEiZAccolabp0YZ+WTDTcCprGpXMfiDq/pPJbEEXlG9ND/VrV
         anCw0DCsCc9iTxi3EQo+J3JOxBshsCmbil7GlVSk4L2wugLDqUJo7xb2/UOY6yn5nuaq
         dkrfgbnF1gEt5JrZPBYqS+r/vu2boLzh/YD5WTetXJpOYnXmtKs2VQgKVqnluyND8Yb4
         D+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zVd40d6mMStuYAtkdWEGqAp6oRjkuiyCK1HTnRYaNNU=;
        b=dIJsP7XvL6SmusxSCag9hS+XjmpaYlnhX5Kbq81pfwBszXBJV/WQiUUTFjl7Lef/yK
         VnLyXDRZBSAEjdQqYqfVQuZpAW3BXfF+E8HP4jG6vBc/sX2gn8q4fM+z0s6sI6qfB5cY
         nLyFetOOKSX6OhTvrZ9I1bmt9Fstkcl/XGYGJj4x/OMa3tsD/Ml5udK70SZC8nZjk061
         3JKRYyq4jHcvfSob02C32vNlmaZ74hY7tVTp029jPC/DNUFyJHm7eILQuBXVMZPI8183
         hrEEOa7OWig9re8HLZE5HCordQ9O9ip6nuL9yLpY+nu2CdTxUnO16+T5EwESmc+7YYti
         +VFg==
X-Gm-Message-State: APjAAAUbynzYxxU13lJluiS1OOPshGwLmhsm3Wx3Xe/UhuO04JUFGJ3F
        WoOlVv8ot5uFDe62Bg3oB4MAp6dnK0Q=
X-Google-Smtp-Source: APXvYqwLOlWCtVU8mAgD5kDv3fO4Gay4frd/A7ujg508JIMTF+rrp+ALgdYjyHBzfC8qsMhI4bFCTw==
X-Received: by 2002:a62:1783:: with SMTP id 125mr67603410pfx.189.1577933406839;
        Wed, 01 Jan 2020 18:50:06 -0800 (PST)
Received: from localhost (172.96.199.36.16clouds.com. [172.96.199.36])
        by smtp.gmail.com with ESMTPSA id h26sm65744603pfr.9.2020.01.01.18.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2020 18:50:06 -0800 (PST)
From:   m1s5p6688@gmail.com
To:     linux-wireless@vger.kernel.org
Cc:     johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        luciano.coelho@intel.com, linuxwifi@intel.com
Subject: [PATCH] iwlwifi: fix possible potential NULL pointer dereference
Date:   Thu,  2 Jan 2020 10:49:59 +0800
Message-Id: <20200102024959.5199-1-m1s5p6688@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Qing Xu <m1s5p6688@gmail.com>

iwl_req_fw_callback() check the wrong kmemdup return value, leading 
to a NULL pointer dereference. 
Fix it by replacing the wrong value with the correct.

Signed-off-by: Qing Xu <m1s5p6688@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 4096ccf58..68c9b7157 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1455,7 +1455,7 @@ static void iwl_req_fw_callback(const struct firmware *ucode_raw, void *context)
 				kmemdup(pieces->dbg_conf_tlv[i],
 					pieces->dbg_conf_tlv_len[i],
 					GFP_KERNEL);
-			if (!pieces->dbg_conf_tlv_len[i])
+			if (!drv->fw.dbg.conf_tlv[i])
 				goto out_free_fw;
 		}
 	}
-- 
2.17.1

