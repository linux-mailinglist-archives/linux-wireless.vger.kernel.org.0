Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0532F7A4FFB
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Sep 2023 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjIRQ5q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Sep 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjIRQ5i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Sep 2023 12:57:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155983
        for <linux-wireless@vger.kernel.org>; Mon, 18 Sep 2023 09:57:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88827C32784;
        Mon, 18 Sep 2023 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695047350;
        bh=PVDCYh7IbDu0+S30lfHpcZ3DfgARe/jsmNOOlcSlFbc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Gn3sLiuezcPNPRxIPvLkd3Ej8sxFaFAhtiVmbc7NFrIhnh6YAhPalecLlmUQ+lLo1
         vYDmyWTdNK9f18Q7nQMiwyG565cjhbCcFz85GyQKNN+zX7gj0PwycSSCBtr5N1fxVm
         Du611+g6Q5fNBhmyE6mnHfDoQ7ALJEAYn5uAxckugGqs1UoKLD8IzgAj2fLyZn/Xig
         HAyMc9NgSzF+IMJOQDHVKUPqycE/wcEKHHA+TLNM0ka76ljIP+DLfhf9MPyjP3voNM
         t+V8K8a67vlqImzCm8fDvsAAIL4x/Pg9Ut0ivdHptiEENlXKBaDR+DFOjQVdxsJunv
         31uJ0TuNPm/Tg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: 52c: rfk: refine MCC channel info
 notification
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230908031145.20931-2-pkshih@realtek.com>
References: <20230908031145.20931-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169504734750.740666.1826649889995290528.kvalo@kernel.org>
Date:   Mon, 18 Sep 2023 14:29:09 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> RF calibration will notify FW to backup the calibration result after it
> is done on a channel. For MCC (multi-channel concurrency) flow, when we
> at RTW89_ENTITY_MODE_MCC_PREPARE mode, RF calibration should execute on
> second channel of MCC, i.e. RTW89_SUB_ENTITY_1, and then, notify FW to
> backup the result for the second one.
> 
> Originally, the RF calibration flow only fit single channel case. We are
> planning to support MCC on RTL8852C, so we refine its RF calibration flow
> to fit MCC case.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

74b45618f534 wifi: rtw89: 52c: rfk: refine MCC channel info notification
c83ff9a3a2ca wifi: rtw89: rfk: disable driver tracking during MCC
6e9d6f8254ee wifi: rtw89: 52c: rfk: disable DPK during MCC
31e415e3d08a wifi: rtw89: mcc: update role bitmap when changed
5f69aabab126 wifi: rtw89: mcc: track beacon offset and update when needed
15fe9b731953 wifi: rtw89: mcc: deal with P2P PS change
9ecb40ef5281 wifi: rtw89: mcc: deal with BT slot change
97211e026313 wifi: rtw89: mcc: deal with beacon NoA if GO exists

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230908031145.20931-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

