Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204662B3E4B
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Nov 2020 09:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgKPIIT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Nov 2020 03:08:19 -0500
Received: from z5.mailgun.us ([104.130.96.5]:11848 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbgKPIIT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Nov 2020 03:08:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605514099; h=Message-ID: References: In-Reply-To: Subject:
 To: From: Date: Content-Transfer-Encoding: Content-Type: MIME-Version:
 Sender; bh=6DrsFw/mC0T4tdkE2e726UwY3hSwKQ1ZSNNLw28zmOA=; b=sjU/OKCYTIGQppaSODIxhpQbeqQVW2nYCUaTHKxD76u/ZGbyi+cUZ1zB0HVKP/mXQK6Jtz5d
 mANf7peYrw35JbTMG12krSlE20VHsaieqDXIT7g8dFpqtKfLtFbwx30RqnMTcaaXwI8LNgVs
 BkO41/i7eGDFublFNel7tLWJNFY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fb2335f9a53d19da9fd4eed (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 08:07:59
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F0225C43462; Mon, 16 Nov 2020 08:07:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F08EFC433C6;
        Mon, 16 Nov 2020 08:07:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Nov 2020 13:37:57 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ath11k: vdev and peer delete synchronization with
 firmware
In-Reply-To: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
References: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
Message-ID: <07d18b4fbf313ab8524dc89e3a791629@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-12 13:12, Maharaja Kennadyrajan wrote:

Hi Kalle,

Kindly ignore this patchset as I didn't mention the version number
in the subject name of the patches in the patchlist.
I will correct this and send v3 patchset.

Regret for the inconvenience caused.


Regards,
Maha


> When add an interface immediately after removing the interface,
> vdev deletion in firmware might not have been completed.
> add vdev_delete_resp_event and wait_event_timeout to synchronize
> with firmware.
> 
> Peer creation in firmware fails if last peer deletion is still in
> progress, add wait for the event after deleting every peer from host
> driver to synchronize with firmware.
> 
> 1) add vdev delete resp event and wait event to get ack from firmware
> 2) add wait event timeout for peer delete to get ack from firmware
> 3) code clean up and replace the api 
> 'ath11k_mac_get_ar_vdev_stop_status'
>    with 'ath11k_mac_get_ar_by_vdev_id'
> 
> V2: Rebased on latest ath.git TOT - Addressed Kalle's comment.
> 
> Ritesh Singh (3):
>   ath11k: vdev delete synchronization with firmware
>   ath11k: peer delete synchronization with firmware
>   ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references
> 
>  drivers/net/wireless/ath/ath11k/core.c |  2 +
>  drivers/net/wireless/ath/ath11k/core.h |  9 ++--
>  drivers/net/wireless/ath/ath11k/mac.c  | 82 
> ++++++++++++++++------------------
>  drivers/net/wireless/ath/ath11k/mac.h  |  2 -
>  drivers/net/wireless/ath/ath11k/peer.c | 44 ++++++++++++++++--
>  drivers/net/wireless/ath/ath11k/peer.h |  2 +
>  drivers/net/wireless/ath/ath11k/wmi.c  | 81 
> ++++++++++++++++++++++++++++++---
>  drivers/net/wireless/ath/ath11k/wmi.h  |  4 ++
>  8 files changed, 166 insertions(+), 60 deletions(-)
