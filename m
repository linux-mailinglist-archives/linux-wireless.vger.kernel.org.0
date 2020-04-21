Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05551B26FA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2020 15:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgDUNAZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 09:00:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:46682 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgDUNAZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 09:00:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587474025; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=EYuo6FOuAWQ686k65A3Cp1Hg2CeNjbPF9b6zikG6xeg=;
 b=xQpSrnDwA64AnOE+Vzixg10YmicxYGQH7d2chDQMUxbdvt7zV+ynEZOXcU9D69t/XVLkrvoG
 7GmuZQfHbTry/kC0r4e2aC90BoxhbXexVq4HW5JSy6uO9Ko6VJrQBM72vV+M5BR5sNVj1GbA
 qvL7n7hJ5L+6kEfriw9bXOvGy1A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9eee56.7ff5c6519ab0-smtp-out-n05;
 Tue, 21 Apr 2020 13:00:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B63E4C433F2; Tue, 21 Apr 2020 13:00:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8EA46C433D2;
        Tue, 21 Apr 2020 13:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8EA46C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/8] rtw88: 8723d: Add basic chip capabilities
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200420055054.14592-2-yhchuang@realtek.com>
References: <20200420055054.14592-2-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200421130004.B63E4C433F2@smtp.codeaurora.org>
Date:   Tue, 21 Apr 2020 13:00:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Ping-Ke Shih <pkshih@realtek.com>
> 
> RTL8723DE is an 11n 1x1 2.4G single band chip with the
> following capabilities:
> 
>  - TX/RX BD size: 16/8
>  - TX/RX desc size: 40/24
>  - physical/logical/protected efuse size: 512/512/96
>  - TX gain index factor: 1
>  - max TX power index: 0x3F
>  - band: 2G
>  - HT: support
>  - VHT: Not support
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

8 patches applied to wireless-drivers-next.git, thanks.

811853da541a rtw88: 8723d: Add basic chip capabilities
93ae973fb47d rtw88: 8723d: add beamform wrapper functions
c57bd7c3af99 rtw88: 8723d: Add power sequence
e0c27cdbbd41 rtw88: 8723d: Add RF read/write ops
9874f6851e47 rtw88: 8723d: Add mac/bb/rf/agc/power_limit tables
1afb5eb7a00d rtw88: 8723d: Add cfg_ldo25 to control LDO25
44baa97ca820 rtw88: 8723d: Add new chip op efuse_grant() to control efuse access
ab0a031ecf29 rtw88: 8723d: Add read_efuse to recognize efuse info from map

-- 
https://patchwork.kernel.org/patch/11498093/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
