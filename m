Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094D06E793A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjDSMCi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjDSMCf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 08:02:35 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EEB15634
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 05:02:08 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-187949fdb1cso1221129fac.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Apr 2023 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681905725; x=1684497725;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8fsYVlWFjIr8+uQWwugz09FRTzJh0muwnViAoWzM6rc=;
        b=mqvbT17qQNJOkH7y5Zn32mI+RBkPuAkfg7QZnHnKKdi/Da1GLC3+ufYmTV1RgR1vRW
         2N7ILXILKTRWgjKFB/xGynU6FluEewiqmEsNYEebu6zqoSojeyztf6islJZCJ0LTv0UI
         srTDWNyB3rckRj1MTozXZurEKvSegL75EZLbeA5+5FJ8yva9PzPLRpQpJZDlHYAk6Fwd
         WKx09Zl6zk1hLPcjWSe7AwLaeNHdWCC8sZ5zKSoIYMMfr7itqorrUVlL3auoEC7gnWi4
         py+8PYDKQebjl/99agXmLyVjLatlhXJmQFNQOVsKzyYuFE6iEPo8mGmvl5UgkpKTXzMh
         6Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681905725; x=1684497725;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fsYVlWFjIr8+uQWwugz09FRTzJh0muwnViAoWzM6rc=;
        b=jW1i+dCsDAN5WEPhFvZIogqLTAqR40Fw5enxFolBNQaWqp0f4bn0Yq6NLP483304RX
         K81EBEo2mq+91sjQhzC4JfGIQlx7u5ReBBfSGbOa/GDk+F0LevNNYPszmeDe0RBT/4G3
         RP6FZj7nAeyVQ3Nc7XCWBCrrzQoswoTsKLEZwjJV7X+Psi6Mu8vjl23qPduwobzx9bVb
         2KSupB0afORpmTeXC/EveKje+B2uU7wE5sDVnsOuTfT5jLz3vdS5Mz+7xzHcRqVpYeGE
         QRkPkIRF49bG85n5kg/u+ocoujIdC4WVTGehPCZg1FfYmgmwXr8ie/R/Uc5llvurm6Xs
         Engw==
X-Gm-Message-State: AAQBX9eCL3Q7eaKR6Ght/l9qbtTIq+jVkytFuXehLK6GhLRYOFKzhLYx
        ks5STiw6jElTS/lOq2VuU2QTxFvIzj0=
X-Google-Smtp-Source: AKy350YsjwSjKuCEzttW/eNm0v6AlRzO3lQbRmwcehe3eDIH+f3aJavMkvBZiHV6CC5ioi0QKW8z6Q==
X-Received: by 2002:a05:6870:50d:b0:17f:126f:2164 with SMTP id j13-20020a056870050d00b0017f126f2164mr2718834oao.18.1681905725221;
        Wed, 19 Apr 2023 05:02:05 -0700 (PDT)
Received: from [192.168.0.136] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id y138-20020a4a4590000000b0052c27aa1c80sm5789319ooa.46.2023.04.19.05.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 05:02:04 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <0ff3e8c6-0209-ec1e-49e7-780c49ffb736@lwfinger.net>
Date:   Wed, 19 Apr 2023 07:02:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: rtw89 (realtek drivers)
Content-Language: en-US
To:     Andrei Chalapco <andreichalapco@gmail.com>,
        linux-wireless@vger.kernel.org
References: <CAK0jaL10rXgu_3qwQfsarQKj5Jx_ULA0Lyf+vRCcd7JEMGL8Hw@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAK0jaL10rXgu_3qwQfsarQKj5Jx_ULA0Lyf+vRCcd7JEMGL8Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/19/23 04:48, Andrei Chalapco wrote:
> Hi,
> 
> I've recently bought a new laptop (Hp pavilion with the Realtek
> RTL8852BE WiFi 6 802.11ax PCIe Adapter) and when using Fedora 37 it
> won't find the wireless adapter. (still with a 6.2 kernel version).
> 
> Already found the rtw89 drivers on the linux kernel but they don't
> seem to work and I also don't understand why a github repo
> lwfinger/rtw89 seems to work.
> I was wondering when this chipset will be supported by the linux kernel.
> 
> Thanks

It is supported in the 6.3 kernel, which will be released soon.

Larry

