Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D2B6363D5
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237963AbiKWPf5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 10:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbiKWPf4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 10:35:56 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B486D4A9
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:55 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id g10so12643749qkl.6
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQ5QDI4af4ZfNZG5o47ipt1XsCibRZfQcbTvzmxsb0Q=;
        b=UXH+gEi3Vz3AsonhO6331s4+ZrwyinoMrX5DaVsDRC4kX7EeMgh76h75cUHBxyPo6Y
         3yFzOyNwcOz5rL4kGaen5QS+uYys1gyyHkqx4MwWO6dN+ZkVdnYZkDHpVrU4l4JVZ4KX
         /fw0lhQ5y22+T4JRlA2+6PkISuALYioPiFY+nwOE8Y1eC9i5/AomVD4x891SE22ag1iE
         hqjRc5SPDTHxNj8V4zr1upz0iUmpsPRN5DYeuciX4jVrbc0OrdqVKlUm7j/KFIx7FGLc
         OuUCHYNhjhHq6BfUNzWOIuthiXM4K7XyocNA/XLBlKs1Ds42u+I32v09ueNyZCHsPA/I
         0w+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQ5QDI4af4ZfNZG5o47ipt1XsCibRZfQcbTvzmxsb0Q=;
        b=XEBouzc79+5U4qh+Wf2x2kkPGqNtMOojZSZAAeO2Ec2U6b17whAOhDh7BeGUrYM+jR
         c+tpbQOTyEY9YsbzJiXSgkC+Yn3fCXtzuBKmGd1QkAtGgtXy2lwDxolAL7XDuSeuXGIY
         GuRSufszJKq5NL97d6a7P3vnYklA1v2qElYKMlLX4gG8Zkf/IgCuuO/xiH/9k/xo8Wad
         UzBycyNQtyH7taJZD7ksqEmIqQ9StlU9AAtf5mk5fBhL/i6Ro4UQNS0OVGL/+hZnxoyx
         lOgVwT2Lu08EF5Sv4Pciz3nbGTE5Su4uLLPpPsGn0tePxXWD4y9fpz7n3og02zc93M3z
         Fz+A==
X-Gm-Message-State: ANoB5pmSSVQBSC8ChDrWYof3Nqmzbl+j/m8ZjMAsh0bAshrxLTliAiRt
        AugMHqAWIKZx+a33VIh8BI4in/rIM/FgXXS4Kq6c5ew/hbf847QtAJjZipgYWGS4pCeRVir/PCz
        voYfkUyBeS7cnLQvsnUJz+Mp/wbqO+/WcBEUxZ5YWlhozQhBqtNIhbQLiri8QT6vzCLNY5fc014
        uVEtZCz/ecxWc=
X-Google-Smtp-Source: AA0mqf4C5A9IM8iRGgd5d0llNO/2pGsakRk9uZsAYo3cuMbYjngrCG01BYAXo3/ogMLVeOQ9yZIAiA==
X-Received: by 2002:a05:620a:d41:b0:6fb:38cd:adee with SMTP id o1-20020a05620a0d4100b006fb38cdadeemr26069884qkl.703.1669217754594;
        Wed, 23 Nov 2022 07:35:54 -0800 (PST)
Received: from localhost.localdomain (c-73-218-151-107.hsd1.ct.comcast.net. [73.218.151.107])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm11990296qke.105.2022.11.23.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:35:54 -0800 (PST)
From:   Phil Turnbull <philipturnbull@github.com>
To:     linux-wireless@vger.kernel.org
Cc:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        kvalo@kernel.org, Phil Turnbull <philipturnbull@github.com>
Subject: [PATCH 3/4] wifi: wilc1000: validate length of IEEE80211_P2P_ATTR_CHANNEL_LIST attribute
Date:   Wed, 23 Nov 2022 10:35:42 -0500
Message-Id: <20221123153543.8568-4-philipturnbull@github.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123153543.8568-1-philipturnbull@github.com>
References: <20221123153543.8568-1-philipturnbull@github.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Validate that the IEEE80211_P2P_ATTR_CHANNEL_LIST attribute contains
enough space for a 'struct wilc_attr_oper_ch'. If the attribute is too
small then it can trigger an out-of-bounds write later in the function.

'struct wilc_attr_oper_ch' is variable sized so also check 'attr_len'
does not extend beyond the end of 'buf'.

Signed-off-by: Phil Turnbull <philipturnbull@github.com>
Tested-by: Ajay Kathat <ajay.kathat@microchip.com>
Acked-by: Ajay Kathat <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index aedf0e8b69b9..c4d5a272ccc0 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -967,7 +967,8 @@ static inline void wilc_wfi_cfg_parse_ch_attr(u8 *buf, u32 len, u8 sta_ch)
 		if (index + sizeof(*e) + attr_size > len)
 			return;
 
-		if (e->attr_type == IEEE80211_P2P_ATTR_CHANNEL_LIST)
+		if (e->attr_type == IEEE80211_P2P_ATTR_CHANNEL_LIST &&
+		    attr_size >= (sizeof(struct wilc_attr_ch_list) - sizeof(*e)))
 			ch_list_idx = index;
 		else if (e->attr_type == IEEE80211_P2P_ATTR_OPER_CHANNEL &&
 			 attr_size == (sizeof(struct wilc_attr_oper_ch) - sizeof(*e)))
-- 
2.34.1

