Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206F56BFEB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239544AbiGHS3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239615AbiGHS3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 14:29:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940EB2AB
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 11:29:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso2750882pjc.1
        for <linux-wireless@vger.kernel.org>; Fri, 08 Jul 2022 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oIffK8cXnvzSzFD4HmmR+oOoPQhfquX5TfTKdCjS61E=;
        b=jjqZd+9GtT+Lej4QtuLNEQNEU1YVvH7lWgmfjDYqGLcoAijVsKk+4uJCLa5rdJ0q4O
         REQIi1RnQchRh3YPwlJE7gVAq7qSyqf3NEAr4HI3JWPd9Z6IVylllhvByycAaHGzu+GJ
         8YUx8z1Je9//t1e6R/LVF7EINtrE9OjPBOKSn+qfOwF1jDOM3P7HjlcSYJkALtU/tF0N
         ggfcE36ZX4pJB9wfQ1SmqdJM9MVCMBCnjNpjPzFevWTD+KbJ60w2zPXZZ2POHHS3YkoQ
         fhzCVNFoZipSgka8fjqKt43zz3m1XRZ7dMElGnQg8drK5aAys6sfClQ28hkDOtMYkgfN
         nEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oIffK8cXnvzSzFD4HmmR+oOoPQhfquX5TfTKdCjS61E=;
        b=FUo1Gun9IaGTsY9MiCi1+64LawnZaiM/eHHxK9SzHu7NHEsu1qHYyy/k6HQQUbF3yl
         C7LghXa4OpuD+Q7YVTSqRQo8CxRlQRqyaswe/GdgqxJCGBMoe2dSiuzSuTEMOBNiDFA5
         37CQ9tsWagMs6IHmBiR85zasNqod7UWKNNCpW+gFohDNd93RdOPr72ng2pCJ2lDBUFec
         9wFV3JemKA48f2kiOXLFzsB+fxkgbMm3YgANFvVMA/NYEVNq/yLWwfnUhRYYATeFTfvc
         FsYQS8tAXfObKf6WJvcvF/7QUnTuHZ1qKsC8kjeBuFnKQwAShQcPr9Ejd5aOoEoQacZG
         p5SA==
X-Gm-Message-State: AJIora+XUyFcmIBvyI2RYoQTuToHHsuETUEGP2fZPp4T8gNT+kChpW+a
        pR5iJ1niBEMAeG1dLl0N9hM=
X-Google-Smtp-Source: AGRyM1uyLRlpUofb9N7v+rI4SUfzIqHNPVQoJHruqU/9D39hJoGTS6b9in2gYtIaYfoOZ5V1JtE85g==
X-Received: by 2002:a17:90b:504:b0:1e6:a0a4:c823 with SMTP id r4-20020a17090b050400b001e6a0a4c823mr1303017pjz.190.1657304958019;
        Fri, 08 Jul 2022 11:29:18 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090ac25000b001ef87123615sm1950440pjx.37.2022.07.08.11.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 11:29:17 -0700 (PDT)
Message-ID: <94bc4370-c140-f002-16ef-11220467b921@gmail.com>
Date:   Fri, 8 Jul 2022 20:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] brcmfmac: Add brcmf_c_set_cur_etheraddr() helper
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220708133712.102179-1-hdegoede@redhat.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20220708133712.102179-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/8/2022 3:37 PM, Hans de Goede wrote:
> Add a little helper to send "cur_etheraddr" commands to the interface
> and to handle the error reporting of it in a single place.

Acked-by: Arend van Spriel <aspriel@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/common.c       | 18 +++++++++++++-----
>   .../broadcom/brcm80211/brcmfmac/common.h       |  1 +
>   .../broadcom/brcm80211/brcmfmac/core.c         |  8 ++------
>   3 files changed, 16 insertions(+), 11 deletions(-)
