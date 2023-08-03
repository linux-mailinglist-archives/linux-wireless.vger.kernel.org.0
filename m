Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AAA76DFB5
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 07:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjHCFXN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 01:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjHCFXG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 01:23:06 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D5630FA
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 22:23:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bbc06f830aso4204635ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Aug 2023 22:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691040185; x=1691644985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXIhTH4M1QfnWESXrTrS5OHE7UjCglH9VtTwSN6zscc=;
        b=HwxzMl+wA0Bf2wi/690ta495YBBxXP0GhF0h7xQk2w4Lm/di2l8qg/0xFduo3i7aSQ
         PUPEaIXjoJcfQBlFcG38RMMuxqxIVW5DiCb2Ka+QW7XQzPdI/bsHRYwsOtEgJd0Qh8Nm
         s362XGFzp37IeLafMfH+C5rAXhN75wdDEsZMkNV4dI2QOErMFDYx2b/t8CJoj+f3NEkZ
         BIV3sDtu9ApoeAy92QkEDbQEpwORcfLpx8E/GREnYj8LbbmKjKL8BCCd5eqA73N1gD2K
         K/PrgjGFKw7wZEsHDJwzq+KIJsf3l136C5GheKJ8Po0Huddn9ZF4LurtMZzpSnYysQuO
         xboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691040185; x=1691644985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXIhTH4M1QfnWESXrTrS5OHE7UjCglH9VtTwSN6zscc=;
        b=LqwCVS4jhUKwmmJN+dCsk0/hWrR6rkZqaGu0AY2WW+VOUcuExrrwRepLQxZqXUKcVL
         C4iB7K8Am+htHd+Ki+sKpwjhO/YJg5XzBUp2jtiIP8EcEMxODLkrCm8uGPcc6hDCV+Jq
         3kuC6CalQDRTwKmMmLQEfedLZP+N6ECDAPBWQt73EG7OqseEarxYANYIVY3vugu2o17f
         VbaZNOJl5bjIh16dpTjNsU9Ka9HQf15TXEYP24Qti7PXtzpZAVqgvfIJodYrVkjIDQRd
         WOGqczD98Xk/QtqoBOkfcAwARtSaeT10Nyl6N+ifSifSNhihr7wz1W6hfW8HnD2ZqUQ2
         Semg==
X-Gm-Message-State: ABy/qLZToU4rVzihp/8/u4mG04hqMekvNOHC0FH9VnJNDRDAN6KE7f5O
        PyPS0vDHFcl5jIULBoGUWMA=
X-Google-Smtp-Source: APBJJlF9wm1yurI+g7oDgrt2/7/NvEcy+amzXkCKdfxcvUNFZ+Nwr2JBHOU62pHe3mu+3hp+VK/xJg==
X-Received: by 2002:a17:903:11c9:b0:1b9:d38d:f08d with SMTP id q9-20020a17090311c900b001b9d38df08dmr21977880plh.18.1691040185185;
        Wed, 02 Aug 2023 22:23:05 -0700 (PDT)
Received: from rajgad.hsd1.ca.comcast.net ([2601:204:df00:9cd0:c7db:43fb:24e4:2bcf])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902bf4900b001bb988ac243sm13266685pls.297.2023.08.02.22.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 22:23:04 -0700 (PDT)
From:   Atul Raut <rauji.raut@gmail.com>
To:     aspriel@gmail.com
Cc:     franky.lin@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] brcmfmac: replace one-element array with flexible-array member
Date:   Wed,  2 Aug 2023 22:22:38 -0700
Message-Id: <20230803052238.12147-2-rauji.raut@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803052238.12147-1-rauji.raut@gmail.com>
References: <20230803052238.12147-1-rauji.raut@gmail.com>
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

One-element arrays are obsolete, and flexible
array members have taken their place. So, in
struct cca_stats_n_flags, replace the one-element
array with a flexible-array member.

This fixes warnings such as:
./drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:119:6-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index de8a2e27f49c..fff32e54833d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -116,7 +116,7 @@ struct brcmf_dump_survey {
 struct cca_stats_n_flags {
 	u32 msrmnt_time; /* Time for Measurement (msec) */
 	u32 msrmnt_done; /* flag set when measurement complete */
-	char buf[1];
+	char buf[];
 };
 
 struct cca_msrmnt_query {
-- 
2.34.1

