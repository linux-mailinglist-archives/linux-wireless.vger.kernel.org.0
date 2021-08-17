Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5DF3EE144
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 02:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhHQAi3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 20:38:29 -0400
Received: from mail001.nap.gsic.titech.ac.jp ([131.112.13.101]:42312 "HELO
        mail001.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S237328AbhHQAh5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 20:37:57 -0400
Received: from 172.22.40.203
        by mail001.nap.gsic.titech.ac.jp with Mail2000 ESMTP Server V7.00(21081:0:AUTH_RELAY)
        (envelope-from <matsumoto.r.aa@m.titech.ac.jp>); Tue, 17 Aug 2021 09:37:04 +0900 (JST)
Received: from mail001.nap.gsic.titech.ac.jp (mail001.nap.gsic.titech.ac.jp [131.112.13.101])
        by drweb06.nap.gsic.titech.ac.jp (Postfix) with SMTP id 5BF789665;
        Tue, 17 Aug 2021 09:37:04 +0900 (JST)
Received: from 153.240.174.134
        by mail001.nap.gsic.titech.ac.jp with Mail2000 ESMTPA Server V7.00(21083:1:AUTH_LOGIN)
        (envelope-from <matsumoto.r.aa@m.titech.ac.jp>); Tue, 17 Aug 2021 09:37:03 +0900 (JST)
Date:   Tue, 17 Aug 2021 09:36:58 +0900 (JST)
Message-Id: <20210817.093658.33467107987117119.ryutaroh@ict.e.titech.ac.jp>
To:     arend.vanspriel@broadcom.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com
Subject: Re: 5.10.58 UBSAN from brcmf_sdio_dpc+0xa50/0x128c [brcmfmac]
From:   Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
In-Reply-To: <85b31c5a-eb4a-48a0-ad94-e46db00af016@broadcom.com>
References: <20210816.084210.1700916388797835755.ryutaroh@ict.e.titech.ac.jp>
        <85b31c5a-eb4a-48a0-ad94-e46db00af016@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend, thank you for paying attention to this.

> Line 2016 in skbuff.h is inline function __skb_queue_before() and as
> far as I can tell brcmfmac is not using that direct or indirect. Maybe
> I am reading the line info incorrectly?

I am unsure of it. On the other hand, I have also seen somewhat similar
UBSAN from a header file "include/net/flow.h" as reported at
https://lore.kernel.org/netdev/20210813.081908.1574714532738245424.ryutaroh@ict.e.titech.ac.jp/

All UBSANs that I have seen come from *.h compiled with clang...

> Would you be able to provide information as to what line
> brcmf_sdio_dpc+0xa50 refers to.

I'd like to do, but I do not know how to let kernel UBSAN include a line number,
though I know it with user-space applications...

Best regards, Ryutaroh

From: Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: 5.10.58 UBSAN from brcmf_sdio_dpc+0xa50/0x128c [brcmfmac]
Date: Mon, 16 Aug 2021 11:54:31 +0200

> On 8/16/2021 1:42 AM, Ryutaroh Matsumoto wrote:
>> Dear Maintainers of the
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac driver,
>> I found the following UBSAN error in kernel 5.10.58 compiled with
>> CLang 12.0.1
>> with integrated assembler (make LLVM=1 LLVM_IAS=1).
>> It always happens when iwd starts an access point, where
>> /etc/iwd/main.conf
>> looks as follows:
>> [General]
>> UseDefaultInterface=true
>> DisableANQP=false
>> I do not observe the following error if
>> * kernel is compiled with gcc 10, or
>> * kernel version is 5.13.9 or 5.14rc5.
>> The reported UBSAN error is only seen with 5.10 series compiled with
>> CLang 12.
>> UBSAN looks as follows. The hardware is Raspberry Pi 4B with 8GB RAM.
>> Aug 16 08:11:21 raspi4b-router systemd[1]: systemd-rfkill.service:
>> Succeeded.
>> Aug 16 08:11:21 raspi4b-router kernel: IPv6: ADDRCONF(NETDEV_CHANGE):
>> wlan0: link becomes ready
>> Aug 16 08:11:21 raspi4b-router systemd[1]:
>> iwd_start_ap@Yamashita_guest.service: Succeeded.
>> Aug 16 08:11:21 raspi4b-router systemd[1]: Finished iwd starting
>> Yamashita_guest access point.
>> Aug 16 08:11:21 raspi4b-router kernel:
>> ================================================================================
>> Aug 16 08:11:21 raspi4b-router kernel: UBSAN: object-size-mismatch in
>> ./include/linux/skbuff.h:2016:28
> 
> Line 2016 in skbuff.h is inline function __skb_queue_before() and as
> far as I can tell brcmfmac is not using that direct or indirect. Maybe
> I am reading the line info incorrectly?
> 
>> Aug 16 08:11:21 raspi4b-router kernel: member access within address
>> 000000002d0b610c with insufficient space
>> Aug 16 08:11:21 raspi4b-router kernel: for an object of type 'struct
>> sk_buff'
>> Aug 16 08:11:21 raspi4b-router kernel: CPU: 1 PID: 295 Comm:
>> kworker/u8:3 Tainted: G C 5.10.58-clang12a #1
>> Aug 16 08:11:21 raspi4b-router kernel: Hardware name: Raspberry Pi 4
>> Model B Rev 1.4 (DT)
>> Aug 16 08:11:21 raspi4b-router kernel: Workqueue: brcmf_wq/mmc0:0001:1
>> brcmf_sdio_dataworker [brcmfmac]
>> Aug 16 08:11:21 raspi4b-router kernel: Call trace:
>> Aug 16 08:11:21 raspi4b-router kernel:  dump_backtrace+0x0/0x1e4
>> Aug 16 08:11:21 raspi4b-router kernel:  show_stack+0x18/0x24
>> Aug 16 08:11:21 raspi4b-router kernel:  dump_stack+0xac/0x104
>> Aug 16 08:11:21 raspi4b-router kernel:
>> ubsan_type_mismatch_common+0x198/0x298
>> Aug 16 08:11:21 raspi4b-router kernel:
>> __ubsan_handle_type_mismatch_v1+0x40/0x50
>> Aug 16 08:11:21 raspi4b-router kernel: brcmf_sdio_dpc+0xa50/0x128c
>> [brcmfmac]
> 
> Would you be able to provide information as to what line
> brcmf_sdio_dpc+0xa50 refers to.
> 
> Regards,
> Arend
