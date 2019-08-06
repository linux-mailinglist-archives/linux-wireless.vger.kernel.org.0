Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4AFF83148
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbfHFMZT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:25:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54386 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfHFMZT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:25:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01947608CC; Tue,  6 Aug 2019 12:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565094319;
        bh=ca1LOVDmRVvP70xkzyWoS5J/M4KpZeq3R2plRp/fxxY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QejDs9ksjnVzZcbG4qdpVIKR8VL/+dTLxdf9m079lGt/8ttZdb3JG/1CVOUwkjHWo
         Unrw8hto5FTD2WY6eut43sgiQtcDFeyik5yM+/WF6KMap+Kkd9Xz7T2BNauYBvJV9b
         q2XC+iXCh2Mn1ezVPI6zaMfe/g442fg0U+Lbgc78=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8958B60452;
        Tue,  6 Aug 2019 12:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565094318;
        bh=ca1LOVDmRVvP70xkzyWoS5J/M4KpZeq3R2plRp/fxxY=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=oGQzhpTAnWOkcNiJh6L7AEk+Rdd1FmCMMndk6IAunv0wzC9YB16Ku3oMRWZowWrfe
         7PUodzv3LgPhynggcrW/hbCjW1ISzvbLs4+1ltKOntLGCZMnoT/NwlWXNwZ/5g2Q/K
         fYX398HyNQgzYZi4p48wGeI2gOedu+5Ntnonb6zU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8958B60452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] rtw88: use txpwr_lmt_cfg_pair struct, not arrays
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190713013232.215138-1-briannorris@chromium.org>
References: <20190713013232.215138-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     <linux-wireless@vger.kernel.org>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806122519.01947608CC@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:25:19 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> We're just trusting that these tables are of the right dimensions, when
> we could do better by just using the struct directly. Let's expose the
> struct txpwr_lmt_cfg_pair instead.
> 
> The table changes were made by using some Vim macros, so that should
> help prevent any translation mistakes along the way.
> 
> Remaining work: get the 'void *data' out of the generic struct
> rtw_table; all of these tables really deserve to be their own data
> structure, with proper type fields.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

3457f86da60d rtw88: use txpwr_lmt_cfg_pair struct, not arrays

-- 
https://patchwork.kernel.org/patch/11042813/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

