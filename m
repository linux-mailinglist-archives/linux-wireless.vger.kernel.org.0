Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109585F3E4F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJDI2Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiJDI2K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:28:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D442B197
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:27:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC35E6126C
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E20C433C1;
        Tue,  4 Oct 2022 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664872072;
        bh=F1bCvc4N6d+/EJNSdyMPN69GqhRF7Pd0a9E4gnjUcsE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HEjS/jFl6oV0bEpj31CUwm+YN1Hul47ZWHmyf6od65Qmq/2UNWTttAQYjjn4pfUHM
         6766IsGkDmJpSis6mJjS8lD1oNiTah5pUa1b/H/oX4vuhC0LtoBpR2vUPXthm+6ANq
         y4pJB4Q85r/X35iTYl/UVzXLKkEvnpCsG+RQz+JLI1kpqTYvZU76yTkHyprxMxQkM0
         Ty+iRcDAWSpFAFBXnuBgEItYZVb0o87Vkn2VVwEr9K+lR/WK9Vkj85/Xg+2puWc+Ph
         bdN7nNFOJQr7gRahvNAu+X2oYetEOUR0kbrXV59a06hLnZ/8e9fZDVLX4P7FRX0ywM
         LG2ICkQJvybvw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/4] brcmfmac: Add dump_survey cfg80211 ops for HostApd
 AutoChannelSelection
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220929012527.4152-2-ian.lin@infineon.com>
References: <20220929012527.4152-2-ian.lin@infineon.com>
To:     Ian Lin <ian.lin@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <franky.lin@broadcom.com>,
        <hante.meuleman@broadcom.com>, <Double.Lo@infineon.com>,
        <ian.lin@infineon.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166487206879.2137.2631764099038197338.kvalo@kernel.org>
Date:   Tue,  4 Oct 2022 08:27:50 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ian Lin <ian.lin@infineon.com> wrote:

> From: Wright Feng <wright.feng@cypress.com>
> 
> To enable ACS feature in Hostap daemon, dump_survey cfg80211 ops and dump
> obss survey command in firmware side are needed. This patch is for adding
> dump_survey feature and adding DUMP_OBSS feature flag to check if
> firmware supports dump_obss iovar.
> 
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>

4 patches applied to wireless-next.git, thanks.

6c04deae1438 brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection
216647e6aaaf brcmfmac: fix firmware trap while dumping obss stats
25076fe2a602 brcmfmac: fix CERT-P2P:5.1.10 failure
62ccb2e6f208 brcmfmac: Fix authentication latency caused by OBSS stats survey

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220929012527.4152-2-ian.lin@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

