Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D86858940
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 19:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfF0RsF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 13:48:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfF0RsE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 13:48:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 669DB60AA8; Thu, 27 Jun 2019 17:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657684;
        bh=FC/fnWQl5MOUaLXAzkMEKu0x6iCvNqWs8DOxxI/o9l0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fjTjMoIJyWK64XfMAAzsEsQ3sHzB5v07lpYyV3IZKzuDbYEoVEsPZBxKEnJr4T9NJ
         PO2q9frTZxn7qYa5P5JE8If1GOPNOAeiGi3JomZd6UI42qN1BZiLkZUyDWSwBs9CJq
         K4s2+GgfGCSK9qNGvgNIxnt2h4c6BNMY7TzYpU3Q=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 806A96016D;
        Thu, 27 Jun 2019 17:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561657684;
        bh=FC/fnWQl5MOUaLXAzkMEKu0x6iCvNqWs8DOxxI/o9l0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=SKoCozRhabvdQAMNMHG74ZFaSmGTJ/HM8C1N5TWB5wfWzqvXeLyVwVF3EYUj6OjM3
         PTcF4ozQu3VlHyK+qlo08t3s+Mn5wqAKKEj5ibNq5yis/374Msk5kECS4jk0nAVtNR
         cY1SUxvHNlf2Kzpv8kJlYkjDsuHndWGh2Wp5eTNU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 806A96016D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] carl9170: remove dead branch in op_conf_tx callback
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190615100009.14654-1-chunkeey@gmail.com>
References: <20190615100009.14654-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190627174804.669DB60AA8@smtp.codeaurora.org>
Date:   Thu, 27 Jun 2019 17:48:04 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch removes the error branch for (queue > ar->hw->queues).
> It is no longer needed anymore as the "queue" value is validated by
> cfg80211's parse_txq_params() before the driver code gets called.
> 
> Some background:
> In the old days (linux 2.6 and early 3.x), the parse_txq_params()
> function did not verify the "queue" value. That's why these drivers
> had to do it.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

4ba641262b91 carl9170: remove dead branch in op_conf_tx callback

-- 
https://patchwork.kernel.org/patch/10997023/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

