Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD45FF182
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 17:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJNPhb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 11:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJNPha (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 11:37:30 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D3D16C234
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 08:37:29 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id r15-20020a4abf0f000000b004761c7e6be1so1750848oop.9
        for <linux-wireless@vger.kernel.org>; Fri, 14 Oct 2022 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=aDsOTG9zBNarI1Rtok1jWy7gY+RThTmsg9+L0qxJ118=;
        b=XMt4lo+L2UWezAJPu0vFOnSxSv8G6x49iluNaGqjlRPWU/dtzpTL7ux2JDKVbqjk5V
         ExEGPHD8pacMIgRZB4EtiwNG3fJJnHXGfjkuhibG2si5Wf35eJqP4CV+6f/OwfOhNz80
         DVfKzpJhdRgoWRSPCUjosbnwGYZcepgDoMRrcIYDBOwAPIkfRFx6vFcAkzuK5x7ceGWD
         RlzcmBiRElVGnoA5zMkqSuFkwB3g3qoFS1VGKKWxRTLIcpl8l5S1GgK7d76P7swQbRR9
         F58II5/Wb5ReM1UUAuK6CtxPrNr8dZFF/5fGNgK+WmMkJBPMqffsBC6H1wVW94YqDV+k
         mBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDsOTG9zBNarI1Rtok1jWy7gY+RThTmsg9+L0qxJ118=;
        b=1wdb6bPNBjrQOhO58ns583bwYTlquqZdW8OXtgeG/E4PNGHletmeK4l7cTbsjBrdG7
         TlyRAGJQpRCNo0iX1TsxzbrDWtfZWMWHowiKEELxWN2H5j7Sq8Ph1/mDjer/cHpTPbfC
         I7J2T0OpImQr9JUerDKdxx9qvktZhxtHLJDrTYp9zpu6n02TVa6O+xktFbmhBf3ZRmJE
         dyRSBWKLC5AOFkm2wTHIhkvlzvF2EcB6rpyNFfwHWita1FrOutlDZb2p7eBcSvmFN8Fk
         kLGc+N+NWFKWhQNGGz6FAhz576n2uSJ1P+M0bPFCyPDlEuvRgj/xaM9oJ+8FHctg4iN/
         RpFw==
X-Gm-Message-State: ACrzQf2GRc5ciNQu4FLdcz8Tuweak5LX2hSBXFMxKPRE9S/tbmgt1tAV
        d51jDm2AMMmzswEDC1iIarLgP7NPwbs=
X-Google-Smtp-Source: AMsMyM5UsgZteKhgh3jORyj0dck2brCmamqSkmGu+46JQTzhDeTxW0yY9sUhDYxcKEUI373xhNai4g==
X-Received: by 2002:a4a:aa4b:0:b0:47f:7ce6:5b29 with SMTP id y11-20020a4aaa4b000000b0047f7ce65b29mr2194335oom.17.1665761849047;
        Fri, 14 Oct 2022 08:37:29 -0700 (PDT)
Received: from [192.168.0.158] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id a10-20020a05680804ca00b003544822f725sm1258036oie.8.2022.10.14.08.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 08:37:28 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <54d3afcb-3333-ef9d-df68-446618f09040@lwfinger.net>
Date:   Fri, 14 Oct 2022 10:37:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 0/4] wifi: rtw89: 8852b: add RF calibration part 2 and
 enable 8852BE
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>
Cc:     linux-wireless@vger.kernel.org
References: <20221014060237.29050-1-pkshih@realtek.com>
 <87ilkmn1ud.fsf@kernel.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87ilkmn1ud.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/14/22 05:20, Kalle Valo wrote:
> Ping-Ke Shih <pkshih@realtek.com> writes:
> 
>> After this patchset, 8852BE is ready, so add 8852BE to Kconfig and
>> Makefile. With firmware v0.27.32.0, STA, AP and monitor can work well.
> 
> Awesome! From my point of view adding 8852BE support went really
> smoothly, thanks for that. Very much appreciated.

I agree. I have been testing the wireless-next code for about a week with no 
drops and with a code change in today's patches, very little has been logged.

After applying today's updates, my RTW8852BE gets a little over 700 Mbps up and 
down when using a local speedtest server and a D-Link AX1500 router in the 5G band.

Kudos to the Realtek group.

Larry


