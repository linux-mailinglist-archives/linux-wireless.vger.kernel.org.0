Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0516E9483
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 14:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDTMf2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 08:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjDTMfZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 08:35:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714687695
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 05:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F172764927
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 12:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7578EC433EF;
        Thu, 20 Apr 2023 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681994050;
        bh=n3AhfkANBgXoKmGkGOL43Ok4mXa7p3SWDOCseNUsRXk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Oc4T5CZnOM1swFBJNokOXqTK7VTUU6+vcu2Fwy/wu/Q6HexHnQIxEIp53J8oyAyGg
         HOaTTPDifr8CCuozJ/IESukqUrC4o9vwmy6Hynjj09dQnP1Q0YpvEsRfynyDOrEz70
         JoGbSFW6qzA6cyhOQIHmv71weGklbAzhmsCpi7CPLt0fSoeqexYEbLbeQxt05wbkVY
         7bTyR1H90yYfVjUnIi07PrgOW8Z+4l5aHuinDv80YylwINDw4UquGVyIEobm+LVP35
         iQiNdoLlbzPM3IG9+Qld3OPWOrxHWSeIfU1LlMOhu+NNST/9G/vaPpI9EMKsN3SH/W
         i3lsYf7K3BzxA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/8] wifi: rtw88: add bitmap for dynamic port settings
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230414121135.17828-2-pkshih@realtek.com>
References: <20230414121135.17828-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168199404727.31131.18077753114787654693.kvalo@kernel.org>
Date:   Thu, 20 Apr 2023 12:34:09 +0000 (UTC)
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

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> In order to support multiple interfaces, multiple port settings will
> be required. Current code always uses port 0 and should be changed.
> Declare a bitmap with size equal to hardware port number to record
> the current usage.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

f0e741e4ddbc wifi: rtw88: add bitmap for dynamic port settings
ccf73f6e69c0 wifi: rtw88: add port switch for AP mode
ffa71c547779 wifi: rtw88: 8822c: extend reserved page number
5ec69129f195 wifi: rtw88: disallow PS during AP mode
982f4a2004f7 wifi: rtw88: refine reserved page flow for AP mode
a1b8015da57a wifi: rtw88: prevent scan abort with other VIFs
96fbb84de4ff wifi: rtw88: handle station mode concurrent scan with AP mode
d16836cdcc3b wifi: rtw88: 8822c: add iface combination

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230414121135.17828-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

