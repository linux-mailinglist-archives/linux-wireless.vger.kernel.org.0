Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BCD0FC7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731138AbfJINSF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 09:18:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35856 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJINSF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 09:18:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 49EAB60C5F; Wed,  9 Oct 2019 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570627084;
        bh=envJvmdlNsJEQbEUUBpCyBB6HOzYd7ZRkxn8Frs/dtc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UOvgPT/O2qSPu7HxmRhJ1xXXlJHVEaco64qPtdDjczT2yEl4DWkpGPyUZZ0lYJYt/
         ninXFskbQoldKgHWzqD0h4G8CsY11OIhb3gNQCOUpuZcyUsPQ3/cm3qwC6PdMuufo7
         jWY3CrrT09UdY41J5IFh6DTmG+7JvAYCDkPZKslQ=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F1D67609D1;
        Wed,  9 Oct 2019 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570627083;
        bh=envJvmdlNsJEQbEUUBpCyBB6HOzYd7ZRkxn8Frs/dtc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=aJHWWgiAI11UiLFMppuqdDf1OKTeGB7B4ju2uJQyZmAmJ8pD+sSkr8yjnrRaHyU40
         /2WnQayhWwcqercq225g571mA9YPyvvMYaqQtxV2Z8/vXXWoXTUrMpxMsR5obkaEmK
         q6GMAUAPcmxFn8Ydbuv6Dh42ZMd3jVdDfc4RMFMI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F1D67609D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kan Yan <kyan@google.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, toke@redhat.com,
        nbd@nbd.name, yiboz@codeaurora.org, ath10k@lists.infradead.org
Subject: Re: [PATCH v2 2/2] ath10k: Enable Airtime-based Queue Limit (AQL)
References: <20191007043120.67567-1-kyan@google.com>
        <20191007043120.67567-3-kyan@google.com>
Date:   Wed, 09 Oct 2019 16:17:58 +0300
In-Reply-To: <20191007043120.67567-3-kyan@google.com> (Kan Yan's message of
        "Sun, 6 Oct 2019 21:31:20 -0700")
Message-ID: <87eezmgird.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kan Yan <kyan@google.com> writes:

> Calculate the estimated airtime pending in the txqs and apply AQL to
> prevent excessive amounts of packets being queued in the firmware queue.
>
> Signed-off-by: Kan Yan <kyan@google.com>

Please CC ath10k patches to ath10k list, I doubt all ath10k developers
follow linux-wireless.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
