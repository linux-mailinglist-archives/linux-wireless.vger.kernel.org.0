Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD81733565
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjFPQHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 12:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjFPQHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 12:07:09 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6306C2D76
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 09:07:05 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b28fc7a6dcso761373a34.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686931624; x=1689523624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3mi3YmJ92UC2+IcFEqEllItRr/kLsrWEjxNTefsoZfI=;
        b=dHlEmjTaocqsi/Msza76NOa/NBqx8OJ4DLGaBYpKOGwDIUBa7/N2MEvzJNktdyY+em
         L0TrYyX/HrDab8/Y75FXitwFhynzdlydTzQT/rKFZ7gfB90xsj7aaNFB9PiVtFgUENl4
         z9cGqj8aRRYfn9n0mLO+GbcepQswigt1+P7By2S0VfSiU+P5l8oITceuM+AQjAmqTPJn
         lS2Ck3ac4nJznGTVMEstAbLssa5HgD2qIIRBlto0WyYPwnYk7t0y93nb9+wupG0NuaNn
         m4oGkona0aFP47T246mHgs+BeKyO+iJSuZ2RtvJD3dIbldQHkK/RBJDilJKpbqEUp28b
         Tahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686931624; x=1689523624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mi3YmJ92UC2+IcFEqEllItRr/kLsrWEjxNTefsoZfI=;
        b=WXL4YtQOjx2TgdeG9TGkaxkk83wqC6YRw4GDo7xZ871YC2hzcoajThGfPjXqrkU5Tw
         CP7NvdzNN3EjNvr27qu8IKMcTaGjyQBT1ork4+AC/tNRPQNhHOXU2L8ugsNCk1P/nG5a
         xq/E7miBE7gYnJ+gCH6Wo1dAwICIm/x+wlMjBSogx2k57b7iIRu5wHuza9/Z9IDcfIWm
         2ARRwBnBGRHqcKvSpOrOibYyDLBHfByb7etzyhslU8JtXdlB0I7BfuGfsSGaVq3HTKth
         fcUlr/8hdWtWGImfeu03GEXL+PokZrjLwOfvn8FXEHbQRT4gLH72g5RLEFF0t0Y9DFsZ
         hDTQ==
X-Gm-Message-State: AC+VfDwImszTn7DRzFbCvdqR6fsnzICzAJHC9EMMTJ6MzgcIw9ZZEMAV
        lh7vZuqDWnxKovQ8RGXyFCg=
X-Google-Smtp-Source: ACHHUZ6YmC3DwEfXGCCuNGyYkHXiiubLeDAzQW6uRYSekcwBB1tO/3JXOepCm08HGgsPm4e9w5WQmA==
X-Received: by 2002:a9d:6247:0:b0:6ab:1338:fed5 with SMTP id i7-20020a9d6247000000b006ab1338fed5mr2586093otk.11.1686931624637;
        Fri, 16 Jun 2023 09:07:04 -0700 (PDT)
Received: from [192.168.0.200] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id q12-20020a9d654c000000b006b2f16af2c3sm4506838otl.76.2023.06.16.09.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:07:03 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <fe6b1abc-d529-c20f-3fcb-43d891091080@lwfinger.net>
Date:   Fri, 16 Jun 2023 11:06:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] [v2] wifi: rtlwifi: simplify LED management
To:     Dmitry Antipov <dmantipov@yandex.ru>, Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20230608095051.116702-4-dmantipov@yandex.ru>
 <168664510862.24637.10587241603155144086.kvalo@kernel.org>
 <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru> <87h6rad3fp.fsf@kernel.org>
 <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru> <87cz1vbulk.fsf@kernel.org>
 <2e78d1f5-4dc5-9665-e3a1-ee00dcc41630@yandex.ru>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <2e78d1f5-4dc5-9665-e3a1-ee00dcc41630@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/16/23 05:20, Dmitry Antipov wrote:
> Note MAINTAINERS marks drivers/net/wireless/realtek/rtl818x/rtl8180 as
> orphaned but drivers/net/wireless/realtek/rtl818x/rtl8187 as maintained.

Driver rtl8187 is certainly maintained, not that it gets many bug reports. 
Devices that support 802.11g are not used very often, but at least once a year I 
use my device to get online to retrieve the drivers for a fancier wifi card that 
does not have a driver in Linux or Windows. Drivers for the USB-based 8187A and 
8187B have been in Linux since version 2.6.38 (December 2010), and also in 
Windows 7, if not in older versions.

The driver for rtl8180 is not very important, and could be removed as the card 
uses PCI, not PCIe, slots. I do not have such a device, nor do I have any 
hardware old enough to support it, even though I do have some stuff that tends 
to match my age. :)

Larry

