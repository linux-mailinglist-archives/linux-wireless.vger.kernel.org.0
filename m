Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD4BDDA5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2019 14:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391391AbfIYMCo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Sep 2019 08:02:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58130 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391282AbfIYMCo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Sep 2019 08:02:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 09CE660112; Wed, 25 Sep 2019 12:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569412963;
        bh=fzW0/s40aH0wn1UyIWcQVQckKg4nvy9gajWH4C9J5mU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mLtwTwAHhjpPBSF4roUrhEGyOtFjMJrVyev1q+V1lIzPyadrrh4CShe5NLYiZG+0o
         AootVORLSVBG20zpoppRa2EFKpnboj9C/vTXebNxfl232iswIZwfls7TTXcUeHz07k
         X/SHpOi26mkl173Vq/pvVq+iaNp/I/9GL6ADujCY=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A15CE6013C;
        Wed, 25 Sep 2019 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569412962;
        bh=fzW0/s40aH0wn1UyIWcQVQckKg4nvy9gajWH4C9J5mU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=D7eC359BlIsEnN0DLDCcOZuDS5QvVDvFgI4TPVuyLz+GOTAINpjIkFcATbNFMjo0/
         Xw1cz3RgkRwne6fJ3TqBiEEWtNiDWckoDuTuo4nz3ziB2gY/KA6AeVtupA6mFSxfjt
         v2n91FWgV9LtX394BOF0y8v6yHBhgXYYYU7VZpZA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A15CE6013C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Federico Cuello <fedux@fedux.com.ar>
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCH] ath10k: Fix ath10k_init_uart when uart_print is false
References: <20190925090856.6964-1-fedux@fedux.com.ar>
        <20190925090856.6964-2-fedux@fedux.com.ar>
Date:   Wed, 25 Sep 2019 15:02:39 +0300
In-Reply-To: <20190925090856.6964-2-fedux@fedux.com.ar> (Federico Cuello's
        message of "Wed, 25 Sep 2019 11:08:56 +0200")
Message-ID: <87o8z8inxc.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ ath10k

Federico Cuello <fedux@fedux.com.ar> writes:

> Patch 4504f0e5b5714d9d26b1a80bf1fc133c95830588 introduced a workaround
> for a firmware UART pin configuration bug, but it caused uart_print to be
> interpreted as true when it was false and uart_pin_workaround also false.
>
> This patch corrects the exit condition when uart_print is false.
>
> Signed-off-by: Federico Cuello <fedux@fedux.com.ar>

I have already applied a fix for this:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=1340cc631bd00431e2f174525c971f119df9efa1

But it's not CCed for stable, hopefully the stable bots still catch it.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
