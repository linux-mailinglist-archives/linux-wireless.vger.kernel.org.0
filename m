Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01EC549D32
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 21:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242242AbiFMTPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 15:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346930AbiFMTPB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 15:15:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AB41CFED
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 10:32:54 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id h23so12467133ejj.12
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version;
        bh=RY5It5ZdebBcXVaql2t0lpKiGiaXrOi40asd43li74M=;
        b=OX29FpFAJXk1JylLRjxa/3N40rVBoDa7l3tKT4glpi9IkHhYG9rVK/H2FJA+vQOj3+
         iIO2n49MhpOeS2SwEsuxdgtUthrH33YrybUY2SRkftZ20zn2RA7pmRhRpJPpYnLeXwJZ
         CtWwQaHYsel04qoxueqiQ0IU3Ut2mZdok0hZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version;
        bh=RY5It5ZdebBcXVaql2t0lpKiGiaXrOi40asd43li74M=;
        b=li9E29zqqfzN3At4RvuB1I89j2ZiaFKkrbsMGZ3s5PitckqlqVzliceaUXvhsKEgZW
         90bxlkuYzMGghM9paqh6/o2F/L1ZVk7S0Bz4392Ur62E+qqseGJbLQ6dvA1aYhuGpG9v
         /plNWKTbTHSLbxkoOg28uETzhCLvbDxp2xt9890FIgGSN1IeGLcaC/SBIxdrUJHWFS7p
         NxpMPUHfMNqU5YAmbc2DdpR53wbrTRMaTdREEcQrZBNAztfDTOxGBp3Z6phzyU3DEeyr
         bYjgVMwAOvaA/hhUZEg/jyvxnlwb/IxDLrNpcG4UjEtgY/Yi1N5/x8PAIx6lyOleUByF
         ibkg==
X-Gm-Message-State: AOAM5331o6kz0d+BebHYkQcq8t7qCDheAzAaNdcnlua6DjF2U9L8Vg4R
        I9PGcbk8B+Kf0gYZuAP1izHRfw==
X-Google-Smtp-Source: AGRyM1usj97UXOb4boi5c7PP8DDKlf6sPvDnOZBjYHtZjz7jIBvArhZ8laqgaFUIq/8xPldnChx7pQ==
X-Received: by 2002:a17:907:3e1d:b0:711:dc92:e308 with SMTP id hp29-20020a1709073e1d00b00711dc92e308mr775205ejc.235.1655141573083;
        Mon, 13 Jun 2022 10:32:53 -0700 (PDT)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id j5-20020a170906430500b006f3ef214e0esm4040645ejm.116.2022.06.13.10.32.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jun 2022 10:32:51 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Danny van Heumen <danny@dannyvanheumen.nl>
CC:     Franky Lin <franky.lin@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>
Date:   Mon, 13 Jun 2022 19:32:49 +0200
Message-ID: <1815e2011e8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <MV9-h4Mgj6FKxRJY93AQMhYFsz2yz0CoDQ70V8JWe742HUdLdl6Q1LbFTxGa-NCzodUmI3dbSoRGXebbE5rWPKKehHdixSTjW4TKZt10AJk=@dannyvanheumen.nl>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl>
 <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl>
 <Y_XMhLmW7kj2Ls3X8pCfFd2RdWzXd9UWdv3ksFrVi7xh79wY7l6K52N3ODhI3_UK_IqG1uJcIEv0PxT-wQG9tdYu9krraq7gxsprUu-RtjQ=@dannyvanheumen.nl>
 <51CC1C7B-400C-4A7A-A5D3-EB457DC6862F@broadcom.com>
 <jJuvC2YezD_e1G6VFXwJjFFUAir0HFcDnBaZGRvKtnaY69v8aI3KkCouzzyOjrb9bZOnSzinETjNNxHvlmYCwNijdmts_5bEXZSV7dMNi0s=@dannyvanheumen.nl>
 <B08447EB-F222-49B5-A411-0DB6848A80ED@broadcom.com>
 <EbyrCYK_mR6ppJYbSc5JfGGG_QZEZb2Zp8Htx9f-orZ_wX0Dpz1pXhDjQ9P1nGuyTH041zvsScaRIPllClzLpLgwVuff4ZTTAiVOXe5-Mwg=@dannyvanheumen.nl>
 <1a116224-66ff-17b1-bb8b-9c0918dd47e4@broadcom.com>
 <kB9OdQYlBnucF05VoKxTvsT8eUrPGJc_we9irAdR-2gmXsEl4NvkhMzDcTahLm3HLA2zKVXnhEOstESbIEcHGKYHvMOyIcr4vh80f0eJCJ0=@dannyvanheumen.nl>
 <MV9-h4Mgj6FKxRJY93AQMhYFsz2yz0CoDQ70V8JWe742HUdLdl6Q1LbFTxGa-NCzodUmI3dbSoRGXebbE5rWPKKehHdixSTjW4TKZt10AJk=@dannyvanheumen.nl>
User-Agent: AquaMail/1.36.0 (build: 103600147)
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000087b1ec05e157ad9b"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000087b1ec05e157ad9b
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On June 13, 2022 2:33:51 PM Danny van Heumen <danny@dannyvanheumen.nl> wrote:

