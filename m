Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7959E6363D6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 16:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbiKWPgA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 10:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238042AbiKWPf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 10:35:59 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7440473B8F
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:58 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id s4so11431915qtx.6
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSfnO0oLUvR/YHRda4SUn9qpHU5N545eEU/vyWcDNSs=;
        b=IlDj/ixSzEJ7qI4m70X7ywNtqUijdynODGQNoDHpdHsQSmUm6IibulgOqhx759hfRc
         sgSrp+r+zd4DCCkWjFB/Vkc+YMKx+3yOVb+kzP8gE+ZPnOsAS4o7WRzuQN28tJGAI3cY
         1W17x3r9gfraWtFirC+ITMytn3OCwio/4uV3sNhcAcW5+IWEQopYi2Ja//Qnhr3lqtW3
         TVlTFzr5l7X71GWGscGEkKWsVw5wrU9MheWr/odcG9RO1zsheBRvo9KU8ROo+v2EPswG
         j3HqorxenMDaGKyclRj2kMSq2tdwEcTgY3shXOR17m/nspYoQN5dyHjaj8LGrF+CxpE6
         zCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSfnO0oLUvR/YHRda4SUn9qpHU5N545eEU/vyWcDNSs=;
        b=chPU52ntAH33Csr3QMFkxuVrbFwJRA945V31l0LGFW0uyGRhoEWZ88CgllcgPyxyI/
         c9PEjJQqVpS3mc6Wx2QHSzrBZvE2CIi7Wp0cjUfq3ajCGhUa4b2s+ALnAWJ4uDDT+t7d
         skW5Hlyb9fSgYrAivFrnROO7tLRW6CFBhZCOzAgc2oE48wMIVqO7DFav17UXgKA6xAqe
         81DK/Pjy/+qCNLfgZgEQApdwr9XXtKgzJ0rOBC+W58X31fJFq1XxOZWo6Hxjk0ycRWGw
         r0x2uwpcgi6S8sYj+n0PJB0JwEEV0Ybd9Uwp52ihYn3B/4agyGbpLMxpXzuOgA9ULPQX
         PbuA==
X-Gm-Message-State: ANoB5pncGCttxkfxms6wNKgMyge5JNnmE6+7pEGSj3rMp3WDC1mdUEPU
        rzprwF3w8hCbPdP5KbbsoKY8gqVgPDr3h453XsffMuRtQ0g5TualeJdtQUYNoen7y2GM9U+XTz4
        mjUxmRyh7xpl3ua4gjkxH2C6LNNF3xd6nicWnBHOE6Alh3zqopD84v3XQyUtXbDc7cd9wSVkYEN
        BghHeJYKvm7fA=
X-Google-Smtp-Source: AA0mqf755Mojwkr0Kqso5W1wkXlf1OICk3ws3kZY270zJrI4TKozzyDg1Btns+2hgdMpjt7vY4AitQ==
X-Received: by 2002:ac8:7343:0:b0:3a4:c30b:c640 with SMTP id q3-20020ac87343000000b003a4c30bc640mr8314182qtp.25.1669217757151;
        Wed, 23 Nov 2022 07:35:57 -0800 (PST)
Received: from localhost.localdomain (c-73-218-151-107.hsd1.ct.comcast.net. [73.218.151.107])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm11990296qke.105.2022.11.23.07.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:35:56 -0800 (PST)
From:   Phil Turnbull <philipturnbull@github.com>
To:     linux-wireless@vger.kernel.org
Cc:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        kvalo@kernel.org, Phil Turnbull <philipturnbull@github.com>
Subject: [PATCH 4/4] wifi: wilc1000: validate number of channels
Date:   Wed, 23 Nov 2022 10:35:43 -0500
Message-Id: <20221123153543.8568-5-philipturnbull@github.com>
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

There is no validation of 'e->no_of_channels' which can trigger an
out-of-bounds write in the following 'memset' call. Validate that the
number of channels does not extends beyond the size of the channel list
element.

Signed-off-by: Phil Turnbull <philipturnbull@github.com>
Tested-by: Ajay Kathat <ajay.kathat@microchip.com>
Acked-by: Ajay Kathat <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index c4d5a272ccc0..b545d93c6e37 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -981,19 +981,29 @@ static inline void wilc_wfi_cfg_parse_ch_attr(u8 *buf, u32 len, u8 sta_ch)
 	}
 
 	if (ch_list_idx) {
-		u16 attr_size;
-		struct wilc_ch_list_elem *e;
-		int i;
+		u16 elem_size;
 
 		ch_list = (struct wilc_attr_ch_list *)&buf[ch_list_idx];
-		attr_size = le16_to_cpu(ch_list->attr_len);
-		for (i = 0; i < attr_size;) {
+		/* the number of bytes following the final 'elem' member */
+		elem_size = le16_to_cpu(ch_list->attr_len) -
+			(sizeof(*ch_list) - sizeof(struct wilc_attr_entry));
+		for (unsigned int i = 0; i < elem_size;) {
+			struct wilc_ch_list_elem *e;
+
 			e = (struct wilc_ch_list_elem *)(ch_list->elem + i);
+
+			i += sizeof(*e);
+			if (i > elem_size)
+				break;
+
+			i += e->no_of_channels;
+			if (i > elem_size)
+				break;
+
 			if (e->op_class == WILC_WLAN_OPERATING_CLASS_2_4GHZ) {
 				memset(e->ch_list, sta_ch, e->no_of_channels);
 				break;
 			}
-			i += e->no_of_channels;
 		}
 	}
 
-- 
2.34.1

