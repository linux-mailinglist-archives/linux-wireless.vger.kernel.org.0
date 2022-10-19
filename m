Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5655603968
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Oct 2022 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJSF4k (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Oct 2022 01:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJSF4j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Oct 2022 01:56:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FD54F386
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 22:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C470DCE205C
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 05:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5E4C433D6;
        Wed, 19 Oct 2022 05:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666158994;
        bh=03bAEXcvQdNEwbbwYPGBerdiS2aHV6KTedqnYR+KXyQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QZyU94xtnbuh4tE6fsc33pvDnWICoxdd0t44RGTIx2RDV0jzK6cx3MImYC8LMTkFl
         9C3k0DW1HqApBDCIcJVcWjAmEIeZduBGI5uxzY29p/z+KVliMqtjFHnfIoP6CgGE0h
         oZezaR4xO2MJRSM6oPFHdTMNi07CtZxKFWE0+GlDBda9kwpiH8BN3FSmniYAYuiAqv
         4PkNoqVY0wb23Ot+J3w8YSvSWM01Qlw/o4RnNrFp46sIrQ6MpmeN/4wJHKIF/Hjl5w
         pR7tFiID+05BLxsJIutrylOYn52aq1aGuVjXon/rNPBwFHN/mqllOqZfB9dbkFTMCj
         zp8i+QPilH8Ug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: 8852b: rfk: add DACK
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221012083234.20224-2-pkshih@realtek.com>
References: <20221012083234.20224-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166615899171.17379.15494918296651200606.kvalo@kernel.org>
Date:   Wed, 19 Oct 2022 05:56:34 +0000 (UTC)
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> DACK (digital-to-analog converters calibration) is used to calibrate DAC
> to output good quality signals.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

16be5e3be0e5 wifi: rtw89: 8852b: rfk: add DACK
10298b53bff6 wifi: rtw89: 8852b: rfk: add RCK
212671074ab2 wifi: rtw89: 8852b: rfk: add RX DCK
f2abe804e823 wifi: rtw89: 8852b: rfk: add IQK
7f18a70d7b4d wifi: rtw89: 8852b: rfk: add TSSI

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221012083234.20224-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

