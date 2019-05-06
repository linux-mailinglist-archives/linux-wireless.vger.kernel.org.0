Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3494A145D4
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEFINm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 04:13:42 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44957 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfEFINm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 04:13:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so14309112edm.11
        for <linux-wireless@vger.kernel.org>; Mon, 06 May 2019 01:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QNvN8OqIbd2dPdzBBPVcOe2NRqEy3Q9v/swnK/nbM9Q=;
        b=KDhmqpacYg0+m7OlGoHP1VBd6sNnPHyoavT3mfoGvnCwQ6xq3h8fpQJbrEHkuLknex
         Iw1OBDVvfZGxoq+L6KwjtjN0ZAZcD92/o95tQ53vBJlHhpdxk06NZeVelbyj0fVUbpKL
         PnwiLV+6RrCijejgksWD5r23zwQUfw0iB2YgQXbFX9WVCzK3HA7dkQlPpAPG24gN42tE
         SKtq+PrzaZ4q9UC9sHEaGHAtTVNnynxxT4FjY9ssXpb8tVIT+Fh2UiieoEZule6jIY9z
         7UVPc9VosC5dZar7W93Ujr3Kw+P3CE72KlYdSjKKmsjxdL4Vr4RXsvqIuHvvuMwMEPgk
         qHkA==
X-Gm-Message-State: APjAAAWnK0QcWg+7+1VBJrhdmWaI+0kxaXDOsaCcyKSb38yoJqv2RmoP
        nxgvrAavRP0EXAOhX9mh2FpkAw==
X-Google-Smtp-Source: APXvYqw67dt/5kqRfhyvR2PWuu6bLBz4NWBrEcYKuCB2vbs72gHOr5g5FWhIaIT8SBagdj86Q71UXg==
X-Received: by 2002:aa7:d9cb:: with SMTP id v11mr2912156eds.159.1557130420772;
        Mon, 06 May 2019 01:13:40 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id k37sm2886520edb.11.2019.05.06.01.13.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:13:39 -0700 (PDT)
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
To:     Victor Bravo <1905@spmblk.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
References: <20190504162633.ldrz2nqfocg55grb@localhost>
 <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
 <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20190505150355.3fbng4ny34x255vk@localhost>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
Date:   Mon, 6 May 2019 10:13:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505150355.3fbng4ny34x255vk@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 05-05-19 17:03, Victor Bravo wrote:
> Sanitize DMI strings in brcmfmac driver to make resulting filenames
> contain only safe characters. This version replaces all non-printable
> characters incl. delete (0-31, 127-255), spaces and slashes with
> underscores.
> 
> This change breaks backward compatibility, but adds control over strings
> passed to firmware loader and compatibility with CONFIG_EXTRA_FIRMWARE
> which doesn't support spaces in filenames.
> 
> Changes from v1: don't revert fresh commit by someone else
> 
> Signed-off-by: Victor Bravo <1905@spmblk.com>

Thank you for the patch, but I'm sorry to say this patch cannot go in as is,
because it will break existing systems.

If you look here:

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/brcm

You will see a file named: "brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt" there, which
has a space in its name (and which works fine).

I'm fine with doing some sanitizing of the strings, but replacing spaces with _
breaks existing use-cases (will cause a regression for them) and a space is absolutely
a valid character in a filename and the firmware-loader can deal with this just fine.

If the code for building firmwares into the kernel cannot deal with spaces then IMHO
that code should be fixed instead. Have you looked into fixing that?

As for your T100HA example from earlier in this thread, the brcmfmac driver now
also supports getting the firmware from a special EFI nvram variable, which the
T100HA sets, so you do not need to provide a nvram file on the T100HA and things
will still work.

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> index 7535cb0d4ac0..84571e09b465 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> @@ -23,6 +23,14 @@
>   /* The DMI data never changes so we can use a static buf for this */
>   static char dmi_board_type[128];
>   
> +/* Array of 128 bits representing 7-bit characters allowed in DMI strings. */
> +static unsigned char brcmf_dmi_allowed_chars[] = {
> +	0x00, 0x00, 0x00, 0x00, 0xfe, 0x7f, 0xff, 0xff,
> +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f
> +};
> +
> +#define BRCMF_DMI_SAFE_CHAR '_'
> +
>   struct brcmf_dmi_data {
>   	u32 chip;
>   	u32 chiprev;
> @@ -99,6 +107,15 @@ static const struct dmi_system_id dmi_platform_data[] = {
>   	{}
>   };
>   
> +void brcmf_dmi_sanitize(char *dst, const unsigned char *allowed, char safe)
> +{
> +	while (*dst) {
> +		if ((*dst < 0) || !(allowed[*dst / 8] & (1 << (*dst % 8))))

At a first look I have no clue what this code is doing and I honestly do not feel
like figuring it out, this is clever, but IMHO not readable.

Please just write this as if (*dst < 0x21 || (*dst > foo && < bar) || etc,
so that a human can actually see in one look what the code is doing.

You may want to wait for Arend to give his opinion before changing this though,
maybe he likes the code as is.

Also note that that should be < 0x20 of course, since we need to preserve spaces
as is to avoid a regression.

Regards,

Hans





> +			*dst = safe;
> +		dst++;
> +	}
> +}
> +
>   void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev)
>   {
>   	const struct dmi_system_id *match;
> @@ -126,6 +143,9 @@ void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev)
>   	if (sys_vendor && product_name) {
>   		snprintf(dmi_board_type, sizeof(dmi_board_type), "%s-%s",
>   			 sys_vendor, product_name);
> +		brcmf_dmi_sanitize(dmi_board_type,
> +				   brcmf_dmi_allowed_chars,
> +				   BRCMF_DMI_SAFE_CHAR);
>   		settings->board_type = dmi_board_type;
>   	}
>   }
> 
