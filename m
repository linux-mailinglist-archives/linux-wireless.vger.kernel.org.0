Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16096FB68A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 20:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjEHS70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 14:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHS70 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 14:59:26 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432C55FF4;
        Mon,  8 May 2023 11:59:25 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38ea3f8e413so2545127b6e.2;
        Mon, 08 May 2023 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683572364; x=1686164364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PZkDmZHcRiHp/Q7/Uo7N6bFtU8+8Snn1+dcariI9Db4=;
        b=p7x8BsPzsyBMuTdqQL1gaBcd3fyd9hwZMdGoMYHm1X8hGob2I1fze7ohSBdS/j+DIu
         xngXoPWAF3mivdiM1jkhgY5e+xUbjp/nfO9+5j86Fjhmp9v/p8t6YE5qj+juHrmEpLPS
         Arvib59/852hwYT5B12PYPdSJM2ZgG8xIc3OSwDWxfTUQP4eLFZxyxd2Q7tMnpfEMI33
         OwWVJ+sCQ23sd7Yv9sWgX/x5q0BuflZf6sAF0cEpp8I6TBgnSbi56UpFPX+joCGgFkTU
         zAs7CAqpGjUIcxr7nxrtj+RuUfyBx5gf8nlzt/Q3w3xH7Jaj9hdblLwYy9FZEdgrPT4B
         r8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683572364; x=1686164364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZkDmZHcRiHp/Q7/Uo7N6bFtU8+8Snn1+dcariI9Db4=;
        b=fHon4haFIOgY3O1Hqrzoo3ys9tQKIvaWhWpmF3ZMGd97GfAGbkBcWX9t53QQGSxFPZ
         PxbWa0RoDuXC4HyV0kapUWxXVe1FWH1xsavORdJ41ES67edAIDb2SoQeHAmUCbubT3mA
         ziVtPwGOgFWzvKbBzcurvj00KXD8oE7xbt/zB1brFuYYgO8Vd6vYl7WMRyzK99h1n6t+
         VRW0dqIo3QTb7kRJu/J979fpeY5G/KiGosqIfE6Jl2739HCse1Zkx42rlvgCB2lB1cdj
         c+c/AG63wjJQFrW1Vh0nm9tu9CTEzDHfl1yBtpIFjk/uSWjPGjUmdsF1B39HCDCarCXK
         HP/Q==
X-Gm-Message-State: AC+VfDwV+4vfY2e+iSs3dOQ8Dgtbzhk3MIny/sZIztBuLjZqskbGeyTv
        P6NviA+pejXhlNvCaI0OTMo=
X-Google-Smtp-Source: ACHHUZ44oeGRxyI4iSdEzH2tiKUCbu/BdxXUIpsgke9dmFcxggtZej2UJWEYFmoxqSrHSDEamQm/lQ==
X-Received: by 2002:a05:6808:3a84:b0:38e:8d7f:c07e with SMTP id fb4-20020a0568083a8400b0038e8d7fc07emr17370oib.52.1683572364484;
        Mon, 08 May 2023 11:59:24 -0700 (PDT)
Received: from [10.62.118.118] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id 6-20020aca0b06000000b0038c5c0d8a83sm311408oil.33.2023.05.08.11.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:59:24 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <8975f4d5-b042-5983-e15a-40b8a3452a9f@lwfinger.net>
Date:   Mon, 8 May 2023 13:59:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] wifi: rtw88: correct qsel_to_ep[] type as int
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>, kvalo@kernel.org,
        tony0620emma@gmail.com
Cc:     s.hauer@pengutronix.de, stable@vger.kernel.org,
        dan.carpenter@linaro.org, linux-wireless@vger.kernel.org
References: <20230508085539.46795-1-pkshih@realtek.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <20230508085539.46795-1-pkshih@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/8/23 03:55, Ping-Ke Shih wrote:
> qsel_to_ep[] can be assigned negative value, so change type from 'u8' to
> 'int'. Otherwise, Smatch static checker warns:
>    drivers/net/wireless/realtek/rtw88/usb.c:219 rtw_usb_parse() warn:
>    assigning (-22) to unsigned variable 'rtwusb->qsel_to_ep[8]'
> 
> Cc: stable@vger.kernel.org
> Fixes: a6f187f92bcc ("wifi: rtw88: usb: fix priority queue to endpoint mapping")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/linux-wireless/c3f70197-829d-48ed-ae15-66a9de80fa90@kili.mountain/
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

