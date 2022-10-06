Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277EE5F6E1B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 21:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiJFTVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiJFTU4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 15:20:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93D384E5D
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 12:20:54 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i7-20020a17090a65c700b0020ad9666a86so5267038pjs.0
        for <linux-wireless@vger.kernel.org>; Thu, 06 Oct 2022 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=itZWwPdDaSKLWFxysGkqkMCHBdnDlLrqJO/idiDOslY=;
        b=JUsE59scSIqOd3RSs+2ERXty4+RKlbVH8hzJHnoRRXfbL9fbsY7AedyXrqpEYhBjwT
         PmPPKU5rUEu7JvzYlqV5115l1w/JDWCA42QlLydOFhZtfAF/wuUQ0v7nmCkhWQ3Q8cbr
         ZguKk4CT2DDUv2zNtUDFc5Cn/taJ9NkOhXS4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=itZWwPdDaSKLWFxysGkqkMCHBdnDlLrqJO/idiDOslY=;
        b=unks7xu6nh4kveo75BcF93wIR0XbQvol0IjkI8g/J72p5GNiaCSIWb+LvTDNbkMuoj
         1shV/Sx5XHyCzMx3fDmM+X0OnqzXm3eeHHzfRLv5VSIgVZbJWhsAGCPiCzp7Zub69FZD
         7LBbPHZd5DOnE2uoscrUiNZ9AvPEq6WXuKkcK/nIP0DeOl0TeR+PdrPhZhVsUs7nJ/n2
         OJcvj1dC5M2MpKnUrCMEFqHhfkXLgcumzaQXVavIpu71EfpkqsWw7OXGMjHSLqTvTwr1
         7p1qamhJ4BcGeF8j9gE/2paayG50KTzFIp60//uldJ7WuYu5OsTj9rkUnR4EqBCOaZEW
         EHgw==
X-Gm-Message-State: ACrzQf1KC42TeCXkkwLhuT5YNEBaxfIRASu3vHK/ZNft8/huNnovCIcG
        hkYBfQXeWU8qZ7DkblNuafZ5Zg==
X-Google-Smtp-Source: AMsMyM6LjYgbdTj0/rBODYHzW0d0fCW4va1+F14dDNVJxWwaaXNv95GiVv6m9nbEEczNin00+ZXvWg==
X-Received: by 2002:a17:902:ea06:b0:178:23f7:5a18 with SMTP id s6-20020a170902ea0600b0017823f75a18mr1363172plg.21.1665084054303;
        Thu, 06 Oct 2022 12:20:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b0016d72804664sm12690964plg.205.2022.10.06.12.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:20:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christian Lamparter <chunkeey@googlemail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH] wifi: carl9170: Remove -Warray-bounds exception
Date:   Thu,  6 Oct 2022 12:20:51 -0700
Message-Id: <20221006192051.1742930-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

GCC-12 emits false positive -Warray-bounds warnings with
CONFIG_UBSAN_SHIFT (-fsanitize=shift). This is fixed in GCC 13[1],
and there is top-level Makefile logic to remove -Warray-bounds for
known-bad GCC versions staring with commit f0be87c42cbd ("gcc-12: disable
'-Warray-bounds' universally for now").

Remove the local work-around.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ath/carl9170/Makefile |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/carl9170/Makefile b/drivers/net/wireless/ath/carl9170/Makefile
index 7463baa62fa8..1a81868ce26d 100644
--- a/drivers/net/wireless/ath/carl9170/Makefile
+++ b/drivers/net/wireless/ath/carl9170/Makefile
@@ -3,8 +3,3 @@ carl9170-objs := main.o usb.o cmd.o mac.o phy.o led.o fw.o tx.o rx.o
 carl9170-$(CONFIG_CARL9170_DEBUGFS) += debug.o
 
 obj-$(CONFIG_CARL9170) += carl9170.o
-
-# FIXME: temporarily silence -Warray-bounds on non W=1+ builds
-ifndef KBUILD_EXTRA_WARN
-CFLAGS_cmd.o += -Wno-array-bounds
-endif
-- 
2.34.1


