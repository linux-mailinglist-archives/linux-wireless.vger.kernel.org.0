Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C787362ECD
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 11:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbhDQJNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 05:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhDQJNC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 05:13:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65BBD610CC;
        Sat, 17 Apr 2021 09:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650756;
        bh=qnco3CJwv/25pWgOodPs9x+ZDLwweLDKhc+D+94XUp0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=p5fxf8+RigOuMnAtjzdbX3JpyGSGkBxhVqSWTqX1QamYCf1b3yWVM2rj6SxgJpmXS
         oBXYPQmJEWb2o9WcD1nO3YNTDYR9IuNvhDjAaeuAVxGglPWz0MXYf1jJTwyBua2EA3
         WU+SsRSPt7fGuI3TiGj0h2prWCKJTc7LxMMiJ2BcetLi1GHYng/WLTn9zMVKYqcx+s
         nAkgAIfDBcwDM4q9t2rlKLSYR6CUqQ4xNCUhEjs7ANjnX+mLRO4yty6ybV90g7KLoS
         5c2S76Ap7gOfkRHX3jZaqIKRfjzEJjirObG4yEpkyEdvcRXlnORhkFA5BFKEjGeZl0
         UnJsdjkXJNlfg==
Date:   Sat, 17 Apr 2021 11:12:33 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in
 iwl_pcie_gen2_enqueue_hcmd()
In-Reply-To: <20210417085010.58522C433C6@smtp.codeaurora.org>
Message-ID: <nycvar.YFH.7.76.2104171105580.18270@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2104070918090.12405@cbobk.fhfr.pm> <20210417085010.58522C433C6@smtp.codeaurora.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 17 Apr 2021, Kalle Valo wrote:

> This is malformed in patchwork, check the link below. Please resend, and
> I strongly recommend to use git send-email to avoid any format issues.

Honestly I have no idea what you are talking about, there is no whitespace 
damage nor anything else that I'd see to be broken. I just took the patch 
from the mail I sent, applied with git-am, and it worked flawlessly.

Anyway, I'll send a patch as a followup to this mail so that it could 
hopefully be picked up by your tooling.

Thanks,

-- 
Jiri Kosina
SUSE Labs

