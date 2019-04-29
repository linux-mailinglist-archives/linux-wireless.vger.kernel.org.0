Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC3EE4F1
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfD2OnP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:43:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60210 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2OnP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:43:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4B64E6086B; Mon, 29 Apr 2019 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556548994;
        bh=F642DkWqeIrIzNHMOaGjMTfPAClqqEoYZGOY6jnPPaI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=o+THj89LJ83zgzFwYbkZtHzSwLcb9HYBiYw26kEx34+FK5UxLnIN7bItU60DsXPpF
         H5QgKnvUFuNZ8vYGXYXyBZ1g0wfMH3CIvtN+e5xQeN/jfqo5SUzodfbaioHudTMCG+
         j/Kzy/aBZgYbiHnJV0k4gJlNaSW8K3GqFaKFR77w=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A1CC6028C;
        Mon, 29 Apr 2019 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556548993;
        bh=F642DkWqeIrIzNHMOaGjMTfPAClqqEoYZGOY6jnPPaI=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=B2S6041exZrq+2C/ojOhtGHbd/tHHS6Aq0jFP2LUrFul2uwY+40+T9JptgZkOv8z6
         NhU12JcZ4oadk6ElUELnUoIz/ZuX2iUE7p7CNTvcii1CTsCB5D+m8/c92iFmqLvMsX
         x4l0+UesHKRbDWVcUf3OrXV45oPEPICn0ktir3+E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A1CC6028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix incorrect multicast/broadcast rate setting
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1544504171-19810-1-git-send-email-pradeepc@codeaurora.org>
References: <1544504171-19810-1-git-send-email-pradeepc@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep kumar Chitrapu <pradeepc@codeaurora.org>,
        Zhi Chen <zhichen@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190429144314.4B64E6086B@smtp.codeaurora.org>
Date:   Mon, 29 Apr 2019 14:43:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> wrote:

> Invalid rate code is sent to firmware when multicast rate value of 0 is
> sent to driver indicating disabled case, causing broken mesh path.
> so fix that.
> 
> Tested on QCA9984 with firmware 10.4-3.6.1-00827
> 
> Sven tested on IPQ4019 with 10.4-3.5.3-00057 and QCA9888 with 10.4-3.5.3-00053
> (ath10k-firmware) and 10.4-3.6-00140 (linux-firmware 2018-12-16-211de167).
> 
> Fixes: cd93b83ad92 ("ath10k: support for multicast rate control")
> Co-developed-by: Zhi Chen <zhichen@codeaurora.org>
> Signed-off-by: Zhi Chen <zhichen@codeaurora.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Tested-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

93ee3d108fc7 ath10k: fix incorrect multicast/broadcast rate setting

-- 
https://patchwork.kernel.org/patch/10723033/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

