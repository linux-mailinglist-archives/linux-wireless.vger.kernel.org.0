Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABA4583B8D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbiG1Jxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiG1Jxo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:53:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A5E15A2E
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0CE061070
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80226C433D7;
        Thu, 28 Jul 2022 09:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659002023;
        bh=ptUJBrqHeccfmhviMwnCZdNFtmr4681k56sIlY+1o0k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eG+7L13GtvsHlZS9YA4WiKVKni6CF31En4vWhQ4CBc5qy/kyV27CTHl94jmpJ8ujX
         CzULc1mI9DUhmaME7v73S72rHcUVXygxlYbB2VGagtyaaKGhQJ+iYiEAnTPQluR9et
         W8TcuD+NYHZVwPxTesU+xy4VrVMbRru4QGm4aJl3xFsbLiWwTLDEAKpj1X6yj5u55T
         CpndVaP3LoQY4cIWTSaLrVIm3CI479PLSb21RDJKmGWKg6VAU1h89+wj5TEexwnFbz
         XemVfVkaYbMFTrfPaAmVYU9xd1O54/6QQLwLOjs9UySI6itteb55A3fP20SYPsH2hL
         H9O+daNysdKhA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend Van Spriel <aspriel@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH 2/2] brcmfmac: Replace default (not configured) MAC with a random MAC
References: <20220708133712.102179-1-hdegoede@redhat.com>
        <20220708133712.102179-2-hdegoede@redhat.com>
        <9bf3dc09-73df-8914-aa13-68ed9d48f350@gmail.com>
Date:   Thu, 28 Jul 2022 12:53:38 +0300
In-Reply-To: <9bf3dc09-73df-8914-aa13-68ed9d48f350@gmail.com> (Arend Van
        Spriel's message of "Fri, 8 Jul 2022 20:27:57 +0200")
Message-ID: <87bkt9o95p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <aspriel@gmail.com> writes:

> On 7/8/2022 3:37 PM, Hans de Goede wrote:
>
>> On some boards there is no eeprom to hold the nvram, in this case instead
>> a board specific nvram is loaded from /lib/firmware. On most boards the
>> macaddr=... setting in the /lib/firmware nvram file is ignored because
>> the wifi/bt chip has a unique MAC programmed into the chip itself.
>>
>> But in some cases the actual MAC from the /lib/firmware nvram file gets
>> used, leading to MAC conflicts.
>>
>> The MAC addresses in the troublesome nvram files seem to all come from
>> the same nvram file template, so we can detect this by checking for
>> the template nvram file MAC.
>>
>> Detect that the default MAC address is being used and replace it
>> with a random MAC address to avoid MAC address conflicts.
>>
>> Note that udev will detect this is a random MAC based on
>> /sys/class/net/wlan0/addr_assign_type and then replace this with
>> a MAC based on hashing the netdev-name + the machine-id. So that
>> the MAC address is both guaranteed to be unique per machine while
>> it is still the same/persistent at each boot (assuming the
>> default Link.MACAddressPolicy=persistent udev setting).
>
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

This is nitpicking but as you are the maintainer could you use Acked-by
instead? That way I can immediately see in my patchwork script that a
maintainer has acked these and I can take them. Just trying to optimise
my workflow :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
