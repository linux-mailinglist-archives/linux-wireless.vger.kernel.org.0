Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6ABE9857
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 09:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfJ3Ily (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 04:41:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35874 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfJ3Ilx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 04:41:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so1285954wrt.3
        for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2019 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cryvzLgbDMtwjGhzkRT6/vR7N9p8/gSURlaB37/Qe4Y=;
        b=ZWx36xSw857XGXHgGgMSZS6zlGb8TiDYcRr2BxPiWSNsrmlRDrGcgQuuyi0bp+o8y/
         RRLF8IsK4qaTFnNqV3Bybi7sH0UJeYWyI5ME9lPlwWVdg8i3/mPwgM8/EbhnwQX/Mwcm
         t1Xw3zCBQQ8fV66KV3UIRE8z1GbWFK2jbOAujsEwHICwPnYvLxOmW4CSTwgtl7rjDq31
         sAyAGaH8/l/Lhn/ZQhQrPKSB8ypoWLZcwSR9z0GRHYw57xRLobbqzyuGr2U3kuebO/VN
         9rokN+q74RHMSbJ2VNbjnQSs2j9f+XrBilP8zfmQ7NbxTw9yA2FWK4RXPNYHBfYnTgr6
         fFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cryvzLgbDMtwjGhzkRT6/vR7N9p8/gSURlaB37/Qe4Y=;
        b=e5B76RYSxswqfBVdm/gUKQio58MXvGkS/dAcvjQblK0oiCodmkvYzcu11TQEj0kM+Y
         vRzTq1mGpDG2MmPlyC5gxftIqrE7uGbYff+28okIOhMTBUw6AfinSbJNdLWidUN87mhZ
         3UUSY3M3SMv4QuIKSMaENuaqapjr+7r5++6Me+kxWqVP4L+Pd5ofYCiHVS1utmtReiAG
         DMwioDSXXZBSEEy0fUKOqYg0o+uFQcv9SrqiVkF+kz75FrorlqW2RZd377luSwLIzMt8
         KhbplyrlObeRWvjpfmKR6T/M/WLhZ1k0ORs/wA7gd0/s+oEAmu0fW/XvUj1ofi/zyIuj
         u4Ew==
X-Gm-Message-State: APjAAAVYP+kXu2x+/1/cOf2sCdPE0EwL7CjWpz2kzSxTYAR7LlfxzJxz
        oyX4pMFRTdTgg4bOJtCBQCw=
X-Google-Smtp-Source: APXvYqz64GKBUvqLJi68Wu8q0R2zuSfT4XubqAglZMPk0p/s8rw53wezLzfjUGFhN/TrDRvBCS9UGg==
X-Received: by 2002:a05:6000:1621:: with SMTP id v1mr23227554wrb.62.1572424911917;
        Wed, 30 Oct 2019 01:41:51 -0700 (PDT)
Received: from localhost.localdomain ([193.27.220.66])
        by smtp.gmail.com with ESMTPSA id b7sm1642225wrn.53.2019.10.30.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 01:41:50 -0700 (PDT)
From:   Eduardo Abinader <eduardoabinader@gmail.com>
To:     wcn36xx@lists.infradead.org
Cc:     Eduardo Abinader <eduardoabinader@gmail.com>,
        linux-wireless@vger.kernel.org, kvallo@codeaurora.org
Subject: [PATCH] wcn36xx: remove unecessary return
Date:   Wed, 30 Oct 2019 09:41:41 +0100
Message-Id: <20191030084141.24009-1-eduardoabinader@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index a276dae30887..c30fdd0cbf1e 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -935,8 +935,6 @@ static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 out:
 
 	mutex_unlock(&wcn->conf_mutex);
-
-	return;
 }
 
 /* this is required when using IEEE80211_HW_HAS_RATE_CONTROL */
-- 
2.20.1

