Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317F83F8F86
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhHZULZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhHZULZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:11:25 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B89FC0613CF
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 13:10:37 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id f6so353863vsr.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnwFAguajTWbtY8HER0/jsnYSNmcvzU+zHYbuiiR8hw=;
        b=S/gnaa4jkaUpWZWrEFzernYCElVSYkmmW9LJxpBwCDM6lUfy+pq3iuKE2haiclfak3
         8/rYaRjOfwIWCRdSplRWtolS5md0ogxTvQ7qYaexNx9O6D1daMJZN1hKCIsHHxCiohDm
         djokpQISgzvCzqucX/IKrrnPm640J6bNTpC2h7MlZ7UEQlDiJz+qa8p44sIbyOvCTIiS
         PDNQ8SdnvqseEvchMhNkmSZ0OIIKJQQlgoHX6eTxSEtpC2Xca62gsNwC+a2eZNl3dxNo
         e5cM2x0gnWr4LnOZF/M6ctjJK4ZlJ6zNNn7G1kyRp/rkyHw51G2juIPb3Aj6s0aoFJ49
         YisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RnwFAguajTWbtY8HER0/jsnYSNmcvzU+zHYbuiiR8hw=;
        b=NIdrt9eojWF/8lf2e7wGE6EjFhlbL4hMkSwdxsErhR12xGBwJ+bN99mLb55UivHhMc
         /j9smubu4S8VeKYNCufTgtLb3A8BAycKbsrdWUXOpc3yvr6rT5VBS5jC3/SSRFhvw0ny
         uxrZNGbFmRpjVzvLUHJxn/09Z54sV7wQvY6WHSKO292EGsOLFI1JlP3f78sd5DLJHtly
         Gew6bqKeC+EjzhYic3DcgCl8PQrdMvbxxL6qIwimWTndePnshJXRx6+aEQcIyJkBlb3G
         UILSs3PLErUdXyvr3+iP0XRgEHVQWXtP4RPMdIFzv4YDWIpqecPPIsx++JoU72bcPTEs
         qrPQ==
X-Gm-Message-State: AOAM532/mbUre+ESOD3LIkv8WuO6DLhcBROH3x+btTbmR0NPDMZ3/N+O
        jKG6PzJgjwsW3sGyPpFJfIzkh2rTzZULSgkmaJg=
X-Google-Smtp-Source: ABdhPJyxwMq1p2QYOJBahQgzrvnf2K/iuHEqbJWXD9MYYj/QsCLR1HUsCLMKYXG6IC3ZjwzXO4LreQ==
X-Received: by 2002:a05:6102:dd0:: with SMTP id e16mr4450295vst.7.1630008634430;
        Thu, 26 Aug 2021 13:10:34 -0700 (PDT)
Received: from helios300.. ([186.33.134.25])
        by smtp.gmail.com with ESMTPSA id o82sm578201vko.15.2021.08.26.13.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 13:10:34 -0700 (PDT)
From:   Victor Bayas <victorsbayas@gmail.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Victor Bayas <victorsbayas@gmail.com>
Subject: [PATCH v2] Update regulatory rules for Ecuador (EC)
Date:   Thu, 26 Aug 2021 15:10:26 -0500
Message-Id: <20210826201026.5071-1-victorsbayas@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update the frequency ranges and power limits according to the current
Ecuadorian norm [1], allow up to 160 MHz bandwidth on 5GHz.

[1] https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf

Signed-off-by: Victor Bayas <victorsbayas@gmail.com>
---
 db.txt | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index e7b11cf..6e8dbef 100644
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
+	(5150 - 5250 @ 80), (50 mW), AUTO-BW, DFS
+	(5250 - 5350 @ 80), (125 mW), AUTO-BW, DFS
+	(5470 - 5725 @ 160), (125 mW), DFS
+	(5725 - 5850 @ 80), (1000 mW)
 
 # EE as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.30.2

