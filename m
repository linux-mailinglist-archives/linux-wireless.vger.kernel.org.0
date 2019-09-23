Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 205F3BACF7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 06:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfIWEAv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 00:00:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfIWEAu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 00:00:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CD74D61156; Mon, 23 Sep 2019 04:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569211249;
        bh=dzGBpWxMQIcheSbBv5pFlJ/FVipyNXb6HgHczU7BnLw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bF0Si9noipC1DvA26t/bcOZFpeOa82/ozhTJmANi9lYi9jd1J32fFCx0w9MitKOW0
         BCZsUklgXz1DCn/ADy4/z6aptpZbebveJRgXXkY8ihGq6v9CDwUC3y0LDdl9uiHhVR
         DyaznzN/G7dNOMrT2wC6Az8HNyVEzL1iYIc2weNc=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 431AD6047C;
        Mon, 23 Sep 2019 04:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569211249;
        bh=dzGBpWxMQIcheSbBv5pFlJ/FVipyNXb6HgHczU7BnLw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=bF0Si9noipC1DvA26t/bcOZFpeOa82/ozhTJmANi9lYi9jd1J32fFCx0w9MitKOW0
         BCZsUklgXz1DCn/ADy4/z6aptpZbebveJRgXXkY8ihGq6v9CDwUC3y0LDdl9uiHhVR
         DyaznzN/G7dNOMrT2wC6Az8HNyVEzL1iYIc2weNc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 431AD6047C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: Re: [PATCH] mt76: mt7615: fix mt7615 firmware path definitions
References: <9e132c0949139155a4fb3375e4c83218159efce7.1569159209.git.lorenzo@kernel.org>
Date:   Mon, 23 Sep 2019 07:00:43 +0300
In-Reply-To: <9e132c0949139155a4fb3375e4c83218159efce7.1569159209.git.lorenzo@kernel.org>
        (Lorenzo Bianconi's message of "Sun, 22 Sep 2019 15:36:03 +0200")
Message-ID: <87wodzirv8.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> mt7615 patch/n9/cr4 firmwares are available in mediatek folder in
> linux-firmware repository. Fix path definitions.
> Moreover remove useless firmware name pointers and use definitions
> directly
>
> Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

This sounds pretty serious, I guess distros don't work out of box
because of this? So I would like to queue this to v5.4.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
