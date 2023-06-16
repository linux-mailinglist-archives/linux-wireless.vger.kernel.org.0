Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F867331D5
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 15:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbjFPNFu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 09:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjFPNFs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 09:05:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06B2D79
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 06:05:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9829b12b80fso98024266b.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 06:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686920745; x=1689512745;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shAEuzecm+bQ6fdyU+HQc3N1yAYO8DNoyiFo1ru18T8=;
        b=rzx1s1ahJ5jJEfseObGAGlqzvF32gBrbA/cplvp+K12LGBHI0FgORzS4vLRj4LqI0y
         NRnEaoFkrGWBRP+ADWqGBSqWBjXYRsNJB5jkPsCAmhLmSISRNrk1yNQuLtT6TujiGB6C
         U8PAsqxiy5oFsF48q4acyumM6jzTLib8uUTGB3zo8ssmj522tAZKDgG1XdDGqB+668gH
         u8TgWwXlVYtvmLcfn49hYE+JtOuta5iu5VzcQKgsy0ZS/chXHRxAjGsQpIa3eURZeTht
         FTXFDaS8Neae4AAl6kf+N64UcQKJa0GmV/oUARYFjWRGtzlHg5qtFh56I5Z7YLNjWUXB
         SDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686920745; x=1689512745;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=shAEuzecm+bQ6fdyU+HQc3N1yAYO8DNoyiFo1ru18T8=;
        b=G/inORFqBCxalMg8vQUi7jD8xgoIL46IWU0IQUPHhmPwXItyHMELbIlzIcDA0dPIXM
         IM9oNRIzikEXMkEyvCAP3BydrMwFNnvEfPXEqJq1gbXSMp0AlVzw8Xwqwuq6eAJnNfWl
         m3GqCjt7dYbJKgFQ/Oa0b22tgm5G8fU568T+hUM93OtDlU7yWqjCb4ZpQmc2UR8sozxQ
         nwTPIJJRYOHWWH5B//qJv3+AYM57VrBJN/fMy0qBcs07D7Ckf/ixRpsbMUCAqllLZ6T3
         wkNEQ2lIykNKf1Z8JRCAu6WAYTXg1ge5yPbKnxmggAz3uI3JB6M2NWOVBiY43HX9iOGB
         OZLQ==
X-Gm-Message-State: AC+VfDyAl5Np9IeGnroI6qsTB865iUtiB4gLDALjdFI3C5vrOv6VOPJ9
        ED2Yzws/rvCe3rLfw+PugQN4LhJyAQY=
X-Google-Smtp-Source: ACHHUZ6GQNc5iYxVoEo2MLVrigw2x+MT2n0kvmjRw9sNVTKAP1lib5O6m/EXyw5Gj9bbdIfM/GbJ6Q==
X-Received: by 2002:a17:907:3f29:b0:973:8cb7:4d81 with SMTP id hq41-20020a1709073f2900b009738cb74d81mr2598296ejc.49.1686920745152;
        Fri, 16 Jun 2023 06:05:45 -0700 (PDT)
Received: from shift.daheim (p200300d5ff125900aaa159fffeeb01f1.dip0.t-ipconnect.de. [2003:d5:ff12:5900:aaa1:59ff:feeb:1f1])
        by smtp.gmail.com with ESMTPSA id dk17-20020a170906f0d100b0097886843f75sm10905982ejb.177.2023.06.16.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 06:05:44 -0700 (PDT)
Received: from localhost ([127.0.0.1])
        by shift.daheim with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1qA995-0009bN-2y;
        Fri, 16 Jun 2023 15:05:43 +0200
Message-ID: <7cdadb5c-75d8-74ec-ca3a-11539878b55a@gmail.com>
Date:   Fri, 16 Jun 2023 15:05:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] wifi: p54: Add missing MODULE_FIRMWARE macro
Content-Language: de-DE, en-US
To:     Juerg Haefliger <juerg.haefliger@canonical.com>, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
References: <20230616121917.1034761-1-juerg.haefliger@canonical.com>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20230616121917.1034761-1-juerg.haefliger@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/16/23 14:19, Juerg Haefliger wrote:
> Add the missing MODULE_FIRMWARE macro for "3826.eeprom".
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Sure.

Acked-by: Christian Lamparter <chunkeey@gmail.com>

For people looking for the "3826.eeprom": Default values
are provided by p54spi_eeprom.h . But there's a MAC field
and antennas dbi values in there for customization.

Cheers,
Christian
> ---
>   drivers/net/wireless/intersil/p54/p54spi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
> index 19152fd449ba..ce0179b8ab36 100644
> --- a/drivers/net/wireless/intersil/p54/p54spi.c
> +++ b/drivers/net/wireless/intersil/p54/p54spi.c
> @@ -28,6 +28,7 @@
>   #endif /* CONFIG_P54_SPI_DEFAULT_EEPROM */
>   
>   MODULE_FIRMWARE("3826.arm");
> +MODULE_FIRMWARE("3826.eeprom");
>   
>   /* gpios should be handled in board files and provided via platform data,
>    * but because it's currently impossible for p54spi to have a header file

