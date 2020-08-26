Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86069252A41
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Aug 2020 11:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgHZJgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Aug 2020 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgHZJfL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Aug 2020 05:35:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC185C06135A
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r15so1072938wrp.13
        for <linux-wireless@vger.kernel.org>; Wed, 26 Aug 2020 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOk7+v5tRA8kQkojRiep+oFsY19pnrxzjDBrN8NxzU0=;
        b=oROYULirz7RycKlFmz17ODwkIRUf3Ag8qwgHItHR6BX/j/SEk6NQew0g/BRgEMzKRt
         tt5Jo4BYLTEgPjhR8lr8ljhURcObcNyebw4VhcIRTD8tNDzT+tN9XWFK/g1IEDDze0lo
         cVcmlCZWZ3+6bIsZPPUPS6/6TB7U+uwepRDGIDC6wHM5H0TXN7N+u6megW0Hfk/fhUh9
         7ay25LPBDBt4KObWLrnNxDdAtrhYcz0n+4RItNhX+gnxbxzecxQt4SWzH3BOKu5ViVg0
         KQqLjd3R2nlk95hbvc6xpBfj9zdeQaaNiOxwWcq04YmdmBtGeOwgHTAtW9TERdqwx4W4
         y2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOk7+v5tRA8kQkojRiep+oFsY19pnrxzjDBrN8NxzU0=;
        b=AdNIgkOke06gm2gdnkXVHIo8gvjW3Jx7/BjfRqFAzPDY7i9pMIprR4lWNdVDVtkZFC
         4eus9y8MsNuWuuJYxEk8kRpNu29VhWdoIQEIeTM9hg4/1OOkX508Gp7WgH8RoASC4Gnf
         IXgfiWvKz4fxkrfwC+H9P/HdaqvSxmmCH77JZYalh47oq3O+bXevdLEkH1bJV/9RMHA2
         cQapHrNQa2bOKW9ip5O6WRTuyimDAC9a7cpVqIqplZ5iKJyN0imSOSIhYMUUt0Bvoo4Z
         Q2/qN0/aiEyGgy9K6DqgoaDeYHQtAZ1+QaM9GgHNJOE+rimkjVS8q9Ryq8Nm112u0QXt
         hAXg==
X-Gm-Message-State: AOAM531lQ2CPJ5AzNPTkkXXiFSmytctvgjrtRozK+k5weOGhMRwCO+V7
        aRYC7dYG4L/Sa+telDzsD8zEtg==
X-Google-Smtp-Source: ABdhPJycFcwRj1JjehKwx0tcqJuFWgg2Bt6DGFQBYF0/uRC61ugktaO9SXdUglT0sloncVXp09skjQ==
X-Received: by 2002:adf:fe90:: with SMTP id l16mr15018301wrr.345.1598434474431;
        Wed, 26 Aug 2020 02:34:34 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>
Subject: [PATCH 24/30] wireless: marvell: mwifiex: wmm: Mark 'mwifiex_1d_to_wmm_queue' as __maybe_unused
Date:   Wed, 26 Aug 2020 10:33:55 +0100
Message-Id: <20200826093401.1458456-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

'mwifiex_1d_to_wmm_queue' is used in'; main.c, txrx.c and uap_txrx.c

... but not used in 14 other source files which include 'wmm.h'.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/net/wireless/marvell/mwifiex/init.c:25:
 drivers/net/wireless/marvell/mwifiex/wmm.h:34:18: warning: ‘mwifiex_1d_to_wmm_queue’ defined but not used [-Wunused-const-variable=]
 34 | static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 | ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/marvell/mwifiex/cmdevt.c:26:
 drivers/net/wireless/marvell/mwifiex/wmm.h:34:18: warning: ‘mwifiex_1d_to_wmm_queue’ defined but not used [-Wunused-const-variable=]
 34 | static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 | ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/marvell/mwifiex/util.c:25:
 drivers/net/wireless/marvell/mwifiex/wmm.h:34:18: warning: ‘mwifiex_1d_to_wmm_queue’ defined but not used [-Wunused-const-variable=]
 34 | static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 | ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/marvell/mwifiex/wmm.c:25:
 drivers/net/wireless/marvell/mwifiex/wmm.h:34:18: warning: ‘mwifiex_1d_to_wmm_queue’ defined but not used [-Wunused-const-variable=]
 34 | static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 | ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/marvell/mwifiex/11n.c:25:
 drivers/net/wireless/marvell/mwifiex/wmm.h:34:18: warning: ‘mwifiex_1d_to_wmm_queue’ defined but not used [-Wunused-const-variable=]
 34 | static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 | ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/marvell/mwifiex/11n_aggr.c:25:
 drivers/net/wireless/marvell/mwifiex/wmm.h:34:18: warning: ‘mwifiex_1d_to_wmm_queue’ defined but not used [-Wunused-const-variable=]
 34 | static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 | ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:25:
 drivers/net/wireless/marvell/mwifiex/wmm.h:34:18: warning: ‘mwifiex_1d_to_wmm_queue’ defined but not used [-Wunused-const-variable=]
 34 | static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 | ^~~~~~~~~~~~~~~~~~~~~~~
 In file included from drivers/net/wireless/marvell/mwifiex/11n.h:25,
 from drivers/net/wireless/marvell/mwifiex/scan.c:25:
 drivers/net/wireless/marvell/mwifiex/wmm.h:34:18: warning: ‘mwifiex_1d_to_wmm_queue’ defined but not used [-Wunused-const-variable=]
 34 | static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 | ^~~~~~~~~~~~~~~~~~~~~~~

 NB: Many entries - snipped for brevity.

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc: Xinming Hu <huxinming820@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/marvell/mwifiex/wmm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.h b/drivers/net/wireless/marvell/mwifiex/wmm.h
index 60bdbb82277a3..58bcd84b050c5 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.h
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.h
@@ -31,7 +31,8 @@ enum ieee_types_wmm_ecw_bitmasks {
 	MWIFIEX_ECW_MAX = (BIT(4) | BIT(5) | BIT(6) | BIT(7)),
 };
 
-static const u16 mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
+static const u16 __maybe_unused
+mwifiex_1d_to_wmm_queue[8] = { 1, 0, 0, 1, 2, 2, 3, 3 };
 
 /*
  * This function retrieves the TID of the given RA list.
-- 
2.25.1

