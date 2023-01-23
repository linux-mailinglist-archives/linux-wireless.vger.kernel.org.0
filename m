Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035206774EF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 06:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjAWFb5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 00:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjAWFbz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 00:31:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5046DF772
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 21:31:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id dw9so10639954pjb.5
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 21:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lS8RxxZjmGlqZ8cnEymEaNnDbuVt+IfNcHGvu/vuIE=;
        b=XcZK0qpPVooMp9/r0K+9ME9y5HWbzxEo95R2wiW4GvYj4yH9fVkG0iqF6fzePlOvqA
         XuKE+V0y8a6e81v1UTo9zZfZj0RZvxoOS5JesxI3FQBSwFWKYQ5JZtgXKkm1V2jE6HpL
         8r5O7y6crKh1ArP3+U54Rugxvth+7E0C/xUzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lS8RxxZjmGlqZ8cnEymEaNnDbuVt+IfNcHGvu/vuIE=;
        b=bJ4aCEis3tr3kE7tn5hfP7QPL/aUeSNL5ppWfTOnha1/nJq99r89VbV+ra+DibKc9S
         dey/1EkIaOvJsdU0sohIhdA6fgmW5HUVhtWaBhhtbKwia05iEXfjraTPfmQFnOKVk9xe
         ewBhXw5Egf8ujY++AFiCctPDqRIUrc3fOMfbEv4rocpn91aKIvkcc+il4p+/3MjvXBex
         jnX+xXEBT87Yh3jOjqmKZBlzpdt+Ix5Z++F+m4/jDkNB8NcaGCqO+u0/x3rZLWO0YGTG
         pV1imm4sygf8gI0y2bFC7lppZeL3ed5DeTHp8fHxa4MlmF4ZbM/c167qOGqFpzbochmo
         J+8g==
X-Gm-Message-State: AFqh2krXQpxNG4v7LB25LVdqFyf9RrrPf83S6C9NRdzvXDnawAlSj1U8
        cP3tkkNxW2mzhsK5BtXO6T8VOQ==
X-Google-Smtp-Source: AMrXdXv4d9WR0BLVLX8gqZyPGFcJu7LLqeAEAcsKCvousE8W1W3sAA7X/k7BITaizhVmlaO3U/LfDA==
X-Received: by 2002:a17:903:324e:b0:185:441e:222c with SMTP id ji14-20020a170903324e00b00185441e222cmr24256123plb.39.1674451913779;
        Sun, 22 Jan 2023 21:31:53 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902db0300b0018963b8e131sm9125244plx.290.2023.01.22.21.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 21:31:53 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v4 1/4] wifi: libertas: fix code style in Marvell structs
Date:   Sun, 22 Jan 2023 21:31:29 -0800
Message-Id: <20230123053132.30710-2-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123053132.30710-1-doug@schmorgal.com>
References: <20230123053132.30710-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Several of the structs are using the deprecated convention of items[1]
for a dynamically sized trailing element. Convert these structs to the
modern C99 style of items[]. Also fix a couple of camel case struct
element names.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/net/wireless/marvell/libertas/types.h | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/types.h b/drivers/net/wireless/marvell/libertas/types.h
index cd4ceb6f885d..de60becaac12 100644
--- a/drivers/net/wireless/marvell/libertas/types.h
+++ b/drivers/net/wireless/marvell/libertas/types.h
@@ -105,23 +105,23 @@ struct mrvl_ie_header {
 
 struct mrvl_ie_data {
 	struct mrvl_ie_header header;
-	u8 Data[1];
+	u8 data[];
 } __packed;
 
 struct mrvl_ie_rates_param_set {
 	struct mrvl_ie_header header;
-	u8 rates[1];
+	u8 rates[];
 } __packed;
 
 struct mrvl_ie_ssid_param_set {
 	struct mrvl_ie_header header;
-	u8 ssid[1];
+	u8 ssid[];
 } __packed;
 
 struct mrvl_ie_wildcard_ssid_param_set {
 	struct mrvl_ie_header header;
-	u8 MaxSsidlength;
-	u8 ssid[1];
+	u8 maxssidlength;
+	u8 ssid[];
 } __packed;
 
 struct chanscanmode {
@@ -146,7 +146,7 @@ struct chanscanparamset {
 
 struct mrvl_ie_chanlist_param_set {
 	struct mrvl_ie_header header;
-	struct chanscanparamset chanscanparam[1];
+	struct chanscanparamset chanscanparam[];
 } __packed;
 
 struct mrvl_ie_cf_param_set {
@@ -164,12 +164,12 @@ struct mrvl_ie_ds_param_set {
 
 struct mrvl_ie_rsn_param_set {
 	struct mrvl_ie_header header;
-	u8 rsnie[1];
+	u8 rsnie[];
 } __packed;
 
 struct mrvl_ie_tsf_timestamp {
 	struct mrvl_ie_header header;
-	__le64 tsftable[1];
+	__le64 tsftable[];
 } __packed;
 
 /* v9 and later firmware only */
@@ -220,7 +220,7 @@ struct led_pin {
 
 struct mrvl_ie_ledgpio {
 	struct mrvl_ie_header header;
-	struct led_pin ledpin[1];
+	struct led_pin ledpin[];
 } __packed;
 
 struct led_bhv {
@@ -233,7 +233,7 @@ struct led_bhv {
 
 struct mrvl_ie_ledbhv {
 	struct mrvl_ie_header header;
-	struct led_bhv ledbhv[1];
+	struct led_bhv ledbhv[];
 } __packed;
 
 /*
-- 
2.34.1

