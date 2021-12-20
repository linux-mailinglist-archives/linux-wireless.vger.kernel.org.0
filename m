Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B637C47B332
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 19:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbhLTStT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 13:49:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57368 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240587AbhLTStS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 13:49:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F29B612A1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 18:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611FDC36AE2;
        Mon, 20 Dec 2021 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640026157;
        bh=sqZ58pUg04jlgLVsb61HIZZdbxYIieoKBD7suo7EgSI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mYgD+yiXaLMBNzK3BSRBMNgNuyML4mvrR6KdTOGI3+DtNGOooj3gff0jgQvxJYxpr
         ZEBQnhwfiBxNtuU7K37ifdLgbSOiKqQ/mF6kQxBoh/7dPWBXO5F9CNHcpPUtQ3FvRD
         HZiTL8daA5Q6ZW8E6bAipwlOAQaVnI80d8fi94+t71M17q3T2+i4qUxmWXtR1dFu/d
         es0P7fPxJcCnrNf7j+FO6pRb7OCMrxn4KSIPctGQ3SjPmSHXJcZ1ny+jM9SgdmXntE
         seTHF9D8v+lCvjgbP3ZY14y94fulWmEVprMK50G+YA9o1Aeimz1pVcJjArQNBMQF3s
         Kq99QWcYLbIfw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: don't check CRC of VHT-SIG-B in 802.11ac signal
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211217012421.7859-1-pkshih@realtek.com>
References: <20211217012421.7859-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>,
        <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164002615472.16553.5108180195660301786.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 18:49:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Currently all realtek wifi chip is set to check CRC of VHT-SIG-B
> in 802.11ac signal, but some AP don't calculate the CRC and packets
> from these AP can't be received and lead to disconnection.
> We disable the check defaultly to avoid this case.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-drivers-next.git, thanks.

a3fd1f9aa79a rtw88: don't check CRC of VHT-SIG-B in 802.11ac signal

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211217012421.7859-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

