Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCF976B815
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjHAOzY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjHAOzX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:55:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F68122
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:55:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F150615BF
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 14:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7BCC433C8;
        Tue,  1 Aug 2023 14:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901721;
        bh=O4f0lYsvt5aiySfmW63DlhgqBL9XXh8Ojln1RCx+o70=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BJ+8lJe7jdFcVu6LOrE/thDqm49NXgE++/CRpCF3WaHpmQqi8xg6rpT+HH3fuEjW2
         elt3Mw6Y4C8qKdpnYCDSXOrLwL6A+KHDO11SXBn6qZc/G8cPM26coiYLfPgdppK98H
         5ShByF6o0lRsBy/1Xq4QV8taEhwoJt/dUoVn2yUqoCkGkAyhsMwpHCRxay3W75blsu
         fPHzOXyZUvLGGDXCx2LxmYPXA5WpjV9i3fmUqzWUtaA62H1vkZ+JNR08cSRJ4gK+Pv
         Xr8fWH9GvdBRF6xbG34SPPcId2U5n0bx9+e2LUqsHpi0VsUlXSasBXA2SrFvBWXHgw
         4L8Md/DPe4nyA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] wifi: brcmfmac: Fix field-spanning write in
 brcmf_scan_params_v2_to_v1()
References: <20230729140500.27892-1-hdegoede@redhat.com>
        <169090065747.212423.9892152660352726427.kvalo@kernel.org>
        <57b9d6c8-557f-fbd7-0069-c84691a76ff4@redhat.com>
Date:   Tue, 01 Aug 2023 17:55:18 +0300
In-Reply-To: <57b9d6c8-557f-fbd7-0069-c84691a76ff4@redhat.com> (Hans de
        Goede's message of "Tue, 1 Aug 2023 16:47:36 +0200")
Message-ID: <873512yfqh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> Hi,
>
> On 8/1/23 16:37, Kalle Valo wrote:
>> Hans de Goede <hdegoede@redhat.com> wrote:
>> 
>>> Using brcmfmac with 6.5-rc3 on a brcmfmac43241b4-sdio triggers
>>> a backtrace caused by the following field-spanning error:
>>>
>>> memcpy: detected field-spanning write (size 120) of single field
>>>   "&params_le->channel_list[0]" at
>>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1072 (size 2)
>>>
>>> Fix this by replacing the channel_list[1] declaration at the end of
>>> the struct with a flexible array declaration.
>>>
>>> Most users of struct brcmf_scan_params_le calculate the size to alloc
>>> using the size of the non flex-array part of the struct + needed extra
>>> space, so they do not care about sizeof(struct brcmf_scan_params_le).
>>>
>>> brcmf_notify_escan_complete() however uses the struct on the stack,
>>> expecting there to be room for at least 1 entry in the channel-list
>>> to store the special -1 abort channel-id.
>>>
>>> To make this work use an anonymous union with a padding member
>>> added + the actual channel_list flexible array.
>>>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> 
>> Does the driver still work even if this warning is printed? I'm wondering
>> should I take this to wireless or wireless-next. Also a review from Broadcom
>> would be really good.
>
> It works fine, but it logs an oops / backtrace.

I'll add that info to the commit log.

> Note I did test the patch on a device where the warning was triggered
> and the warning is gone and wifi association still works.
>
> So there is a slight preference to get this as a fix into 6.5 from my side.

I'll queue this wireless then. But I really would like to Broadcom take
a look at this in case we are missing something.

>> What about a Fixes tag? 
>
> This is caused by the new field-spanning wtire checks enabled
> recently, so there is not really a brcmfmac commit to point to as the
> culprit.

Ok.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
