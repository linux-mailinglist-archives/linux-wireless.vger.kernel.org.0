Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DFC5EE6AD
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 22:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiI1Ug6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 16:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiI1Ug4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 16:36:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C34D4DC3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 13:36:55 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id c30so17631575edn.2
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=3c6BLMTXXTqYTCxHVeF2lhPje24/4Qmp27/SyAZRmUc=;
        b=FWPdrhJzF569Gp2fr5wnJVXXRRTZsU+BeLOUc/69D9A/CxfDOz9vTQAC0dGIcALHDc
         CwWyRTb0Zrx2Xac6W+4JNEtch80F0h+9a1uMtZzUfk+5rkJeAqJHkCRPpb0/7AqWm2Ma
         q0CUxcB0as6DIhQQgvg0PpfPrlv6dywtskkFGx35eqNJ1wa7LMcj+kK24jWnhLpBob/n
         xdI+DCgc4iT313vnBfrNLgDjlLpIdhUG5eHYGco8FUkvfmxpYlFxEbwDJnWHlN9+6aZS
         63yE8rd5MZSdw1B99C1sVnZ4IcutUmvWl6y/OsfwedQZo83zar67c6I5y+8dLCRTwYPw
         yldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=3c6BLMTXXTqYTCxHVeF2lhPje24/4Qmp27/SyAZRmUc=;
        b=AMMRnfJePjXaQpIx4NLqTBlytaTm9BbKpbv5ZFdGU91qfx0gu4C+CrbztzjgLrGEyZ
         LZoTrmTwUlGh3lfm6nyFJNlw36Efkcn4X6qZrrwKptNr1RpMNCG1GtKHMnNehfm6cOOs
         kbb9Nrgw6Hwpxx0aW6S6yhEkKwWdWmgConUmlT8ot19Bzt2poK/AclCGHhLXVYNpptom
         ZaBOIL3NQ6V7NUX1oa2cjF7KBYC9eCMQJRtUc6fFJaR0VylxsXUS4/rulskIbH/czXqu
         AewF72T0zyYReMYNkjcQA88VSye1mCMHpEeHvEPnFEnOhMJEM16wBXYFOpshXGBWWDMr
         J1MA==
X-Gm-Message-State: ACrzQf1gyi7dHHiV26zSQ8Nhdik6cp3yGzQ3gh6cCf8KEAK8Ii5I/j4M
        nYSdh6WmTFcS9o4M0hEvSsZBRal1rsc=
X-Google-Smtp-Source: AMsMyM5XpUZiBGIpDJY/tOwN/mjFsQfNOg2sPPx1PeERNibT7ThDNbTQZltGyGbFTH0s7QX8nUodPw==
X-Received: by 2002:aa7:cc02:0:b0:453:b0f3:9927 with SMTP id q2-20020aa7cc02000000b00453b0f39927mr35793732edt.66.1664397413833;
        Wed, 28 Sep 2022 13:36:53 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id bd28-20020a056402207c00b00456f8a03250sm4013804edb.3.2022.09.28.13.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 13:36:53 -0700 (PDT)
Message-ID: <43200afc-0c65-ee72-48f8-231edd1df493@gmail.com>
Date:   Wed, 28 Sep 2022 23:36:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] wifi: rtl8xxxu: gen2: Turn on the rate control
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Re-enable the function rtl8xxxu_gen2_report_connect.

It informs the firmware when connecting to a network. This makes the
firmware enable the rate control, which makes the upload faster.

It also informs the firmware when disconnecting from a network. In the
past this made reconnecting impossible because it was sending the
auth on queue 0x7 (TXDESC_QUEUE_VO) instead of queue 0x12
(TXDESC_QUEUE_MGNT):

wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 1/3)
wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 2/3)
wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 3/3)
wlp0s20f0u3: authentication with 90:55:de:__:__:__ timed out

Probably the firmware disables the unnecessary TX queues when it
knows it's disconnected.

However, this was fixed in commit edd5747aa12e ("wifi: rtl8xxxu: Fix
skb misuse in TX queue selection").

Fixes: c59f13bbead4 ("rtl8xxxu: Work around issue with 8192eu and 8723bu devices not reconn…")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
  Report the disconnect as well.

v1 was part of the series "[PATCH 0/4] wifi: rtl8xxxu: A few
improvements".
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 4b76881cd50d..ba2a16de19ed 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4476,12 +4476,9 @@ void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 				  u8 macid, bool connect)
 {
-#ifdef RTL8XXXU_GEN2_REPORT_CONNECT
 	/*
-	 * Barry Day reports this causes issues with 8192eu and 8723bu
-	 * devices reconnecting. The reason for this is unclear, but
-	 * until it is better understood, leave the code in place but
-	 * disabled, so it is not lost.
+	 * The firmware turns on the rate control when it knows it's
+	 * connected to a network.
 	 */
 	struct h2c_cmd h2c;
 
@@ -4494,7 +4491,6 @@ void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 		h2c.media_status_rpt.parm &= ~BIT(0);
 
 	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
-#endif
 }
 
 void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
-- 
2.37.2