> Hi Arend, Franky,
>
> ------- Original Message -------
> On Tuesday, June 7th, 2022 at 21:45, Danny van Heumen 
> <danny@dannyvanheumen.nl> wrote:
>
>> Hi Arend,
>>
>> ------- Original Message -------
>> On Tuesday, June 7th, 2022 at 21:00, Arend van Spriel 
>> arend.vanspriel@broadcom.com wrote:
>>
>>> [..]
>>>
>>>>> While directly return without invoking clean up process makes
>>>>> perfect sense for the issue described here, it doesn’t address the
>>>>> broader issue that sdiodev might hold on to couple stale pointers that
>>>>> might subsequently be used in somewhere down the path because sdiodev is
>>>>> not freed. Setting these pointer to NULL after freeing them could help
>>>>> us to catch such issue which is more catastrophic than a double-free.
>>>>> The perfect solution of course is to rework the code to free sdiodev
>>>>> whenever brcmf_sdiod_remove() is invoked but that can not be done in
>>>>> short-term unfortunately.
>>>
>>>> - True.
>>>> - If the two early returns are appropriate -- I think they are -- so
>>>> we can leave those in. (Again, I'm unfamiliar with the code-base.)
>>>> - Setting the pointer to NULL at least has the benefit that behavior
>>>> (even if bugged) is the same irrespective of memory allocation behavior.
>>>> - I checked your suggestion for 'sdiodev->sgtable': it is not a
>>>
>>> pointer, so setting to NULL will not help. If I read this correctly,
>>> 'sg_free_table(..)' is already resistant to multiple freeing attempts
>>> with a test of '.sgl'.
>>>
>>>> .. as for the control flow. Sure, rework would be nice, but -- to me
>>>> at least -- it is not clear if it is really necessary. Maybe I'm
>>>> mistaken, but there seem to be few entry-points to take into account.
>>>> The "hardware-reset after firmware-crash"-logic was added later IIUC, so
>>>> maybe it was an oversight? Regardless, I have updated the patch.
>>>
>>> The reset-after-fw-crash was indeed added later. I am wondering is we
>>> can leave the remove-reprobe dance to the mmc core. Maybe mmc_hw_reset()
>>> could do the trick, ie. simply call mmc_hw_reset() in
>>> brcmf_sdio_bus_reset() and be done with it. Maybe opening a can of worms
>>> here, but I always felt uncertain about calling .remove and .probe
>>> callbacks directly from the driver itself as it may cause issue like
>>> this double-free, but also the bus is unaware and I don't know that is a
>>> bad thing or not.
>>
>>
>> I am pretty sure you found a can of worms indeed :-)
>>
>> So, a few things to note:
>>
>> - do you have a reliable way to test this behavior?
>> - from my PoV: I have encountered various compositions of firmware and uCode
>> for the BCM4345/9 (43456-sdio). Earlier versions may occasionally
>> exhibit the crashing-behavior, but not reliably.
>> - do you want to tackle this as a separate effort, given that there is already
>> benefit in merging the earlier patch proposal?
>>
>> Let me try to give my impression of the code, that I get from my cursory scans
>> through the brcmfmac code: it seems that the device as a whole (the "root")
>> gets activated. From what I remember, there seems to be a callback that
>> triggers subsequent initialization. So, it makes somewhat sense to me if a
>> hardware-reset could flow (back) into the existing initialization flow.
>> (Again, don't trust info below, as I have very limited knowledge in this 
>> domain.
>> I'm trying to check the extent to which I can make sense of it.)
>
> What would be the next steps?

You should send a proper patch to the linux-wireless list, ie. not in an 
attachment but the commit message and patch diff in plain text email 
message. Please refer to [1] for guidelines.

I reinstated SDIO card in my test setup so I can test your patch.

Regards,
Arend

[1] 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



--00000000000087b1ec05e157ad9b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
XSlOP9s1dqWlRRnnNxV7BVC87lkKKy0+1M2DOF6qRYQlnW4EfOyCToYLAG5zeV+AjepMoX6J9bUz
yj4BlDtwH4HFjaRIlPPbdLshUA54/tV84x8woATuLGBq+hTZEpkZAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKb+3b9pz8zo
0QsCHGb/p0UrBlU+MA0GCSqGSIb3DQEBCwUAA4IBAQCHisuRNqP0NfYfG3U3XF+bocf//aGLOCGj
NvbnSbaUDT/ZkRFb9dQfDRVnZUJ7eDZWHfC+kukEzFwiSK1irDPZQAG9diwy4p9dM0xw5RXSAC1w
FzQ0ClJvhK8PsjXF2yzITFmZsEhYEToTn2owD613HvBNijAnDDLV8D0K5gtDnVqkVB9TUAGjHsmo
aAwIDFKdqL0O19Kui0WI1qNsu1tE2wAZk0XE9FG0OKyY2a2oFwJ85c5IO0q53U7+YePIwv4/J5aP
OGM6lFPJCVnfKc3H76g/FyPyaE4AL/hfdNP8ObvCB6N/BVCccjNdglRsL2ewttAG3GM06LkvrLhv
UCvjMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMMSnY
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDV+7uHV3bjFNJSN28V
/svj2ylzXVOAh0Bglg71a69czDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjA2MTMxNzMyNTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAWtrVX8rcVkjIUarpTBdhkrmYw0Upc9IrWZzI
z6ZHuiRpKTS/1wohS/j81Y4a/EUBYrOVpvlnyo668TuHmRW8DmNgZwAkrqbGP1hLkX0/hAJUpYz6
2a0gi6FbdUJ9cjwjgReeydwYHMIFt3klhVJMK7qK48yWyghypmrnkZUQ1GCXVj9bB0Ng+yBgfEQj
IkY+fANErJ3PpLWn752wlYHcdvrxHTpQWVrjeL+EmFRr1+uyDY3E7w8DQx8CcBUiXnyO3T4GMI47
gCqmy2qrK6+1Ryp+/+Hpf4ZkD7rHKjp+S4oCMgDkWziQ+GUSCO7c6ljtbUhGjULHWwbPF0z73I+T
Zg==
--00000000000087b1ec05e157ad9b--
