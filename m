Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC29D46C239
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 18:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbhLGSBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 13:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhLGSBd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 13:01:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0629C061574
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 09:58:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 35E66CE1C95
        for <linux-wireless@vger.kernel.org>; Tue,  7 Dec 2021 17:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A1CC341C1;
        Tue,  7 Dec 2021 17:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638899879;
        bh=fz2nEJk5rFpWz4JegCbvPXaQuPKi9Cp81JShqbULKqI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hS5wK5xnyEEFGjyO7T6SPiwH5fUqd9iLr4ZvN2fZFyKfYEWkTdS6qJT/68b1pMgrb
         WaC4G62Aj419ye0AEFeJd9zxigy6WeBIw4iTwClF27urKZlt66DZdkdlYZuf5BeQnk
         xl194dHnRFMdJYw5DF/DMyVtJN5VVeFzQkEnE3qbyNPnWFgEUDSI7pJ+UqA5RWEisf
         3i7JVCos8xBBmUOdnbzey2Rod52ADqqv/wTKDLjOSNN4uR70WWW7Z3RPJeISTNiiaU
         y/hbBOhp1VdQBhT4fXzHBg7g58QpNOwZCBT0/bxMoW0olgd4dPh9sJA64yoQnNtRi2
         7JOEZrskz/WTA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: drop beacon and probe response which leak from
 other
 channel
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211026025114.26313-1-quic_wgong@quicinc.com>
References: <20211026025114.26313-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163889987494.24891.11641687858291703677.kvalo@kernel.org>
Date:   Tue,  7 Dec 2021 17:57:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When scan request on channel 1, it also receive beacon from other
> channels, and the beacon also indicate to mac80211 and wpa_supplicant,
> and then the bss info appears in radio measurement report of radio
> measurement sent from wpa_supplicant, thus lead RRM case fail.
> 
> This is to drop the beacon and probe response which is not the same
> channel of scanning.
> 
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Reported-by: kernel test robot <lkp@intel.com>

Fails to apply:

error: patch failed: drivers/net/wireless/ath/ath10k/wmi.c:2610
error: drivers/net/wireless/ath/ath10k/wmi.c: patch does not apply
stg import: Diff does not apply cleanly

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211026025114.26313-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

