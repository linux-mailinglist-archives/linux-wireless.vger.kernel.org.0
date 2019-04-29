Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6036DE994
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 19:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfD2R6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 13:58:47 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47154 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbfD2R6q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 13:58:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1806F60850; Mon, 29 Apr 2019 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556560726;
        bh=5TrNGB0Vt1PiDJmJSN6BEJmawdsW3EAaTzNwwM9jFjw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eusJ8tsPjmZceud6ZRCFA4oOx2nDOo4UDaXOa/Ar+wf33hzJIOBB5QfVJiG/BgZAZ
         gsXEMggHoSXkSi8dHOvpIulXU7+Yn1H3swac6LdzVpQeZYA4lKNnq7/26h2MlmerwO
         C2lomXBcnrh5VA1YMkFjYeXEHR8abPNzghc0lGXs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4D27C60240;
        Mon, 29 Apr 2019 17:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556560724;
        bh=5TrNGB0Vt1PiDJmJSN6BEJmawdsW3EAaTzNwwM9jFjw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JQwzAg7oAUJimh2bXat/85TTBrtG9kkDmumgpL6ka2y3YwJzjo5Zjz/hBvqKhFkH7
         TXC5NyOOJ+d6hLFmD0V60vE1/6v6VPc2ySvOMk5o4VW8cZCiYSDRpU1mSLffGiZY46
         GCVGhxhldc179s94biiyeeQ7PkIINIk+JatR3P/I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D27C60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Subject: Re: pull-request: iwlwifi-next 2019-04-29
References: <491e2c7557a981d2e1a721ffe7571ec992dfe62d.camel@coelho.fi>
Date:   Mon, 29 Apr 2019 20:58:41 +0300
In-Reply-To: <491e2c7557a981d2e1a721ffe7571ec992dfe62d.camel@coelho.fi> (Luca
        Coelho's message of "Mon, 29 Apr 2019 19:00:30 +0300")
Message-ID: <875zqwsnfy.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> This is the fourth batch of patches intended for v5.2.  This includes
> the last patchset I sent.  Usual development work.  More details about
> the contents in the tag description.
>
> I have sent this out before and kbuildbot reported success.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit 9ef77fbedad9ea8895cd5d7fb7aee16071f527dc:
>
>   brcmfmac: send mailbox interrupt twice for specific hardware device (2019-04-26 15:00:53 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2019-04-29
>
> for you to fetch changes up to a0eaead41db98c08614c4b1ef453bdfaacde962d:
>
>   iwlwifi: dbg_ini: check for valid region type during regions parsing (2019-04-29 18:42:48 +0300)
>
> ----------------------------------------------------------------
> Fourth batch of patches intended for v5.2
>
> * Fix a bug we introduced in the RX path in a previous patch;
> * Add command version parsing from the FW TLVs;
> * Some fixes and improvements in the new debugging framework;
> * Bump the FW API supported for 22000 series;
> * Small improvement in FTM;
> * Some RF-Kill interrupt handling fixes;
> * Support for a new WoWLAN patterns FW API;
> * Other small fixes and improvements;
>
> ----------------------------------------------------------------

Pulled, thanks Luca.

-- 
Kalle Valo
