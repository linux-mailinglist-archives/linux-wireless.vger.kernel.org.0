Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FBA59BA3A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Aug 2022 09:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiHVH1O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Aug 2022 03:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiHVH1K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Aug 2022 03:27:10 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67DF29CB0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Aug 2022 00:27:08 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 67DC122238;
        Mon, 22 Aug 2022 09:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1661153225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Fnv7lKMoxLUBaQb/u2LrxfneQ+/pTsC5fGdEV8AbbA=;
        b=DVsqfPYqGX1+/RQReifjgfhP/XAbtRPwXa8vkTPIgFn/xsjOYCye7vhRglpabrl7LvRIgr
        KCip6Rwz2LzniJFbp9eoRT7FfWNvy9cJ6l+BooC/5XIkafzHslrxaQ97Wap9yi9X7AcpqM
        eayDiJIqKz7hfzY0XSsIOPk5lq3uyaw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 22 Aug 2022 09:27:04 +0200
From:   Michael Walle <michael@walle.cc>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ajay.Kathat@microchip.com, linux-wireless@vger.kernel.org,
        Claudiu.Beznea@microchip.com, Sripad.Balwadgi@microchip.com,
        mwalle@kernel.org
Subject: Re: [PATCH v3] wifi: wilc1000: fix DMA on stack objects
In-Reply-To: <87k07fgz16.fsf@kernel.org>
References: <20220809075749.62752-1-ajay.kathat@microchip.com>
 <b1e606e7a36fb900bbc664bbd585ff6a@walle.cc> <87k07fgz16.fsf@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bbbaf29f1767a7f90851505cd4a24ce6@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Am 2022-08-11 06:55, schrieb Kalle Valo:
> Michael Walle <michael@walle.cc> writes:
> 
>> Am 2022-08-09 09:57, schrieb Ajay.Kathat@microchip.com:
>>> Sometimes 'wilc_sdio_cmd53' is called with addresses pointing to an
>>> object on the stack. Use dynamically allocated memory for cmd53 
>>> instead
>>> of stack address which is not DMA'able.
>>> 
>>> Fixes: 5625f965d764 ("wilc1000: move wilc driver out of staging")
>>> Reported-by: Michael Walle <mwalle@kernel.org>
>>> Suggested-by: Michael Walle <mwalle@kernel.org>
>>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>> 
>> Thanks!
>> 
>> Reviewed-by: Michael Walle <mwalle@kernel.org>
>> Tested-by: Michael Walle <mwalle@kernel.org>
> 
> Thanks Michael. My plan is to take this to the wireless tree, seems
> important enough fix.

Do you already have any plan, when you will pick this?

-michael
