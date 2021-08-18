Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866A93EFB73
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 08:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbhHRGNR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 02:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbhHRGMB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 02:12:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C7DC0698E2
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:06:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q2so1141373pgt.6
        for <linux-wireless@vger.kernel.org>; Tue, 17 Aug 2021 23:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=foQDo7WpLo2j2V/z+FSCXpsN+DWjHtp9JYSgEaJMB90=;
        b=GKSzM0IlJzJUf6lZnhXWBc3es8Ghf2l0pYhAqJGw0m0Etoh9R9ZMUtcr7TQfx5XH16
         yUU50MfeHmQfTuW7Ip6OieaI0/v3E9dPT9SLJqUTpqoqf9QRyyt07A/6SF5rzbn7F+nJ
         +/lFdCNLXnONV1jAas5Ljfn8bo+d3tCRsQ77A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foQDo7WpLo2j2V/z+FSCXpsN+DWjHtp9JYSgEaJMB90=;
        b=aTe0ECzLAJsEnteIv4NtuXr2bHvKtwanjsN47wyIllbQB1pZ78rW9sQPwwE7JWkqkI
         v3EMUImWaUzrbJfTxumJtiLoLPaAjYnFKK8j+K+LYFHfN1Rw4JbWm9R43P3XN6UkLfH+
         1DxyKTCqi1EBNLftTGbbxrC+1swPfEQpV7/QIK3RnaJ/nKIKsAWv+Jiin880YDQxOVY0
         PWhmiV8lO69U3Fopz4+YIgYypfDjUfAGdFvzRJOOwJ2od0hjD7LCiZCKQTXz0yScvOfA
         hXsi4PjYhfHzO9vO6K7JEt286IGCgsjNdI4Hb3l+RT6ut5R5ZFow/ann9iig9t689rHW
         qX4w==
X-Gm-Message-State: AOAM530CVxkXVMhLi9Q15P+8qb9BtbticMOYmPeb+alU9Xqz2dIzniqf
        MRoYkG68dkOcd9S0IfN06jy0ZA==
X-Google-Smtp-Source: ABdhPJyaW6PaSoHolvdHHHrfwFOitgtk5zymjMduPV9RR03aWMu9nIrmKtLLFhURS2RiRyMqgOc9Ww==
X-Received: by 2002:a63:5c8:: with SMTP id 191mr7451505pgf.293.1629266765131;
        Tue, 17 Aug 2021 23:06:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18sm5548805pgk.24.2021.08.17.23.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:06:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 59/63] can: flexcan: Use struct_group() to zero struct flexcan_regs regions
Date:   Tue, 17 Aug 2021 23:05:29 -0700
Message-Id: <20210818060533.3569517-60-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5011; h=from:subject; bh=8Ts9umslvw0EuXRaphSdWSysW0LFYybLoYrceMcY2J8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMrtWREAe+sayvsZiZZ8f8J5sqHhCBlNW7evqOS y4cIMiCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjKwAKCRCJcvTf3G3AJl2pD/ 95zMtNfq1UN3l8y/gyN1appJq7NzWCP9Ku5k1Ba1Voq8jwjYkgywPDqqLvBA6qhUCGs+OtkOFRJm9r 2WBM2tr0yTR7/Huu8tg3Y9QEDaf1r85ita3zR+Lo8bHAVhDGXrm0QLkXcE5kvRTliHDwuyH5NQdbeI y8MSusibpB/OZKb1O2tTsxmhqrhbyjP6XdzghSiU7T4QDxkGxZwJgsAc7vPRqbHk7VQ4C8W2dPyt0e NE2ZrJYx0O61gXhgePrJkWBiMMPSajK74LMAZnW+05D56fMzPxqiMjtL0p/si6OhxhglP8w/YyyfB4 hnLWCd7r/bixExnxdKaJIIssbZtUDNaR6qxxa++crImbOrfTcB2xJkZxZo5FCuWwXjSeFm5seZ8DSF VqrYUY1JAcu3VBvPK178Bzrnv1RgFdvpt4I+zejm4UhAQh4kmjNR1TG43rdFl+h9uzkvW74E7N8ulI x2uluahMtzsRiCPNN78mfMrihT6ffb7zDUoByobpe2156Mnrn0LmOGmBizoXBiY8TaXTRKSEavjrKQ EjTgqkUCcUBJwrofQz5SF6k1zmaygNghMfj+owZdXn8OFWlfbX7KbDZmtfReV8lng9nDI4GeN25VRY 8eq9GEvLK3a8NRy4xCnvyxCK9Lloiounz6j68lZ9p5uyRuvWXtQFVzzhEMKw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Add struct_group() to mark both regions of struct flexcan_regs that get
initialized to zero. Avoid the future warnings:

