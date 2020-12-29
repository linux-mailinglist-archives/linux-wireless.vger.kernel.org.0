Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E9E2E7351
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 21:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgL2UGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 15:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgL2UGX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 15:06:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C82CC061574
        for <linux-wireless@vger.kernel.org>; Tue, 29 Dec 2020 12:05:08 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id t30so15639340wrb.0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Dec 2020 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPs7e52j0MruEfTDx7S6xZAJfhWHdbowdofq3XG1NZQ=;
        b=fABRlHmpWRHxp9lWlhtrIsXaPWHr9t55GQ0ampr6gozeohTJe37K9x34PQVrmL/hu5
         vrkHhtotfnE95IJW+NEyNajXDAffxzoPLGLDRwXiZQ5PzgFeJAZQ+yfmiCFp/Yg+2c18
         FAi5zHghAVZKBolEnEq3Wa/sjrP67t94oamY3Au4KeEJdx85P5sytwSm3N1Sba7HzDAL
         1Q8vmp+26o/tIKJuPjVQAYDhZ8byvs9xLqeoCNGQpzjVIPkH7yL3hrfRemVyhX0GHdNY
         CB6YzkrtLfp8UDH5cMj5PXRGdpSejeDssWAIXjI4cbm9eUrPFNuOdlCrCExxJ/UAam1q
         0geA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPs7e52j0MruEfTDx7S6xZAJfhWHdbowdofq3XG1NZQ=;
        b=XDyx0fnTvlLZ4JCeUzDd6z+yIzTbCNK2oDT1Atjh21UTD0saD413c9MJcd5Yz2S7Oj
         VvfTMqctKXJBEP8CkznHNAIAOblhUj3d7SDFnR+mvRUYgcGq8xwamhBMsih4EacL71/7
         oJLlOzVyyj+OsMnyBbwONwSJK9gkRdep+UXV1QtpOBVTGYgSYKly/BpL3cOqfYRGdQqd
         ZYAYg9dixga1IFC0CIV3zstLG+CiKioXHGj41FUiwqPwLbmI3Zd4IdmqQLYtds4uIndt
         2tZtSMlagiwUdT80ScAPC+egc8K/ZhUdF9c82CSIQ+xHFMFlLC3DYyFlQLS9pmx0SoFB
         tpaQ==
X-Gm-Message-State: AOAM532VL5krZdr6sl4sG2mLX62NOy4nqb1BlpJk4SR1C/P188UCM0+2
        1qaFojyVUsmVYTrLHng17w==
X-Google-Smtp-Source: ABdhPJzOFkeWyUDeawHNtUjLHgILyiZX1TC9j4+a/l2+MMDuV92VxR5719Qvp5c8csGJ6MP5EaO57g==
X-Received: by 2002:a5d:4d4f:: with SMTP id a15mr57285159wru.315.1609272307062;
        Tue, 29 Dec 2020 12:05:07 -0800 (PST)
Received: from localhost ([94.73.63.168])
        by smtp.gmail.com with ESMTPSA id n12sm67247944wrg.76.2020.12.29.12.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 12:05:06 -0800 (PST)
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        WIRELESS ML <linux-wireless@vger.kernel.org>,
        REGDB ML <wireless-regdb@lists.infradead.org>
Subject: [PATCH] wireless-regdb: update CNAF regulation url for ES
Date:   Tue, 29 Dec 2020 21:05:04 +0100
Message-Id: <20201229200504.6383-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
index c71a03a..d03f3fa 100644
--- a/db.txt
+++ b/db.txt
@@ -527,7 +527,7 @@ country EG: DFS-ETSI
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
-# ES: https://avancedigital.gob.es/espectro/Paginas/cnaf.aspx
+# ES: https://avancedigital.mineco.gob.es/espectro/Paginas/cnaf.aspx
 country ES: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-- 
2.29.2

