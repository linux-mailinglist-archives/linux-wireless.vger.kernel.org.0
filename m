Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 689F7A6A31
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfICNlf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:41:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52658 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICNlf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:41:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4D3D460592; Tue,  3 Sep 2019 13:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518094;
        bh=UMXqbDxZX0xCl2r/+tUes0XSAmBhNXUCdxAZRa/JZkY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Acw4fXWJzosDcBwn6YqSGAHB1O6McQTEgG0rAAlHXPl/UQEVzJjzsbE9v/HqGy0JE
         z7z2tZydrRihRhKPFCjcIEMxnJEKZLtxmlQpXX1FlVxLeq6WajFMMkqt8sWPrYlTD8
         CloD0AaePwBHpLM4CpULRva+c95SIJpHb0wzOqww=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB6F160C5F;
        Tue,  3 Sep 2019 13:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518093;
        bh=UMXqbDxZX0xCl2r/+tUes0XSAmBhNXUCdxAZRa/JZkY=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=PftzXhPubuEH09ReMtdtoDIJjpXP0UDgc+EFfMlGBxjPaXOtv7l9jHIiOszcPJvst
         Ii/vs/hss/wENPDm7V2ARGvxK7QAh5WBZccZQp9PrXxmKii8HydVd9qrepr4L978xt
         l28VoW069EJSjDfcWfe5PFKDsSs2e8VOLWcVj/fQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB6F160C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rt2x00: do not set IEEE80211_TX_STAT_AMPDU_NO_BACK on tx
 status
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1566544196-20371-1-git-send-email-sgruszka@redhat.com>
References: <1566544196-20371-1-git-send-email-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903134134.4D3D460592@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:41:34 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> According to documentation IEEE80211_TX_STAT_AMPDU_NO_BACK is suppose
> to be used when we do not recive BA (BlockAck). However on rt2x00 we
> use it when remote station fail to decode one or more subframes within
> AMPDU (some bits are not set in BlockAck bitmap). Setting the flag result
> in sent of BAR (BlockAck Request) frame and this might result of abuse
> of BA session, since remote station can sent BA with incorrect
> sequence numbers after receiving BAR. This problem is visible especially
> when connecting two rt2800 devices.
> 
> Previously I observed some performance benefits when using the flag
> when connecting with iwlwifi devices. But currently possibly due
> to reacent changes in rt2x00 removing the flag has no effect on
> those test cases.
> 
> So remove the IEEE80211_TX_STAT_AMPDU_NO_BACK.
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

567a9b766b47 rt2x00: do not set IEEE80211_TX_STAT_AMPDU_NO_BACK on tx status

-- 
https://patchwork.kernel.org/patch/11110703/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

