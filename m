Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DFA40286F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Sep 2021 14:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbhIGMTp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Sep 2021 08:19:45 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36896
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344142AbhIGMTe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Sep 2021 08:19:34 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 34CE53F046
        for <linux-wireless@vger.kernel.org>; Tue,  7 Sep 2021 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017107;
        bh=hZ5N4zB6ne7AqKTWsazgl2eww5+7SrfSBiF0jiwRIRU=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=fkzyi7n2xgRThZvtfH3XLRK+o6Zi5blyGh4ByOfRM/sSR9Cgp0Y2eDc40e84Vanzs
         kC+WzjJtzvYxuyFUmpdqyHEKLG5TRiTAXRwcBiRPqp4RZgwVSMTIn4QmEVe8lieaOU
         KcPfoFh1kcX6o/UkVuptmGXQTUnYIUFgjcTaZyyKkZMdEN8JyhuyjOrXKrodx4V8eC
         qCPbbUgwQ3y/qrmL6gT+SgFm857RhIunvC8c0LFXkt/iwGqqRKORntTYAluSCXTwfB
         RigmusWPTsxExSx7aAk56pBDbWBvHTDqB88i+U5wyL2yJUETciH47H8bmuaNMErxNz
         NJFnfzSFLe33A==
Received: by mail-wm1-f71.google.com with SMTP id o20-20020a05600c379400b002e755735eedso1052935wmr.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Sep 2021 05:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ5N4zB6ne7AqKTWsazgl2eww5+7SrfSBiF0jiwRIRU=;
        b=RS3yodDrAjiOS1MlH55Uyk/6w7Sh6m9b6Ev9hk6MOO14hn7KlSOS0/k0/Q77kEWaFx
         x3SvKSg31zXjQAaGYPHb7wyfZFX/+yrQtKrpJtuHqOoR3A2WtwaBH+HDI+b20No57kpt
         bvXWTgP1DXzbqgJblYyYZNfaiXG+7c2uMUx4juaRfg5NH/Emt8bMg3kov9vA/XW0guUJ
         Pz26mg1ZEBpFWHQwqYfpwV616Ixo2tScf/91eygy9C2G1SUCgvjFuIoLNdM3SC9VyKRT
         iui+VqjQczk1htTbajirARdVk1sYsGU6DAtChD/KMUV4QvgU5ZFLo69gHJLgNbB0r+wx
         68TQ==
X-Gm-Message-State: AOAM533ykATRkMBOAFPNTCONUW2YkyLw3H6Vou2fj+9ivZKAO6KiBFDW
        o2cJXKJAdV8nWmbBKJOhGOZvYWmpEnqAHLcjc0gPAdGljlnb0A3yOZhigN6egX6fBkO78cwKvlQ
        7rknehx5FX2jwoVo72VzTZzrL6JcrW54SMakalXSfHzKM
X-Received: by 2002:adf:b348:: with SMTP id k8mr3883767wrd.123.1631017106985;
        Tue, 07 Sep 2021 05:18:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgbBZYQOs4YRKdywoy8M0o3zhvETIaAW/i0wBtwjAAuvZRpPDbv0ZXj/kM++iU/bcy36GOCg==
X-Received: by 2002:adf:b348:: with SMTP id k8mr3883754wrd.123.1631017106864;
        Tue, 07 Sep 2021 05:18:26 -0700 (PDT)
Received: from kozik-lap.lan ([79.98.113.47])
        by smtp.gmail.com with ESMTPSA id m3sm13525216wrg.45.2021.09.07.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 05:18:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 04/15] nfc: fdp: drop unneeded debug prints
Date:   Tue,  7 Sep 2021 14:18:05 +0200
Message-Id: <20210907121816.37750-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
References: <20210907121816.37750-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ftrace is a preferred and standard way to debug entering and exiting
functions so drop useless debug prints.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/fdp/i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index 051c43a2a52f..f78670bf41e0 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -335,7 +335,6 @@ static int fdp_nci_i2c_probe(struct i2c_client *client)
 		return r;
 	}
 
-	dev_dbg(dev, "I2C driver loaded\n");
 	return 0;
 }
 
-- 
2.30.2

