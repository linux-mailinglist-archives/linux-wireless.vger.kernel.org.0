Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BC152292
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 07:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfFYFJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 01:09:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42366 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFYFJa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 01:09:30 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7CF0760117; Tue, 25 Jun 2019 05:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439369;
        bh=Pka2jAN8vSAjTwJ2G/4rfb0Lb8Ws3IBMHseNlBa7qn8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=J5LwtY9u7X4y0tZNwaQgy9Qs20OKdSXugWu65+oCSsd4z8P4v0LmpNbmy5f2rroHh
         UWPBPofO59bQ4OJt4SI5FwABkg29ZZ10JdFDr9PWCbQ4Qal8yw2qjhdHZCO1c4Dq8r
         o1tHkFwERjB7KlvxBzbHKYPzThdTpSlBw2iEIlHw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 83B13601E7;
        Tue, 25 Jun 2019 05:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561439369;
        bh=Pka2jAN8vSAjTwJ2G/4rfb0Lb8Ws3IBMHseNlBa7qn8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=GQakgPE3uycAM7DYP74kcPp23Mwt4V86liu+dMM7/dz9FeVKEUJTtC9Qff3cqq5ul
         ssssdPnkjAjetwUhoGiBR4/9dOfOaVa8MdzvixJ1I5w62qua6jIbV2JbOotyq7/Oqq
         YlPSJAwE28TwwJEfTRbahnNFSrVxruUQpS/j7T3o=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83B13601E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/11] rtw88: add fast xmit support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1560497055-17197-2-git-send-email-yhchuang@realtek.com>
References: <1560497055-17197-2-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190625050929.7CF0760117@smtp.codeaurora.org>
Date:   Tue, 25 Jun 2019 05:09:29 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> With dynamic power save support, rtw88 is able to support fast tx
> path, claim it to mac80211.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

11 patches applied to wireless-drivers-next.git, thanks.

e6fec313fa3f rtw88: add fast xmit support
44cc4c63a877 rtw88: add support for random mac scan
6fabdc4a34d0 rtw88: add beacon function setting
818d46e7715e rtw88: 8822c: add rf write protection when switching channel
f859e71f9615 rtw88: 8822c: update channel and bandwidth BB setting
e027446667b5 rtw88: 8822c: disable rx clock gating before counter reset
e1cc056c92f9 rtw88: 8822c: use more accurate ofdm fa counting
d41673b941f2 rtw88: power on again if it was already on
a11cddd42b67 rtw88: restore DACK results to save time
e9c87a3b744b rtw88: rsvd page should go though management queue
4a36de3996c7 rtw88: fix typo rtw_writ16_set

-- 
https://patchwork.kernel.org/patch/10994533/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

