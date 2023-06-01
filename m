Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019C4719ECF
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 15:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjFANuL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 09:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjFANuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 09:50:10 -0400
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d500])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92243192
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 06:50:05 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:2991:0:640:bb47:0])
        by forward500c.mail.yandex.net (Yandex) with ESMTP id 8956D5EDC4;
        Thu,  1 Jun 2023 16:50:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2oOC6E0DYW20-Fml5YSnz;
        Thu, 01 Jun 2023 16:50:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1685627403;
        bh=P1xAhTZF2QZP+jUph4FSayyg5vKki7ub5CyGBI7GfE0=;
        h=Subject:From:In-Reply-To:Cc:Date:References:To:Message-ID;
        b=IjvtbO07lcYBkGfiSS0Pnc1z4ZbO6xrBbEXd2Bhd+w5uzwVwTCCInFDd3BQvlkl9Z
         jHvoSIeEGiUgIzBL3BkzXrjVxwmltMo0eIJKfD52OoUuDslK3JDbU7J7WE/tHDqZRz
         6ZYXZ3rJRt9ztCTdcrPHtBFGFqiEHSzbeDYa5yFQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <0d1f24b9-a058-52fd-b669-54aa4e9162f9@yandex.ru>
Date:   Thu, 1 Jun 2023 16:50:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
 <20230601105215.27013-1-dmantipov@yandex.ru>
 <3b92f9205003f44187f7ebf7add6c3e0626e9646.camel@realtek.com>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] rtlwifi: rtl8188ee: mark RTX_POWER_{BEFORE,AFTER}_IQK_A
 reads as unused
In-Reply-To: <3b92f9205003f44187f7ebf7add6c3e0626e9646.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/1/23 15:30, Ping-Ke Shih wrote:

> Normally, mention a commit by `commit <12 digits SHA1> ("subject")`

OK

> Why not just
> 
> rtl_get_bbreg(hw, RTX_POWER_BEFORE_IQK_A, MASKDWORD);
> rtl_get_bbreg(hw, RTX_POWER_AFTER_IQK_A, MASKDWORD);

Compiler with -Wextra etc. or static analysis tool may complain about an unused
return value. As far as I know GCC has __attribute__((warn_unused_result)) but
lacks an opposite thing, so (somewhat ugly explicit) cast to 'void' may be helpful.

Dmitry

