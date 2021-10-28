Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F3943E025
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJ1Lmn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Oct 2021 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhJ1Lmk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Oct 2021 07:42:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86635C061570
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 04:40:12 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 1so4234743ljv.2
        for <linux-wireless@vger.kernel.org>; Thu, 28 Oct 2021 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EPO/PX8P5pmEDcwaoHZ4NGvxtgVrTPN3Xr1ZeWVcQyo=;
        b=ixrOqryvaeOSQXpt3O/J1Q3ZXT3Zu6bTLc1dI8IjsUPGeQQFIAsrQ9RIA4ASR6R6rV
         Hd0ezGPMrvnl5k+gPF+8nmopWRVo++rY1DgakoRKQpDZIpeLUxJsdfvwy0cNgr067aY+
         GgPyds6TObuPEoIL0zlonP9dmSbiWdbODJNvEDVRp2T+k32AtUJs9PRKqXshKRcV6HUI
         DUhEqV3sze2+tbomPW2viZbKhb/YTuZBn717MoDCd8e3qv/+lnvWq29zwQ/92k7vtiJP
         zRVEQDiP0vG4VSwEDfuH5vZGE0CeFVBtcQBaiU36K/o+3CZVC+j4rj2AYePdNyHJL9Ex
         9uEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EPO/PX8P5pmEDcwaoHZ4NGvxtgVrTPN3Xr1ZeWVcQyo=;
        b=hdCRCzgA1LmOhKO9n/iC2RYof/AXSaqHwXhPj9NnGZgmUtw3a8c8I8jpluNv6Yy7dF
         mX+wFZHNNPdN0BMgnGVucRMO3AFHT5WdnBJv8mzwvcJ3eD4LHtbyRpGtVS/wBqF3Ddu7
         npCJ8hXyoVY7Xl88SbZdnV1m7vAGo8877W9YfL5CcclJLku6+BbNV5+q7sM+O5jM/aQj
         rYFQd7R/5wOhyPgesZ6RrWCpYpD16HykBiMSUrtU6HVhiEry9tb7nQTuN5gB0tduYaLt
         aWK2ZFxqxGp6FIqiBw1NVQsLTetcDkSaydGZJf9Vjolo0Vey+PXmDI/DnIZzK+3wHfJC
         pHpA==
X-Gm-Message-State: AOAM532TIpCRdI1iv9oPZMVm6+21wwFyt6OzIc/j3/MaIV+6kyJ7oYjs
        I+0us54kvnU0lJn+Z6/9X9pRu3y/Re7cvUOtK80=
X-Google-Smtp-Source: ABdhPJw9ppDKOlSn9mDamAid1FcMBK+j3nbvg5BNuyUWxO4KLqJGVEnwX5aGOcV4NHZonB4SXUTUdgmyIEO5lPih7Ik=
X-Received: by 2002:a2e:9015:: with SMTP id h21mr4179495ljg.264.1635421210214;
 Thu, 28 Oct 2021 04:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211016234609.1568317-1-chunkeey@gmail.com> <87ee855xwa.fsf@codeaurora.org>
 <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com>
In-Reply-To: <3a8840ea-1499-950b-fb44-7546a32c586f@gmail.com>
From:   Ansuel Smith <ansuelsmth@gmail.com>
Date:   Thu, 28 Oct 2021 13:39:59 +0200
Message-ID: <CA+_ehUwi45irFZCadx-XRnW_+jJac7wWcPJ2756K8xjFsDx4Ow@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: fetch (pre-)calibration data via nvmem subsystem
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 28/10/2021 10:58, Kalle Valo wrote:
> > Christian Lamparter <chunkeey@gmail.com> writes:
> >
> >> ATH10K chips are used it wide range of routers,
> >> accesspoints, range extenders, network appliances.
> >> On these embedded devices, calibration data is often
> >> stored on the main system's flash and was out of reach
> >> for the driver.
> >>
> >> To bridge this gap, ath10k is getting extended to pull
> >> the (pre-)calibration data through nvmem subsystem.
> >> To do this, a nvmem-cell containing the information can
> >> either be specified in the platform data or via device-tree.
> >>
> >> Tested with:
> >>          Netgear EX6150v2 (IPQ4018 - pre-calibration method)
> >>          TP-Link Archer C7 v2 (QCA9880v2 - old calibration method)
> >>
> >> Cc: Robert Marko <robimarko@gmail.com>
> >> Cc: Thibaut VAR=C3=88NE <hacks@slashdirt.org>
> >> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> >> ---
> >>
> >> v1 -> v2:
> >>      - use %zu and %u in the format string for size_t
> >>            and u32 types (catched by the "kernel test robot").
> >>      - reworded commit message + successfully tested on QCA9880v2
> >>
> >> I placed the nvmem code in front of the current "file" method
> >> (firmware_request). Reason is that this makes it easier for me
> >> to test it. If needed it can be moved to a different place.
> >
> > Looks good to me. Before I apply this, I want to mention to that I have
> > had a long in my deferred queue related two patchsets:
>
>
> > https://patchwork.kernel.org/project/linux-wireless/patch/2020092719251=
5.86-1-ansuelsmth@gmail.com/
> > https://patchwork.kernel.org/project/linux-wireless/patch/2020092719251=
5.86-2-ansuelsmth@gmail.com/
> Oh ok, serves me right for not looking thoroughly googling this first.
> Alban Bedel and Ansuel's work made this nvmem all possible. And indeed,
> the second patch here looks eerie similar.
>
> Do you want to go with his two patches instead? I'll change mine, so it
> just consists of the cal_mode for the older QCA9880v2,QCA9887 and
> add the -EPROBE_DEFER handling. This -EPROBE_DEFER only ever comes up
> with the Meraki gear. This is because Meraki likes putting the MACs-Value=
s
> into SoC-connected AT24 eeproms-chips. Everyone else just have them in a
> proper FLASH partition. Though, this's usually nothing more than adding
> the following line:
>
> if (ret =3D=3D -EPROBER_DEFER)
>         return ret;
>

The 2 patch has to change to use the nvmem api.
The mtd one is present in ath10k-ct and looks to work well on my devices.
At times I also tested one implementation that used nvmem api to fetch cal
data from nvmem using a specific nvmem cell name passed in the dts and it
did work just right.
Also with recent changes to nvmem api the of_platform_device_create and the
pdev check are not needed anymore are the nvmem can find cell also if the
platform is not registered

> > https://patchwork.kernel.org/project/linux-wireless/patch/2020091818110=
4.98-1-ansuelsmth@gmail.com/
> > https://patchwork.kernel.org/project/linux-wireless/patch/2020091818110=
4.98-2-ansuelsmth@gmail.com/
>
> Ansuel's post: https://patchwork.kernel.org/project/linux-wireless/patch/=
20200918181104.98-2-ansuelsmth@gmail.com/#23639361
>  > You are right about nvmem... Problem is that nvmem for mtd is still no=
t
>  > supported. I already sent a patch to fix this in the mtd mailing list =
but
>  > I'm waiting for review...
>  > If that will be accepted, I can convert this patch to use nvmem api.
>
> The nvmem api is there (which makes these two patches obsolete I think).
> Granted: The nvmem can't do all the same cases (From what I know, mtd
> partitions splitters and mtdparts through commandline is being worked on.
> But we always have userspace + firmware_request as a fallback).
>
> Cheers,
> Christian
