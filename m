Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931785EEDD6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Sep 2022 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiI2GXw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Sep 2022 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbiI2GXv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Sep 2022 02:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F1812969D
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 23:23:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B80376202F
        for <linux-wireless@vger.kernel.org>; Thu, 29 Sep 2022 06:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F724C433D7;
        Thu, 29 Sep 2022 06:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664432630;
        bh=gGVKnk5tdrKF7EF6Tn/YMG+mjTSIhDxU33qoCsKVtqQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CgQCJiylIILmpxDhSzqtk3etl6d4TpPObcG2ftHEiyqwAx8Kqp8/WYnshvJO8x62Y
         jPNPrh1Hf5JcWVLTWSURHTPln2l93SNF/qIXzghcaj8el2NpKS6Jv6ZiY2qj1jDwsl
         +53gcAgv1ogVPmsy8M6KB0Zf1IcDXnk6hXEUouUwAKtq03dX/LScPdis8iWSkE5gWi
         cTUWUf+D5Jf9i4KMYDSbZzSC8kyDuILKCLSndRPFLRjQNNEComftPvgRmeuIoWI+Fa
         H6i/XMFwls1u0Rd8qhIYkMpvHG6qXz4SeqasevFbgUQHb5FsvsC5TmYUf2uqGHHJfE
         fOojOnP0msr4A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>, chris.chiu@canonical.com
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Support new chip RTL8188FU
References: <dfc6a877-e50a-87a2-08f7-7007c8083386@gmail.com>
        <87bkr27amy.fsf@kernel.org>
        <b8af19f6-564e-d592-0993-6b4c33728ac4@gmail.com>
Date:   Thu, 29 Sep 2022 09:23:46 +0300
In-Reply-To: <b8af19f6-564e-d592-0993-6b4c33728ac4@gmail.com> (Bitterblue
        Smith's message of "Wed, 28 Sep 2022 20:53:36 +0300")
Message-ID: <87v8p6r959.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> On 26/09/2022 12:22, Kalle Valo wrote:
>
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>> 
>> [...]
>> 
>>> +static struct rtl8xxxu_reg8val rtl8188f_mac_init_table[] = {
>> 
>> [...]
>> 
>>> +static struct rtl8xxxu_reg32val rtl8188fu_phy_init_table[] = {
>> 
>> [...]
>> 
>>> +static struct rtl8xxxu_reg32val rtl8188f_agc_table[] = {
>> 
>> [...]
>> 
>>> +static struct rtl8xxxu_rfregval rtl8188fu_radioa_init_table[] = {
>> 
>> [...]
>> 
>>> +static struct rtl8xxxu_rfregval rtl8188fu_cut_b_radioa_init_table[] = {
>> 
>> Can these arrays be static const?
>> 
> Only if I modify the functions rtl8xxxu_init_phy_regs and
> rtl8xxxu_init_phy_rf, and the struct rtl8xxxu_fileops. Otherwise the
> compiler complains about discarded const. Perhaps in a future patch?

Yeah, a future patch sounds good.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
