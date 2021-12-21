Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0743F47BE1F
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 11:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhLUKZz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 05:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhLUKZz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 05:25:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4000BC061574
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 02:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEA076150F
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 10:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87632C36AE7;
        Tue, 21 Dec 2021 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640082354;
        bh=q5PhLrmvK2whZQ78l2psm79UksUSAPXS5N/xUZNND/k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d1wQexdrADUXfX40Ar38lgyE88eavweZzFIFS3i7Kn9gL9NFM1V/Ka5Nmn+20ZJgO
         S4LckSDmMlBUMS31yJH1wQjCvvW6wl9bpDSIiAfOlqltZtyR/u0OzPzPfw2Roics5C
         VFfjgjSowvooHaAuwS7Yf7L7+oC21aUk5BJa+fVa5iEmF+0iISI+APIxkpB7y+uJXh
         R1c+INq4Mb9DmyyQ+1diHzPL0Dc9JxRB2A11bms0cJwIKWkXhmjrcqMcQnE+yWMSMh
         5xcbymMomk8883ckb83DvljgTdPE2e5wPnOCDGg+dT1Uk087wwUQCCv7RM4oq/RRRU
         oeampBvQ8QKug==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: pull-request: iwlwifi-next 2021-12-21
References: <64f03fe09e5e811878a609824464d84086c3647f.camel@coelho.fi>
Date:   Tue, 21 Dec 2021 12:25:49 +0200
In-Reply-To: <64f03fe09e5e811878a609824464d84086c3647f.camel@coelho.fi> (Luca
        Coelho's message of "Tue, 21 Dec 2021 10:13:45 +0200")
Message-ID: <875yri9rv6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> Hi Kalle,
>
> Here's my second pull request for v5.17 with the five patchsets I sent
> earlier, plus a couple of indentation fixes and a couple of compilation
> cleanups that were sent to the list earlier.
>
> Otherwise this is all normal development, new features, bugfixes and 
> cleanups.  More details about the contents in the tag description.
>
> Please let me know if there are any issues.
>
> Cheers,
> Luca.
>
>
> The following changes since commit f75c1d55ecbadce027fd650d3ca79e357afae0d9:
>
>   Merge tag 'wireless-drivers-next-2021-12-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-12-17 07:30:07 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-12-21
>
> for you to fetch changes up to 33511b2061dc0cd85bdb3d2a30cf4b875a7b9635:
>
>   iwlwifi: mei: wait before mapping the shared area (2021-12-21 09:54:32 +0200)
>
> ----------------------------------------------------------------
> iwlwifi patches for v5.17
>
> * Support for Time-Aware-SAR (TAS) as read from the BIOS;
> * Fix scan timeout issue when 6GHz is enabled;
> * Work continues for new HW family Bz;
> * Support for Optimized Connectivity Experience (OCE) scan;
> * A bunch of FW debugging improvements and fixes;
> * Fix one 32-bit compilation issue;
> * Some RX changes for new HW family
> * Some fixes for 6 GHz scan;
> * Fix SAR table fixes with newer platforms;
> * Fix early restart crash;
> * Small fix in the debugging code;
> * Add new Killer device IDs;
> * Datapath updates for Bz family continues;
> * A couple of important fixes in iwlmei;
> * Some other small fixes, clean-ups and improvements.
>
> ----------------------------------------------------------------

Some issues:

Commits

  9fae33eb13cc ("iwlwifi: yoyo: fix issue with new DBGI_SRAM region read.")
  64ae418ed8d0 ("iwlwifi: mvm: fix rfi get table vendor command handler")

are missing a Signed-off-by from their authors.


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
