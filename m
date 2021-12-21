Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355CA47C5E4
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 19:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbhLUSJQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 13:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbhLUSJO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 13:09:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5679FC06175F
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 10:09:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 231F0B818A4
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 18:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536ECC36AE9;
        Tue, 21 Dec 2021 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640110150;
        bh=l57tvocUd/SI25D3XCSNSVRuTDabgjNWcyrZGdmSXks=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TGbpJetzXkxjWze1q5ygKlThJAMfHAEBcvDpF39DX/TH6QFSzIG4kmGEQv3fJnHqW
         /mBaA5hqnH/TG+Qiy/14jgGilp9q8u1+rET/HmIGCVexJXgFecJwXuP4xIMc74WS/t
         u2bwAOgM8YdqMXHfvgpDTzobuFND3bl1WRpgyDnXBRzq+8iGPct3KxDD6toCXyW8dr
         amtM7dDWA/122p+m/Szb3XOGNW9Dbyk3n/XhYv7mzKlv4btvCSQWx785696dWdbfA7
         VAaaAFQAM3s/4LHHQ/kZ+X55dc9Dk51AGOzbXs192hlxRB360/8fFv8ujnjO34Bmng
         p7ygaJDC36LRA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: pull-request: iwlwifi-next 2021-12-21 v2
References: <51742e95c6f5f523c26cfe1a44c80489b2880708.camel@coelho.fi>
Date:   Tue, 21 Dec 2021 20:09:06 +0200
In-Reply-To: <51742e95c6f5f523c26cfe1a44c80489b2880708.camel@coelho.fi> (Luca
        Coelho's message of "Tue, 21 Dec 2021 12:42:38 +0200")
Message-ID: <871r254ypp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca Coelho <luca@coelho.fi> writes:

> This is version two with the s-o-b's added to where they were missing.
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
> The following changes since commit f85b244ee395c774a0039c176f46fc0d3747a0ae:
>
>   xdp: move the if dev statements to the first (2021-12-18 12:35:49 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git tags/iwlwifi-next-for-kalle-2021-12-21-v2
>
> for you to fetch changes up to bcbddc4f9d020a4a0b881cc065729c3aaeb28098:
>
>   iwlwifi: mei: wait before mapping the shared area (2021-12-21 12:39:04 +0200)
>
> ----------------------------------------------------------------
> wlwifi patches for v5.17 v2
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

Pulled, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
