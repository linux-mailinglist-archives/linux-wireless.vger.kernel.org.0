Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B700D3B75
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbfJKIoH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 04:44:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJKIoG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 04:44:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D7EED60AA3; Fri, 11 Oct 2019 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570783445;
        bh=pNSzaKUDUvO9yLZxvxkObg17lYXcrKGGHE3JOH6HQxg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m6qjQENhNG2xkYiQNV7Goh13QUPQT1IE8EP1mwqydE3QKHBTMdwmaL7ELxoOCtbl6
         bVqi44lofChnnaug5TwX3EYndajb4VBzKy+KXHC/eSIq2i8u0zkUrkikxCI7UKwIvL
         Tl+v6M2Rpyy2irmc0eoE16kf5JVx3Xo7eTXV3Svs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0455260159;
        Fri, 11 Oct 2019 08:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570783445;
        bh=pNSzaKUDUvO9yLZxvxkObg17lYXcrKGGHE3JOH6HQxg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=m6qjQENhNG2xkYiQNV7Goh13QUPQT1IE8EP1mwqydE3QKHBTMdwmaL7ELxoOCtbl6
         bVqi44lofChnnaug5TwX3EYndajb4VBzKy+KXHC/eSIq2i8u0zkUrkikxCI7UKwIvL
         Tl+v6M2Rpyy2irmc0eoE16kf5JVx3Xo7eTXV3Svs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0455260159
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath10k@lists.infradead.org, vnaralas@codeaurora.org,
        linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: Re: [RFC PATCH 0/2] ath10k: provide survey info as accumulated data
References: <20190918124259.17804-1-sven@narfation.org>
Date:   Fri, 11 Oct 2019 11:44:01 +0300
In-Reply-To: <20190918124259.17804-1-sven@narfation.org> (Sven Eckelmann's
        message of "Wed, 18 Sep 2019 14:42:57 +0200")
Message-ID: <87imovzn72.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> it was observed that ath9k provides accumulated survey counters but ath10k
> neither provides deltas nor accumulated counters. Instead it returns
> some value which was returned at some point from the firmware.
>
> But as it turns out, this data is not reliable. To make it more useful,
> ath10k has to:
>
> * retrieve counters rather frequently for hardware which is known to use
>   firmware versions with low number counter bits (for only 14-30s)
> * clean up received counter values 
> * accumulate counters from firmware
>
> A comparison of the resulting output with these fixes can be seen under
> https://stats.freifunk-vogtland.net/d/ffv_node/nodeinfo?orgId=1&var-node=ac86749f4d60&fullscreen&panelId=5&from=1568782046974&to=1568807068706
>
> The left side of the graph shows the output before the patches were applied
> and the right side the output with the patches applied. Just as reference, an
> ath9k device in the same building is
> https://stats.freifunk-vogtland.net/d/ffv_node/nodeinfo?orgId=1&var-node=ac86740037e0&fullscreen&panelId=5&from=1568782046974&to=1568807068706

Thanks, this looks very good to me and I had only cosmetic comments.
Please submit next version without RFC so that I can apply these.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
