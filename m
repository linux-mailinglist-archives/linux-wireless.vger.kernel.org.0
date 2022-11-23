Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E185E6363D3
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 16:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbiKWPfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 10:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbiKWPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 10:35:51 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322951161
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:51 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id a27so11408662qtw.10
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcEd0uKVX5Vx/FXDpHViklYQ6RAhuSZUrYNICOdpZ44=;
        b=I+Q8RXW4JCTR7ksow0zKJr77nBLVMD+Icq/ogcNJ9OmPETms5UtxKM/lNxM0EtmJGj
         hccKPNFga8itE//hmdDEvf8/PBGfKhKuNzyuiqBXh8VwVZtFOebSJia0VT08FI2v8fu5
         A9AJXCo7dxGmvZ22UjloMaX0Q4DLh07Lxd6gQtzsexUeffEU2JATVw1rs4FH7OZXA3QH
         L3U0WQ7EzIiHX8X+0YsqlNqUZMCi/QYMNq0Fr3y+deUgZJmca9r2ulHTUCsaaQc74Wdh
         W67VkNyGVutYruGWV2y9+MrD0fuJ2G6yAydYnO3MYWbfDzoL1q1rJUDDUfkJUiZKzEYO
         yA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcEd0uKVX5Vx/FXDpHViklYQ6RAhuSZUrYNICOdpZ44=;
        b=KeepZhgZoJ9MhhxT5UogMdncF73j+8vLUYoryYBUZFEWaERu0UjdrHE8MU/YscuLsm
         daRJRU+BSIQ46InJSOvmgZ1nVtfSsk3GzpyepeOulWDSQCSNXkFEZuTtlHz1Zo2seoXO
         TA24rQLtN4Rq7TLEfOAedGyAIri11A/4mzb//sMMxu2wwHamUatqBu9+ieukmdTwu4we
         7CVs9DWi2EoDEgaNHx9tWljcRYmlfRgo0Fjm8zIhvvIuwfigQ4AHbmZ0VYAqkeg+MLcq
         gAoFayv0v8RILXnelDJoywQwwk3IN0HKHb0b45jlcttJK6dF69Wt+CoPQ49eTdx4VnPl
         xQLg==
X-Gm-Message-State: ANoB5plFCBle3G+Po2SDzEAnGVysQJYy8/0AhvDiGpcdSCaLBX/2vIws
        KYCD+yMEQ4bru1EJw3peMxH0aR0xQ8zOqwMeifvMeWFlHxD+3YyD9QjuBn3Bqjk/MMmGI2MIY4t
        yKbI3NhfYAxsRSY+wBd0rARS/fksJwn38U8Uq/toHhKZsD2IxD6JDzSSxfKY5rUWzRcs8znhMGn
        pwO2ZSmTU6uNI=
X-Google-Smtp-Source: AA0mqf49FyNap30xhv6kOPez9FfiSJtmGpKXxbbJf2dkqWY+hg491oqJN9aHINvzeG3CAtZezv3jEA==
X-Received: by 2002:ac8:488f:0:b0:3a6:fa9:bcca with SMTP id i15-20020ac8488f000000b003a60fa9bccamr27533721qtq.652.1669217750173;
        Wed, 23 Nov 2022 07:35:50 -0800 (PST)
Received: from localhost.localdomain (c-73-218-151-107.hsd1.ct.comcast.net. [73.218.151.107])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm11990296qke.105.2022.11.23.07.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:35:49 -0800 (PST)
From:   Phil Turnbull <philipturnbull@github.com>
To:     linux-wireless@vger.kernel.org
Cc:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        kvalo@kernel.org, Phil Turnbull <philipturnbull@github.com>
Subject: [PATCH 1/4] wifi: wilc1000: validate pairwise and authentication suite offsets
Date:   Wed, 23 Nov 2022 10:35:40 -0500
Message-Id: <20221123153543.8568-2-philipturnbull@github.com>
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

There is no validation of 'offset' which can trigger an out-of-bounds
read when extracting RSN capabilities.

Signed-off-by: Phil Turnbull <philipturnbull@github.com>
Tested-by: Ajay Kathat <ajay.kathat@microchip.com>
Acked-by: Ajay Kathat <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index eb1d1ba3a443..67df8221b5ae 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -482,14 +482,25 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 
 	rsn_ie = cfg80211_find_ie(WLAN_EID_RSN, ies->data, ies->len);
 	if (rsn_ie) {
+		int rsn_ie_len = sizeof(struct element) + rsn_ie[1];
 		int offset = 8;
 
-		param->mode_802_11i = 2;
-		param->rsn_found = true;
 		/* extract RSN capabilities */
-		offset += (rsn_ie[offset] * 4) + 2;
-		offset += (rsn_ie[offset] * 4) + 2;
-		memcpy(param->rsn_cap, &rsn_ie[offset], 2);
+		if (offset < rsn_ie_len) {
+			/* skip over pairwise suites */
+			offset += (rsn_ie[offset] * 4) + 2;
+
+			if (offset < rsn_ie_len) {
+				/* skip over authentication suites */
+				offset += (rsn_ie[offset] * 4) + 2;
+
+				if (offset + 1 < rsn_ie_len) {
+					param->mode_802_11i = 2;
+					param->rsn_found = true;
+					memcpy(param->rsn_cap, &rsn_ie[offset], 2);
+				}
+			}
+		}
 	}
 
 	if (param->rsn_found) {
-- 
2.34.1

