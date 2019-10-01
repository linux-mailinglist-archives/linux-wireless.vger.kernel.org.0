Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17078C2FAC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbfJAJJi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:09:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbfJAJJi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:09:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2887D60A37; Tue,  1 Oct 2019 09:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569920977;
        bh=8+qPw+buh2bAKVu/iserVs8uM7m0xAhuaEbDYL7F03M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=czQNHWHl0/QoV8gSLPVlye++bYS40MuzHS6i73lbElBG4DEhDPwvnep4tzE0YHAW2
         TIg7ogTpnzPmXg4bG/J7BIwP6VYoNStVUquWQwPGbqIY6dyxUKP377B5FMXFwmDNY4
         gpsBe9dofJoRcR/FLXSYPc6VAJ7ekJcuYidxTObo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 056AB6081C;
        Tue,  1 Oct 2019 09:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569920976;
        bh=8+qPw+buh2bAKVu/iserVs8uM7m0xAhuaEbDYL7F03M=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=FwbvP5WTOR82ONB2Nr483TRNx4dQSsMT67ln0zlaIsbXwZCxPn2cL+AZQXj4R3GEe
         JYs3abF7Dan5KxTmdHYZDbXDfcV8v68qB6FP1AUwNKQomUipZO04JeaAjSIIXl/P6A
         o7qI20nGo20FGEE5AOcvploO45/u+BEPqKeU9bP0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 056AB6081C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rt2x00: initialize last_reset
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190926085433.1300-1-sgruszka@redhat.com>
References: <20190926085433.1300-1-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>,
        Jonathan Liu <net147@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001090937.2887D60A37@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 09:09:37 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> Initialize last_reset variable to INITIAL_JIFFIES, otherwise it is not
> possible to test H/W reset for first 5 minutes of system run.
> 
> Fixes: e403fa31ed71 ("rt2x00: add restart hw")
> Reported-and-tested-by: Jonathan Liu <net147@gmail.com>
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

I'll queue this to v5.4.

-- 
https://patchwork.kernel.org/patch/11161981/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

