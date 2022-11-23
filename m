Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D417E6363D4
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Nov 2022 16:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiKWPfz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Nov 2022 10:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbiKWPfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Nov 2022 10:35:54 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8BD7818E
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:53 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id d7so12649578qkk.3
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 07:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILrrTlt7glj7jRujaJkBk6baf5IG4t3ahOvYJI1MVcA=;
        b=KwtCFmMQewxxZnxaFKZblBQJGt42ydUC7qF87da4aMyVpKIj251nuN+fEm86qcCR2Z
         WcpoRGRuhztWDCVwgDupbQ+iMU1n3tGi76oQqxyWEorlqNn1U5n/sUPlOWLFhoPV+FD+
         b68TKOvyT2uI7qrK919seB9ve6d5QEDM9oQg1V6lSjjh8NbbS+cb13s/iH8fjXMz5Xfj
         9Q5x12lxqt87yP52t/HA83xf+rVSdowOiMpQJUta6uDXzvfLvD8A8l86H4xy2mnq8L2w
         pepkhjpKRs0gkXsgvjYMQF+UNvKbWzQzwmr7H/utQ0KTktBHeyQYX6ppZj4twa6L0Fbr
         6KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILrrTlt7glj7jRujaJkBk6baf5IG4t3ahOvYJI1MVcA=;
        b=fpnBBabyP2sZ1Cn6Xptg5lQmchLgyKQZJAk/YQA77k5MqIr5Vbr0Wmc4xT61ZBbJ74
         hcw6GZ3bmC3CObLw1rXGukgBlXhZxCE9BCZAZLIFUXqanzymKchKoxDEB7XdQb50qiZQ
         wQXRws88iicouyzm7P8gQ3qjphBhY1E9nLtQI1cjtE4pB/kk/EgUmHW08Y2de7a9aJc7
         iS5QtG/hNdaroGfsTg/exC8IgfCZsnIinMCEFMT+u9l6qWB1sVoSpjUxX/u9FlMijO5a
         AhobOJI7x1tfWTb0axgGYxUuumAq3Ynj/H8fQHu92IC8qX8tXtouPdIYDLCdABUulw8L
         m4zw==
X-Gm-Message-State: ANoB5pl2QLANCHGbF2eW+8ufXhsIUfd/5JmkkoooIJaOw7P90ic2uxg0
        iVKNuQAmogV7CpRmutoywKkVcgs+L/ndZFdnTzvkg2cOmtA0Ur4weA5qvBpkiDm+j45LMWidHU2
        gK5G6Wur1WQcBBY28b1T4sOO1wij4LrhasNrLfjRY/6f9LXqkmjzVGp/hScT2VMTArMNS41Ux8/
        kdpxI4uDrPD8A=
X-Google-Smtp-Source: AA0mqf7nsgL3zen3LyDO4H8OR2wz+CpwC40C6JXQU6QnKY9XQB/uOUmgB70ylkOKEao7lKE6IOygUQ==
X-Received: by 2002:a05:620a:102f:b0:6fa:2050:ea8b with SMTP id a15-20020a05620a102f00b006fa2050ea8bmr8866246qkk.429.1669217752385;
        Wed, 23 Nov 2022 07:35:52 -0800 (PST)
Received: from localhost.localdomain (c-73-218-151-107.hsd1.ct.comcast.net. [73.218.151.107])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm11990296qke.105.2022.11.23.07.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 07:35:52 -0800 (PST)
From:   Phil Turnbull <philipturnbull@github.com>
To:     linux-wireless@vger.kernel.org
Cc:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        kvalo@kernel.org, Phil Turnbull <philipturnbull@github.com>
Subject: [PATCH 2/4] wifi: wilc1000: validate length of IEEE80211_P2P_ATTR_OPER_CHANNEL attribute
Date:   Wed, 23 Nov 2022 10:35:41 -0500
Message-Id: <20221123153543.8568-3-philipturnbull@github.com>
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

Validate that the IEEE80211_P2P_ATTR_OPER_CHANNEL attribute contains
enough space for a 'struct struct wilc_attr_oper_ch'. If the attribute is
too small then it triggers an out-of-bounds write later in the function.

Signed-off-by: Phil Turnbull <philipturnbull@github.com>
Tested-by: Ajay Kathat <ajay.kathat@microchip.com>
Acked-by: Ajay Kathat <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 9bbfff803357..aedf0e8b69b9 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -959,14 +959,24 @@ static inline void wilc_wfi_cfg_parse_ch_attr(u8 *buf, u32 len, u8 sta_ch)
 		return;
 
 	while (index + sizeof(*e) <= len) {
+		u16 attr_size;
+
 		e = (struct wilc_attr_entry *)&buf[index];
+		attr_size = le16_to_cpu(e->attr_len);
+
+		if (index + sizeof(*e) + attr_size > len)
+			return;
+
 		if (e->attr_type == IEEE80211_P2P_ATTR_CHANNEL_LIST)
 			ch_list_idx = index;
-		else if (e->attr_type == IEEE80211_P2P_ATTR_OPER_CHANNEL)
+		else if (e->attr_type == IEEE80211_P2P_ATTR_OPER_CHANNEL &&
+			 attr_size == (sizeof(struct wilc_attr_oper_ch) - sizeof(*e)))
 			op_ch_idx = index;
+
 		if (ch_list_idx && op_ch_idx)
 			break;
-		index += le16_to_cpu(e->attr_len) + sizeof(*e);
+
+		index += sizeof(*e) + attr_size;
 	}
 
 	if (ch_list_idx) {
-- 
2.34.1

