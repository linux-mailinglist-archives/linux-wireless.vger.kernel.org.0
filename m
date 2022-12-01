Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E863F26F
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 15:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLAOPN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 09:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiLAOPM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 09:15:12 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860D9AC19D
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 06:15:11 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b2so4504811eja.7
        for <linux-wireless@vger.kernel.org>; Thu, 01 Dec 2022 06:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSZ94s+QaNvY6jxnG+UIbHxcBW6vYxNV9Ku2eR9SMas=;
        b=I89LXcBKEf36dQ9tacYbuaD6/2Hyh27/Lq7lcJ8DGmsMYlgdIWHWqu8yJlNYXg47jB
         ADCNUqZiyYf4sDgOLn8eHBV+2XFfmcln6vXBWeRa55TprfGc/NrZB7ENUVZGvm99Hiej
         YiqvyAi1UnCaVjPYxN3YK79cteXFckUpsqwwEre9eMMUuMPiSDOFjJyotc9MJlFyswZs
         VrZz4WMb6breSrGirRQ5La6IfV41/SHIm0UObiIoj50veu3LlUhcJGGkO1pivHaEBq2+
         7ZNq/rkCSK5rIoCqKjVpHOVJnpDFhzibhuj3J/jsgyLpZ+6a7o/kmcrMR6Pm8aJ1/nmE
         g0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSZ94s+QaNvY6jxnG+UIbHxcBW6vYxNV9Ku2eR9SMas=;
        b=s7HsrcLjNRQCPbbWcf65GuJC4wRPtqMHkumPXzaexlKeZ84yLt22oSFPCluXe35M1o
         JkAs7KBuYYfHWPZQZtxHBkSt+CwpOhhfy8qzHjzEPJtpw02alhtQfnDNeBNcbziZ6H62
         XfZk1CazOheH55loGK0UZgHPZhT60bPoNfXcmVxfoSBOwNTXdlmxBD0qUu045n4XGEjS
         dCezp81NxIbPv7grtor5IrY2GovrbpFm1Ula8MDRma34sISDKrGjfQ1dFptPxSYoCVK4
         DO6ChoTiI8e/IGvEY+m8pj6xPdjUmDgLW2PHBC3ykB/GcYcoyTZTOEsnt9CcA712/TPD
         ENlw==
X-Gm-Message-State: ANoB5pnM7M4bObZxEXsz8C2bdky83IlNrSIGQjJq4H9ocfDZXfTrlMll
        JEDyvPaLz1g7gvvWihO6yzsI6yIsQWI=
X-Google-Smtp-Source: AA0mqf6/4LwwWT87ji3K1xQfjEPtkV98NPt6xs18FQxc3Q/5Tj57/QLkQ9oUMTg/RTKDv0vStYYt9A==
X-Received: by 2002:a17:906:8465:b0:7bd:7253:457a with SMTP id hx5-20020a170906846500b007bd7253457amr2129091ejc.81.1669904110057;
        Thu, 01 Dec 2022 06:15:10 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.254])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402074400b0046267f8150csm1782324edy.19.2022.12.01.06.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:15:09 -0800 (PST)
Message-ID: <5b41f1ae-72e7-6b7a-2459-b736399a1c40@gmail.com>
Date:   Thu, 1 Dec 2022 16:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v4 2/3] wifi: rtl8xxxu: Fix the channel width reporting
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
References: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
In-Reply-To: <1a270918-da22-ff5f-29fc-7855f740c5ba@gmail.com>
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
v4:
 - Use the more convenient offsetofend macro.
 
v3:
 - Don't assume bw will always be 1 byte.
 
v2:
 - Eliminate the magic numbers.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 28f136064297..7ca46fb77a3b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5569,7 +5569,6 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 			rarpt->txrate.flags = 0;
 			rate = c2h->ra_report.rate;
 			sgi = c2h->ra_report.sgi;
-			bw = c2h->ra_report.bw;
 
 			if (rate < DESC_RATE_MCS0) {
 				rarpt->txrate.legacy =
@@ -5586,8 +5585,13 @@ static void rtl8xxxu_c2hcmd_callback(struct work_struct *work)
 						RATE_INFO_FLAGS_SHORT_GI;
 				}
 
-				if (bw == RATE_INFO_BW_20)
-					rarpt->txrate.bw |= RATE_INFO_BW_20;
+				if (skb->len >= offsetofend(typeof(*c2h), ra_report.bw)) {
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
