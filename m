Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9962DD5F1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 18:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgLQRVP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgLQRVP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 12:21:15 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D6CC061794
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=99MIRrxmrT2hLh8pgqts08SkhJkWHuN5iO58VeSman8=; b=bmPgPSf1GoXYkM5i+EMRzJOnuQ
        JlJVFGGBrPyp6nLjYtLB0AWt/TxNqrVZk0OOP2OXTwntpVmWOIHUqKDMaahtl6gO+nkTfXM0CCPlG
        eJ/h1xwonwhgVY5tjrAQrGr11FbzI2E4Q2noVAuyi8Hky3dDNIHnztRnWIGdkQ6FJICI=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpwx7-0000ee-Lc; Thu, 17 Dec 2020 18:20:33 +0100
Subject: Re: [PATCH] mt76: mt76s: fix NULL pointer dereference in
 mt76s_process_tx_queue
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
References: <b49c1b4edacd87b2241a9fd0431dd4864c8963f6.1607418933.git.lorenzo@kernel.org>
 <20201217163616.546AFC433CA@smtp.codeaurora.org>
 <20201217171105.GC16606@lore-desk>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <58f03209-de19-0f35-fed3-d20366f933d2@nbd.name>
Date:   Thu, 17 Dec 2020 18:20:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201217171105.GC16606@lore-desk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-17 18:11, Lorenzo Bianconi wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>> 
>> > Fix a possible NULL pointer dereference in mt76s_process_tx_queue that
>> > can occur if status thread runs before allocating tx queues
>> > 
>> > Fixes: 6a618acb7e62 ("mt76: sdio: convert {status/net}_work to mt76_worker")
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> 
>> Failed to apply to wireless-drivers:
> 
> Hi Kalle,
> 
> sorry for the noise. I guess to apply this patch we need to apply even the
> following series:
> https://patchwork.kernel.org/project/linux-wireless/cover/cover.1607164041.git.lorenzo@kernel.org/
> 
> @Felix: do you think it is ok to apply "remove wake queue tx logic for
> usb/sdio" series to wireless-drivers?
Yes, that makes sense.

- Felix
