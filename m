Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727EF6A7681
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Mar 2023 22:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCAV5N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Mar 2023 16:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCAV5M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Mar 2023 16:57:12 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6DC2F7B0
        for <linux-wireless@vger.kernel.org>; Wed,  1 Mar 2023 13:57:06 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-172a623ad9aso16022993fac.13
        for <linux-wireless@vger.kernel.org>; Wed, 01 Mar 2023 13:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677707825;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZksZDm4c8Z9A4r9O+UEC2Yx1wXH1S521LD/PG4iUTYo=;
        b=hzJelyTeTyOyJjhEdCJ7a2w3NvlROO46KfHyrPtPIeCIKwH/A2UkwP1bM4niAw0ctK
         cGbI+QzNnMIseCe8qyuL62wWAANJKGTteq9m4w434tii4M4z0FrdNlJhGE5gBFMWKxr4
         /pRmrGd3s//i5ZwpUq2deyl2ee1GlVaZoziOLE8Ers3boUL4zHQKyiRc3g02ah+5erpI
         z4UDoqoHKMQ9rXq0wuAJdf/28qIbQ+GuVE3ePGOX1ItmdZ6HX8ihIxlU0SXbIw7O+Bv5
         22fq3vnuosVIlRuZU6zJxDDaBkD/62RBLoxyz2PvKHOwDAqR0Lh3SJJ0ab8vrA6LrWUn
         4Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677707825;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZksZDm4c8Z9A4r9O+UEC2Yx1wXH1S521LD/PG4iUTYo=;
        b=xukGU4WZwIdPBA/Ruun8krLRgFO3ke9GHKTlhqkqDLDQjEijg9A9lCJenN7FvAthbp
         beeG3R4/7LiMU/AeDY33f7r8Y7h95aCM7hIWvn7+ppXZ8KajWEqwMaqhwn7+ccTc3QM5
         sWsGGaXXx7hIZQi7INznpxqepjf9YBPQ7F449QsOEPeDDL8nGuAHRODMLBcqa6vpoaTh
         UU5ibXp7w8GoeWxfgrSFcLTGZYaQShSMChszS/XHrC8W/K1XKxV3M6I+yv7NfvJSBGGN
         VkUfXDDKotjQDUxfwgDPvkpxqJZFNkI1SvmRUwuk99KAova1H4gyujUMJmBOpFXbZ62o
         KSWA==
X-Gm-Message-State: AO0yUKVgk0dqIIoJnOQ6a39Yny1liphgvufFEIZ9N4V5VSkVGIgwyQoE
        G0NpMnSczwYLyQVL9z/I2s0St9f+tR8=
X-Google-Smtp-Source: AK7set+/2uWevTOISSZJElQOzSRx477sl1Gj9QK1trDr3urTopJ35pp6NOSRu74Yq8zhoNCFCf0sgQ==
X-Received: by 2002:a05:6871:b13:b0:172:bab0:ee30 with SMTP id fq19-20020a0568710b1300b00172bab0ee30mr4857614oab.32.1677707825357;
        Wed, 01 Mar 2023 13:57:05 -0800 (PST)
Received: from [192.168.7.168] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id b3-20020a056870918300b0017281100b75sm4768005oaf.42.2023.03.01.13.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 13:57:05 -0800 (PST)
Message-ID: <ee614c10-cfd7-de88-3f85-6448aaa17c5a@gmail.com>
Date:   Wed, 1 Mar 2023 15:57:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     linux-wireless@vger.kernel.org
Cc:     pkshih@realtek.com, neojou@gmail.com, s.hauer@pengutronix.de
From:   "Alex G." <mr.nuke.me@gmail.com>
Subject: Issues with rtw88_8821cu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'm seeing some issues with a BrosTrend AC650 adapter (rtw88_8821cu). I 
have all the recent fixes, up to and including commit 4a267bc5ea8f 
("wifi: rtw88: use RTW_FLAG_POWERON flag to prevent to power on/off twice").

1)   rtw_8821cu 1-3:1.0: Firmware version 24.11.0, H2C version 12
     rtw_8821cu 1-3:1.0: failed to download firmware
     rtw_8821cu 1-3:1.0: failed to setup chip efuse info
     rtw_8821cu 1-3:1.0: failed to setup chip information

This first issue is related to USB errors. Generally, it starts with the 
"failed to download firmware" followed by an assortment of other "failed 
to" messages. At this point the adapter may show up in iw, but is 
unusable until unplugged and replugged.

2) The second issue is unusably low Rx signal levels on the 2.4 GHz 
bands. The scan results report about 30dB to 50dB lower than adjacent 
adapters. That's if the 8821cu can even detect the beacons.

3) The third issue is that, in IBSS mode, the adapter cannot receive any 
packets or see adjacent IBSS nodes.
	iw <wlanx> station dump
shows no results, unless also running a scan. Even so, ifconfig shows 0 
Rx packets, and the adapter is not able to receive. This happens in 
either noHT, HT20, or HT40 modes.


Where do I begin getting these running?

Alex
