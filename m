Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA15CD3BBA
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfJKI5l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 04:57:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43640 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJKI5l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 04:57:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1EDEF606CF; Fri, 11 Oct 2019 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570784260;
        bh=HJPvqwtpIUA4a4oro+V62fLeo2/uwTNtiKMufXngZR0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aQB/194A30UNmYuu+lXBAlBFcz+JrP9m4+miF5bz9nIzTc7TLvv9+Su+EFPcjbMkp
         7Q6w50qNGY0n0ekmhwfnca+SeERh3hZBO9+m4gYw51t9AjjEGo3A1bWkpTpXW/e6ie
         PXPVa/nIizRJS0E8n+Jak0h4OgU4HQxs4oRVORlk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6B56E606CF;
        Fri, 11 Oct 2019 08:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1570784259;
        bh=HJPvqwtpIUA4a4oro+V62fLeo2/uwTNtiKMufXngZR0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=cH+/1EynQOz5PVOnAEJdkpJaBwnus2fVi6IsGrvSxGLDvrvXn0ruP27k+vf1BPMni
         leF3igfQh8UoBvqGGpTI7XQrXzboREogsUjtGQ2KLgvTmEwIz8FU/ehKs3V1unpLYB
         Gwy8g3x/rOU2JBGczHF80Dg3MkdIfSrRrZAkS0yM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B56E606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] rtlwifi: rtl8192se: Remove unused GET_XXX and SET_XXX
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191009173711.20348-2-Larry.Finger@lwfinger.net>
References: <20191009173711.20348-2-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191011085740.1EDEF606CF@smtp.codeaurora.org>
Date:   Fri, 11 Oct 2019 08:57:40 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> As the first step in converting from macros that get/set information
> in the RX and TX descriptors, unused macros are being removed.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

4 patches applied to wireless-drivers-next.git, thanks.

c2fca7d083f7 rtlwifi: rtl8192se: Remove unused GET_XXX and SET_XXX
c3f997f0c3b2 rtlwifi: rtl8192se: Replace local bit manipulation macros
06aae1b02285 rtlwifi: rtl8192se: Convert macros that set descriptor
1dce7eb37333 rtlwifi: rtl8192se: Convert inline routines to little-endian words

-- 
https://patchwork.kernel.org/patch/11181777/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

