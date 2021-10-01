Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598BC41F231
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Oct 2021 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355025AbhJAQgH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Oct 2021 12:36:07 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:22531 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbhJAQgG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Oct 2021 12:36:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633106062; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=NY14Dc9oGXULrplY7IutIcZmm/5UJD13Yn3cthVdbR8=; b=kh29cyBUudno/2UwChog3LuaE8EzUm7iaUuky9fmttSj1aw7a+RtwN+Hz22RQSdfIJvxTZVc
 wWT2oQGO13iqKK7Qpj1szVgqnwalDtArZvggtYC3bp4arVJPhYM+sqna0TwQtsTnZk3yFLRK
 NsigTw5j0zpoGrQf4XnwVwoHDdI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 615738869ffb413149eceac8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 01 Oct 2021 16:34:14
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 058F9C43616; Fri,  1 Oct 2021 16:34:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C55E9C4338F;
        Fri,  1 Oct 2021 16:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org C55E9C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
References: <20210820043538.12424-1-pkshih@realtek.com>
Date:   Fri, 01 Oct 2021 19:34:10 +0300
In-Reply-To: <20210820043538.12424-1-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 20 Aug 2021 12:35:14 +0800")
Message-ID: <8735pkiu0t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> This driver named rtw89, which is the next generation of rtw88, supports
> Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
> Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
> though.
>
> The chip architecture is entirely different from the chips supported by
> rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
> are totally redefined, so it's impossible to reuse register definition. To
> communicate with firmware, new H2C/C2H format is proposed. In order to have
> better utilization, TX DMA flow is changed to two stages DMA. To provide
> rich RX status information, additional RX PPDU packets are added.
>
> Since there are so many differences mentioned above, we decide to propose
> a new driver. It has many authors, they are listed in alphabetic order:

I did a review now and this looks pretty good to me. Kconfig has a
different license and lots of static/extern variables which are not
const, otherwise I only saw smaller issues. But I do have to admit that
after mac.h (in alphabetical order) my review was more on the sloppy
side, this is a large driver.

The community has been testing this driver already, right?

I pushed the driver to the pending branch for build testing:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=c9dfa866a9f4004fcbde9fc3ad8772ad417c6ad9

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
