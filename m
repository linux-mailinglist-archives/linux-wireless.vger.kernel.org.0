Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 106EAB21D3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 16:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfIMOXM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 10:23:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42564 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfIMOXL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 10:23:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DAA6560767; Fri, 13 Sep 2019 14:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568384590;
        bh=XS8naUEoOspaz8A5d3Bz86kz+OFpNeb0azAWm0kmD+k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TLPoaUQh/wds/nIqQKHPvWuha1RjLeEjP1cIbA0mQik2rTmdFVHrQUraT81Mbz+qs
         vcKEDjdsM5QqQCVNuQBkWKWW8jJtASU7sdlf9foqKcFM7m/EIiPilUChch5EbItw84
         pw7lLU5FCfNrk8wcXCB1C/jkD5ZwylUrguWn67u8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E34E9602F8;
        Fri, 13 Sep 2019 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568384590;
        bh=XS8naUEoOspaz8A5d3Bz86kz+OFpNeb0azAWm0kmD+k=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=ThPPKfmcju4VuVBb3+KhmYHulcUQ3DpjjMu3s4QEiLh/F1VZ6B4EoDpmOXTGytVQE
         Jl6pWAC4FVtIplO82gdt6KvMG4NqohdzPsecd+3k+9wY2kHGE8Imdr0vjUnc+XJlUq
         nGYyepJzjjcBYUecDGx/q+HIbZmOf8kBfCYCDWUc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E34E9602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] CREDITS: Update email address
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <CAHJ2opv5fhURr7f9H7fbXZpkc6NowTkDtrZ0Xa743DKKf9HquA@mail.gmail.com>
References: <CAHJ2opv5fhURr7f9H7fbXZpkc6NowTkDtrZ0Xa743DKKf9HquA@mail.gmail.com>
To:     Luis Correia <luis.f.correia@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190913142310.DAA6560767@smtp.codeaurora.org>
Date:   Fri, 13 Sep 2019 14:23:10 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luis Correia <luis.f.correia@gmail.com> wrote:

> Signed-off-by: Luis Correia <luisfcorreia@gmail.com>
> 
> diff --git a/CREDITS b/CREDITS
> index a738760..8b67a85 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -751,7 +751,7 @@ S: Santa Cruz, California
>  S: USA
> 
>  N: Luis Correia
> -E: lfcorreia@users.sf.net
> +E: luisfcorreia@gmail.com
>  D: Ralink rt2x00 WLAN driver
>  S: Belas, Portugal

Patch applied to wireless-drivers-next.git, thanks.

527c5d375419 CREDITS: Update email address

-- 
https://patchwork.kernel.org/patch/11134813/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

