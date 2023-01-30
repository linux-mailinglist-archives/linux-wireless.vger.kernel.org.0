Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D696810AF
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 15:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbjA3OFp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 09:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbjA3OFo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 09:05:44 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B5C2A172
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 06:05:42 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id l7so2055142ioa.7
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 06:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Qb6zMVyzjtj0/TQ/Lyc3HSKCfDqcZxkwmAqIFLNINM=;
        b=BeH6FnitCZVR0iI8gmCER8IMJQNBB9NGcYTMaGX+FL0/YdxrRBrh7iRP5ou+BuabkR
         EbE2h0BytgkGmKEhV0h5JP8bgdlMAwqSHCjKgMTq6ua8kGtj3den1FGKohq96yftyIsP
         bHhD01xY4jrU0CBScgm6zigpUW3eMQ10lZKf7xh7C80mtrO+7mqK8CGgTzusyjeurlBB
         J5hiN3KFQNBHgmaiJE9vc48vqRD5nzGcYI5HOwrlBISi80zq4JNvO+ilk9HoafF45JtR
         kx+UWfEBfyY12byYGRApJ8rnswNpFRzl6hNpEiVXUiEEmIhN7S1ZsfRQQ+YxGu35pA1/
         xuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Qb6zMVyzjtj0/TQ/Lyc3HSKCfDqcZxkwmAqIFLNINM=;
        b=QB60S8v2OXvPgYWXNGaaTvb2JqLufT2yB/zd1/5bTvu3QHKEWqxzf78WePtY/Ftu8x
         WCEy3TY9Tyh1sbVUzljpnC8r5eUXuiiWaZd5ncaVtUVrhVzsxSJakF+yhB7HAPoVMtfZ
         H/hYZa24u4/nx7UcqZVxHbiZkmkF8cT458m/Wa8uKVs3kVezcCHiI0lJq4mcEw+hDxlI
         a+aLd30vIvhqgzpCA9HFUDeSh8Z1o4JXLwcnKQKaCr4TaQaPyfw8JGxR+zyFwBX+TZab
         rceAV+iAye1uDy3sklUak5N1yCqHuKaP4xmLO8607RtctITFOCnZDeseqPgNw2/JCTt4
         TIHQ==
X-Gm-Message-State: AO0yUKWeLsUH5JCLoADruGFc2Upf6unVWnqHBiJKKcx3nf0cjUwZ2PUO
        eEBE4AAy3TH9kZwIO8l7QXAchOLvAIj1gAtARiHFtpC0iHM=
X-Google-Smtp-Source: AK7set8i73j2W5MrUkGmaATl3/fl0ZwGGUj/7GzNZuA/U713Mx2VRsiEqZSrl87R92Elath1nwYywvhdl8mku6BqjiQ=
X-Received: by 2002:a02:6f51:0:b0:3b1:4f93:69b8 with SMTP id
 b17-20020a026f51000000b003b14f9369b8mr567256jae.117.1675087541420; Mon, 30
 Jan 2023 06:05:41 -0800 (PST)
MIME-Version: 1.0
From:   Eugene Konev <uejikov@gmail.com>
Date:   Mon, 30 Jan 2023 21:05:30 +0700
Message-ID: <CAO7DJoAXrB8e+q2uHD6Cq6A2UV5pN0=6ieAVV+yJp0ht1bPhyg@mail.gmail.com>
Subject: [PATCH] Update regulatory info for Russia (RU) on 5GHz
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
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
index 3f74194..9bc2c1c 100644
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
+       (5150 - 5350 @ 160), (200 mW), NO-OUTDOOR, DFS
+       (5650 - 5850 @ 160), (200 mW), NO-OUTDOOR, DFS
        # 60 GHz band channels 1-4, ref: Changes to NLA 124_Order
=E2=84=96129_22042015.pdf
        (57000 - 66000 @ 2160), (40), NO-OUTDOOR

--=20
2.30.2
