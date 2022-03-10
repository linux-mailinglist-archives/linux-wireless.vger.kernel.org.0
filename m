Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48DB4D4E29
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 17:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiCJQFk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 11:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbiCJQFj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 11:05:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A1E186440
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 08:04:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03EC3B826BF
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 16:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEE8C340E8;
        Thu, 10 Mar 2022 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646928275;
        bh=nrnANzdnSvIBCfKASEr11xl/I6tjygqYfjIbA7pWatE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=onraeYRordaskzCNrfWQ2wA4WWnNBvYvn5XT7BmpeaEHpfmciRCXYfgtJFfFnmbzR
         SB3aURHqPVFuqGrOgTLk4eeWHCGgf2HsHi6sD6nD2jwau5LXeYmuGa/jQBVXiqrnxf
         IYXjR0xeOdcpzf1w9TSjqD8Frl/49TSm6B+EmQYbmoygvyqLRpE4Icv8GMTHydciFD
         izzxC+X2Rg4HamfSu6a+H9Kvym/hoKosgobIaVJWCtzVxVVuwy0/xJ6HyezFruM1JL
         lp9Hpll5FNoWEiptGUSx4WneL8blS75fQkAdDR3KLgQJAsjImKNjMWDflwO6R7ZB+E
         7hU2N5okUsKYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: MAINTAINERS: brcm80211: remove Infineon maintainers
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220222015947.169224-1-double.lo@infineon.com>
References: <20220222015947.169224-1-double.lo@infineon.com>
To:     Double Lo <double.lo@infineon.com>
Cc:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Double Lo <double.lo@infineon.com>,
        Kurt Lee <kurt.lee@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Double Lo <Double.Lo@infineon.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164692827086.6056.2908596661685495752.kvalo@kernel.org>
Date:   Thu, 10 Mar 2022 16:04:33 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Double Lo <double.lo@infineon.com> wrote:

> From: Double Lo <Double.Lo@infineon.com>
> 
> These email addresses no longer work, so remove them from MAINTAINERS.
> 
> Signed-off-by: Double Lo <Double.Lo@infineon.com>

Patch applied to wireless-next.git, thanks.

56e4e4538ef0 MAINTAINERS: brcm80211: remove Infineon maintainers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220222015947.169224-1-double.lo@infineon.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

