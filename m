Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0FD31B2C1
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 11:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfEMJVx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 05:21:53 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33416 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbfEMJVx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 05:21:53 -0400
Received: by mail-ed1-f67.google.com with SMTP id n17so16581263edb.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 02:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZvUBwLNO7ee4FxMaKAao/U9Adifw5Jc5EmFQrHAk9pc=;
        b=NRUEUnNs3PgqaYTy3xzCy0Gua3VgJCYFyjhso55dkrrhuVEughlqeh+uJMTKB5YAfU
         Elq19h+pLTOCw4Pg19q3/sADPz/OvJix8W9AgaJ+5scOSlWjB3i4VUQt/4wZVzOtewfh
         +R0yEe4H7h7XDn7nZUbLGpJus5eXCfBsmqAdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvUBwLNO7ee4FxMaKAao/U9Adifw5Jc5EmFQrHAk9pc=;
        b=ubE11eenAio5Bo6o42XmG+qix9XZs+KB5Ltar6jfLL/EbrhMLIhA9l6Q3N7tAFAwvt
         YetZyl3khrA2UduzAH6z1oywYBoq0Ao2QqqBgfGnu3Kk0Yc4xdIJA5UfCMZ4qg8+WXJO
         72S2R8o2kBoiftXJ13z/HBKbqorcRaMShgO5dU59YLEr5TKRZ5ZA7GpjxJPP0NfvqaZU
         ZUy6S3rQASHBvF63o0zDPseVlvt5+U56ABWYit8auyeSXWSX+UhZE6fb/+Fm7yvJRzTN
         EUZKGyyWTPKsBhBFnVAFrTF++6CkuaVWdpJrQGmtNhgUa9GNB6NjhdRuFDOCejaZRZXC
         Y/WA==
X-Gm-Message-State: APjAAAXu9pBgqTDNcRaE2JMTSlSnjxTGa8QT7VlNtQ2pngcBZ0r2qt8X
        X20/N3dtlWaQOenT2TgAdgC/Ww==
X-Google-Smtp-Source: APXvYqzm+Fllq+S8uJLlL9TpvqJpSHMIEztBcq1s3oxvsKnqIyNKQAS5ta85y9r68VuGUdRfEXYwSg==
X-Received: by 2002:a17:906:314b:: with SMTP id e11mr20887402eje.259.1557739310962;
        Mon, 13 May 2019 02:21:50 -0700 (PDT)
Received: from [10.176.68.125] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id p52sm3601517eda.79.2019.05.13.02.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 02:21:50 -0700 (PDT)
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
To:     Hans de Goede <hdegoede@redhat.com>,
        Victor Bravo <1905@spmblk.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
 <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20190505150355.3fbng4ny34x255vk@localhost>
 <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
 <20190506090609.msudhncj7e5vdtzw@localhost>
 <70677dff-4336-28d5-7ab9-7ba7c3d74ebc@redhat.com>
 <20190506102032.3ximjecado4mz62j@localhost>
 <fb07ae01-4cca-98e7-1c2d-dfdf44909900@redhat.com>
 <87d0kvvkej.fsf@codeaurora.org> <20190506152441.ifjcdi73elxuq5it@localhost>
 <3f3cca6e-50b7-c61d-4a62-26ce508af9e7@redhat.com>
 <95cd81ea-3970-92de-7983-5c1919e2bbd9@broadcom.com>
 <02a6dc11-7def-7d72-4640-d9d42ccec47c@redhat.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <0f42608f-772e-356f-3ade-7ec1b38bd45f@broadcom.com>
