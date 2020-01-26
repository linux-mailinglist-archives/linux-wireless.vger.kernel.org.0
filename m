Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 819A5149B7C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2020 16:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAZPje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 10:39:34 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:36554 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgAZPjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 10:39:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580053173; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=nDbhVB0PL0Z9ZeZHzZJHurvBTfdBcAdeXI2UbJJ30hs=; b=wnREQJmz9jj9ekoabqvxuBr+nrlfehvjt1aUzJqaoVpT+SK+s0mSHRO+5/afp5MPwzfe1h2s
 u3m3Gz711mbFvqu+BwvREFTiycULqS372vBn91jVIzKEQJjtwI6Oa7jdWeKh99CHsS78taD0
 VDjovP2XO/TflZec8wBtZPVAca8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2db2b4.7f7de34299d0-smtp-out-n01;
 Sun, 26 Jan 2020 15:39:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 46139C43383; Sun, 26 Jan 2020 15:39:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1E3EC433CB;
        Sun, 26 Jan 2020 15:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1E3EC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     <yhchuang@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>
Subject: Re: [PATCH 01/11] rtw88: fix rate mask for 1SS chip
References: <20191220092156.13443-2-yhchuang@realtek.com>
        <20200126153842.DF08CC447A1@smtp.codeaurora.org>
Date:   Sun, 26 Jan 2020 17:39:28 +0200
In-Reply-To: <20200126153842.DF08CC447A1@smtp.codeaurora.org> (Kalle Valo's
        message of "Sun, 26 Jan 2020 15:38:42 +0000 (UTC)")
Message-ID: <87k15exm4v.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> <yhchuang@realtek.com> wrote:
>
>> From: Ping-Ke Shih <pkshih@realtek.com>
>> 
>> The rate mask is used to tell firmware the supported rate depends on
>> negotiation. We loop 2 times for all VHT/HT 2SS rate mask first, and then
>> only keep the part according to chip's NSS.
>> 
>> This commit fixes the logic error of '&' operations for VHT/HT rate, and
>> we should run this logic before adding legacy rate.
>> 
>> To access HT MCS map, index 0/1 represent MCS 0-7/8-15 respectively. Use
>> NL80211_BAND_xxx is incorrect, so fix it as well.
>> 
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>> Reviewed-by: Chris Chiu <chiu@endlessm.com>
>
> 9 patches applied to wireless-drivers-next.git, thanks.
>
> 35a68fa5f96a rtw88: fix rate mask for 1SS chip
> 73a2d0b83424 rtw88: fix TX secondary channel offset of 40M if current bw is 20M or 40M
> e339b6493524 rtw88: 8822c: update power sequence to v15
> 3f43f10bd619 rtw88: remove unused spinlock
> 962562cde154 rtw88: remove unused variable 'in_lps'
> 65ae64d37575 rtw88: remove unused vif pointer in struct rtw_vif
> fc83c616d4d9 rtw88: use rtw_hci_stop() instead of rtwdev->hci.ops->stop()
> f48abf064ade rtw88: assign NULL to skb after being kfree()'ed
> bbdd1d854e0a rtw88: change max_num_of_tx_queue() definition to inline in pci.h

I dropped patches 3 and 5 as they had comments.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
