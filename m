Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FE972DC96
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241485AbjFMIgd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241452AbjFMIgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:36:20 -0400
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C83019B4
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:36:08 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
        by forward501a.mail.yandex.net (Yandex) with ESMTP id D96695E888;
        Tue, 13 Jun 2023 11:36:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5aVLrOsDRa60-4RBHTFkq;
        Tue, 13 Jun 2023 11:36:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686645365;
        bh=BXsZUiqbYTJ4dRCz++Ls2gAS1dQ/c78k5t7UblDw0nA=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=swiZYyzrzC/YnyfvsyKKXjAG2Qsmpt2o+xRPbiCd4C8oHZnn1DKBGWUN/ENh7kY6z
         LykJx3r65D/0DVviUfv6ujRsDqemuq/SLZpl4WkqOkIvzG9qi/1VulJ3sbeCuF/TAF
         9wupIKMqSlP2rZ9TG1fXWAzgAI3uIZ8o40xsxhmI=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru>
Date:   Tue, 13 Jun 2023 11:36:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] [v2] wifi: rtlwifi: simplify LED management
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20230608095051.116702-4-dmantipov@yandex.ru>
 <168664510862.24637.10587241603155144086.kvalo@kernel.org>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <168664510862.24637.10587241603155144086.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/13/23 11:31, Kalle Valo wrote:

> Is there a reason why you are changing error messages to debug messages like here:
> 
> -		pr_err("switch case %#x not processed\n",
> -		       pled->ledpin);
> +		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
> +			"unknown LED pin %d\n", pin);

Well, this sounds to be more problem-specific rather than
generic "something unexpected in the switch statement".

> The commit log mentions nothing about that.

It seems I have to write more detailed commit message.
Should I resend?

Dmitry

