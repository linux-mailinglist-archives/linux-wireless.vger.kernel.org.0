Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0109B5F3E1D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbiJDITe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiJDITa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C20E002
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:19:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F7A61157
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84192C433C1;
        Tue,  4 Oct 2022 08:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664871565;
        bh=HZg+SXBy/BRvmqGlGD5YONv+f6RGxu+5DMYD3IPU1YE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VWZevTsK8tOGZNTb2Z5un/Uh75rthfHu0cOB7cN9nWjR3mQWGkQ20O2f3fuqgNCkw
         qo6ygRXIZbuKyoOWnvId42MsxPFllQxg7nXPn1r+EgQ83CyUnGAfDPdLvXTGjYimjP
         MSdeR1WxffnUzRk6AHIULGzqWkpwM8zvaVrhWlQXrZpVUiZ5xSG8tv3v8ln0eSw8Lj
         EfXC+lrvQ6DmetZ0G8CgzlcVyDChVK3PwbR3qrXgaBcNlj1WOMaD67UxK86NxIPbK4
         qU2SngHJZ0CIYyPoaKxTnnVv/C0rMCYSkD94wzLj3TNUzXrMM8HGI1hz72B62VpuA8
         Hsms81DiD5Fhw==
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
Message-ID: <166487156053.9318.11274787933218797801.kvalo@kernel.org>
Date:   Tue,  4 Oct 2022 08:19:23 +0000 (UTC)
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

64a86f1a0619 brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection
a8071cdc0290 brcmfmac: fix firmware trap while dumping obss stats
ef1a776197fe brcmfmac: fix CERT-P2P:5.1.10 failure
5eb95da2be1e brcmfmac: Fix authentication latency caused by OBSS stats survey

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220929012527.4152-2-ian.lin@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

