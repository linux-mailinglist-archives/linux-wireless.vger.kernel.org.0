Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F0F797A72
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 19:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245362AbjIGRk3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 13:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245307AbjIGRkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 13:40:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C40CE7
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 10:39:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D85C433C7;
        Thu,  7 Sep 2023 05:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694066311;
        bh=2NblsHeIww0wlaVgsXnVSMug4mMIEm0LZM8MOjNyBHM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fc3ZnpGHo2QiKlrKyuZ4cpyJs2PJSUxO+ykKu8sX9+AHCmjkFZl0JQvoKFqf5oZUO
         I4tCzGY+LU3eRQibLnwo+EUhFzCd0sGNnqwJX+E8awIr5qNJO5m+fclYUwbHMU2qVI
         e/MfOvSR1eHUsouPlOQb19EWQESN04P+1tbg3h1WB1EL6YPTR/I0YlE1yq8o+ZdDF5
         YXbtlEwF1pc+o5iyIA24i4yRhqJSuzA58gnk1WOVUjDgtYIapxO6jORJQ+vN8U+PoF
         xuYgZK6slaOlQUvIuOr0EdtKqTtiyYLD8YFpTbPw3Lip0+19AUIPoJXZq5EMHMu4FO
         aSo9At3SCKzwg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/8] wifi: rtw89: fw: move polling function of firmware
 path ready to an individual function
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230901073956.54203-2-pkshih@realtek.com>
References: <20230901073956.54203-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169406630926.3946078.2995556575813207168.kvalo@kernel.org>
Date:   Thu,  7 Sep 2023 05:58:31 +0000 (UTC)
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

> To download firmware, we need to check path is ready. There are two kinds
> of path -- one is to download firmware header, and the other is to download
> firmware body.
> 
> Since the polling method is different from WiFi 7 chips, make it to be
> an individual function, and then we can reuse the download flow.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

80e706a85cb5 wifi: rtw89: fw: move polling function of firmware path ready to an individual function
ae4dc23d139c wifi: rtw89: fw: generalize download firmware flow by mac_gen pointers
68261ddbb2bc wifi: rtw89: fw: implement supported functions of download firmware for WiFi 7 chips
fa31a8c58d6e wifi: rtw89: fw: add checking type for variant type of firmware
a712eef681ed wifi: rtw89: fw: propagate an argument include_bb for BB MCU firmware
c6ea2a8391a5 wifi: rtw89: 8922a: add chip_ops::bb_preinit to enable BB before downloading firmware
38bae445a30b wifi: rtw89: fw: refine download flow to support variant firmware suits
b227c990de9a wifi: rtw89: 8922a: set memory heap address for secure firmware

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230901073956.54203-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

