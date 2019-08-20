Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2AF961C9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 16:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfHTN7v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 09:59:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48116 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbfHTN7v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 09:59:51 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B6D476086B; Tue, 20 Aug 2019 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566309590;
        bh=Y8DLjjbgB4GAGqQs3U8wc1WAmJvQUuxP12/nKlgv40U=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=l4+BmQPVuvgSJi4DeCCbX/CyqJTHXYqneH3OPp2xBnbN4aUrSkABMdA5oo4IuU+7m
         IwR0oo5vP44XZ6sHQ1Al0fR3jiUDD/WA88UoEEyx9FE7GJTYZtpFAsh0JzmSoSydhq
         AFcvLpgJ/qM7OHP2d7T2080DlSKloFejAtetsTL8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 705DC60863;
        Tue, 20 Aug 2019 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566309590;
        bh=Y8DLjjbgB4GAGqQs3U8wc1WAmJvQUuxP12/nKlgv40U=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=EQAqJQ3xvIokp6KthpzFOdXP/4AouHDzDbn/6HVOqwT5+Uq443puRnMDHAodQD553
         77YDkS1hvhotUEWN78GaaTy/691AxPkxalgMiQTfrrWmh77YpZCdQVJf1DUKm2K9fV
         PC1zUkagWOIrATALwHosrVytcWwSmRFX0rsycEAo=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 705DC60863
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.3] rt2x00: clear IV's on start to fix AP mode regression
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1566213607-6723-1-git-send-email-sgruszka@redhat.com>
References: <1566213607-6723-1-git-send-email-sgruszka@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>, Emil Karlson <jekarl@iki.fi>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190820135950.B6D476086B@smtp.codeaurora.org>
Date:   Tue, 20 Aug 2019 13:59:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> To do not brake HW restart we should keep initialization vectors data.
> I assumed that on start the data is already initialized to zeros, but
> that not true on some scenarios and we should clear it. So add
> additional flag to check if we are under HW restart and clear IV's
> data if we are not.
> 
> Patch fixes AP mode regression.
> 
> Reported-and-tested-by: Emil Karlson <jekarl@iki.fi>
> Fixes: 710e6cc1595e ("rt2800: do not nullify initialization vector data")
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>

Patch applied to wireless-drivers.git, thanks.

95844124385e rt2x00: clear IV's on start to fix AP mode regression

-- 
https://patchwork.kernel.org/patch/11100685/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

