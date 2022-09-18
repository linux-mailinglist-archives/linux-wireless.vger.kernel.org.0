Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7285BBDCA
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Sep 2022 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIRMfd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Sep 2022 08:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIRMfb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Sep 2022 08:35:31 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB221CB10
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:35:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so58806673ejc.1
        for <linux-wireless@vger.kernel.org>; Sun, 18 Sep 2022 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KdNtYmOhgy4JpuKmbZsSGmqyjkZ4AsuHlyD8960+62Q=;
        b=elQqZKFZ1wc6X7HM2yyklY+rbX29m5D+h9+IZTvJPRezFcotLmQ1LfXf4iFAx+SD5t
         odqhfOfqyAyDhJJuy07dna7/wIyqhHA+ojTAx4zPRB1OimccOQhOairYk6v2Viph7Gp6
         6VP9IzYXy/uDDOd65R6Cbl5NPfhvFiBINlBHtlvGK80AciwqX1uNxu24hHivP2fs9vf/
         U7BIuXZ7Zf0ipU6ouyzqsW+sVzSj/oN0jfcezhSVP+/bLz0+Ua9lCaJEiSoeVi5ZsFDN
         DaHUqdQBD8hn6xsttHYNpU/59N2AsVAMohLeNU47ypZtM+eJv3uSqIeOvD8XbRJAXmJp
         1/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KdNtYmOhgy4JpuKmbZsSGmqyjkZ4AsuHlyD8960+62Q=;
        b=3BdJ8ZlqBTZuoNw4QZG3l8gE9WxfMcWdVFqhv/QdzI4rByki3Il4z7MzytxjS2L8D6
         DmPZN/vHJMtLkQRLyjHCSRE2kuQHOjFUPO2NW5ixOFUY6CdsImg4soUf+Wp9RMB/xZiw
         KHhBI9fyxyHmNb5nRaJPReIZcArUA3CPcuc2pfpDnMqUIlo32hdWelmxYjXQ+LU/JqtE
         ZhZ2F1Nv9tsE8k69x6oPw9aK3wZzzSEyvw7vsEDDlaPhlxAiwUpyTarQbDn2iwhWj+/x
         P+PRjnQaES1kylRGnOyU0IYLo3KWHSxGhtgZ2+I1i/TBG5GV8bOt8IC1w4pB35+43tFL
         wjYw==
X-Gm-Message-State: ACrzQf1mjFdnj08GF6UM+vDn5Qus8vO4Pt0Oo4q1kgXl85pNpxfq813D
        /VISHA1si6XyQRrogdoCaSxfvQqEDJY=
X-Google-Smtp-Source: AMsMyM4qtodrqxiz2Zy9AanAKCztGDg8pQRnGr36dv/2kQ6FI7usRTBfkTcyb69xKsvJVKSdUDkBug==
X-Received: by 2002:a17:907:1de0:b0:770:8670:6a6a with SMTP id og32-20020a1709071de000b0077086706a6amr9873825ejc.588.1663504528673;
        Sun, 18 Sep 2022 05:35:28 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id t11-20020aa7d4cb000000b0044e8774914esm18287863edr.35.2022.09.18.05.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 05:35:28 -0700 (PDT)
Message-ID: <78cec57b-2678-acf3-99b3-271e0f9bdbad@gmail.com>
Date:   Sun, 18 Sep 2022 15:35:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: [PATCH 1/4] wifi: rtl8xxxu: gen2: Turn on the rate control
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     linux-wireless@vger.kernel.org
References: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>, chris.chiu@canonical.com
In-Reply-To: <56712d04-1505-2cbb-b6ac-3af4e73de108@gmail.com>
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

Inform the firmware when connecting to a network. This makes the
firmware enable the rate control, which makes the upload faster.

Don't inform the firmware when disconnecting from a network, because
that makes reconnecting impossible for some reason:

wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 1/3)
wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 2/3)
wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 3/3)
wlp0s20f0u3: authentication with 90:55:de:__:__:__ timed out

Not informing the firmware about disconnecting doesn't seem to have
any downside.

Tested only with RTL8188FU. Someone should test the other gen2 chips:
RTL8723BU and RTL8192EU.

Fixes: c59f13bbead4 ("rtl8xxxu: Work around issue with 8192eu and 8723bu devices not reconn…")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 32ab6ed5b9b6..7978d5dcc826 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4471,25 +4471,34 @@ void rtl8xxxu_gen1_report_connect(struct rtl8xxxu_priv *priv,
 void rtl8xxxu_gen2_report_connect(struct rtl8xxxu_priv *priv,
 				  u8 macid, bool connect)
 {
-#ifdef RTL8XXXU_GEN2_REPORT_CONNECT
 	/*
 	 * Barry Day reports this causes issues with 8192eu and 8723bu
 	 * devices reconnecting. The reason for this is unclear, but
 	 * until it is better understood, leave the code in place but
 	 * disabled, so it is not lost.
 	 */
+	/*
+	 * It also affects 8188FU. However, without this the rate control
+	 * is not on. Probably it only enables the rate control when it
+	 * knows it's connected to a network.
+	 *
+	 * Hack: don't report the disconnect. This way the rate control
+	 * is on and reconnecting also works. TODO Test 8192EU and 8723BU.
+	 */
 	struct h2c_cmd h2c;
 
 	memset(&h2c, 0, sizeof(struct h2c_cmd));
 
 	h2c.media_status_rpt.cmd = H2C_8723B_MEDIA_STATUS_RPT;
-	if (connect)
+	if (connect) {
 		h2c.media_status_rpt.parm |= BIT(0);
+	/*
 	else
 		h2c.media_status_rpt.parm &= ~BIT(0);
+	*/
 
-	rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
-#endif
+		rtl8xxxu_gen2_h2c_cmd(priv, &h2c, sizeof(h2c.media_status_rpt));
+	}
 }
 
 void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
-- 
2.37.2
