Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE48E758174
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jul 2023 17:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbjGRP4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Jul 2023 11:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjGRP4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Jul 2023 11:56:32 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4C81B9
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jul 2023 08:56:31 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1b056276889so3966693fac.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Jul 2023 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689695791; x=1692287791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6/4lcjP72yKqatsCriQavGtgbngapiHaC3Twd+juHL4=;
        b=TU/AlBna6TePLU2bicSNaMveThckpsXz/H37XzxSzcz8E4+GLoNXTjS+D0zVtbFK5/
         NETkkHE8pDgDCl7igiCYF1ubgoPX+Pvc6cVAeWlyIR1dxbRZszEzMsQWXmElkOYGw8kZ
         1HBaCxgM7W8hJXC7FkZaV5pfzm+5yEbx8p7OVyWKLSaX3Hn7b1Je9c0N28BO6o4wHN4w
         rn6A0ZC0N7nc3VFkK6r/FT08SgWZU0M+seNi4qHLiRJkVoqDNflAWVodywai2Lc0SM4Y
         dCtTAgpB4Uwx/nkMLjWDpiconx4m3jYWrie3/0irTvoQ/6Ga4X+szzeYEMcpLJf7d45u
         j9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689695791; x=1692287791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/4lcjP72yKqatsCriQavGtgbngapiHaC3Twd+juHL4=;
        b=E0ApnMuNQ8q7NjEbDi1NTXlXwqya3H4nseQW2TXQazbZWVIPNlDuAuTwmsCMU7yR59
         t2AU27RYFOSym2R4Ll6+bDMxdn8ZXJENV2AdJtG0XdJrzzb/70JJdek9GrCi8Wr/6g4I
         nppBbiB27DUNUtJGc2lVxZG2hegZVXX1WKiO0kEJ+SqF+bfqHgMLOOBEl1RXsV3OYcYS
         GHP3D4NKGbwnYtUMp5SyuNcwu9tCd/rslitVCJFlczyFVYIhKaYKPU6duOfm4uxQf154
         CsUMU38B8EUKQ8JXTF+dRDFy7ZpUiKdNqYk35jd4s6TqAY+QO8c5O1++na1FqIDhspaK
         iX7g==
X-Gm-Message-State: ABy/qLa5WLZpZsGszPoj1giJv6NQX7sT1JQB0EKqWba8WvwBLwQNqsrL
        0FPr8GrZmmHx+L0ok2zntXc=
X-Google-Smtp-Source: APBJJlFK5NKk7AzkE+XGz3HC3bpne2nSjT72gWuaMnrVrYnfpfEoV5w061A7gOlfOtww3kl5qq9JVQ==
X-Received: by 2002:a05:6870:f68a:b0:1a6:987b:f09d with SMTP id el10-20020a056870f68a00b001a6987bf09dmr15074834oab.51.1689695791009;
        Tue, 18 Jul 2023 08:56:31 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id e1-20020a0568301e4100b006b94aba1f0bsm962160otj.43.2023.07.18.08.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 08:56:30 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <834b9657-8c8c-839c-c04e-4b8e55dc728b@lwfinger.net>
Date:   Tue, 18 Jul 2023 10:56:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: rtw89 driver and compressed firmware files
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
References: <87zg3uvawm.wl-tiwai@suse.de>
 <f5e75b2b-14eb-7ffc-6716-70324d2d13c5@lwfinger.net>
 <87351lpywg.wl-tiwai@suse.de>
Content-Language: en-US
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87351lpywg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/18/23 00:33, Takashi Iwai wrote:
> 
> Thanks Larry, but I guess that it happens only for multi versions such
> as rtw8852b that have rtw8852a_fw.bin and rtw8852a_fw-1.bin, while
> yours is rtw8851b that has only one firmware version.
> 
> And, the driver might look as if still "working".  IIUC, it's only
> that the new firmware version won't be used as long as the firmware
> files are compressed.
> 
> You can see more details by passing firmware_class.dyndbg=+p boot
> option.
> 
>> All of this was done using Tumbleweed. My next step will be to try
>> Leap 15.5 and Leap 15.4. I will report those tests later.
> 
> Note that the problem of the firmware loader is likely irrelevant with
> the actual issue in the bugzilla entry above; I only gave as a
> reference.
> 
> It seems that the bug there was due to the error:
> 
>    rtw89_8852be 0000:02:00.0: [ERR]pci config read 719
>    rtw89_8852be 0000:02:00.0: [ERR] pcie autok fail -22
>    rtw89_8852be 0000:02:00.0: failed to setup chip information
> 
> Since reloading the module works, this might be related with the PCI
> power state or something else.  But it's a different topic from this
> thread, which is about the firmware loader problem.

