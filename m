Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50B0507FC9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 06:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347091AbiDTEQq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 00:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEQp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 00:16:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D40167C3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 21:14:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id n22so837247pfa.0
        for <linux-wireless@vger.kernel.org>; Tue, 19 Apr 2022 21:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wSdWUFjhyHF8nG68rRcEXAl20d4uAMXtwo0O6RnSpQ=;
        b=phwaPK4CAuman7/QBGaQQd9UkFXxHOTUlrpoQo3dj7jtRS5nLHntfZ7/1KcU24suWA
         jJuGzga+PkqmuTVvy0wcmd+9lR8SO2fU0RBx7WHkYVS0XPce/CQWgK9mRWdK+agUSJ6p
         B7CUd9XLMv6xvnYJrp7HUVlwi2E1G8rG0YyamDXZDdm5uGxnH1XJXTydjzzZ4CgleI6b
         aQHT9xAk2d3G0kgfHjP3Hf1VZEn/Y/jJcN+BZWLZuY/xqka0vWjhFNpqbVRofnp078In
         HdhdwwDAb3A93GiMYanuegpmtyGxeBhhkcIXzPrchDHluFyYI5j54nbpC/nBdufu3yIM
         wuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+wSdWUFjhyHF8nG68rRcEXAl20d4uAMXtwo0O6RnSpQ=;
        b=x/fGK7yvDfA/XZIms8QXt//MOOuZe1zEWFZvWNmGk4mZpcNZmDFTWei+WOpkhCR4Qo
         XXmChtIOb4Ict8UMCkZMrUEQwxv/++VBubjI25ivFL0eAlVutsCxXnQHEVZfLbGj1IsU
         LbauV4wck4fB9d4ar2RVPsLgKSQHXeNpnmiLomtbikLsV5bh+cuiyk5A8R4xLKYscFBi
         dJAMIXQH6gE1WJT2TaPB3zcJUv+X26LRPlRLuBvZEEXt3vT0eX6F1y/DvsgMw+keWqXg
         T1KzliFhg7I+fjYjf3x0CSorb3TxwqTrhNF77u3QnIENFOK0utAmgj6Qdv2yStO2dg9S
         +edA==
X-Gm-Message-State: AOAM532ByZmNWy16a2mBpz6LkVYcH8oD6gWlgSETheSQjcQB2C+g/o4c
        wDoUhbHtW/5DPckyYHtKp1kmI72OtpUvGnqz
X-Google-Smtp-Source: ABdhPJzUZirAlbIwnH8E4OijoKXFHPNdTjDd4CwTxRcNapqONDofeOGtRKW5oSjLcRrrbiuQ4kdhXw==
X-Received: by 2002:a63:f351:0:b0:3aa:4ae4:1916 with SMTP id t17-20020a63f351000000b003aa4ae41916mr3805097pgj.496.1650428040014;
        Tue, 19 Apr 2022 21:14:00 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm18891545pfc.190.2022.04.19.21.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 21:13:59 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH] cfg80211: retrieve S1G operating channel number
Date:   Wed, 20 Apr 2022 04:13:20 +0000
Message-Id: <20220420041321.3788789-1-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When retrieving the S1G channel number from IEs, we should retrieve
the operating channel instead of the primary channel. The S1G operation
element specifies the main channel of operation as the oper channel,
unlike for HT and HE which specify their main channel of operation as
the primary channel.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index b2fdac96bab0..c5273d29515e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1829,7 +1829,7 @@ int cfg80211_get_ies_channel_number(const u8 *ie, size_t ielen,
 		if (tmp && tmp->datalen >= sizeof(struct ieee80211_s1g_oper_ie)) {
 			struct ieee80211_s1g_oper_ie *s1gop = (void *)tmp->data;
 
-			return s1gop->primary_ch;
+			return s1gop->oper_ch;
 		}
 	} else {
 		tmp = cfg80211_find_elem(WLAN_EID_DS_PARAMS, ie, ielen);
-- 
2.25.1

