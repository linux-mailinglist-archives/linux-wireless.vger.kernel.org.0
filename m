Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6216674E64D
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 07:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjGKFXR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 01:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjGKFXQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 01:23:16 -0400
Received: from mx2.ucr.edu (mx2.ucr.edu [138.23.62.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA1012E
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1689052995; x=1720588995;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QWyU+rQMzDLb05pXkZZeTLSin284oMZhWweJMfW0gaY=;
  b=biBcNYoidbc6c8HEqKGo2fXrm1Snl/nBAIMu+7d7ZYHgx/kBY102JgPm
   MJDo3EFZ87sR1NRGvMXXN6NrtQ8bl9sr6Wz8uUUqtaucZyen5fPmjLwgJ
   Jb7yTeSluh6suExHNLXi7PauV6f+Jcvc6T67JxIffNcZfLEPhl4HHNTwy
   TYzsBhFe8dNz9N3y9PShrP2eoN4fJqZY3J/XsRGijF/W7dwBuxrCKRY5O
   az5ck2+/bjPua4EbAKmcLHf/1apIb47TDEqhlVBEi/V9l2WbURsxj81//
   WrLECY3d1hKEKFWL+7fWs4mv+ATd9Jb9YTPh2Uwp+InVqu4FmIdnvbbfK
   Q==;
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2023 22:23:14 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-786f2ff0697so133843839f.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1689052993; x=1691644993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqg7UvHO1vogsyp/LtKhkl2lP5WBKlgMWbM9rdXBjjo=;
        b=rcIHN6HSzv8xTsnDg2XTYIHns8S/NOUBjbpDbF4if0iRlKef7Pvit7zPbPxnCK3WqX
         zh8TxuQBSVwe8zYMzdUc2T27cQK1+0Zsgq6F89tKRGe28yy5X01yuwTSVdC6OV2q9KE0
         +Y0KFC2izKv5WWML3jeH4Tjbvf8s6nGuurxo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689052993; x=1691644993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqg7UvHO1vogsyp/LtKhkl2lP5WBKlgMWbM9rdXBjjo=;
        b=WdUj8rKkHq/RGfS280urASJG6WaqaOYvvSTDrtXLtvvzSg2OnmwNTlDHeySEf3ucwe
         gu7kjMLbw+KaiikApaW2spkwkWTh9TXFKpE1FAp0ZVl+KSsmDEV2dxFm04U6npag0MQ9
         Nn9Wnacvqd3gBrpy90Y4ztycZ+2wwdyGvgKKpcm+NbeYs6e9hOaxYS4LLngUdyftx93W
         Whdbt7L6LuLkoAHvrWBJrFXHFRYjn0tQvvpgc6/jhpxJFEZStVAWzspBmg/UPapYVm5w
         5pD4ykzkKy+w7j5OQa+TviBS45Z2NCIDUstBxNbkaGKeUXKpY7CwBRde7/Z11/svomny
         XLsA==
X-Gm-Message-State: ABy/qLb08MJxg2bMG9V80TXgL8BB9GxLgC2lrA+UJLhsBAeGKcovOSQU
        0W8zgSY31597/WY0iE+ryA+CIYsABLLqmkKb2kDgzVV+HwNZu2djnrQJW3sXcvwFfkUdhgkObyH
        kOSUIPr/lijMFzY0x4FAOSTH9gjPS
X-Received: by 2002:a6b:760f:0:b0:786:26f0:3092 with SMTP id g15-20020a6b760f000000b0078626f03092mr13386668iom.3.1689052993318;
        Mon, 10 Jul 2023 22:23:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGrx6Kz6Gs0LaOT30w9EoY4muW18zkAHNptQE+3CUjBhiLcxLh7TEpn7B09U7qWS5jWcj4d3w==
X-Received: by 2002:a6b:760f:0:b0:786:26f0:3092 with SMTP id g15-20020a6b760f000000b0078626f03092mr13386657iom.3.1689052992971;
        Mon, 10 Jul 2023 22:23:12 -0700 (PDT)
Received: from yuhao-ms.. ([2600:6c51:4700:3f7c:3e6a:a7ff:fe52:5148])
        by smtp.gmail.com with ESMTPSA id k14-20020a6bef0e000000b007870c56387dsm380530ioh.49.2023.07.10.22.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 22:23:12 -0700 (PDT)
From:   Yu Hao <yhao016@ucr.edu>
Cc:     Yu Hao <yhao016@ucr.edu>, Kalle Valo <kvalo@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] net: wireless: cisco: Fix possible uninit bug
Date:   Mon, 10 Jul 2023 22:23:07 -0700
Message-Id: <20230711052310.3294305-1-yhao016@ucr.edu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The struct cap_rid should be initialized by function readCapabilityRid.
However, there is not return value check. Iit is possible that
the function readCapabilityRid returns error code and cap_rid.softCap
is not initialized. But there is a read later for this field.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 drivers/net/wireless/cisco/airo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 7c4cc5f5e1eb..391ac1e9e261 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6950,8 +6950,11 @@ static int airo_get_range(struct net_device *dev,
 	CapabilityRid cap_rid;		/* Card capability info */
 	int		i;
 	int		k;
+	int		status;
 
-	readCapabilityRid(local, &cap_rid, 1);
+	status = readCapabilityRid(local, &cap_rid, 1);
+	if (status != SUCCESS)
+		return -EINVAL;
 
 	dwrq->length = sizeof(struct iw_range);
 	memset(range, 0, sizeof(*range));
-- 
2.34.1

