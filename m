Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3096DADA5
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Apr 2023 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjDGNfM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Apr 2023 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDGNfL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Apr 2023 09:35:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDE944B9
        for <linux-wireless@vger.kernel.org>; Fri,  7 Apr 2023 06:35:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id q16so54510214lfe.10
        for <linux-wireless@vger.kernel.org>; Fri, 07 Apr 2023 06:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680874509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtaBXHMta717GpCuZ3wh1MM3SKnnue8iRo2CuX4LyJA=;
        b=C0uULR956DWUq4yyn2ojN4NMe/JEa/qkhBvz1mLHZE6E+4OeYapJs8wBgvf5rYVHtk
         UVurRhKyEk/mgh9qfmZ6QceyEzX0j28/3OxWegln1vq21BCdqGmGpUFXRIRX9hwx9ON6
         AwoQND2MnjFVeaCtDTwz4U/1c/mHlwdKeQ2a3tV6UTtB8N6dOJsEPcPTJGeXmcBYY1d0
         OjRqYk4EabZgIb01qL/Hw29ccVkBaFEwx/tkRsSLAAHEiFkAM/8warC7bd3w64WLwB8w
         sep9+WlkXlS/dVBOHk2RBGfNW6fIvCE1ZoHCbrYJ2z81b7T1XKhwBuk2NxB1phNK5f52
         cScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtaBXHMta717GpCuZ3wh1MM3SKnnue8iRo2CuX4LyJA=;
        b=nrmQTJU51d0e21S8lgNgp4c9w6k9Ky+6sSt/SeQ73THCBWBUw5DAp4HGlvTUjT1xw0
         /lVFaIJfiOJWzqisKrN4D+eqwOrwZ+YNBLJqB+Pf3mEpHL05AA7hOMTKcoEMr6uJHUZn
         oVhiEZg6ZiwE+B/1c7qbrX0gYSIOQa7xW4h8TGbSN13oSPIbzF+xXglxpS6YCIiEa3fD
         x68IAviuLZ7QqaJcsv7PzEg+4dzrbWbviQwRRz7zRFPtOgAbzl0X7SBeuVrRo3sQ0n3f
         aWrbEc98lqsesJhXjIB8SnPAgMRBsK7gTTi864efSta5tfj0NYCV6mU2L1COXix65bhw
         ficQ==
X-Gm-Message-State: AAQBX9dxWhzYSTylL9p4fmIMm4srk/sentkVP7s4I6z2mKYYIdhgRYwA
        9MMS5jmE8s6vFKaXhMU04XMFEw==
X-Google-Smtp-Source: AKy350aT0DmwbnnqzrraNugNo0+iMi/Li4QQ8L+y+1QlEdcYad0HE/PkOOlJ6OW+ED8Ingr9/fcD8Q==
X-Received: by 2002:a19:f817:0:b0:4a4:68b8:f4bd with SMTP id a23-20020a19f817000000b004a468b8f4bdmr706625lff.3.1680874508840;
        Fri, 07 Apr 2023 06:35:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f14-20020a2ea0ce000000b00298a81f3184sm790704ljm.100.2023.04.07.06.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 06:35:08 -0700 (PDT)
Message-ID: <8ceeee1e-8828-69a9-facb-20c3787207bd@linaro.org>
Date:   Fri, 7 Apr 2023 16:35:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PULL linux-firmware] ath10k & ath11k firmware 20230405
Content-Language: en-GB
To:     Kalle Valo <kvalo@kernel.org>, linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org
References: <87cz4ia35m.fsf@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <87cz4ia35m.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 05/04/2023 16:07, Kalle Valo wrote:
> Hi,
> 
> Here's a pull request for ath10k and ath11k. For ath10k we have lots of
> board file updates in multiple hardware families. For ath11k we have new
> firmware branches for QCN9074, IPQ6018 and IPQ8074. WCN6750 also got a
> firmware update and WCN6855 has board file updates.
> 
> Please let me know if there are any problems.
> 
> Kalle

Excuse me, a gentle reminder regarding WCN3990 board-2.bin. It was not 
included into this pull request.

> ----------------------------------------------------------------
> Kalle Valo (12):
>        ath10k: QCA4019 hw1.0: update board-2.bin
>        ath10k: QCA6174 hw3.0: update board-2.bin
>        ath10k: QCA9888 hw2.0: update board-2.bin
>        ath10k: QCA9984 hw1.0: update board-2.bin
>        ath10k: QCA99X0 hw2.0: update board-2.bin
>        ath11k: IPQ6018 hw1.0: update board-2.bin
>        ath11k: IPQ6018 hw1.0: update to WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>        ath11k: IPQ8074 hw2.0: update board-2.bin
>        ath11k: IPQ8074 hw2.0: update to WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>        ath11k: QCN9074 hw1.0: update to WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>        ath11k: WCN6750 hw1.0: update to WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1
>        ath11k: WCN6855 hw2.0: update board-2.bin

-- 
With best wishes
Dmitry

