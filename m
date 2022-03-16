Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472CB4DB4E4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 16:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiCPPbK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 11:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbiCPPbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 11:31:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931B56B08C
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 08:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D647B81B41
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 15:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029DBC340E9;
        Wed, 16 Mar 2022 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647444592;
        bh=1PpOTbf/zRAfxMTRAlj2cYhN/D7OwLjK0h0EhGNrWqI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BTi+vzlshyksZgvhOHOJA7K4S/EWDw25ZxYUBsBBNbSAhamSS7GHTgYDOdEOT/q4I
         FX8WPV7OyEyCnG+b+KdLoUcHR2WxrmfckJTLqZgvdNM6i0XT5I3vsdaqMj0MMa2H9Z
         cHFOwFnLu9hz4D+GrlNC7bJaL/9Uir2/GNvGEnJ6/i071x7wmXUuFfO97PoK49eYDU
         uwjY2I3M1+DAV4kSuGNomvbA8EpUfVs8BuL87oT6yX+9HnpmpfEu/gVfB/pr1ewcR2
         zJKhiGe3C67O2sVVDQKsBxOMTgoY6baLCMFJkkn0+0D9T5dAEFJd3HtXD5KAisnO3t
         BjiqnAYOPm29A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8192cu: Add On Networks N150
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <DBAPR04MB7366E8014ECA839E1F5CCE29920E9@DBAPR04MB7366.eurprd04.prod.outlook.com>
References: <DBAPR04MB7366E8014ECA839E1F5CCE29920E9@DBAPR04MB7366.eurprd04.prod.outlook.com>
To:     Jonathan Teh <jonathan.teh@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>,
        Jonathan Teh <jonathan.teh@outlook.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164744458977.16413.15022508030260261875.kvalo@kernel.org>
Date:   Wed, 16 Mar 2022 15:29:51 +0000 (UTC)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jonathan Teh <jonathan.teh@outlook.com> wrote:

> This is an RTL8188CUS device, identifies as model N150MA-199WWS.
> 
> Signed-off-by: Jonathan Teh <jonathan.teh@outlook.com>
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-next.git, thanks.

ceb7482f2d39 rtlwifi: rtl8192cu: Add On Networks N150

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/DBAPR04MB7366E8014ECA839E1F5CCE29920E9@DBAPR04MB7366.eurprd04.prod.outlook.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

