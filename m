Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 947F212D18
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 14:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfECMFC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 08:05:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53204 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECMFC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 08:05:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 40E7360DAB; Fri,  3 May 2019 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556885102;
        bh=294rR0Akwz5jfvKYEA2j+HnKF5BPrGnec1mvt2REFAo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ByDKfHdY38cDirkpnSGDnrg3N8LbojE5sBPG3FM9sjbrOIMp83J2j5OkdeIlIr1ty
         S7lyo4P0NWhEdAN6tMThx9SnVYD3CZwyEWzGZu8+IY/O02W01pqY4CHJAydaokR7Eq
         xBLHjALWhdIPqLldyP2P+GB+IthweVmDoIjj2yWw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1509760A42;
        Fri,  3 May 2019 12:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556885101;
        bh=294rR0Akwz5jfvKYEA2j+HnKF5BPrGnec1mvt2REFAo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KGwY5sQBvK8Tj3yPUJq+vCvRxmltJ0Kan5tVojaXrfW8NorNH/W6DdRrYYjqfU/F1
         4wdyR35Jtrm/5/L9DRqPsejrQZk6QUhRGhBhsYMHxlnzpxZ+bcFsGfxiGSOBe9oCP3
         RKIv1aZvCzh6OWDnbkBtPYYBo2QUjx5nroc2u1dU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1509760A42
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] rtw88: minor fixes from suggestions during review
References: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
Date:   Fri, 03 May 2019 15:04:58 +0300
In-Reply-To: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
        (yhchuang@realtek.com's message of "Fri, 3 May 2019 19:53:30 +0800")
Message-ID: <87ftpvkal1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> writes:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
>
> The series fix some small problems for rtw88, most of the suggestions
> are from the review process.
>
>
> v1 -> v2
>
>  - modify description for LPS, ", turn off" -> ", to turn off"
>  - drop patch "rtw88: mac: remove dangerous while (1)",
>    should re-write the power sequence parsing code to make sense of avoiding
>    infinite loop
>  - unify Makefile license to Dual GPL/BSD
>
>
> Yan-Hsuan Chuang (5):
>   rtw88: add license for Makefile
>   rtw88: pci: use ieee80211_ac_numbers instead of 0-3
>   rtw88: pci: check if queue mapping exceeds size of ac_to_hwq
>   rtw88: fix unassigned rssi_level in rtw_sta_info
>   rtw88: more descriptions about LPS

I was just in the next few minutes about to tag the last -next pull for
5.2. I'll apply patch 1 now so that we have consistent licenses for 5.2
but the rest have to wait for 5.3.

-- 
Kalle Valo
