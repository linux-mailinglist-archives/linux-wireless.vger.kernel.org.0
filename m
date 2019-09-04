Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50A3A7B27
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 08:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfIDGGz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 02:06:55 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52038 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfIDGGz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 02:06:55 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BDDCC61194; Wed,  4 Sep 2019 06:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567577214;
        bh=6oY1hWWjdduDaRo/PIdjq07I2zzTLs1oqnPDSebwuRE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LXaj16397dI+ChOmwwRENCZ75C+raRvZGaDpY0AILvLZM0RD1YsbqlsMg3d9bJGwM
         uWb4C4b3nC9o9ZDULngEpuzQiPwEeytLm+VU8ZZdZtOHTHB+RuuieyK+hvLlui2k4G
         mD7AZcQZ4A17yNUBx95HVAECI17d48/kuofPPswI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1239F6118C;
        Wed,  4 Sep 2019 06:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567577214;
        bh=6oY1hWWjdduDaRo/PIdjq07I2zzTLs1oqnPDSebwuRE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=dmkdYM0Gskv4SeR/Jw3K8IJbGy99L86+CIPxTC6NbJ+xJ9Y1QQ4v17G1gSGZapn3h
         R4DBmmFi2Mcx9VQWJ7nGDGs+bAiYPW45s70YSiVF9e6Numvk60TnZe3B/O9Zza0ex7
         VZ5hA+7sqMDWZCsI/6mZgijjnzCsbx+/D9/2lJag=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1239F6118C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v8 2/2] wil6210: Add EDMG channel support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1566138918-3823-3-git-send-email-ailizaro@codeaurora.org>
References: <1566138918-3823-3-git-send-email-ailizaro@codeaurora.org>
To:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Alexei Avshalom Lazar <ailizaro@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190904060654.BDDCC61194@smtp.codeaurora.org>
Date:   Wed,  4 Sep 2019 06:06:54 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexei Avshalom Lazar <ailizaro@codeaurora.org> wrote:

> Add support for Enhanced Directional Multi-Gigabit (EDMG) channels 9-11.
> wil6210 reports it's EDMG capabilities (that are also based on FW
> capability) to cfg80211 by filling
> wiphy->bands[NL80211_BAND_60GHZ]->edmg_cap.
> wil6210 handles edmg.channels and edmg.bw_config requested in connect
> and start_ap operations.
> 
> Signed-off-by: Alexei Avshalom Lazar <ailizaro@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

9abe3e306ecc wil6210: Add EDMG channel support

-- 
https://patchwork.kernel.org/patch/11099621/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

