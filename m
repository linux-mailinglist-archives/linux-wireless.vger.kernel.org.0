Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8152A414D86
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Sep 2021 17:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhIVP4C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Sep 2021 11:56:02 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:42681 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhIVP4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Sep 2021 11:56:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632326070; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TQmo6H985l6YspKxjxGXlp8XC/Pf9PkfzoCAYLU0wAw=;
 b=cMm0DaHgSX54y9vjT9HapuGlDyiekjTR92pD84Am0r2IdTSJANvLidHWqyjYknP5gA1vP3Xk
 +ef0LFAFa1Lj+MhbrJrTK+eC+ZpuDxyY7/P7GrBY/WKheXt3JtVhHQBlo0oYxPI3MQmLihVN
 b4kwqRDJTJhWXFGPLlEeMVaiUyg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 614b517ebd6681d8ed8df6fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Sep 2021 15:53:34
 GMT
Sender: seevalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A3458C4338F; Wed, 22 Sep 2021 15:53:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: seevalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83B81C4360C;
        Wed, 22 Sep 2021 15:53:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Sep 2021 21:23:32 +0530
From:   Seevalamuthu Mariappan <seevalam@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Subject: Re: [PATCH 2/3] ath11k: add separate APIs for monitor mode
In-Reply-To: <87tuidudmi.fsf@codeaurora.org>
References: <20210721162053.46290-1-jouni@codeaurora.org>
 <20210721162053.46290-3-jouni@codeaurora.org>
 <877dfaukjq.fsf@codeaurora.org> <87tuidudmi.fsf@codeaurora.org>
Message-ID: <58b100804acf0afc1c8baf4840ed65d8@codeaurora.org>
X-Sender: seevalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-21 21:25, Kalle Valo wrote:
> Kalle Valo <kvalo@codeaurora.org> writes:
> 
>>> +vdev_stop:
>>> +	reinit_completion(&ar->vdev_setup_done);
>>> +
>>> +	ret = ath11k_wmi_vdev_stop(ar, vdev_id);
>>> +	if (ret) {
>>> +		ath11k_warn(ar->ab, "failed to stop monitor vdev %i after start 
>>> failure: %d\n",
>>> +			    vdev_id, ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = ath11k_mac_vdev_setup_sync(ar);
>>> +	if (ret)
>>> +		ath11k_warn(ar->ab, "failed to synchronize setup for vdev %i stop: 
>>> %d\n",
>>> +			    vdev_id, ret);
>> 
>> I added return ret here for consistency..
>> 
>>> +	return ret;
>> 
>> I don't thinks this is right, in an error path (vdev_stop label) we
>> return 0? I changed this to -EIO.
>> 
>>> +static int ath11k_mac_monitor_vdev_stop(struct ath11k *ar)
>>> +{
>>> +	int ret;
>>> +
>>> +	lockdep_assert_held(&ar->conf_mutex);
>>> +
>>> +	reinit_completion(&ar->vdev_setup_done);
>>> +
>>> +	ret = ath11k_wmi_vdev_stop(ar, ar->monitor_vdev_id);
>>> +	if (ret)
>>> +		ath11k_warn(ar->ab, "failed to request monitor vdev %i stop: 
>>> %d\n",
>>> +			    ar->monitor_vdev_id, ret);
>>> +
>>> +	ret = ath11k_mac_vdev_setup_sync(ar);
>>> +	if (ret)
>>> + ath11k_warn(ar->ab, "failed to synchronize monitor vdev %i stop:
>>> %d\n",
>>> +			    ar->monitor_vdev_id, ret);
>>> +
>>> +	ret = ath11k_wmi_vdev_down(ar, ar->monitor_vdev_id);
>>> +	if (ret)
>>> +		ath11k_warn(ar->ab, "failed to put down monitor vdev %i: %d\n",
>>> +			    ar->monitor_vdev_id, ret);
>>> +
>>> +	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %i stopped\n",
>>> +		   ar->monitor_vdev_id);
>>> +	return ret;
>>> +}
>> 
>> I was not sure what's the idea of error path handling here, we print
>> warnings but still continue the normal execution. I changed this so 
>> that
>> we bail out in the first error and if everything goes well we return 
>> 0.
> 
> I found quite a few missing error checks, too many to list here but
> fixed in the pending branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=8b2f8d11422e7909ff02db456cda41728f621de4
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=5ff318be206b3d2a0bfdcfaf0ac52cc3b4ecdeae
> 
> Please double check, compile tested only.

Thanks for the fixes Kalle. It looks fine and tested the same.

Regards,
Seevalamuthu M
