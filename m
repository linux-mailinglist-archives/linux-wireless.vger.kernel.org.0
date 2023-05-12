Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2FB70026A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 10:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbjELIWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 04:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjELIWe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 04:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B25940CD;
        Fri, 12 May 2023 01:22:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C334560920;
        Fri, 12 May 2023 08:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487E0C433D2;
        Fri, 12 May 2023 08:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683879752;
        bh=eOuGicipDQ0S1L6yb+ho/AhSB+0Z3aOwwL53vP8BHds=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n9AhOre7C1ZOpLqtoJnN01zZogLEk9y4P4e0nd4NPAiUJlUoqUrzkj7FuoJN+mqFt
         fc0paOXUt+1gzjCdb0xo7KdsBEOq4Kk7poAjDSCligcb4gIodaTg/2sv2J3tyLLC0+
         YpClFlvZda8lQCpGh/U1vXVmoFWY/UnfBLwtur9/QJbKr8FPNVBbJ9S+E7MB0tk9Re
         DY0OAU15yuDHp+Na82wTlPRgS3W4Yk4fEr8JneD0SVAo12l+tVN5+p15CuSOPVoU/g
         xztAGc/u5h+q3QgGIK++riZ9clBtnUNZegnWk1X2F0xiQk+b4ihDhQHVtBieO1vkKn
         y1rzhM/NnpYsg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtw89: 8852b: adjust quota to avoid SER L1
 caused by
 access null page
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230426034737.24870-1-pkshih@realtek.com>
References: <20230426034737.24870-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <stable@vger.kernel.org>, <Larry.Finger@lwfinger.net>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168387974912.10206.8566556149003653588.kvalo@kernel.org>
Date:   Fri, 12 May 2023 08:22:31 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Though SER can recover this case, traffic can get stuck for a while. Fix it
> by adjusting page quota to avoid hardware access null page of CMAC/DMAC.
> 
> Fixes: a1cb097168fa ("wifi: rtw89: 8852b: configure DLE mem")
> Fixes: 3e870b481733 ("wifi: rtw89: 8852b: add HFC quota arrays")
> Cc: stable@vger.kernel.org
> Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Link: https://github.com/lwfinger/rtw89/issues/226#issuecomment-1520776761
> Link: https://github.com/lwfinger/rtw89/issues/240
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

c0426c446d92 wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by access null page

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230426034737.24870-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

