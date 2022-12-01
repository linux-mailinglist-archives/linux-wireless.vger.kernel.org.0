Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9AE63EF35
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 12:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiLALRX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 06:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLALQw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 06:16:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9260DE
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 03:12:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14A08B81E8A
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 11:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290C4C433C1;
        Thu,  1 Dec 2022 11:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669893153;
        bh=K9UXaa+s26pMOuyh3Qro4HpVP3V7/PSOqif90/siANw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Wpf6sxydLStFB6GzVgl/MLvk+zHfoYBW3DIxuMqhZOvtpRos/XS6zQeHNeu5Qty8U
         qYdaFqPqFGbzf2/g2hqvp+8Sk5uAU7FoJqjtfLqi0R60pMt0wQH+8PUQD9YsuQmZ+f
         RMfDCgOxRwoXrUkhdetxw6izfHL+Zv/cA6fvjLbELdNoxgKtf0lhfIMUdQwCRQa2i6
         NYy1z70L3veaOF/2x5SHEYEGMSOAui6SB3//ZBOkd1PiiEyQc8hkR67HbxzU39drKb
         5wdXPlXGSS6VRdY/c8RXvK0Be/2RtdKVZj04zSyayorx2iwqkZkVsnFAe9G8Paf5Gy
         q65/gUCUN0IkQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH V2 0/7] brcmfmac: support devices from multiple vendors
References: <20221129135446.151065-1-arend.vanspriel@broadcom.com>
        <9dfeb220-b81b-83de-db91-9bb57014309f@broadcom.com>
Date:   Thu, 01 Dec 2022 13:12:29 +0200
In-Reply-To: <9dfeb220-b81b-83de-db91-9bb57014309f@broadcom.com> (Arend van
        Spriel's message of "Tue, 29 Nov 2022 14:58:12 +0100")
Message-ID: <87fsdz4btu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 11/29/2022 2:54 PM, Arend van Spriel wrote:
>> Took my sweet time coming with this follow-up series, but here
>> it is. Hopefully, sending patches is working for me now.
>>
>> The bcm43xx family of wifi chipsets found its way to different
>> groups inside and outside Broadcom. For the fullmac devices this
>> means that in those difference groups firmware is being developed
>> and the firmware api is bound to diverge. This series introduces
>> a design change to accomodate supporting multiple firmware api's.
>> The vender-specific support can be compiled in brcmfmac or
>> built as a separate module. Currently the vendor-specific support
>> does not have any real effect. At the momemt looking into SAE support
>> which appear to be different for Cypress devices so that might be a
>> first use-case.
>>
>> The patches apply to the main branch of the wireless-next repository.
>
> Just realized I forgot the 'wifi:' prefix. Hopefully you can forgive
> me this time? If not, I can resend.

Yeah, I can add that. When we switched to using "wifi:" I was mentally
(and in my tools) prepared to adding those the next couple of years :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
