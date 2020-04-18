Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B31AEDBD
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgDROCi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 10:02:38 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:27915 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbgDROCi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 10:02:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587218557; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PtPOrt07EzuEgYcXSDgkKyOC29cvpcuzM7IRgCX/a6A=;
 b=BYGah4HouJF61k756vV+Gc+UiqsD6o6N4oYihIVll09JPW6/MtTVZYDd2CNhHoIgBxWagXZe
 56vkoad8Ie1d7Mmye54NB+KIwkPkqz6hpw8nGBbT8MxWivkWBN3+iXd2idH3FTJqk1Y5OGSQ
 NXZmTI9/BHejmS9F7SKe8gMObTc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9b0872.7f8633374c38-smtp-out-n02;
 Sat, 18 Apr 2020 14:02:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 11982C433BA; Sat, 18 Apr 2020 14:02:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 947F9C433CB;
        Sat, 18 Apr 2020 14:02:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 18 Apr 2020 22:02:24 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
In-Reply-To: <87o8rrr4y5.fsf@kamboji.qca.qualcomm.com>
References: <20200212080415.31265-1-wgong@codeaurora.org>
 <20200212080415.31265-4-wgong@codeaurora.org>
 <87tv1su2vq.fsf@kamboji.qca.qualcomm.com>
 <185d31c2e6f8792beb240f2c74d26463@codeaurora.org>
 <87h7xmtrmv.fsf@kamboji.qca.qualcomm.com>
 <87o8rrr4y5.fsf@kamboji.qca.qualcomm.com>
Message-ID: <27ca9f2bf63807d501cfb29d8f55f904@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-16 20:27, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 

>> How much does it drop? Please add the justification (with numbers) for
>> the new thread to the commit log, so that the reason is properly
>> documented.
> 
> I see that you already submitted v10. If you can give the numbers I can
> add them to the commit log.

I tested for VHT80 mode for 3 thread config:
result:
                                      TCP-RX    TCP-TX    UDP-RX    
UDP-TX
use workqueue_tx_complete(Mbps)        423       357       448       412
change it to ar->workqueue(Mbps)       410       360       449       414
change it to ar->workqueue_aux(Mbps)   405       339       446       401

each thread role:
tx_bundle_skbs(ar->workqueue),
rx_indication(ar->workqueue_aux),
sdio_async_tx_request(ar_sdio->workqueue),
tx_bundle_complete(ar->workqueue_tx_complete)
