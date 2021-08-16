Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8203B3ED155
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 11:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhHPJzP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 05:55:15 -0400
Received: from lpdvacalvio01.broadcom.com ([192.19.166.228]:44100 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235336AbhHPJzP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 05:55:15 -0400
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8450180C2;
        Mon, 16 Aug 2021 02:54:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8450180C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1629107683;
        bh=Aj2VaZcpOH4Bg0zUIiSMcLLwUhPDKPLUYkCL/ibAG5s=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=cL4DgYMfLhxcHzkRuddbo/o/Xqy4EbL0iokgieCFiWE9Cf+MIm5UpDPzI3k5TqR+K
         rBHLZStO1E5WDYf1NvxiQjMlFiwtcLMuCX1soEJKSqK3TtZ+FKVE+ZGcWdaPVmT9Fl
         Az6z/sRGjB6LtIqnEMUmVkLVKgW6l9bqaf22VC3w=
Received: from [10.176.51.53] (d581793.dhcp.broadcom.net [10.176.51.53])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id A27981874BD;
        Mon, 16 Aug 2021 02:54:41 -0700 (PDT)
Subject: Re: 5.10.58 UBSAN from brcmf_sdio_dpc+0xa50/0x128c [brcmfmac]
To:     Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        linux-rpi-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, chi-hsien.lin@infineon.com,
        wright.feng@infineon.com, chung-hsien.hsu@infineon.com
References: <20210816.084210.1700916388797835755.ryutaroh@ict.e.titech.ac.jp>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <85b31c5a-eb4a-48a0-ad94-e46db00af016@broadcom.com>
Date:   Mon, 16 Aug 2021 11:54:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210816.084210.1700916388797835755.ryutaroh@ict.e.titech.ac.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/16/2021 1:42 AM, Ryutaroh Matsumoto wrote:
> Dear Maintainers of the drivers/net/wireless/broadcom/brcm80211/brcmfmac driver,
> 
> I found the following UBSAN error in kernel 5.10.58 compiled with CLang 12.0.1
> with integrated assembler (make LLVM=1 LLVM_IAS=1).
> It always happens when iwd starts an access point, where /etc/iwd/main.conf
> looks as follows:
> [General]
> UseDefaultInterface=true
> DisableANQP=false
> 
> I do not observe the following error if
> * kernel is compiled with gcc 10, or
> * kernel version is 5.13.9 or 5.14rc5.
> 
> The reported UBSAN error is only seen with 5.10 series compiled with CLang 12.
> UBSAN looks as follows. The hardware is Raspberry Pi 4B with 8GB RAM.
> 
> Aug 16 08:11:21 raspi4b-router systemd[1]: systemd-rfkill.service: Succeeded.
> Aug 16 08:11:21 raspi4b-router kernel: IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
> Aug 16 08:11:21 raspi4b-router systemd[1]: iwd_start_ap@Yamashita_guest.service: Succeeded.
> Aug 16 08:11:21 raspi4b-router systemd[1]: Finished iwd starting Yamashita_guest access point.
> Aug 16 08:11:21 raspi4b-router kernel: ================================================================================
> Aug 16 08:11:21 raspi4b-router kernel: UBSAN: object-size-mismatch in ./include/linux/skbuff.h:2016:28

Line 2016 in skbuff.h is inline function __skb_queue_before() and as far 
as I can tell brcmfmac is not using that direct or indirect. Maybe I am 
reading the line info incorrectly?

> Aug 16 08:11:21 raspi4b-router kernel: member access within address 000000002d0b610c with insufficient space
> Aug 16 08:11:21 raspi4b-router kernel: for an object of type 'struct sk_buff'
> Aug 16 08:11:21 raspi4b-router kernel: CPU: 1 PID: 295 Comm: kworker/u8:3 Tainted: G         C        5.10.58-clang12a #1
> Aug 16 08:11:21 raspi4b-router kernel: Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> Aug 16 08:11:21 raspi4b-router kernel: Workqueue: brcmf_wq/mmc0:0001:1 brcmf_sdio_dataworker [brcmfmac]
> Aug 16 08:11:21 raspi4b-router kernel: Call trace:
> Aug 16 08:11:21 raspi4b-router kernel:  dump_backtrace+0x0/0x1e4
> Aug 16 08:11:21 raspi4b-router kernel:  show_stack+0x18/0x24
> Aug 16 08:11:21 raspi4b-router kernel:  dump_stack+0xac/0x104
> Aug 16 08:11:21 raspi4b-router kernel:  ubsan_type_mismatch_common+0x198/0x298
> Aug 16 08:11:21 raspi4b-router kernel:  __ubsan_handle_type_mismatch_v1+0x40/0x50
> Aug 16 08:11:21 raspi4b-router kernel:  brcmf_sdio_dpc+0xa50/0x128c [brcmfmac]

Would you be able to provide information as to what line 
brcmf_sdio_dpc+0xa50 refers to.

Regards,
Arend
