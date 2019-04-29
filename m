Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF4E464
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfD2OMq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:12:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34586 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbfD2OMq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:12:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5F41C608D4; Mon, 29 Apr 2019 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556547165;
        bh=1YZh4rF0kC09u7WTScxlAdfqd54VJi90HDJpSFG+7ok=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LgQ7oG3a7aMS2P6gFSOq//qIm4Y6+BciY5Ss2yC6sW86P94t7y4jmF+XvgOnOeIWA
         LzvjzHpbrTWsmPBphGPr0oCk2WZfcWB/L77o0UiQG+yzyFl+VOO8KQ3rFts2SS0Pb/
         wh9qPCUL9mPCWZr8lx7x7MNEAgzWJKT0QBwDl7yo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA37060128;
        Mon, 29 Apr 2019 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556547164;
        bh=1YZh4rF0kC09u7WTScxlAdfqd54VJi90HDJpSFG+7ok=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cAqhi9CYDKkZOBxA+SjQlQNFW46U5JNEPqdn2l2ODhmMoOUm+6R6xvBr7riMX5Mba
         APcNs7VLVnkaVy7XHUL08RmiS6J0B72v35YHVtuyOW6SjJCdDCajyk5WQd7xJUCAiJ
         FzlBzv2rV7iqpsnfXvOkRaxWw1LQwfBHS5X6jaas=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA37060128
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sriram R <srirrama@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        "open list\:NETWORKING DRIVERS \(WIRELESS\)" 
        <linux-wireless@vger.kernel.org>, ath10k@lists.infradead.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: [PATCH] ath10k: Drop WARN_ON()s that always trigger during system resume
References: <2884043.Jv1Mn93hE8@aspire.rjw.lan>
        <20190403195718.GA74723@google.com>
        <87o94tutdz.fsf@kamboji.qca.qualcomm.com>
        <CAJZ5v0ifD=DATprUeeO2_LGs04aEEhPB6AcGVPxWUdQaOma+ww@mail.gmail.com>
        <CALiNf2_qV+iViHbS0tQquTMZfu6XfFvQCH14mdT5bixn94DZ2Q@mail.gmail.com>
Date:   Mon, 29 Apr 2019 17:12:39 +0300
In-Reply-To: <CALiNf2_qV+iViHbS0tQquTMZfu6XfFvQCH14mdT5bixn94DZ2Q@mail.gmail.com>
        (Claire Chang's message of "Mon, 29 Apr 2019 18:41:50 +0800")
Message-ID: <87ef5ksxwo.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Claire Chang <tientzu@chromium.org> writes:

> Tested-by: Claire Chang <tientzu@chromium.org>
>
>> Still, I'm quite sure that the WARN_ON()s trigger during system resume
>> regardless of the hw/fw combination.
>
> Also see this on sido:
>
> [    4.925278] ath10k_sdio mmc1:0001:1: qca6174 hw3.2 sdio target
> 0x05030000 chip_id 0x00000000 sub 0000:0000
> [    4.935721] ath10k_sdio mmc1:0001:1: kconfig debug 1 debugfs 1
> tracing 1 dfs 0 testmode 1
> [    4.948750] ath10k_sdio mmc1:0001:1: firmware ver
> WLAN.RMH.4.4.1-00007-QCARMSWP-1 api 6 features wowlan,ignore-otp crc32
> b98adaf8
> [    5.132728] ath10k_sdio mmc1:0001:1: board_file api 2 bmi_id 0:4
> crc32 6364cfcc

Great, thanks. I added your Tested-by as well.

-- 
Kalle Valo
