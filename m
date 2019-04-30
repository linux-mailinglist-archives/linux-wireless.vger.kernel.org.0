Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA58F796
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 14:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfD3MAg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 08:00:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42096 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfD3MAf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 08:00:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C7B1A60A44; Tue, 30 Apr 2019 12:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556625634;
        bh=LbqOttWCDNF4UpbUtc7p4YaKq8WmZv2WxQcrvtfdo28=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NXM+1bI7fQr5eYvjPLT91hjZIbyDlVmFVXKMOQ/ptuIV0rpkGQ2Av3oBtjcd9hbs9
         doPvmt69iOeXwPv3O62eWvzpu1npAogUrXDqemsuV8OsJUJl5m7MpjjNdmbC84LyxD
         kCS3pZ2CLzt6NGFAhm4BpDfSt169PMCO70gKVWdQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FB9F6074F;
        Tue, 30 Apr 2019 12:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556625634;
        bh=LbqOttWCDNF4UpbUtc7p4YaKq8WmZv2WxQcrvtfdo28=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NXM+1bI7fQr5eYvjPLT91hjZIbyDlVmFVXKMOQ/ptuIV0rpkGQ2Av3oBtjcd9hbs9
         doPvmt69iOeXwPv3O62eWvzpu1npAogUrXDqemsuV8OsJUJl5m7MpjjNdmbC84LyxD
         kCS3pZ2CLzt6NGFAhm4BpDfSt169PMCO70gKVWdQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FB9F6074F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        <pkshih@realtek.com>, <tehuang@realtek.com>,
        <Larry.Finger@lwfinger.net>, <sgruszka@redhat.com>,
        <briannorris@chromium.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v9 09/14] rtw88: chip files
References: <1555653004-1795-1-git-send-email-yhchuang@realtek.com>
        <1555653004-1795-10-git-send-email-yhchuang@realtek.com>
        <87d0l3rdpp.fsf@kamboji.qca.qualcomm.com>
Date:   Tue, 30 Apr 2019 15:00:29 +0300
In-Reply-To: <87d0l3rdpp.fsf@kamboji.qca.qualcomm.com> (Kalle Valo's message
        of "Tue, 30 Apr 2019 13:26:26 +0300")
Message-ID: <87wojbwvmq.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> <yhchuang@realtek.com> writes:
>
>> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>>
>> chip files Realtek 802.11ac wireless network chips
>> 8822B & 8822C series files
>>
>> Reviewed-by: Stanislaw Gruszka <sgruszka@redhat.com>
>> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> [...]
>
>> +static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
>> +	{0x0086,
>> +	 RTW_PWR_CUT_ALL_MSK,
>> +	 RTW_PWR_INTF_SDIO_MSK,
>> +	 RTW_PWR_ADDR_SDIO,
>> +	 RTW_PWR_CMD_WRITE, BIT(0), 0},
>
> I see lots of arrays like this which are not const. I think they should
> be const.

And I'm seeing even more of these while I review the driver. So
basically all static variables should be const to make sure you don't
accidentally between driver instances. IIRC there was something in
cfg80211 API which prevent to use const (maybe the channels? can't
remember now) but that's just an exception to the rule.

-- 
Kalle Valo
