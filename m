Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53E669F494
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 13:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjBVMb2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 07:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBVMb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 07:31:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E395638B74
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 04:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72D3361411
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 12:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012BCC433D2;
        Wed, 22 Feb 2023 12:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677069085;
        bh=e+rnIeUsS7JCZ4Ym1Z30Bjs7gJNIi0XDvAqccknPqpw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=gZyt7qn1ssZ6O8nIfXS0cnN8V7i1zg9xiXLfI8cbz8dqc4Se5LDj8nxZxBPqEQLEz
         c04aYWxafys5CE1+MmiQKc/7uVhK6Iv+hlssSdHR94XR6jbK67ekyI5KuMD8LXPthY
         alFNhUcwcWJHJx+tB/PsBopzNIDEXIcgCx8rOmMFpVRTVUZwwD8V5jipUnPwWzdKxu
         e5ZyYsa1ovb38WWOZyv2B2UVA7fpDMqu0c2Ca5wDk4rvZxybftDDOJZX1JtUHzofWe
         bPGZHYrrnMUPqSVGSgppqM0Vwfrqi7ihikAvH1yFGvd+enQTgrU2mvkrgO/u2IBrjr
         ZarOdcxlEHEAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: Remove always true condition in
 rtl8xxxu_print_chipinfo
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <68eff98b-a022-5a00-f330-adf623a35772@gmail.com>
References: <68eff98b-a022-5a00-f330-adf623a35772@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167706908315.20055.17316683017000986435.kvalo@kernel.org>
Date:   Wed, 22 Feb 2023 12:31:24 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Fix a new smatch warning:
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:1580 rtl8xxxu_print_chipinfo() warn: always true condition '(priv->chip_cut <= 15) => (0-15 <= 15)'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302140753.71IgU77A-lkp@intel.com/
> Fixes: 7b0ac469e331 ("wifi: rtl8xxxu: Recognise all possible chip cuts")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

b9b1e4fe2957 wifi: rtl8xxxu: Remove always true condition in rtl8xxxu_print_chipinfo

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/68eff98b-a022-5a00-f330-adf623a35772@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

