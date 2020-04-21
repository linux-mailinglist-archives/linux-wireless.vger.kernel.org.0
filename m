Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6E1B26D5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgDUM4t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 08:56:49 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52789 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgDUM4t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 08:56:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587473808; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=jlb1jd3wJwPiRDLqG4rfl3lOfJ0dqqd6GGvhXRIuAt4=; b=RPMNta8eFRxnU7qi0RUhH/KyaGfAy6yAQJuKg+mHKm2BD0qf6hP6Fsor/Z/auTBF6S2wEMvr
 TJyYa8aLAS2hrxfONBTB5qI5uNpCzNHlQBCFQ0o22nxw6TIoVJwV8Fdu3hDIP69PqSlwAkk1
 4tiF5K0tiMqjVztgHB/PwlxrobU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9eed8f.7f54181a6848-smtp-out-n04;
 Tue, 21 Apr 2020 12:56:47 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 13762C432C2; Tue, 21 Apr 2020 12:56:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8044FC433BA;
        Tue, 21 Apr 2020 12:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8044FC433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <kvalo@codeaurora.org>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] rtw88: 8723d: Add read_efuse to recognize efuse info from map
References: <20200420055054.14592-1-yhchuang@realtek.com>
        <20200420055054.14592-9-yhchuang@realtek.com>
Date:   Tue, 21 Apr 2020 15:56:41 +0300
In-Reply-To: <20200420055054.14592-9-yhchuang@realtek.com> (yhchuang's message
        of "Mon, 20 Apr 2020 13:50:54 +0800")
Message-ID: <87lfmpj8ty.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Ping-Ke Shih <pkshih@realtek.com>
>
> The logical efuse map is decoded from physical map by parsing the
> header format of the physical map. And each different type of chips
> has different logical efuse layout. So add the logical map's layout
> for parsing the efuse contents.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

[...]

> +static void rtw8723de_efuse_parsing(struct rtw_efuse *efuse,
> +				    struct rtw8723d_efuse *map)
> +{
> +	ether_addr_copy(efuse->addr, map->e.mac_addr);
> +}

Feels like an unnecessary extra function to me. But not a big deal, no
need to resend because of this.

And thanks for splitting the patches, makes my life a lot more pleasant :)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
