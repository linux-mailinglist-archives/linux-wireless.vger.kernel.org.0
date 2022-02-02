Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3A4A7B4F
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Feb 2022 23:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347951AbiBBWwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Feb 2022 17:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347938AbiBBWwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Feb 2022 17:52:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90526C061714
        for <linux-wireless@vger.kernel.org>; Wed,  2 Feb 2022 14:52:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id s18so1322626wrv.7
        for <linux-wireless@vger.kernel.org>; Wed, 02 Feb 2022 14:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Y1jPAyL1xOFLM7YyaPmwDCktPz/RiDJpfcKX/6shOE=;
        b=MzLQPo1bVMe7ZXHrz7gLw7NxC2q8exlBDDXekuoVgoAOZhZJff7f5Az/hi/+MYsnEK
         MRZXzREFPYyidN8sxxvnsaCKK1t5389Odl+Q672ewsl1rn+NIvqJCjLgZTwdVb5u5Lvd
         8OhsDBHADg46uQFKUO4Ty3B08Jrne3/TkNOvBSeHS+93TVrBfte6mFccov2XPaUNyRRe
         gL88CxDEEIG1lgVbbb7k0RPQQ4ejaW9I3aRC0Nf+1tZ6IDx+IciUf7EE/vm0QRWdGPXP
         +cIO+krxjWYSSeS/WvzYxHm6816D7ie0DTEkxktyuOgbvce3C+Qb6zgPo/9Brse8J73m
         SXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Y1jPAyL1xOFLM7YyaPmwDCktPz/RiDJpfcKX/6shOE=;
        b=zpTaHcNeq+tIz7H5+eGh5hPqhjeKsRruWBe7BG2T9Sg7NnrZLQ5DP0Pqa3K1sqAgF5
         V1M0CfujvtfNgB8px/uOvPMImf5LSqcKujPDw9KcfZ0l+BvPqwpdveVyrrwy6B3Cgzu/
         ja8qQ5fnwCzpk5jvLYvkIHdEAQpeaJ32HOpwz8quRhv2xcbFt+abe4oe1FjVTRQcXY/d
         fEmntjWogsH7RMy2BtLh9fa+jaHDJ+gr4o5ZsWZdJwSrkO5k9hbSTd37/oSIXO3EUYj1
         upSj8IA5A4PK3mdIPldoeS8jkIXNLzs0t7JabgH43t8LpMkDY/P1DDDa7XZXokQkHmST
         L8DA==
X-Gm-Message-State: AOAM533OP1ST7yc1Rt3toRtatxQ7lQsWfojCFdFADCLnaj+j6+YLKWRn
        ObzwroqZRWFOMrXm6ZkmBLHcbhigrw==
X-Google-Smtp-Source: ABdhPJymxREiIvACPFepf/haoPjM6PD5iWRtffqJCkgzrVZ4Cct0G8NCdNT3GBlsq9ZKh3dUGeynog==
X-Received: by 2002:a5d:6486:: with SMTP id o6mr26728499wri.636.1643842318862;
        Wed, 02 Feb 2022 14:51:58 -0800 (PST)
Received: from localhost (233.red-81-38-238.dynamicip.rima-tde.net. [81.38.238.233])
        by smtp.gmail.com with ESMTPSA id h18sm598976wro.9.2022.02.02.14.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 14:51:58 -0800 (PST)
From:   Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Seth Forshee <sforshee@kernel.org>,
        WIRELESS ML <linux-wireless@vger.kernel.org>,
        REGDB ML <wireless-regdb@lists.infradead.org>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Spain (ES) on 6GHz
Date:   Wed,  2 Feb 2022 23:51:57 +0100
Message-Id: <20220202225157.91989-1-xose.vazquez@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add WiFi 6E frequency band.

Sources:
(EU) 2021/1067: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32021D1067
BOE numero 308, de 24/12/202: Orden ETD/1449/2021: CNAF-2021 (page 302): https://www.boe.es/buscar/pdf/2021/BOE-A-2021-21346-consolidado.pdf

UN-167 RLANs en 6 GHz

Aplicaciones de uso común en la banda de 5945-6425 MHz.

De conformidad con la Decisión de Ejecución (UE) 2021/1067 de la Comisión, sobre el uso
armonizado de la banda 5945-6425 MHz para sistemas de acceso inalámbrico, incluidas las
redes de área local (WAS/RLAN), se permiten estas aplicaciones en la citada banda de
frecuencias bajo la consideración de uso común con arreglo a las condiciones técnicas
indicadas en el anexo a la citada Decisión.

Los dispositivos de baja potencia para uso en interiores (LPI), tendrán una potencia máxima
de 23 dBm (p.i.r.e.), con una densidad de potencia p.i.r.e. media máxima de 10 dBm/MHz
para las emisiones en banda y de -22 dBm/MHz para emisiones fuera de banda.

Los dispositivos de muy baja potencia para uso en interiores y en exteriores (VLP), tendrán
una potencia máxima de 14 dBm (p.i.r.e.), con una densidad de potencia p.i.r.e. media
máxima de 1 dBm/MHz para emisiones en banda, o hasta 10 dBm/MHz si funcionan con
canalización que no supere los 20 MHz, y de -45 dBm/MHz para emisiones fuera de banda.

En cualquier caso, estos dispositivos deberán utilizar técnicas de acceso al espectro y
mitigación de interferencias que garanticen los requisitos esenciales de la Directiva
2014/53/UE.

Cc: Seth Forshee <sforshee@kernel.org>
Cc: WIRELESS ML <linux-wireless@vger.kernel.org>
Cc: REGDB ML <wireless-regdb@lists.infradead.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
---
 db.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/db.txt b/db.txt
index 6dbda3c..5e41f7d 100644
--- a/db.txt
+++ b/db.txt
@@ -549,6 +549,8 @@ country ES: DFS-ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
+	# WiFi 6E
+	(5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-- 
2.34.1

