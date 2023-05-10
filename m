Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA466FDB49
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 12:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbjEJKF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 06:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjEJKF0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 06:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F130665A4
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 03:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683713078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mxi0tssM/MIAC/Us8XUva2O6e9fov44nkm6fQlyWJnA=;
        b=isZBKGAMh/uErCczrg+3ycs049+oSB7jjrpMcgTbQwPDOg5SKzhqjQTs7OXi1OlGXfpz/i
        o0R310S2oasetMdjZchpBfQLa8ORqz90VP+gHzT0s13vxlRMyctPO0PEpU1XkSH6RMNeRV
        PuXblabWXjeuNCvu/mB2j0k60tXk+cU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-RF3bSlhWNEWYIg6Moz6nyA-1; Wed, 10 May 2023 06:04:35 -0400
X-MC-Unique: RF3bSlhWNEWYIg6Moz6nyA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9662ead7bf8so421227266b.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 03:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713074; x=1686305074;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxi0tssM/MIAC/Us8XUva2O6e9fov44nkm6fQlyWJnA=;
        b=jmB7fQTpmHABgFyX2MjOaJTwZhmF+hxkOFdkEAmhEui1aTh5yuzXoQTFi/V0dPN6jV
         4DQu1ynH5SnwIVgCJQ4HfOJ/Zq11RhRR2dTJpJxx2wcpEFZXxg7oTnwbizONrm+wQrDv
         qnyOKFkwxqnI1nl8sw2ENOWReletVd5XjM0EfW1uLFqpCeUydB3kQbzu9eMFnHpHaWtl
         jamgQBedEb35yojTgY00fl9h7eEVAnQPtgv13XPYtapUT2HkSdpH7GXI9zgwMqQE+guD
         Vmj8s/BB2H8y8siiPL8VZO1Z6fGWWMeZjj4mH3MppV31aUVNBqidmKaRlG8fXUN2KGyk
         l05g==
X-Gm-Message-State: AC+VfDxiswLnYqKVZRFXSfqrewhX+tKWS/cJGP2PXY/T/XrrP9+JkbMr
        OW9IdlVsCFZfP6m4ENsc/QGoKb7iaQrNH/2ome75NWjmfONWN+l0gClC9UyoPwvJHsopQJFWOv1
        85sGMHGChK31fh58LPgJemPJ4t+8=
X-Received: by 2002:a17:906:dc93:b0:94f:a292:20cc with SMTP id cs19-20020a170906dc9300b0094fa29220ccmr15643205ejc.41.1683713074314;
        Wed, 10 May 2023 03:04:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6g3VLlchZ4NQ4dVKKV7VFeDXbAdsULvGoTQhQBYH7wgUiWDxOc+E6cOLAsZqVz3BCBbS6/Sw==
X-Received: by 2002:a17:906:dc93:b0:94f:a292:20cc with SMTP id cs19-20020a170906dc9300b0094fa29220ccmr15643186ejc.41.1683713074026;
        Wed, 10 May 2023 03:04:34 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id de25-20020a1709069bd900b0096664376ec9sm2486973ejc.55.2023.05.10.03.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 03:04:33 -0700 (PDT)
Message-ID: <c7aa9034-59f8-11aa-7170-86c0db012dda@redhat.com>
Date:   Wed, 10 May 2023 12:04:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [REGRESSION] wifi: brcmfmac: add firmware vendor info in driver
 info
Content-Language: en-US, nl
To:     Felix <nimrod4garoa@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     regressions@lists.linux.dev,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
References: <4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4ef3f252ff530cbfa336f5a0d80710020fc5cb1e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Felix,

On 5/10/23 10:25, Felix wrote:
> Changes made by the mentioned commit lead to Oops when waking up after
> suspend to RAM.
> 
> When waking up a Dell XPS 13 9350 with BCM4350 wifi card after suspend
> to RAM, the kernel hangs with a NULL pointer dereference and Oops. The
> issues was introduced by commit
> da6d9c8ecd00e20218461007948f2b0a8e7fa242 and only happens when the
> brcmfmac module is loaded. This issue is the reason we could not
> upgrade to newer kernels than the 6.1 series on the affected machine.
> 
> 
> Details:
> 
> On a Dell XPS 13 9350 laptop with Broadcom BCM4350 wifi card (according
> to lspci), every kernel starting with 6.2 hangs when waking up after
> suspend to RAM. The issue persisted as of May 2nd (last tested commit
> was 348551ddaf311c76b01cdcbaf61b6fef06a49144). Passing the debug and
> no_console_suspend parameters to the kernel show that a NULL pointer
> dereference and an Oops happen at wakeup. Please find the kernel
> messages readable on the screen at this point attached
> (kernel_log_after_suspend.txt).
> 
> A bisection was successful and produced the first bad commit
> [da6d9c8ecd00e20218461007948f2b0a8e7fa242] wifi: brcmfmac: add firmware
> vendor info in driver info
> I've attached the bisection log as well (bisect.txt).
> 
> Suspend to RAM works on this machine on newer kernels once the brcmfmac
> module is unloaded.
> 
> Distribution: Arch Linux
> Architecture: x86_64
> Device: Dell XPS 13 9350 with BCM4350 wifi card
> Kernel config used at compilation (created using the Arch Linux default
> config and make olddefconfig):
> https://gist.githubusercontent.com/maclomhair/e33fa7eece8f8c77e5a88c4eede2f523/raw/429dfb022498c026225865dbb3ab2f75d5030a54/config
> Dmesg output after boot:
> https://gist.githubusercontent.com/maclomhair/47c75fa759d93800e7fb5e937fabef3e/raw/10750996a1ea9dcb3fa14d9b94e11fedd3abf280/dmesg
> 
> #regzbot introduced da6d9c8ecd00e20218461007948f2b0a8e7fa242

Thank you for reporting this and thank you for bisecting it too!

As a result of your excellent bug report I've been able to write
a fix for this. I'm confident enough in the fix that I've submitted
it upstream right away.

But it would still be good if you can test the fix and let us know
if it fixes this issue for you. You should have received a copy
of the patch when I submitted it upstream.

Regards,

Hans




