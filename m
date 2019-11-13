Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B33F1FA757
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 04:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfKMDh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 22:37:59 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55336 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKMDh7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 22:37:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6DFD160591; Wed, 13 Nov 2019 03:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573616278;
        bh=GEBgaE4DdNY7qFa24EInCgdSI0JAGHtKkaCNGSQWEpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NRtfCdPdoaUfDngdFCmj2RtA5t6p/IyYO/860f6GKn0H4VYasYcGLyBnlX9NrtYhX
         f00+dwv4A0N5jfw9/8JU2uCcRrq1ZhnYSg+/5/zQ2F27hESX681yG1Ch3YyC+I1kTa
         p3fb3Z+3bnNvA2BCMgMFqmGDfC2gLz1lWA+BFBMY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id BCA8C601E7;
        Wed, 13 Nov 2019 03:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573616277;
        bh=GEBgaE4DdNY7qFa24EInCgdSI0JAGHtKkaCNGSQWEpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E8PM8j6AtSy5jbglHF8pcJqGCJ9WhpxRqFw9ZnhJth3HeXGTWPjibTFXg4K1AN6K/
         cpSTv50vWcg2JTU7RAQhCyN/7VBz5KKGSTECycbILk5aUyRTEqojDC6YK5WZwPk9Zp
         qeJ+Bd3+VFET4NdbTgq6jrq5WcRNRjE6URZo28G0=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 13 Nov 2019 11:37:57 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 3/3] ath10k: add workqueue for RX path of sdio
In-Reply-To: <87r22ewqi6.fsf@codeaurora.org>
References: <1569402639-31720-1-git-send-email-wgong@codeaurora.org>
 <1569402639-31720-4-git-send-email-wgong@codeaurora.org>
 <8736f92sfx.fsf@kamboji.qca.qualcomm.com>
 <3f3641ad49a2664d346558760e38b404@codeaurora.org>
 <70f8f208f631a2a2c7337f45b873a16e@codeaurora.org>
 <87r22ewqi6.fsf@codeaurora.org>
Message-ID: <ee6539c50cff626968984df3b511a5a8@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-11-11 20:23, Kalle Valo wrote:
> Wen Gong <wgong@codeaurora.org> writes:
> 
>> On 2019-11-01 15:42, Wen Gong wrote:
>>> On 2019-10-31 17:08, Kalle Valo wrote:
>>> 、> I just realised that this is RX path so we should use
>>> ATH10K_SKB_RXCB()
>>>> instead. I made the change below to this commit in pending branch:
>>>> 
>>> I will test with the new patch together with other performance 
>>> patches.
>> Hi Kalle, I have tested with the patches of pending branch, it is
>> success.
>> result is same with the public review which I tested before.
>> 
>> the patches I tested on pending branch:
>> 
>> ath10k: enable alt data of TX path for sdio
>> ath10k: add htt TX bundle for sdio
>> ath10k: disable TX complete indication of htt for sdio
>> ath10k: enable napi on RX path for sdio
>> ath10k: sdio: remove struct ath10k_sdio_rx_data::status
>> ath10k: sdio: cosmetic cleanup
>> ath10k: add workqueue for RX path of sdio
>> ath10k: change max RX bundle size from 8 to 32 for sdio
>> ath10k: enable RX bundle receive for sdio
> 
> Very good, thanks for testing.
Hi Kalle,

this patch will trigger connect fail for PSK mode AP:
ath10k: add workqueue for RX path of sdio

I have sent patch to fix it:
ath10k: clear ieee80211_rx_status for sdio
