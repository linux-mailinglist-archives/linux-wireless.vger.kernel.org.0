Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8DA158C08
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 10:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgBKJqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 04:46:34 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:14006 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727947AbgBKJqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 04:46:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581414393; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XmbfhDgeU7lpSNpemQsNQ8B28yn5AsMpAGvUsIt06vc=;
 b=ERdc9qfK6NgB2liV0czwZpdrEWQThsmSmYyZp+wLJz2eb8DqHGlCz2lCKU2/C/jRc3JQ7c6O
 M5YVMvwg0LyPrJ4+bXi8DkvbqbmiDIjz9ZqYOOc++MExd82HkHq0vSR3HBIPJuuXtMaHBou6
 i2VogTgx2xoEw+gJvCG1kTZziJ8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4277f2.7ff3e053d538-smtp-out-n03;
 Tue, 11 Feb 2020 09:46:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 22B96C4479D; Tue, 11 Feb 2020 09:46:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0A01C43383;
        Tue, 11 Feb 2020 09:46:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Feb 2020 17:46:25 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v8 1/4] ath10k: disable TX complete indication of htt for
 sdio
In-Reply-To: <76bce8e3-e05b-ace6-3edd-54f522be3fe6@chromium.org>
References: <20191128103030.6429-1-wgong@codeaurora.org>
 <0101016eb1903db0-ef7063b4-0f42-4a01-8886-327541e6c1a4-000000@us-west-2.amazonses.com>
 <76bce8e3-e05b-ace6-3edd-54f522be3fe6@chromium.org>
Message-ID: <25fd4f59b39c56b2fee208713c7cbc57@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-02-11 15:03, Pi-Hsun Shih wrote:
> Hi,
> 
> On 11/28/19 6:30 PM, Wen Gong wrote:
>> ...
>> diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c 
>> b/drivers/net/wireless/ath/ath10k/htt_tx.c
>> index a182c0944cc7..c6c4b2a4d20f 100644
>> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
>> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
>> @@ -543,7 +543,35 @@ void ath10k_htt_tx_free(struct ath10k_htt *htt)
>>     void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff 
>> *skb)
>>   {
>> +	struct ath10k_htt *htt = &ar->htt;
>> +	struct htt_tx_done tx_done = {0};
>> +	struct htt_cmd_hdr *htt_hdr;
>> +	struct htt_data_tx_desc *desc_hdr;
>> +	u16 flags1;
>> +
>>   	dev_kfree_skb_any(skb);
>> +
>> +	if (!htt->disable_tx_comp)
>> +		return;
>> +
>> +	htt_hdr = (struct htt_cmd_hdr *)skb->data;
> 
> skb is already freed on the above line (dev_kfree_skb_any) but is
> still used here, should the dev_kfree_skb_any be moved to the end of
> this function?
> 
skb will not freed on the above line, please see this patch
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath/ath10k?h=ath-next&id=30382dd1cf3a141bfaa568ee183c1892090fa79a
