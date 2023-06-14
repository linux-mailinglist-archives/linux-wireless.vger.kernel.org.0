Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029A072F74D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjFNIF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243654AbjFNIFG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 04:05:06 -0400
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C910E6
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 01:05:03 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
        by forward500a.mail.yandex.net (Yandex) with ESMTP id E9B785EA66;
        Wed, 14 Jun 2023 11:05:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 15WEvw5DZGk0-QsNqZeeV;
        Wed, 14 Jun 2023 11:05:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1686729901;
        bh=jWxBh/uZB7xo+MgbwaDbhA+YmI0quhbQfTKhDdhLiXU=;
        h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
        b=cD0JBWSTGjMxQSY4W5INR3Gh20TfnsnwVIuZfp3mMgZbk5/VdlJH0E1F8vkIyhP8S
         HtacalnNZ3AZQZ8W5ga5UWrqogqZXi/sRHBTe696FpRyuY90QygfyT8ZKJFQPYGoL3
         bbEPd/AP8c5TnY5tcWOe6pqG5/PLlqzCFYBB1RV0=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <33e23046-c80b-d55a-a8c9-996ca641e6b8@yandex.ru>
Date:   Wed, 14 Jun 2023 11:05:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] [v3] wifi: rtlwifi: cleanup USB interface
To:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru>
 <20230614061832.40882-1-dmantipov@yandex.ru>
 <20230614061832.40882-2-dmantipov@yandex.ru>
 <dcf1857e8fe9484dac9d269ae5384971@realtek.com>
Content-Language: en-US
From:   Dmitry Antipov <dmantipov@yandex.ru>
In-Reply-To: <dcf1857e8fe9484dac9d269ae5384971@realtek.com>
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

On 6/14/23 10:08, Ping-Ke Shih wrote:

> I think this patch doesn't change pr_{info,err}, right ?

Yes but the previous version did, and Kalle has suggested
to avoid such a changes for rtlwifi.

Dmitry

