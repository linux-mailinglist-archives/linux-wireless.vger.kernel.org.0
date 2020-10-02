Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AAC280E91
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 10:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBIOf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 04:14:35 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:64195 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgJBIOf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 04:14:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601626474; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=1tva/yFuxdlSYrutZcd3hM41HpxcP4fzCMnfphofrQM=; b=WrC6zDXz3lYCpfHihZyrnodeAgl3tuu/M0ngkKV+NcBBznttVyPbPbFmNkWY0d4nJJDTEn3V
 ENh6ys0UDjSmI2r7Mzbj0k7PF/B/wWmjJ/ECL4I5eQQAKUklkTtSlKO3zY5NLSII4Aa+K/Un
 1d0cVy/rRs0fzj92z5aXoMvh43U=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f76e16ad90823fe0fc2f603 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Oct 2020 08:14:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6C924C433FE; Fri,  2 Oct 2020 08:14:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 408C8C433CA;
        Fri,  2 Oct 2020 08:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 408C8C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     tehuang@realtek.com, yhchuang@realtek.com,
        linux-wireless@vger.kernel.org, clang-built-linux@googlegroups.com,
        arnd@arndb.de
Subject: Re: [PATCH 3/5] rtw88: add dump firmware fifo support
References: <20200925061219.23754-1-tehuang@realtek.com>
        <20200925061219.23754-4-tehuang@realtek.com>
        <20201001190641.GA3723966@ubuntu-m3-large-x86>
Date:   Fri, 02 Oct 2020 11:14:29 +0300
In-Reply-To: <20201001190641.GA3723966@ubuntu-m3-large-x86> (Nathan
        Chancellor's message of "Thu, 1 Oct 2020 12:06:41 -0700")
Message-ID: <87d021cae2.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ arnd

Nathan Chancellor <natechancellor@gmail.com> writes:

>> +int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
>> +		     u32 *buffer)
>> +{
>> +	if (!rtwdev->chip->fw_fifo_addr) {
>
> This causes a clang warning, which points out it is probably not doing
> what you think it is:
>
> drivers/net/wireless/realtek/rtw88/fw.c:1485:21: warning: address of
> array 'rtwdev->chip->fw_fifo_addr' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (!rtwdev->chip->fw_fifo_addr) {
>             ~~~~~~~~~~~~~~~^~~~~~~~~~~~
> 1 warning generated.
>
> Was fw_fifo_addr[0] intended or should the check just be deleted?

BTW what is the easiest way to install clang for build testing the
kernel? For GCC I use crosstool[1] which is awesome as it makes the
installation so simple, do we have something similar for clang?

Just supporting x86 would be fine, as my use case would be just to
reproduce build warnings.

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
