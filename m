Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9C335774A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 00:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbhDGWBO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 18:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhDGWBN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 18:01:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA0EC061760
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 15:01:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x7so19510205wrw.10
        for <linux-wireless@vger.kernel.org>; Wed, 07 Apr 2021 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YO+Luw6+NxVvRkcrJgxuPRq03WcH9gZGARw02gdsBak=;
        b=Oeix9diGFjjdj63SNKEfk54iKoS4V89riVBANyDi1RhIC7/pv5pBZKm3PrVY0muvCX
         eTpGX4bYLlAVgtOUBEknDmAdHO1AHQN/Tby13yV/KqI3L0EW5y3/XFMSAbmGC49hQmp4
         lPZgns1Ba2CmeipJsmXVPEwiuJhQmQs12fNyH1NE24Gl5jDrzGb9A3Mc2p+fIV7BoGjF
         uBqPYWKe3W/HqiTZnLV4TCn9+tTtmHITd9XisPqh9vB8Il9INNP1AuFK3fKc7p1SZff7
         Jw10GzLIjPQPeqtdC76g7kLQm841oD9n2IbRX1gcXr2xIlropsr1VpK4IrbrjX/jHEH0
         aM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YO+Luw6+NxVvRkcrJgxuPRq03WcH9gZGARw02gdsBak=;
        b=Uamu+4u/s6SEnVKYivSWf1S7JWXfqiOeXnkch9y0mEB6mV+uSmTbeB1RMy0r8QBsmZ
         4mAQJVcsO/D2p3RgqT9usAr68dJEWpRb6pFAOKUOhEFjez3OENmOwfFMSTuK8mdN6sdR
         A9z2NSS+f7hPtoCRqWXUrpUD7awe/yC69HEjDvIvrrx5nhXNJDcybKMIIOTaWV8mqQaW
         rUuVoBmqOORbWfDkZDdJmik4DloR5bblHWtV4uqohzdqxs+J9CsM5Wq6B6Zg+C0eWimD
         +UETwzSYa9G3oIEcWhYPDp5h6nlyLum0BcDeBH/nm/kNTNIENrm/oucp3SpTUP93tvXX
         8cQQ==
X-Gm-Message-State: AOAM530k2j1RSDDkeYs1X5zg3gFDsnKxEO/NNQBmGDl/+ze/hvh4j/WK
        giIlIPCX1GvmEO7bb+ayCw==
X-Google-Smtp-Source: ABdhPJzN0BPmZDeTAg02rl591GKqEE0EuUxmGJlExzyDYeNo3gTo3sIA+tAAiV5ZuFH79g+OV2sIaQ==
X-Received: by 2002:adf:fb0e:: with SMTP id c14mr6977685wrr.140.1617832862141;
        Wed, 07 Apr 2021 15:01:02 -0700 (PDT)
Received: from localhost ([84.39.178.7])
        by smtp.gmail.com with ESMTPSA id p27sm11048539wmi.12.2021.04.07.15.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 15:01:01 -0700 (PDT)
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        =?UTF-8?q?Jos=C3=A9=20Daniel=20Rodr=C3=ADguez?= 
        <josedanielr@yandex.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        WIRELESS ML <linux-wireless@vger.kernel.org>,
        REGDB ML <wireless-regdb@lists.infradead.org>
Subject: [PATCH] wireless-regdb: re-add source url and info for CU
Date:   Thu,  8 Apr 2021 00:00:54 +0200
Message-Id: <20210407220054.9347-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Handy to find modifications or new rules.

Cc: José Daniel Rodríguez <josedanielr@yandex.com>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: WIRELESS ML <linux-wireless@vger.kernel.org>
Cc: REGDB ML <wireless-regdb@lists.infradead.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
 db.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/db.txt b/db.txt
index b0d6689..5e72469 100644
--- a/db.txt
+++ b/db.txt
@@ -372,6 +372,9 @@ country CR: DFS-FCC
 	(5735 - 5835 @ 20), (30)
 
 # Source:
+# https://www.mincom.gob.cu/es/marco-legal
+# - Redes Informáticas
+#    Resolución 98- 2019 Reglamento de Redes Inalámbricas:
 # https://www.mincom.gob.cu/sites/default/files/marcoregulatorio/r_98-19_reglamento_redes_inalambricas.pdf
 country CU: DFS-FCC
 	(2400 - 2483.5 @ 40), (200 mW)
-- 
2.31.1

