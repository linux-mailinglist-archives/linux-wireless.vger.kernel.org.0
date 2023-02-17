Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D2469B2BB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 19:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBQS5H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 13:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQS5H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 13:57:07 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203B65FF4
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 10:57:06 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j20so9377158edw.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZK4iMZWPcfp2djDH5P0nJB7FnClrPgur4nJbLfogCk=;
        b=bZkI+ZDXWkrlkum6pG5qrsYh7zAUJjViKF2N+coifZDNAFQzSmAVvKwhtyyithADh/
         gSFcZmiDFt+BdovUlm1Y8dEFajX597ZLDRdjmAvuKM0VL/B7wpuZJlzYI9Ev3P4sXXEw
         UGqFjvhk9PZBgTa3sxKf7qR++cefhVBacAGf1APiD4/fAKXnlnVdyjRMh6IqPkNS2DQm
         ANSF8l79YXWYKzq0kvW60KEVoRRbOjNHNYEPka3FWGaThfWqCPU2/rr1R3vmrvGqfDHH
         VnoaZqCNB1Wg/bL+bfOw2N1KlxA1DasnWSFx17kcjWKlf3OqaGWGS++BU/QxDULbV4Q1
         psbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZK4iMZWPcfp2djDH5P0nJB7FnClrPgur4nJbLfogCk=;
        b=qgnNgYJTWmH70gbLH37INomFBNyBPGV4CaRfOPclOSoKeETh72GjdMCNDKQT/lciNU
         vDiK3kjcwEWDxaA4XtXRGXzoG/1lWaifnYC+VezuhrgHlOallS0BCKXNNPsgiSBrFJ4C
         Lnrw9APCbax1K1Os2OXtXUJbS6zOReQQbTksSDIdSwtctd6CkPqW6aSBCgwfP5+n6ydJ
         1Ayl/zaJBHoavggeFd1/1rHMWGi220fsdl3Y80Qewy9Zmm3gAfEhEVDa05abnmHsVXWW
         JTjS2U7DcKc5F1Hhmpp0mPcfGY0CW04/ta8cGhRp3rbqd8rkcPt5vwyXrbq7MDKVMpa1
         enWQ==
X-Gm-Message-State: AO0yUKUfvtzrrKN280d6MTYmQoEl4PnLe/d0Mjn6+PqurBEIKugMgxFW
        vmm/ibvvS+jcZEWBWNTb+6SME/OhFig=
X-Google-Smtp-Source: AK7set+b4J0inl8B8lYw3XAZ1JbIGLoKK4Xzv7T394iQRyeJB1n7MeyI1/ZTlH5SwHtulf0MrhSxEA==
X-Received: by 2002:aa7:da8c:0:b0:4a2:6573:5c35 with SMTP id q12-20020aa7da8c000000b004a265735c35mr2463967eds.21.1676660224484;
        Fri, 17 Feb 2023 10:57:04 -0800 (PST)
Received: from shift (pd9e2966a.dip0.t-ipconnect.de. [217.226.150.106])
        by smtp.gmail.com with ESMTPSA id j17-20020a508a91000000b004a21c9facd5sm2659347edj.67.2023.02.17.10.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 10:57:04 -0800 (PST)
Received: from localhost ([127.0.0.1])
        by shift with esmtp (Exim 4.96)
        (envelope-from <chunkeey@gmail.com>)
        id 1pT5s1-000HLD-2b;
        Fri, 17 Feb 2023 19:57:03 +0100
Message-ID: <c9ccbfe1-9535-f46c-756e-4eb19c1afbff@gmail.com>
Date:   Fri, 17 Feb 2023 19:57:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20230215
Content-Language: de-DE
To:     Kalle Valo <kvalo@kernel.org>, linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org
References: <878rgzuw37.fsf@kernel.org>
From:   Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <878rgzuw37.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 2/15/23 10:17, Kalle Valo wrote:
> Here's a new pull request for ath10k and ath11k. We have new hardware
> IPQ5018 and various updates for existing hardware. Especially many have
> requested the firmware update for WCN6855 which seems to fix an
> important suspend problem.
> 
> Please let me know if there are any problems.

Could you also please include all the QCA9888+IPQ4019 boardfiles updates
from last year too?

Cheers,
Christian
