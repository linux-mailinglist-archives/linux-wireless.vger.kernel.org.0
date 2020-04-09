Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266FA1A312F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 10:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgDIIuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 04:50:18 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33666 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgDIIuS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 04:50:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586422218; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=lKT87G/6eCqsB9hKN0EhH/E4zdNG9T0d5yHU6lAPE3w=; b=Fa9hRfH4V4ynrJSC47UTXldAQdThy4p32eY5XlnHrN9edrgkFeNL5eO/s6BYzu7Gg2f3soJB
 djntuDAjFJN4pPN21az9LgUloDePk0keC6u0dMBgiswxVahozgoqp97eQ3n0HHp7HC8ci5QH
 bvvJmSGUjcSGxI0AHbSmVaeBgnU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8ee1bf.7fe9308f8420-smtp-out-n02;
 Thu, 09 Apr 2020 08:50:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1E288C43636; Thu,  9 Apr 2020 08:50:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB618C433CB;
        Thu,  9 Apr 2020 08:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AB618C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ath11k: fix missing return in ath11k_thermal_set_throttling
References: <20200408190606.870098-1-arnd@arndb.de>
Date:   Thu, 09 Apr 2020 11:50:01 +0300
In-Reply-To: <20200408190606.870098-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 8 Apr 2020 21:05:57 +0200")
Message-ID: <87h7xtujpi.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The empty stub version of this function causes a compile-time
> warning:
>
> In file included from drivers/net/wireless/ath/ath11k/core.h:23,
>                  from drivers/net/wireless/ath/ath11k/dp_rx.h:8,
>                  from drivers/net/wireless/ath/ath11k/ce.c:6:
> drivers/net/wireless/ath/ath11k/thermal.h: In function 'ath11k_thermal_set_throttling':
> drivers/net/wireless/ath/ath11k/thermal.h:45:1: error: no return statement in function returning non-void [-Werror=return-type]
>
> Just return success here.
>
> Fixes: a41d10348b01 ("ath11k: add thermal sensor device support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/wireless/ath/ath11k/thermal.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/thermal.h b/drivers/net/wireless/ath/ath11k/thermal.h
> index 459b8d49c184..f1395a14748c 100644
> --- a/drivers/net/wireless/ath/ath11k/thermal.h
> +++ b/drivers/net/wireless/ath/ath11k/thermal.h
> @@ -42,6 +42,7 @@ static inline void ath11k_thermal_unregister(struct ath11k *ar)
>  
>  static inline int ath11k_thermal_set_throttling(struct ath11k *ar, u32 throttle_state)
>  {
> +	return 0;
>  }

Already fixed by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers.git/commit/?id=c9be1a642a7b9ec021e3f32e084dc781b3e5216d

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
