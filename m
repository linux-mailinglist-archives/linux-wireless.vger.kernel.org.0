Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC67758CB9A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 17:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbiHHPxf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243808AbiHHPxe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 11:53:34 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 08 Aug 2022 08:53:32 PDT
Received: from wrqvvpzp.outbound-mail.sendgrid.net (wrqvvpzp.outbound-mail.sendgrid.net [149.72.131.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028F115801
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 08:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yatao.info;
        h=from:subject:mime-version:to:content-type:content-transfer-encoding:
        cc;
        s=s1; bh=rCLwSN0k9RLHOy5/DBz4Iu3BT9YHFTAWiUyyhkUm4+U=;
        b=Gc6sL7Xv3NZYHXeTbh+FidOV7WfX4GmYYYYMfZwwoY8K9/yll+O7u+0a9YJOx7JK6YtQ
        beGgqbQWWXtgx6HHBHxQFMzF7Ug6zYKx0MHNWnnH0rGTnA+wa9NuKmfb/fY7hUBdxPnO6c
        z2vazT/K/I9O5yFuBGj+FFhzsotZ17zId/XFiB/bmAdYpIi54q1W9MPhLNWtDlRe3TaNgD
        3HAbANeWfF82KTSBCyazcrXAlmJdZtpBT52P2sHvfQKBNvdcEEWf74EwAz82xYagxE0N3c
        ErItuSkaqd+KD8sLxUx9lb9mTWxcVzUEg96jPpB2nh2zz64lydJKxpHSsf4WeQRw==
Received: by filterdrecv-846bc987b5-hmfk4 with SMTP id filterdrecv-846bc987b5-hmfk4-1-62F1311E-5C
        2022-08-08 15:51:59.06057893 +0000 UTC m=+1540062.830789445
Received: from yatao.info (unknown)
        by geopod-ismtpd-canary-0 (SG)
        with ESMTP id NEoVUy4bSMSBC7wcCKwBDg
        for <linux-wireless@vger.kernel.org>;
        Mon, 08 Aug 2022 15:51:58.555 +0000 (UTC)
Date:   Mon, 08 Aug 2022 15:51:59 +0000 (UTC)
From:   Yatao Li <me@yatao.info>
Subject: Re: BUG: b43: ssb init failed with pcmcia bus
Message-ID: <20220808155156.zwdt52dii4clahxa@yatao-nas>
Mail-Followup-To: Yatao Li <me@yatao.info>, linux-wireless@vger.kernel.org
Mime-Version: 1.0
X-SG-EID: =?us-ascii?Q?9sVaV2=2FMDwE9lvO94Vf6VyCXIQG5ddhQ=2F2QO1blnrCNXBDhbnq=2FI3dlX3m1UPf?=
 =?us-ascii?Q?ZbEFpuDRvkXBmfcokeQae2scSeNavlZEcCvc0BH?=
 =?us-ascii?Q?LYA8ZvaESPFJZNxezYZGEWj2T9HxmRp+tPnAqRO?=
 =?us-ascii?Q?1Jc8RgWfm70VuoYEnuhB1Z343JdHSPCIO6h5tZx?=
 =?us-ascii?Q?S+u7AKStSb4BdNw4RS9=2FE9DEa=2F83r562U37hKBL?=
 =?us-ascii?Q?Onl5rO8wdFVoRL7BAjmElmkAWJBs08TiRXd+=2FS?=
To:     linux-wireless@vger.kernel.org
X-Entity-ID: J7BGEXGUO3C06VaRBW5Rkg==
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/4/22 14:55, Larry Finger wrote:
>On 7/4/22 07:54, 尤晓杰 wrote:
>> 
>> I got 802.11b card debian sid(Linux debian 5.18.0-2-686-pae #1 SMP PREEMPT_DYNAMIC Debian 5.18.5-1 (2022-06-16) i686 GNU/Linux
>> ) reconised it. But ssb could not be reconised
>> dmesg:
>> [ 1268.029113] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
>> [ 1268.029646] pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 21)
>> [ 1268.117186] ssb: Failed to switch to core 0
>> [ 1268.117225] ssb-pcmcia 0.0: Initialization failed (0, -16)
>> [ 1268.117232] ssb-pcmcia: probe of 0.0 failed with error -16
>> allan@debian:~$
>
>That combination of outputs and the -EBUSY (-16) error means that the driver was 
>unable to read or write a configuration variable at SSB_PCMCIA_ADDRESSX, where X 
>is 0, 1, or 2.
>
>There is a possibility that your card is broken. Please post the portion of the 
>output of the command 'sudo lspci -nn -xxx' that describes the b43 device.
>
>Larry
I'm encountering a similar issue. It's a Summit SDC-CF10G CompactFlash
WiFi card. (http://url6924.yatao.info/ls/click?upn=ZzU3A6Y3aWFtn4aD2u-2FBwbEq46EcTw8hKN7GGRjFv-2F1WUxFrRaacpRjX-2BppM38Z1RZWTFfXewuYqW8Nnv564nw-3D-3DR6DP_6pwKHJ8Ph1XTyv7ONZlOBOinZyu77Ix3HWUiu18xV0L3uSyMV6rU6SMAhQ33IJM2wJd2p1qgFX70jtzxE78Bic9U9VM4uaHAGq8Y2z4nXzsBrnCA-2BEJxidxXoTjqSX5JhPdGPz27iBdsFlHRMb6oNfEWDfNzT6lxlDURcfl5OoAzrBro2PfB7LyxzBrY2q3DanhP8kUyZ8w6n8cOIP9lLaudyfzwvgAIpY9R5yIIG-2FE-3D
`pccardctl info` gives:
```
PRODID_1="SummitDC"
PRODID_2="802.11g SC CF"
PRODID_3="4.0"
PRODID_4=""
MANFID=02d0,0448
FUNCID=6
```
MANFID matches lookup table in the code.
The host is a Sharp SL-C3100 running Linux alarm 5.4.193, bridging from
`pxa2xx-pcmcia`.

I did some simple manual tracing, and the problem happens early:
```
ssb_host_pcmcia_probe (Initialization failed res=0,err=-EBUSY)
  `->...(res=0)
  `->ssb_bus_pcmciabus_register (err=-EBUSY)
    `->ssb_bus_register
      `->ssb_bus_scan
        `->ssb_pcmcia_switch_coreidx (matching errmsg)
          `->ssb_pcmcia_cfg_write (maybe)
          `->ssb_pcmcia_cfg_read (maybe)
```

Any suggestions?

Thanks,
Yatao
