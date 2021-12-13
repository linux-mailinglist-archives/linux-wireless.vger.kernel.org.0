Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C244734A0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 20:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbhLMTEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 14:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbhLMTEj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 14:04:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBEEC061574
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 11:04:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CCB0611B4
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 19:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA206C34604;
        Mon, 13 Dec 2021 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639422278;
        bh=Pd6ZZJBN+xfki9RvtjiVCvd6Aqn/UeTpdDHvUe87Mvg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Kohz/VDLdmDdPQnG2Vuuycz1N3ZQhEYEdOhPSraS8TP3poDJY7fQD9eXOimQkMfHh
         eisG30xdPd35VuHcjXJlpsPyFDt4mRAVzGMgtzYF2f8QGfDE3hxxgnEnUuQcy6jNl4
         VXUjSfOE31k7acoZ7fzB68rVlNJUF4O3zx90KwTivoiZ3H1wfAYhgGYykaB89X8FjP
         tsBqgLvP3yyqu1flLptz+Cr/xZ8dqwUjjqijTOMDYZA63h+nKYDE0aPm91nJOcYrVP
         Tib54vCL+2GxeYwZSTau9hmOcXBUDegHqChuBx7zxRWC0O5dE33bhjrpKJIv+gyq2O
         j+fr/LROLakPw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] brcmfmac: Fix incorrect type assignments for keep-alive
References: <1638953708-29192-1-git-send-email-loic.poulain@linaro.org>
        <163942183691.6700.15831682111724282439.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 21:04:33 +0200
In-Reply-To: <163942183691.6700.15831682111724282439.kvalo@kernel.org> (Kalle
        Valo's message of "Mon, 13 Dec 2021 18:57:18 +0000 (UTC)")
Message-ID: <87tufcmim6.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> Loic Poulain <loic.poulain@linaro.org> wrote:
>
>> cpu_to_le16 has been used for all keep-alive fields, but 'perdio_msec'
>> is a 32-bit field and 'keep_alive_id' a 8-bit one. Fix that.
>> 
>> Fixes: 7a6cfe28ae3e ("brcmfmac:  Configure keep-alive packet on suspend")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
>
> Patch applied to wireless-drivers-next.git, thanks.
>
> 78da5cca6ece brcmfmac: Fix incorrect type assignments for keep-alive

Actually the fixes tag was incorrect, I fixed it but the commit id changed:

3db30b790289 brcmfmac: Fix incorrect type assignments for keep-alive

The error was:

In commit

  78da5cca6ece ("brcmfmac: Fix incorrect type assignments for keep-alive")

Fixes tag

  Fixes: 7a6cfe28ae3e ("brcmfmac:  Configure keep-alive packet on suspend")

has these problem(s):

  - Subject does not match target commit subject
      Just use
           git log -1 --format='Fixes: %h ("%s")'

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
