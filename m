Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA1E697794
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Feb 2023 08:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjBOHvQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Feb 2023 02:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjBOHvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Feb 2023 02:51:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23F26E99
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 23:51:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DE9661A71
        for <linux-wireless@vger.kernel.org>; Wed, 15 Feb 2023 07:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E5CC433D2;
        Wed, 15 Feb 2023 07:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676447468;
        bh=fWsRDTeLyopWkpBIY9xPw7LdCjw6nsVDzetsLA8aRgw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tIp5C1oD0XFM1aSk10p7VFFORGZzDbbRESrdATxW4418l5Bs9ox5+2AnmrdH+2LuP
         oGx22Uu9feV4BnoU+UU4l2P6gCNs+AZA7HdF9uSgijN5x//8GY67eLMn8frpC9605j
         NqiHNH+XjGyCeEw+3C+d/99ILTVTuyazLjWERl+H9xr2krBvUbgraI5XuO97Zuibjs
         c3DRzcVaJ92cpZ1bGvQIFqRlKFNtbJCd9EakeFr9AqboQUnlRADNPoFk2e3ad9xQXW
         psrOSjHNI6BOefCucSskm16Cwze3MDWsYH5lj33JVZD4gDbntH5P8vcmSuxaBktWLy
         lww3/qwD+qI2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: use readable return 0 in
 rtw89_mac_cfg_ppdu_status()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230213091328.25481-1-pkshih@realtek.com>
References: <20230213091328.25481-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <error27@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167644746638.2758.1702991891864476396.kvalo@kernel.org>
Date:   Wed, 15 Feb 2023 07:51:07 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> For normal (successful) flow, it must return 0. The original code uses
> 'return ret', and then we need to backward reference to initial value to
> know 'ret = 0'. Changing them to 'return 0', because it will be more
> readable and intuitive. This patch doesn't change logic at all.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302101023.ctlih5q0-lkp@intel.com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

210871887208 wifi: rtw89: use readable return 0 in rtw89_mac_cfg_ppdu_status()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230213091328.25481-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

