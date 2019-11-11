Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02DBEF82BB
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 23:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKKWIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Nov 2019 17:08:17 -0500
Received: from muru.com ([72.249.23.125]:41752 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKWIR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Nov 2019 17:08:17 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 68BB58047;
        Mon, 11 Nov 2019 22:08:52 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:08:12 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Wen Gong <wgong@codeaurora.org>,
        Erik Stromdahl <erik.stromdahl@gmail.com>,
        Eyal Reizer <eyalreizer@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mmc: Fixup HW reset for SDIO cards
Message-ID: <20191111220812.GX43123@atomide.com>
References: <20191109103046.26445-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109103046.26445-1-ulf.hansson@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

* Ulf Hansson <ulf.hansson@linaro.org> [191109 10:31]:
> Changes in v2:
> 	- Add adaptations to the mwifiex driver.
> 	- Keep existing syncronous reset behaviour if the SDIO card has a single
> 	func driver.
> 
> It has turned out that it's not a good idea to try to power cycle and to
> re-initialize the SDIO card, as currently done through mmc_hw_reset(). This
> because there may be multiple SDIO funcs attached to the same SDIO card and
> some of the others that didn't execute the call to mmc_hw_reset(), may then
> simply experience an undefined behaviour.
> 
> The following patches in this series attempts to address this problem, by
> reworking the mmc_hw_reset() behaviour for SDIO and by adopting the Marvel
> mwifiex driver to these changes.
> 
> Note that, I don't have the HW at hand so the the code has only compile tested.
> Test on HW is greatly appreciated!

Looks good to me. I tried testing this, but looks like at least on duovero
mwifiex_sdio is broken in v5.4-rc7:

# dmesg | grep mwifi
mwifiex_sdio mmc1:0001:1: poll card status failed, tries = 100
mwifiex_sdio mmc1:0001:1: FW download with helper:       poll status timeout @ 0
mwifiex_sdio mmc1:0001:1: prog_fw failed ret=0xffffffff
mwifiex_sdio mmc1:0001:1: info: _mwifiex_fw_dpc: unregister device

No idea when it broke and what might be the issue this time around.
Any ideas?

Regards,

Tony
