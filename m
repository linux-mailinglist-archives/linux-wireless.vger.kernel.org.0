Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E8658D602
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 11:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiHIJKU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 05:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiHIJKS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 05:10:18 -0400
X-Greylist: delayed 55391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Aug 2022 02:10:15 PDT
Received: from wrqvxtdp.outbound-mail.sendgrid.net (wrqvxtdp.outbound-mail.sendgrid.net [149.72.167.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94EA3A8
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yatao.info;
        h=from:subject:references:mime-version:content-type:
        content-transfer-encoding:in-reply-to:to:cc;
        s=s1; bh=3JBw3ucJkCMu8782p7ls+skUc8YazM9g6OeSecDljqU=;
        b=v4oZUETT6nEUO2WPaKqf4YGcyjStC84e+kmfou6XySNHh/9hghE29maftkZcTokmA2Zh
        gJADJ1EL30vqtmD0zfx5r1HRCm0X281QXE9u7r2XGvCdXHX6pk5qQ4EwV46mua04GR8FZz
        sCBMnwaPFlh6a0Qfpkl0eQdz3MflA+ky+6aAHQar6xye+Iu0JcUp5DSKHfZckjjGKc/gFn
        4ET7/WQ4zCU0FmBi1f81Rm0BDJFWyGr5pn9zyj88IHu/lup6BPamu0D7rz1VKIqYs95Cap
        V4TFQn5DpBCut3ZJmwVoX6/MgErGFCP88I2faF06xzED237I6jSUtK2kJHyfmc4w==
Received: by filterdrecv-66b95c5ffd-lw6jz with SMTP id filterdrecv-66b95c5ffd-lw6jz-1-62F22476-1F
        2022-08-09 09:10:14.511049712 +0000 UTC m=+1602325.603617971
Received: from yatao.info (unknown)
        by geopod-ismtpd-1-0 (SG) with ESMTP
        id CK1EfkZsRZSP7xwAOTV1LQ
        for <linux-wireless@vger.kernel.org>;
        Tue, 09 Aug 2022 09:10:13.568 +0000 (UTC)
Date:   Tue, 09 Aug 2022 09:10:14 +0000 (UTC)
From:   Yatao Li <me@yatao.info>
Subject: Re: BUG: b43: ssb init failed with pcmcia bus
Message-ID: <20220809091010.wuiyrxou7qkhfmcr@yatao-nas>
Mail-Followup-To: Yatao Li <me@yatao.info>, linux-wireless@vger.kernel.org
References: <20220808155156.zwdt52dii4clahxa@yatao-nas>
 <YvFME534TnPt5Nwn@yatao-nas>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YvFME534TnPt5Nwn@yatao-nas>
X-SG-EID: =?us-ascii?Q?9sVaV2=2FMDwE9lvO94Vf6VyCXIQG5ddhQ=2F2QO1blnrCNXBDhbnq=2FI3dlX3m1UPf?=
 =?us-ascii?Q?ZbsI3uee+k9fjYOLqYy+tgpRCukvqaBaxy1CAnq?=
 =?us-ascii?Q?qnFRL5jrP=2FJYqwlevtQPv6PmTfUx70EzVP2QzVP?=
 =?us-ascii?Q?APgEdD2HaSdeUEn54MUL4uohvvZAU6E35874Exa?=
 =?us-ascii?Q?gAKb9yuzErXFyqR8bruj8YMRBh+D2R+b+ytYE17?=
 =?us-ascii?Q?VmsdQthwqXfyFofdaeP9RcLjGSpbTZ5IxZ=2F39a?=
To:     linux-wireless@vger.kernel.org
X-Entity-ID: J7BGEXGUO3C06VaRBW5Rkg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 08, 2022 at 05:47:03PM +0000, Yatao Li wrote:
> On Mon, Aug 08, 2022 at 03:51:59PM +0000, Yatao Li wrote:
> > On 7/4/22 14:55, Larry Finger wrote:
> > >On 7/4/22 07:54, 尤晓杰 wrote:
> > >> 
> > >> I got 802.11b card debian sid(Linux debian 5.18.0-2-686-pae #1 SMP PREEMPT_DYNAMIC Debian 5.18.5-1 (2022-06-16) i686 GNU/Linux
> > >> ) reconised it. But ssb could not be reconised
> > >> dmesg:
> > >> [ 1268.029113] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
> > >> [ 1268.029646] pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 21)
> > >> [ 1268.117186] ssb: Failed to switch to core 0
> > >> [ 1268.117225] ssb-pcmcia 0.0: Initialization failed (0, -16)
> > >> [ 1268.117232] ssb-pcmcia: probe of 0.0 failed with error -16
> > >> allan@debian:~$
> > >
> > >That combination of outputs and the -EBUSY (-16) error means that the driver was 
> > >unable to read or write a configuration variable at SSB_PCMCIA_ADDRESSX, where X 
> > >is 0, 1, or 2.
> > >
> > >There is a possibility that your card is broken. Please post the portion of the 
> > >output of the command 'sudo lspci -nn -xxx' that describes the b43 device.
> > >
> > >Larry
> > I'm encountering a similar issue. It's a Summit SDC-CF10G CompactFlash
> > WiFi card. (http://url6924.yatao.info/ls/click?upn=ma0iYQYPVJ6oQbSqYo5zhoh-2BS-2F7coOnMI4oVTd5l-2FkvlfLQmfQTwoKyrvqxh-2Fa6hp0qWFyGc7QP5gJnRZoRe42IbDvi-2FnhetkVt4QC8kXm6Vd4pN7tzmSSSlk8a4EQOpxYGxsYE8m3phXHkNXSx-2BL1P7et4eGobwIglMZszgDL07YOJq5EyntcXBv4-2BYUGIRUi2MrnJ4p662SQrx-2FtoX79hg6YXrirwpuj8m7-2Bsw5zTnr5xfKfj-2FrBsCgKtU-2BX5zQGws18FXFFs-2BTY6Zpr3HMEu3nvGCoU6e00DloQAajTPrHNuzxDgQ6NJRayVXOLw45ovVbXhhy-2BpjlpxNHbcxzfvxW1Pq3WJzmMFvXmA95canVXVWlIboFEv3QGUeCfCZIr14kSNob-2FsqM9faSY5-2BCPp8D8-2BR-2B9L1wCXvYOfsQ-2BAUOryDFHHxi6alF3RFgyx4MfUBwJkLXQE-2F1vIPLLWDVcO-2F4gK2OYmAKZlG0kIJuMBE9P2u-2BEKgCaLSZzw0IdO72gvK0BCwN7vs5ydtLuoDkvWpKb878bj1UqrOHEwbe51qWt9Pie-2Bq1fEHVxKGwIJEnJEm7pvxhC4FfB-2BD8-2FdMJytEg-2B9NLqoEJ76bN7ekikfTJBnSpSQMfgSVCQg-2FRN86esALmiSAsmKqXFwBVdohuY0dU-2FvaCT63S-2BDUbKL6SQArofUeV51Z2LorARLdtXk3hYGQI8CD7IpXwuah8ZGEY2CyWQ3acK5u8Ws8jqGiUxad73xePy-2BbQRrdKXIx-2FqFohi8LAU2455aH9g7lgkEeWJmfk-2FotLUlRwdQE5XKwztoPjO5QOsjV-2BkVRyrNIopAS-2Btc63zoSnZ7b8mjwS3l29hTdnYi-2Bq1R7P7u7eOqz2zV
 ibhmjkNCElsZdDXoTrGTFwXBMFRriEoorUFCTHNzx-2BWFXf29Uzr-2B9xEvrQ7kvdGsN5Se4Gnf8MowYG3blC2huHWiKi8horsmbayI-2F0UuYQ-2B-2FeVd5wC40aK0A7NO1wnIoTuqsIRZOaIg3JrwU8GXaXxtDiepynOs5xAUs1bgQBDS7vs4DRkeKuofkBkoFLMFF9ivfODWbY6R4nht8K2yXUJR3yfJWiXe69Y0AdIEmD6Leg9tgTZG-2BULALY4FMOUT0OBGqXvdja-2F3N4qoYGUJeHA2ayb74zTH6Juh-2FeEeZlTA58lQR4ZbVb755hsqEiGbmrv7gKeg95KmjQ7eCBoyKrT03F_6pwKHJ8Ph1XTyv7ONZlOBOinZyu77Ix3HWUiu18xV0If4k6Q4ZTva5JRL4WWfCqxDEYEP8QwcT5eeLVBRvPqM4FDc6xgxmltjJUyokgcct6ZYebNrUqbp5Pag0tggdfzNg3CELt0sXd4BYKLxWLZ-2Bl5l-2B7apmxqUadDIVLVovFqW2Slle-2FSqB-2BK4nZ35eWaRIj4DysDCuXb1iS112r8iGR2aydGCMSbf8sC-2BjAZlIiQ-3D
> > `pccardctl info` gives:
> > ```
> > PRODID_1="SummitDC"
> > PRODID_2="802.11g SC CF"
> > PRODID_3="4.0"
> > PRODID_4=""
> > MANFID=02d0,0448
> > FUNCID=6
> > ```
> > MANFID matches lookup table in the code.
> > The host is a Sharp SL-C3100 running Linux alarm 5.4.193, bridging from
> > `pxa2xx-pcmcia`.
> > 
> > I did some simple manual tracing, and the problem happens early:
> > ```
> > ssb_host_pcmcia_probe (Initialization failed res=0,err=-EBUSY)
> >   `->...(res=0)
> >   `->ssb_bus_pcmciabus_register (err=-EBUSY)
> >     `->ssb_bus_register
> >       `->ssb_bus_scan
> >         `->ssb_pcmcia_switch_coreidx (matching errmsg)
> >           `->ssb_pcmcia_cfg_write (maybe)
> >           `->ssb_pcmcia_cfg_read (maybe)
> > ```
> > 
> > Any suggestions?
> > 
> > Thanks,
> > Yatao
> Quick update:
> `echo -n 'file cistpl.c +p' > <debug_fs>/dynamic_debug/control`, then
> `dmesg`. This kernel is configured with very small kmsg buffer... I
> could only capture the last portion of the commands:
> 
> ```
> pcmcia_read_cis_mem(1, 0xe3, 2)
>   0x80 0x09 0x00 0x00 ...
> pcmcia_read_cis_mem(1, 0xee, 2)
>   0xff 0xff 0x00 0x00 ...
> pcmcia_read_cis_mem(0, 0x0, 5)
>   0x00 0x00 0x00 0x00 ...
> pcmcia_read_cis_mem(0, 0x0, 5)
>   0x00 0x00 0x00 0x00 ...
> pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 217)
> pcmcia_read_cis_mem(1, 0x4d, 2)
>   0x06 0x00 0x48 0x04 // is that FUNCID and MANUFID?
> pcmcia_read_cis_mem(1, 0x12, 30)
>   0x08 0x00 0x53 0x75 ...
> pcmcia_read_cis_mem(1, 0xb1, 5)
>   0x01 0x01 0x00 0x07 ...
> pcmcia_write_cis_mem(1, 0x383, 1)
> pcmcia_write_cis_mem(1, 0x380, 1)
> <systemd-journald warning that /dev/kmsg is overrun...>
> pcmcia_write_cis_mem(1, 0x381, 1)
> pcmcia_write_cis_mem(1, 0x397, 1)
> pcmcia_write_cis_mem(1, 0x398, 1)
> pcmcia_write_cis_mem(1, 0x399, 1)
> pcmcia_read_cis_mem(1, 0x397, 1)
> !! attempt to read CIS mem at addr 0x397 (CISTPL_MAX_CIS_SIZE is 0x200)
>   return -1;
> ```
> 
> Not knowing what's what here, at least I see there's some inconsistency.
> - write is okay but read fails on bound check
> - the ssb offsets are u8 and values like 0x397 are (pcmcia base + offset), 
>   but the bound check is not aware of the base address, right?
Added some debug prints to extract pcmcia device config base and it's
0x700. It matches the debug logs that read/write 0x397-0x399 for
SSB_PCMCIA_ADDRESS{0,1,2}. Actual pcmcia address will be (config_base +
offset) >> 1 and reads will always fail the bound check.

Digging deeper I found that config_base is a property of the card and
pulled by pcmcia_device_probe. So the problem is clear now -- the card
says the config base is at 0x700, resulting in ssb module accessing
addresses like (0x700 + SSB_PCMCIA_ADDRESS0) >> 1, but then fails the
CISTPL_MAX_CIS_SIZE (0x200) check. Commenting out the check result in
the wifi module working correctly.
