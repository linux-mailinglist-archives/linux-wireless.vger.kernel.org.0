Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3E4126FB
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 07:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfECFFz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 01:05:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49884 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECFFz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 01:05:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DBC19611FA; Fri,  3 May 2019 05:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556859954;
        bh=F+twRZuYtMfzGNKN2y3io8vWyqlHIqIv5xB4evmZB+g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kl4c7PX8dEOBgsfdgr5ocdMw7n5FQO3jIrXffGOlLT6E6y35hsKQzVJqbRR9GnUms
         +Ut2zBe+aresw7fwiKA8yrJoUiHpCWM8YXJw4I78jyM70Rs6FuDIGjuQTmEieM4blL
         uldKj/hNhwhwyZTMUmap3njXq21wPJCh3HX9XvmM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B12A611C3;
        Fri,  3 May 2019 05:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556859954;
        bh=F+twRZuYtMfzGNKN2y3io8vWyqlHIqIv5xB4evmZB+g=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=OiRu0WUNFwgN6dwjrLNZQo9yhzAk0LIR1E97YClK7cQxgFM8W8B/o741QzqVSca16
         0i8RS0dmPFfsolN+COH4FC+U2Mx+wxxk2VdL/HDKZMhUW4jOw5eZTKB+g0JWDQGH4y
         EkW1aJg3Xy4ppqRzDHP9sVP6CYSasnPlPZce2ckc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B12A611C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] wil6210: fix spurious interrupts in 3-msi
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556293417-27097-2-git-send-email-merez@codeaurora.org>
References: <1556293417-27097-2-git-send-email-merez@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190503050554.DBC19611FA@smtp.codeaurora.org>
Date:   Fri,  3 May 2019 05:05:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:

> Interrupt is set in ICM (ICR & ~IMV) rising trigger.
> As the driver masks the IRQ after clearing it, there can
> be a race where an additional spurious interrupt is triggered
> when the driver unmask the IRQ.
> This can happen in case HW triggers an interrupt after the clear
> and before the mask.
> 
> To prevent the second spurious interrupt the driver needs to mask the
> IRQ before reading and clearing it.
> 
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

9 patches applied to ath-next branch of ath.git, thanks.

e10b0eddd523 wil6210: fix spurious interrupts in 3-msi
9c6465979276 wil6210: fix _desc access in __wil_tx_vring_tso
0131d1851338 wil6210: add printout of platform capabilities
a7feb56f204f wil6210: add support for multiple sections in brd file
9a874d045473 wil6210: enhancements for descriptor and status ring debugfs
ddf7afdde824 wil6210: fix overwriting max_assoc_sta module param
7441be71ba7e wil6210: fix missed MISC mbox interrupt
d6a553c0c61b wil6210: check rx_buff_mgmt before accessing it
3d0aa9198446 wil6210: remove HALP for Talyn devices

-- 
https://patchwork.kernel.org/patch/10919277/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

