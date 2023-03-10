Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551796B3F2B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Mar 2023 13:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjCJMbF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Mar 2023 07:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjCJMbE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Mar 2023 07:31:04 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C0F10A2B0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Mar 2023 04:31:03 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h14so4885168wru.4
        for <linux-wireless@vger.kernel.org>; Fri, 10 Mar 2023 04:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678451461;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHmh9/KAeLR+QkSExlMSfuIIFzq19c9+yEKUYVUea7k=;
        b=Uwcsj1jKL1jfwb7wr3qoHlpQbD6/wTigJnhA8Icj/ATb7twMB1MSffb/Ku4hMRsd+F
         ghF9oMTWzKkpcQObxObet2yHJE4o1NQ2D4pMXu5Kcfcz/6DdUIicoinyz+2ftOQ8o3pE
         A2oegZYcOpZha1fhdbzI2wcsxPUhQ9CzBz720ieUafTmji6EG6qZYbWUquwNWXgUDi01
         2q4oCl0jGTeQHbQQwWG9DS6Smw/prg6wger+T3Kstgl/25FO9nHtRgOHG80CP7phRd4Y
         os8d0hdVk9yNKcGeFxzTq6yJyCt64OayWsZBBpnrWEKHnyh+wx/RXT9khLPsbvD9GIhq
         SZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678451461;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHmh9/KAeLR+QkSExlMSfuIIFzq19c9+yEKUYVUea7k=;
        b=A+RloIJz6axmmfr9WYYr8OoqdsuGDsEx9nvtYnJzZqlNsnaMV4a0qWh/y5jbiqX4nR
         9v9SN72Z8JmeXNIomgqk3s2adgEdrqfb8pJKCJeQtsMmmGiLoBJxlmQqWQ1Ng/LnhQ8x
         oSK+h45nMvWl+B6j1ifah44+gMpP8F1slxTYYdqNhMW6jTrlIpAGig+7kwmnyHzIdk4D
         CO+ETHY4A9+lwdHX+LdeSMbK1yqs8gUH1ip8e3btZgbz7Wi3gYbdPkQAt0vYG8kELsui
         7Q+pr4qifGDPcXB1qNMXkWsCTXbzy/vaB0FI2/Vp8EzTZQ8vGO9xWTqdGkvo16uJhyqQ
         pPQg==
X-Gm-Message-State: AO0yUKV+t9x9Gnh5OuSXMVsc8f+sWG0Ah67O2k2vlrMMpuFBuQRNSgAf
        hkFOKuHa1MQuV4PZFgfT0Lk=
X-Google-Smtp-Source: AK7set9tzRfuCZUqRAMdi+w4jL2lrSkS1/hJxVr+5CmcKoget2SakVfOQDTpjTzGQxLho60MvRDDYg==
X-Received: by 2002:adf:ff87:0:b0:2c9:a8c7:b48d with SMTP id j7-20020adfff87000000b002c9a8c7b48dmr15074665wrr.10.1678451461613;
        Fri, 10 Mar 2023 04:31:01 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b002c54e26bca5sm2016043wri.49.2023.03.10.04.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:31:01 -0800 (PST)
Date:   Fri, 10 Mar 2023 15:30:58 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     marcan@marcan.st
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: [bug report] wifi: brcmfmac: cfg80211: Add support for scan params v2
Message-ID: <cfc9e588-67a4-4cba-a792-e8e032cc0498@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Hector Martin,

The patch 398ce273d6b1: "wifi: brcmfmac: cfg80211: Add support for
scan params v2" from Feb 14, 2023, leads to the following Smatch
static checker warning:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1459 brcmf_run_escan() error: potential null dereference 'params_v1'.  (kzalloc returns null)
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:4319 brcmf_pmksa_v3_op() error: potential null dereference 'pmk_op'.  (kzalloc returns null)

drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
    1451         params->version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION_V2);
    1452 
    1453         if (!brcmf_feat_is_enabled(ifp, BRCMF_FEAT_SCAN_V2)) {
    1454                 struct brcmf_escan_params_le *params_v1;
    1455 
    1456                 params_size -= BRCMF_SCAN_PARAMS_V2_FIXED_SIZE;
    1457                 params_size += BRCMF_SCAN_PARAMS_FIXED_SIZE;
    1458                 params_v1 = kzalloc(params_size, GFP_KERNEL);

kzalloc() needs a check for failure.

--> 1459                 params_v1->version = cpu_to_le32(BRCMF_ESCAN_REQ_VERSION);
    1460                 brcmf_scan_params_v2_to_v1(&params->params_v2_le, &params_v1->params_le);
    1461                 kfree(params);
    1462                 params = params_v1;
    1463         }
    1464 
    1465         params->action = cpu_to_le16(WL_ESCAN_ACTION_START);
    1466         params->sync_id = cpu_to_le16(0x1234);
    1467 
    1468         err = brcmf_fil_iovar_data_set(ifp, "escan", params, params_size);
    1469         if (err) {
    1470                 if (err == -EBUSY)
    1471                         brcmf_dbg(INFO, "system busy : escan canceled\n");
    1472                 else
    1473                         bphy_err(drvr, "error (%d)\n", err);
    1474         }
    1475 
    1476         kfree(params);
    1477 exit:
    1478         return err;
    1479 }

regards,
dan carpenter
