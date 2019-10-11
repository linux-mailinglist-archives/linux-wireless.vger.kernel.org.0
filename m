Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C0ED3B69
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 10:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfJKImB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 04:42:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37682 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfJKImB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 04:42:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1918660791; Fri, 11 Oct 2019 08:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570783320;
        bh=zFqlxr18PQtDX34HJ128An+cwS7TjNXYBDpvMEAI0UI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YWQb0D+yo9nvAE92goXshicCR7ZO5ax9O6IVY5RCj1vH0t3XFSIqM3gOglDbB1PJ5
         YJmlBCc5ItFmAymH56nuTkYRlkMzFisX4Sm0twCJZtlqxpmzVEsKcgeErXxTgVwdtU
         SWuOjiLV0ao0yz/ubX+bD46s9dF54KutPmQhdIlA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2F71460AA3;
        Fri, 11 Oct 2019 08:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570783319;
        bh=zFqlxr18PQtDX34HJ128An+cwS7TjNXYBDpvMEAI0UI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KeGHbNcnPJc82pyPJWol+Y8pbFw1I1KNRZcEBfANH1SlfL7ayuWFGgt/V4ujKU7pS
         cU03MsDIELi9hgHBGbPWcBmKnRJMk3hDo9AZlwXhlYHtxBPWo0Byr1qFQnAFraBVsZ
         WuMXJ/rJbtRVF4avusrh+EEFHBAYj7LriORw83Z0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F71460AA3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Sven Eckelmann <sven@narfation.org>
Cc:     ath10k@lists.infradead.org, vnaralas@codeaurora.org,
        linux-wireless@vger.kernel.org,
        Sven Eckelmann <seckelmann@datto.com>
Subject: Re: [RFC PATCH 1/2] ath10k: report survey info as accumulated values
References: <20190918124259.17804-1-sven@narfation.org>
        <20190918124259.17804-2-sven@narfation.org>
Date:   Fri, 11 Oct 2019 11:41:56 +0300
In-Reply-To: <20190918124259.17804-2-sven@narfation.org> (Sven Eckelmann's
        message of "Wed, 18 Sep 2019 14:42:58 +0200")
Message-ID: <87mue7znaj.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sven Eckelmann <sven@narfation.org> writes:

> From: Sven Eckelmann <seckelmann@datto.com>
>
> The survey report is expected to contain a counter which is increasing all
> the time. But ath10k reports some kind of delta. This can either be the
> difference to the last get_survey or the difference to some even older
> get_survey because the values are sometimes cached and sometimes
> overwritten.
>
> To make the returned values useful, they must be accumulated manually by
> ath10k before send out to the upper layers. Special care must be taken when
> accepting values from older firmware versions (which use
> ATH10K_HW_CC_WRAP_SHIFTED_ALL) because they will not clear the cycle_busy
> and cycle_total counter and will only use 31 bit of the 64 but counter.

Please clarify a bit more which older firmware versions you are talking
about, we have so many of them :) I assume you are talking about _all_
QCA988X and QCA9887 firmware versions, but it would be nice to clarify
that in the commit log.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
