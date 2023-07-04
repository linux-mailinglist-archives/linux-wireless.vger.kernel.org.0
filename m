Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B809A747A8B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jul 2023 01:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGDXwD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jul 2023 19:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjGDXwC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jul 2023 19:52:02 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 16:52:02 PDT
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E6B2
        for <linux-wireless@vger.kernel.org>; Tue,  4 Jul 2023 16:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1688514722; x=1720050722;
  h=mime-version:from:date:message-id:subject:to;
  bh=wSdyC5891jJbFmTuKtYjfgMjLQS/fVpwoPNKrqoId3M=;
  b=LQt8CHbz0PTsLv7YQAGQABnaue47u6IDohF+EIslsPf5zWcenvr6sBvq
   sBcq4rXz8SjtsSm/GP4Z6sjaRUXUsQhadM936GxSFHJ2EkNxzip01vnur
   +XZThu57YdAEtVTWg74oiwkKtFdJKwFTRzppnD1nK/vsf2Bau8uJZgPZ1
   qYU04s1fP8U5npSgq7jGlhBUhkO3jKqTUaWsC4g2gj9R/RtyHzG4kJsDX
   l3pnr0LzPHRdBFJgxbVoDDGFiC724jz2prObjp23DVOKDEVnSfR8gQ9tf
   RCAlpCzKkofBqq8sHNa7/ZqF/1TRazAohYD+QvxwE4B4iUIXwGNCHqi0T
   g==;
Received: from mail-wr1-f72.google.com ([209.85.221.72])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2023 16:50:59 -0700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3143c941d0bso889567f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jul 2023 16:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1688514657; x=1691106657;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/mXMcy887qPFqnoPqho388ScuVrFV543nUjedX0tcHQ=;
        b=bzV6Rgax6AZfFeVKbuPFqnvFeBXJEjwMahX2psJdYDuKMlY4Dw92ZLBWN6XXHX1Xq/
         aZdYx5Hluixt0Os3s0kds/ggce1w/hGlbUNWkWecszOUKx3vFI0mcKzME6KbKBA8pnlL
         DOAen/gLefwSU5jiBe7Z+0IxY5DivM2BptD28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688514657; x=1691106657;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/mXMcy887qPFqnoPqho388ScuVrFV543nUjedX0tcHQ=;
        b=YkQ5g9kaDGByhk0dGt7CdD2ZIVgPzxmoDQ8OM1NMHsQ29MA6bggmct5So0wpcORlce
         L7LdL4oiw34DmFhEyW8MqCjizUIqrj239JXrhIQXRH9B96bvA1g24I/DOTHLnBiM4cXw
         QGoMJc2VWr4qL6lRBFPWbKyS655QoW+p5gumDQBreaPyziG+sxMdoFYkzp41oDagtMad
         eAUwCfDGvLJBJrTI35Np9lAtmKmmdFJq/KtWb7BpauTKY9MvoO8e+S27dQKewrO0Hs9r
         rcuuJ/llGUaxYX6k3ja0w9Og0h0PM8pGGsZcrnnx/xzR3UKfR5ZlaG0EY0r8UUSfSlZQ
         U55w==
X-Gm-Message-State: ABy/qLYO5BxRchbYt1NxldtbjZfgniP+g9DrtmD+2UkUWXDALofa7crb
        YvJv3gMSV7r80e9JEbrqLh2x8aZbDs2xBdJN0omSv6ugRPXSk3J1S9fE9sYbaOkOUK2Rv/q9PGD
        W6VOog6MxOpqEDJK3lRA7JXX/1apjajuFEZ2ian49eKXX
X-Received: by 2002:a5d:5148:0:b0:314:3c84:4da2 with SMTP id u8-20020a5d5148000000b003143c844da2mr3793303wrt.13.1688514657473;
        Tue, 04 Jul 2023 16:50:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFopcbRFlM/QXxH3jqxO61w82vcVsCVkdkO//2H4gliBuit9v82WgR6YBumb+o9c6O+3lD56vmkqTBlRIC1K6Y=
X-Received: by 2002:a5d:5148:0:b0:314:3c84:4da2 with SMTP id
 u8-20020a5d5148000000b003143c844da2mr3793298wrt.13.1688514657217; Tue, 04 Jul
 2023 16:50:57 -0700 (PDT)
MIME-Version: 1.0
From:   Yu Hao <yhao016@ucr.edu>
Date:   Tue, 4 Jul 2023 16:50:45 -0700
Message-ID: <CA+UBctBLWF14TsgT4OfanmnxTqbm9mNxyHhjJqpFo7c+kdjDsw@mail.gmail.com>
Subject: [PATCH] net: wireless: cisco: Fix possible uninit bug
To:     kvalo@kernel.org, keescook@chromium.org, gustavoars@kernel.org,
        Jason@zx2c4.com, linux-wireless@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The struct cap_rid should be initialized by function readCapabilityRid.
However, there is not return value check. Iit is possible that
the function readCapabilityRid returns error code and cap_rid.softCap
is not initialized. But there is a read later for this field.

Signed-off-by: Yu Hao <yhao016@ucr.edu>
---
 drivers/net/wireless/cisco/airo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/cisco/airo.c
b/drivers/net/wireless/cisco/airo.c
index 7c4cc5f5e1eb..b3736d76a5d5 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -6950,8 +6950,11 @@ static int airo_get_range(struct net_device *dev,
    CapabilityRid cap_rid;      /* Card capability info */
    int     i;
    int     k;
+   int     status;

-   readCapabilityRid(local, &cap_rid, 1);
+   status = readCapabilityRid(local, &cap_rid, 1);
+   if (status != SUCCESS)
+       return ERROR;

    dwrq->length = sizeof(struct iw_range);
    memset(range, 0, sizeof(*range));
-- 
2.34.1
