Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CFF63C7C1
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 20:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbiK2TG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 14:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbiK2TGZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 14:06:25 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2181B28F
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 11:06:24 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n20so36210513ejh.0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIsv3FNKXbmn1ZiV9cEXAumjRE9U/5PO6zKLBJYdikI=;
        b=Pcr29i9RvOKqzR93gDb4J2t7XoUP4KUqWPdq8fnGPPoiF6+2NA6iUFLOdceHllqcNT
         DWiWA5YCIl2T11WeBbqX0iRXlCcNpOq8YXJEpJUdP5UldofSh7fKU4GA2hiPIJYb2t73
         YMONHcqYFm1fylX+G1qzPgkN0iM1u+Cm7vuzJQ+CJsPtFGqjQzp5pxBeDODOQRObacU5
         p2BD3l7jBXbBNCOrtpWRp31CZ5FABQnc0v5GcYagwDtGtXGlVthnAgJ8MEmleBaBJ+XY
         tMHswWPLU7gPIdQnN2TeP0eewMz48PwsbDtac0QqC7jTryWlHbIAyyZtrCh4mdS49xlw
         hejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIsv3FNKXbmn1ZiV9cEXAumjRE9U/5PO6zKLBJYdikI=;
        b=HghXMADdeW59PjNILfcBKH9dED6Aon0J1jcR63SM6W4IJq1UfWxpFiF8Y/iEI5danB
         mX627lkZMpQZwpWETH1x+HXEk7HfQWIsjAqOmKbbzDb2Op8pSYYmcCGfVz7ZqydhTacS
         n54jz8cpD9XmNgdlfQOjcKA6m5Kg49uRE4rV+6fvfe7GzMJN8b48xqV9HRD9lFwgINjF
         ArdgkgrHIlHQnd9N5LUUPrhAMhR9j1N7e/46xUm/V8LktcCiAgSd5B5GdtSkq7Hs/8Ba
         QKpGwU/JzsR9E3GnCEtK8NhBaJoxyR63KqNwHdTq4Ngw5YAym2kWqtlq51NkDp0I8DZ0
         y/9w==
X-Gm-Message-State: ANoB5pm5etT+nRA2Y4Vaz7iTDEYjDJNGhh+yWmXKkMq3pu5fcsm4d3tg
        eAc7N4bId+J44TQBVsR7KAjUCOmS9rE=
X-Google-Smtp-Source: AA0mqf5NO2UsllptvQc34NkE75X/TRdWfqkJF7NploSKFLd/f27hmvxZhU4O+EYOgG473/NircaHog==
X-Received: by 2002:a17:906:8994:b0:7ae:ea4:583c with SMTP id gg20-20020a170906899400b007ae0ea4583cmr49103337ejc.587.1669748782705;
        Tue, 29 Nov 2022 11:06:22 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b007a9c3831409sm6415447ejb.137.2022.11.29.11.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 11:06:22 -0800 (PST)
Message-ID: <aa0afff7-eccd-eac6-9b0d-6d5e94fb2c06@gmail.com>
Date:   Tue, 29 Nov 2022 21:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <ba821a9d-af25-3ade-9fa8-0d3f4b58aec5@gmail.com>
In-Reply-To: <ba821a9d-af25-3ade-9fa8-0d3f4b58aec5@gmail.com>
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

The gen 2 chips RTL8192EU and RTL8188FU periodically send the driver
reports about the TX rate, and the driver passes these reports to
sta_statistics. The reports from RTL8192EU may or may not include the
channel width. The reports from RTL8188FU do not include it.

Only access the c2h->ra_report.bw field if the report (skb) is big
enough.

The other problem fixed here is that the code was actually never
changing the channel width initially reported by
rtl8xxxu_bss_info_changed because the value of RATE_INFO_BW_20 is 0.

Fixes: 0985d3a410ac ("rtl8xxxu: Feed current txrate information for mac80211")
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - Don't assume bw will always be 1 byte.
 
v2:
 - Eliminate the magic numbers.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 28f136064297..9799bc5ed60a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5569,7 +5569,6 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 			rarpt->txrate.flags = 0;
 			rate = c2h->ra_report.rate;
 			sgi = c2h->ra_report.sgi;
-			bw = c2h->ra_report.bw;
 
 			if (rate < DESC_RATE_MCS0) {
 				rarpt->txrate.legacy =
@@ -5586,8 +5585,14 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 						RATE_INFO_FLAGS_SHORT_GI;
 				}
 
-				if (bw == RATE_INFO_BW_20)
-					rarpt->txrate.bw |= RATE_INFO_BW_20;
+				if (skb->len >= offsetof(typeof(*c2h), ra_report.bw) +
+						sizeof(c2h->ra_report.bw)) {
+					if (c2h->ra_report.bw == RTL8XXXU_CHANNEL_WIDTH_40)
+						bw = RATE_INFO_BW_40;
+					else
+						bw = RATE_INFO_BW_20;
+					rarpt->txrate.bw = bw;
+				}
 			}
 			bit_rate = cfg80211_calculate_bitrate(&rarpt->txrate);
 			rarpt->bit_rate = bit_rate;
-- 
2.38.0
