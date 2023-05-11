Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0CC6FF095
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 13:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbjEKLek (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 07:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbjEKLeh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 07:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D8A5FF
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 04:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7A556192E
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 11:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B830C433EF;
        Thu, 11 May 2023 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683804874;
        bh=RHUC5bzmCWO2IF7rnOwQe0S2gYNdkMFXvVTnDOMJ93s=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ILiMvN2wCiV1YRzU/yXnTh6TGhTFCEQE3OZ/VXuYIBtNnHyI97o+2k6ruaQR4Av4D
         IHSncbG/GHHm4H43ze5qm1/kFF/M6VFsJVyCQPl1BvrckV1byfap/JeZ8U+LjTBiu5
         9zI0mpWQpQTpdWI8hhPvg46LRKKv8QSZdNVuR3q2tJXE0UaJT+SlOmrBoPlpQAKDKW
         dh4pSs1lba2+lntsAddMrA3wfH7k667VRjoxOUtYTYkwYOkdNT5n0w00WV914/Yjmt
         Bo3FpGeYybNxhyxrq3ivsCXymuLJtIM6LQiyyptWciHhkXdlmiXL6OqoVmFU30QOXM
         k81tX1CfDBOTQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Martin Kaistra <martin.kaistra@linutronix.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192cu: Remove driver
References: <20230428182933.19157-1-Larry.Finger@lwfinger.net>
        <cab66a9d-9a66-7cd1-408b-91e8cd9d8a9c@linutronix.de>
        <53260a3b-9256-07a2-1d66-553e865362b7@lwfinger.net>
Date:   Thu, 11 May 2023 14:34:27 +0300
In-Reply-To: <53260a3b-9256-07a2-1d66-553e865362b7@lwfinger.net> (Larry
        Finger's message of "Sat, 29 Apr 2023 12:03:14 -0500")
Message-ID: <873543nlto.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 4/29/23 04:42, Martin Kaistra wrote:
>> Am 28.04.23 um 20:29 schrieb Larry Finger:
>>> The functionality of these devices has been replaced by the rtl8xxxu
>>> driver, thus the version under rtlwifi can be removed.
>>>
>>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>>
>> Things to keep in mind:
>> - rtlwifi offers AP mode support for rtl8192cu devices, rtl8xxxu
>> doesn't (yet) do that. Should be relatively easy to add that on top
>> of [1], though.
>> - The rtl8192cu devices are currently hidden behind
>> CONFIG_RTL8XXXU_UNTESTED in the rtl8xxxu driver with the comment
>> "Still supported by rtlwifi".
>>
>>
>> [1]
>> https://lore.kernel.org/linux-wireless/20230428150833.218605-1-martin.kaistra@linutronix.de/
>
> Kalle,
>
> I failed to consider this point. Please drop my patch. Instead, I will
> submit one to remove that configuration parameter that says the
> rtl8192cu is "untested".

The original reason why we added CONFIG_RTL8XXXU_UNTESTED back in the
day was so that we would not have two drivers supporting the same
hardware. Though I don't know how much the kconfig helped with that but
at least the conflicts were somehow documented.

Now that rtl8xxxu has matured and gained more features, I would really
like the idea of removing rtl8192cu driver. Of course we should make
sure that we are not accidentally removing any devices support, for
example I was not able to find this device in rtl8xxxu:

	{RTL_USB_DEVICE(USB_VENDOR_ID_REALTEK, 0x817c, rtl92cu_hal_cfg)},

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
