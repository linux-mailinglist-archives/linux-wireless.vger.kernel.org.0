Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4395349758A
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jan 2022 21:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiAWUoJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Jan 2022 15:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiAWUoI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Jan 2022 15:44:08 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1476EC06173B
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jan 2022 12:44:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f17so9984474wrx.1
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jan 2022 12:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7ZBEjCn+lkjb6jeRnJ16QVEUOr4HiZcOfZUdeWEHec=;
        b=oHbJ8xkO/Ojfj4RINLfEgVPxcYIcndQPhd9V0tZFwi9pZY5O74GuNTwar3ZSENwflH
         xQxaFNMgNQJb8oPsNjIjoYsmWkrigHadLYN/T4PpNgidooMnJhcKhT1Pw0JHIqBpl8+v
         k22egn6Vk8Vx098ngy/ruGz7vKxmXzMPskFLBkpSMxYaVAwR4fH5QOSB0CHIyj94yANW
         UZ+wbuMbH2IAdHrHhTHY+vkX0orqsvPz7tL+0ulhbOgEIoCScVRuymV9Qe646Kj9fqpC
         yOAg2H5YKr0wIDJwQh5pl4HmAhwuFOzsGS1k/VITgLSYQWwkK5PXaaRDNBlyYzaRIbFT
         EyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/7ZBEjCn+lkjb6jeRnJ16QVEUOr4HiZcOfZUdeWEHec=;
        b=bhqpVq5ldxSxhIaf3Z+Z18L5F8Fq/VacHjTjK8N/njOyuVjcCys12zZkXjPJPBXEMI
         vHbLMMBsqqEjg2shQrBeKmc2x9NYda26g6SjYpGxdZTMo/TuqFGC/KmwIxoTxShwBThn
         KBIliKUfTt0RS5pYi/Q+VM1Nqrvl53Ht3sE4B4Q87HrVUbxWkeVlJeqgElFXTdo90pXo
         6vBmoc7mR2KHVSEHg7+6gcuehWbKB7KD/4qCWiyTcY4cwH1ka/sXda/4BArXr+35Lht/
         +QiI7QVxpHIuiEcDRo+F9oj1IaMizdamDZt9D+BZREMyvy4vBpzj0dtbKR4520SGGZoS
         txxQ==
X-Gm-Message-State: AOAM531tNPMvU4OikQKjyM1GxSjpyHwnhKGq9sh9zw+bZmxzPPV4Zkr7
        a8owRmh4VvADIYQMKnZhsdw=
X-Google-Smtp-Source: ABdhPJwKCZrHdwfB8xGomX42mfc8VipGV8LdC7BylopvthIpQI04D1kKfLgmwZQoBoSaE8lrduE30g==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr11907238wrr.106.1642970646564;
        Sun, 23 Jan 2022 12:44:06 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ec4e:f5a0:225:d3ff:fe36:baa6])
        by smtp.gmail.com with ESMTPSA id l15sm16236736wmh.6.2022.01.23.12.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 12:44:06 -0800 (PST)
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for France (FR) on 6 and 60 GHz
Date:   Sun, 23 Jan 2022 21:43:46 +0100
Message-Id: <20220123204346.14588-1-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The French national agency for radio frequencies (ANFR) has published an updated
revision of the normative radio band allocation table on 2021-12-14. It includes
the authorization for the lower 6 GHz band for 802.11ax as prescribed by the EU
2021/1067 decision, as well as the authorization for channels 5 and 6 in the 60
GHz band for 802.11ay.

The declaration for the 6 GHz band follows the Low Power Indoor constraints.

https://www.anfr.fr/fileadmin/mediatheque/documents/tnrbf/TNRBF_2021-12-14.pdf

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 db.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index 6dbda3c..436d4d7 100644
--- a/db.txt
+++ b/db.txt
@@ -585,6 +585,7 @@ country FM: DFS-FCC
 #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
 #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
+# FR: https://www.anfr.fr/fileadmin/mediatheque/documents/tnrbf/TNRBF_2021-12-14.pdf
 country FR: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -592,8 +593,10 @@ country FR: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4 (ETSI EN 302 567)
-	(57000 - 66000 @ 2160), (40)
+	# WiFi 6E low power indoor
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	# 60 GHz band channels 1-6 (ETSI EN 302 567 v2.2.1)
+	(57000 - 71000 @ 2160), (40)
 
 # GB as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893)
 # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
-- 
2.20.1

