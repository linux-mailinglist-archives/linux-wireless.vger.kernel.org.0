Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC596117AA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Oct 2022 18:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJ1Qiu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Oct 2022 12:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ1Qir (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Oct 2022 12:38:47 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC420882A
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 09:38:46 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f27so14252525eje.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Oct 2022 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Vrc6plb0e5u/Fwr/zcNr43BHXvx4XVliYTRalbAfM8=;
        b=kRd1wf0hkJfe784Ud8vi6qYPgPavsyzMKBQUNmRULwApz69fQht8/PXoqAPVqknckH
         vInkF/T0eJ0NsxwHN6OB4ADkq8F7hT2b4BZb+XDtK52YyvwpRGKdhZM4V5RFQa5c27zf
         MefIDXPYE51pm505gB3nYC5Fgesbja8aCQVmWb+SaDTNNAZnN6XSAcxKq0o+8JcZLTU9
         +JAU9I/ak2ZtqIp7Rv4wOsycMTD2dq+754dvKIarJvnylf/BSaENFQzVyb5Y4GnQspTV
         gKvNORJ0ZpCBdP7wyA51J6zv8HZSplxOKpkjcn0MBtsQ82nBoVH4Z3FQ0Zh/+5qDMK4S
         7oNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Vrc6plb0e5u/Fwr/zcNr43BHXvx4XVliYTRalbAfM8=;
        b=5DfOTzoA3eDqp9EneczRkuCkEf/rk4jJbb0u+lHSzmnMuIOZ0UaGotXCIIJM5qNthp
         xcfL5jfq31eWa79WSRRzWEvcxABlYiw3Ci4umPcwtJYX9Rk2MrEaZDstf3rRhioSIC6z
         JODmUI4L4UjhQzuAJdXP6hvDcSICR5DYuC3/4K0NXklGmrFS1bm6olmkybfhlFvxC7jy
         XcYC4wq2ipq1oBzB1DeLXGisJrWe2qEHWXYmFwsR51vJIqROq6l0GYRI4LMEu1kZGrwr
         8kezEEr2sN82ihvf+L2SNAJw3G+JZB/s4uIJ3aUPpr2YHpKCZvJ5CTGQjnTkTptO9iCC
         0b3g==
X-Gm-Message-State: ACrzQf2DWKOFzY5k5d1Uxrf+F1qAy8MN+UoZVHBJFFuLgVq91vRUDMRF
        vsLHWcD3iOTlSbKljALBcn4Y8RUG4po=
X-Google-Smtp-Source: AMsMyM7JNqd44RKcIq1CHIkb4g4TampXfvMHW4ARd5ufctxSb243pG3yEd61VlsQYmzBCKNqzkVwrA==
X-Received: by 2002:a17:906:8a48:b0:7ad:aaee:cbec with SMTP id gx8-20020a1709068a4800b007adaaeecbecmr227097ejc.36.1666975125412;
        Fri, 28 Oct 2022 09:38:45 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id eg22-20020a056402289600b0044e937ddcabsm2918684edb.77.2022.10.28.09.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 09:38:44 -0700 (PDT)
Message-ID: <fd9bec2a-466c-4670-068f-e2aea101f2de@gmail.com>
Date:   Fri, 28 Oct 2022 19:38:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH v3 4/5] wifi: rtl8xxxu: Set IEEE80211_HW_SUPPORT_FAST_XMIT
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
In-Reply-To: <d1cfc9ef-dfc1-b3dc-c471-fe18aee8962e@gmail.com>
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
v3:
 - No change.
 
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 64062f18a5a0..57800c3575b4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -7005,6 +7005,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	 * The firmware handles rate control
 	 */
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORT_FAST_XMIT);
 	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
-- 
2.38.0
