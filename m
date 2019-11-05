Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAAFEF852
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfKEJNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:13:39 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40796 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730433AbfKEJNj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:13:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4ED5B60F90; Tue,  5 Nov 2019 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572945218;
        bh=Q4XK0CcJiwUgJuop8UEj03vrfbVc2E4fEqnoYYM54d8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KE6PtIRg14d1ecGD1muhe4IP0QOQDlw5QucwerjyVJoZLzV6x8eoteeE7aAZGC6PB
         wQBTNBYyPXw3AOWU+x7Nzh2Z2AZUycaFL8H4X/FLRrQeTYIudkSeSGSZTgHdg54rgZ
         vHLz7oM5QF/yXmyP3eO5rfvQgzAmakbYI6nXMcSE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB95460FF6;
        Tue,  5 Nov 2019 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572945216;
        bh=Q4XK0CcJiwUgJuop8UEj03vrfbVc2E4fEqnoYYM54d8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hpSbFqKSTfgzQ6WX9TrNGir3XJZWjsSb/kbzLXUkXABbpmuOFI0dUGrm6jen+qhLI
         rwJ+hhgGvhD59P+uDNP6R+1iZBQmKwP7kVMbsUiksD5f3+TfzCAtSnMWoslfbVz2tU
         8x0cgFTCTYXB8SAzeBcnCESN/AbYhS0RlY6tzurc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB95460FF6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH] Revert "mt76: mt76x0e: don't use hw encryption for MT7630E"
References: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
        <87eeymd98m.fsf@tynnyri.adurom.net> <20191105090043.GB4422@redhat.com>
Date:   Tue, 05 Nov 2019 11:13:31 +0200
In-Reply-To: <20191105090043.GB4422@redhat.com> (Stanislaw Gruszka's message
        of "Tue, 5 Nov 2019 10:00:44 +0100")
Message-ID: <87woceznwk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> On Tue, Nov 05, 2019 at 10:21:13AM +0200, Kalle Valo wrote:
>> Stanislaw Gruszka <sgruszka@redhat.com> writes:
>> 
>> > This reverts commit 34b0e9b767bfa09ae233ca0d6ceb299bf2e24600.
>> >
>> > Since 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")
>> > is no longer necessary to disable HW encryption for MT7630E.
>> >
>> > Disabling HW encryption helped previously because somehow fragmented
>> > skb's are not created if mac80211 encrypt frames, so buffer unmap bug
>> > of non-linear skbs was not triggered. Now since this bug if properly
>> > fixed by 7bd0650be63c , we can enable HW encryption back.
>> 
>> This should be:
>> 
>> ... fixed by commit 7bd0650be63c ("mt76: dma: fix buffer unmap with
>> non-linear skbs"), we can enable ...
>
> I provided the topic in the first reference of the commit at the top.
> Should I do this anytime in the chenglog when a commit is referenced,
> even if it's done already ?

Sorry, I missed that. Yes, you are right and ignore my comment.

-- 
Kalle Valo