Takashi,

When I switched my NIC to an RTW8852BE, which does have 2 versions of the 
firmware, I still got a successful firmware load for Tumbleweed running the new 
kernel 6.4.3-1, on Leap 15.5, and on Leap 15.4. The only problem was that file 
rtw8852b_fw.bin.xz is loaded, and not the newer rtw8852b_fw-1.bin.xz, which is 
preferable. This was try for the drivers in kernel 6.4.3, 6.5.0-rc2, and in the 
GitHub repo.

When I stripped the code in rtw89_early_fw_feature_recognize() to never try to 
run request_partial_firmware_into_buf(), then the newest firmware is loaded. The 
logs showed the following:

[  834.438601] firmware_class: __free_fw_priv: fw-rtw89/rtw8852b_fw.bin 
fw_priv=000000000849addc data=00000000fd3cabe2 size=1035232
[  834.438658] firmware_class: fw_name_devm_release: 
fw_name-rtw89/rtw8852b_fw.bin devm-000000002d8c3343 released
[  846.992333] firmware_class: __allocate_fw_priv: fw-rtw89/rtw8852b_fw-1.bin 
fw_priv=000000009e1a6364
[  846.992352] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin failed for no such 
file or directory.
[  846.992357] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/updates/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
[  846.992361] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin failed for no such file or 
directory.
[  846.992366] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/rtw89/rtw8852b_fw-1.bin failed for no such file or directory.
[  846.992371] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.zst failed for no 
such file or directory.
[  846.992375] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/updates/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or 
directory.
[  846.992378] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.zst failed for no such 
file or directory.
[  846.992391] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/rtw89/rtw8852b_fw-1.bin.zst failed for no such file or directory.
[  846.992396] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/updates/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.xz failed for no 
such file or directory.
[  846.992399] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/updates/rtw89/rtw8852b_fw-1.bin.xz failed for no such file or 
directory.
[  846.992402] rtw89_8852be 0000:02:00.0: loading 
/lib/firmware/6.4.3-1-default/rtw89/rtw8852b_fw-1.bin.xz failed for no such file 
or directory.
[  846.997453] rtw89_8852be 0000:02:00.0: Loading firmware from 
/lib/firmware/rtw89/rtw8852b_fw-1.bin.xz
[  846.997456] rtw89_8852be 0000:02:00.0: f/w decompressing rtw89/rtw8852b_fw-1.bin
[  847.014261] firmware_class: fw_set_page_data: fw-rtw89/rtw8852b_fw-1.bin 
fw_priv=000000009e1a6364 data=00000000fd3cabe2 size=1184992
[  847.019276] rtw89_8852be 0000:02:00.0: Loaded FW: rtw89/rtw8852b_fw-1.bin, 
sha256: 8539efc75f513f4585cf0cd6e79e6507da47fce87225f2d0de391a03aefe9ac8
[  847.019280] rtw89_8852be 0000:02:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
[  847.021436] rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.1, cmd 
version 0, type 5
[  847.021442] rtw89_8852be 0000:02:00.0: Firmware version 0.29.29.1, cmd 
version 0, type 3
[  847.362658] rtw89_8852be 0000:02:00.0: chip rfe_type is 1
[  847.397754] rtw89_8852be 0000:02:00.0 wls1: renamed from wlan0

I want Ping-Ke to look at my patch. If he agrees, I will push it to GitHub, and 
it will be picked up in the openSUSE repos for 15.4 and 15.5.

Larry


