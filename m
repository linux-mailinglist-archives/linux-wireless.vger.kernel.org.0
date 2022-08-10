Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D64058E6CF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Aug 2022 07:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiHJFtc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Aug 2022 01:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHJFtb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Aug 2022 01:49:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04231642E3
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 22:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9C22B81A6E
        for <linux-wireless@vger.kernel.org>; Wed, 10 Aug 2022 05:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5A1C433D6;
        Wed, 10 Aug 2022 05:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660110568;
        bh=5k1poUOa8EOe1FlaFpDcn16P1jN/obFGpMicqI0/d/M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qJenpb9h3fwz7XON0z8zvu9yalqa8e+daJLEQcMIjC9yh2fX1lfibEc6I+tvZ2DUA
         0VfEzH9UWIcYIWYfluM5oFPAszTGX5k18TvtpNA97TQn35ZzsaY7hJC/MnRSVfYSQ3
         tDkJBV+TtQ2W7eTKSCrgcVeMcZ0yYyJf86mRXqZ+BcO4gwmmCZkjy7ISPZudxbtRHJ
         wzOObgUulx407rxjmKDa/8NM3PPZs7I/Kr6i2wtEy7J3ORzfB/iRIhbTEGcfDrwAVF
         BohgTzZvSc2rXmaMAE3+m4fBqd6XH+acMH1lgmZhHNTobyEzJyya4ocyAfN8M37AUl
         tIElUvTBRDW/w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] wifi: rtw88: add mutex when set SAR
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220809084107.38137-2-pkshih@realtek.com>
References: <20220809084107.38137-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166011056548.24475.2990196002466106549.kvalo@kernel.org>
Date:   Wed, 10 Aug 2022 05:49:27 +0000 (UTC)
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

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Applying SAR will access hal data, it should hold rtwdev::mutex
> to avoid hal data changed during setting flow.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

9a72db413385 wifi: rtw88: add mutex when set SAR
685b474b7d8a wifi: rtw88: add mutex when set regulatory and get Tx power table
341dd1f7de4c wifi: rtw88: add the update channel flow to support setting by parameters
68c539144397 wifi: rtw88: fix WARNING:rtw_get_tx_power_params() during HW scan
d08458b57a50 wifi: rtw88: add flushing queue before HW scan
6bf3a083407b wifi: rtw88: add flag check before enter or leave IPS
7dad3e39fde1 wifi: rtw88: prohibit enter IPS during HW scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220809084107.38137-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

