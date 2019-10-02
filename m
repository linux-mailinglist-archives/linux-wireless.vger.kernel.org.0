Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66743C46AA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 06:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfJBEhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 00:37:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48750 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfJBEhX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 00:37:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2514260790; Wed,  2 Oct 2019 04:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569991042;
        bh=xh39h2stOuKANpsG0r8C6wZebDbKE6gErmdAdpb39Ac=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KRtTAAes4qfz+rt56X0bOa9I6hYSNjrSSpsRzyfQtCQFx0z3JLaM3ETczo+So27JP
         UZFAdRY44J1w4xQ7DAuJPQbRQY//vqh4crrUJzzjdHRL0yhHpdUVfwzzoAFx0V6XQO
         xzMeXSCmswB4MzTZLivnJq6WQ2gyugPCPfcDaKPw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E161C60790;
        Wed,  2 Oct 2019 04:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569991041;
        bh=xh39h2stOuKANpsG0r8C6wZebDbKE6gErmdAdpb39Ac=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VZN0CA5G2QGHos12kt2+cpPHrqvG89aDrill9D/917s8ZmMZwMqnih0Ql+TtEfrvn
         4QszRzuxr3PvZr+ulQlaEaPJlda7XWAIrWlTgXt4nNPv9rUY5tduP+iW0yuExMFbPz
         u4Ka+I9xdkh8xaGT91gG7mU0Hd+RkizOsNdxN2t4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E161C60790
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
Message-Id: <20191002043722.2514260790@smtp.codeaurora.org>
Date:   Wed,  2 Oct 2019 04:37:21 +0000 (UTC)
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

Patch applied to wireless-drivers.git, thanks.

c91a9cfe9f6d rt2x00: initialize last_reset

-- 
https://patchwork.kernel.org/patch/11161981/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

