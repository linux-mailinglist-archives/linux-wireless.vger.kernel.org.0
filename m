Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345146E9482
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjDTMe0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjDTMeZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9B37DA3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E316123A
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 12:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9CCC433D2;
        Thu, 20 Apr 2023 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681994000;
        bh=hrGiqkjnueLtKlSVPIc31tG670ePcgMh0GK7hP0j5KU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=f3H9uJRKYEDrOOaMy5DnXd06+Dk7hVJhho+qgK5+iTpdq0BPDoPvk5H0AhyFtjuCT
         pdNhy1hK36WUSACpXnjtdcp+odQfmUYcqAS7/xSHsDrpN5rRo1Fcx+HtpJxy16MXLg
         ecV694FLfna1taFnZLdRb8HehXb0InEDiPgUypUllWni/eS6dMzsFFVgp4hZb+H1FF
         xYG1g7tlUhavy4r6jDPZU8NPMo/2WEIO9FW9PvV+f7XUv42ZE+/CANAJGewovLmTp/
         ImLds1LX41YLnKim02vXcSG4knSAT4HDcNnKacc3onJAteaZPzyogJoCqop7a/lBUk
         qn49snvdZOdIg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: mac: use regular int as return type of DLE
 buffer request
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230414082228.30766-1-pkshih@realtek.com>
References: <20230414082228.30766-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168199399542.31131.14153398071731527302.kvalo@kernel.org>
Date:   Thu, 20 Apr 2023 12:33:20 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The function to request DLE (data link engine) buffer uses 'u16' as return
> value that mixes error code, so change it to 'int' as regular error code.
> Also, treat invalid register value (0xfff) as an error.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

eaddda248483 wifi: rtw89: mac: use regular int as return type of DLE buffer request

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230414082228.30766-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

