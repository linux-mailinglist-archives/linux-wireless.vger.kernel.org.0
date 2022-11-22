Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601F5634A05
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 23:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiKVW2b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 17:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiKVW22 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 17:28:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D799BC90
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 14:28:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l24so10003178edj.8
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 14:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eZAddN1OvrFook69+5yYdfP/WIUWWnERavX+DpxwSRs=;
        b=QKvLa81mge5bWQqA6enHXK3l9GjRMaHVWIlDzSL8A5gZtmFsv2HkwVyACh353hr6so
         Duk2LmQarVGm0O1mZD3cIYMYybDkpC89BpPIQW71yJSZC6J1IaxHHmZd5h5XAbIhMELH
         SFFwLiIfslqsBLw0z94+iBA9sGy/UF31c8M5KxVYES/TlUvtISqfXZqcGvd6kL+W0RQj
         N564U1DvHaq//1+VUUZ38Dss+H8J1/gZTMj8juRRhQ63zQiGlylsDc1QWLZ3T7MKQvAW
         MogLrP4ONYpPmEYON+/clCHeF93Q7RznV1/abBtDlo5g9/e4qcxBV/3hcduTG0PXX73A
         9tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZAddN1OvrFook69+5yYdfP/WIUWWnERavX+DpxwSRs=;
        b=wv8BHSNlJkFc3GAttQiBzvtxrf+GfZyueAtSAJN6sTASfwkE20MsVHP6lb2ItBhsOd
         w74TNLN64FcY7xIjkRFdyvioLMFzFVgOyxV6qX0EfbEoNtFw5mzmuB1kLi5yQo/WggfA
         9nSCOCfxKSHSHmMISJY61MKTGXGvLTSE0oYAJgTZF5Jh4oVgp06rNT8MfyTHDX8yeFKp
         ZY7t4wqaFtZIhvBzZdqPV6SxtWZiRyz/nk/2lVpCAry3w8c4c5RbxgSLpHMwsGg1Kzn5
         4njxutwoVhLf+r9caPOoA+8SpdyVLEj/wC7BxkSJAEvRLFTORn3khV+VN2Fe6ulTI9eQ
         0Inw==
X-Gm-Message-State: ANoB5plTQ3GwCwzeG3As6EYZ6gt3IyKf4gQbutspJIfNyb6Orkr9k/SY
        O8RjUgmiz/6bDDxKM+reiDziNZyM5fonbh4neH1EkskkbJ8=
X-Google-Smtp-Source: AA0mqf4GutYf4zOwxFQILZ5eZJTT1HQvH8rvyKhyl2UhDE4zAL++c5Mj0gwvoMcJLfZXM9R4DE6NtUYrQ33fsnCc1XM=
X-Received: by 2002:a05:6402:b84:b0:461:a89:8654 with SMTP id
 cf4-20020a0564020b8400b004610a898654mr23148121edb.212.1669156079012; Tue, 22
 Nov 2022 14:27:59 -0800 (PST)
MIME-Version: 1.0
References: <CAB3_1NtsSrka20wLocDkR2dz9vrY447+WK2P3hQ1UN9bynGGCg@mail.gmail.com>
In-Reply-To: <CAB3_1NtsSrka20wLocDkR2dz9vrY447+WK2P3hQ1UN9bynGGCg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 22 Nov 2022 23:27:48 +0100
Message-ID: <CAFBinCAvF5FgXRa-Bin6O6e-nua32NSOwsreJQ_EpNt84hZ2QQ@mail.gmail.com>
Subject: Re: Throughput related to RTL8822CS
To:     Nitin Gupta <nitin.gupta981@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Nitin,

On Tue, Nov 15, 2022 at 3:26 PM Nitin Gupta <nitin.gupta981@gmail.com> wrote:
>
> Dear All
>
> I am new and Facing throughput issue for RTL8822CS chipset
> Same kind of issue observed in mail which is addressed by Martin .
Nitin is referring to my comment from [0] where I wrote:
> [...] it's not fast yet, in my tests I got ~6Mbit/s in either direction.

There is no major news on this issue. My first goal is to make it work
upstream, then we can improve performance.

> Please let me know if that patch is good to go for Improving performance
> also I came across below error which frequently coming any idea or hint which direction i need to check
>
> Error :-
> 3.734608] RTW: ERROR sdio_io: bSurpriseRemoved, skip write 0x00041, 1 bytes
> [   33.734609] RTW: ERROR _halmac_sdio_cmd52_write: I/O FAIL!
Nitin, I think the RTL8822CS driver which you are testing was written
by (or for) Realtek. It's an out of tree (meaning:
maintained/developed separately from the Linux kernel).
All of my efforts are for the "upstream" rtw88 driver (meaning: it's
part of the Linux kernel directly). That driver is also written by
Realtek employees but it's a completely different codebase.
Personally I don't know much about this out of tree driver - I'm only
using it to understand the hardware/firmware interface that the driver
communicates with.

If "surprise removed" kicks in you may have some SDIO communication
issues. Have you tried lowering the SDIO bus frequency (on systems
with device-tree: max-frequency property of the SDIO controller)?
Another reason could be some incorrectly set up CD (card detect) line.
Since you haven't mentioned what board and card this is it's
impossible to say for sure.


Best regards,
Martin


[0] https://lore.kernel.org/netdev/20211228211501.468981-1-martin.blumenstingl@googlemail.com/
