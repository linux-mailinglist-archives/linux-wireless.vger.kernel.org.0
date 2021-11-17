Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FBE4543CC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhKQJjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 04:39:11 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:47729 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbhKQJiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 04:38:14 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637141716; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=J9v9JrVfSADEur5gzTe1RmMYOu6pmmlAHUSlI2g3aXo=;
 b=I5/aG+3dzSaMSnd6icHFIDtYU5G23PzyE0EeH1+IjvCDpNuivxZdv1chY6iKVc345De/nJRI
 aSHfD+SGlmlhV74llUMFiOrMUJPfUltEGSO8WTrKoZ3dU6at7OZwmlqFUWH7nbKtN6ZhlgzL
 L1HiZ3haj2tcJ7nby7OVa5CVsF0=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6194ccd4638a2f4d6163f3f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Nov 2021 09:35:16
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 42871C4360C; Wed, 17 Nov 2021 09:35:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCE7BC43618;
        Wed, 17 Nov 2021 09:35:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Nov 2021 17:35:14 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ath11k: add feature for device recovery
In-Reply-To: <87sfvvdx1f.fsf@codeaurora.org>
References: <20211015035459.14190-1-wgong@codeaurora.org>
 <87h7cdh970.fsf@codeaurora.org>
 <a9efda4011061f2f0d57ea597b9b8f0e@codeaurora.org>
 <87sfvvdx1f.fsf@codeaurora.org>
Message-ID: <21a93f4c93e636b47bd04e75cae90461@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-17 16:08, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> On 2021-11-15 20:53, Kalle Valo wrote:
>>> Wen Gong <wgong@codeaurora.org> writes:
>>> 
>>>> From: Wen Gong <quic_wgong@quicinc.com>
>>>> 
...
>>> 
>> 
>> I have sent v4, it is not to fix your fail:)
>> It added patch "ath11k: fix invalid m3 buffer address".
>> https://patchwork.kernel.org/project/linux-wireless/cover/20211116041522.23529-1-quic_wgong@quicinc.com/
>> 
>> 
>>> Also there should be a clear ath11k_warn() message when firmware
>>> recovery was successful, I could not find one from patches.
>> 
>> Yes, if recovery succes, it will have "success" log.
> 
> Where are the printouts? I cannot find any ath11k_warn() messages in 
> v4.
> Basically I would want to see something like this when the firmware
> crashes:

It is not print in this patch.
It is here:

ath11k_mac_op_reconfig_complete(struct ieee80211_hw *hw,
				enum ieee80211_reconfig_type reconfig_type)
	if (ar->state == ATH11K_STATE_RESTARTED) {
		ath11k_warn(ar->ab, "pdev %d successfully recovered\n",
			    ar->pdev->pdev_id);

> 
> firmware crashed, restarting it
> 
> And once the firmware is running again:
> 
> firmware restarted succesfully

"firmware crashed" log is here:
static void ath11k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
				    enum mhi_callback cb)
{
	struct ath11k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
	struct ath11k_pci *ar_pci = ath11k_pci_priv(ab);

	switch (cb) {
	case MHI_CB_SYS_ERROR:
		ath11k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
