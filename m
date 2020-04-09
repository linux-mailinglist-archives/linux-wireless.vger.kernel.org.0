Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF6F1A3763
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 17:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgDIPqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 11:46:06 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:55318 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727912AbgDIPqG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 11:46:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586447166; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=JrY+N5OWsykGVuGT2zTyq6XfRigYdFNjytDlDSHFDUw=;
 b=lzk3V+LtZI5vpeuBJ1CH4otpzB9T9l+PbNxh9LNAPg493nOiR7z6/oq3Ew8Qs21JdPQHqcUJ
 XjAryJQJ9cWOpQVr8h5drYn3GockzebAXAaT+b81ckYWJyuR0pLs7NfAr/Hx4R30FuFqfhaY
 v9NQla7USCMuhHDZX8ue9vJASmg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f4327.7f14543ddd88-smtp-out-n02;
 Thu, 09 Apr 2020 15:45:43 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BC825C43636; Thu,  9 Apr 2020 15:40:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5210CC432C2;
        Thu,  9 Apr 2020 15:40:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 09 Apr 2020 23:40:41 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
In-Reply-To: <87tv1su2vq.fsf@kamboji.qca.qualcomm.com>
References: <20200212080415.31265-1-wgong@codeaurora.org>
 <20200212080415.31265-4-wgong@codeaurora.org>
 <87tv1su2vq.fsf@kamboji.qca.qualcomm.com>
Message-ID: <185d31c2e6f8792beb240f2c74d26463@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-09 22:53, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> +	ar->workqueue_tx_complete =
>> +		create_singlethread_workqueue("ath10k_tx_complete_wq");
>> +	if (!ar->workqueue_tx_complete)
>> +		goto err_free_aux_wq;
> 
> We already have three threads:
> 
> ath/ath10k/core.c:      ar->workqueue =
> create_singlethread_workqueue("ath10k_wq");
> ath/ath10k/core.c:      ar->workqueue_aux =
> create_singlethread_workqueue("ath10k_aux_wq");
> ath/ath10k/sdio.c:      ar_sdio->workqueue =
> create_singlethread_workqueue("ath10k_sdio_wq");
> 
> Do we really need a fourth one? For example, why can't we use
> ar->workqueue_aux?

For tcp test, it has 4 thread work meanwhile:
tx_bundle_skbs(ar->workqueue),
rx_indication(ar->workqueue_aux),
sdio_async_tx_request(ar_sdio->workqueue),
tx_bundle_complete(ar->workqueue_tx_complete)

It has 4+ cpu/core in system, if reduced to 3 threads, then tcp 
throughput will drop.
only when it only has 1/2/3 cpu/core in system, then reduced to 3 
threads will not drop.
