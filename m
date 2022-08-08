Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D6A58CD05
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 19:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbiHHRtm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 13:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244176AbiHHRtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 13:49:19 -0400
Received: from wrqvvpks.outbound-mail.sendgrid.net (wrqvvpks.outbound-mail.sendgrid.net [149.72.131.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42615FFA
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yatao.info;
        h=from:subject:references:mime-version:content-type:
        content-transfer-encoding:in-reply-to:to:cc;
        s=s1; bh=K+BHjIFCDLduXKqQxdKfnAuk4NQNvddnJuCTEbZ80IE=;
        b=p6RXrKN/w0Tg69SzGgoW6OFgXcbkENNHC5ASJ/oFQf/DKmCIRs3cuL5ubrJkua3lGDSH
        VOHXYSC3AiFnHBg2U74v2U4Q2Sle8gnzMnKhwN0R5rFXVA3fCrcca/ZiFZ4DdHmTeha1Mm
        yvOMp+X22v2TZVH23bAfow/UXWdfoXu19o7REpvdsVcY9qiI7EmQ2jZoUgLZco/6cAkkin
        Hf0RawEBLuYw3NFyo7nFMOnLEWFAjfForPK4BcF9cW2tA7yUfocVUIUIdQ5obTcGgI4r9T
        g1tx+2HAXQcR+MxBNQDfPEocxCiOQxblmLwFvimQw1tAXyZpQIA0jbYzLnzqLKqQ==
Received: by filterdrecv-68b46c5bd4-krp75 with SMTP id filterdrecv-68b46c5bd4-krp75-1-62F14C17-12
        2022-08-08 17:47:03.2471494 +0000 UTC m=+1546885.803190513
Received: from yatao.info (unknown)
        by geopod-ismtpd-2-0 (SG) with ESMTP
        id MfGHT_oyTg6Y9SFvCIGuGg
        for <linux-wireless@vger.kernel.org>;
        Mon, 08 Aug 2022 17:47:02.729 +0000 (UTC)
Date:   Mon, 08 Aug 2022 17:47:03 +0000 (UTC)
From:   Yatao Li <me@yatao.info>
Subject: Re: BUG: b43: ssb init failed with pcmcia bus
Message-ID: <YvFME534TnPt5Nwn@yatao-nas>
Mail-Followup-To: Yatao Li <me@yatao.info>, linux-wireless@vger.kernel.org
References: <20220808155156.zwdt52dii4clahxa@yatao-nas>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220808155156.zwdt52dii4clahxa@yatao-nas>
X-SG-EID: =?us-ascii?Q?9sVaV2=2FMDwE9lvO94Vf6VyCXIQG5ddhQ=2F2QO1blnrCNXBDhbnq=2FI3dlX3m1UPf?=
 =?us-ascii?Q?ZbsyvpgCH+mYBI7kqFc3xY3I84bU198efrI5lh3?=
 =?us-ascii?Q?5zYAiOKTMeI=2F7s10KP6wGwe4Dgg1U=2Fm2mUfWEX7?=
 =?us-ascii?Q?VkbM2aIZYmwPldzmFMMeSKSLrPl+m5HyJdd1i+2?=
 =?us-ascii?Q?shn+21ahQaSikNamv0HW8r6d9VRp=2Fm06SzKAujO?=
 =?us-ascii?Q?yjHL7RE83EqwqncgLbl+Dsrb9Hei=2FcG2iG6YVA?=
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

On Mon, Aug 08, 2022 at 03:51:59PM +0000, Yatao Li wrote:
> On 7/4/22 14:55, Larry Finger wrote:
> >On 7/4/22 07:54, 尤晓杰 wrote:
> >> 
> >> I got 802.11b card debian sid(Linux debian 5.18.0-2-686-pae #1 SMP PREEMPT_DYNAMIC Debian 5.18.5-1 (2022-06-16) i686 GNU/Linux
> >> ) reconised it. But ssb could not be reconised
> >> dmesg:
> >> [ 1268.029113] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
> >> [ 1268.029646] pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 21)
> >> [ 1268.117186] ssb: Failed to switch to core 0
> >> [ 1268.117225] ssb-pcmcia 0.0: Initialization failed (0, -16)
> >> [ 1268.117232] ssb-pcmcia: probe of 0.0 failed with error -16
> >> allan@debian:~$
> >
> >That combination of outputs and the -EBUSY (-16) error means that the driver was 
> >unable to read or write a configuration variable at SSB_PCMCIA_ADDRESSX, where X 
> >is 0, 1, or 2.
> >
> >There is a possibility that your card is broken. Please post the portion of the 
> >output of the command 'sudo lspci -nn -xxx' that describes the b43 device.
> >
> >Larry
> I'm encountering a similar issue. It's a Summit SDC-CF10G CompactFlash
> WiFi card. (http://url6924.yatao.info/ls/click?upn=ma0iYQYPVJ6oQbSqYo5zhoh-2BS-2F7coOnMI4oVTd5l-2FkvlfLQmfQTwoKyrvqxh-2Fa6hQCJzO-2Bk-2FfGFyGP2VHkAwNfcLj2Uf-2FkslGABFBIZsFzDiWpFjj73tFaRG7z4f8AzQyB-2FHvi-2FgvoL6pOJ-2Bj0Ibt35vlG-2FvzkI-2FnzzX2l38erhdl-2BcHVatpNK4kbxqoQkUEQtL4uV-2BonheissjTzTWwWO6vv9MJ-2BULOZHBke875iEWHGWYkxAugmix-2FDjUL5cyExLYeaX61mO-2BF0sj0J7N4IuVoegI9Pdts05ydxdTJ-2BRRKhjMzWEaRS0-2FhPWASeJTIqLTPvwBInxqZJrvnKNPfJoJymfrmPZ8wiRitFRQe76F-2B9ZYx8LGOgr2Fc6NndLGjGq-2BuTU60SYRjH3PjmIscozpD-2BgO7-2BTQ5WUTtXxrMo3UYcJuBNa55Fw2v8MfMpKS7Uc1pVpSGYSG-2BEeBc-2BJ-2FCt-2Fniq5sfak1R90l6kxpjL3v7fu1L-2Fedv0uN5tEUHLIuIYtTAMJ-2FVZscNLySCiTp5Ow-3D-3Dc3mA_6pwKHJ8Ph1XTyv7ONZlOBOinZyu77Ix3HWUiu18xV0J6a-2Fno9WCbgvjfhwwVXVJdL7p2b9BC0WAvGVOJxbD6-2FIi5t5W2Cb1NAb-2F3wo3hIj7fSUI6G8S0gYfDJ3DUri5FXlaoND6AMe38UJ-2B1vGBpdxByA5WoYAL4dqP1cc6hP-2F4jBwr5AmCkE5qGmyNLHVA1clpYkY3IdbHiLK90MowHjMtMnbw65qhZZSnFXcyaBOU-3D
> `pccardctl info` gives:
> ```
> PRODID_1="SummitDC"
> PRODID_2="802.11g SC CF"
> PRODID_3="4.0"
> PRODID_4=""
> MANFID=02d0,0448
> FUNCID=6
> ```
> MANFID matches lookup table in the code.
> The host is a Sharp SL-C3100 running Linux alarm 5.4.193, bridging from
> `pxa2xx-pcmcia`.
> 
> I did some simple manual tracing, and the problem happens early:
> ```
> ssb_host_pcmcia_probe (Initialization failed res=0,err=-EBUSY)
>   `->...(res=0)
>   `->ssb_bus_pcmciabus_register (err=-EBUSY)
>     `->ssb_bus_register
>       `->ssb_bus_scan
>         `->ssb_pcmcia_switch_coreidx (matching errmsg)
>           `->ssb_pcmcia_cfg_write (maybe)
>           `->ssb_pcmcia_cfg_read (maybe)
> ```
> 
> Any suggestions?
> 
> Thanks,
> Yatao
Quick update:
`echo -n 'file cistpl.c +p' > <debug_fs>/dynamic_debug/control`, then
`dmesg`. This kernel is configured with very small kmsg buffer... I
could only capture the last portion of the commands:

```
pcmcia_read_cis_mem(1, 0xe3, 2)
  0x80 0x09 0x00 0x00 ...
pcmcia_read_cis_mem(1, 0xee, 2)
  0xff 0xff 0x00 0x00 ...
pcmcia_read_cis_mem(0, 0x0, 5)
  0x00 0x00 0x00 0x00 ...
pcmcia_read_cis_mem(0, 0x0, 5)
  0x00 0x00 0x00 0x00 ...
pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 217)
pcmcia_read_cis_mem(1, 0x4d, 2)
  0x06 0x00 0x48 0x04 // is that FUNCID and MANUFID?
pcmcia_read_cis_mem(1, 0x12, 30)
  0x08 0x00 0x53 0x75 ...
pcmcia_read_cis_mem(1, 0xb1, 5)
  0x01 0x01 0x00 0x07 ...
pcmcia_write_cis_mem(1, 0x383, 1)
pcmcia_write_cis_mem(1, 0x380, 1)
<systemd-journald warning that /dev/kmsg is overrun...>
pcmcia_write_cis_mem(1, 0x381, 1)
pcmcia_write_cis_mem(1, 0x397, 1)
pcmcia_write_cis_mem(1, 0x398, 1)
pcmcia_write_cis_mem(1, 0x399, 1)
pcmcia_read_cis_mem(1, 0x397, 1)
!! attempt to read CIS mem at addr 0x397 (CISTPL_MAX_CIS_SIZE is 0x200)
  return -1;
```

Not knowing what's what here, at least I see there's some inconsistency.
- write is okay but read fails on bound check
- the ssb offsets are u8 and values like 0x397 are (pcmcia base + offset), 
  but the bound check is not aware of the base address, right?
