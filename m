Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD2983178
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfHFMgU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:36:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfHFMgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:36:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 30B4260EA5; Tue,  6 Aug 2019 12:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565094979;
        bh=bj8qWGpk0Sk8b4h8M0Ne5LXuOnmgHgbZr/8RgDNfuP8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n/NFR8e6uXdTOcxgC4FYIIvCgEMowGv40S/7M0PSyT6SAGCDRg5MGpGmHuGvm5vBh
         ib6wt+geuP1GBMibxUhUmrV5qC+dfT6HiJmaCnT/f3C/tfGhfeXiF7MzTSqOK1zVx6
         OFcFpbc7JEHrWCTHa2aPrw/8e1HnVod+towgJzWI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B25CB608BA;
        Tue,  6 Aug 2019 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565094976;
        bh=bj8qWGpk0Sk8b4h8M0Ne5LXuOnmgHgbZr/8RgDNfuP8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=Dg5fiiKl+2LFh3I+pWjL092hV7TngoKzborRoN74EW4KRcpbs+nwMTI6RVw1whISe
         sPqJUsINYQRPWt+aFM0DPXndUOosh3IOcu4Fslc/8GUp6RGiElz9h/0mTAg33nr+qA
         eo5CGPUblez1eRYjIdhjMH6gQwrd835cZBPv1BHU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B25CB608BA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] libertas: Fix a double free in if_spi_c2h_data()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <9153261627a0f84b996e023f1349a2bc06dd03ee.camel@redhat.com>
References: <9153261627a0f84b996e023f1349a2bc06dd03ee.camel@redhat.com>
To:     Dan Williams <dcbw@redhat.com>
Cc:     Philip Rakity <prakity@yahoo.com>,
        libertas-dev@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Allison Randal <allison@lohutok.net>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806123619.30B4260EA5@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:36:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Williams <dcbw@redhat.com> wrote:

> The lbs_process_rxed_packet() frees the skb.  It didn't originally, but
> we fixed it in commit f54930f36311 ("libertas: don't leak skb on receive
> error").
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Dan Williams <dcbw@redhat.com>

Patch applied to wireless-drivers-next.git, thanks.

3915a252ce71 libertas: Fix a double free in if_spi_c2h_data()

-- 
https://patchwork.kernel.org/patch/11057049/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

