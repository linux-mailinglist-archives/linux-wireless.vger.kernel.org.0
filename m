Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC622790B74
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Sep 2023 12:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbjICKUt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Sep 2023 06:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICKUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Sep 2023 06:20:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE0110
        for <linux-wireless@vger.kernel.org>; Sun,  3 Sep 2023 03:20:45 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so277337b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 03 Sep 2023 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1693736445; x=1694341245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6XXDs+jljXJa177mWNIN+D05m6VZztSbnyEvLxch/Pg=;
        b=C1r3M46vJlG9nclflqytRf0CtUP6aDmjkntFqsqnbyvqATJj3MsGhMco0ISRk89sb+
         WWXyIaln0vDjwKkpzBm0HWaHL2rLM6YN3it28JY/gkAV/RIJT2K4+w38Tx5er3XG2CWB
         imNozKDHKMBPQbU9s773c6v6bn3a1qXiU4JuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693736445; x=1694341245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6XXDs+jljXJa177mWNIN+D05m6VZztSbnyEvLxch/Pg=;
        b=D6ifFgPWOWyN9okdMkwuMXdoAohYlyzOA8K1L3OgBI55a3NAYymJalBo/JnKz3DrOW
         QIUdmcIBS7cq//y4X3pmRTXYTSJG8fJzBaoX5XckyboSCKiC+QtXzxirWE9C+ffK0jns
         pg2iw/+Ieq/8pljdwQVdp8SZjdlJrCgaq/81l9dnmsG+Ivxf4l818Xvd6AFw5W71JILS
         vbcVHDczLw2KQMUos+t6jse7wA8W0Q0ThNao68aiLrMH/WINkqU0jcfgqNR8b6xMvI1d
         N+GW7AKtll5eoWF8S3TdG8AtdZ9Fsx/g2VyCj+m7joHflBv2uTpWM15gpAGYgzTlSIU2
         297A==
X-Gm-Message-State: AOJu0YzZtqveXLw/FtJeQJLS+OI+3oA4aS/vgRk6HOhF+Yw0HBfppPej
        uETg3f9wCSpn5JSk5P1BS6k8QZnTmggVL+PF1JSt1g==
X-Google-Smtp-Source: AGHT+IHnarHww6vziXMh0qkiYHOxzhtFZzACr1C80yA3Vp1HMQ3QSmPLg+GRws1v5wd+Oao+9dOSaA==
X-Received: by 2002:a17:903:1cf:b0:1b9:e8a5:3699 with SMTP id e15-20020a17090301cf00b001b9e8a53699mr7373006plh.21.1693736444717;
        Sun, 03 Sep 2023 03:20:44 -0700 (PDT)
Received: from livaq3plus.. ([2401:7400:c808:8240:d9ba:2e67:481b:ca36])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b001b88da737c6sm5717318plj.54.2023.09.03.03.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 03:20:44 -0700 (PDT)
From:   Andrew Yong <me@ndoo.sg>
To:     linux-wireless@vger.kernel.org
Cc:     wireless-regdb@lists.infradead.org, Andrew Yong <me@ndoo.sg>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Singapore (SG) for September 2023
Date:   Sun,  3 Sep 2023 18:20:22 +0800
Message-ID: <20230903102022.11186-1-me@ndoo.sg>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

 - Update regulatory rules for September 2023 IMDA TS SRD [1]
 - Enable 5945 - 6425 MHz (Wi-Fi 6E) band per legislation
 - Switch units from dBm to mW to match values listed in legislation
 - Allow AUTO-BW between 5470 - 5850 MHz to permit additional 160 MHz BW options

[1] https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-consultations/ict-standards/telecommunication-standards/radio-comms/imdatssrd.pdf

Signed-off-by: Andrew Yong <me@ndoo.sg>
---
 db.txt | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/db.txt b/db.txt
index fdc2c13..cbe1a88 100644
--- a/db.txt
+++ b/db.txt
@@ -1584,25 +1584,27 @@ country SE: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-# https://www.imda.gov.sg/-/media/Imda/Files/Regulation-Licensing-and-Consultations/ICT-Standards/Telecommunication-Standards/Radio-Comms/IMDATSSRD.pdf
-# IMDA TS SRD, Issue 1 Revision 1, April 2019, subsequently "IMDA TS SRD"
-# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 (25); ANSI C63.10-2013 and FCC Part 15 Section 15.247 or EN 300 328
-# 5150 - 5350 MHz: IMDA TS SRD, Table 1 (29); FCC Part 15 Section 15.407 (1) 5.15-5.25 GHz (2) 5.25-5.35 GHz; EN 301 893
-# 5470 - 5725 MHz: IMDA TS SRD, Table 1 (30); FCC Part 15 Section 15.407 (2) 5.47-5.725 GHz; EN 301 893
-# 5725 - 5850 MHz: IMDA TS SRD, Table 1 (27); FCC Part 15 Section 15.247; FCC Part 15 Section 15.407 (3) 5.725-5.85 GHz
-# 57000 - 66000 MHz: IMDA TS SRD, Table 1 (31); ETSI EN 302 567
-# Note: 27dBm for 5470-5725MHz bands is 3dBm reduction per FCC Part 15 Section 15.407 (2) 5.47-5.725 GHz; EN 301 893 as referenced by IMDA TS SRD
+# https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-consultations/ict-standards/telecommunication-standards/radio-comms/imdatssrd.pdf
+# IMDA TS SRD, Issue 1 Revision 3, Sep 2023, subsequently "IMDA TS SRD"
+# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 Sub-band 32e
+# 5150 - 5350 MHz: IMDA TS SRD, Table 1 Sub-band 33a
+# 5470 - 5725 MHz: IMDA TS SRD, Table 1 Sub-band 34
+# 5725 - 5850 MHz: IMDA TS SRD, Table 1 Sub-band 35
+# 5945 - 6425 MHz: IMDA TS SRD, Table 1 Sub-band 45b
+# 57000 - 66000 MHz: IMDA TS SRD, Table 1 Sub-band 40
+# Note: 500mW for 5470-5725MHz bands per FCC Part 15 Section 15.407 (2) 5.47-5.725 GHz as referenced by IMDA TS SRD
 #  AU and BG regulatory domains use the same interpretation of cited FCC and ETSI standards
-# Note: The transmit power for 5250-5350MHz bands can be raised by 3dBm when TPC is implemented: IMDA TS SRD Table 1 (29)
-# Note: The transmit power for 5470-5725MHz bands can be raised by 3dBm when TPC is implemented: IMDA TS SRD Table 1 (30)
+# Note: The transmit power for 5250-5350MHz bands can be raised by 3dBm when TPC is implemented: IMDA TS SRD, Table 1 Sub-band 33a
+# Note: The transmit power for 5470-5725MHz bands can be raised by 3dBm when TPC is implemented: IMDA TS SRD Table 1 Sub-band 34
 
 country SG: DFS-FCC
-	(2400 - 2483.5 @ 40), (23)
-	(5150 - 5250 @ 80), (23), AUTO-BW
-	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
-	(5470 - 5725 @ 160), (27), DFS
-	(5725 - 5850 @ 80), (30)
-	(57000 - 66000 @ 2160), (40)
+	(2400 - 2483.5 @ 40), (200 mW)
+	(5150 - 5250 @ 80), (200 mW), AUTO-BW
+	(5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
+	(5470 - 5725 @ 160), (500 mW), DFS, AUTO-BW
+	(5725 - 5850 @ 80), (1000 mW), AUTO-BW
+	(5945 - 6425 @ 320), (250 mW), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (10000 mW)
 
 # SI as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.41.0

