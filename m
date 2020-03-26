Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC15C193E21
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 12:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgCZLpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 07:45:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44735 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgCZLpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 07:45:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id 142so2721465pgf.11
        for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2020 04:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QNc7sUitYw+STr16lrtQWpfnsD8DXSPcqt4YHYoo/vA=;
        b=Ii+N+nH3zPPvVwnTqGDG7+afr0CZ0b58kdFhT46r2UJZcO49+8kv638i8xqsSKsVOk
         H+lf7rtAPu4VvQKNjuEwj0YOdDCT9Ct3WNDQC7jMXWxY/XUzMcsop24gWRg9ckVeCYW1
         Tfw1JYeTRp6ucho8i1sz4Ovm1iNqNCNCW0LlFJKKE3j3rZHSoPaxYKJWT2++RAplJCXc
         fvDotAPc0GRnPOszJor2boD2GbSq56SsfRcI7aSVNMfKBVd2OA8fHJkpr/dCEUu0hICh
         hxUmBKa2si3hvPKjinJ0D2fd1r2zQr0CvYYHFGC3yo7fHWXWKxYD8nprCz/zekmEh7pV
         llCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QNc7sUitYw+STr16lrtQWpfnsD8DXSPcqt4YHYoo/vA=;
        b=KaSoevHedZFQiU6g58ITaOp8xo+Ey+Jf7qnfSIZsuY9Qi9m/PoxlvxESBB4ozs4sGI
         4RVXyOOO7F1++qUyfty5AOyRlAOQusIRdtnZoQQ4uBS76OxbJ/v3uNWs5KgPDGXGYiQT
         KbXhqjEXT2W6GN3xaU+E+ZWXHvS5MXVGgWwcOW+QEEkJ6buQaFl8l6/piDlNkbuko6WP
         pl3oTlCrnx8MYx+Yy2rV6uWiqhEOsh7ikV3rUDtBL3tIYSeSMByZJyErlZCWHG5gR3b3
         V/XW6MZmKN545Yw4tnzljleWuTU3xUaw9+N6kPJjJwOnG/dv081aVQP81ProSwEd+kPj
         MFAA==
X-Gm-Message-State: ANhLgQ2Co20pnsM6A3I3HhsUO2cdkdu1k3yTwZRPliqvtr8QF7SS4NT4
        ZRPyQMNQ7XcAbqptvQK3AOU=
X-Google-Smtp-Source: ADFU+vssNiTUhowNTZTuDPc0uSOqYT6zyE3GLeJ+oFH+ooA1OxZZlnzO9DemmVcW9gLVajK5wY2wBA==
X-Received: by 2002:a63:a055:: with SMTP id u21mr7778404pgn.100.1585223116477;
        Thu, 26 Mar 2020 04:45:16 -0700 (PDT)
Received: from localhost.localdomain ([183.83.146.239])
        by smtp.gmail.com with ESMTPSA id 184sm1468382pgb.52.2020.03.26.04.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 04:45:15 -0700 (PDT)
From:   chaitanya.mgit@gmail.com
To:     seth.forshee@canonical.com, wireless-regdb@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Chaitanya Tata <chaitanya.mgit@gmail.com>
Subject: [PATCH] GB: Extend to cover DMG channels 5 & 6
Date:   Thu, 26 Mar 2020 17:15:06 +0530
Message-Id: <20200326114506.943-1-chaitanya.mgit@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chaitanya Tata <chaitanya.mgit@gmail.com>

OFCOM extended the DMG band to include till 71GHz.

Signed-off-by: Chaitanya Tata <chaitanya.mgit@gmail.com>
---
 db.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index 9c4b447..c5750f2 100644
--- a/db.txt
+++ b/db.txt
@@ -587,6 +587,7 @@ country FR: DFS-ETSI
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
 # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0019/136009/Ofcom-Information-Sheet-5-GHz-RLANs.pdf
 # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
+# GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0013/126121/Statement_Implementing-Ofcoms-decision-on-the-57-71GHz-band.pdf
 country GB: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -594,8 +595,8 @@ country GB: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4 (ETSI EN 302 567)
-	(57000 - 66000 @ 2160), (40)
+	# 60 GHz band channels 1-6
+	(57000 - 71000 @ 2160), (40)
 
 country GD: DFS-FCC
 	(2402 - 2472 @ 40), (30)
-- 
2.17.1

