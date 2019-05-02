Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD5B11BDE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 16:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBO5S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 10:57:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37788 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBO5R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 10:57:17 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3B2B3607DE; Thu,  2 May 2019 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556809037;
        bh=7E/f1KNqjuAIh+7P2Jn75B7j8N7ezXYcQJb3AHakCt8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jSC9ZHuRRb1zB/0i7YC2YQ6SDUn+1H8J/IMznrSuOBqVhyIAFIGLtLS2rvQADb/eL
         jDYi68kNSOsl7g4qKEwMdGrYROqf4yx4C08ePbVaMhkpGrDrBTgZKBCtzeDH4Hb7CG
         HednuKonNqvCcj5qFGLWwPeiJhpqtGgWKqv/wKvQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60900601D4;
        Thu,  2 May 2019 14:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556809036;
        bh=7E/f1KNqjuAIh+7P2Jn75B7j8N7ezXYcQJb3AHakCt8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=cU8P4yxYCOf5wj3h4yWIsdh8NeF0XqLC+7kk3x7p1KWsVXjaPMd75Xu3jTHIsgt6b
         /+XwexzrB6TJWeEYobOVEVPSFu7qff0tm9zw/GjWuwFHv99XaqJSGaWm8hnDx8LT/I
         2tn8Xzuy4kGaJUGU4xkVjDXx6kUj58dOYHSVvCIM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60900601D4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC/RFT 3/7] rt2800: initial watchdog implementation
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1556788021-6531-4-git-send-email-sgruszka@redhat.com>
References: <1556788021-6531-4-git-send-email-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190502145717.3B2B3607DE@smtp.codeaurora.org>
Date:   Thu,  2 May 2019 14:57:17 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> Add watchdog for rt2800 devices. For now it only detect hung
> and print error.
> 
> [Note: I verified that printing messages from process context is
> fine on MT7620 (WT3020) platform that have problem when printk
> is called from interrupt context].
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Dropped per request.

Patch set to Rejected.

-- 
https://patchwork.kernel.org/patch/10926399/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

