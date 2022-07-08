Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FAF56BFB3
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Jul 2022 20:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239614AbiGHS24 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Jul 2022 14:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiGHS2j (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Jul 2022 14:28:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BA987346
        for <linux-wireless@vger.kernel.org>; Fri,  8 Jul 2022 11:28:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so2746905pjr.4
        for <linux-wireless@vger.kernel.org>; Fri, 08 Jul 2022 11:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EH9nKI/pDY3CrfQLjiujlfJ+k4538OktHnZI6jkiFj4=;
        b=OAZabcTfsOiCuKg5z7fcWjvHr9JZnWMpJnhyKEzNqbY6WH27UJKKoV5e/nz7K0CKWJ
         6MqMmWzNdWv23PWk6t/iuPgXGyOJ+blgdltXoYxpNX6zaX6HBO8EOetjT+0vjO97mDm7
         +Sm/Ck064s1nen69vPE0ndRAo4wnbM86BOPaDpaAKhqtJzFpov6S9gwwEF/xMJeum6Rs
         2zbJ9kU7uxO3zgyHdSC8vbPBWtasVBDfTTypEdxHg6Pwcnx9MQf+6y/rxvR1MNS+0R5H
         oPcUXFh0kXOuy8FwuAwQ+E5XTD49jMImA/3Xz+1dxkh7aBiuhVrMyrNY7lvdFDw/rZo4
         vZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EH9nKI/pDY3CrfQLjiujlfJ+k4538OktHnZI6jkiFj4=;
        b=pq240iAbKDLja7wsKD4fzikoxxJlqzAR/D5+JJn3GH1xSeT3n30cfB4rtgeQmsZtXy
         AVHFufi3riK7pc2jV9+I+3s9fQ5h2XCCCLXikKENOBgkrukv3ynXnIdQkHCN8xoZxd2e
         Y4MosGFFzY7ttUV/+LrCMXwEXbaXzY41tBvf+CFPl2WRCJ2WKYgsOn0g1zF0AnPtPCfo
         iC8vkHb8COT6JjwhR8E00t2YWIBykga8qLyOGH1nowhCGz33wV4XOidg+7B2oU0P4649
         EA5S9NEjwx+6Mie4JstDeLGuiILLYmhPDoeYQj7cHgg/euNcIWvuwyP1WnhZ563BxMm4
         8kzA==
X-Gm-Message-State: AJIora/oSHfMUTRF6vPYloPhwBRwCWWxSV8QdI9XSUyFnHwaURJa6t+M
        UkoNXppOIrjxAoH/wN0xxOs=
X-Google-Smtp-Source: AGRyM1sEoWBaLQtTa10JJI0cFWQK9W82ISiM3ow7QXDBQnP0NuzmYpz2H6qfssIIpJ/9eOPO8Ff6Uw==
X-Received: by 2002:a17:902:b60d:b0:16b:e832:7295 with SMTP id b13-20020a170902b60d00b0016be8327295mr5090945pls.144.1657304882362;
        Fri, 08 Jul 2022 11:28:02 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id r14-20020a17090a454e00b001ef8d2f72fesm1911167pjm.45.2022.07.08.11.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 11:28:01 -0700 (PDT)
Message-ID: <9bf3dc09-73df-8914-aa13-68ed9d48f350@gmail.com>
Date:   Fri, 8 Jul 2022 20:27:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] brcmfmac: Replace default (not configured) MAC with a
 random MAC
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <20220708133712.102179-1-hdegoede@redhat.com>
 <20220708133712.102179-2-hdegoede@redhat.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <20220708133712.102179-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/8/2022 3:37 PM, Hans de Goede wrote:
> On some boards there is no eeprom to hold the nvram, in this case instead
> a board specific nvram is loaded from /lib/firmware. On most boards the
> macaddr=... setting in the /lib/firmware nvram file is ignored because
> the wifi/bt chip has a unique MAC programmed into the chip itself.
> 
> But in some cases the actual MAC from the /lib/firmware nvram file gets
> used, leading to MAC conflicts.
> 
> The MAC addresses in the troublesome nvram files seem to all come from
> the same nvram file template, so we can detect this by checking for
> the template nvram file MAC.
> 
> Detect that the default MAC address is being used and replace it
> with a random MAC address to avoid MAC address conflicts.
> 
> Note that udev will detect this is a random MAC based on
> /sys/class/net/wlan0/addr_assign_type and then replace this with
> a MAC based on hashing the netdev-name + the machine-id. So that
> the MAC address is both guaranteed to be unique per machine while
> it is still the same/persistent at each boot (assuming the
> default Link.MACAddressPolicy=persistent udev setting).

Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   .../broadcom/brcm80211/brcmfmac/common.c      | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> index dccd8f4ca1d0..7485e784be2a 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/common.c

[...]

> @@ -226,6 +240,15 @@ int brcmf_c_preinit_dcmds(struct brcmf_if *ifp)
>   			bphy_err(drvr, "Retrieving cur_etheraddr failed, %d\n", err);
>   			goto done;
>   		}
> +
> +		if (ether_addr_equal_unaligned(ifp->mac_addr, brcmf_default_mac_address)) {

Is it necessary to use the unaligned variant?

Regards,
Arend
