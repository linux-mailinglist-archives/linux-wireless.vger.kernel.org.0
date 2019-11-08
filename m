Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8F5F57BD
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 21:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbfKHTh2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 14:37:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:56856 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387561AbfKHTh2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 14:37:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6906F61282; Fri,  8 Nov 2019 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573241847;
        bh=Z3j0Gz/vD7Z3P0IwT9HGD7SHVyARaBMIuWDN4vqQy/c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=D8G7xJ2a2l2NVikZ4c4hcW5sfWh6Aw+8s9znPFLbAw8CIqC+5U+oXtRilZbhuejQJ
         S3suPJjQL5+3Uwrh8xesyDN1OE0d/mf4JnQs2h0t9DL1X0OZOcmd4yhF7SYZ7ggHGw
         7g5JPlpCjlxi7LN1FtNCKF65M8oAtNnlgWbvy/jI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C8A060247;
        Fri,  8 Nov 2019 19:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573241846;
        bh=Z3j0Gz/vD7Z3P0IwT9HGD7SHVyARaBMIuWDN4vqQy/c=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=PuqdhLSNQDSMLBYbgf4QjgorUe8CvvN7btOUMqHcjb6M7xm8GepHHN7JrU7qlb3RP
         71i/qJg50P2sNRPDAFpSMqPvkFoiAIBxcTc5AEHWL87CsDapqhOj54yKmPIMNh0xGu
         4jDu2oEwnHNw7TYEvcnYzSjJ7322y8JcwlYPvzZc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C8A060247
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5.4 1/3] iwlwifi: pcie: don't consider IV len in A-MSDU
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191107115149.10709-1-luca@coelho.fi>
References: <20191107115149.10709-1-luca@coelho.fi>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191108193727.6906F61282@smtp.codeaurora.org>
Date:   Fri,  8 Nov 2019 19:37:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> wrote:

> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> From gen2 PN is totally offloaded to hardware (also the space for the
> IV isn't part of the skb).  As you can see in mvm/mac80211.c:3545, the
> MAC for cipher types CCMP/GCMP doesn't set
> IEEE80211_KEY_FLAG_PUT_IV_SPACE for gen2 NICs.
> 
> This causes all the AMSDU data to be corrupted with cipher enabled.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

Patch applied to wireless-drivers.git, thanks.

cb1a4badf592 iwlwifi: pcie: don't consider IV len in A-MSDU

-- 
https://patchwork.kernel.org/patch/11232699/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

