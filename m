Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD87694DDF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjBMRZP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBMRZO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:25:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD58DE048
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 220A1CE1C4C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EF6C433D2;
        Mon, 13 Feb 2023 17:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676309110;
        bh=228pIzvKm/oYvC3tn6M3ie0cxdZYxGvD+FqK4eEKERA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DvLkj7JCOdrPdS2I3EQMvC2aObbuPc1K9wW+zoY1LyH+9f+tRSdkQo8mWKrXRP/0c
         OxTUhh8QWnlYQ6veXxSGJiaRprjO+a2jVXd146GnwSQxa75wL0JWgu5blTy2X7QGYi
         kEqiT/U5q4J7cumx72ATOiCWLdoM0GqNUF7U9IQmzsqvpczeTN2VCxjTaEDSkGIyZS
         atqlMABibOb5DbgxEaU0XSs/0YsdEeWwc1HweE6/6p1ZS+7HAzeAvpyiYZui8oeQf8
         fHQCMKe4OUy7vLPzI8kVNwiO6rOfh1NjNkXqA3+zXjFx4AXCuQr5RhppccXhKRumwc
         oM7xDc+IybnQg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: fix txdw7 assignment of TX DESC v3
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230119113146.9640-1-pkshih@realtek.com>
References: <20230119113146.9640-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <Jes.Sorensen@gmail.com>, <linux-wireless@vger.kernel.org>,
        <rtl8821cerfe2@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630910749.12830.13385949308945959484.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:25:09 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Type of txdw7 is __le16, so assign __le32 is wrong. Also, the
> TXDESC_ANTENNA_SELECT_C is defined for __le32, so shift 16 bits to fit
> the value. Compile test only.
> 
> sparse warnings: (new ones prefixed by >>)
> >> rtl8xxxu_core.c:5198:24: sparse: sparse: invalid assignment: |=
> >> rtl8xxxu_core.c:5198:24: sparse:    left side has type restricted __le16
> >> rtl8xxxu_core.c:5198:24: sparse:    right side has type restricted __le32
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Patch applied to wireless-next.git, thanks.

6869ba4911df wifi: rtl8xxxu: fix txdw7 assignment of TX DESC v3

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230119113146.9640-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

