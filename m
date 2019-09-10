Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38659AE493
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2019 09:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfIJHV4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Sep 2019 03:21:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47860 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfIJHVz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Sep 2019 03:21:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DE0F1602BC; Tue, 10 Sep 2019 07:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568100114;
        bh=//GgADCv5P/N4lGj7YcRUNjlPgDm/wqbIpGducZmKn0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=a6+cMm1LIRKcKNTrhjCzqxmsRb1ejW7gN+CYN+pQ+vtkuaOTXhjjD05XtcGJAU8pu
         jdn/Pj4aHZdXeMwqRRq1YLzqAxCzMx3pw9nVrW35qw23AroyJkFo4eD+EDbWVc3XXZ
         2o47cLI4p9WJvOyGXU3rnSNuRXB0LEgIUVdqJUnI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAC2B602FC;
        Tue, 10 Sep 2019 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568100114;
        bh=//GgADCv5P/N4lGj7YcRUNjlPgDm/wqbIpGducZmKn0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=a6+cMm1LIRKcKNTrhjCzqxmsRb1ejW7gN+CYN+pQ+vtkuaOTXhjjD05XtcGJAU8pu
         jdn/Pj4aHZdXeMwqRRq1YLzqAxCzMx3pw9nVrW35qw23AroyJkFo4eD+EDbWVc3XXZ
         2o47cLI4p9WJvOyGXU3rnSNuRXB0LEgIUVdqJUnI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAC2B602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Tom Psyborg <pozega.tomislav@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org,
        Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [PATCH] ath10k: restore QCA9880-AR1A (v1) detection
References: <20190906215423.23589-1-chunkeey@gmail.com>
        <20190907214359.1C52A21835@mail.kernel.org>
        <CAKR_QVKv8kgXSSCwd8esw28hARA61Pah3usRi+ZZG6ss2CcS=g@mail.gmail.com>
Date:   Tue, 10 Sep 2019 10:21:48 +0300
In-Reply-To: <CAKR_QVKv8kgXSSCwd8esw28hARA61Pah3usRi+ZZG6ss2CcS=g@mail.gmail.com>
        (Tom Psyborg's message of "Tue, 10 Sep 2019 03:27:28 +0200")
Message-ID: <87h85kfwfn.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(dropping stable list)

Tom Psyborg <pozega.tomislav@gmail.com> writes:

> According to this very old post
> http://lists.infradead.org/pipermail/ath10k/2013-July/000021.html
> seems like you've been misinformed on amount of these cards that were
> put out in the market.
>
> At least digipart only have >40000 units in stocks
> https://www.digipart.com/part/QCA9880-AR1A and other retailers
> probably few thousands more.
>
> With that large amount of cards I think it is justified to request
> firmware support for the chip. And probably a lot easier to make few
> firmware modifications than go hacking a bunch of API calls so it
> works with v2 firmware.

I'm very surprised that QCA9880 hw1.0 boards are still available, after
six years. Did you confirm that it really is hw1.0 and not just some
mixup with hardware ids or something like that? For example, you could
try the old ath10k and old hw1.0 firmware to see if it works.

But if it's really is hw1.0 I doubt there will be any support for that.
I recommend to avoid hw1.0 altogether.

-- 
Kalle Valo
