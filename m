Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF5EA6A63
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfICNul (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:50:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57154 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbfICNul (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:50:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E456602EF; Tue,  3 Sep 2019 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518640;
        bh=XDgc0S+TyjdkFGPOkPtR4W8dO7Rdjdw5wKm6OEQNtfg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dygC4D2LkJj9kmS+JVCSAko0SO2Kf7J7Hg+4aeAXlbUwLH1ZjAO9s653z8OFcTgDW
         6HTOVGuRnEqqTzicSga4jxZRrU90MEipOiVE5ihvbTDHd3FgSx+kRGeeL3eP/eyybo
         6oHUkJq8Hfyff+PMaBbuHt8kpSRaXdSRgqlG18IM=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 99C25602EF;
        Tue,  3 Sep 2019 13:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567518639;
        bh=XDgc0S+TyjdkFGPOkPtR4W8dO7Rdjdw5wKm6OEQNtfg=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VsspBHK0wQZRWE2fNfksm9A4M+K0o7wYaypZxMwgHrvBDXQC2dubwQZFzCYttpdnF
         JfxgqrQIh3hrSuMSWOwvLs+uiJcjIioukLEdgthqWcCX31KY31JIGMtYB40ea5TmoW
         E+3yLS5M2sX2aGtLNzdCosJR33L6aYd0zAf9rkQY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99C25602EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: Fix three heap overflow at parsing element in
 cfg80211_ap_settings
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190828020751.13625-1-huangwenabc@gmail.com>
References: <20190828020751.13625-1-huangwenabc@gmail.com>
To:     huangwenabc@gmail.com
Cc:     linux-wireless@vger.kernel.org, amitkarwar@gmail.com,
        nishants@marvell.com, gbhat@marvell.com, huxinming820@gmail.com,
        solar@openwall.com, greg@kroah.com, sashal@kernel.org,
        mrehak@redhat.com
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903135040.7E456602EF@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:50:40 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

huangwenabc@gmail.com wrote:

> From: Wen Huang <huangwenabc@gmail.com>
> 
> mwifiex_update_vs_ie(),mwifiex_set_uap_rates() and 
> mwifiex_set_wmm_params() call memcpy() without checking
> the destination size.Since the source is given from 
> user-space, this may trigger a heap buffer overflow.
> 
> Fix them by putting the length check before performing memcpy().
> 
> This fix addresses CVE-2019-14814,CVE-2019-14815,CVE-2019-14816.
> 
> Signed-off-by: Wen Huang <huangwenabc@gmail.com>
> Acked-by: Ganapathi Bhat <gbhat@marvell.comg>

Patch applied to wireless-drivers.git, thanks.

7caac62ed598 mwifiex: Fix three heap overflow at parsing element in cfg80211_ap_settings

-- 
https://patchwork.kernel.org/patch/11117681/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

