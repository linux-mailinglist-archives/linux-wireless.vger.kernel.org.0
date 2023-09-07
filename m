Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAAE79747B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjIGPi5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 11:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjIGPW5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 11:22:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7E8199A
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 08:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6129C433C9;
        Thu,  7 Sep 2023 05:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694066162;
        bh=DVymOMuNgk0G/TAzChbZfMrI8zsbqJjpGKm/pdQcne8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OeBGaDpGBC2c5FVZGmhvsHG8UcJ7wOVOQ7UKzqecIpwHtGld1XDG1U8OaTTR3HM/S
         05RHgbE/Q0ubE/Njx1unyU2hp0HR0qcJnzAdiZ+6VPNIgmG3AnSU1ERaIUiaTmO8nq
         41/od47k0tJCQ8Syuh4OpKGTHHLex4IozEEmb0GPMn63xEvvA4RCGPv/98fIHloJ34
         tpVcVtOLib+6qe3CNFQurSiOpM5VEf0G8gTvDC0u0bA78Ro5Bs4KjPZCAvZg20ERTF
         0ZKdywUO1wMunt1DZpCsCbG6AAprYcqLtg8HLI7RepATPtcsU5ewmDLSh5FSVrkLsi
         +4HEBH1LQulDQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] wifi: rtw89: mcc: initialize start flow
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230831053133.24015-2-pkshih@realtek.com>
References: <20230831053133.24015-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169406615977.3946078.1397128890019703880.kvalo@kernel.org>
Date:   Thu,  7 Sep 2023 05:56:01 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> We prepare to support TDMA-based MCC (multi-channel concurrency)
> which allows two kinds of modes below.
> * P2P GO + normal STA
> * P2P GC + normal STA
> 
> Each mode has two vif and two chanctx. Then, each vif binds one
> separate chanctx and becomes one MCC role. We name the two MCC
> roles as follows.
> * MCC role - reference (ref)
> 	We calculate the baseline of our TDMA things accodring
> 	to its info, e.g. TBTT. In normal case, it will be put
> 	at the first slot of TDMA.
> * MCC role - auxiliary (aux)
> 
> MCC state machine will be running in FW eventually, but before that,
> we have to fill and calculate things that are needed by FW. We fill
> the information of MCC role according to its vif and its chanctx.
> Then, we calculate the start time for MCC.
> 
> Note that the parameters used in the calculation now is assigned by
> default rules. The precise parameters for better MCC behavior will be
> derived in the following.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

b09df09b55fb wifi: rtw89: mcc: initialize start flow
4dc25ef19163 wifi: rtw89: mcc: fill fundamental configurations
7d1704640aad wifi: rtw89: mcc: consider and determine BT duration
17aa2c332689 wifi: rtw89: mcc: decide pattern and calculate parameters
980d4215f94e wifi: rtw89: fix typo of rtw89_fw_h2c_mcc_macid_bitmap()
6fa25e768df4 wifi: rtw89: mcc: trigger FW to start/stop MCC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230831053133.24015-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