Date:   Mon, 13 May 2019 11:21:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <02a6dc11-7def-7d72-4640-d9d42ccec47c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/7/2019 5:38 PM, Hans de Goede wrote:
> Hi,
> 
> On 06-05-19 21:30, Arend Van Spriel wrote:
>> + Luis (for real this time)
>>
>> On 5/6/2019 6:05 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 06-05-19 17:24, Victor Bravo wrote:
>>>> On Mon, May 06, 2019 at 03:26:28PM +0300, Kalle Valo wrote:
>>>>> Hans de Goede <hdegoede@redhat.com> writes:
>>>>>
>>>>>> If we're going to do some filtering, then I suggest we play it 
>>>>>> safe and also
>>>>>> disallow other chars which may be used as a separator somewhere, 
>>>>>> specifically
>>>>>> ':' and ','.
>>>>>>
>>>>>> Currently upstream linux-firmware has these files which rely on 
>>>>>> the DMI
>>>>>> matching:
>>>>>>
>>>>>> brcmfmac4330-sdio.Prowise-PT301.txt
>>>>>> brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt
>>>>>> brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt
>>>>>>
>>>>>> The others are either part of the DMI override table for devices 
>>>>>> with unsuitable
>>>>>> DMI strings like "Default String"; or are device-tree based.
>>>>>>
>>>>>> So as long as we don't break those 3 (or break the ONDA one but 
>>>>>> get a symlink
>>>>>> in place) we can sanitize a bit more then just non-printable and '/'.
>>>>>>
>>>>>> Kalle, Arend, what is your opinion on this?
>>>>>>
>>>>>> Note I do not expect the ONDA V80 Plus to have a lot of Linux users,
>>>>>> but it definitely has some.
>>>>>
>>>>> To me having spaces in filenames is a bad idea, but on the other 
>>>>> hand we
>>>>> do have the "don't break existing setups" rule, so it's not so 
>>>>> simple. I
>>>>> vote for not allowing spaces, I think that's the best for the long 
>>>>> run,
>>>>> but don't know what Arend thinks.
>>
>> Hi,
>>
>> Had a day off today so I did see some of the discussion, but was not 
>> able to chime in until now.
>>
>> To be honest I always disliked spaces in filenames, but that does not 
>> necessarily make it a bad idea. What I would like to know is why 
>> built-in firmware can not deal with spaces in the firmware file names. 
>> I think Hans mentioned it in the thread and it crossed my mind as well 
>> last night. From driver perspective, being brcmfmac or any other for 
>> that matter, there is only one API to request firmware and in my 
>> opinion it should behave the same no matter where the firmware is 
>> coming from. I would prefer to fix that for built-in firmware, but we 
>> need to understand where this limitation is coming from. Hopefully 
>> Luis can elaborate on that.
> 
> Ok.

The issue is probably that make does simply split the EXTRA_FIRMWARE 
setting at each space character. I tried to use single quote so
"'brcmfmac43340-sdio.ASUSTeK COMPUTER INC.-T100HAN.txt' 
brcmfmac43340-sdio.bin". No luck. So all I could think of is patch below 
which require the user to enter a special sequence, ie. _-_ where space 
should be.

"brcmfmac43340-sdio.ASUSTeK_-_COMPUTER_-_INC.-T100HAN.txt 
brcmfmac43340-sdio.bin"

It works but I had to drop the dependency so it's all a bit hacky.

Regards,
Arend

diff --git a/firmware/Makefile b/firmware/Makefile
index 37e5ae387400..a536e5d12d5f 100644
--- a/firmware/Makefile
+++ b/firmware/Makefile
@@ -5,10 +5,11 @@
  fwdir := $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE_DIR))
  fwdir := $(addprefix $(srctree)/,$(filter-out /%,$(fwdir)))$(filter 
/%,$(fwdir))

+fw_space_escape := _-_
  obj-y  := $(addsuffix .gen.o, $(subst $(quote),,$(CONFIG_EXTRA_FIRMWARE)))

-FWNAME    = $(patsubst $(obj)/%.gen.S,%,$@)
-FWSTR     = $(subst /,_,$(subst .,_,$(subst -,_,$(FWNAME))))
+FWNAME    = $(subst $(fw_space_escape),$(space),$(patsubst 
$(obj)/%.gen.S,%,$@))
+FWSTR     = $(subst $(space),_,$(subst /,_,$(subst .,_,$(subst 
-,_,$(FWNAME)))))
  ASM_WORD  = $(if $(CONFIG_64BIT),.quad,.long)
  ASM_ALIGN = $(if $(CONFIG_64BIT),3,2)
  PROGBITS  = $(if $(CONFIG_ARM),%,@)progbits
@@ -34,7 +35,7 @@ $(obj)/%.gen.S: FORCE
  	$(call filechk,fwbin)

  # The .o files depend on the binaries directly; the .S files don't.
-$(addprefix $(obj)/, $(obj-y)): $(obj)/%.gen.o: $(fwdir)/%
+$(addprefix $(obj)/, $(obj-y)): $(obj)/%.gen.o:

  targets := $(patsubst $(obj)/%,%, \
                                  $(shell find $(obj) -name \*.gen.S 
2>/dev/null))
