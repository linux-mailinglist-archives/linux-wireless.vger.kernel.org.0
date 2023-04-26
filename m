Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4EF6EED97
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 07:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjDZFl4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 01:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDZFly (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 01:41:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197F1FC8
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 22:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 292C2632DB
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 05:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B83C433EF;
        Wed, 26 Apr 2023 05:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682487712;
        bh=G15HNREUnfueflAxmcbBwIH65cTQ6m8MubRMWjECbxE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=i37hKNIsvVkmGDIvPwpuRCYxCNgrYOZVOxkqkk7a2dT3LZjbb8QEkUgtNJNY6dTpG
         LSpay+QW301eWXj3QotCM1ZqeDQfjRDcPbKNUTHGeg0TnmoRck4uQIt8SmwWlZhQ3c
         /H+qxcEnPTyeF835xkLPzQg50ZrLTLbJ97TYX4XAJ/MNuvPmGyCSll/r7yO4PKGNQM
         0jkB2WD4viDdDD+Pe2UhCUsLCxwwcp2FCx7qtUWfyD7NtIK51TACfAIVZncWy9hhJL
         RNy1DfD/xSznxW2qGXC0cCknGlZM/mpPoeTcAmegW/xWaCtsW3d5DUb5+PBUPrdQGT
         3IJ+4DjIrCaIA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "Larry.Finger\@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: rtw89: 8852b: adjust quota to avoid SER L1 caused by access null page
References: <20230426034737.24870-1-pkshih@realtek.com>
        <87r0s7teik.fsf@kernel.org>
        <b1c5e4f89ba843cd958f569547caa8e5@realtek.com>
Date:   Wed, 26 Apr 2023 08:41:47 +0300
In-Reply-To: <b1c5e4f89ba843cd958f569547caa8e5@realtek.com> (Ping-Ke Shih's
        message of "Wed, 26 Apr 2023 05:16:41 +0000")
Message-ID: <87mt2vtd2c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Wednesday, April 26, 2023 1:10 PM
>> To: Ping-Ke Shih <pkshih@realtek.com>
>> Cc: stable@vger.kernel.org; Larry.Finger@lwfinger.net;
>> linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH v2] wifi: rtw89: 8852b: adjust quota to avoid
>> SER L1 caused by access null page
>> 
>> Ping-Ke Shih <pkshih@realtek.com> writes:
>> 
>> > Though SER can recover this case, traffic can get stuck for a while. Fix it
>> > by adjusting page quota to avoid hardware access null page of CMAC/DMAC.
>> >
>> > Fixes: a1cb097168fa ("wifi: rtw89: 8852b: configure DLE mem")
>> > Fixes: 3e870b481733 ("wifi: rtw89: 8852b: add HFC quota arrays")
>> > Cc: stable@vger.kernel.org
>> > Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
>> > Link: https://github.com/lwfinger/rtw89/issues/226#issuecomment-1520776761
>> > Link: https://github.com/lwfinger/rtw89/issues/240
>> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>> > ---
>> > v2: add Fixes, Cc and Tested-by tags suggested by Larry.
>> 
>> Should this go to wireless tree for v6.4?
>
> Yes, please take it to v6.4. People can get stable connection with this fix.

Ok, I'll then take this to wireless.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
