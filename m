Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED063B241
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 20:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbiK1TaP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 14:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbiK1TaG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 14:30:06 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1092CC85
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 11:30:05 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ml11so3566691ejb.6
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 11:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQUa92xLDXtcofb3/NG/Eqz814eKmIgItrI0x4KT1rM=;
        b=obMFQlYRVDD5JEaZc6W877va/3DIaQIreyZ+vSoso1zQjiiTX1HoYAADaCjB0HcHeL
         R3Un0c7iqy5TNfLgruDP0ipfOGFDltUtAkFfY7arNqrwMZVYmWbcrLKwCJpoWR91O8XO
         i/ITCdpGljml8jn10KZ1PzYwJCjy8Y3C4SuDcs2yoToKz46WFbx5U7RmQr+pgfdjEhhV
         pFZMKR7e0HKQBXpq5IImDuOVSFv2WE5vm851deH+e76qZEkmV3EOf4OqKfh3ukx+qnZb
         r6V6Cnep++kK5OkZprye2eMWIK0ESdI1RuXdvNkHyYxdCxg8OQVUteOczXt0W07CB175
         yXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQUa92xLDXtcofb3/NG/Eqz814eKmIgItrI0x4KT1rM=;
        b=M65EUQskdodyqiO+ZUwgrqBfxV3EnVufL7nxFH/DDKL7EBYCFPTQWW0XA0Q9SiNIY4
         VuZq8rRDTPMcMfC0Qc/KHn17ddHU7GppcN46JS+wKTRgJco8X/HpgE8i5+tSN46zJ6Vp
         7SDbcyhbijDPUcH8ilBJY7cDMmEmmWmbZFZyHEqD34r5SBvgzjCfOdfP5S3C1X3nSFqt
         TXDPluTXgCZfvPOgV15hMoflQ0uj758bw7GBdAbqTPFzt5KSG3bBUTTTolKsr9HNpP7M
         63xzInj3Ftzdh5pl4SjIbsNwTLPmvwZ1GiKcvCnnCnjWuYHDsfmFUBQ+6s2tjCBLRhSG
         N+FA==
X-Gm-Message-State: ANoB5pmaXHvyGVdT4L/5nAWV4kzSxzrI62zILkpEpNnS/OTEbYHSB/Q6
        /rh+3E8eewcgxmHrDiMgORjSBMzuSZA=
X-Google-Smtp-Source: AA0mqf7RB/PRH5iCC/k5kjARWV69FXSleNdAgc6fqgKJbwAdt7gRb7YDKYuQYNrBDJP84meyRDNKjg==
X-Received: by 2002:a17:906:f281:b0:7ae:3b9e:1d8a with SMTP id gu1-20020a170906f28100b007ae3b9e1d8amr42917962ejb.581.1669663803601;
        Mon, 28 Nov 2022 11:30:03 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id la26-20020a170907781a00b007bed316a6d9sm2505898ejc.18.2022.11.28.11.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:30:03 -0800 (PST)
Message-ID: <adc5b63e-7d8d-d613-661d-579bb9f9fadb@gmail.com>
Date:   Mon, 28 Nov 2022 21:30:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v2 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <d3018e30-92c6-1e73-3b63-311fc472a41f@gmail.com>
In-Reply-To: <d3018e30-92c6-1e73-3b63-311fc472a41f@gmail.com>
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
v2:
 - Eliminate the magic numbers.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h      |  2 ++
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 11 ++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index d26df4095da0..9be53e0f25cc 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -1187,6 +1187,8 @@ enum rtl8xxxu_bw_mode {
 	RTL8XXXU_CHANNEL_WIDTH_MAX = 5,
 };
 
+#define RTL8XXXU_C2H_HDR_LEN	2 /* id and seq */
+
 struct rtl8723bu_c2h {
 	u8 id;
 	u8 seq;
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 28f136064297..352779fe4b78 100644
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
+				if (skb->len > RTL8XXXU_C2H_HDR_LEN +
+					       offsetof(typeof(c2h->ra_report), bw)) {
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
