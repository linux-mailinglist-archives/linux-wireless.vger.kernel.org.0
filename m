Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E83731486
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 11:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbjFOJwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343617AbjFOJwJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 05:52:09 -0400
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727C4272D
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 02:52:01 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1f25:0:640:df6e:0])
        by forward501c.mail.yandex.net (Yandex) with ESMTP id 7DC2364DC6;
        Thu, 15 Jun 2023 11:49:08 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7nXvcf9WsKo0-47deQQQ6;
        Thu, 15 Jun 2023 11:49:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686818948;
        bh=DAFsiM/zh1clJdZMXurzXYi2RZF27HSmRqOFliUS6ic=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=dvz49WlWy3PA8QqnVr8noRMJ+vQmu2zol5AunaSVyxQ48XZCo0KoabTFGBuSGkL65
         aDc3Qugf7oSqnfbaV72uBRPi5YXnEdwtOWQFeUccuX9dYdAtPv+lXqnM8VcU8AScWv
         S6gcOrTEPumgU979gf7xSEv4r5lAg6H8nBssev2g=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru>
Date:   Thu, 15 Jun 2023 11:49:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] [v2] wifi: rtlwifi: simplify LED management
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <20230608095051.116702-4-dmantipov@yandex.ru>
 <168664510862.24637.10587241603155144086.kvalo@kernel.org>
 <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru> <87h6rad3fp.fsf@kernel.org>
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <87h6rad3fp.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/14/23 08:21, Kalle Valo wrote:

> rtlw8xxxu, rtw88 and rtw89 are the active Realtek drivers

What about rtl818x?

Dmitry


