Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D856F4A53
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 21:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEBT1v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 May 2023 15:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEBT1t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 May 2023 15:27:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD2E1BF9
        for <linux-wireless@vger.kernel.org>; Tue,  2 May 2023 12:27:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f6c285d92so830237266b.3
        for <linux-wireless@vger.kernel.org>; Tue, 02 May 2023 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683055667; x=1685647667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwyuMAFYq27hGp5u9hIVI5Ry/hLhKys8+auDfUI9QPA=;
        b=ezrMsR6kfxOplSKSkvfNO03UTWTOMgX4fpaT8LHkWP9fPsM9t5A2a1kdJWL/7kM3uA
         /31GsU2zP2VA8kpcxo4/yUI41jPd/c9ZjvBeEsQLABinBSrhCmv568wkDziPldFNpZ2n
         aYJGJZO8faiYfgIsDgaJRGw/lXuPnrI2BcWByfRs865sb3UIsOR0ajKRr8N2vn5lBrmd
         oXnJwrVtY+7aXZLnwJ+EsUKU0ux9Rz9s9awHOzlV0Z2ZfJAzHB4BXT8FNbGOTEQ3fslo
         MEWYodjCaTyjNOwn2hgJRe2cqVPMf0AVVHLtiwD6yre/HLrF4vwFN+RF80Lk+szudjQb
         1EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683055667; x=1685647667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwyuMAFYq27hGp5u9hIVI5Ry/hLhKys8+auDfUI9QPA=;
        b=dRl4tOQiACWSxck2kyR3ria/ymkHkCABQ1VjOALSUDgXU7XWNZ05KOnA7lvvQ3el/F
         qo46wzUOw7qS/LcGph4Ld+CDO4SaVtY2BcAEBA6VpZncoelKpmIzPa3UXCCh9VmaIfoV
         KDfeyJesvSa8F40bX4ZB6JNkA8nnDgvUeBnhTdlKnCJ4yxCsjUX8uzatEN/ejkhpIHos
         WdEXULpFGNrlL4LK7NATrl96C0pHsC+R51ei2hXKO8mWJ908oDgsTlp0+FuPL5uLF6UI
         OX25ZSdPAfHlsv63AfQP3sXMOK46VBDkZOJzrMtaHem7Pbsgo3RuOs/PKVmBAnizjuw0
         w5aA==
X-Gm-Message-State: AC+VfDw5pAiWk5vjDCY5SJ6+t/1RuXwGbQVcghE7Me2fiBveolNmCdJ0
        Ujb/cndmaKcb7dZ5GjUD0BmKdyayWxFM/Dnc
X-Google-Smtp-Source: ACHHUZ4WGnCZhuyXeH30M8nXjOzM9AuY7NdKHlDwPaB787eZkSoUq6GCtApPuHpe6vwn2gA/8BobyA==
X-Received: by 2002:a17:907:608b:b0:88f:a236:69e6 with SMTP id ht11-20020a170907608b00b0088fa23669e6mr932565ejc.7.1683055666690;
        Tue, 02 May 2023 12:27:46 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id lc21-20020a170906dff500b0094ef10eceb3sm16260585ejc.185.2023.05.02.12.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 12:27:46 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: Driver for rtw8723ds
Date:   Tue, 02 May 2023 21:27:45 +0200
Message-ID: <5930608.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

/cc Martin

Dne nedelja, 30. april 2023 ob 18:51:15 CEST je Larry Finger napisal(a):
> Jernej,
> 
> Is there a reason that the driver for RTW8723DS was not included along with
> the other SDIO versions in rtw88?

We have no HW to test.

> 
> I have a user of one of my GitHub repos that uses this device.

Can you ask that user to test following commits?
https://github.com/xdarklight/linux/commit/
3866a7a3702f7f24557f2c065b7d4088f7027466
https://github.com/xdarklight/linux/commit/
66fd078556a6bf246337270b2e91d73c079fce2d

Patches are trivial, but some testing needs to be done to confirm the driver 
actually works as intended.

Best regards,
Jernej

> 
> Thanks,
> 
> Larry




