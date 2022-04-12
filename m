Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425704FD82B
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 12:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357455AbiDLJ4H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356182AbiDLHek (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 03:34:40 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FAB265C
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 00:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EXRqyyFbECu6GEBfrNfZPIBbjds5Ej7Fq838pGzWpHc=; b=dcFjm0Mc2ZG7YRfXxLPx2nio/n
        E0LWy8kDXNcjn32L7FeEEs3AF9gw6L5ZgdsN7jMk/NQWrIkltePH0/ri8FbR30Ef1yA2h0JZS+uTF
        HCs5zJSXrPAe4CkRJbtJ6NaLA9ccA+VNkUov/IgZKSjsBWMiaJlms7+Qorr6hNYKUaas=;
Received: from p57a6f1f9.dip0.t-ipconnect.de ([87.166.241.249] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1neAe8-0007N0-LC; Tue, 12 Apr 2022 09:09:04 +0200
Message-ID: <35ae1b48-e9e6-3c05-1abe-7d11dfb03797@nbd.name>
Date:   Tue, 12 Apr 2022 09:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] mt76: mt7915: add device name in eeprom request
Content-Language: en-US
To:     Daniel Danzberger <daniel@dd-wrt.com>,
        linux-wireless@vger.kernel.org
References: <20220411142309.886165-1-daniel@dd-wrt.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <20220411142309.886165-1-daniel@dd-wrt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 11.04.22 16:23, Daniel Danzberger wrote:
> When an eerpom is requested from userspace via request_firmware, the
> device name is appened to the firmware name so the userspace can load
> different eeproms/caldata for different devices.
> 
> Signed-off-by: Daniel Danzberger <daniel@dd-wrt.com>
> ---
>   mt7915/eeprom.c |  7 ++++++-
>   mt7915/mt7915.h | 16 ++++++++--------
>   2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/mt7915/eeprom.c b/mt7915/eeprom.c
> index 4b1a9811..99c1d650 100644
> --- a/mt7915/eeprom.c
> +++ b/mt7915/eeprom.c
> @@ -76,8 +76,13 @@ mt7915_eeprom_load_default(struct mt7915_dev *dev)
>   	u8 *eeprom = dev->mt76.eeprom.data;
>   	const struct firmware *fw = NULL;
>   	int ret;
> +	char eeprom_name[100];
>   
> -	ret = request_firmware(&fw, mt7915_eeprom_name(dev), dev->mt76.dev);
> +	scnprintf(eeprom_name, sizeof(eeprom_name),
> +		"mediatek/%s-%s.bin",
> +		mt7915_eeprom_name(dev), dev_name(dev->mt76.dev));
In order to not break compatibility, please keep the existing code that 
loads eeprom files based on the chip name.
For the device name based eeprom file, you don't need to include the 
chip id. Just make it mt76-eeprom-<name>.bin or something like that.
I also think you don't need the mediatek/ prefix here, since that's 
usually used for files shipped with linux-firmware.git

- Felix
