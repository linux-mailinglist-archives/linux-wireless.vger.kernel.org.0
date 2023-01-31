Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04405682CF9
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 13:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjAaMt0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 07:49:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjAaMtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 07:49:24 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7356C16321
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 04:49:21 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id e2so2870664iot.11
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 04:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4IvuXJwVICWBcwlud5vZAuUcWP9KhMspPCpkjTpsyS4=;
        b=NuupiDQWOFqogwPeBdUZIVadecNGSE1gYLOTPNHkrLcwY78iVCDq5DxYOJhcwoFrRH
         Lt1YYqRHiatPYxL0dISGjE31fJ0k8RH85UTW3dwrp5gXXnCS4c8EeIRVSZ6Q3+aVIiTh
         5piKj8kohfywKDP4HAOVWXGLwcDo346ct5YJpg/VkAiODyTzMLcoqsHYG+TB6lo0Qp9m
         wV7Bagl0Dtfc1fV7snB9kenWU/BehTk/ukJ6QvsTjN5zlnHbUeRI6WZIKio0qS9zdlFf
         F/ths3s3Uxe41wD6c2LAs/yYeSz/NCA542Nhisuh8BqQmpRCkmBYrZlldz/A5dJmTyKA
         Vzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IvuXJwVICWBcwlud5vZAuUcWP9KhMspPCpkjTpsyS4=;
        b=v/1YrtU+RZTgqNKRWuR+fT2JJdNVvYn+UTRzOsbntpdT3wvIUdxWLVn7rlBTwZpu4Y
         RfaEHdT5pxkc+zjKo1sljA+SR8E341KFVQEiFfgVAZmKJPzrtxqNw6TWYtBFWAQnhcEH
         +B/rN7fpVX6EZWcrXulSIs7cAHLUSxGIfdA98MZCMcBmGdKV3tlyt/mDa2D1ni7bIlJB
         s0gIjuoa+75U/ovPgtKj3m9ass+iGr2Q3SK/NJyPQnmco1L70k75c99mhJ68f66PebmB
         hCVFWPummSVVy7IbCTvVipkVD8ZYVTtpdCKnfakA1+weKPJ4QPa8VL5AEwaN6GtVmJxg
         4vtg==
X-Gm-Message-State: AFqh2kpTuZpRda9rO14rYpQKhyvnW1BXYPdnYQYVW9EHRIt5whJj+Hfz
        tCfXW4MRYNDF7TBIUIYcaUCEygooyW6GakpHm+MtKk+neQQ=
X-Google-Smtp-Source: AMrXdXsxyTQG+WnT09B2IcM/SSASM0w8LHI+STv2UeIaeRqQhR80vgLAMcUfKl6L0+1rM7QPMDO5ukztngyznUyqw8M=
X-Received: by 2002:a05:6638:ed7:b0:388:9ab3:1cd5 with SMTP id
 q23-20020a0566380ed700b003889ab31cd5mr7966279jas.64.1675169360827; Tue, 31
 Jan 2023 04:49:20 -0800 (PST)
MIME-Version: 1.0
From:   Eugene Konev <uejikov@gmail.com>
Date:   Tue, 31 Jan 2023 19:49:09 +0700
Message-ID: <CAO7DJoCeUdHzRYkXg-HXTQqYpBPijR-ZbUy_C6Lx35s-wYR-mQ@mail.gmail.com>
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Russia (RU) on 5GHz
To:     sforshee@kernel.org
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update regulatory info for Russia on 5GHz in accordance with
current regulatory rules.

Source: https://docs.cntd.ru/document/902048009?section=3Dtext

Signed-off-by: Eugene Konev <uejikov@gmail.com>
---
 db.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/db.txt b/db.txt
index 3f74194..915a3b9 100644
--- a/db.txt
+++ b/db.txt
@@ -1500,10 +1500,11 @@ country RS: DFS-ETSI
        # 60 GHz band channels 1-4, ref: Etsi En 302 567
        (57000 - 66000 @ 2160), (40)

-country RU:
+# Source: https://docs.cntd.ru/document/902048009?section=3Dtext
+country RU: DFS-ETSI
        (2400 - 2483.5 @ 40), (20)
-       (5150 - 5350 @ 160), (20), NO-OUTDOOR
-       (5650 - 5850 @ 160), (20), NO-OUTDOOR
+       (5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS
+       (5650 - 5850 @ 160), (100 mW), NO-OUTDOOR, DFS
        # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order
=E2=84=96129_22042015.pdf
        (57000 - 66000 @ 2160), (40), NO-OUTDOOR

--=20
2.30.2
