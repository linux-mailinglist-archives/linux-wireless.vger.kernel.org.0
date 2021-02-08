Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2670C313A8B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 18:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhBHRMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 12:12:31 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:23041 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230125AbhBHRLY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 12:11:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612804261; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=j4v1m7WvFUznw6JnVEh5YmNm65JzeRSJWKDypgu7710=; b=ECsiJi85g1MamVqBM3xVuOesRcftrTA0wzkNNNryaOGyPa6IbloXwkKDqdc7Ue8CSRSlzDf8
 4N1BP8q+w0ruXp/fqHabrT8F+TJSC0/AXqsNP+TnWpVs8wOfKnvYPT3FJUuwDOsFac+DFJLg
 Ss198860b3oSsJhafjRZaAurFKU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60217078e4842e9128a0ffce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 17:10:16
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B34ECC433ED; Mon,  8 Feb 2021 17:10:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4A135C433C6;
        Mon,  8 Feb 2021 17:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4A135C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-01-29
References: <3eba5570-7cff-f51e-4050-aa0054f98f81@nbd.name>
        <20210208102728.F3395C43461@smtp.codeaurora.org>
        <00fa069f-3174-85fa-f4d1-fb4e403a9401@nbd.name>
Date:   Mon, 08 Feb 2021 19:10:12 +0200
In-Reply-To: <00fa069f-3174-85fa-f4d1-fb4e403a9401@nbd.name> (Felix Fietkau's
        message of "Mon, 8 Feb 2021 12:40:02 +0100")
Message-ID: <87lfby4haj.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

>> This had conflicts:
>> 
>> $ git pull https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-01-29
>>>From https://github.com/nbd168/wireless
>>  * tag                         mt76-for-kvalo-2021-01-29 -> FETCH_HEAD
>> Auto-merging drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>> CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>> Auto-merging drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
>> Automatic merge failed; fix conflicts and then commit the result.
>> 
>> With this commit from w-d:
>> 
>> b7c568752ef3 mt76: Fix queue ID variable types after mcu queue split
>> 
>> And these commits from your tag:
>> 
>> b8135057988e mt76: mt7915: simplify mt7915_mcu_send_message routine
>> c203dd621780 mt76: mt7915: rework mcu API
>> 
>> This was not easy to fix. Felix & Lorenzo, please carefully check my resolution
>> in the pending branch:
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=dfe85c17c7c7183e1d409b948fae9d8e545cb25d
>> 
>> This is the diff output of my resolution:
>> 
>> diff --cc drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>> index e211a2bd4d3c,0296f2aa7997..000000000000
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
>> @@@ -267,22 -260,16 +260,16 @@@
>>         if (!seq)
>>                 seq = ++dev->mt76.mcu.msg_seq & 0xf;
>>   
>> -       if (cmd == -MCU_CMD_FW_SCATTER) {
>>  -      if (cmd == MCU_CMD(FW_SCATTER)) {
>>  -              txq = MT_MCUQ_FWDL;
>> ++      if (cmd == MCU_CMD_FW_SCATTER) {
>
> This needs to be if (cmd == MCU_CMD(FW_SCATTER))
> The rest looks good to me.

Thanks. Pulled manually, fixed that and pushed to master branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
