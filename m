Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4364FE32A
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 15:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350835AbiDLNyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 09:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiDLNyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 09:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4571356779
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 06:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D55DD61AEA
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 13:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50583C385A1;
        Tue, 12 Apr 2022 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649771547;
        bh=ye/JXTtCzIck+Tiv/GFFFHZCtROfPq/UXWfEYmKeiHE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KqHR15L7jT7/UCARxCFPMjIU810rPt8B3NL9iA66De/1j5a4nXKkh7TZPiAWrHcEV
         r22MDL3Qh3tLt5xa7ZkBGYPtlelZ+Gc+BJ4d5mUEFtUFKNTaZueUT+FPyycFvRaDSa
         6AQMinRMMOL4qs4YHYuawLtPwmn+6K3WaG2gReZ7AJY2Mgix5nv6CuNsir54EPtuWa
         qhaiPDITUMAQRQqHQXQM8tCDo6E444o7UbTmJoLf8ER20I1bQxZk+IqZekMM0vAU4i
         OJGlcZu9WPHbauSNgunLMZ+fnZhK1t8cG43zKnCPSvOQrN+sMKN6b73PvGxME2owv2
         Ajqi07dJqw2pg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] rtw88: add ieee80211:sta_rc_update ops
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220407095858.46807-2-pkshih@realtek.com>
References: <20220407095858.46807-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164977154420.6629.18071848283775875141.kvalo@kernel.org>
Date:   Tue, 12 Apr 2022 13:52:26 +0000 (UTC)
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
> Adding this allows us to get notification when bitrate configuration
> of the station changes. Update according parameters to firmware so
> the rate control algorithm can work properly.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

c1edc86472fc rtw88: add ieee80211:sta_rc_update ops
6723c0cde84f rtw88: fix incorrect frequency reported
f2217968ffda rtw88: Add update beacon flow for AP mode
f1c4dabfe68d rtw88: 8821c: Enable TX report for management frames
f5207c122102 rtw88: do PHY calibration while starting AP
ece31c93d4d6 rtw88: 8821c: fix debugfs rssi value

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220407095858.46807-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

