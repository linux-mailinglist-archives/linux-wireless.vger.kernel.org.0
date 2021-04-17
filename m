Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC3362ED7
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 11:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhDQJZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 05:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235685AbhDQJZ3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 05:25:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EE19610E6;
        Sat, 17 Apr 2021 09:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618651503;
        bh=No2ybFli6a/uIcaB5d7KYouXIO074oXS/iOhlE5Z+bA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=nmPFlg+Yd2QZW5VMgVRmgUPuT5gRfxP1jpe3HwflBEZ1yrJfZP64XdIVyPGIE40RR
         tOJG6LuIQWxwDsNfA0xKM4HbO8Us8u3vlJyvDpBQodjKXn8KhcmQCdK9gGQsHfoHhQ
         Opds8790IHsW0e8HAm6by/LafYhK1Uk8DEifysQ4QaCqNhXXXFihKvmLr76OM0ON80
         qipByn+TaRqkY6+vPMOJUTDm0KyPANOIErA30nxC/ENCdfFwrXwSL7eLy0ZNrVVVFU
         nZMy15qdH6NOhvr0H1yEAxt8GYrXUke86es0+lJbha1qA96b2mf9lnZbbCMh+8Ukzc
         Tm4yeTxGySJqA==
Date:   Sat, 17 Apr 2021 11:24:59 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
In-Reply-To: <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2104171124280.18270@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm> <20210417085010.58522C433C6@smtp.codeaurora.org> <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 17 Apr 2021, Jiri Kosina wrote:

> > This is malformed in patchwork, check the link below. Please resend, and
> > I strongly recommend to use git send-email to avoid any format issues.
> 
> Honestly I have no idea what you are talking about, there is no whitespace 
> damage nor anything else that I'd see to be broken. I just took the patch 
> from the mail I sent, applied with git-am, and it worked flawlessly.
> 
> Anyway, I'll send a patch as a followup to this mail so that it could 
> hopefully be picked up by your tooling.

And it seems to have appeared here:

https://patchwork.kernel.org/project/linux-wireless/patch/nycvar.YFH.7.76.2104171112390.18270@cbobk.fhfr.pm/

-- 
Jiri Kosina
SUSE Labs

