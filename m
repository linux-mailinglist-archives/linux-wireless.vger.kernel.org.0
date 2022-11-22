Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE733633986
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 11:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbiKVKQN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 05:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiKVKQI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 05:16:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187513FBB6
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 02:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFF1DB81604
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 10:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDDAC433C1;
        Tue, 22 Nov 2022 10:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669112165;
        bh=3o0dDTAitOz4ci3/6xXtJFTXjMpKFaAFwKBXxeRjpao=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=h/+cVmNidYrwO8blOYLqomb/xZyHhfSTyszk+kt4AmaBmX+ohu+TZWLX92sqxDIBh
         hXDsVRQ08L6MOq2WCHaAyb8lcIs8wH2HdnjT3qscaB63HUHEIkezFPTKivcLuIgF/6
         CKJTwNapnDO28EguViBE2ARowDbhpqLUQmBFttxlBzb7/VSE6akfGxEnLAoNe9qVVL
         slr6hcZbpNJ19i72IW2eHw4LWiRWMvtFXS6ZeJmsnJ15EYNIoXwemDg0Uik/l3aGYf
         tRZyNLxg5fONr1ImrdMb6kj3jV6naf+//EKQIhr7HHaeIhyQ8jtRttA5dNMhuGijbL
         MzuiRC2GanYrw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: avoid inaccessible IO operations during
 doing
 change_interface()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221117085235.53777-1-pkshih@realtek.com>
References: <20221117085235.53777-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166911216314.12832.10530952554489139997.kvalo@kernel.org>
Date:   Tue, 22 Nov 2022 10:16:04 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> During doing change_interface(), hardware is power-off, so some components
> are inaccessible and return error. This causes things unexpected, and we
> don't have a warning message for that. So, ignore some IO operations in
> this situation, and add a warning message to indicate something wrong.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

ac3a9f1838d8 wifi: rtw89: avoid inaccessible IO operations during doing change_interface()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221117085235.53777-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

