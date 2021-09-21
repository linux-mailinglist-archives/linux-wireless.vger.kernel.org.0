Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A064136C3
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 17:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhIUP56 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 11:57:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53904 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhIUP5z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 11:57:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632239786; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=R2SYqKJghX3Q9JXD5f+M78ix3or9lR3EMnYoy1HL7R8=; b=Inr9ov+mZU4oO7UZcJT7vomJcWzwIYCaDEzeB65MsuNjdH8kfYSGrHmbKt10Zt9q6M3+BG3w
 n2xrco1uaFxTvrrdmKIcaDI/ZY9ZcjGTDMKRjm6et0tr5QaPen65oAQc/VstidyWb3VqdleQ
 UAAvsFYm6tyNRr8NbsG4LQyYNyM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 614a008b507800c880555f51 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 15:55:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF9B5C43618; Tue, 21 Sep 2021 15:55:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4765C43460;
        Tue, 21 Sep 2021 15:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E4765C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        Vasanthakumar Thiagarajan <vthiagar@codeaurora.org>
Subject: Re: [PATCH 2/3] ath11k: add separate APIs for monitor mode
References: <20210721162053.46290-1-jouni@codeaurora.org>
        <20210721162053.46290-3-jouni@codeaurora.org>
        <877dfaukjq.fsf@codeaurora.org>
Date:   Tue, 21 Sep 2021 18:55:49 +0300
In-Reply-To: <877dfaukjq.fsf@codeaurora.org> (Kalle Valo's message of "Tue, 21
        Sep 2021 16:26:17 +0300")
Message-ID: <87tuidudmi.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

>> +vdev_stop:
>> +	reinit_completion(&ar->vdev_setup_done);
>> +
>> +	ret = ath11k_wmi_vdev_stop(ar, vdev_id);
>> +	if (ret) {
>> +		ath11k_warn(ar->ab, "failed to stop monitor vdev %i after start failure: %d\n",
>> +			    vdev_id, ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = ath11k_mac_vdev_setup_sync(ar);
>> +	if (ret)
>> +		ath11k_warn(ar->ab, "failed to synchronize setup for vdev %i stop: %d\n",
>> +			    vdev_id, ret);
>
> I added return ret here for consistency..
>
>> +	return ret;
>
> I don't thinks this is right, in an error path (vdev_stop label) we
> return 0? I changed this to -EIO.
>
>> +static int ath11k_mac_monitor_vdev_stop(struct ath11k *ar)
>> +{
>> +	int ret;
>> +
>> +	lockdep_assert_held(&ar->conf_mutex);
>> +
>> +	reinit_completion(&ar->vdev_setup_done);
>> +
>> +	ret = ath11k_wmi_vdev_stop(ar, ar->monitor_vdev_id);
>> +	if (ret)
>> +		ath11k_warn(ar->ab, "failed to request monitor vdev %i stop: %d\n",
>> +			    ar->monitor_vdev_id, ret);
>> +
>> +	ret = ath11k_mac_vdev_setup_sync(ar);
>> +	if (ret)
>> + ath11k_warn(ar->ab, "failed to synchronize monitor vdev %i stop:
>> %d\n",
>> +			    ar->monitor_vdev_id, ret);
>> +
>> +	ret = ath11k_wmi_vdev_down(ar, ar->monitor_vdev_id);
>> +	if (ret)
>> +		ath11k_warn(ar->ab, "failed to put down monitor vdev %i: %d\n",
>> +			    ar->monitor_vdev_id, ret);
>> +
>> +	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac monitor vdev %i stopped\n",
>> +		   ar->monitor_vdev_id);
>> +	return ret;
>> +}
>
> I was not sure what's the idea of error path handling here, we print
> warnings but still continue the normal execution. I changed this so that
> we bail out in the first error and if everything goes well we return 0.

I found quite a few missing error checks, too many to list here but
fixed in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=8b2f8d11422e7909ff02db456cda41728f621de4

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=5ff318be206b3d2a0bfdcfaf0ac52cc3b4ecdeae

Please double check, compile tested only.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
