Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F61B9DBE
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2019 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407581AbfIUMCd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 21 Sep 2019 08:02:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53320 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405761AbfIUMCc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 21 Sep 2019 08:02:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DDC661418; Sat, 21 Sep 2019 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569067352;
        bh=y3WyIXKp78T7Z0+PNgpl1qyjz/opNgPzXwSHd3PHFrs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BxBJq7pwqdfuHexW3CH4LaV/0WvCjZqCAqCkUC/GBsFWYPL+wavu9aqbq/KgEldMx
         rej1RISx5gw5EJn/qapylYyebeXkFbGtvltbMqgEnlNvtH6e1yrqEn3ZJT+dQ62Zl7
         kjMEMd0Df2RsZEbt1iMgopNnf2ooN6Y9mP4ubhL0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-106-186.rev.dnainternet.fi [37.136.106.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9EF6660C72;
        Sat, 21 Sep 2019 12:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569067351;
        bh=y3WyIXKp78T7Z0+PNgpl1qyjz/opNgPzXwSHd3PHFrs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=QsmJu8cBnhE7DY+qQns6aJm2JTD6cJqyM4p+bc/65Zexaf5hH8Yd/M1f2le8yAgFx
         2KMgq2c6D7QrnDytxuCkvSlsbItAClbvg6dusMsJ9Laj9db2fkq6NnFmejsYqy/Ne1
         qkixwF3cxlQjKsXokSHVYn5xtvUot3tw3AVpasSU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9EF6660C72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 5/8] ath10k: disable TX complete indication of htt for sdio
References: <1567679893-14029-1-git-send-email-wgong@codeaurora.org>
        <1567679893-14029-6-git-send-email-wgong@codeaurora.org>
Date:   Sat, 21 Sep 2019 15:02:28 +0300
In-Reply-To: <1567679893-14029-6-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Thu, 5 Sep 2019 18:38:10 +0800")
Message-ID: <87v9tlamcr.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> Tx complete message from firmware cost bus bandwidth of sdio, and bus
> bandwidth is the bollteneck of throughput, it will effect the bandwidth
> occupancy of data packet of TX and RX.

TBH I'm not enthuastic about this, this feels an ugly hack. And it adds
yet another module parameter which I detest.

> This patch disable TX complete indication from firmware for htt data
> packet, it results in significant performance improvement on TX path.

So how much does this feature improve through exactly? Do you have any
numbers?

> The downside of this patch is ath10k will not know the TX status of
> the data packet for poor signal situation. Although upper network stack
> or application layer have retry mechanism, the retry will be later than
> ath10k get the TX fail status if not disable TX complete.

I don't understand this description. What's the difference in practise
from user's point of view?

But I think this patch should dropped from the patchset and revisited
after rest of the patches are applied.

-- 
Kalle Valo
