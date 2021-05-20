Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95538A29C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 May 2021 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhETJn3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbhETJl2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 05:41:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEB4C0611CB;
        Thu, 20 May 2021 02:29:53 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso4686211wmc.1;
        Thu, 20 May 2021 02:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0cGf1aBFrVZ9AWx/JMeJaEcovPhb2SGzpzNb2QM+Nk0=;
        b=uHOB9zSLOzNOqCaCdv3tAd2rduYeX+Y6HLl91ACEXI0mAiipvTrz62XOO2SaIgoVty
         Pf+RMtbo6f9V42RwSERPXTfjWo95E9cFtuWO9WKA3FnlyXzYA2sixDVebOmpsiGxbbrs
         9H75RMmiqXRnaSuCiHDHAfG1oZEYV+e0kFKI3et7gI5qVSablXEgzMq74sy11W+OVSBg
         fv7UHDUKttjvUQS8McyFbz5R9rRxXKz5CWcwkYd/YNSYTQwhvZ8bx4KdaLHqPOOdvH9T
         sB+YUNNslLh91vbqAYFcpIySpJbri7dhqbJjx3hah4/GEvkwzv8dQ2huIVBDg0fLwNfN
         LmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0cGf1aBFrVZ9AWx/JMeJaEcovPhb2SGzpzNb2QM+Nk0=;
        b=b241yx4hf56L3tEHKBQhrGCfw5ivFN1cjGHJyZbq0u25yRJ45G588C23bUBsHe4/Tr
         To5G0q1Yh/rS0KVsRK4ujsrJmcwnKrd4UI1NMmipIxHuiiGnz7rpkFDmJg52F0+QNqn7
         +Oc8VkiDcmWpsXHaa9jlBKja/Ige0pioOntrjCVS3SPruE1R0gVgwREswpTUoCtf/9va
         MMZK7I2l7JHcuD/q/IXd/03nPxWnadsAuYko+CixmXvw/LZhDbTc8ZX44G4XTaERhGwP
         pvUzV/NrcL80fNn0j4AmGX5rbQoaLj9Jr+8E0TiOaBljnJBcycE8K9sHD1Bz2oI6I/PP
         k+Vw==
X-Gm-Message-State: AOAM533utA1yRr3PAzH1zVJ+8yjKg9Ut4UcV7j9XSyEYvG5h5QFbyBod
        PB45V9Om1zDF3VeN4VMutHM=
X-Google-Smtp-Source: ABdhPJyzQVEd0/LMaL/vCBhQFOWm/v6djjo0ZDbNWBjNqUGvVSd07eOXBWJMelsuPcjU1JJMY/FRXA==
X-Received: by 2002:a7b:ce0f:: with SMTP id m15mr3040219wmc.55.1621502991917;
        Thu, 20 May 2021 02:29:51 -0700 (PDT)
Received: from agape.jhs ([5.171.80.207])
        by smtp.gmail.com with ESMTPSA id x2sm2018708wmj.3.2021.05.20.02.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 02:29:51 -0700 (PDT)
Date:   Thu, 20 May 2021 11:29:49 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     hdegoede@redhat.com, Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: staging: rtl8723bs: removal of 5G code
Message-ID: <20210520092946.GA1404@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

I'm stick with removal of 5Ghz code from rtl8723bs wireless card driver
(in staging subsystem).

I think that this task comprehend deletion of all code managing
80Mhz bandwidth and upper bandwidth (160 and 80+80). For the latter
it's simple, there's quite no code (unused enums and obsolete comments).

The former seems to be trickier, there are handlers like this:

        /* 3 Set Reg483 */
        SubChnlNum = phy_GetSecondaryChnl_8723B(Adapter);
        rtw_write8(Adapter, REG_DATA_SC_8723B, SubChnlNum);

phy_GetSecondaryChnl_8723B() contains code like:

        } else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
                if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
                        SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
                else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
                        SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
        }

so if we are on a 40M channel some settings involving 80M are made and
the whole is then written on card registers.

May I get rid of the whole? Are there some implications I should be aware of?
Is secondary channel needed if we are on 40M bandwidth?

Thank you in advance,

fabio
