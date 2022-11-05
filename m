Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263F161DA8A
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Nov 2022 14:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiKENQF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Nov 2022 09:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKENQE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Nov 2022 09:16:04 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582ACDEE0
        for <linux-wireless@vger.kernel.org>; Sat,  5 Nov 2022 06:16:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so19728361ejn.3
        for <linux-wireless@vger.kernel.org>; Sat, 05 Nov 2022 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/elDj5JY1kVbzZamSxer1alRcgi4lwen1qzSP+7Fh0=;
        b=mY7LmlcFn5k8wGTjT+eM/bwd9h4jVXYLPs+e41LYp5X3tGsozkOLPlAv+oQyxgIN/i
         rZDfr8v/tDNHxaLpQDrHiRBKipiIyOUgWpsAPyELwhPb7+kwpoH4z3TRhuQ/a1hFWlaL
         AWm+tr7qFzM7EiWn2ss8qLu6z8unQFL78QpL842JVgfmd3cP2kZ7bWTVJqwnDBZzUncA
         MiwYH5LHD8oBuQySxZI1ylj9PR3b9WoIkQ7xc2+ZONHyJ8yeuj9ZeaFrow3HdZ8u6ZSD
         NxPfT45pU/kBJtjWSDtcLVzd/S3G+VL5fY9c2o7ea53kHHai/NW617hhywmKKlbjg/td
         bBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/elDj5JY1kVbzZamSxer1alRcgi4lwen1qzSP+7Fh0=;
        b=YV2IpmWbK81ff1NMOo5osT2x8EN2mpVEz1iK5IEMW1Y9QFPqNF3r+qa2ZNpwGEGhVC
         LFCFY8gGgF4cZDfNJnv3ZzhxLeOejqXxekJ+fo0pcFI+/NR3qaHyvBJdz4FQSQ9a2Qu9
         wf3bDLhoYRT5iQAdR44EmeyLAQYfkNdhDkhPldTlznALdJ80WJJyCE7ZNQ7yjXM54/aG
         rnTfWEyz73qpe/TfLCx/l9Fhnw9izQxcErdp0z+klQUaHe78TK3coOo7rghu25G0EcqB
         +zhDYdX8g5DiGkKku0jGQ0MovoNU5QcJk4Hfn8r/lBLBm3BmWX9eJIEIwJVzE5Shb73g
         7/zg==
X-Gm-Message-State: ACrzQf02nAwayeXvPMxHBOLvXAtKlAqh/Whwglsw8l8NqRmQ8Lh6rJfY
        eZ5nS1WNBT1CD8SOtq7xq/LsEMdn/kA=
X-Google-Smtp-Source: AMsMyM5ysI/INtuVQsH7pGjilPEo7AsUWQpwrsdF7mTfxKjR/raEErIS/7ooHntDEsHgIKjx1wc6pw==
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id dd6-20020a1709069b8600b0073d72cf72afmr39912228ejc.440.1667654161921;
        Sat, 05 Nov 2022 06:16:01 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id q8-20020aa7da88000000b004619f024864sm1131399eds.81.2022.11.05.06.16.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Nov 2022 06:16:01 -0700 (PDT)
Message-ID: <3401bf94-c3b2-e764-0041-a4f1f3ed6795@gmail.com>
Date:   Sat, 5 Nov 2022 15:16:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: [PATCH 3/3] wifi: rtl8xxxu: Rename rtl8xxxu_8188f_channel_to_group
Content-Language: en-US
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>
References: <8d8ebf5f-54f0-8fae-1dc9-329d583852b9@gmail.com>
In-Reply-To: <8d8ebf5f-54f0-8fae-1dc9-329d583852b9@gmail.com>
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

This name is an anomaly. Change it to rtl8188f_channel_to_group to
follow the same pattern as the other functions.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 2d72390fe16f..ccb37a7beb91 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -352,7 +352,7 @@ static int rtl8188fu_identify_chip(struct rtl8xxxu_priv *priv)
 	return ret;
 }
 
-static void rtl8xxxu_8188f_channel_to_group(int channel, int *group, int *cck_group)
+static void rtl8188f_channel_to_group(int channel, int *group, int *cck_group)
 {
 	if (channel < 3)
 		*group = 0;
@@ -378,7 +378,7 @@ rtl8188f_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 	u8 cck, ofdmbase, mcsbase;
 	int group, cck_group;
 
-	rtl8xxxu_8188f_channel_to_group(channel, &group, &cck_group);
+	rtl8188f_channel_to_group(channel, &group, &cck_group);
 
 	cck = priv->cck_tx_power_index_A[cck_group];
 
-- 
2.38.0
