Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDAB4C1CA6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 20:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbiBWTxz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 14:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbiBWTxz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 14:53:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BA24C40A
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 11:53:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i11so44188149eda.9
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 11:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Id7gLQHKMx+QutSy3tPhG606eG0uppY8RxjJxXA7nNw=;
        b=nfP0/TUTFvI0Bgnwxl2ARIRvtRqF0RX9/VDvI/8ZVANfriAu/bHsn9sUCT17WbAr/q
         4LO2PzE4OX9qxD0hCp/CNWMBR/K3XXEwdWH3uN7EUKYPcp5fjNcqY0T9SZ0xJHmwatf0
         y55CJ1iGnrFp6Zg/L4v1FZl+BzyVpZggfN8Wu60mvmOIUT7gKzs/9xsahmH/UsOzfrfw
         Kd3UcromWF7jwwUCZCBNIxLEeAz2PKDlUr74Fc9yNoxw5EWvXA8FhtOekd7ptQ5c7tYf
         uLc9cN9bFQC1DHttpQlbRJgdFKROaXh82A4k0l6JgF508sBMeFeLbTRDoquL/lImpA2+
         uxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Id7gLQHKMx+QutSy3tPhG606eG0uppY8RxjJxXA7nNw=;
        b=5AGic2uZVhqZgGd3g+aiHLksl9EQ7poR/Zkukypp+L7dCbpMMs316gWyUF9tjCKS9/
         qOaCAHZbsKShelQWPcpslEMhF+RMQw19E1XyCostyib8QL0Dc4gz6jL3JVRflkSVjm+4
         kDri1yUwMbdawm0CaNtqK+7zrtrRONPz5XndiZzYErngcfQpaVNw8tQOB8a/9NJewixc
         fX7qFvujrHiDbp/SpWY/8fho6QKHnWG+qjFD/7Umw7BsRUWWmMNAtwBN2juJ77Yo3ASB
         cyWTnWznXlbiMqMfJKGPM621NBaIP2nysWOgjTjPPhgam13JK+uPtqRpCHX40ov/QT9Y
         vrug==
X-Gm-Message-State: AOAM533F6zvQ67FM+QxK9YmKUkL0OxVtf1K5REGkbHKkS8tNNV2uChTJ
        MB4eNxLvtcX9nrHO8S96c9T5HoO+c8E=
X-Google-Smtp-Source: ABdhPJzAxB4++MHSIAdXpeX+gKgOFrcFoLnI4/+wSoI7sbwlNSZ4clhNVhuYq3cl2XwGrQqvDS6xZQ==
X-Received: by 2002:a05:6402:142f:b0:40d:e8eb:1dbe with SMTP id c15-20020a056402142f00b0040de8eb1dbemr974004edx.421.1645646005490;
        Wed, 23 Feb 2022 11:53:25 -0800 (PST)
Received: from debian64.daheim (p5b0d779b.dip0.t-ipconnect.de. [91.13.119.155])
        by smtp.gmail.com with ESMTPSA id 23sm232417ejf.215.2022.02.23.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:53:24 -0800 (PST)
Received: from chuck by debian64.daheim with local (Exim 4.95)
        (envelope-from <chunkeey@gmail.com>)
        id 1nMxhU-001Rh8-1l;
        Wed, 23 Feb 2022 20:53:24 +0100
From:   Christian Lamparter <chunkeey@gmail.com>
To:     linux-firmware@kernel.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@qca.qualcomm.com>
Subject: [PATCH v2 5/5] ath10k: QCA6174 hw3.0: update board-2.bin
Date:   Wed, 23 Feb 2022 20:53:23 +0100
Message-Id: <5ed7d88456e5fef317b71705c51247597e9ff2b9.1645645875.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <da7d9cff16246c5c8dc003248a0ec4832606b1c6.1645645875.git.chunkeey@gmail.com>
References: <2ce6ca92f529aca13984db205ed38fa0fa6d436f.1645645875.git.chunkeey@gmail.com> <63972ee8daa620c57eda5eb89221ecfeb55f46af.1645645875.git.chunkeey@gmail.com> <623e92dfaae9117e59c9ff9c9d1189295072d034.1645645875.git.chunkeey@gmail.com> <da7d9cff16246c5c8dc003248a0ec4832606b1c6.1645645875.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

syncs linux-firmware.git with the latest releases from Kalle Valo (QCA):
<https://github.com/kvalo/ath10k-firmware/tree/master/QCA6174/hw3.0>

556321a QCA6174 hw3.0: update board-2.bin
d1a9282 QCA6174 hw3.0: sync board-2.bin from upstream linux-firmware
c987e38 QCA6174 hw3.0: update board-2.bin
b44d86f QCA6174 hw3.0: update board-2.bin
8ba5ed7 QCA6174 hw3.0: update board-2.bin
3ce0d6d QCA6174 hw3.0: update board-2.bin

Cc: Kalle Valo <kvalo@qca.qualcomm.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
v1->v2: sent to linux-wireless + ath10k mailing list too (Valo)
---
 ath10k/QCA6174/hw3.0/board-2.bin | Bin 715444 -> 723668 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/ath10k/QCA6174/hw3.0/board-2.bin b/ath10k/QCA6174/hw3.0/board-2.bin
index 0bc5ddabc3354269822edd75fb7ab329c0efd6a8..239db8985d7aecbb6662db917319512fdffdc876 100644
GIT binary patch
delta 47
zcmdmTRr|_RorV_17N!>F7M2#)7Pc1l7LFFqEnHh(O)k)6nZDp9M<|nt`F8z7j7Q}G
DvL_Lq

delta 29
lcmcaIRcFgp?S>Y{7N!>F7M2#)7Pc1l7LFFqEnHh(0RXGF3ikj2

-- 
2.35.1

