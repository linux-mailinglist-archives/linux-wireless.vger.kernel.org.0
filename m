Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9A5D13BE8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 21:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfEDTSV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 15:18:21 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:35067 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfEDTSV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 15:18:21 -0400
Received: by mail-wm1-f51.google.com with SMTP id y197so10405608wmd.0
        for <linux-wireless@vger.kernel.org>; Sat, 04 May 2019 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HI5w6ujO6T0yJN9Qynb2wYlJVmzdy1Uxf1JSDTX/jJE=;
        b=QsMLywWmFfZHolAXf9gVDS/QpKgOOj5xasXqGL6ErgqJWOObr6XfOPH9HDtJsl6V5I
         sgROGd577LJLCSfyPe2ldUsyt7bmMTt8npw1bi85jmbOAQYy+uwXwSHPBq2LFAb1Giiu
         iXFlfbmxuPhWvX21x2NR1FzADh2b2vLIEdQptP8p0arghFZO29RcAs0FLOpPAwdsemlj
         kzIoJr5PY7aFUrQRUuzGJuYU5j91vYzDVopupEEa3zeb47EEstXfoUvNgBnF6mHJons+
         rhaUK8sJt3oO+BKwD5OaXwxuDnDREUVwXbqtCt/usTlVKOyp/xugwvD+xlbaVWbjLNg9
         qz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HI5w6ujO6T0yJN9Qynb2wYlJVmzdy1Uxf1JSDTX/jJE=;
        b=FHnW9Fi7EbcKm5i64OtqeQVcYuE1hekA1GnDg5Z+IJUHbE/sS/7iZ2GEcsBN1zbqWN
         F6gUzg1Y4OggCSpWcHVe7R4jySGBgS2sr+uhPBrQIvVq7MOI2ciVBlrbvymA5A98vu/F
         8ir0VEBTOY/053Dv9to8unVN0JQEjEDF0RBZZE8gkbAjlVguuySb99Ak8ERIBkWr6NV9
         939huLl/qjQUKSxQLfZaIZLgV7MAZuv7i3NiAZcxWcoKQPMZIn+Zodmco5GAIWaDcCev
         voWfpAn8wqTccp/gkf247LQqoEMI9ersiQn27CAUmu2LPDlDdUwy6Lylty1jXFsO+gKu
         4fEg==
X-Gm-Message-State: APjAAAUtxLv1QJvfSSYs4mh6Oq1lDzcKdRsbVAZweqxFPnDZ79O+GPD/
        2mouC8sB1YZ1Wem7D5bzpA==
X-Google-Smtp-Source: APXvYqwtq2/V9I/cKC2WcKKas66yHRw6TElQkA9W1c5xu+FMiz62e3WnjWFYgJCfjDTTwKxcWCC3MA==
X-Received: by 2002:a1c:be10:: with SMTP id o16mr10981542wmf.67.1556997499519;
        Sat, 04 May 2019 12:18:19 -0700 (PDT)
Received: from localhost (238.red-83-37-105.dynamicip.rima-tde.net. [83.37.105.238])
        by smtp.gmail.com with ESMTPSA id h9sm5480048wmb.5.2019.05.04.12.18.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2019 12:18:18 -0700 (PDT)
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        WIRELESS ML <linux-wireless@vger.kernel.org>,
        REGDB ML <wireless-regdb@lists.infradead.org>
Subject: [PATCH] wireless-regdb: update source of information for ES
Date:   Sat,  4 May 2019 21:18:17 +0200
Message-Id: <20190504191817.3668-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: WIRELESS ML <linux-wireless@vger.kernel.org>
Cc: REGDB ML <wireless-regdb@lists.infradead.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
 db.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 4fb1948..fe909a8 100644
--- a/db.txt
+++ b/db.txt
@@ -432,7 +432,7 @@ country EG: DFS-ETSI
 
 # Source:
 # Cuadro nacional de atribución de frecuencias (CNAF)
-# http://www.mincotur.gob.es/telecomunicaciones/espectro/paginas/cnaf.aspx
+# https://avancedigital.gob.es/espectro/Paginas/cnaf.aspx
 country ES: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-- 
2.21.0

