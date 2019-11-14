Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB0D7FC9EB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 16:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfKNP2b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 10:28:31 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33310 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKNP2b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 10:28:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4859B607EB; Thu, 14 Nov 2019 15:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573745310;
        bh=XFhXWtzpMffal4UZF55c6GYPwnvZsz59RD3HO61R2a0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QUQZIXkUxIXB+wqH+oALtOAgZ0nOukElxc6fBGmLgVUJREBcG0zitwMHvh+BrNLSo
         H5eD4bEdfJLuWtnMMfhi+vTSOwpbZmKuAnuv872htdnD+DzsXlIYYZlEuVNWNO1G6w
         RUggbZ5jsfpI20n5wVlRxPQILaGcWVXmY/sgNL8c=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4812860112;
        Thu, 14 Nov 2019 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573745309;
        bh=XFhXWtzpMffal4UZF55c6GYPwnvZsz59RD3HO61R2a0=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=cDvbh5pSXdPDspPUBaomI/zw6sZ9FPAYf3DoRsrqPD3KNlxEjsPxlqunaI1V0PzQH
         xJIVJfecNWUkV7lEeEcTB34M++bhAqtzF2Tz5QDhF8Z491EzMsBorV5sCFyjcDt0bt
         luKWM831yat6gdd6IGqJs6XfbFFNu8mRIg38u5RQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4812860112
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtl8xxxu: Add support for Edimax EW-7611ULB
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191112202850.32041-1-Jes.Sorensen@gmail.com>
References: <20191112202850.32041-1-Jes.Sorensen@gmail.com>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191114152830.4859B607EB@smtp.codeaurora.org>
Date:   Thu, 14 Nov 2019 15:28:30 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jes Sorensen <jes.sorensen@gmail.com> wrote:

> A number of people have reported the Edimax EW-7611ULB works fine.
> 
> Signed-off-by: Jes Sorensen <Jes.Sorensen@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

408f122a1f92 rtl8xxxu: Add support for Edimax EW-7611ULB

-- 
https://patchwork.kernel.org/patch/11240113/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

