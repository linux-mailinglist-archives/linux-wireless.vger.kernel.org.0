Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C465F3D0C
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 09:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJDHHj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 03:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDHHh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 03:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2B481CE
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 00:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9BB73B8162A
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 07:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57D0C433D6;
        Tue,  4 Oct 2022 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664867253;
        bh=l+Ce8zHOlThDhcfP0o2VnzAhafAV2jKaOsmpgOKvnUE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JRHDR+P81kviqjlqnjZEAx1kfeKWz4MZ9v0msXucvA6kOtrpd74y8r1ZpbqeohmYP
         x2Vb9rs0pkW/rdyBE4W6nPFbSZfN7yF5FGr3wZyNCx1UTT4ISislYldU2vjukAfWK8
         +2YRB6hJ/8awmUbp89UFHZJD+YKrAFtciwumaCOiUrl8nstAoy8p853tLlLPMdpTbU
         uU94KsqKpLIr013GPdYEGhSxGkKp+tv6Kfpk5KBwMKgDwlCQRqmKzthQ1nD7ZWtcOR
         FAEy62KzZFNSQgaPY0JGgtqCyM8w2+2frh+X1CRXIjQAZntRgWtUP+AoxVThJehkhL
         xoExnqCtjgQhA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH 1/3] brcmfmac: add a timer to read console periodically in PCIE bus
References: <20220929031001.9962-1-ian.lin@infineon.com>
        <20220929031001.9962-2-ian.lin@infineon.com>
Date:   Tue, 04 Oct 2022 10:07:26 +0300
In-Reply-To: <20220929031001.9962-2-ian.lin@infineon.com> (Ian Lin's message
        of "Wed, 28 Sep 2022 22:09:59 -0500")
Message-ID: <87edvoqd75.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ian Lin <ian.lin@infineon.com> writes:

> From: Wright Feng <wright.feng@cypress.com>
>
> Currently, host only reads console buffer when receiving mailbox data or
> hit crash with PCIE bus. Therefore, we add timer in PCIE code to read
> console buffer periodically to help developer and user check firmware
> message when there is no data transmission between host and dongle.
>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>

[...]

> @@ -340,6 +342,11 @@ struct brcmf_pciedev_info {
>  			  u16 value);
>  	struct brcmf_mp_device *settings;
>  	struct brcmf_otp_params otp;
> +#ifdef DEBUG
> +	u32 console_interval;
> +	bool console_active;
> +	struct timer_list timer;
> +#endif
>  };

I was wondering where that DEBUG is defined and found that it's done in
the Makefile:

subdir-ccflags-$(CONFIG_BRCMDBG)	+= -DDEBUG

I think that DEBUG define should be removed and instead CONFIG_BRCMDBG
should be used all over the brcmfmac and brcmsmac code. A cleanup patch
doing this is very welcome.

This would be a good task for someone new to kernel development, is
there a way to report these kind of simple tasks?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
