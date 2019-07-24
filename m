Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A61872E34
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2019 13:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbfGXLwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jul 2019 07:52:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52930 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387393AbfGXLwZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jul 2019 07:52:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 47B8660314; Wed, 24 Jul 2019 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969144;
        bh=WDx4mY1JbCdStvR1Qpmf5KLxJIUu43b7WByPChbxOPQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jBV2RKh7YPHKs87QSf0OkpEQvtOY1D+9N0mxCZYIWZnZ99PQT6Ju4NMWGdpn9QfKP
         2PuN0p8bToTMPoWLU0+KoHMzWNE9V4X5hXlWt+oaYmTrwG++zmDw1bd8OcACGEjrMk
         8Dg7QJLa5aJ1llHQkgp2G5QsCoxR0ESPGnW6fHEs=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C311D60214;
        Wed, 24 Jul 2019 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1563969143;
        bh=WDx4mY1JbCdStvR1Qpmf5KLxJIUu43b7WByPChbxOPQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=TEKxSPcbRLMSwOrYxBaJZ7llbhIii5bWbPLt3nwS4Njv7i2o+I2LoQXSvl5FYOoY7
         r2UMptXK2lfZrH3y7FAQaSg/qXUcnJaQdf1RdRtwt7GJFaPHkp5ElgWmQ4f9aJzMgE
         wxoTmAclXW4oo5MYMZSzcA5v+h9PLEVSL38Z6l8c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C311D60214
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mt7601u: use params->ssn value directly
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190712120949.GA21396@redhat.com>
References: <20190712120949.GA21396@redhat.com>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kubakici@wp.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190724115224.47B8660314@smtp.codeaurora.org>
Date:   Wed, 24 Jul 2019 11:52:24 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> wrote:

> There is no point to use pointer to params->ssn.
> 
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Acked-by: Jakub Kicinski <kubakici@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

f0248ec49bde mt7601u: use params->ssn value directly

-- 
https://patchwork.kernel.org/patch/11042213/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

