Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E103F6D9E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Aug 2021 05:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhHYDPS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 23:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhHYDPR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 23:15:17 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00544C061757
        for <linux-wireless@vger.kernel.org>; Tue, 24 Aug 2021 20:14:31 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id t26so13802771uao.12
        for <linux-wireless@vger.kernel.org>; Tue, 24 Aug 2021 20:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7C6eU2bq+kP7VKEHH8KfX35tClQoC7RBscehpXMH58=;
        b=iS3h7ld81iYe+OuZ/XBYi7nF14iSBhqjpHLLwzcHgMEPXcptUjyqCF5Mx4W5zXryAb
         z6tsceDG6GCOv4UgdyM0NSb6qsTZISSuZQpPK/5qBhjI7qtEFCp3olPta7NQL/Zq54Pi
         eT1HklsaTztFkDdT7Csy1YXO0roVRf5ojpeQ0H/m3bItLUIT8WOzU31pJ/wvfeSVrnxy
         fcVurvo0qBsVe++s8EzpCgJ+OuaplM80FArrVrVufr+5OxRl1gjH4OmUWAD+Lmo/WNEx
         KLlN2oS+dLNdPMaWTDoaiyhZ05cYNh1nbqkgx8jXhW9apMAraFJJGNpXJThze/9/khn0
         FnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b7C6eU2bq+kP7VKEHH8KfX35tClQoC7RBscehpXMH58=;
        b=JXsSlhH0Lj2nMmp2Y+ajw71WqlDYb35V5ChK91Aewa1u00Lj3lp7XU8JlSjLKDz58o
         PKlMkCLnIvitAH+atWqXNkQczQJdPAyV6AWrB8RlqRs78bls1zq7D9ydZny1kHGnFMwm
         7fIEc5sLNOj2hp0lFAS7no5hWTTIrWrjLoCxg9UbXnM7ErMwv4OG8RWoejqhCld9rdDV
         YoHnUNuYc9tJqHNaFp/xZShg0sYA9mumAHzpTErA2Shz0oP+jPMLNiGVAwhocF3LWWK0
         LCvIn1Btc4DDA7vBk5j9ROwpCFnBn+XbMR2AzdO0GZtFYPWHGltDqXJGQIMQQNmoMKIO
         oRAg==
X-Gm-Message-State: AOAM533xXp5CKZY5v9oV0r44fOgwl7lWh4F78n5y3Qj5Y3cn+LP475tG
        qF9DTWiZzpDMB2SSINxpx0w=
X-Google-Smtp-Source: ABdhPJy0fyJVxgTrPhXZqox/Kz0fMaLaXdSKttH+Xus1YCTDiT6yDqtFf2pyKZn+7PDotHbZZ9I55w==
X-Received: by 2002:a05:6102:378:: with SMTP id f24mr31639120vsa.37.1629861269559;
        Tue, 24 Aug 2021 20:14:29 -0700 (PDT)
Received: from helios300.. ([186.33.134.25])
        by smtp.gmail.com with ESMTPSA id l26sm2173689vsi.3.2021.08.24.20.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:14:29 -0700 (PDT)
From:   Victor Bayas <victorsbayas@gmail.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Victor Bayas <victorsbayas@gmail.com>
Subject: [PATCH] Update regulatory rules for Ecuador (EC)
Date:   Tue, 24 Aug 2021 22:14:09 -0500
Message-Id: <20210825031409.10552-1-victorsbayas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update the frequency ranges and power limits according to the current Ecuadorian norm [1],
corrected 5GHz maximum bandwidth since there are no legal restrictions in this subject.

Note: 60GHz channels 1 to 3 are allowed without license for Point-to-Point links but
they aren't for Point-to-Multipoint links so they were omitted in this patch.

[1] https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf

Signed-off-by: Victor Bayas <victorsbayas@gmail.com>
---
 db.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index e7b11cf..4630854 100644
--- a/db.txt
+++ b/db.txt
@@ -504,12 +504,14 @@ country DZ: DFS-JP
 	(5250.000 - 5330.000 @ 80.000), (23.00), DFS, AUTO-BW
 	(5490.000 - 5670.000 @ 160.000), (23.00), DFS
 
+# Source:
+# https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf
 country EC: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 20), (17)
-	(5250 - 5330 @ 20), (24), DFS
-	(5490 - 5730 @ 20), (24), DFS
-	(5735 - 5835 @ 20), (30)
+	(2400 - 2483.5 @ 40), (1000 mW)
+	(5150 - 5250 @ 80), (50 mW), AUTO-BW
+	(5250 - 5350 @ 80), (250 mW), AUTO-BW, DFS
+	(5470 - 5725 @ 160), (250 mW), DFS
+	(5725 - 5850 @ 80), (1000 mW)
 
 # EE as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.30.2

