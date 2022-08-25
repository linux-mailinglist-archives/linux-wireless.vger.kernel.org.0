Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC645A0D5E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Aug 2022 11:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbiHYJyX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Aug 2022 05:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiHYJyD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Aug 2022 05:54:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEA1AB4E8
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 02:52:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d8so15113861lfq.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Aug 2022 02:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=hKfDWH3H7k49OaxlWD9m5PnQEo+ONbPwyxm1Mk2RNsw=;
        b=MG4M1Wh53E9B6I36jXwCO3n5f7AvA6I0ScJ07llWFKJ7RYAMmP57xIccpirP+XUxAn
         vAINFdvj6B22sT/LFI+zh8HX/wESKPBJjTYlJExqbTGohrg/6Aqrfk9Xvi0hkQjkr/Fv
         5qp+pgD2ltwMM1kDbtkUJW5y82Y00dC305HsZ9ZdC6V3fkRmTKtYG0tRbOQ5N7+QKN5C
         xenA/62EcUoV9pS/HTSUowre6HSFMOrr3vTYxO/9hmV5ZX/yfyBXq7wipIbAiq82anrq
         VMj15vn0WTY1uUIs7u6pgicRg8gbJT8hk19zgM8z/UHqXUelLa90DJ2Jbca8ig9zSd0+
         YhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=hKfDWH3H7k49OaxlWD9m5PnQEo+ONbPwyxm1Mk2RNsw=;
        b=CWCwPYsaVJIX2mUZgarkjUHcrC/ZUDd7sXA7khZYUvGAZV7wPDfYzO11PQs/XCZhy8
         Jm+lIazfBHhVyTgosInmGAnzyNlEpLIXB6v01uLrTWKCNE4Od/NM3UrStkLrDjPtp9Rv
         v0hp9P04crDtufOmw4XDZkePrVmx6NDgb0aKV3Th5xmN5cFgzDlmI+tkn+g0b/yGOxrI
         H3Z7eHUJTIGK/W2PmQIvhwyMnR2v0jBTfuB1LAWYj7GMu6dwll5ly79Vq4Mf6GUmShCI
         6TaxorCiNK2eKxi/lUOxoUvxJYcHxNiUKe4Bco+eJ2xDUUC4bmu0XpJlukFLRdz10aBv
         On9A==
X-Gm-Message-State: ACgBeo3/Y/FnRTyvdAAv4EIThlyww0wkOMkJ0+K/1Q8TT4/vZipRNeav
        e3ArsTIvRKzd3TyLi+wulpoMYkGN+WQZTw==
X-Google-Smtp-Source: AA6agR7P54rzQFMBbuJpDseQ4UEjsJFGV1/CrxQ79RMMHlLNwnipRSNRZHp3sc20vJKsCcyJez7hCQ==
X-Received: by 2002:a05:6512:1291:b0:492:e988:60f with SMTP id u17-20020a056512129100b00492e988060fmr846351lfs.417.1661421088130;
        Thu, 25 Aug 2022 02:51:28 -0700 (PDT)
Received: from localhost.localdomain ([62.141.192.106])
        by smtp.gmail.com with ESMTPSA id k11-20020a2ea26b000000b0025e304903f5sm463215ljm.6.2022.08.25.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 02:51:27 -0700 (PDT)
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Janusz Dziedzic <janusz.dziedzic@gmail.com>
Subject: [PATCH] iw: add cac background command
Date:   Thu, 25 Aug 2022 11:51:11 +0200
Message-Id: <20220825095111.1026649-1-janusz.dziedzic@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add command that request background CAC radar scan.
Tested on mt7915.

Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
---
 phy.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/phy.c b/phy.c
index 2d489ef..0a57ecb 100644
--- a/phy.c
+++ b/phy.c
@@ -301,6 +301,15 @@ static int handle_cac_trigger(struct nl80211_state *state,
 	return put_chandef(msg, &chandef);
 }
 
+static int handle_cac_background(struct nl80211_state *state,
+				 struct nl_msg *msg,
+				 int argc, char **argv,
+				 enum id_input id)
+{
+	nla_put_flag(msg, NL80211_ATTR_RADAR_BACKGROUND);
+	return handle_cac_trigger(state, msg, argc, argv, id);
+}
+
 static int no_seq_check(struct nl_msg *msg, void *arg)
 {
 	return NL_OK;
@@ -381,6 +390,14 @@ COMMAND(cac, trigger,
 	"Start or trigger a channel availability check (CAC) looking to look for\n"
 	"radars on the given channel.");
 
+COMMAND(cac, background,
+	"channel <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
+	"freq <frequency> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
+	"freq <frequency> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]",
+	NL80211_CMD_RADAR_DETECT, 0, CIB_NETDEV, handle_cac_background,
+	"Start background channel availability check (CAC) looking to look for\n"
+	"radars on the given channel.");
+
 static int handle_fragmentation(struct nl80211_state *state,
 				struct nl_msg *msg,
 				int argc, char **argv,
-- 
2.25.1

