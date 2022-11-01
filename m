Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C648661535B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 21:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKAUen (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 16:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiKAUel (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 16:34:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D81004A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 13:34:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b2so40062280eja.6
        for <linux-wireless@vger.kernel.org>; Tue, 01 Nov 2022 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80p2vI7h9NymXeZ/iGoytPyO7nRo83XNUs5KtNjW7vU=;
        b=FvbNEuHUrNUfBoPl3Re1aUOdsoRbR7199TgyrvFHnwy3pcUWN9cmtLuVTWuROOI7Av
         MavGxhyv+fLLhxmK4mCMLeMpkUnamSJUzoHGdsBV5DMSadrfeGuxf6hBdj8TOGDwK9TC
         9ss/dPpT1Ym/FEmRE+lyyAhPNzmQV9/2Gm2bzYDPVzYLgCRM8V3UbGgWE/yMX3/KCD+x
         aFs62IYLbgbNMUjjg3pQUczR+QAfLCIMqh9LdSkTvifCyXqmhcbhJoDWeIN9n2EkbK+j
         07LLz9IrJu6BzchXVQlKLpxBWsCEpir0+/Wc570xIn1wKT+3sR1840PSv0x8YS1kLcQN
         B+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=80p2vI7h9NymXeZ/iGoytPyO7nRo83XNUs5KtNjW7vU=;
        b=Gy3jXROCLHtydpWZAptpVeCAPks8JTWhA/M8u/CR63/GpI1pn/GV6qF4fvfuXmnN0H
         2IHJXfWawaKpDfaXXM5IjBHv80bHh/IrBA/W1KAdXiVzvyd5t02JVhM4WZIy5Ovg5SNu
         Z4sUC6TU41aRJTIiykb7lRZAdPcqHJdL2EH2f3Dok29JJWyyc64kyd49uYBxXUYvV3h6
         nHktJs3Lw+r1mgAWqQffnzjZnALhN+HbbZzArlm+BXBW0NHXtei5n+n7BuaFJoIpUmWr
         FA/+rsPPZMyFzigoZF+ypqSfwgs0jH7l7UgelvLYsnSNu7hhYn2RsZ/9ka5dh07hjrxs
         UCxA==
X-Gm-Message-State: ACrzQf03B8QE8CiLfPxWTUCtRO46gcYb6VqzsFvIJzn30CVQooZh8/rU
        D3c4hIrt1H7Qnqbbrf8vyf95pWzG10g=
X-Google-Smtp-Source: AMsMyM5iAlaZBnCqKuhtrHUEYTBwU3FSWYp45SXqHX79O9wCspG8S1qEIZavllYHsqsPlYi5T/XOOw==
X-Received: by 2002:a17:907:6d9d:b0:7ad:f514:794e with SMTP id sb29-20020a1709076d9d00b007adf514794emr3306695ejc.602.1667334878520;
        Tue, 01 Nov 2022 13:34:38 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id f30-20020a170906739e00b0078e05db7005sm4521490ejl.214.2022.11.01.13.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 13:34:38 -0700 (PDT)
Message-ID: <9b59e735-6b89-a557-fafc-2da87fdd5b48@gmail.com>
Date:   Tue, 1 Nov 2022 22:34:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v4 4/5] wifi: rtl8xxxu: Set IEEE80211_HW_SUPPORT_FAST_XMIT
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
In-Reply-To: <80aba428-0aff-f4b2-dea5-35d1425982b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to commit 60d7900dcb98 ("wlcore: enable
IEEE80211_HW_SUPPORT_FAST_XMIT"), we can use this because all the chips
have hardware rate control.

This is one of the things mac80211 requires before it will handle MSDU
aggregation for us.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Rebased on top of wireless-next.
 
v3:
 - No change.
 
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 823e50811b0d..58e6416787df 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -6998,6 +6998,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	 * The firmware handles rate control
 	 */
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
-- 
2.38.0
