Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CB3124914
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLROHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:07:41 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:42063 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726856AbfLROHl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:07:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576678060; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=R08EXNh/NqRs6WB6d4v4PJs0E+F6CZC33plOYfDtU4c=; b=OdRH6jbRiTmqoPuwj3+Hs8McYZwBRS8j3AUFKjEdO3LWdikx0fuIFhCub344+w+Y2YvgiHFr
 hqP4VG77D40K9yzEzz3Ej73a8xLX7HeESjKjy+nIHILvuF6maurE01DYhlmdTTzVg0rUGQep
 cHCC+rcGPRXLEeyzC50cxyEEoVo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa32a9.7f77856b0960-smtp-out-n03;
 Wed, 18 Dec 2019 14:07:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7AB2C4479D; Wed, 18 Dec 2019 14:07:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 02EF4C43383;
        Wed, 18 Dec 2019 14:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02EF4C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Subject: Re: [PATCH 1/8] wil6210: dump Rx status message on errors
References: <20191218135947.5903-1-merez@codeaurora.org>
        <20191218135947.5903-2-merez@codeaurora.org>
Date:   Wed, 18 Dec 2019 16:07:33 +0200
In-Reply-To: <20191218135947.5903-2-merez@codeaurora.org> (Maya Erez's message
        of "Wed, 18 Dec 2019 15:59:40 +0200")
Message-ID: <87v9qd917e.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> writes:

> From: Ahmad Masri <amasri@codeaurora.org>
>
> Dump all the Rx status message on different errors to allow more
> visibility of the case.
>
> Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> ---
>  drivers/net/wireless/ath/wil6210/txrx_edma.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
> index 02548d40253c..6a1671c3a2be 100644
> --- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
> +++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
> @@ -903,6 +903,11 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
>  	if (unlikely(!wil_val_in_range(buff_id, 1, wil->rx_buff_mgmt.size))) {
>  		wil_err(wil, "Corrupt buff_id=%d, sring->swhead=%d\n",
>  			buff_id, sring->swhead);
> +		print_hex_dump(KERN_ERR, "RxS ", DUMP_PREFIX_OFFSET, 16, 1,
> +			       (void *)msg, wil->use_compressed_rx_status ?

Isn't the cast unnecessary? Please avoid casting as much as possible.

> @@ -963,6 +968,11 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
>  
>  	if (unlikely(dmalen > sz)) {
>  		wil_err(wil, "Rx size too large: %d bytes!\n", dmalen);
> +		print_hex_dump(KERN_ERR, "RxS ", DUMP_PREFIX_OFFSET, 16, 1,
> +			       (void *)msg, wil->use_compressed_rx_status ?

Same here.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
