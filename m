Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF2A4C1CAA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 20:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244540AbiBWTx6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 14:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbiBWTx5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 14:53:57 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16564C419
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 11:53:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id s14so28534361edw.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRRYmfN+W4uYuWPtzuC8a5o7Osbc3UqXT6pXvUkzigU=;
        b=qtBczWTxN2k/hHU1hasafMOKvI1kbuqmVO/szkp5+xdOdXdAOwlo9xQM6LlZsnPnLd
         aFV3QZtv6RGkw+DVdtgQO5Ioq+/cLCcFmr/XJ9+WWJWuudiBoNUYNhyHkpcwjVlnVPbQ
         fvLZBaObR+njfTpBuii9jaTeUiA6c5SGRkSHZDNW+qDewNLPhxuYtwKRHNC0vWbG7RwL
         Z7s7xTuG76JzaGhU6baMV92x4aLG+xzrQDIAwuXtab0oTY0GJ5TsptSrrwkvwZ29s3Bl
         QauNVQn1uvVe+nWsmVBKKPR2LihYndDy39LZkN1y5gdzY0xB9aybQbfrwqYpws0MiSc6
         WFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRRYmfN+W4uYuWPtzuC8a5o7Osbc3UqXT6pXvUkzigU=;
        b=KhQ4FJsV1+DTArAMLResIr0BITpGiEB/5p4nPpi6BD1D/U6QO6DJliqZ/V9xjLlXJX
         X38EABynraFMhsV2BDFD/Z2bsi6WhpUYHFQxFxDnSQVgW0hscNjMiyqv8wBcJuYy3ibN
         Iz2qwTQMdlUyNxA7QQyRyfOsJTY+BKrhqBblB60bu8cVdLCdEMxTCdaSJk9+aCuC94rG
         +mPMZGfw/n67b9B3YU/1Q6lp7BXP+mm7aaX6e+VrK3+fJF6urgX8vcUh4GMeuMVgjmXt
         Toe6SfXYKerySL2oCoxYhTYfuwZmpbMtd9EPJ11fYlwTNEcxp4oSIZcYQOyaIQOeG24F
         /oQg==
X-Gm-Message-State: AOAM531ncAUguedayDhfMgcERGCMvT5ImXh7cgAMk9bmQpiCvab4sJJI
        u2hvioqdxQDMXJfzZ+kHQqc=
X-Google-Smtp-Source: ABdhPJz6F21a2jihFjj4qPM3p/7rRh7r7g8YoaaEwYTFffV/MJNXhtnUrTCqS8kd0u7KKQvOy3OuPQ==
X-Received: by 2002:a05:6402:f04:b0:410:f0a5:5b02 with SMTP id i4-20020a0564020f0400b00410f0a55b02mr1002383eda.209.1645646006445;
        Wed, 23 Feb 2022 11:53:26 -0800 (PST)
Received: from debian64.daheim (p5b0d779b.dip0.t-ipconnect.de. [91.13.119.155])
        by smtp.gmail.com with ESMTPSA id eq19sm302072edb.36.2022.02.23.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:53:24 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nMxhT-001Rg4-UA;
        Wed, 23 Feb 2022 20:53:23 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-firmware@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>
Subject: [PATCH v2 1/5] ath10k: QCA4019 hw1.0: update board-2.bin
Date:   Wed, 23 Feb 2022 20:53:19 +0100
Message-Id: <2ce6ca92f529aca13984db205ed38fa0fa6d436f.1645645875.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syncs linux-firmware.git with the latest releases from Kalle Valo (QCA):
<https://github.com/kvalo/ath10k-firmware/tree/master/QCA4019/hw1.0>

