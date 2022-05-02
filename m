Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04699516AF3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 08:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383507AbiEBGtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 02:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343598AbiEBGtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 02:49:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4932D2CE1D
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 23:45:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9219C60C7F
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 06:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AE6C385AC;
        Mon,  2 May 2022 06:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651473954;
        bh=QL5mKu8NQSQYC2o1qLuJuSMa2wrvjTbvRYPInb79afw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aVoTjSvqeC14pydjY9yUpTiG8AaozH6XUwfg1argCrlx2pUn4fQehEmTUdDBVqNkq
         yDhFmrBmufwAqp1nl21mR1432mALnWqjckz5NML+jzyEHKyKN6XxQWBck7/wK3G8Bn
         7GOfQhUJe54hxKA7vbQhZB3omCtqVui02rrYh1A84r8HYbHu+wE17DJr+tb62gW4/3
         GEyGXgaJojtKuNAbE2Rd6jq7pSbF7kqV+owNzoMBd8I1VDwwA9BCKTovsF9d/XbONy
         CKfDylu9KwCiGKSuQDrrWTQpEPWxjkw/ne5yU1nY6N2cJX5EHhxFRg6KJ7UwrcomMn
         hQvYUFH13g0mA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/16] rtw89: 8852c: rfk: add RFK tables
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220429071809.32104-2-pkshih@realtek.com>
References: <20220429071809.32104-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165147395131.22580.17272377169555802599.kvalo@kernel.org>
Date:   Mon,  2 May 2022 06:45:53 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> These tables are used by RFK (RF calibration) to set parameters. These
> parameters can trigger certain calibration, or configure/reset settings
> before and after RF calibrations.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

16 patches is too much, I only reviewed patches 1-8. Please split this
patchset into two.

16 patches set to Changes Requested.

12831552 [v2,01/16] rtw89: 8852c: rfk: add RFK tables
12831545 [v2,02/16] rtw89: 8852c: rfk: add DACK
12831547 [v2,03/16] rtw89: 8852c: rfk: add LCK
12831551 [v2,04/16] rtw89: 8852c: rfk: add TSSI
12831546 [v2,05/16] rtw89: 8852c: rfk: add RCK
12831548 [v2,06/16] rtw89: 8852c: rfk: add RX DCK
12831556 [v2,07/16] rtw89: 8852c: rfk: add IQK
12831560 [v2,08/16] rtw89: 8852c: rfk: add DPK
12831549 [v2,09/16] rtw89: 8852c: rfk: get calibrated channels to notify firmware
12831550 [v2,10/16] rtw89: 8852c: add chip_ops::bb_ctrl_btc_preagc
12831555 [v2,11/16] rtw89: 8852c: add basic and remaining chip_info
12831553 [v2,12/16] rtw89: ps: fine tune polling interval while changing low power mode
12831554 [v2,13/16] rtw89: correct AID settings of beamformee
12831557 [v2,14/16] rtw89: 8852c: correct register definitions used by 8852c
12831559 [v2,15/16] rtw89: 8852c: fix warning of FIELD_PREP() mask type
12831558 [v2,16/16] rtw89: 8852c: add 8852ce to Makefile and Kconfig

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220429071809.32104-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

