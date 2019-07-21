Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C004D6F29C
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jul 2019 12:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfGUK2Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Jul 2019 06:28:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50356 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfGUK2Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Jul 2019 06:28:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 52A9260C60; Sun, 21 Jul 2019 10:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563704903;
        bh=kD5iFpMQDyZoB1AMJrJ6Nu/Cpk0yTJrch8RqYZ0t3Hc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=akb6TljbMGmPVUJ8T/yHxR/wNky5DZrHaVqrH1cRKyj0i23vBoFBmuDwv1QtwwjG8
         f/1iRNIZ0kYTVEDW9L/LsM/XizSYgG9uvw/lNTjk/tlFcFbamcgSzl9cHD2sn92kNE
         ymPMxbcesI8xFyZPIa98d64uUoEnakIXa+1Bv3nA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C77FE6087F;
        Sun, 21 Jul 2019 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563704902;
        bh=kD5iFpMQDyZoB1AMJrJ6Nu/Cpk0yTJrch8RqYZ0t3Hc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gaPZ5BvLoZkI8tHv65o77exAADkP4LQ1vPoClWVY6ZwHCQxIkRYDTjQMjY/krgOjF
         1n7dJoIUiCqZYtlINQVSTRc8Ynco+qw7kBCxI9aTF+XtKNRQVtwqxsqwTx4U1vulav
         iNEs/DE5GiWseK8+Yk+q0iFgYhUIEP21lQ65r66U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C77FE6087F
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
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] mt76: mt7615: add cwmin/cwmax initial values
References: <50d28c9b0f9e7d6b277d36fc93f55142d7535259.1563518381.git.ryder.lee@mediatek.com>
        <c83e14787bc86f8f8062e0aa44e03ef80c3fd38a.1563518381.git.ryder.lee@mediatek.com>
Date:   Sun, 21 Jul 2019 13:28:18 +0300
In-Reply-To: <c83e14787bc86f8f8062e0aa44e03ef80c3fd38a.1563518381.git.ryder.lee@mediatek.com>
        (Ryder Lee's message of "Fri, 19 Jul 2019 14:55:36 +0800")
Message-ID: <877e8bsmv1.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ryder Lee <ryder.lee@mediatek.com> writes:

> Add initial values in mt7615_mcu_set_wmm() to cleanup setup flow.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

[...]

> -#define WMM_AIFS_SET	BIT(0)
> -#define WMM_CW_MIN_SET	BIT(1)
> -#define WMM_CW_MAX_SET	BIT(2)
> -#define WMM_TXOP_SET	BIT(3)
> +#define WMM_PARAM_SET	GENMASK(3, 0)

I don't see how this is any better? IMHO you just hide what is the
meaning of each bit.

-- 
Kalle Valo
