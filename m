Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E842E5F9C71
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbiJJKKl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 06:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiJJKKd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 06:10:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FD640545
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 03:10:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qw20so23188915ejc.8
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 03:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98JsuiawP+LaIKyxwWk6yFEIVKAbYc/KHs9wU/YOwJ8=;
        b=Jbebkw02K1c9pqfSECpQmjBr+RHBdT00bDgP6qsMukNp73ofK0WCQP7kj1755KuHPF
         0qBTQXkWus5PUtD/bHB6lv3jo7kpXOSM4OGr9S7dTMgOWqUxeKixjZ9vVBtEfvRWzID3
         MU1RFyCNaTf0uv0OkJ88CPex0xhgOU1cKeF4gaz+fOR8I2N47wbVwHryBCk1T4sMQkEQ
         nkgc9EDn6D6KQe8iSCkMOWUgk6hkviL6ix9ub3vQj36j49QiUKIipWeU23GjJVC6b0Vd
         IOo1scvfZ+mZtfyyI67L2pa/9i5edJtmYPF2l4bxUCz5GhTHqPhx0Oj0kolwweBqqmaU
         HSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98JsuiawP+LaIKyxwWk6yFEIVKAbYc/KHs9wU/YOwJ8=;
        b=qCQwRsLGmHcTmE/fYqGO/65AHLyj+/3RFaB1NC0dNCegX3fSs6Q9/yqWHf3KOdBNY0
         SSlhlNHTBE2QJJ7W91Ri8EmCAEhV0aTSsPDuq2A+FXyHxKsgzBg5JcNJ2Kt5hmnQlqZG
         +XOpsW4nqC6WWkp07j06pvMEcr4UwnV83qgpcBf4P+FKapiPIooPdtx2bqaMpURvLs1m
         NPKA5TDsvedZkvtpu15SRbetu8eSTHKLin4uBweHm/2Ev836sCUUo/zZsORoe6XEXU/t
         BP136BGsQnfEJmiJ8CuFedpa5CzbOU1cS4qLW8mQhvLoDgrjHqGojPg9UgC8XhGFNzFz
         HafQ==
X-Gm-Message-State: ACrzQf2bngY5mSDkdBSvhefYmPMym5iIYqcAZQ/FsNy4f9QjOxA9WXrR
        HLBpUnQTKd+Y0iP2HC5KNnvoLTcRyhZw51RB
X-Google-Smtp-Source: AMsMyM6NSUkJQ32RX9e0sQHkKi2s3oLUmSe5uKZ7VsIws+lIi9D8FY2MR2SIU/CXy9660Itd08vWMA==
X-Received: by 2002:a17:907:3e85:b0:73d:60cc:5d06 with SMTP id hs5-20020a1709073e8500b0073d60cc5d06mr14337023ejc.722.1665396627636;
        Mon, 10 Oct 2022 03:10:27 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id s9-20020a056402014900b0045c3f6ad4c7sm673641edu.62.2022.10.10.03.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 03:10:27 -0700 (PDT)
Message-ID: <14cd2ae0-f7d7-79ca-a192-fa95f2b5f31c@gmail.com>
Date:   Mon, 10 Oct 2022 12:10:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/4] brcmfmac: Support multiple station interface series
Content-Language: en-US
To:     Ian Lin <ian.lin@infineon.com>, linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, Double.Lo@infineon.com
References: <20220929050614.31518-1-ian.lin@infineon.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20220929050614.31518-1-ian.lin@infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/29/2022 7:06 AM, Ian Lin wrote:
> Support create multiple station interface.
> And fix related issues.

These patches surely break things for older chips. Also the firmware API 
definitions should not be place in cfg80211.c but in fwil_types.h.

Regards,
Arend

> Prasanna Kerekoppa (1):
>    brcmfmac: Fix AP interface delete issue
> 
> Ting-Ying Li (1):
>    brcmfmac: revise SoftAP channel setting
> 
> Wright Feng (2):
>    brcmfmac: add creating station interface support
>    brcmfmac: support station interface creation version 1, 2 and 3
> 
>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 306 ++++++++++++++++--
>   .../broadcom/brcm80211/brcmfmac/core.h        |   1 +
>   2 files changed, 272 insertions(+), 35 deletions(-)
> 
