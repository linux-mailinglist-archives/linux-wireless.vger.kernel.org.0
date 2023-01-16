Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3266BFEC
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 14:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjAPNhg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 08:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjAPNhY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 08:37:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88020046
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 05:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C94F1B80E86
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 13:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18A8C433EF;
        Mon, 16 Jan 2023 13:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673876239;
        bh=qb7hkP6yPmmftgP6nX4eNwpSpkptFmXBLZgNTHd5Vxw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=hjSDz8oGf4v38/Mc6JWYbSXswHEt7kozLZDNIuuxf7cEw6hDfSP3cIz1E26chk8Fg
         HWti0EvS/KY5QGhHzqD4d0CeIris48Af0811O+mjswAKa0SVQDnM+2bwEP/UtTm4fr
         m2+8RLHAMoTI8+qcTOyt9IYzpElp/XRrSvJio2LZ2q6WEW2ICiFd4e2z28CTfRep/N
         3QDFrrlpo3kfV3XUYxov1Qt8oTk1BNlaUkhOLR0B4VFCFcmT4gRlyJ+aoGW5wgIQyp
         mIBRvXAlSYZsVVXo1dt12d5Ex9okZnRTau6XFg2/+S8jZGTXWJ+ByHkQ+h1hHxlywY
         v4WxQ8dcqI36Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: coex: Add version code for Wi-Fi
 firmware
 coexistence control
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230106120844.17441-2-pkshih@realtek.com>
References: <20230106120844.17441-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167387623706.32134.17008406743102231322.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 13:37:18 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> The newer Wi-Fi firmware are all changed to "Not to send H2C to
> mention firmware how many call flow step should firmware trace".
> The structure had removed the member, and define the steps number
> at newer version firmware.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

72f8b0461b4a wifi: rtw89: coex: Add version code for Wi-Fi firmware coexistence control
3d929f075d3b wifi: rtw89: coex: Change Wi-Fi Null data report to version separate
2626ccefe615 wifi: rtw89: coex: Change firmware steps report to version separate
2ce43be34850 wifi: rtw89: coex: refactor debug log of slot list
ae4e1adbb1be wifi: rtw89: coex: Packet traffic arbitration hardware owner monitor
447a3267cbed wifi: rtw89: coex: Change RTL8852B use v1 TDMA policy
fbc2caf19914 wifi: rtw89: coex: Change Wi-Fi role info related logic to version separate

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230106120844.17441-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

