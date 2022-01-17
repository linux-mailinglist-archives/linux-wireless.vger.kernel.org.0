Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98952490AB7
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jan 2022 15:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbiAQOs4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jan 2022 09:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiAQOsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jan 2022 09:48:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380C4C061574
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 06:48:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF23EB80E03
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jan 2022 14:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE99EC36AEC;
        Mon, 17 Jan 2022 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642430932;
        bh=uxtZp7jFFEMwhOZNMTMWbivpAvT9tM/QEjNTQflZiDI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qGnlxrKJDj6iLgVBpN2Vfb69Uhr+hqj5zCCamhEw0Z+FxYR1imQhL095e6sEPWtuy
         RDbaTq4xZwuqjWQHV/HvjODpW7QLs8zh1lWM1bM0IvMJ6mHuWuho7f1EN2eG8cIVwM
         7lIsoCy7mLtPDH2UYeIEe+rC1f105yW9rfAuQvEuDpQ5MnIzBLP5/Rqs/z+7ii2QoC
         I9u5nRA//hQhM/XG3LyGBRH5+Ug1rhaJcbmd7rnOO295riMJWRtZpSa3QB6yN/XQKh
         rsjiouo2b3quaGdTnRAY148tT/A8pdFN9ZNDfJzcy2fDClkG0hRScs8yFJFaR6yrIi
         fN+2Sfbze6m9A==
From:   Kalle Valo <kvalo@kernel.org>
To:     fckath@web.de
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: ath11k and the 32 MSI problem
References: <trinity-f503010b-028a-4c52-a368-56b3e6a1e645-1642429792868@3c-app-webde-bap30>
Date:   Mon, 17 Jan 2022 16:48:49 +0200
In-Reply-To: <trinity-f503010b-028a-4c52-a368-56b3e6a1e645-1642429792868@3c-app-webde-bap30>
        (fckath's message of "Mon, 17 Jan 2022 15:29:52 +0100")
Message-ID: <87zgnuifji.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(adding ath11k list)

fckath@web.de writes:

> Hello world;
> =C2=A0
> I've got a bunch of M.2 Type A/E Wifi 6e cards from Emwicon (WMX7205)
> and Sparklan (WNFQ-268AXI(BT)) wirth Qualcomm WCN6856 chips.
> =C2=A0
> I'd like to use them on DFI AL553 3.5" SBCs with ATOM E3940 processor
> (https://www.dfi.com/de/product/index/1409), but I was hit by the
> error message "failed to get 32 MSI vectors, only -28 available". Ok,
> it seems that the Atom E3900 does not support VT-d. I managed to get
> these card working on standard PCs with i7 and i5 with active VT-d.
> However, when disabling VT-d in the BIOS I get the same behaviour as
> on the Atom boards.
>
> I tried the single MSI patch on
> https://wireless.wiki.kernel.org/en/users/drivers/ath11k but failed to
> apply these patches to an 5.15.0 kernel from Debian backports.
>
> Are there
>  - patches for 5.15 or 5.16?
>  - patched drivers for 5.15 or 5.16?
>  - information where to find a matching driver source on which the patche=
s will apply?

The support for one MSI vectors will be in v5.17-rc1, which should be
released next Sunday. The feature is already on Linus' tree.

IIRC you need these commits, in case you want to backport them:

e94b07493da3 ath11k: Set IRQ affinity to CPU0 in case of one MSI vector
915a081ff307 ath11k: do not restore ASPM in case of single MSI vector
ac6e73483f7b ath11k: add support one MSI vector
c41a6700b276 ath11k: refactor multiple MSI vector implementation
4ab4693f327a ath11k: use ATH11K_PCI_IRQ_DP_OFFSET for DP IRQ
01279bcd01d9 ath11k: add CE and ext IRQ flag to indicate irq_handler
87b4072d7ef8 ath11k: get msi_data again after request_irq is called
081e2d6476e3 ath11k: add hw_param for wakeup_mhi

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
