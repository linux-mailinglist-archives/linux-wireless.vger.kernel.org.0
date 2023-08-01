Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AC276B7E5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjHAOoX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjHAOoU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:44:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0685122
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:44:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35EE0615CD
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 14:44:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45240C433C9;
        Tue,  1 Aug 2023 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901057;
        bh=a/hdlpvxbDowlwhXf9gBTu4C/wIfe4YqQORIcYYIuD4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CiuB74E9a08/BDpLloNyvWwW+VLIxk/PMU6GC9xcv4sNgfx9QdO5YkZiW21ENTyzu
         sW8oLVGqocw4EvtFn3BC5xJXy4zm+jSGMwrfKhEVBH5CxdnQSwsM0t0HSnJ/7udZ1J
         iFh6U87VOIfkyjMkmDnPXK6WsJLJ9QaSc7yKRJiefmN4GIE67ctvj52h7lsbyCWR3G
         XzfTA2nxbbLdKufy+AylfeT8D6zWFNw/3xEZEN7TBy/Q4zv05SyG8xgbFET4pTDGlA
         TPQ08t/UPhh9thxYyySVSMBu+2G907iKDLeymssBQreo0taJxcbVongrjPOCmWpTOP
         Rj37+UNlaK98Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: Fix loading of compressed firmware
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230724183927.28553-1-Larry.Finger@lwfinger.net>
References: <20230724183927.28553-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>, Takashi Iwai <tiwai@suse.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169090105450.212423.7947684119400095506.kvalo@kernel.org>
Date:   Tue,  1 Aug 2023 14:44:16 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> wrote:

> When using compressed firmware, the early firmware load feature will fail.
> In most cases, the only downside is that if a device has more than one
> firmware version available, only the last one listed will be loaded.
> In at least two cases, there is no firmware loaded, and the device fails
> initialization. See https://github.com/lwfinger/rtw89/issues/259 and
> https://bugzilla.opensuse.org/show_bug.cgi?id=1212808 for examples of
> the failure.
>   
> When firmware_class.dyndbg=+p" added to the kernel boot parameters, the
> following is found:
> 
> finger@localhost:~/rtw89>sudo dmesg -t | grep rtw89
> firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw-1.bin fw_priv=00000000638862fb
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/5.14.21-150500.53-default/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/5.14.21-150500.53-default/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: Direct firmware load for rtw89/rtw8852b_fw-1.bin failed with error -2
> firmware_class: __free_fw_priv: fw-rtw89/rtw8852b_fw-1.bin fw_priv=00000000638862fb data=00000000307c30c7 size=0
> firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw.bin fw_priv=00000000638862fb
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: Direct firmware load for rtw89/rtw8852b_fw.bin failed with error -2
> firmware_class: __free_fw_priv: fw-rtw89/rtw8852b_fw.bin fw_priv=00000000638862fb data=00000000307c30c7 size=0
> rtw89_8852be 0000:02:00.0: failed to early request firmware: -2
> firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw.bin fw_priv=00000000638862fb
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin.xz failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw.bin.xz failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/5.14.21-150500.53-default/rtw89/rtw8852b_fw.bin.xz failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: Loading firmware from /lib/firmware/rtw89/rtw8852b_fw.bin.xz
> rtw89_8852be 0000:02:00.0: f/w decompressing rtw89/rtw8852b_fw.bin
> firmware_class: fw_set_page_data: fw-rtw89/rtw8852b_fw.bin fw_priv=00000000638862fb data=000000004ed6c2f7 size=1035232
> rtw89_8852be 0000:02:00.0: Firmware version 0.27.32.1, cmd version 0, type 1
> rtw89_8852be 0000:02:00.0: Firmware version 0.27.32.1, cmd version 0, type 3
> 
> The key is that firmware version 0.27.32.1 is loaded.
> 
> With this patch, the following is obtained:
> 
> firmware_class: __free_fw_priv: fw-rtw89/rtw8852b_fw.bin fw_priv=000000000849addc data=00000000fd3cabe2 size=1035232
> firmware_class: fw_name_devm_release: fw_name-rtw89/rtw8852b_fw.bin devm-000000002d8c3343 released
> firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw-1.bin fw_priv=000000009e1a6364
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.xz failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/updates/rtw89/rtw8852b_fw-1.bin.xz failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: loading /lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.xz failed for no such file or directory.
> rtw89_8852be 0000:02:00.0: Loading firmware from /lib/firmware/rtw89/rtw8852b_fw-1.bin.xz
> rtw89_8852be 0000:02:00.0: f/w decompressing rtw89/rtw8852b_fw-1.bin
> firmware_class: fw_set_page_data: fw-rtw89/rtw8852b_fw-1.bin fw_priv=000000009e1a6364 data=00000000fd3cabe2 size=1184992
> rtw89_8852be 0000:02:00.0: Loaded FW: rtw89/rtw8852b_fw-1.bin, sha256: 8539efc75f513f4585cf0cd6e79e6507da47fce87225f2d0de391a03aefe9ac8
> rtw89_8852be 0000:02:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
> rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.1, cmd version 0, type 5
> rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.1, cmd version 0, type 3
> 
> Now, version 0.29.29.1 is loaded.
> 
> Fixes: ffde7f3476a6 ("wifi: rtw89: add firmware format version to backward compatible with older drivers")
> Cc: Ping-Ke Shih <pkshih@realtek.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>

Patch applied to wireless-next.git, thanks.

942999c48cb3 wifi: rtw89: Fix loading of compressed firmware

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230724183927.28553-1-Larry.Finger@lwfinger.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

