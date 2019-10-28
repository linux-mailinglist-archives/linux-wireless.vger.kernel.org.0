Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07794E7127
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2019 13:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfJ1MRm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Oct 2019 08:17:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43664 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfJ1MRm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Oct 2019 08:17:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E8D860913; Mon, 28 Oct 2019 12:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572265061;
        bh=76zjcLGQGemMf25LEWhCx4thgKLupCTxiVAeornU9UA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Awvdh7pGtdPX3hjME7ggJ/t3weIJ2sn+XQoOfgIEPcuQUhj8KFyS2NTvitUJnCevt
         1CGLzpSOMU8hW+D0/CsD7w/9WgAP/j/qX9F148VqTQxxxIXRNR6+YvFVayeX6xjENC
         tUESXCcekUWzIrL+zDXhqaVCTHDGFdPSt3eqfZPs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (unknown [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 39A0860134;
        Mon, 28 Oct 2019 12:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572265058;
        bh=76zjcLGQGemMf25LEWhCx4thgKLupCTxiVAeornU9UA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G27aGyEt7oKYulDIAw+xEujblIA5Ta5VCva3NM/bDXemjCe89hhAgicJ5YXSYViin
         HaAdypI+0BBYljVjDwGsuTVldMvAMiWPnKL5OdY6lsgzrF6f6SZrRIDUC2m2OmDLnJ
         9/N+bb0A/BQ32HjsqOXMTTusVa7xUeOliv4XIdkk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39A0860134
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Lior David <liord@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: Re: [PATCH] wil6210: add SPDX license identifiers
References: <1572260296-24121-1-git-send-email-merez@codeaurora.org>
Date:   Mon, 28 Oct 2019 14:17:34 +0200
In-Reply-To: <1572260296-24121-1-git-send-email-merez@codeaurora.org> (Maya
        Erez's message of "Mon, 28 Oct 2019 12:58:16 +0200")
Message-ID: <87lft53vz5.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> writes:

> From: Lior David <liord@codeaurora.org>
>
> Change all files to add SPDX license identifiers and
> remove license text.
> This is only an administrative change, there is no change
> in actual license or copyright for any file.
>
> Signed-off-by: Lior David <liord@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>
> ---
>  drivers/net/wireless/ath/wil6210/boot_loader.h    | 13 +------------
>  drivers/net/wireless/ath/wil6210/cfg80211.c       | 13 +------------
>  drivers/net/wireless/ath/wil6210/debug.c          | 13 +------------
>  drivers/net/wireless/ath/wil6210/debugfs.c        | 13 +------------
>  drivers/net/wireless/ath/wil6210/ethtool.c        | 13 +------------
>  drivers/net/wireless/ath/wil6210/fw.c             | 13 +------------
>  drivers/net/wireless/ath/wil6210/fw.h             | 13 +------------
>  drivers/net/wireless/ath/wil6210/fw_inc.c         | 13 +------------
>  drivers/net/wireless/ath/wil6210/interrupt.c      | 13 +------------
>  drivers/net/wireless/ath/wil6210/main.c           | 13 +------------
>  drivers/net/wireless/ath/wil6210/netdev.c         | 13 +------------
>  drivers/net/wireless/ath/wil6210/p2p.c            | 13 +------------
>  drivers/net/wireless/ath/wil6210/pcie_bus.c       | 13 +------------
>  drivers/net/wireless/ath/wil6210/pm.c             | 13 +------------
>  drivers/net/wireless/ath/wil6210/pmc.c            | 13 +------------
>  drivers/net/wireless/ath/wil6210/pmc.h            | 17 ++---------------
>  drivers/net/wireless/ath/wil6210/rx_reorder.c     | 13 +------------
>  drivers/net/wireless/ath/wil6210/txrx.c           | 13 +------------
>  drivers/net/wireless/ath/wil6210/txrx.h           | 13 +------------
>  drivers/net/wireless/ath/wil6210/txrx_edma.c      | 13 +------------
>  drivers/net/wireless/ath/wil6210/txrx_edma.h      | 13 +------------
>  drivers/net/wireless/ath/wil6210/wil6210.h        | 13 +------------
>  drivers/net/wireless/ath/wil6210/wil_crash_dump.c | 13 +------------
>  drivers/net/wireless/ath/wil6210/wil_platform.c   | 15 ++-------------
>  drivers/net/wireless/ath/wil6210/wil_platform.h   | 13 +------------
>  drivers/net/wireless/ath/wil6210/wmi.c            | 13 +------------
>  drivers/net/wireless/ath/wil6210/wmi.h            | 13 +------------
>  27 files changed, 29 insertions(+), 328 deletions(-)

What about trace.h and trace.c?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
