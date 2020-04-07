Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD601A0700
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgDGGIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 02:08:52 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52138 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgDGGIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 02:08:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586239731; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=plPh33tcSqADjZ5N/FxeriOzadskWCCkz6NB8hSkUpQ=; b=f4LflYSLDiCgkXLWCxYKzk3N+7wtoMiKiDHIVzAUNBRnT5QQe7hc4b3lQSNdtB0uh7amz9KU
 I4q3YSGAEF9SA9crJQ+x13a3CN3+xzYkPBOS1p0kU2Z+wUki/LWjW4XN8trvZp8tjCOGo0X0
 IyQes5URcz4kEYF8EA4MW+PfoKI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c18f2.7f686b35e8b8-smtp-out-n04;
 Tue, 07 Apr 2020 06:08:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E735C43636; Tue,  7 Apr 2020 06:08:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E14EDC433D2;
        Tue,  7 Apr 2020 06:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E14EDC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 1/4] ath10k: disable TX complete indication of htt for sdio
References: <20200212080415.31265-2-wgong@codeaurora.org>
        <20200407054431.6B2A0C433BA@smtp.codeaurora.org>
        <84039fe1187e3ec7546edd4f9fe5600a@codeaurora.org>
Date:   Tue, 07 Apr 2020 09:08:46 +0300
In-Reply-To: <84039fe1187e3ec7546edd4f9fe5600a@codeaurora.org> (Wen Gong's
        message of "Tue, 07 Apr 2020 14:04:58 +0800")
Message-ID: <87mu7nx1xt.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> On 2020-04-07 13:44, Kalle Valo wrote:
>
>> This has new warnings:
>>
>> drivers/net/wireless/ath/ath10k/htt_tx.c: In function
>> 'ath10k_htt_htc_tx_complete':
>> drivers/net/wireless/ath/ath10k/htt_tx.c:566:30: warning: 'msg_type'
>> may be used uninitialized in this function [-Wmaybe-uninitialized]
>> drivers/net/wireless/ath/ath10k/htt_tx.c:573:6: warning: 'flags1' may
>> be used uninitialized in this function [-Wmaybe-uninitialized]
>> drivers/net/wireless/ath/ath10k/htt_tx.c:577:42: warning: 'desc_hdr'
>> may be used uninitialized in this function [-Wmaybe-uninitialized]
>>
>
> I already run ath10k-check, but not see these warnings.
> my gcc: gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
> so is it because my gcc too version too low?

Most likely, I'm using 9.2 from crosstool:

x86_64-linux-gcc (GCC) 9.2.0

crosstool is a handy way to install GCC for kernel compilations, here
are my notes:

listings: https://www.kernel.org/pub/tools/crosstool/

wget https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.1.0/x86_64-gcc-8.1.0-nolibc-x86_64-linux.tar.xz
pushd /opt/cross/
tar -xf ~/tmp/crosstool/x86_64-gcc-8.1.0-nolibc-x86_64-linux.tar.xz

In top level create GNUMakefile:

CROSS_COMPILE=/opt/cross/gcc-8.1.0-nolibc/x86_64-linux/bin/x86_64-linux-
include Makefile

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
