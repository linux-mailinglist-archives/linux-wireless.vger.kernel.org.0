Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CEDB2148
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390382AbfIMNnB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 09:43:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59598 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbfIMNnB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 09:43:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DBEB060710; Fri, 13 Sep 2019 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568382179;
        bh=Ja4ceG8awDLyP6lPXdyb6uLP/6pbJZpWydMXOFW+26Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XvGzC+6huv+7a1sNFc0pmzUq3qvzdztxG2IvTy9ERoqSZkiZ5ToOwqRf8ybpSgAtX
         6L0/jZVnzRWpqz6esTEMYr2y0d9T95gWpfhYnNOAw2qHLv7R5a37MKiz7M/CzVTu2J
         pda6n05rfKe9OOLtmM8IAXJNlPKO45UxFxXCU2UU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03E2F601C3;
        Fri, 13 Sep 2019 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568382179;
        bh=Ja4ceG8awDLyP6lPXdyb6uLP/6pbJZpWydMXOFW+26Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=UPSBbIpeEQNcPSb5JSIJU6pLbFQcmBEjMLxtwx1r2JAb/2AvdJHnMNd2SWmSmbBa8
         z9OvVqgcb3adv4j+0cEIXnrEU4luuBPIQy0MquE2QvkNddHumUViquJLOOD2ZmSVbq
         0sbilHNtVsv9RgM4Zo9JaR6tzpy/5FAgGCM8yptE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03E2F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] brcmfmac: move "cfg80211_ops" pointer to another
 struct
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190903042928.18621-2-zajec5@gmail.com>
References: <20190903042928.18621-2-zajec5@gmail.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Winnie Chang <winnie.chang@cypress.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190913134259.DBEB060710@smtp.codeaurora.org>
Date:   Fri, 13 Sep 2019 13:42:59 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This moves "ops" pointer from "struct brcmf_cfg80211_info" to the
> "struct brcmf_pub". This movement makes it possible to allocate wiphy
> without attaching cfg80211 (brcmf_cfg80211_attach()). It's required for
> later separation of wiphy allocation and driver initialization.
> 
> While at it fix also an unlikely memory leak in the brcmf_attach().
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

3 patches applied to wireless-drivers-next.git, thanks.

ba76ff25ee64 brcmfmac: move "cfg80211_ops" pointer to another struct
450914c39f88 brcmfmac: split brcmf_attach() and brcmf_detach() functions
a1f5aac1765a brcmfmac: don't realloc wiphy during PCIe reset

-- 
https://patchwork.kernel.org/patch/11127163/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

