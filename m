Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDC232C13C
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbhCCVRf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835182AbhCCSCa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 13:02:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87FC364EBD;
        Wed,  3 Mar 2021 18:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614794508;
        bh=UKy7wDZ5bChILMO8xcrObp1g4dcJ2qNkVlmdmBl9ZX0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=PH9ZOJl20JyEMilez2SL/x3jyUlCRnEVLFx4gxCtuZ945yee/n+NTe0e4laoR+pdE
         GzMpcbyKyvoEu3R4TUXuakvljSx9yIksJqPjZRIKG/WrpIAKgTI0c2vhuUSwe2Txe8
         5JxClRFJOrmpABYsedHVE+BoM55XjqJmNhMnv9WRzP2VAeqUGwFdr+K4oTDveROvxm
         Zm+jcFBvq2vqUeKC9ourygLQ+hJEPE63VhjPidoHgK5cBb2JC4Dqw2eIMGr5QN+LRz
         HYUPp3ZtH28O0xj8TjmQES1thS0cPV9Z3S9vFu0PGCZMDvjiQpb9e9CpU10grKbJLS
         yYAZPvip34AsQ==
Date:   Wed, 3 Mar 2021 19:01:45 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
cc:     Johannes Berg <johannes@sipsolutions.net>,
        Luca Coelho <luciano.coelho@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iwlwifi: don't call netif_napi_add() with rxq->lock
 held (was Re: Lockdep warning in iwl_pcie_rx_handle())
In-Reply-To: <20210303155941.25521C43463@smtp.codeaurora.org>
Message-ID: <nycvar.YFH.7.76.2103031901140.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm> <20210303155941.25521C43463@smtp.codeaurora.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 3 Mar 2021, Kalle Valo wrote:

> Patch applied to wireless-drivers.git, thanks.

Thanks, but ...

> 295d4cd82b01 iwlwifi: don't call netif_napi_add() with rxq->lock held (was Re: Lockdep warning in iwl_pcie_rx_handle())

... i believe you want to drop the "(was ...") part from the patch 
subject.

-- 
Jiri Kosina
SUSE Labs

