Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E787171446
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 10:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfGWIo2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 04:44:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfGWIo2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 04:44:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CC13B619F2; Tue, 23 Jul 2019 08:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563871467;
        bh=kxLkewl6Q0I7FEEg5DZ7f85vkdxTUMfxwv/cP5k0pDU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=A5hc6X5yO7V5UiU3S+bl/GseWX/nUvUy++zDnLFXa29aP70vI0agR22onPyXAg9ip
         7F6KQCcDUMkLJ8Vc0yjxhCCP+uQpzrFY6w4hT+8hTV74zT5Y1LNdl4tPIQ/L4Q9PBx
         LUM0bEX/1ggK2wQDLPRGyp1Wb86BuImQ2Jjv+7ek=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3333B619D1;
        Tue, 23 Jul 2019 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563871460;
        bh=kxLkewl6Q0I7FEEg5DZ7f85vkdxTUMfxwv/cP5k0pDU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bfGBP0tetY8pP6f/42+dnDskyxyBz2Z7A6NaSNlgcj2mcCc6eldKZjp5PAIjaaI1E
         NTgK9VK3+5hq+5FUk8EakAZ+C6UzOxOKfZDqIYApCe7SRfJc5wZMKTde1UbTxsEk0T
         nIeI3p6myEvivgORGgyBTpMGl9eKYYBjYa58h1vc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3333B619D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Roy Luo <royluo@google.com>, YF Luo <yf.luo@mediatek.com>,
        Yiwei Chung <yiwei.chung@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 0/5] fix many checkpatch.pl warnings
References: <cover.1563772403.git.ryder.lee@mediatek.com>
Date:   Tue, 23 Jul 2019 11:44:16 +0300
In-Reply-To: <cover.1563772403.git.ryder.lee@mediatek.com> (Ryder Lee's
        message of "Mon, 22 Jul 2019 13:31:10 +0800")
Message-ID: <8736ixrvhb.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> This gathers many subsets to fix checkpatch.pl warnings.

Thanks, this is much better now.

> I still keep some warnings there due to readability.
> (The most of them are - networking block comments or 80 characters limit)

I do the same in ath10k. BTW, here's my simple script which I use to
filter unwanted checkpatch warnings etc:

https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath10k/ath10k-check

-- 
Kalle Valo
