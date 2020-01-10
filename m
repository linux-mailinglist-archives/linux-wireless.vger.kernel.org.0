Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF22136B0F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2020 11:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgAJK3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jan 2020 05:29:38 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:42074 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727339AbgAJK3h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jan 2020 05:29:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578652177; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=IytsLbM1pR0Qzs157gZv5EoAroYoP4LB4watZpuwJso=;
 b=JrFHgdSFAyGQHrPd8F/BVK76f2Mb/GZYG50RPpOlm6sQgfqi03hfZNJ+SaxpAoX4/bEwm3Ro
 MsoszPob5W5SHsFpCPSLPgFSFVY9O+qHJ2kT/dWu7IXFUhaLxHnZLBBl3M2Nnssou9d/5B0w
 +zAwbHe1L5T7Zlhmo9I959h6qPQ=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e185210.7f29dee6b228-smtp-out-n02;
 Fri, 10 Jan 2020 10:29:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1313FC433A2; Fri, 10 Jan 2020 10:29:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93091C433CB;
        Fri, 10 Jan 2020 10:29:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 10 Jan 2020 18:29:34 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Justin Capella <justincapella@gmail.com>
Cc:     ath10k <ath10k@lists.infradead.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <CAMrEMU-UTtxJ-eMoNEBONXJCTpaZCcGc8Mu34wqQNXkpVz=gJA@mail.gmail.com>
References: <20200108031957.22308-1-wgong@codeaurora.org>
 <20200108031957.22308-2-wgong@codeaurora.org>
 <CAMrEMU-UTtxJ-eMoNEBONXJCTpaZCcGc8Mu34wqQNXkpVz=gJA@mail.gmail.com>
Message-ID: <55ab2d64e78d51a9da587f276899e08b@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-01-08 20:02, Justin Capella wrote:
> I think this might break the "wedged" state.
> 
> Would simply not taking action unless STATE ON avoid the problems with
> multiple calls to _restart? ie:
> 

ath10k_core_restart is one part of the recovery process,
after ath10k_core_restart, it has other things do in mac80211/ath10k...,
it need to make sure all the recovery 
finished(ath10k_reconfig_complete),
then the next recovery can start from ath10k_core_restart.

so it can not simply change like below.
> diff --git a/drivers/net/wireless/ath/ath10k/core.c
> b/drivers/net/wireless/ath/ath10k/core.c
> index 5ec16ce19b69..a6c11b2bc97c 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -2198,11 +2198,8 @@ static int ath10k_init_hw_params(struct ath10k 
> *ar)
>   return 0;
>  }
> 
> -static void ath10k_core_restart(struct work_struct *work)
> +static void inline _ath10k_core_restart(struct ath10k *ar)
>  {
> - struct ath10k *ar = container_of(work, struct ath10k, restart_work);
> - int ret;
> -
>   set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
> 
>   /* Place a barrier to make sure the compiler doesn't reorder
> @@ -2232,14 +2229,28 @@ static void ath10k_core_restart(struct
> work_struct *work)
>   */
>   cancel_work_sync(&ar->set_coverage_class_work);
> 
> + ath10k_halt(ar);
> + ath10k_scan_finish(ar);
> + ieee80211_restart_hw(ar->hw);
> +
> + ret = ath10k_coredump_submit(ar);
> + if (ret)
> + ath10k_warn(ar, "failed to send firmware crash dump via devcoredump:
> %d", ret);
> +
> + complete(&ar->driver_recovery);
> +}
> +
> +static void ath10k_core_restart(struct work_struct *work)
> +{
> + struct ath10k *ar = container_of(work, struct ath10k, restart_work);
> + int ret;
> +
>   mutex_lock(&ar->conf_mutex);
> 
>   switch (ar->state) {
>   case ATH10K_STATE_ON:
>   ar->state = ATH10K_STATE_RESTARTING;
> - ath10k_halt(ar);
> - ath10k_scan_finish(ar);
> - ieee80211_restart_hw(ar->hw);
> + _ath10k_core_restart(ar);
>   break;
>   case ATH10K_STATE_OFF:
>   /* this can happen if driver is being unloaded
> @@ -2262,13 +2273,6 @@ static void ath10k_core_restart(struct 
> work_struct *work)
>   }
> 
>   mutex_unlock(&ar->conf_mutex);
> -
> - ret = ath10k_coredump_submit(ar);
> - if (ret)
> - ath10k_warn(ar, "failed to send firmware crash dump via devcoredump: 
> %d",
> -     ret);
> -
> - complete(&ar->driver_recovery);
>  }
> 
>  static void ath10k_core_set_coverage_class_work(struct work_struct 
> *work)
> 
> On Tue, Jan 7, 2020 at 7:20 PM Wen Gong <wgong@codeaurora.org> wrote:
