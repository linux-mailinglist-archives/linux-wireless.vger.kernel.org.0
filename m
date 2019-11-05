Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00E0EF71E
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 09:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387717AbfKEIVU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 03:21:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbfKEIVU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 03:21:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 750706090F; Tue,  5 Nov 2019 08:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572942079;
        bh=nAwjlRAFrDcHiDhUYKUDdNV1rAmHzr+VDZqV5W/gC34=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=h3OE6/f3S+RriteokA3Gsl8C4qXVA4BeR25QEk/V1pWZEUsCc1jdruOv+qsnSdvmk
         3EpqPhpaamhXmSTtoUjToBDX+4acQY2Av2jz+9loBj1nd74B3msHTD/5UADTbdMELC
         ZGIPreG0DTq2gLdV3kbEUVkFhu0xMJBQfMXBhm2o=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97E396090F;
        Tue,  5 Nov 2019 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572942078;
        bh=nAwjlRAFrDcHiDhUYKUDdNV1rAmHzr+VDZqV5W/gC34=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dprY15UfLbDXdzkIw9yLVg4si8vP681VlRogtyiVbBu6/P7v4s2NkfHk2Pc8IurNC
         QoXIuNsMwGppdloPnPss9K/22sBoJpGbG0vtq2azTQP9ctAGD7N7iI7Wy5Cj5E45RV
         Pqjlt+yL2ssAA3KYFofCtiwuSVVklFFEsmBhaYIU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97E396090F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH] Revert "mt76: mt76x0e: don't use hw encryption for MT7630E"
References: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
Date:   Tue, 05 Nov 2019 10:21:13 +0200
In-Reply-To: <1572860780-2403-1-git-send-email-sgruszka@redhat.com> (Stanislaw
        Gruszka's message of "Mon, 4 Nov 2019 10:46:20 +0100")
Message-ID: <87eeymd98m.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> This reverts commit 34b0e9b767bfa09ae233ca0d6ceb299bf2e24600.
>
> Since 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")
> is no longer necessary to disable HW encryption for MT7630E.
>
> Disabling HW encryption helped previously because somehow fragmented
> skb's are not created if mac80211 encrypt frames, so buffer unmap bug
> of non-linear skbs was not triggered. Now since this bug if properly
> fixed by 7bd0650be63c , we can enable HW encryption back.

This should be:

... fixed by commit 7bd0650be63c ("mt76: dma: fix buffer unmap with
non-linear skbs"), we can enable ...

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