Includes the following changes:
93591ce ath10k-firmware: QCA4019 hw1.0: Add ZTE MF286D specific BDFs
29b419c ath10k-firmware: QCA4019 hw1.0: Add ASUS RT-AC42U specific BDFs
fb4e69f ath10k-firmware: QCA4019 hw1.0: Add Linksys WHW01 v1 specific  BDFs
ff8c56b ath10k-firmware: QCA4019 hw1.0: Add Plasma Cloud PA1200 specific BDFs
89492ce ath10k-firmware: QCA4019 hw1.0: Add Plasma Cloud PA2200 specific BDFs
faf338c [v2] ath10k-firmware: QCA4019 hw1.0: Add Linksys MR8300 V1.0  specific BDFs
725d7f6 ath10k-firmware: QCA4019 hw1.0: Add Luma WRTQ-329ACN BDFs
a92ca29 ath10k-firmware: QCA4019 hw1.0: Add Buffalo WTR-M2133HP specific BDFs
9f771d2 ath10k-firmware: QCA4019 hw1.0: Update AVM FritzBox 4040 specific BDFs
a633c15 [v2] ath10k-firmware: QCA4019 hw1.0: Add Cell C RTL30VW specific BDF
46a4f4a ath10k-firmware: QCA4019 hw1.0: Add Aruba AP-303 specific BDFs
0e51dac ath10k-firmware: QCA4019 hw1.0: Add MobiPromo CM520-79F
15f1bdd ath10k-firmware: QCA4019 hw1.0: Add Cell C RTL30VW specific BDF
c07b12a ath10k-firmware: QCA4019 hw1.0: Add EZVIZ CS-W3-WD1200G EUP specific  BDFs
f688435 ath10k-firmware: QCA4018: Add D-Link DAP-2610 specific BDFs
b529a8b ath10k-firmware: QCA4019 hw1.0: Add AVM FRITZ!Repeater 1200 specific  BDFs
8f150f4 ath10k-firmware: QCA4019 hw1.0: Add EnGenius EMR5000 specific BDFs
1fad4d7 ath10k-firmware: QCA4019 hw1.0: Update 8devices Habanero specific BDFs
08fccb1 ath10k-firmware: QCA4019 hw1.0: Add EnGenius ENH1350EXT specific BDFs
0d2493a ath10k-firmware: QCA4019 hw1.0: Add EnGenius EMD1 specific BDFs
4f719af ath10k-firmware: QCA4019 hw1.0: Add EnGenius EMR3500 specific BDFs
e2fe755 ath10k-firmware: QCA4019 hw1.0: Add 8devices Habanero specific BDFs
38ebb2d ath10k-firmware: QCA4019 hw1.0: Add EnGenius EAP2200 specific BDFs
bc42587 ath10k-firmware: QCA4019 hw1.0: Update OpenMesh A42 specific BDFs
f305604 ath10k-firmware: QCA4019 hw1.0: Update OpenMesh A62 specific BDFs

Cc: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1->v2: sent to linux-wireless + ath10k mailing list too (Valo)
---
 ath10k/QCA4019/hw1.0/board-2.bin | Bin 607304 -> 1081212 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/ath10k/QCA4019/hw1.0/board-2.bin b/ath10k/QCA4019/hw1.0/board-2.bin
index 58046713c3e25f2332d00550778b897b5524541c..083a9d46dc8bc625993f39117eae36e6611e3421 100644
GIT binary patch
delta 33089
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

delta 212
zcmezK&+$ZuYC{X-7N!KwX|2pw(~m{)$}ma4*e)=GDTZ<T0(U+wuFdzjpG$9-HDub%
z4pd?=&60_0x?Kma%=T|Td6e|q6F8ZGm>Gy!fS7fA0w<e*$n+0eIrOKm-^a>5{h2z)
z$LaF787ro%cW@|eU%Qr#muq{SF~?CAMvmzpX7hA!KOe#IKyUhW4GzWW0&{q>x6420
zkmi~^FN<gTlt~;}(<e;gFxvia5{Ik`*ce8x?E#t`dR&v^PV#O)e~_bBxxGM^4T#yd
K7szs0Z~*`_*Gzl>

-- 
2.35.1

