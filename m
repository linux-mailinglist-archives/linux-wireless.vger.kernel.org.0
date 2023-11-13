Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369C37EA01B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjKMPf4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 10:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjKMPfz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 10:35:55 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E388AC2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 07:35:52 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41cd8bd5727so27172841cf.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 07:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699889752; x=1700494552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/qRHNLJQLqgBuhA+bGh1CdRxwGlPm5c6onmqi8Aufi4=;
        b=dHxDHt/y3MeSjoXvDWBRdaby6NrPyNeiPK1aUlSsDue/Z8ajI9vTCczBXAiwmd2LR4
         hxxugc94TGGAtCnlnXkl4e1/x6gnkBK8HmqFrj4dWnMYGMrHEMpAvzqQlgQ4vxvQciDJ
         YYNjcpLdr13t/kWPTe1XnSShDQCbLE9C80YDf3DwfKSY8ltsaS+emqGQK1EfJyLBBOS/
         u9xMliw2lkMvNTCLmN1GE3DGBGj+gQTAQwVfM8+ZoFgqvnDE0f7QfP4fImgwlJXm0o1O
         3KgHS4cHkniktu6j/QPUgZ9EdP/UG1KXNZkmYa7I3F8OZFlMJBlmoYfMipf8gwDCp/sJ
         GS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699889752; x=1700494552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qRHNLJQLqgBuhA+bGh1CdRxwGlPm5c6onmqi8Aufi4=;
        b=biGDc15sg8YQU8/W/OqoDGWndoca5C/nHdRfGr1BqLz202r1STQYu1twHtSSBKk6Jd
         ZMSxKoVmQYfxqMfg4tWaHCWcmf3IkekNJAhDRnPm1bL9RjKAP/JT3GAMbm8NuV7ami72
         cpiSLMD8gddT1/BrlGS1KjB/6wieWSBsAiA30A0P8fPmAjGd6p1oZ/zhnQ6wrH/gh1XI
         3GHVb0K33VtHNllE2Gm7RJzB5IjqiPKt2Rb2j0u8DFZ6qZjlv/h9L0MNFSyI7Xb/3YAx
         Gd2zY/2/07Mg7vyXp0x4zkoF+fa7VmFOWiMoQCf3djAHZeiczFpUDOqaTbKybXT20g6E
         mWxw==
X-Gm-Message-State: AOJu0YzGfau89pMzpd8XKj7yyuCD84Lwl3nlVELkYcozXBKFc92zkilC
        cGrk19ZN7/9lf9lOsrXjwU8oBnolnWU=
X-Google-Smtp-Source: AGHT+IH9spqrhUQpN9rLxm+6OxRlqrfvw1OLSAXH0D6fkHFjruwlInYzdjWSnFfe7qOJXFm5qONoHg==
X-Received: by 2002:a05:622a:1451:b0:41e:a8ab:3c73 with SMTP id v17-20020a05622a145100b0041ea8ab3c73mr7846568qtx.41.1699889751731;
        Mon, 13 Nov 2023 07:35:51 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id o2-20020ac841c2000000b0041803dfb240sm2016794qtm.45.2023.11.13.07.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 07:35:51 -0800 (PST)
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
Date:   Mon, 13 Nov 2023 07:35:43 -0800
Message-Id: <20231113153544.282461-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Let ath11k select this option automatically which makes building
more intuitive if the user enables this driver (rather than the
driver not building unless CRYPTO_MICAEL_MIC is explicitly enabled)

Signed-off-by: James Prestwood <prestwoj@gmail.com>
---
 drivers/net/wireless/ath/ath11k/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
index ad5cc6cac05b..27f0523bf967 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -2,7 +2,7 @@
 config ATH11K
 	tristate "Qualcomm Technologies 802.11ax chipset support"
 	depends on MAC80211 && HAS_DMA
-	depends on CRYPTO_MICHAEL_MIC
+	select CRYPTO_MICHAEL_MIC
 	select ATH_COMMON
 	select QCOM_QMI_HELPERS
 	help
-- 
2.25.1