In function 'fortify_memset_chk',
    inlined from 'memset_io' at ./include/asm-generic/io.h:1169:2,
    inlined from 'flexcan_ram_init' at drivers/net/can/flexcan.c:1403:2:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field(p_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function 'fortify_memset_chk',
    inlined from 'memset_io' at ./include/asm-generic/io.h:1169:2,
    inlined from 'flexcan_ram_init' at drivers/net/can/flexcan.c:1408:3:
./include/linux/fortify-string.h:199:4: warning: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribute-warning]
  199 |    __write_overflow_field(p_size_field, size);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/can/flexcan.c | 68 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 7734229aa078..12b60ad95b02 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -290,31 +290,33 @@ struct flexcan_regs {
 	u32 dbg1;		/* 0x58 */
 	u32 dbg2;		/* 0x5c */
 	u32 _reserved3[8];	/* 0x60 */
-	u8 mb[2][512];		/* 0x80 - Not affected by Soft Reset */
-	/* FIFO-mode:
-	 *			MB
-	 * 0x080...0x08f	0	RX message buffer
-	 * 0x090...0x0df	1-5	reserved
-	 * 0x0e0...0x0ff	6-7	8 entry ID table
-	 *				(mx25, mx28, mx35, mx53)
-	 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
-	 *				size conf'ed via ctrl2::RFFN
-	 *				(mx6, vf610)
-	 */
-	u32 _reserved4[256];	/* 0x480 */
-	u32 rximr[64];		/* 0x880 - Not affected by Soft Reset */
-	u32 _reserved5[24];	/* 0x980 */
-	u32 gfwr_mx6;		/* 0x9e0 - MX6 */
-	u32 _reserved6[39];	/* 0x9e4 */
-	u32 _rxfir[6];		/* 0xa80 */
-	u32 _reserved8[2];	/* 0xa98 */
-	u32 _rxmgmask;		/* 0xaa0 */
-	u32 _rxfgmask;		/* 0xaa4 */
-	u32 _rx14mask;		/* 0xaa8 */
-	u32 _rx15mask;		/* 0xaac */
-	u32 tx_smb[4];		/* 0xab0 */
-	u32 rx_smb0[4];		/* 0xac0 */
-	u32 rx_smb1[4];		/* 0xad0 */
+	struct_group(init,
+		u8 mb[2][512];		/* 0x80 - Not affected by Soft Reset */
+		/* FIFO-mode:
+		 *			MB
+		 * 0x080...0x08f	0	RX message buffer
+		 * 0x090...0x0df	1-5	reserved
+		 * 0x0e0...0x0ff	6-7	8 entry ID table
+		 *				(mx25, mx28, mx35, mx53)
+		 * 0x0e0...0x2df	6-7..37	8..128 entry ID table
+		 *				size conf'ed via ctrl2::RFFN
+		 *				(mx6, vf610)
+		 */
+		u32 _reserved4[256];	/* 0x480 */
+		u32 rximr[64];		/* 0x880 - Not affected by Soft Reset */
+		u32 _reserved5[24];	/* 0x980 */
+		u32 gfwr_mx6;		/* 0x9e0 - MX6 */
+		u32 _reserved6[39];	/* 0x9e4 */
+		u32 _rxfir[6];		/* 0xa80 */
+		u32 _reserved8[2];	/* 0xa98 */
+		u32 _rxmgmask;		/* 0xaa0 */
+		u32 _rxfgmask;		/* 0xaa4 */
+		u32 _rx14mask;		/* 0xaa8 */
+		u32 _rx15mask;		/* 0xaac */
+		u32 tx_smb[4];		/* 0xab0 */
+		u32 rx_smb0[4];		/* 0xac0 */
+		u32 rx_smb1[4];		/* 0xad0 */
+	);
 	u32 mecr;		/* 0xae0 */
 	u32 erriar;		/* 0xae4 */
 	u32 erridpr;		/* 0xae8 */
@@ -328,9 +330,11 @@ struct flexcan_regs {
 	u32 fdcbt;		/* 0xc04 - Not affected by Soft Reset */
 	u32 fdcrc;		/* 0xc08 */
 	u32 _reserved9[199];	/* 0xc0c */
-	u32 tx_smb_fd[18];	/* 0xf28 */
-	u32 rx_smb0_fd[18];	/* 0xf70 */
-	u32 rx_smb1_fd[18];	/* 0xfb8 */
+	struct_group(init_fd,
+		u32 tx_smb_fd[18];	/* 0xf28 */
+		u32 rx_smb0_fd[18];	/* 0xf70 */
+		u32 rx_smb1_fd[18];	/* 0xfb8 */
+	);
 };
 
 static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
@@ -1400,14 +1404,10 @@ static void flexcan_ram_init(struct net_device *dev)
 	reg_ctrl2 |= FLEXCAN_CTRL2_WRMFRZ;
 	priv->write(reg_ctrl2, &regs->ctrl2);
 
-	memset_io(&regs->mb[0][0], 0,
-		  offsetof(struct flexcan_regs, rx_smb1[3]) -
-		  offsetof(struct flexcan_regs, mb[0][0]) + 0x4);
+	memset_io(&regs->init, 0, sizeof(regs->init));
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
-		memset_io(&regs->tx_smb_fd[0], 0,
-			  offsetof(struct flexcan_regs, rx_smb1_fd[17]) -
-			  offsetof(struct flexcan_regs, tx_smb_fd[0]) + 0x4);
+		memset_io(&regs->init_fd, 0, sizeof(regs->init_fd));
 
 	reg_ctrl2 &= ~FLEXCAN_CTRL2_WRMFRZ;
 	priv->write(reg_ctrl2, &regs->ctrl2);
-- 
2.30.2

