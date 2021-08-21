Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843F23F37E0
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Aug 2021 03:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbhHUBJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 21:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhHUBJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 21:09:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F1C061756;
        Fri, 20 Aug 2021 18:09:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k5-20020a05600c1c85b02902e699a4d20cso7039847wms.2;
        Fri, 20 Aug 2021 18:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcYSAh37tYGfOcz68oPLczgRQrzJo44tg66hXDfFigc=;
        b=OG1FxgjXGBWAxGA1anG/qouatpziretSb3btXyjQ0HvbXcQqium0ZqecGus6IbGl+H
         HzhLD7XrmsuuaHPsNI0ei/6UpTRU9Ro3mKJLEkubLn8rwj6nwEHT3snMDRWpYbRfg8Jt
         aPPw3S0cB+5/fFWfdQaw4ncloi7juZFnXElENdg0qFHnRManGUDp99u5xsILxjnWg5Gv
         tfGRmStx8SGrUsD7n68Geg1n/zDriEBhBAcKubbX4z9U8KgObDpvGMerQUKmDreOlkW7
         ZVH7lBbl18aKIkmiO4dmXsVKodrUAe6ZZerOvRonTo18BAWL6Lv5H4gk+VDftlL+t7Ma
         nrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AcYSAh37tYGfOcz68oPLczgRQrzJo44tg66hXDfFigc=;
        b=W9aYyYagvb2DALE797ijhPsSUQDZ7DnyKsVYf4lzyf/BDWglvdf2Iwr4Ne2+TH9jjQ
         1U8ya20kL8EkpABvXCJbZR03rf+OIwY3tV3C3NIeTN3gkwCaCFhnec/g2GY5SAI5d/iY
         1vZOaP4+rgKRbiIN8AB56YD1SbdP1K4nrLsBW1avOaytUDXVVfve60QYbnN6xobyCNDh
         pzKrz0Age9ZVd8WIMrWv1fhkLDq4tDA4slP04hBbB5EhX4ahKyRQln3Jf6oVZ9q7Ep2y
         hzfMmOPPe6qYs6JlfwYfvyKTWGpz9lW7enTkFUKLCKAGbBFy23+fDCNhHYlG4tAB/wox
         n69Q==
X-Gm-Message-State: AOAM533uHflOs3SkpyKplM8k1jGn7wwKqEPN2mE880Wuzs33tosHLCCI
        7IuwPSltKCbkhrednHQDF+RniH/Eq1c=
X-Google-Smtp-Source: ABdhPJz8gPzOw/Nwv9WuHVXNJHIvT9HbNHiCjMybUfwnKcGqS3vHqS8ZYOd8sZzoLU3K+xl7zUgYoA==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr6186956wme.91.1629508156517;
        Fri, 20 Aug 2021 18:09:16 -0700 (PDT)
Received: from debian64.daheim (pd9e297bb.dip0.t-ipconnect.de. [217.226.151.187])
        by smtp.gmail.com with ESMTPSA id o6sm7498992wru.92.2021.08.20.18.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 18:09:15 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.94.2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mHFVb-0046Wv-7e; Sat, 21 Aug 2021 03:09:15 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com
Subject: [RFC PATCH v1 1/3] dt-bindings:net:wireless:qca,ath9k: add nvmem-cells for calibration data
Date:   Sat, 21 Aug 2021 03:09:13 +0200
Message-Id: <91e68ca7f65bee7197ed5829ef91bc526df16e8a.1629508039.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On most embedded ath9k devices (like range extenders,
routers, accesspoints, ...) the calibration data for
the RF/PHY is simply stored in a MTD partition named
"ART", "caldata"/"calibration", etc.

Any mtd partition is automatically registered in the
nvmem subsystem. This makes is possible to fetch the
necessary calibration directly from there at the low
cost of adding nvmem cell information via the
device-tree or via similar means.

This speeds up the driver's initialization a lot,
because the driver doesn't have to wait for userspace
to provide the data via helpers.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 .../devicetree/bindings/net/wireless/qca,ath9k.txt     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
index aaaeeb5f935b..88b322b55dd8 100644
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
@@ -34,6 +34,13 @@ Optional properties:
 			ath9k wireless chip (in this case the calibration /
 			EEPROM data will be loaded from userspace using the
 			kernel firmware loader).
+- nvmem-cells: A phandle pointing to a nvmem-cells node representing registers
+			that has information about the MAC-Address or
+			calibration data.
+			Please refer the for nvmem-cells bindings
+			Documentation/devicetree/bindings/nvmem/nvmem.yaml.
+- nvmem-cell-names: Should be "address" for the MAC address. "calibration"
+			for ART/caldata.
 
 The MAC address will be determined using the optional properties defined in
 net/ethernet.txt.
@@ -44,5 +51,8 @@ In this example, the node is defined as child node of the PCI controller:
 		compatible = "pci168c,002d";
 		reg = <0x7000 0 0 0 0x1000>;
 		qca,no-eeprom;
+
+		nvmem-cells = <&macaddr_art_c>, <&cal_art_1000>;
+		nvmem-cell-names = "mac-address", "calibration";
 	};
 };
-- 
2.33.0

