Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC3672938F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jun 2023 10:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbjFIIpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Jun 2023 04:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241143AbjFIIpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Jun 2023 04:45:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814491B9;
        Fri,  9 Jun 2023 01:44:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso233377766b.1;
        Fri, 09 Jun 2023 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686300297; x=1688892297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV5kS4uFTylsIKBTpLATpLjmqF+bm2uJbZFR1pKIFFU=;
        b=ev/gO9W54hYaCq9ean5DupK1uYMYJe2cw12AnKy5KCgHrVvXscqgta6p77dUi9PpD0
         SQ/8RR5w1cKmN9AKkuezoVkYeu8oxjL1GovQ4Th659JBhce999+AcsmOkaqYQRkfCm1B
         XRWej+p7auDkDaBPPqeKDPymHRTSJ/6iIV6W0Dy2kd0/SlXCXuwYrgaWzMSURucXRWye
         DtfnyXC6hIDfEHOf0t09TwpMGqxWhV9Mf2oBVG2Q8AiLCiT+jxjU4rGtWrajThtnCXqq
         2PEDII6gwra9FL/ixUsC2wZaUb+0bKHxfjioOC4g5KRZd2t7PvGuy9u83kxaIzbUAFma
         oMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686300297; x=1688892297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV5kS4uFTylsIKBTpLATpLjmqF+bm2uJbZFR1pKIFFU=;
        b=EMc0SkIwX3CsWxHP+aC/Wm7Evj4NeaiQz/YR606uPmwMgfaM9QWcYWtnuYWa2e409L
         uYeIVdoH7Y6HAGbfKwVpXZZsdBRdo5+GbNc33ZE6hJqxabsLizZgUSjKYCCwFnzrbiF2
         MQ1XMg37jOyDxJ0SXWDrExTMZb6RdAYJYktbvijXTWYrpY3ZYrUn9TQELAx3Bi0I2Uy+
         3rvmaTfwPAjUK1AXi4/0kja/HwnwsUJpHavH7HRGSdhUF0Y+mLRiK6CbtAQlfJwzfm6u
         2pJCdzJHbvKQZFR1Oh/0OWPZhq8WhgM6ldVtw21UAhiEtklQzJie5v1jzXJFFnftp22R
         QwnA==
X-Gm-Message-State: AC+VfDx81B2TxGYYR2TTXzBikuQxZmOF7w3sW6OBB8mx3RZsdxc/PBuH
        QJiA12BjEVmuYQTvVRC36pufcLFfXuM=
X-Google-Smtp-Source: ACHHUZ6BRxs/pXjmvDXY/Ix/M6PsYGHPtG5nSO4nq825Yv/jpYmkLikZjzLYUPDhzmiNY3syp+zKHg==
X-Received: by 2002:a17:907:9349:b0:973:e4c2:2bcd with SMTP id bv9-20020a170907934900b00973e4c22bcdmr1042732ejc.18.1686300296517;
        Fri, 09 Jun 2023 01:44:56 -0700 (PDT)
Received: from shift.daheim (pd9e2959c.dip0.t-ipconnect.de. [217.226.149.156])
        by smtp.gmail.com with ESMTPSA id jw19-20020a17090776b300b00973fac6065esm974199ejc.223.2023.06.09.01.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 01:44:56 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.96)
        (envelope-from <chuck@shift.daheim>)
        id 1q7Xjr-0004fR-1N;
        Fri, 09 Jun 2023 10:44:55 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org
Cc:     kvalo@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: [PATCH v1 2/2] wifi: ath11k: add support DT ieee80211-freq-limit
Date:   Fri,  9 Jun 2023 10:44:55 +0200
Message-Id: <a57a3e1e23b5ac4a18d772e3b82527498ac85bb5.1686300243.git.chunkeey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a3075482150d342f71ec235badacec32cdd6c553.1686300243.git.chunkeey@gmail.com>
References: <a3075482150d342f71ec235badacec32cdd6c553.1686300243.git.chunkeey@gmail.com>
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

The common DT property can be used to limit the available
channels/frequencies. But ath11k has to manually call
wiphy_read_of_freq_limits().

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
compile-tested only.
---
 drivers/net/wireless/ath/ath11k/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c947d1c8d8c1..7e43f2770f27 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9414,6 +9414,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	if (ret)
 		goto err;
 
+	wiphy_read_of_freq_limits(ar->hw->wiphy);
 	ath11k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
 	ath11k_mac_setup_he_cap(ar, cap);
 
-- 
2.40.1

