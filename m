Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8247CCEEB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Oct 2023 23:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjJQVMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Oct 2023 17:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjJQVMe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Oct 2023 17:12:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526D9F
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 14:12:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso94019357b3.0
        for <linux-wireless@vger.kernel.org>; Tue, 17 Oct 2023 14:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697577150; x=1698181950; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QXzsHVghZ/vMgKxfKM1dzjkgTQebO8rvy+/S6SScf3k=;
        b=R8PcU1W/5S6bkm52VpK5VdZMnRhqeBQROS+TV0xwjTr3e5M8njGi0/o/xDNUgFSb7f
         tCbuWaUyV1DcwjlSSEX4Td/o7Z6dIJFzoN0EFoAD3EsjH9mFR/ZIbQAWZWBgTub09g64
         uBFlugYflg80KZjjhQz1p6Fa3WsFRaZJio8kUums336YvMxizo9Lv6gltosa/ZO/JLaI
         1sIVidDOS/jisgt2f5VUqDg+OOPVgrS18BvURi/zCx2MKNvWu9HwNFrtQmvUFkbNhoGi
         h/9KG9c4Nb7oD96XogqxK8WmyQAbBue/Q6yvvbxKaZlJUwzYRs9QUOaUycYrfTp7K3FR
         Skog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577150; x=1698181950;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXzsHVghZ/vMgKxfKM1dzjkgTQebO8rvy+/S6SScf3k=;
        b=ai4d4fWUg+JTKRGCGqGlc7v4yfDFXZ98hw3NCHteC7PJqNeLT9q629yDyCGikMrO+d
         SZ105gUSRVV3jP+Pitb9ialFRSHbh960QCn6iAmqeeGz6HUSkhAoyuK57UfdH/FXHe+N
         aGWb9Pk7YCKE1W+eqPYvUcACdpaGtxNo5pFu6BaiJ64g4PzPedFNLtKDdAMegCkiu8sP
         u20XJtSmv0DbIdv4bKnqEAsrYLD8ytXtrzG0QRDLum3YWle3m9GhzOTyF3eTu415WGn2
         qwpmNHInwnxB1O1O9qdQu3jAGlyHZpoa06BJmcEL3u7ug1ikXOtjR5QTj/FiYO1jDcE7
         Ek8g==
X-Gm-Message-State: AOJu0YwTXXMtpwQG+jv6Ytnc+8ta2mUTuzcfq5DL6rQuwUwEqXKSZgFZ
        RHVeOq2v8gKGW6Y+2n7cB4LDRjhhSx9us6RqDg==
X-Google-Smtp-Source: AGHT+IGJblzoOljLjk6/ecy438CFYmQUmdxFbWvGK70QvUdqQeqXtoTHla4D+YArJvsCrt0odJIX6Hsm57+fTpL7rA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:b118:0:b0:d9a:6b49:433d with SMTP
 id g24-20020a25b118000000b00d9a6b49433dmr61099ybj.6.1697577150758; Tue, 17
 Oct 2023 14:12:30 -0700 (PDT)
Date:   Tue, 17 Oct 2023 21:12:30 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAL34LmUC/x3NQQrCQAxG4auUrA1kKip6FXExZH41IDMlKVUpv
 buDy2/z3koBNwRdhpUci4W12pF2A+kz1wfYSjeNMu6TpBPH7FWnLxe3BR5cMfPbHC9EsFpo42z eWLnIWYscRPIR1HuT426f/+t627YfhUfv7HsAAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697577149; l=2545;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=iByoXcEl+/fTj7qfxJpQSjCOu1SG80zw46SDN1JdAVA=; b=422phc1KfoxKuZOVw01uw/lgnVEOwbLB9bZNBj3xD+nmrWlmWo1VFxb4TdilgcB/yQ/FizVWk
 oopegqE63ZDB+soiysSjOYI6D+ByXbd4dx2ld1FM64ecTwR85Ll2K55
X-Mailer: b4 0.12.3
Message-ID: <20231017-strncpy-drivers-net-wireless-cisco-airo-c-v1-1-e34d5b3b7e37@google.com>
Subject: [PATCH] airo: replace deprecated strncpy with strscpy_pad
From:   Justin Stitt <justinstitt@google.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

`extra` is clearly supposed to be NUL-terminated which is evident by the
manual NUL-byte assignment as well as its immediate usage with strlen().

Moreover, let's NUL-pad since there is deliberate effort (48 instances)
made elsewhere to zero-out buffers in these getters and setters:
6050 | memset(local->config.nodeName, 0, sizeof(local->config.nodeName));
6130 | memset(local->config.rates, 0, 8);
6139 | memset(local->config.rates, 0, 8);
6414 | memset(key.key, 0, MAX_KEY_SIZE);
6497 | memset(extra, 0, 16);
(to be clear, strncpy also NUL-padded -- we are matching that behavior)

Considering the above, a suitable replacement is `strscpy_pad` due to
the fact that it guarantees both NUL-termination and NUL-padding on the
destination buffer.

Technically, we can now copy one less byte into `extra` as we cannot
determine the sizeof `extra` at compile time and the hard-coded value of
16 means that strscpy_pad() will automatically truncate and set the byte
at offset 15 to NUL. However, the current code manually sets a
NUL-byte at offset 16. If this is an issue, the solution is to change
the hard-coded magic number to 17 instead of 16. I didn't do this in
this patch because a hard-coded 17 seems bad (even more so than 16).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 drivers/net/wireless/cisco/airo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index dbd13f7aa3e6..8cfb1de5933e 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6067,8 +6067,7 @@ static int airo_get_nick(struct net_device *dev,
 	struct airo_info *local = dev->ml_priv;
 
 	readConfigRid(local, 1);
-	strncpy(extra, local->config.nodeName, 16);
-	extra[16] = '\0';
+	strscpy_pad(extra, local->config.nodeName, 16);
 	dwrq->length = strlen(extra);
 
 	return 0;

---
base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
change-id: 20231017-strncpy-drivers-net-wireless-cisco-airo-c-d09cd0500a6e

Best regards,
--
Justin Stitt <justinstitt@google.com>

