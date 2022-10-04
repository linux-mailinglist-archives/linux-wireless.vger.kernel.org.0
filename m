Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4776F5F3E38
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJDIYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJDIYU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:24:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971C01C123
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85A7EB81914
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0343C433C1;
        Tue,  4 Oct 2022 08:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664871856;
        bh=m9NABulRJTUI14lmDKSVXLZFdhGPZ24by48nUlRAXwc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=btX8Pv/ZeGxdp5ZLWAw0fwiHFZBq27vuc/0ms858zwtgm/U0JLOfbzhIYK3el6Hw+
         epo647MO6ZRtUalnnKt4LUco430WIZmzjtgKdTmD1GzF2UZnocNP2lGjQe5yodFaLL
         65wJO4E7RWvFbybWBWCgUreuD4fp877jtEsrBFcIKjjIdYvwqb+xZMCbpkZNMnaDwD
         or5idyn9vs8rMo0M2+qPhwxNk1EFP3gVI0OBtyee9bGhA5p6iqOzxspez0IBZ0mDwA
         4hKlVjZYZ76PtFpyvNhtIL9+D8XNbANUOss0mZHmLHiDwCKDL7X6yl38eRhn771SI9
         2D2TmVql+8jow==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>
Subject: Re: [PATCH v3 1/4] brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection
References: <20220929012527.4152-2-ian.lin@infineon.com>
        <166487156053.9318.11274787933218797801.kvalo@kernel.org>
Date:   Tue, 04 Oct 2022 11:24:12 +0300
In-Reply-To: <166487156053.9318.11274787933218797801.kvalo@kernel.org> (Kalle
        Valo's message of "Tue, 4 Oct 2022 08:19:23 +0000 (UTC)")
Message-ID: <87h70k574j.fsf@kernel.org>
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

Kalle Valo <kvalo@kernel.org> writes:

> Ian Lin <ian.lin@infineon.com> wrote:
>
>> From: Wright Feng <wright.feng@cypress.com>
>> 
>> To enable ACS feature in Hostap daemon, dump_survey cfg80211 ops and dump
>> obss survey command in firmware side are needed. This patch is for adding
>> dump_survey feature and adding DUMP_OBSS feature flag to check if
>> firmware supports dump_obss iovar.
>> 
>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>
> 4 patches applied to wireless-next.git, thanks.
>
> 64a86f1a0619 brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection
> a8071cdc0290 brcmfmac: fix firmware trap while dumping obss stats
> ef1a776197fe brcmfmac: fix CERT-P2P:5.1.10 failure
> 5eb95da2be1e brcmfmac: Fix authentication latency caused by OBSS stats survey

Please disregard the commit ids, I need to rebase so the commit ids will change.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
