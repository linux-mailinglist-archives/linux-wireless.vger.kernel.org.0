Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7414724B209
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 11:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgHTJTL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 05:19:11 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:45748 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726870AbgHTJSo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 05:18:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597915124; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uHIyqsq5NP71jxpWiW9fsYcrjpHYF1rvE2aWVNxyr4w=;
 b=bAJf4Tto88H1BmpsQ8B7Pdkz3h429tws4UII8HhPkN8qHhCHay6p/pWKfxVs2RgnJ5P4jc0l
 avBlvfCFEJTUdSp/ejPyAp/YNnzDifdWvh3XGywPHAKXBWzArUwO64ylI+ZbnGdyByL5Wzw3
 5FwG00vROGuzDqXbmj2V6Upetx0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f3e3fe3e8bbfbec1018953a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 09:18:27
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7F32C43391; Thu, 20 Aug 2020 09:18:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78ACFC433CA;
        Thu, 20 Aug 2020 09:18:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Aug 2020 17:18:26 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <87imdlkuw8.fsf@codeaurora.org>
References: <20200108031957.22308-1-wgong@codeaurora.org>
 <20200108031957.22308-2-wgong@codeaurora.org>
 <87imdlkuw8.fsf@codeaurora.org>
Message-ID: <725b4377f63c76627e1e68604323cb74@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-15 01:19, Kalle Valo wrote:
...
> 
> I have been thinking a different approach for this. I think another
> option is to have a function like this:
> 
> ath10k_core_firmware_crashed()
> {
>         queue_work(ar->workqueue, &ar->restart_work);
> }
> 
> In patch 1 we would convert all existing callers to call that
> function instead of queue_work() directly.
> 
> In patch 2 we would add a new flag to enum ath10k_dev_flags, or maybe
> should actually use existing ATH10K_FLAG_CRASH_FLUSH? Don't know yet
> which one is better. Now the function would do:
I thinks we can use test_and_set_bit for atomic operation athough it is 
same with restart_count.
and add a new flag, ATH10K_FLAG_CRASH_FLUSH is used for flush,
if still use ATH10K_FLAG_CRASH_FLUSH, it should change clear_bit of it 
from
ath10k_core_start to ath10k_reconfig_complete,because 
ieee80211_reconfig(called by
ieee80211_restart_work)
of mac80211 do many things and drv_start is 1st thing and
drv_reconfig_complete is last thing, drv_reconfig_complete done means 
the restart
finished.

I will send patch v5 with above changes if not other advise.
> 
> ath10k_core_firmware_crashed()
> {
>         if (test_bit(flag))
>                 return
> 
>         set_bit(flag)
> 	queue_work(ar->workqueue, &ar->restart_work);
> }
> 
> That way restart_work queue would be called only one time.
> 
> Though I'm not sure how ATH10K_STATE_WEDGED would behave after this
> change, it might get broken. Ah, actually I think even this patch 
> breaks
> the WEDGED state. This firmware restart is tricky, difficult to say 
> what
> is the best approach. Michal, are you reading? :) Any ideas?
> 
> And after looking more about this patch I don't see the need for the 
> new
> ar->restart_count atomic variable. Checking for ATH10K_FLAG_CRASH_FLUSH
> would do the same thing AFAICS.
> 
> And related to this, (in a separate patch) I think we should utilise
> ATH10K_FLAG_CRASH_FLUSH more. For example in ath10k_wmi_cmd_send() to
> not even try to send a WMI command if the flag is set. Basically all
> hardware access should be disabled except what is needed to restart the
> firmware.
