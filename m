Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA180336BD7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Mar 2021 07:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCKGBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Mar 2021 01:01:44 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:20807 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhCKGBa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Mar 2021 01:01:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615442490; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=iuDEpevXVvAPqRWOTgajEvmqN5hL4zfyLG6VEFB+gCk=; b=cZZLyyTIDWb5AwnoCXW6lIAPJiIjjtFV4vZmdBukoYf5swEpsV1tJamF8hhAJXvW5VtWCpza
 H8pm6EcF9I7sQQJJh1i9Gwu8Fke7eYBvjX+U6hqmYmbOH+jPJyRk/8uf0hm9JjBtewMdZMmE
 AuAYwWWFUm05W6RDhc8IP8M47zA=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6049b233d3a53bc38f6134df (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Mar 2021 06:01:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5B0FC433ED; Thu, 11 Mar 2021 06:01:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E57E5C433C6;
        Thu, 11 Mar 2021 06:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E57E5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH V5 1/2] ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
References: <20210222192651.1782-2-alokad@codeaurora.org>
        <20210309105025.72246C43462@smtp.codeaurora.org>
        <347ccb1006ce48ff6da270560c867c06@codeaurora.org>
Date:   Thu, 11 Mar 2021 08:01:18 +0200
In-Reply-To: <347ccb1006ce48ff6da270560c867c06@codeaurora.org> (Aloka Dixit's
        message of "Wed, 10 Mar 2021 10:42:55 -0800")
Message-ID: <87czw6z0sx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <alokad@codeaurora.org> writes:

> On 2021-03-09 02:50, Kalle Valo wrote:
>> Aloka Dixit <alokad@codeaurora.org> wrote:
>>
>>> These calls are used for debugging and will be required for WFA
>>> certification tests.
>>>
>>> Signed-off-by: John Crispin <john@phrozen.org>
>>> Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
>>> Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>
>> This patchset had new warnings:
>>
>> drivers/net/wireless/ath/ath11k/debugfs.c:16:15: warning: symbol
>> 'debugfs_ath11k' was not declared. Should it be static?
>
> This patch-set doesn't add any reference to 'debugfs_ath11k', so
> don't know why this warning came up.

Ah, sorry. That's coming from Anil's debugfs patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
