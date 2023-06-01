Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D96719080
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 04:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjFACY1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 22:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjFACY0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 22:24:26 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82448B3
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 19:24:25 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-392116ae103so102663b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 19:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685586264; x=1688178264;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rSoXdTlMKfGR+FOKX8kq+k3BGQpNpTpshl5CEMy3Kdc=;
        b=SyRnPrSf896jnKvY/OWcihCwRxxJ89qew6SIs4T02KO4/t+8U68mw1aB6Otaj60kzl
         Fj1Fny2v9y1+f0vonIfmAsFwlGHW1MUQPouoi/c08DD6IxRDznye+rzDcWeRnbHwCxCg
         OIXCVrd3IOvykAaAhH3OuVvphhgoWNkLMMPPC1B/YeBeKfNC2THO1oMww67vJEjrkMqv
         Q0R9v97HoXtYdUYG7MwRVhPQBf7RnZoC6JRcgF/9U4b/+5dNFi4etfwej08RDRpNm4qU
         5T4ZLj22ZXVQrhomKbPrqF5Now5Y6iTalVO8rmIDN6J/8wRGBCEEArNP1ffdURia+M3I
         r7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685586264; x=1688178264;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rSoXdTlMKfGR+FOKX8kq+k3BGQpNpTpshl5CEMy3Kdc=;
        b=Xhv87NsDYwA1gvt/s0QoOccJKsBTeUADaRNWsavPZid1MCeFVy748HHnqS2/vLfalW
         egJa/SoTSIy3gQW5qDHWVsU2LFcJiRIZQUYTFK3VUHeyiKy/HUyieF3a++H2ScZK6ZeD
         1HhJhNRxdI4zXTHz8vmOTiFy7+lT9GNDdfCSyGtaSMcyHyS0bLkfn9eai6loi+UTz8ZS
         hCPhwsH/1SJUgeEsehS3fXe3V6Bz96T8sSfFFf5frhmP8UXtmCf64m5rFWykj5bXK2YK
         8ZaRzcfE/w2+H4v/VIShiPZbIWPc1DgVg6nklGJkq6+Sjuvimd7Svw1y4ZmKpd8QVrkT
         YDjQ==
X-Gm-Message-State: AC+VfDymQYpFyJtkQaqvVZWXH8Xj0ZtcWnWfcOlTabiYMMujVl2PdBZp
        yV75gxI3rvx9QCB8k6+RzXtIYIwx2JbWPAveO0sj4meiI/k=
X-Google-Smtp-Source: ACHHUZ5tJFD0Er81n59FfNbjQq6KPsRkUulyLkeHr2xnagVopX+StYblH+36TL71HvRjm3V64QZmGG/LNCoCXrufVhY=
X-Received: by 2002:a05:6808:1898:b0:398:29ed:f609 with SMTP id
 bi24-20020a056808189800b0039829edf609mr4998518oib.1.1685586264446; Wed, 31
 May 2023 19:24:24 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Sidhwaney <nealsid@gmail.com>
Date:   Wed, 31 May 2023 22:23:48 -0400
Message-ID: <CAJ4cxaQiYWEOmf9sZHsvXqYc_SKSg2dm5jQvifa82+o+W41aNw@mail.gmail.com>
Subject: [PATCH] wifi: brcmfmac: Detect corner error case earlier with log
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In some corner cases, an I/O read can fail and return -1, and this
patch detects this slightly earlier than is done today and logs an
appropriate message.

Signed-off-by: Neal Sidhwaney <nealsid@gmail.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
index 9f9bf08a70bb..9b38c6f2f37f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
@@ -972,6 +972,7 @@ static int brcmf_chip_recognition(struct
brcmf_chip_priv *ci)
  u32 regdata;
  u32 socitype;
  int ret;
+ u32 READ_FAILED = 0xFFFFFFFF;

  /* Get CC core rev
  * Chipid is assume to be at offset 0 from SI_ENUM_BASE
@@ -980,6 +981,11 @@ static int brcmf_chip_recognition(struct
brcmf_chip_priv *ci)
  */
  regdata = ci->ops->read32(ci->ctx,
   CORE_CC_REG(ci->pub.enum_base, chipid));
+ if (regdata == READ_FAILED) {
+  brcmf_err("MMIO read failed: 0x%08x\n", regdata);
+  return -ENODEV;
+ }
+
  ci->pub.chip = regdata & CID_ID_MASK;
  ci->pub.chiprev = (regdata & CID_REV_MASK) >> CID_REV_SHIFT;
  socitype = (regdata & CID_TYPE_MASK) >> CID_TYPE_SHIFT;
--
2.40.1
