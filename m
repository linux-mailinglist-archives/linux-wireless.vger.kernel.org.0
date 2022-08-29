Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E585A4C27
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 14:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiH2MnV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 08:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiH2Mm4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 08:42:56 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147AE2BE1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 05:27:41 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by gnuweeb.org (Postfix) with ESMTPSA id 9B0EB80B54
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 12:27:40 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1661776060;
        bh=F3P0jtYe8nBBFXZxxubIcGD7PfjN1LKYQeyor8Ohfao=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ekcnrn/+6SZXSOAmup6TgAJ/rzV+PiGxiXNMdzZRhZxxSOc10dH7dCvUx9tW0zCJX
         NlHlHEDESIkZyklh7c9mXqNoHoB5+C0KzqqJetyyJqz/2WAIfB84PUZdC1Lo82F3jf
         G28Qlr2ZijDat8kHIXuINievk+19lTsHkfDelb9wdVHLHDLP2TAal4o7ydeSyQpcTr
         ECKRK+zcudEMTNHCgcrCYC2brXqo/Y5j60D/qUwpNlKwAWEkkzP2klLc6KgoX3r0+g
         3AlKALx2xGeZJkrgckm0oYApED797rKZlu5QtSz8/IMuL77ojIhCM5iUVHrL2DxDWX
         PBFi8Fq+92Rew==
Received: by mail-lf1-f42.google.com with SMTP id q7so10900239lfu.5
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 05:27:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo0j1+wQIvEPM2D95yX0iwcy5B/J5Iwel6Vvx6A59erUL0qlkaNF
        XYzPXqQXWeuTtt8z0lmE1q7OuS4iSBphVssIK5FqnA==
X-Google-Smtp-Source: AA6agR6/MaCwdTGYPhxBfRk9aiC96sUXc/nQmdHSZZRK4ihB3EWrLnr+Dp4zIwQ7qLnb+azquQLTlBSE8gM9pP+lBEM=
X-Received: by 2002:a05:6512:2353:b0:492:db5e:775b with SMTP id
 p19-20020a056512235300b00492db5e775bmr5846597lfu.656.1661776058426; Mon, 29
 Aug 2022 05:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220829115516.267647-1-cui.jinpeng2@zte.com.cn>
In-Reply-To: <20220829115516.267647-1-cui.jinpeng2@zte.com.cn>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Date:   Mon, 29 Aug 2022 19:27:27 +0700
X-Gmail-Original-Message-ID: <CAGzmLMV80OLRB+OA=SLk5fEvy2jecYogg636D_HijgzthUoqnQ@mail.gmail.com>
Message-ID: <CAGzmLMV80OLRB+OA=SLk5fEvy2jecYogg636D_HijgzthUoqnQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] wifi: cfg80211: remove redundant err variable
To:     cgel.zte@gmail.com
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        "David S. Miller" <davem@davemloft.net>, edumazet@google.com,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        johannes.berg@intel.com, a.fatoum@pengutronix.de,
        quic_vjakkam@quicinc.com, loic.poulain@linaro.org,
        hzamani.cs91@gmail.com, hdegoede@redhat.com, smoch@web.de,
        prestwoj@gmail.com, Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 29, 2022 at 7:12 PM wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
>
> Return value from brcmf_fil_iovar_data_set() and
> brcmf_config_ap_mgmt_ie() directly instead of
> taking this in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
