Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF606DED3F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 10:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDLIKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 04:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDLIJ7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 04:09:59 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905F54EE8
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 01:09:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j1-20020a05600c1c0100b003f04da00d07so1812070wms.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681286996; x=1683878996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BjT5693LkmeOVHrHrg9OFl3pKDlfUwb2i6dlVyPe8Wg=;
        b=tdBKKcdmp01gaZYDXIvgXSnxV9II/DFAawQdfYxVyl+az5hVPd3bDMP4gH5ui4Cvzq
         RV+mnkp+k3xhs3gQ15gDDa0WHcAnpVT+ta0PlpD3b2UKyPM+1OKUZlqOEA6twpBZ/2+8
         YdkbIDZkpjG84QEIVrFRllMy9ix/1cVrxqKF0OO22uQOi8NAwUXozAvqqBKPvHFJKXlZ
         IFHoqwI4wQsowCpZ5AQvD+jFvj8C3w8CKlfI758pyAXfre5bP0KWDai8Fb65tZxIXmhZ
         KocDZfxMd2s/lu3gBY0yPcdBQmeW3jLJfe5BeOtHcq76LRyKCjj8Qnq3B+yVTZbswffu
         Vecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681286996; x=1683878996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BjT5693LkmeOVHrHrg9OFl3pKDlfUwb2i6dlVyPe8Wg=;
        b=mu0F+dSKC1MGzUvS5/kvNJBb7uja4wbMEyZpL95xa04NG2bPQJ0HL31rtw+HMOTQdm
         H9CctWsr2zS0gcI3J1hnZRWgay5OVaZh+C17B1cMCl9qeG8FIc7keRgRMy8FoajRJGGs
         3v0NtnqoYuwo/tMpwpE7ys7Ujwf3eAxnOVQNiAu6ktP7E3+auDQOMSYDzkfbRnhRHJRk
         N8EdccyZMbcborbbq+LZJbohJ3jREkL+yk9MjGYHd2Vrn9VhDDX9/2cG19Sv4GYLL0mG
         Wf6S1bxIvInan1C0XQmIqCCqisF34Y8aQTRkTD2zpl9Fx6L/4zlkUMoqi3e/UFFM3hJa
         3eLQ==
X-Gm-Message-State: AAQBX9eRYRpx3bRxQw1TtfQkglUSBxEpovp1FZCJKACt2HH3CYmTa+5B
        EOZ/iO9ac21e8E823a99IyOfBA==
X-Google-Smtp-Source: AKy350YEJwPZniE8//TC7gfkFSg8rDT7jZzdpa2nzZHcJQswQl9dL4pvfJVhWbm2r87wR7iuz84LgA==
X-Received: by 2002:a7b:c413:0:b0:3f0:44d1:3ba7 with SMTP id k19-20020a7bc413000000b003f044d13ba7mr1192399wmi.17.1681286995926;
        Wed, 12 Apr 2023 01:09:55 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c2cad00b003ede2c4701dsm1480286wmc.14.2023.04.12.01.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:09:55 -0700 (PDT)
Message-ID: <eb0aab42-961e-a5c1-1898-dac2f8d89e50@baylibre.com>
Date:   Wed, 12 Apr 2023 10:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mt76: mt7921: fix kernel panic by accessing unallocated
 eeprom.data
Content-Language: en-US
To:     sean.wang@mediatek.com, nbd@nbd.name, lorenzo.bianconi@redhat.com
Cc:     Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, arowa@google.org,
        frankgor@google.com, kuabhs@google.com, druth@google.com,
        abhishekpandit@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <c9e2a44da4daa00166c802a8c10527359358219d.1681158440.git.objelf@gmail.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <c9e2a44da4daa00166c802a8c10527359358219d.1681158440.git.objelf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/04/2023 22:35, sean.wang@mediatek.com wrote:
> From: Sean Wang<sean.wang@mediatek.com>
> 
> The MT7921 driver no longer uses eeprom.data, but the relevant code has not
> been removed completely since
> commit 16d98b548365 ("mt76: mt7921: rely on mcu_get_nic_capability").
> This could result in potential invalid memory access.
> 
> To fix the kernel panic issue in mt7921, it is necessary to avoid accessing
> unallocated eeprom.data which can lead to invalid memory access.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

