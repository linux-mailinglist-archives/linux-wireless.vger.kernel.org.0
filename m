Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A290F7EA01C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjKMPf6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 10:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjKMPf5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 10:35:57 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A3D67
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 07:35:54 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4ac20c41e82so1934010e0c.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 07:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699889753; x=1700494553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PdjSok2XoLaWMORWa8Sq9Dmuh3JEG3tHfef6IY4J7g=;
        b=BMb1bicHwvAkni6glMNRDyi3u9HvIsv1Q99NDIpZowVtx/7WhinJm8ywyS32Q0rXSj
         wh8ieMCIdc8vZMj7cYG18TAJeSDdaM790lHOPessLmnKnmxvLndnfY41605ywv7DEV/m
         OlXyalBGhoYOLN3A0tsjq61fAaOlQKx1g/fW4fbB4OHgkdjgnrV1dlFVMexhsO552gFP
         GwHpUmyZXSqI+AJyhN45KZDsOoIJrPa9RCz0miIV+T6u2jVY2VLp2onPY7Cq1Ej4ZyUD
         S6rvfOGLiKgPhRgApO3Aho0YX5y0VwOpG0m/yYfAFSpsFkX2YDSTzi+nSaJ+SuTPi1vA
         WWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699889753; x=1700494553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PdjSok2XoLaWMORWa8Sq9Dmuh3JEG3tHfef6IY4J7g=;
        b=rZ6vducAbmGHvrx6XoYlxMxBsVU6WCp1FfnnVW37Azc54czXB/Mzy54FNCzo+XKHBP
         IVAkeZ1U943dfvA+kmms5famJYDfuibjEwTN7JYHk184O32/I/VsKD8bOL9gyewpzGr+
         H7Hn4Xdb14Vb6g76TCI09I3SF0K//e0jVDMHjhl6gUEWGMRfU+6MsieJ+JsAZjE58hXx
         605cmLgJ7tHSKfpF7d057hmnjDyXj5fjwDS9r+79BQfEQLn91cup7pn/a5BthJe8oOoT
         M4zFHxY/C7QJAZE7G73cz4PrhBn8Q9vH4Y2l5vqwlfvxx3r3Rrg6djkIPwsD/55pUALO
         KMNQ==
X-Gm-Message-State: AOJu0YyRXmSkrx+n++x9SR5aB9XerZr3mMUQwZVW8Uqc4GipZ94638XO
        MtkVhTFKLTswgZJKD1EIZLHKLDxQRyg=
X-Google-Smtp-Source: AGHT+IG2mhYLwm8auUoh0ELZfl6ZoLSC47MqFJqMDJaN172fE5Ny0Ht9823SAp0l4YIzu0kde3/qIg==
X-Received: by 2002:a1f:a084:0:b0:49b:289a:cc3f with SMTP id j126-20020a1fa084000000b0049b289acc3fmr6115120vke.3.1699889752763;
        Mon, 13 Nov 2023 07:35:52 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id o2-20020ac841c2000000b0041803dfb240sm2016794qtm.45.2023.11.13.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:35:52 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] wifi: ath12k: use select for CRYPTO_MICHAEL_MIC
Date:   Mon, 13 Nov 2023 07:35:44 -0800
Message-Id: <20231113153544.282461-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231113153544.282461-1-prestwoj@gmail.com>
References: <20231113153544.282461-1-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Let ath12k select this option automatically which makes building
more intuitive if the user enables this driver (rather than the
driver not building unless CRYPTO_MICAEL_MIC is explicitly enabled)

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 drivers/net/wireless/ath/ath12k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/Kconfig b/drivers/net/wireless/ath/ath12k/Kconfig
index 4f9c514c13e7..e135d2b1b61d 100644
--- a/drivers/net/wireless/ath/ath12k/Kconfig
+++ b/drivers/net/wireless/ath/ath12k/Kconfig
@@ -2,7 +2,7 @@
 config ATH12K
 	tristate "Qualcomm Technologies Wi-Fi 7 support (ath12k)"
 	depends on MAC80211 && HAS_DMA && PCI
-	depends on CRYPTO_MICHAEL_MIC
+	select CRYPTO_MICHAEL_MIC
 	select QCOM_QMI_HELPERS
 	select MHI_BUS
 	select QRTR
-- 
2.25.1

