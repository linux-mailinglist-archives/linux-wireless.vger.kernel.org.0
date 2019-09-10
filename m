Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89167AEB64
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2019 15:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfIJNXR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Sep 2019 09:23:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39330 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfIJNXQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Sep 2019 09:23:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D7AC7602F2; Tue, 10 Sep 2019 13:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568121795;
        bh=lAgGppZTDY0zVMaI156yTuiRF1qBwjhCYk4HuMC1Ny4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NRptEJITotRvRvs2oOPxlgSv3DM6m4oUihuRY+9lAwhWpFsQxZrEfY31LBb6VYi6z
         +ApfKXA/LMKYjYXQmytZBb1hDuxtIAQutOlp/8iEakQwOs8d4JjLQtY9vNPpOeiceM
         sdv5A3IjSgRlXoTo9K0lvAQP8eAGwoxoOYXnHPbk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 546C6602F2;
        Tue, 10 Sep 2019 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568121794;
        bh=lAgGppZTDY0zVMaI156yTuiRF1qBwjhCYk4HuMC1Ny4=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=nmxbvtHgDqwrfyKFQH19UFA2YnLDIcK8Oh0QadG8dZtGi0iPkseKTI18Cqoba8rX6
         QyvCm1k+d111MNu+ddygfa/zERF8m6ZKnKwReATC4k7Sz97UwTYRl8xH+pil6hIIwS
         APm+0n3D441JPG71dKE5UD3+T9pDFF7XBHqJxJk0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 546C6602F2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/11] wil6210: fix PTK re-key race
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
References: <1567931575-27984-5-git-send-email-merez@codeaurora.org>
To:     Maya Erez <merez@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190910132315.D7AC7602F2@smtp.codeaurora.org>
Date:   Tue, 10 Sep 2019 13:23:15 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Maya Erez <merez@codeaurora.org> wrote:

> Fix a race between cfg80211 add_key call and transmitting of 4/4 EAP
> packet. In case the transmit is delayed until after the add key takes
> place, message 4/4 will be encrypted with the new key, and the
> receiver side (AP) will drop it due to MIC error.
> 
> Wil6210 will monitor and look for the transmitted packet 4/4 eap key.
> In case add_key takes place before the transmission completed, then
> wil6210 will let the FW store the key and wil6210 will notify the FW
> to use the PTK key only after 4/4 eap packet transmission was
> completed.

This is rather ugly but I guess still ok. Or what do people think?

But for a proper fix you should look at:

[PATCH v2] wpa_supplicant: Send EAPoL-Key frames over NL80211 where available

http://lists.infradead.org/pipermail/hostap/2019-September/040516.html

-- 
https://patchwork.kernel.org/patch/11136851/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

