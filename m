Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB09346A67F
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Dec 2021 21:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348844AbhLFUGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 15:06:39 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:34482 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348859AbhLFUGg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 15:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1638820985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ShJOuVlPh6WvmEGR3QsvxvrZtNQJG70RhQxx/8Bcbj4=;
        b=jbQKxw9jFTmZb5TAudLPRqDBu5ByxJ74j5WA29ZDULCK5TGfS6EiIbrgdliGjufx4s0mq+
        x8bAcu4xF9ZH2MMPxXFqxomzVSXXoc4FuWpx181/0+2fMPt/j6EgsUFEB1Nb4V4dbvjFhS
        5gB/ITr18/TjaL1We/71UDRpiK6D5Do=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
Date:   Mon, 06 Dec 2021 21:03:02 +0100
Message-ID: <7286726.fyvdfvlfLW@ripper>
In-Reply-To: <71ee85b5-8d8c-c6e5-20a2-d225800de2ba@quicinc.com>
References: <20211129101309.2931-1-quic_wgong@quicinc.com> <7418334.kqliQQpNxi@ripper> <71ee85b5-8d8c-c6e5-20a2-d225800de2ba@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1776693.pgV9giMVx1"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1776693.pgV9giMVx1
Content-Type: multipart/mixed; boundary="nextPart1643539.SFto10UAbY"; protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org, Wen Gong <quic_wgong@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
Date: Mon, 06 Dec 2021 21:03:02 +0100
Message-ID: <7286726.fyvdfvlfLW@ripper>
In-Reply-To: <71ee85b5-8d8c-c6e5-20a2-d225800de2ba@quicinc.com>
References: <20211129101309.2931-1-quic_wgong@quicinc.com> <7418334.kqliQQpNxi@ripper> <71ee85b5-8d8c-c6e5-20a2-d225800de2ba@quicinc.com>

This is a multi-part message in MIME format.

--nextPart1643539.SFto10UAbY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 6 December 2021 08:10:40 CET Wen Gong wrote:
> > On Monday, 6 December 2021 04:29:39 CET Wen Gong wrote:
> > [...]
> >> I did test in my setup, not see the crash.
> >>
> >> I am afraid you also need this patch("ath11k: change to use dynamic
> >> memory for channel list of scan",
> >>
> >> https://patchwork.kernel.org/project/linux-wireless/patch/20211129110939.15711-1-quic_wgong@quicinc.com
> >> )
> >>
> >> Could you apply this patch and try again?
> > Tried it and I see the same problem.
> Could you tell what is your test steps?

Start kernel with commit a93789ae541c ("ath11k: Avoid NULL ptr 
access during mgmt tx cleanup") + patches:

* ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
* ath11k: change to use dynamic memory for channel list of scan

You can find the config in the first mail. But I have now enabled KASAN inline 
to hopefully create some better error messages.

The firmware + board data (see mail "ath11k: incorrect board_id retrieval") 
was prepared like this:

   git clone https://github.com/kvalo/ath11k-firmware /root/ath11k-firmware
   mkdir -p /lib/firmware/ath11k/WCN6855/hw2.0/
   cp /root/ath11k-firmware/WCN6855/hw2.0/*.bin /lib/firmware/ath11k/WCN6855/hw2.0/
   cp /root/ath11k-firmware/WCN6855/hw2.0/1.1/WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1/*.bin /lib/firmware/ath11k/WCN6855/hw2.0/

   git clone https://github.com/qca/qca-swiss-army-knife /root/qca-swiss-army-knife
   apt install python2
   python2 /root/qca-swiss-army-knife/tools/scripts/ath11k/ath11k-bdencoder  -e /lib/firmware/ath11k/WCN6855/hw2.0/board-2.bin
   rm /lib/firmware/ath11k/WCN6855/hw2.0/board-2.bin
   cp 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=266.bin' /lib/firmware/ath11k/WCN6855/hw2.0/board.bin

Then I am just starting up the device as usual, and start wpa_supplicant (with 
defconfig + CONFIG_MESH=y) from commit 14ab4a816c68 ("Reject 
ap_vendor_elements if its length is odd")

    cat << "EOF" > station_test.cfg
    network={
      ssid="MyTestAP"
      key_mgmt=WPA-PSK FT-PSK
      proto=RSN
      psk="testtest"
    }
    EOF
    ip link set up dev wlp6s0
    ~/hostap/wpa_supplicant/wpa_supplicant -D nl80211 -i wlp6s0 -c station_test.cfg

The actual SSID + PSK is valid and multiple access points (4) have this BSS on 
2.4GHz + 5GHz.

So you are basically always calling dev_kfree_skb_any in ath11k_ce_tx_process_cb
because wcn6855 hw2.0 has credit_flow has set. But it seems like one of the 
entries returned by ath11k_ce_completed_send_next is bogus and causes this 
problems during the ath11k_ce_tx_process_cb. And for some reason, this is
triggered here by this firmware feature.

    ./scripts/faddr2line --list vmlinux consume_skb+0x9f/0x1c0
    consume_skb+0x9f/0x1c0:
    
    __kfree_skb at net/core/skbuff.c:757
     752     */
     753 
     754    void __kfree_skb(struct sk_buff *skb)
     755    {
     756            skb_release_all(skb);
    >757<           kfree_skbmem(skb);
     758    }
     759    EXPORT_SYMBOL(__kfree_skb);
     760 
     761    /**
     762     *      kfree_skb - free an sk_buff
    
    (inlined by) consume_skb at net/core/skbuff.c:912
     907    {
     908            if (!skb_unref(skb))
     909                    return;
     910 
     911            trace_consume_skb(skb);
    >912<           __kfree_skb(skb);
     913    }
     914    EXPORT_SYMBOL(consume_skb);
     915    #endif
     916 
     917    /**
    
    (inlined by) consume_skb at net/core/skbuff.c:906
     901     *
     902     *      Drop a ref to the buffer and free it if the usage count has hit zero
     903     *      Functions identically to kfree_skb, but kfree_skb assumes that the frame
     904     *      is being dropped after a failure and notes that
     905     */
    >906<   void consume_skb(struct sk_buff *skb)
     907    {
     908            if (!skb_unref(skb))
     909                    return;
     910 
     911            trace_consume_skb(skb);


    ./scripts/faddr2line --list vmlinux skb_release_data+0x1b0/0x5c0
    skb_release_data+0x1b0/0x5c0:
    
    skb_zcopy_clear at include/linux/skbuff.h:1549
     1544   {
     1545           struct ubuf_info *uarg = skb_zcopy(skb);
     1546 
     1547           if (uarg) {
     1548                   if (!skb_zcopy_is_nouarg(skb))
    >1549<                          uarg->callback(skb, uarg, zerocopy_success);
     1550 
     1551                   skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
     1552           }
     1553   }
     1554 
    
    (inlined by) skb_release_data at net/core/skbuff.c:669
     664            if (skb->cloned &&
     665                atomic_sub_return(skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1,
     666                                  &shinfo->dataref))
     667                    goto exit;
     668 
    >669<           skb_zcopy_clear(skb, true);
     670 
     671            for (i = 0; i < shinfo->nr_frags; i++)
     672                    __skb_frag_unref(&shinfo->frags[i], skb->pp_recycle);
     673 
     674            if (shinfo->frag_list)

But I didn't like the inlined code. So I've changed the compilation flags 
slightly:

    diff --git a/net/core/Makefile b/net/core/Makefile
    index 6bdcb2cafed8..5eda226c5f27 100644
    --- a/net/core/Makefile
    +++ b/net/core/Makefile
    @@ -37,3 +37,4 @@ obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
     obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
     obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
     obj-$(CONFIG_OF)	+= of_net.o
    +ccflags-y += -fno-inline -O1 -fno-optimize-sibling-calls

Now the stacktrace is a lot more readable. And the returned
crash location makes a lot more sense:

    ./scripts/faddr2line --list vmlinux 'skb_zcopy_clear+0x34/0x8f'
    skb_zcopy_clear+0x34/0x8f:
    
    skb_zcopy_clear at include/linux/skbuff.h:1549
     1544   {
     1545           struct ubuf_info *uarg = skb_zcopy(skb);
     1546 
     1547           if (uarg) {
     1548                   if (!skb_zcopy_is_nouarg(skb))
    >1549<                          uarg->callback(skb, uarg, zerocopy_success);
     1550 
     1551                   skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
     1552           }
     1553   }
     1554

Or with the assembler:

     (gdb) disassemble /m *(skb_zcopy_clear+0x34/0x8f)
     Dump of assembler code for function skb_zcopy_clear:
     1544    {
        0x000000000000072a <+0>:     push   %r12
        0x000000000000072c <+2>:     push   %rbp
        0x000000000000072d <+3>:     push   %rbx
        0x000000000000072e <+4>:     mov    %rdi,%rbx
        0x0000000000000731 <+7>:     mov    %esi,%r12d
     
     1545            struct ubuf_info *uarg = skb_zcopy(skb);
        0x0000000000000734 <+10>:    call   0x5d3 <skb_zcopy>
     
     1546
     1547            if (uarg) {
        0x0000000000000739 <+15>:    test   %rax,%rax
        0x000000000000073c <+18>:    je     0x7a0 <skb_zcopy_clear+118>
        0x000000000000073e <+20>:    mov    %rax,%rbp
     
     1548                    if (!skb_zcopy_is_nouarg(skb))
        0x0000000000000741 <+23>:    mov    %rbx,%rdi
        0x0000000000000744 <+26>:    call   0x6f6 <skb_zcopy_is_nouarg>
        0x0000000000000749 <+31>:    test   %al,%al
        0x000000000000074b <+33>:    jne    0x777 <skb_zcopy_clear+77>
     
     1549                            uarg->callback(skb, uarg, zerocopy_success);
        0x000000000000074d <+35>:    mov    %rbp,%rdx
        0x0000000000000750 <+38>:    shr    $0x3,%rdx
        0x0000000000000754 <+42>:    movabs $0xdffffc0000000000,%rax
        0x000000000000075e <+52>:    cmpb   $0x0,(%rdx,%rax,1)
        0x0000000000000762 <+56>:    jne    0x7a5 <skb_zcopy_clear+123>
        0x0000000000000764 <+58>:    movzbl %r12b,%edx
        0x0000000000000768 <+62>:    mov    0x0(%rbp),%rax
        0x000000000000076c <+66>:    mov    %rbp,%rsi
        0x000000000000076f <+69>:    mov    %rbx,%rdi
        0x0000000000000772 <+72>:    call   0x777 <skb_zcopy_clear+77>
        0x00000000000007a5 <+123>:   mov    %rbp,%rdi
        0x00000000000007a8 <+126>:   call   0x7ad <skb_zcopy_clear+131>
        0x00000000000007ad <+131>:   jmp    0x764 <skb_zcopy_clear+58>
     
     1550
     1551                    skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
        0x0000000000000777 <+77>:    mov    %rbx,%rdi
        0x000000000000077a <+80>:    call   0x518 <skb_end_pointer>
        0x000000000000077f <+85>:    mov    %rax,%rbx
        0x0000000000000782 <+88>:    mov    %rax,%rdx
        0x0000000000000785 <+91>:    shr    $0x3,%rdx
        0x0000000000000789 <+95>:    movabs $0xdffffc0000000000,%rax
        0x0000000000000793 <+105>:   movzbl (%rdx,%rax,1),%eax
        0x0000000000000797 <+109>:   test   %al,%al
        0x0000000000000799 <+111>:   je     0x79d <skb_zcopy_clear+115>
        0x000000000000079b <+113>:   jle    0x7af <skb_zcopy_clear+133>
        0x000000000000079d <+115>:   andb   $0xf8,(%rbx)
        0x00000000000007af <+133>:   mov    %rbx,%rdi
        0x00000000000007b2 <+136>:   call   0x7b7 <skb_zcopy_clear+141>
        0x00000000000007b7 <+141>:   jmp    0x79d <skb_zcopy_clear+115>
     
     1552            }
     1553    }
        0x00000000000007a0 <+118>:   pop    %rbx
        0x00000000000007a1 <+119>:   pop    %rbp
        0x00000000000007a2 <+120>:   pop    %r12
        0x00000000000007a4 <+122>:   ret    
     
     End of assembler dump.

To make it even easier to read, just disable the inline KASAN and reduce the 
optimization level for this for it:

    diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
    index 059b6266dcd7..819cc58ab051 100644
    --- a/include/linux/skbuff.h
    +++ b/include/linux/skbuff.h
    @@ -1540,6 +1540,8 @@ static inline void net_zcopy_put_abort(struct ubuf_info *uarg, bool have_uref)
     }
     
     /* Release a reference on a zerocopy structure */
    +#pragma GCC push_options
    +#pragma GCC optimize ("O0")
     static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
     {
     	struct ubuf_info *uarg = skb_zcopy(skb);
    @@ -1551,6 +1553,7 @@ static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
     		skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
     	}
     }
    +#pragma GCC pop_options
     
     static inline void skb_mark_not_on_list(struct sk_buff *skb)
     {

This creates this nice, unoptimized function which crashes at +63:

    $ gdb net/core/skbuff.o -q                                                    
    Reading symbols from net/core/skbuff.o...
    (gdb) disassemble /m *(skb_zcopy_clear+0x3f/0x70)
    Dump of assembler code for function skb_zcopy_clear:
    1546    {
       0x0000000000000000 <+0>:     push   %rbp
       0x0000000000000001 <+1>:     mov    %rsp,%rbp
       0x0000000000000004 <+4>:     sub    $0x18,%rsp
       0x0000000000000008 <+8>:     mov    %rdi,-0x10(%rbp)
       0x000000000000000c <+12>:    mov    %esi,%eax
       0x000000000000000e <+14>:    mov    %al,-0x14(%rbp)
    
    1547            struct ubuf_info *uarg = skb_zcopy(skb);
       0x0000000000000011 <+17>:    mov    -0x10(%rbp),%rax
       0x0000000000000015 <+21>:    mov    %rax,%rdi
       0x0000000000000018 <+24>:    call   0x29e <skb_zcopy>
       0x000000000000001d <+29>:    mov    %rax,-0x8(%rbp)
    
    1548
    1549            if (uarg) {
       0x0000000000000021 <+33>:    cmpq   $0x0,-0x8(%rbp)
       0x0000000000000026 <+38>:    je     0x6d <skb_zcopy_clear+109>
    
    1550                    if (!skb_zcopy_is_nouarg(skb))
       0x0000000000000028 <+40>:    mov    -0x10(%rbp),%rax
       0x000000000000002c <+44>:    mov    %rax,%rdi
       0x000000000000002f <+47>:    call   0x2df <skb_zcopy_is_nouarg>
       0x0000000000000034 <+52>:    xor    $0x1,%eax
       0x0000000000000037 <+55>:    test   %al,%al
       0x0000000000000039 <+57>:    je     0x59 <skb_zcopy_clear+89>
    
    1551                            uarg->callback(skb, uarg, zerocopy_success);
       0x000000000000003b <+59>:    mov    -0x8(%rbp),%rax
       0x000000000000003f <+63>:    mov    (%rax),%r8
       0x0000000000000042 <+66>:    movzbl -0x14(%rbp),%edx
       0x0000000000000046 <+70>:    mov    -0x8(%rbp),%rcx
       0x000000000000004a <+74>:    mov    -0x10(%rbp),%rax
       0x000000000000004e <+78>:    mov    %rcx,%rsi
       0x0000000000000051 <+81>:    mov    %rax,%rdi
       0x0000000000000054 <+84>:    call   0x59 <skb_zcopy_clear+89>
    
    1552
    1553                    skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
       0x0000000000000059 <+89>:    mov    -0x10(%rbp),%rax
       0x000000000000005d <+93>:    mov    %rax,%rdi
       0x0000000000000060 <+96>:    call   0x27f <skb_end_pointer>
       0x0000000000000065 <+101>:   movzbl (%rax),%edx
       0x0000000000000068 <+104>:   and    $0xfffffff8,%edx
       0x000000000000006b <+107>:   mov    %dl,(%rax)
    
    1554            }
    1555    }
       0x000000000000006d <+109>:   nop
       0x000000000000006e <+110>:   leave  
       0x000000000000006f <+111>:   ret    
    
    End of assembler dump.

The question now: What is causing the unclean state of the skb and thus 
doesn't let it get rejected by skb_zcopy_is_nouarg before the uarg
callback is tried.

Kind regards,
	Sven
--nextPart1643539.SFto10UAbY
Content-Disposition: attachment; filename="screenlog.0.zip"
Content-Transfer-Encoding: base64
Content-Type: application/zip; name="screenlog.0.zip"

UEsDBBQAAAAIADl+hlPn7aNkD04AAHcPAQALAAAAc2NyZWVubG9nLjDdvety4zjSIHr+dkf0E3x/
sD0/2nXakgkQvGnG8418q/KWZastu6p7aisUFEnZbEuimqRc5Y6NE/s0+2D7JCcT4AWkSF3ctXsi
Ts10lSwjEwkgkTckEv/X8JScLx7CRZCQ/vCenFzejMhkFc584rtp0COjYEmITZhG+Q/f30WpOyPz
YB7FL4RrjkkGJz983x+ckbedO66dk2EceUGSRPEP358CtsG7P4+ppmk/fH8/OiGD0SmZzJ6S8M/g
2KCMJIGXRnFyTBm3dIPb9g/fD2OAJhdUI0/BC1lEX8g0iskkilLodbHq/fC9H4fPAdG+AtYpc12t
R4an70bH2hH8j6Sxu0hmbhpGi+PZxCVX+CuqMX7EDOPI1EmlsxNAGy4eyDSO5uSdG/vkLEyeut3u
D9+/vb0/IbPI9eH38KP835X8mVyFi9VXYnSp2dU6sUd/JgKmbBAuwjSEiYrduQ8Y819/IvBH62ri
z+cMzXMQJ0BuBd1B8hws/hWHy2UQvyEHD55HDs6CSeguCNW6rEs75pvsEywMoxql2iF5e31PYNkO
8N8TwJ2Gs0RMnwR9Q1hXN7rsDfmbTkaDIRnenp8PhndkAL2fBR4xCTV6zOjpGjk9vxOI12g+jeZz
d+GTGTBMj5zc3NyNLwf9t+fHR7hGR89z+MXqz446mBh+cXx/f3l27EwC3584vEO1adDhgc47jqbr
HdPRHG/CPMPQJtCceNEiiWbBcZq+jLRDSg2maQt7jZavtnk0Xa568MEiF8BtX8LZjKySgFz8Oup/
OF8DSMKHhTvrkbn7FT9PYXkCgtzYI5Rzba097oXOMo6eQz/wyfLxJQk9WNXb/gBQLHvN7QObAU9+
gj0imbTyp1P5yplOptPPQLE7mQX7YXOm3jq2KWKDDRTEz4G/H77pOnXTv4CP1kfrTymfTF81WgT1
6timr6duaq+txdR+PT66vraUBjm+fUdL6XQd2/bRXv9KDs6/Bt4qDVCGYZ9vCHBuChIWhEuPuPDv
8zodo4GQ96xrQWtAvki7a23OBpcoY1UtcQT/HUpVwbsa0ZwjzT6SGqIGnCZej1y4SUruQPjD7gkn
sRDPMDMoKYeXd80wZwHSDtsO57ercR11CQ4pVy8lELesz2QGfYyX0wU5hsmUs4j7fOzG3mPxPc/X
SgW3dC5lybB/1wMBt5iGD6uMyE9ax/rcIx9PCPl4Ssj9aQf+I/Lnofz54x0hCjpq2rRGjWDg3Yix
NOZ8Bpm9AhGLInow7KS4mMRNFUaZsomeMQh+nH5WMVAOGO7F5L49IUv3IZBKwA9jmFAUXEv4XQlB
Nd3WP6NQO7scvS/4kU0n9kTyoa77Ew/5TwXiuvGZ9E+HwBvnbjx7IZJO7zHwnpLVHNVaOAVxKabR
lyzpVxAYTo7gdnQ2rIqjC3YCJoDgfk4OnmEtT29uzwl5o2IwNEPBcKdgOLugJuOMCwxcYKAZBvEP
6i2SN5a/yH+q9lDSeAH/1Hrgtm4LuAvRA39NDya18h7OmsZwij0wnZ1gDwy24fn122oPuD8ouby+
u0IbjVFKebUHU1PGMKqPwbqQY1DVHwA5Zg40Gp7e1oEcdiqADO3VU2vpRQ/vhuf1gXPHlssPM/zq
Hqyih/7w8nSthxM5cOP01T3YtGDAd+ejtTH0qeiBOq8fg20UPYzW2YOfnOAsgcg5l+yBhjj86V9d
nhCBQ/6hYHlfADBv6sHZ1ANwoFgHXctmKethePPx/Pb65mPZg/hF/lOlBwfla3sPYPRJBjTkGJpn
ifXVWWL9ag9WweK3QkOi8BMbVgqlzF8pZShIZLF7O9lHh00qws1xGhCK/bkBIeNegdCaMhUh7FGr
kcLRRgqtaYHQ1q0qQsbXEYqtugmhw7xiyNakipDTdYRiZ25EaGsFwkmNQsNeRyg24kaEk2LILtWr
CK2GIYt9twmhSwuEE3daReg0DHm0ZZX5ZJIP2WS6X0FIm1Z5G0LcYjlCg1cXhTau8jaEsKMKhA5X
ETKKcv06Itf3gz66WYqpI4wOtS2oks9guj1hny644n7NCqn8aTJ+VWQ6g6m5vjk7H5/17/oH2hvi
zmYRmAdg4WUoEdA3JK5GJNzk7DP5d7QIwLFegF3Tq/wS+Y2AtdoXoq+JUKrVfJymPmyWodFZExpa
H2+GpIbG0nREcx3Fc/AY62g2+gwVNMgAQE3wHHoBfAjmy/Sl0gC37SB6FuzwJ05NkrpxKiy+wPUe
xbpVAEzgAGmxZdwjVlZOaKUhqk8ifwtfNbq0axOqOcHaEBx9C552Z1HFY1NtE56dp9RmwCeXizBF
8CRIV0uJU9s+wBaEqEFvFhmWQ7kKwD89QjPzOwRvZ+E+u+FMLNPaXBumbbWgcKydcDCYedzadRyS
/3pEt0y+IyIwVzYgEjG/XRAB51L0y57cxAX/830QL4JZ3/cxvjdyMT72ZxDngTL47KuQFi3s7uGg
cxfOoenlDRlGcdqDFbI1W21t4x64vEHd8kkDb81dht449Ak7LIJrun5IXNk5wE8DT6znIXk7uiRa
h+kVdKXdCFb1eHR7Or75cEsOJiuAJfD3OIz/gE8Ps2jizsQPjPjTGf73RkXkaGwHRI6KyCGz6AuZ
Bc9BDVWpnaVrh5/JwaB/dvdG7HV0FqvyPFxMcc3wcwVTqZaFdg99nFHw5nSbgcs1cZOgJ6bIF1NU
AVVMRbA0eqq9kU80VQAM2BxVgCyw1yMrkFGHYXQIzuXUziJ8FUj0DpL5EoOKYL6DqviCowbrcHif
HMLsPUbpcrZ6ED+rgKC2PgPP9MhjOAGWc2X04zZ4CJM0iEHZLKLEfc4155owyvd6ZY8jWm6+Eq0z
LdA60zW05mupdUtqg3W01mupVcKA03W0zqvQKvE7f01VAlpGXzUJQblkU6sJLXsVtUp0sIgKVtBy
7VVonRJt4ySgl75hZKQUtLjdh6eXxBdGQYX7GS58fqqxdGP3OYzTlZSv5EmIYAKbdOLGAXl0Y/8L
fKjA4wp7YJc9JdEq9mCjxsE0XAR+5/dwOg3B4iJzN3kSAiL7I+Ja3os3w1+WXx+K70N/FowX8AtQ
PwbyD7huFNUdWSh0W4aImQldPF4GsYcx/evbMeztUc+mDiOLeAxfYtfjSZgmvfwb6CD7AZWV+EkR
QBZ4eIA3x3g+x+MHmAgr06lH8DVJmGUbzCax6MhntmkxsgJ3yDYsU8VlobN/AVbrxPWeSBT7oJNw
Ka6FmoSxk0prXM+TVThLwQpADToD/gDJNY8m4SxMX8hDHK0wEAfr0SVEnqsJqsBsAOcOtHAFnQVS
exjNQu9FYOtlCrnSBmz9TM+CoP3//pjGsoDngZ/uF0+L6Msi5z+VNMGj8wA2TkJ+3IXKHw/lIc8E
QZMEFjON8MQnJsnS9YIyeG3ZTNfAiDgLFinYuB6YwsjyyWOmr/Brwc+woZltkwOxoDj3hwQmn+sa
J5OXNIAlQ0LdWFHHNtcw8niJPNdpx8xMRjH2mGF2DgnTHOAitgExtQAxSgF3lUYdtI56aNB7T70I
99Rj4C6l49SLFtmP0zgI8LcZGtrFczsDuG+QSSBdMyxwJN8fcYxRWOy9IksOwC+zzPfl2vjBIbGA
zvck/uK7qXtIwAt1ACaO5I8wq/ATUnZITN0B2EmSYCvNEL/JjyhASb8n3tzt5F+8UQlkaOCBxehH
8x55CNKx/DxegZnqwQBhYcWh7Hj8BLMxFpM89uIA/MWfta/MPdK+ArcBL6SPxIsXD2Mk6FhTugCz
HLbD6Or+BAydjyACHxbHJj8kN7gax1oHDMJBuLiZ/B54aXIMq46WxDGYjLifk2OqoDIonkpM09hF
iZj5rbh1dVuH1cwWHO1hmHe5iUto0zE4X4PGc428rRwFlxJBgbQoN0B8nb0s3HnokSGsM3h/PTJd
zWZKK5hK4JnYAwmXNQlxZR/DIMbjBnlieXpPwvlyFsyBWKGyuioGhnaawPAdtoQVgxF5Yog4K3Ip
MoF8LOQk7LpSAh+zKjYd9Pl3d7Cxl5HY5M9uHLqLlERTcgciPBHkBAtxIlCFxJn67nbl7wODEVLs
zUNydwczrWzI2ALmyFvNxLI8u7NVgPAJsJy/mgVxJ1ig8MapA507c19ImBBmkEwlVtHaWoa27/++
SsQUPgQRiDgQQqgt4HfjqbuIVul4FrjTY2oeVmayQKbrhkkxWHM7vrz9ZSQEFXCSaA2eAsgXzoFr
l7AnCpaS31NTQWKDX4in9pnd7UUzUOzEX83nL5kBQWzYUEYGwroaRgkBZBmHi/SpMNnJJyHlP+eT
qbR3dFPPzfzTCCyLGPAKZ0CkJji6Vja2uIlufMXEeFwG6WvtCqrr4P7Zlm6AvC5sCugIVD/DGC74
hOB8wA7zHpFpk5c5rgVsp8ujG1DGwGnC7CgBHQ3Mgc+k2727HJyDy/IsclSOwVHRhGNJj2Hbhgt6
zMSPTP7IjstBgiK0MVBVGWSaeJ0Aoy7rI20ZcWC6+tSd6i6vjRnW3XLQvNVMpo6ZMlPHOMJpfsgK
vCf5dRZFS3KQPGE+if/mMONxhenlWWwq/GzQJ3+sgoX30u3CAuLZqw0m5UM0uByOyMFs+fsxHiNQ
i70pe9Y1HUPwy9AfA6k96HbqrmawqqBewNibg3Ser+aoiqgCZAg1ejUaYJKRt4rRLLpAe+BLFD+V
oYHytBKBbHHa+5s7d3tgBYAxgZTDXz6IxW7ZDhS4iO4ul/0Y1GCv+NQQcsDmoMpA9tzdDG5+u8kS
cxobGsDvNkbcVot0g+4XQjLX/LCApmHoZrPeR6QcyM2QLqPwG2I2DRvJvcIDeBFVIOHd1UmJjb8/
IeAzg2kyOCE2mD7wD1fAYVq0Cri/HRyMgbcnRNkPlqajXzFawlYC8fCBkh7o3jR8yJwntN+8aPly
lHxxlw8JuieAHkxCNBPHY2HeiWlBM0+GjtSwBvbAdYspPbBaDxegMsUJVRykUimVsGAooi6owOY/
PDNylP9wOzoBPlNwgh2KvIffg6wDOZkGX1OSCFmjoDd105bocbNh7tooRSl58oIWbI98WM0WoKrL
LBHWhb3tINAF6HMR8R8MwXBIpbv5DBZD7lzq7H0BpHN54llETUBbg1vSlJtHDqZgUqAs0r5SFC8g
B2f4A6wkeLEiQQB/1N4o2A2OVsIwiEVYaQGK4/wZGCGRXQwH90Rk5sXlJoQNLnZVFyRJFh/qkdof
TWnNhRDB1uDkgVXkp4+19txWmtu66cjmDwHMIMj0OPPCkwys5GTdZEVrKf2kFK6QopWxfPyjAJsF
MKaOgUMZRv46sNUIDNyfA0/Dr+BKL1fxMkpgS2fTV5kE4OS8tfh9C53KH7Urh2LsVtgf71T7b9Ru
AAKYo4u4wfXgknxxgXn9CFb/PDOacMVhuQFs9iKMgdUcGBBDwo9fOrjqHkqtyrI7hk5twYjgeoIZ
8YA8vFpiume08F2whIRVKZIiMxiuccZkGk6vCGCsxTR7SnsTuEXMUzc7EvhbZsNnk/U3JRBggrYE
8TAeo+8ZLcZClMQrNKZp1zDwQAyDr48gb2aZVy/VftkfqpNyTNHq4THFIVHR+WEWmFSac27ayl4c
ANvMogexGOCoPmWOvgJg66jXCgAZEAAzlJU5T4nM4hIa+wCVMAi+QjWXW5VzG2zwz2jepfPlFPpp
0mQYj0G5h4lPc1DN0lskEzRa8pxIZmN2bw7gQHunZtZ8g7CQBk6vbcjjG9Wc4Q742ZgMtQK52uy6
01ITgjsnbY0WTWholoYHUSDaQJijpxsHlYkpfpOsJskLSJF5CUsdE0/Nrs/vKpG+4cUYvrq6vH5/
BB9vb+7vzkXOXQRWNpEStsTBwB9ln+WhTsVox1G8D0/I24vh+P357fX5FSg7RABc6KYRun65yxkp
02Po3MED8V0Q/nf8iAejOyHmTLD6Poh1thtqtJ7A5HNXPgY2VAuPLIIU1uwpm35ykKeMKUto2BbG
yzPo9GUZHKOBKr84oGD92hq1KbCOqfXoGxE5SYNjdZFF03Hmw4DpHiuuPvRgclskID6izJuNgZDK
gmffk4cI1NkCxvrT1A3jcfLoxsFPChakZB8sE3fxMMa/FCSgNiy6DxJU3OMvYaJSgnbRXkjQ1hqL
UJqKxd4TyzL6AmgyDohiBZXNDJSL4O6iDOhljkcBOXN92M1lcweEg9HeHG8EKI1B5MKGcL1luHwE
MS2OyN5FKRniQRFGzMENTuNohjL+TNgqpVmidUsX2NSgWzw8OC2O26pHa8h6IPrFzQQXNLnroYBW
4JmOcYBd4MFkDBYYlK7jAPMGjw+fQKBMUNjJD+T31XzZiZbgqmVGMAYj8gAHHpTlEARj/FlDDA1M
YYcmCYaGSq1rmszE0/B3q4cA7fq4XFTahY31NpQJpEIfiFhDp5QG1UgXIgOVzBqRMUQ22AsZOOG0
TN8TYfvxzejyYBBhTCZLiHijtDd5edqqtC9t3jUQRxNOwxqI3tXIeHQ6JOe4NsgeiQrFm6HKjvoP
DzB2ZPyGPm3dsRughcfZOQtms86H0A+iEsQCZnJ4K8hVsIieo871h867s8Flpw/yrQJsbgJ+N7zs
vHuZxKHfeRu7S7AVi5HCJIBBbhUHvlxup/7gSmrhBAS14FiMRr4A9/6xCnGpRWQ/cv3C0tC7VAPj
qRj0JdpesPjozFVjSdgSdrBVnvz3yEGyWi6jOE3ISCMjSkY6GXEyMkoyKaC39OrhuMwFEPurMPUI
GG1pGUoAQAbeCXSGGWRgbwnTYunGAgFYG2QSBAvVQOgqkEwcLCn7+zECDxknEvj7S7jwoy9Z1BTJ
+jvuvkWAswXG76G4ofLj0guPF5EXJz+KOYsDHCZxyWSlkMhhEYpdkFnkhDrk7fBcxJultQabK40I
vSjgdAZ6rGBSlHy3eIHqRNL3Cb4A6XTgR3MXcAi765PISdA60+nncmp1XeOmISUqGV4Ptb5m9zTw
KYGFTnvkZkSK1fl0nskxmT5P+qPhgJwidfDvKHhAtyMhgxEI5OGvnTuQf0VuH/TDLcvgm/rBe2Ce
FN6JoD94l53/j94NT/PPw8E56Z/f4oCDU3fpZidtV3e3Sl+2Bt6JWLvKosEEyimAfotUBGzOuIZn
iF44Vn7fE6dlAgIsCGELk09hRLJMAjxA96ZWxglK5yBynP2w+cWRcQM2W0RndsHWlDcwUQ+hdXCp
2J7o1HPq3OyvE8lhewq7ewesJQ8q4NLmA/ACFEOSPfKJaoz1qIHhZKFPgYu9mSvyezRTSV0BJMwx
OK0h4RUkLEdCVSRcRQIuHSaBrCMRUgyFQL4HQJg8JAog6CanCRD49W/5FsoPvM40cqY/wtSc6eBF
lKKRG9RYmwijMgZ9+xgMGIPWhGTbGEyMLTcB7jUGSzec+jqYlTHw7WOwQEXUx2DuMgabgXnfBLjX
GBzD1OtjsCpjMLaPAVxbvc4S1g5jAP9J5MCuA+4zBoNallbrntJsDBrrcSGk1jYVaOcifA9IGEhG
swkJGD8YV0R0UoiBBEUZAf9YnxV4eVrRCs8VeCbhmaI0wP/dDG+r/duy/6kKb3NT2wDvqf1z2b9K
P99MP1PHr0n6NbV/Q9sMz8vcISvQ7DwfCD7qqoQEqWDV9zS4wOpiWg2L6Wk61RQkYD4bTUiUxSyJ
4SUxvKJDDMux1piCdZlCjNlMDFOIQZ27TgxrIQazMfKZ4RViHE04hOt4CrPljJIzpgCAbd8I0La7
EFzusQKJqVmsvkWpvud6mFRb31x663oY5XoYlfXAS3B1YQl49lsPU8cFb0LSvB5GuR5GhRiw85jd
hKdlPUwMiupNAPush4EXaWpIuLoettE4BYYisMFR1vQ6JbyrK/PoN5ohVEUCo1/ja97lCiVt6q8U
u6YNUmMdiaFQ4mxnLwdwrs+J0bKiZsleZoW9LE2zaZ1NDXVuXW2rMgSBwY36rtvFKLGyu43rgC38
ZDG8dVoDMPfcmhZaEbQJSePcWeXcWdW5AxdybQ3MPbemxRlf0+Rm+9Y0y61pVogxNEuvT6W5YWta
RoOoNPfcmpZpGKy+HrZiS1naduPesqhVN+4BCVWQNBkzdSSOZdcZ2c4WQyJh25HYlmXW5ZudCQmJ
RN+OBNPF6itqZ0JCIuFbkYDz79D6ctqZkBBIMMC/DQktnFUViakgaWLQOhLDWpMQdtdSkDSJqxoS
xg1WQUJLJzDweiCDmobDqkhQi9lNSNbs1ezSD9XULQJyt7bVavC2stVksncn+4h+scknYapg4+Bs
G+3YmLpx7RKbrekFNgyhqgQamkOtJpQte9he28M5wPY9XHcpbIuv2VqZk3t6qcRYpI9PFaotGRFd
ByTVeFp9cSrC1LZN3doNS9MSTauRENvRRPx+D2zqEslASOMSOY44iC4Rs/0ZGazamm3I2hiZSZpY
hZEdWt8IrJ2RJ+W4Jo2M7FC7xsisnZHdEpvbzsgOMx2LNqFsYWQH0894E8D+jOyAi200xlmaGJkp
VBvSfFgHbGHkfHEqrOeYbJ2Rm7E0LVGNkR08iWyM97RiU5eonZEdy2B6hQf1VzCyXY8g6G2MrEua
9Coj45mPvQFeZWS/HJffzMjg/FUZWW9nZK/E5rUxMggMUMOsEWUjIyOAWXN49FcyMuBipkjXaAh3
NTCyrlCta+uMbG5g5HxxFNZDLDKhZQcsTUtUYWTAxtk6I2/Gpi5RGyMDYoOyqmPHC0bmHsy+qTUy
sl0yMiIBda41IWmwws2SLnMDXZh5aW9AqfK2VaK0NnCjJX3DNpQVBrfKGI8lYjwtKG2H8SaUbQxu
y9SIdYD9GRy9P7MxEtvE4LykGmtd1D0vCdjKTMqiWe2LRqltZFFy5awDrO7ikF+mAci7SmQBY5Kn
/mGZ/MkxjRvQNIUJmsYF4uUgWU3wdonILfUDvMPzpsQGZu+aKyCwtezmbKDq+dWWHtCUrQe8Nvaw
fqa1pQejIRrW3EP7Ode2LuxdB7H17GtLT6bFtArbmoXEsbxJD8+zt0occHk5dZqQNEgcXjKvoTCv
wrfoG1lN2HY/VUAspskaB4aKTSNvJ0eJcvMMD2nJxF34Is8XE/bmIfYxeSFgoZC3d9BatPlKiUgM
c9NKlIcceHjEOxN3dSzwI0zZg7hMZTdhKNeAYfZoY8ipaYuZ5Uwx2hC032xQrc2+gk3nXOPKMX2W
HSHSFcSYL6/vyjItuABRTC5vfyGagsNW0h9acdQKsAEcd3Td2gJ3sqVvQ82FacWx3jfMvraN5tMt
fVva9nGfNvSNOdLbxn22pW+bbR/3WUPfDqe2vQXufEvfDqy3uRXHWt+Yv2w6W+AuNvet0x3W+6Kh
b8Ypo1vg3m7pW9e29/22oW/dETHfjXDvtvQNGs7aRv+7hr4NPMr6TMJoPl9hRUtxKYpkeTco4nvk
LitYDB0rcDImksMN+jkM5tWFi2d3Fvoy+W8proT3yMz980VeZyuxmMxGTn9+cN140qtmZXG8l8Ax
bnp+1j8lg9Me+SDSqLsgscs2NhPxiusgvXIneEXkcv1Slmgmji7KZjm9Imsb8/3IMWaTKxCmuOuh
QOSJ0wk0vb++6p+cX52fkdPL4ejmmZPT/hV+KhE4mo3uhYJgtZjhJ0xIjcF1zVKQv0iVkl1IU+C5
EB9KCpfIb8sXv5osxjE5xsZgKN5VBGkPumgwuLxR6qQcIliCJWfsQ4V1uCYHmsHpePsd77xj2WvM
WO+gFYknSdSmtiZKnGb3KUoU1KR4PlLJu5c3GuX1d+UX5TXDAtwCmYOpIR8uRj1R3pr8sYpSNyE+
/js2u6ay4Hg9EyOtsjE22HATrUy/xypBojCQSL4v9axlWCJM0HAL7yKcBTLNPs9rK6FMZogjrsUS
dttiKFcGM/HKJrZmGvUmvaxuKq1VxuBdG8tr2LUpxGyz8XJev7rQeHGhdm2BabZhaVimobywAL1g
JTfeeE3gEr5ruRqAcLaGRccuhyT0RZ5c02zLe375dQfrMC9c0HjfAZDaukgdTL3lGG8vB4sxGnFY
A2ks0DdWLNC4veONCujBYQbWgL07HZIgQUxhghzZhFgiyjGbh3lthBbUjkZ1THZC1BOwp3bAuXVC
HA0jdAJnj7wr8CWq6D9Qx5ENHrsXHxVU1NKR+wZDJDCNnoJFI4ViSyhXNR27taoEIGUGQx69Pxtu
X5vN9z4Bmc4oijdA1rkCs/obYOSa8NwbmPv++vJXvABzdQNSupXLHW6Kir8NCH6FIbeCGdSoJw3s
cLCAgKbhNKbd7X6wwDEea60Fw155sIDYHHPPY4pdDhYAsWUZtD7Y7VFrjjFYgzUC7h61Riy2xfaL
M7dGrQGbYxjOt49aAwZNX3P7dgiJIiDWGPhrIVFDFpf8RiFRwMaoYRp7YdslJIqIca/vHVcDQLz0
2Aj4l+JqBkZ/mVN31zdExBRAaz1LYbufDy0MJoqifws/H7E5+WlJLQc6T33m27PHAY1pgAzdhMbY
njYOaCxQDdYmNOYO+eKIx6baRnKs3RPFAZ1taNlhiYKOKui0DZLawMIdpu1sgqc7yGjEg47RJjxs
P+lsdLFYvrmWWc+ahtYgXg0MWGPq6QZ4uoNgRTzFcWALHravSKV4rX5ttvSmoTXKRMocPTtubYGn
O0lDqmONq0142L5ykHLmWGvRfN6McjdBRg10IxsOCPYTBCj4jTV5YuwrCKjJbLZ2G8XYWxBQ06HW
2hUP47WCgMJk2mvzbjazxAapSx3bqasjmdOMV9WexqtkMhau8hjv/UfT6c8wuCPtqxvgdaroiWCp
YAsva3lJgZQxmbG0niK8M1JL1+pIOV5qaMr23RWpAQqrjtS0hHu2njz7Vyi1Had+qCwTR3dGyk2z
hlSnbD2/2NxroWBf1ZGKJ76aEhR3n1PTqSPlOsNQjIganV6NYJPn/lIWYIJvlNYW5zLG1BGX6WWc
KYmmKdbdJJNohVVUJqvpNIjFM2SRqHJ8MPp4eXN3dfJGwQTuPGz4u/hF1GmKyGqBVSTEJappQsI5
3qt1ExEkid35NClrawC0oTt4UFp0DH0A+p54CqYsv55tTc1jhVYrvjLlV5/JgckHKmEGp6iZrj7c
EZjDJEhB3rsJvrOVRVJlHQ15CaIEwyrLyJtBPJXlYy5PRjCF2Ys/B3nP06nSlW3ZGJrKI5BJQLL4
URqvklTUN33BaVSWC31qijUxX+SB2mQGk4bREOVystLa4ngEiMWnEA0WJcOKWEnqzpei7OgxuMcY
BxIu8zHDEs7eU5BmP5fD45ZF8QrAn5OVX4u7wi9t20CPEi+mPmDJKzBGZ26KRXWQ0Fh5Pk6p1wFw
jm5i1mYxGLesZdYwGu5gjOwz6Zet8EE9vOAaxOSnr4bm/NQEh5WX8QbTibhZOnNfoPXodHRZ1Ng5
mCQPb7JSP0XVZ63Ls3GSg7n7Oyw4M7Ry7QxKbTzzBJ1UVNUj8z86fuD6okJgEyGg0TPxLa/G5ru4
uDvXIyPxnhvOmDj1w8AtK/cfhjNMqwmDsRGDUWKwQNXyJgzmRgxmiQF0kGE0YbA2YrAKDKZmmRZr
wEA3j8IuMWA9OhhF8rj0sC7CKHWxCo+/R22EclIxP618HOW/jYe34+4pUkQuRPCVEYySysob5U40
dWqVV8ALKLoFCoULEP723fkIHxELZzLgLa+Nk/7w/JJMw3guhBp8gH2NRyBdBYFjYlxiBJyLxett
4MojKl6ckQx8CAaXyFMR4XuChTxwFqv30gGPYTGMXSUCD2IB0YDlEPEgAAsJijLm5ACLCB1jKA2r
Qown7srHcw9RF/cN1mlwiei8XyI2LQuTzuqIaYmYlYj1PRDb3MZkYFnJzn1YPuCjEOIy/BRzT541
vJZfNod5EuUWBmedD2Emkm8Gg/tnlm/1yQv5r1EQP5DbKPCDGfnH77H48K8EdGTXD/5ZILMwg8xo
RjYFlYcHV664mS0yYIqMACyM8QiDqVTfAXSUU9wAoa1xvF9wPcTix2Q4OmL5nXBZtAkYqatAOQxz
EHOoOJqImtgiKUk+hTZ7UZpjiXenaH4draEum+pYI/IzsBoM3A+ee5IU8WNeUlPWmZLlcGYzMofv
FHgsuPqZxKk39uYRGrjCbb7FI293Qb64T4HMtBiV287ipoGd1oGUIhug/uG3pRayMLWNr4OAYhPV
tTLtKc5EcFdhsc4OZR3NvKO8x/UeaLt7oKksrGOWEh0dHrRI6sjdmRvPE6yMBRixSJjvvmBx4MxO
IotnME8OxXGYqFaqILREgW3YdqCsHjqiYrcyOkAHfgK+JxfIKljIPzDFStktA4+FaEuhJjyBMVui
zCaeYAo3Vrw8eCtLnssHC5WzNeXxwh5xHKcL/+GJnYLFdtCsqRf+3LnkJ/V8zjzLtaleO3GybWo4
Goa0DVqeOUGXmFFu7X44KAEp3jMBnczKEoPCcvSLwoKwGjZ/X7S2gQEw1pNVcgAZII5HM3UzfDbL
lg4WuUYzrZOE6Yrc9Afk4BL+ftPY2BShxnm4BP9ugKXRg3oLh6Pt2rCiw/7p+7ZTNYpp8oZ4EWi+
nCXjhyQC/EOw2N+ObvKEprIpOCDolsM2jSPM1uqVH4GVfXE6H8hHDiOyCL6AGQUTPBYVMY/BWMX7
l5Q6JULYSyjWFYSyGONWOEPHa1hVOLodDgQuXm1X4AbFAO7FADKl3iPP4K12K5COOHu8BO0Hk4Le
EJnEYMt5bpL2qqpQADgO5pEIO24suAur2wmTmSTyhOmA6ljSDfxHBnxsmZQxBvbom84/DyjXMKoC
biA9JB0HhwGa502JHsscoJxTdj7WcQbDIKm/MSKamxo6ZPm7y3i6jlZCJ1yQX8GWdYgXxKl8hzI3
LBDMNBgmvP2JBUdzCz0rLiXqmM3+jI7Qei8hLM7QGi2s7+54mnjxy3LdlRCtbQMj/WXrTY1B9lC1
cdZWPjyMA0ay1gAxxdrUsCJFARgsBGDgN7bGW+x241k8mD00yyQRB4VrJpAANxlGxEOsuwvq8W44
IN5juJTK8TCvTIig8KvORBQ3/S8luAH62M7A+0XZJ3Es6c4eInCEHuc9pIQZpgJl2njXMu9U1LNE
J3EFBp8gOBSPmxbqGWFgMpHQ4HlepquIlT3/MFDKbaWgZiartHhETIBaGr55JkCTrCJxNwnwFYKv
ZStLFiWrthoNQByZfK1unQDg4nSsEeD81/PTZiBHHF00At3d9q9HAyw32AQJxr7dRt9g0B82A8nS
oVUgdwn+4jwvg4nNwKhia7hheZQWholVwKotvKIaj9LQEXtQNHwH1IklkWowa2SCrcSEE5hrqdUC
bS7Mqc0YPddXDDbD+xKM68y218CyRw5ktOQglE+AvSmL6eL7BQoOR9wH+Rjj+Xn+lDJGXx6DHFMM
/msnWoBewLcReoRbVONPJQrw3dBX2kgGFg0+ko8rkAd3+aZtSKYj3gDZiEuiOVrHRTVHweVgNRdW
lv48xTd7AdnHn3/NnwdOetn7GodgpItf5A8Jl1a2wAQMATvmdrUgRziheRAqL1r6w/eZaD4ky1mA
tfK+uGEqolMjfKdO1OzPxDroiK7VyRffBr8VWDJL1SQf3XghqhKPhNl6eSPfG1PiVuLPSf09OvzK
FjkeIC3SLD34ZommBMYtdoA+IQf/bTQ4AUfrIK9nf7RKs8fEOkzLX9tFih1LFOmRbu7N6Eo825hZ
jxkJf5fjyWwQUNmJEE7C4Jeu1n8W+CwLzAisTY0BmKIu6Xp4SDS1zTI/EuPmQiXcj07WlQG0dnQb
rbRVMpGFUBV9i/ZN6Shm3h80nCYFuI1VbvYBf1xNSmDgGLQgwJhePgJvxuBYOFhpNJooFNo66Cva
3kXmaJXkKZB4m/2zxFu52EqC9FE4Wld4Py04simlwSHxtZ7l9myrZ9u96bSH2V6/Xp4R5jEZFWBO
idsyRJniVty/r+aTiEwDF1VUQj5NsZw9bCaHOkWoOP1avJI9Fyz9FH0uenB06qBdHjx64fjR83ti
CRl08NP54hHLbvs/kXdYuEwJ2Bycvzu9fJOZeCUq8NvMDFVn6YEnjs1EsGeZRxz9Goglc7qiSu+0
S8lPN8tg0dDzTWPPsA/Q9s57rh2VCDJqmDJYp6sxTcR5N7EHtNItsTNaekAOQcplfbGccQ7L0DT+
YgFrBUOgJVJwBFDGqqvLitWl+3NO/vIF4MZXdPDgqIVgkLozEdvHYMnoxNK0o9EJ+FxH71Z+Ei06
7EiX0yZf7vjjUYSp3VgxfaAPy9C1TfT/Re6EHmzuYGnpllH4wWQlYyzKrGIgBq8ptcBgaItahxgb
rtb0KRDgkRsWBmtBkO8P8e4pLrKYJ6xfWmLQmaNLeYX/wUxcZwySiZHMiA39D2AdRvEx9c0J/jgE
jbry0mPoEJZ04vmyoOexOPUs0WPFZL4BPT6nI3TqYBofg0uUowWcMjR5LVjxuJw0ZpoaBiTcx7Xy
UH0cHjqAuFU0ojOSzCLQbGYW3MJ7MMtEhCRFyXcy6t/1RWC0xI4RKEMlOKNoy95kFrjj1ra9CX4C
RyYpsQ/cxQrUAXId+B0yJqk+PZYLuxIFeIZoZzYMfzpzcSbl8frC+4MkixQGOsPTCrxhN4vIcr4k
SzxrmK3meOKRkgIxFoHAo3N1i+jFFmGv2OLlmumYDGGq41YXt1dh2xIIYNgmgv7yntXBj8AbEKCD
Ce1A9ziLyJz4xbQiQHQst8hqTY08aJodz5WtQVtg7mAT6Yulnojw5AKozS6O4XgKYI5vdjRKEn2r
igDuEq5sC+w+wl8hSNfEKUkL0m8ioMEtEbWoEi8JRfVRjJhCf2UDDmqiUa3prfKVg6Nitc9ks3w1
FOnIDWBBR6GK1qnCmyRGs9WzWNKmhVaw44NgXMHO6tgtQE5b6d9BvHMwfbnTrPcWS9ZEnzJ9DhVP
fhf06TX6DE3eesq2NfvGysOguoP3M4r+eb1/ENXGpv731y74zqdWQbmb/AdGoVj8sqDVqNMKY+Gm
inhv0W9wxtGyAx8WJajQXe5Xcn826B9RXSfuxI3JHO9e/KusjCj3RPYzhZ8F1zslUoOJGq+AlL0S
qd2A1HGQcQGp/jqkrIFS09IxEANI+SuRNlBq2jqrLEuLZtIVzWTAnhLVn1PXeB0lesPwAKktF8J8
JdL14Zn4Tnum4dhmDYfhYowpVJq2ajhTx7fZm0STuVVJmbphmo0Gv7mvktJLpLg5so1LOxmax/Dh
sZMsAwBSpEKu4LKwdk6GggpVcCt930TfmQYomkbVZLaqMxMnrtFdMNvVmaloA3AMtWYdau6oT2xN
Z4rE1b+xxAcB5WShDbmIW7Brge1XsJuaXcFeJZ5S4W61Er+/ugA5RTH9oY3gCkajxGjWMFoKRkuc
25RE7qaAEA6Ph0q4vfULosAk6BJFiyw0FVkI4lMzMsNY3yxhbN20HHWLFiP7GMbBLEiSsVw3BcKx
NKuGnLfJJJsbhq7ir87AIPBD9y54IpcLr1sCWVy8AxoVoaCbzaEgALE5dTSln/VpEn9KAPANNVZR
3OJutI9vPx+MRil4MOCWklG2rgTUw5sC2tHkQbai9/aBBr/FoRX9vg804w4mNypKaS9oQ6NGObe1
ZONiosVrA946Tzs6Nx2zYkbs0zv4FGheK1p6H2g8pHVaad9HSfESqcnFnbIWpEKC2zUJzgtOYmC2
c9tSpAN/jfylLfIX0RuWeNC5Ff2eEhJRCm2qoix2/eb1F7COpRsq7DaZFlVkGqKwDJPqKorWyIMy
y+IOsxQ7fINMw6ZOaWDxzVYTtKaUcztbPr1DX22kCFSge/QmVtK37y2EZ5Yw4Frg9+Fvo0SqGxpm
hbYgbeRvQ+VvpnFTL81x4xvzN6PMcYwN6PfnbwaroNkqyt35mzFDnBmXsHvzN9OpwSsT1uq/KLPM
qShegUxrbOZvMKpNzNSvNG3lb2YxHXMZ1tdf3ITYPiGWLRIaW+D3YUpl0W1THD22IG1kSrPClI4p
Kk4Xu3abVWrYU5UngaPNFqsUsGOBqZyBmrBXWJK2s6ReYqRUPKhYYCw48mKGWSWnmOF8G7h+EB+J
M/xYAbVoHqAWoFWGfCsz3cvmjOoV2mvMZ9gXOHiT26WMAB9GJC5kHGt+4y2um4bq0K+j33+L65Yu
HuopUe6+xXVQ17Zci06SRjEmI+BMFVtugFXMRtlv8qPb+r7SLdu2uErB3oJCBzNSq6BoERS8q6yV
w2w04IqoltlrGknRHmwVK3cGzM2ChWuGjqqi0pS1CRaw0UUV8n1O5XMqSyS6Jm7jrQsCcyeVCfBm
5l/sSISbKMAm44361txX31olUu6IivstSBtFm6WKNoOBjVX689Y33oxg7GqGsQH9/psRuEZnFYp3
34wGp6bOVdi9txE+/GdQFUWrj6zMsmGK5z2Q163N2wKsVWoatabNHi+0tg27sG6N3J7EZwe32pNR
1Z6kmFAoks4KVNuUnDfVVUYITKz0pDAC2Ma0xG5yM48bNWGv8IFW8oFW4wOtwMjxFmd+eGL2NPE/
ciauL3T6onYowT+D1SwNl7NAar1M7YnfiHc8h7/AmpH+9QgfcsyQgytAHR3rLCV+ifpT4rufCWX4
VBe3bazx1MFDxuLxavHiIAzhwNS7Dnl7cmQ4XQMfCn1T4gVtiVfP1vHKXLqhzKXDeytR/lC6AHNM
5Pk2MFGIqldUWTsU2Xfr3/pRkCx+SosEq7PhDcF6U/f9sifbonj2CF25PfyL4l+M/AP/Mcg/i4ZU
A5Z2mkjqp6krUuxFalYczKNnkfoMdDyV4FleQIw3TOc9MnWTVGbH+dECJPYJiMBFr0hehsUMFpjY
lUlW8UK6aNot2t6uFiId+Cjx4nCZJiLprrNEAlaLtAFggN+LBGJ8b2+KCfZZFhm2bcOK+bmzThot
dyFBNt5Aw8dwNpNPOOIhdTMl0wR+I07nVmk464iUW/GkvYjCHSWTcHGEbbrB15STA/qGdDrkCDbW
Ea7fZ1L+ruOSzqlW/o788H3xuUe8WeAu8EYK6GX7SMfCzdwW1CTwrWMZlm0cUUPnmIeecfsP32fj
EesqHiUUTzyd/3rHO9OEHCDqNz0ixo+HjGVtM5FuKO6HYtoq5mWKG2rkBiYONtECpNibLvkFK7KJ
34Bwk13tNOeTKE2j+c5sst5cDIgLDYu237WoSFwkcg/wnmCKr8JnoiaPIbkJkSsC6KKXqJPxNN7v
AQzBV1DsOXK8/MnFi5tyRvxP9DPmZSeBqCg7l8/5/uSu0mia8J8KKAcPaowqVPY5TxQlcTbKcJFz
kqiAePDzsD8gP/fvzy7vyM+j86vL6/tf4efhsH87uLklP18O+vA9JkTjr09PbwZD8vPb09vfhtD+
7fX93dWIdG6G59ej0RXAncJfJ1fvL8/Iz6f3t/DD+dXF/d0lNrq4PLthgPDsmpEO/A0fh3en5Of3
gxtofXV5IpCOzu/uh6QDP16cXY6g0+Hp7TkADD/+ct+/urz7DT5S+h6o7fxye359enN2Dj3++3II
qK/+zcnPv/6b/PxvAIe/R3dnpPPr+xMgenAD/d3fIfGj30YfLq8BQXYNvfMYBjFmy78crxbhNCxS
vXFmDUPcxVRn9iy/el3JsP9qmx2Tw0r+8P3HYOZFc1Es5z8+0flZMAndBYG5OpLmxCSKnr5E8fwo
Cf3/+KTN/wsC5R1iqopZ7RAD/Hgij7fREOk/fIGx4y5XnY+n1x3TNszOPJy5i3/mnGTinSUHU/tz
eerF2cWlTJ6KZpZ4uAbVsNrfL6tgBcMThz7k92girubld/bhywcgI3sCGeTvZW7jdkukuilscxXp
KWggnLRkhtp9JP4+kg2OAGEq7hfCbPxdZ3NCbt4TglPzuQaHDejfdWfegADbKzSgi892pwF2g0jN
+itk5DhqlICj4uwxG/J+a+cvT4qKp0qRA34H3zg393jxHW83jbDierSQJO5HTTOOGiXcFqcJKiUj
ediI9TfFVS4yBJcH9gtGKP5YBQmYvbAJQLwmET5uLuw7lLsfsXELiTnOgrh15P/rf/zPjZhrhFuy
rEwT4RdR/AVNy0a6P+Id11cSvY4YiN6IWSXaFk9m0Jo0G8FmXi0J6hRpkvTjCdbFAAznXwNvJW+p
YQVSHNccr5aJH+TVAtIv4IYReLttI6l3Ugyp6A1GshFzbSS6YdTFFhjy8iKnlFBXqPXJeXHN60M0
W82DpIXCGnBBXwuWGjWGI2pFbaBm6IJtcw/id18CSsBan5Yjntja0OctGJlpoE7qvp03YKhSAdqD
WeZGKqRQes3QFchar0wXNcK2rv6HAG9U5U7UX2SCNmQ12rij1aX9lagpK5zsBc4j+IdkFGE5lBZC
KgDlfKiQtV4tzNre0KtwGUBI4L++uHIPto4n62K/gpTt6Kr0MSwnqW2gDy0TL52B8J2DXA6z1+iv
RR7iMFy2qZ5m6rYhq9HGHJnU2Ebbf41W8QIYoL/ywXx6xWw1IajRYABHWzvQIIHJgfDSgBvevIqQ
NSw1aixLlMHekZq/QEK1Xzz4sDfNwgroLRyrV3TeAF+jAO+QOdsoeC8vEr6WgAp4rX/TslhtBoqo
xLvVQwCKBK8WKhJZ3A8k+Z+icdFlM5Totlt2zDXd1LWWjoc3o8tfyQDMOAzxC/dgHwq2gK+Rwk3b
1FtIyebuTGTD7UFDG9xa51iSwdjc+V2MEf39O1+Dq3ducMw1bjAqERvaUHid1svM06fgZRKhNThz
X6JVWqWhgCqVx2bwNVJsQ1ypbiRFGvyCxfFBGcybCT0iw7zkOvKDZBs12zHUCTKZZetWC0EYFcxX
ZyCjJLJS+XQrJRtA10gwLUqbbP4WEvx4/oreAaresaUZptXGFw0oplhlaP+eEWyta65Zes1lAAEK
egxVfRajDJLVDA2icCG49H5J+r5sAYL+JFygM5E7DxNxIzt5CrGcntKPQcWzGLv2o3oK4ko2itlb
DJZmTNTWj6M7ZhtfF7opiBHHtimsNa9PnW1Tpx6B2LBqr+DUNQ4F4WXV1VeB6DaLOYtZQr88w1Xx
D7bQsAuONaLAya9HG0pREs38JZZV64PzKrSjXL/tEqQNsNq9gwcY4q4ScndPRsAO+sPL4ia91dWN
N0VrCgYA3sath6vjoJNFrPN4dBDHUZwcZ5H8Thw1hqZztLajG06DWgFublHrzWZFDrSLei96Z7os
zN/U+zbdviMZu+j4kh6LicyDJnpaFfw6ITk2x6TlK0/FbX6Qo2OQ5AtZU1O91984gI0GQkG5Tk1x
p3cD5evWwY5TuNFKKCkwbNOsCeQL4GrxDMcOirmZmALDvhq6oAvf73BqOiqPh/6rUMaJFJUYRM/O
TjBuuBInJnhK/aIg5LKIR+NANyn8XUe4TfOXlNi2OAhvHBoq+T1GhaV9LGP3USH6vzCg3Jgo+zdM
nfOWsQi7YZ/B2IZTn5hNgxH4/8JoCgOloMAEs2EPJvkrzFFjChMvV5ktPe+kanclZWedW9AGxpRV
9yMKr+TifnRe+MB7ODFtcHV9iwcvdUO97kGdZs8IyYDR/p5UK3ydGEezDM3Y3awsqgsP0TpADz4t
UvH6eNz3jGkdTaYl3k2wuEM32HtHI/c5ILfiQA6MRoDdweJbA1obIhiZa0H9HFUfb6bls/7BjUPx
jNO2fpuhKh3rIo9fY23GZqY+Mgsdj4J29QlVkHqX1KFa3aTO9WgrX++ofjfyd0EBVvTl9kYDoJ25
9zMENjN5SREW0tQ3iMB1tttHCDbzX9G7roPD0dZ7C/ft2v0GNiz7tzVu6Pv4jVj5+ARFKUaHZ0Ha
7CoCam6aRn0/1y2tCn/vaVqtMXrRs8E4rcdf13bWukGG48OI7q4brR1Dfd/BPDDWpma3BaZ2nZZd
IlQFRaIoV5v63WGK9l2rLXNV0GUz+N/mA7FhHIhXLcOs6LE8XfoLp3TbEdZohOU0jI00/mWattGA
rxbqbcpDGF9FxU2wTUWS2E7xkTWoOis7pqbTtgAQsmDOflNQBcLcAj6cu8td4qstoGskOEyru3Ab
Y2pggATEzQXGnXhDEb53F+T84rKQjM1yjGLqKjPo7t2BXJxjcUJ8GnaRhGgCzWGRw0XQCX0Ms2He
ZltnlJlaXT+WESgwoztYld3HdDmwqWLBr9muOn8W73nivF3sst5r2P7X//ifG9BVVwEodbS1aG5F
prUxwj7ybBNHFJRwrKhsNMwZYKuHJHfMFGkKTW6czIvZKnksekujBgO4PoGG6YhSrS6eavZE0OWY
ck2TXxSV0DnDYk899kbUSRAlUo9/HN317+5HP5JoGUjBdfxjtmHHWGD4x3z7Hv+4WginfBHAl5gE
d/zjLJmM8XI4rDy0C/1jZoingufHP+YdjOXTHT8WtJpMEw9c7kCryXv6N6N18Rz6oTvOPeycXr6V
XoMZilnV+V0ujP8JKyqitPaC8FlU8BL7M5YJRuJEXixkjI7TPCAZXLlopgmWhbXTRNi8x/93TcTR
0RN83Hk6sL4s34nVuMN6xjej+miVxEeYuzt3Fzmx5lZiTUM8ircbseY3IxZoHMPvUqBlZ1JtTdR3
2I1U65uS+gC/nu5MqeOAWtF3odTSWc/+ZpSm3tJfzZc5nVY7nbuHlZptlJ0t0o0HHxuF/LtgBlOA
UiJ5WXiPcbTA1+Yn6AytlkIVh9PVEqshlLJ+J5r2RLxZrbv4XNUiSLFGTnmDLtlI0poC3M/U2GsB
NhK4n5V8LZGo5oCOMU3xNGy4WK6A1YfRFyD+ZJWmYHrhZYLswfajq+tfR7+N7gY9TZOfT+5H+Hl4
PdROtVP8KFDIv7USv2VwbpfnJYi41s2n4cfbk88lhM053krfkyJEcl0jgxZILU0DN/ezfFreW66m
oMR6JHoO4jgUV3xOLm9GRNT1xxr04+HoTFwKURBY4iLtlnFc5OPgGHyn4pB5aVBNG6deBIbWED/L
ek3k7vRG5s2eRQ/kDhRoXKnWiyhsU8f6MxJFB1AoH/NX67Sv08C3tQlgRKb7ghh9wDgYXN6QrBh2
gdFkUrK1YFTqV3fJYwBsPgGP9NjUsGA8OVhEX4R3fCwKlTTxr3gzKrtUVzCeSPwSrzKpvIfvGXMd
D5DzlT4lo2XgPmEit7LOeRmco6WXLJ9idX3ZrrtoV4Nzl0jGhwgICrM0Zbmt8zzocIvgaJ4eUdiU
0iOsbnokMpPfhg8uFlE9Tx8xHqUWXKrOINdMi9du5hUX4MTVxPxxuORBkyeV2o4yDWWoYChZMXQ/
rbHzTG2c8Exgib0B/mgu64VWLeZ5k3APPMxbzzxZDMMdjR5XqSjAA64nXtD5P7Vc/8exb1xPunE9
N4KyPVlh1zXIWNoEl0i38KkPnAhG6dn1+gSIaqIdraPnT1vlHD9891t+9/1gHopHanvLx5cxSsHj
KtQh3k4/HvRP3xQ9WxZ1HGtj1dwrLOAUJuQMyC/gHHxd3d6JYvoqiuk6xbss29bts5/5kAeEBLZK
KileBXWwHtDGQrQNc2d1dY1peHi4w9yxV80d22numvciXtkeZze2jbq46pe3MfGtopq2w6gVbt+p
Z5gdblt2x5laXsfFclBM597E9aoRDgssJVCHxsZauY1TaOmW2DCYBQfEOI6tO+aTJCpaFLdtjS4h
wziMxMOmHSbf20mTHgWbKI6SpJcDXoya56hfns+3jHcCA7Y624a8J9dBX68xdjNuzZ8Z2sr163e2
3HD2An5dKgq2oeuWv24XbrS+NyBaLR9iYCahCMVt51diBOMljHxQ6uJW9c1iFsLE4w1mmZuIkhrd
tYvisvN+9IaJhwch2Ts28qI1cJKHUeEvQVBxIKyuY1jiKd9zzFDr5S+U/iSNtZ/EE5gzrAfwUq0r
MomEst7dx5LTGEepPHqIplj4gFQ82owgyxDB/pPZKkhB3zxiADoOMAWPsC5jSkN876zxBbuTq/vz
u5ubu3fNj9ghsG3oVKv0ImquShEiVlimgyGx88wpXHseBhHh1VljDVEiL03IZ36b4SzxDoECd8VO
+8NtkHgxjzlYokiBHIErsgFu9/WBkXb8CS412p2v3HSnuDfA5IA1vgvmy0jcD1y3HPcRB9K9qtzu
aoBuvkZx1jlZJbkFkycdiq8qdyr2EU5yqreR0wZ+4iaw+avH8zuFKYKH1cyNCUjipwdRDxjZG2TS
PH8UCofuu8F8z1VrmaDtFj5mGz2LA0/wEjJBBiJtEKSuXwq00QJ0wGOU1k5V7K4OGsvepyLSJC3e
I0JwRzPwKGSSbwTy6IU0r+JSPmAshD9K1T889whmS775iO/UaxpFC0brTsCWncpnkEVhCZGvSzqs
6Itrmo3Za8qmk51Ni8eT87h63oMQbr0tnR502JvNR4VyWa6ihwd56FhNH98Aie8KnYzOAMTDmgOj
xwCUCibsZY6HshCmha/UfSZP+GTcNQwCLyyGcboqVG/12UIdc/1N8cDy6MOgV4Ebug9rzxxie0vX
8CxBtL86uSXPVfxZVRmE2DAmcU0c5gJmTkbq8NHUXSYDdC6eUwr47Ir5Fl9/zRVqRbHn7i+4dSSH
vLdAUzJtLvAmOr5JS7J6tMKai6dPWBimcql7F0HwFm//i9ei0xe6D6AsskRU+NEmP7M9EQBXdhhH
8+VGybpOQPsu2TVp7oK8x0mTT/xm07knhzSJQ2HjbRSIOw5xF1J3RLVNMuyIpn0z7rfqosZWR+6r
bUqxDUdDiZFd1JcIbtyuFuIBYFgd8fLhTrGltkjJJmRSGHKtSznlaOO66SOlT+Oy9J4pHMYeOenf
EvSV8/J9n/ICfFyUBu/gR0M+dC3ea/pcojaoIV/5aEE9GOF1FjTFkl7+OoCAM8Vjua1wX7yFaRsG
efxS1DrmWIPWtqzmh8F/uRye3t7dNpvgHEttmkbNjgWVipUUl+J5Ze0r8TQ9U7A90qG07Fa3nLXH
nVqc7fsl6RCKL3cdXayAzztkOsOKWVnyZvz1KP1a4rUtjg/e4FPZPdI/O7s9vbm+OIDRnZ1/GJ++
61+/PX/TK/oQBcEnARbwSUTVtHJ0sFA6Fm2fP4b4H76OKO0DaSwsxcnDzbXS3hARmLK9PJxA1Rik
YE1nWfUFgGlrBs58CfDRBfUky+8ILwa6CXAzkNHJFVZqG4SytIp8sQz/t7HaEGmtHCTlOyJob4Jl
7RY9IoiluF6Gvom78MXjMfSpfWXys2QW+HlCRGKf/CXwO/g58jPMsId2VDYjFF+JF88ttXYy/TLO
L3JpX4GdPG3CPfx2sgpn/hiTIJIUTDWCz5ECv3UYJxrvwd9FG+j5l9Px5aD/9nz84fx2dHlzPR7d
3V5evz3+eNW/7r4bDbu0Szsasx0G//5y2oevRh+HV+MPdPyBjUeXV5fAU/8eX13enedvsgLxBj4p
STcQD07Vs7hfDd5lfzQcFJX5cJ3d5wgoG7y7JAMmXo2bBfOkwO2AtNHNVtzky2xprr3l9AVWUZNs
snWVsfAcNsxrzfTID99LhmoHVetk/k0no8GQDG/PzwfDOzKABToLPGISavSY0dM1cnp+J1YFS2eN
TY6d3T0Guf+D+ZXebOXn5jtmhq7xtoylEPQIpnEQACNNU/QP/v7D99g++OqC0wCTKp+vRiaBvTNP
ZOQctE7hbCEGP8ACcBOZBAfgP3wfLvzwOfTBpJVRDZHyiSkhySMAHPmRd/R/H3nR8iUOHx4x0bVh
+0lBIobQPxndXN3fnV/9Rq5vyMf+7W3/+u63Q1xsSS2G/374fimMUhQqkxfxtAzoQEzvm7lfoIsr
rIuYrVE+qXJWdaun2+WsRsWeDsULsP/x6T9hZ/FHXNh/ta5h7//5G5Htf/g+g5gBSY8vfwNE3xWK
OOMv+Oq7cArTFHzFmu/fffcF8xHEo9TffYdBX4KFT42eSXuM9lyr50zwN+LUS0ZgfPHzVyk7Nay/
6Z/Mi653IBb2AzWsLrcs8QyNDHLMijeoMSUW65Ydii0E8/giFn8RLTqeC38L+yI7kgXCA8yH8TjD
IrYmN3VZvpV8+hts45yVka3f90f9a1jF4d2l2JKCBJBVGP4Rv+vB+F4mME8gYTryZemOKwsDAhPJ
55g/4fPJXLMZxU4mTKd2Z+2r6eeyA8eieHB/OrzHEqXDyzP8B9M1eyIADIxzpIm6hKkbiisF1Q1Z
IDKw5htQ+g6EsHCnUUaI097zBTAW8Gt/eH8E/x3KQ3gOAkVzjjT7iGmUK2iAIJBBt5dDnCeq9ZKn
IjVvjMbxz8AKE+1I+2p4WglGuYHJXKfinizMLvyf28SeEMsgzBafDTI1iTYlNic+y9pgMw2/9+BX
VPzWIK6u/NYmE7v8Uf5/CtpgSvypQOuQKcMPHoXtT8AS+Yet/ZPoHtFkJwKlr+NvVLo0k0xc0afS
FSADrNq0HJeu6/hu2u1ITge+gTmd2jYwlOVpjmdo5Pziqv92JJiKwh41FVhgaliR2/6vPUALf7zi
0RiN3J7AtzkyjXvmxPfg21P4luLXFLnFAuYz/BIjN+TinP0q+rOpVrI10HiJ31Y4zYW2l0o/+oS7
LLBLjAazBY0nw3orpEazlYduCso1p0Z54FglRnyMDDFSTbYKfKTGsX0LVv2W0jWMFL5l670rGC1R
LPmW6vV+LQ++5cq3nslpYNjwrVFvaysYLa7jPF7Asq2N7wD/ekNgSdWlVn7ztJi9xaSc6p8Suc04
PnR8KpFTjZyNMpFznn84vdXKaQACDRi1spVtm2K87fSWyVaG4euuY0xNywJlcKuXsNTyWIaR1ybW
nCo0gVmHNc1PsZycuIzcU35n2WgBk39c3v7yT+Vrx0ZjhPwnGcful/EXrEE8xlOKcRj/8TOK1SP8
qwAwNfCWEA/mR6/mwRgEBzRzptCMemo7y8RXYnMzxwvG6ddxFhkdewijBwhk+yCkZaNSXppUZ3gl
GckaiyKw48njWEaxxuESgS2EVfqjlonXSQGi7BHmAezTZbgMkp+FJJPyrKE/potE+xL6EbpM4sXD
WIp+6NtHkehjt0YjyQxfSKoMGKQ6wKFYHmdXc3GmzAmg8MwmFCDbsQx2vhjJMlwUa5G4zwLcBWhl
zU3dsbGYXD5TT+MUrJGxqAAKzW2cpbIx1y3DqU1SfVlgQVqXBQvo5p19cZ+C8Wo5BocXZ0ZDKKrs
ENPQhfcmGsMAxstVOkZLbQxOORCKQEieo4JYDvoMim0sKHSTp1mAvZhcdpKThi0U8kydO5IHMpAx
ngzG4wSjFADOrRozw1bDsGnR3BV2xxgzRaNFF1k8hblZdjUAZhxHyHwF3NLFsRWMz4/GaMHKPZMp
zomjtLSEuMxmIvgapuPYW/2MjIAjshSktiYqaRFJxFiE3ePVEofvOsg6altuCob5x1FlV5s2FqPC
7+/6o/fq97YttpWbzMcN+GlwhJ5c2d6B8THVTPCWq9CHPShcWeSyFJmSOjgK11QhQbjZuaUAajwA
tRsQB3T0hEwDYmuou9Gj04jFCbWI4xGQ6KDHKSh8npsAYDJwoeKFfgcMoNDlr3SaoXUpmTgkmCLa
6YSYZh3JP7jxT4QGqwrR2MRgipngE1CqgUH4hNjQgBOTE+5kn8GIQXuh1M2goxzc5VVLQagQx9Us
P6hYCpgnWVoK+Bo53gzYxVIA7cjFt4WlIKwF5liW4SkYHVESQFgKuT1BbUABjCkthZI8TaeY1lix
FEDngRazSwlh6bjHFUtBwgaB5rNmS4FVLQWB0WOTEiPXRcXaiqUgaYQ12WAp1PspMRqwQ3JLYZ0a
WqhIxl3XmPiuY5WWQjGeQFNGDXIHz5MqgldKKdyv4GHgPS6UAUZ1g1gg9XUJmIbQeBE9/jkWGwQg
lmP8DhWP49S2B+oqXDhS2U8ooVC8u0pD8BuEYgIBgw1R80kdpKuNuEWltsTC1piSK4lAOYNItRrV
li1KoWDvUlOAGAcK4hexl1HKKY1tZltIgWg4fhJ3epEM24eGuqusNNYPwMlIApCcvhu/FMhNDlOD
4Z5win0I+ThRIB1qYuISyLGqwMK7oogyq+MgQnzCy++RP+I0HmO4DT+owRT8Tv5I/piH40eR4J7g
RTgwgCjF47GxO/fl8SX8Hacz4nlL+DTx5gRVPh5/wo8oGWfQ5QQmlZPgGR3kWeAnY3BnlWNOwEeS
hQ99y39TcTr+O8YBYpzUaPkyxgre3vRBEgCNSPLoGpSNkyQJ9PyHMruUJHieLMgA9pu8LPFdIQ+G
KRNBiB9PHgje8IOlRtRPVEuD+ZIEnv9YoMnOnQLPU7Kmy4xmNXk7S8HGmiOiUkdRTYWEwMTi7jb5
mn/IatjLfBkv9nTmFX3Cj9Qk84l4roL8PgFfIPHx6hBJqQaGGDYYw0c/nOJH+UmFzr6Rugnf3MHj
6HH+RJF4wQXXGF/jFiuD/+bvushHUPHX+WuooknqZoHpOHBnafBE5n4YgSHyDNs6P+wW6b2CzpCh
wRh+5aLjjA7x2+wzoFw+vhQcasNGxJ3c6XQ+ETAS8eolHpF7JmNg4fsO80EX2uQzNFCAYF/re7vf
tskMNN/+/+Z+gyOko6/wGvfbttGI+5butw0yx+Df0v3GZyUxN+rbud8OdI+G+Ldzv/FeOZ44fTv3
Gx+6Rd34v8X9dnTNQZX3evfb0WW2/7dzvx2ui5fks7IXS3cBMq0j3grBu1Xh4qFHLmBvg0z+6gVL
EeEMF6QwwEtEhiaeWc0Q3UynSZBCxygMBB3iSADPXzJ7hmZMcwAiJMpqOYtAZU9tlZHcKb+aZP++
Kbs2KcUiV4U4e+1gMoH3/wJQSwECFAMUAAAACAA5foZT5+2jZA9OAAB3DwEACwAAAAAAAAAAAAAA
pIEAAAAAc2NyZWVubG9nLjBQSwUGAAAAAAEAAQA5AAAAOE4AAAAA


--nextPart1643539.SFto10UAbY
Content-Disposition: attachment; filename="station_connect_crash_decoded.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; name="station_connect_crash_decoded.txt"

general protection fault, probably for non-canonical address 0xe0080c4200016463: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x00408210000b2318-0x00408210000b231f]
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc1+ #3
Hardware name: PC Engines APU/APU, BIOS 4.0 09/08/2014
RIP: 0010:skb_release_data (./include/linux/skbuff.h:1549 net/core/skbuff.c:669) 
Code: 00 00 48 8b 75 28 48 85 f6 0f 84 d2 00 00 00 40 f6 c6 01 0f 85 a3 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 d3 03 00 00 48 8b 06 ba 01 00 00 00 48 89 df 0f
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	48 8b 75 28          	mov    0x28(%rbp),%rsi
   6:	48 85 f6             	test   %rsi,%rsi
   9:	0f 84 d2 00 00 00    	je     0xe1
   f:	40 f6 c6 01          	test   $0x1,%sil
  13:	0f 85 a3 00 00 00    	jne    0xbc
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df 
  23:	48 89 f2             	mov    %rsi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	0f 85 d3 03 00 00    	jne    0x407
  34:	48 8b 06             	mov    (%rsi),%rax
  37:	ba 01 00 00 00       	mov    $0x1,%edx
  3c:	48 89 df             	mov    %rbx,%rdi
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 d3 03 00 00    	jne    0x3dd
   a:	48 8b 06             	mov    (%rsi),%rax
   d:	ba 01 00 00 00       	mov    $0x1,%edx
  12:	48 89 df             	mov    %rbx,%rdi
  15:	0f                   	.byte 0xf
RSP: 0018:ffff8880c7c09c50 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff888004c6bdc0 RCX: 1ffff1100076945d
RDX: 0008104200016463 RSI: 00408210000b231a RDI: ffff888003b4a2e8
RBP: ffff888003b4a2c0 R08: 0000000000000000 R09: ffff888004c6be97
R10: ffffed100098d7d2 R11: 0000000000000001 R12: ffff888003b4a2c0
R13: ffff888004c6be7c R14: ffff88800c641e58 R15: ffff888004c6be80
FS:  0000000000000000(0000) GS:ffff8880c7c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d3a95f6778 CR3: 0000000017c20000 CR4: 00000000000006f0
Call Trace:
<IRQ>
? _raw_write_lock_irq (kernel/locking/spinlock.c:177) 
consume_skb (net/core/skbuff.c:757 net/core/skbuff.c:912 net/core/skbuff.c:906) 
ath11k_ce_tx_process_cb (drivers/net/wireless/ath/ath11k/ce.c:515) ath11k
? __local_bh_enable_ip (./arch/x86/include/asm/preempt.h:103 kernel/softirq.c:390) 
? ath11k_ce_alloc_pipes (drivers/net/wireless/ath/ath11k/ce.c:500) ath11k
? ath11k_hal_srng_access_end (drivers/net/wireless/ath/ath11k/hal.c:849) ath11k
ath11k_ce_per_engine_service (drivers/net/wireless/ath/ath11k/ce.c:694) ath11k
? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:202 ./include/linux/atomic/atomic-instrumented.h:513 ./include/asm-generic/qspinlock.h:82 ./include/linux/spinlock.h:185 ./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
? __lock_text_start (kernel/locking/spinlock.c:161) 
? ath11k_ce_tx_process_cb (drivers/net/wireless/ath/ath11k/ce.c:689) ath11k
? __wake_up_bit (kernel/sched/wait_bit.c:192) 
? __irq_put_desc_unlock (kernel/irq/irqdesc.c:819) 
ath11k_pci_ce_tasklet (drivers/net/wireless/ath/ath11k/pci.c:637) ath11k_pci
? tasklet_clear_sched (kernel/softirq.c:752) 
tasklet_action_common.constprop.0 (kernel/softirq.c:783) 
__do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:212 ./include/trace/events/irq.h:142 kernel/softirq.c:559) 
__irq_exit_rcu (kernel/softirq.c:432 kernel/softirq.c:636) 
common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14)) 
</IRQ>
<TASK>
asm_common_interrupt (./arch/x86/include/asm/idtentry.h:629) 
RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:259) 
Code: ff e8 8e 95 db fe 80 3c 24 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 8e 06 00 00 31 ff e8 a1 b9 ef fe fb 66 0f 1f 44 00 00 <45> 85 ed 0f 88 52 03 00 00 4d 63 e5 4b 8d 04 64 49 8d 04 84 48 8d
All code
========
   0:	ff                   	(bad)  
   1:	e8 8e 95 db fe       	callq  0xfffffffffedb9594
   6:	80 3c 24 00          	cmpb   $0x0,(%rsp)
   a:	74 17                	je     0x23
   c:	9c                   	pushfq 
   d:	58                   	pop    %rax
   e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  13:	f6 c4 02             	test   $0x2,%ah
  16:	0f 85 8e 06 00 00    	jne    0x6aa
  1c:	31 ff                	xor    %edi,%edi
  1e:	e8 a1 b9 ef fe       	callq  0xfffffffffeefb9c4
  23:	fb                   	sti    
  24:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  2a:*	45 85 ed             	test   %r13d,%r13d		<-- trapping instruction
  2d:	0f 88 52 03 00 00    	js     0x385
  33:	4d 63 e5             	movslq %r13d,%r12
  36:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  3a:	49 8d 04 84          	lea    (%r12,%rax,4),%rax
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d

Code starting with the faulting instruction
===========================================
   0:	45 85 ed             	test   %r13d,%r13d
   3:	0f 88 52 03 00 00    	js     0x35b
   9:	4d 63 e5             	movslq %r13d,%r12
   c:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  10:	49 8d 04 84          	lea    (%r12,%rax,4),%rax
  14:	48                   	rex.W
  15:	8d                   	.byte 0x8d
RSP: 0018:ffffffff89a07de0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff888003b44000 RCX: 1ffffffff129775c
RDX: 1ffff11018f88331 RSI: ffffffff89031b00 RDI: ffff8880c7c41988
RBP: ffffffff89ee0d20 R08: 0000000000000002 R09: ffff8880c7c41c2b
R10: ffffed1018f88385 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000002 R14: 00000024aa5bda97 R15: ffffffff89ee0e08
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
? tick_nohz_idle_stop_tick (./include/linux/hrtimer.h:419 kernel/time/tick-sched.c:920 kernel/time/tick-sched.c:1062 kernel/time/tick-sched.c:1083) 
cpuidle_enter (drivers/cpuidle/cpuidle.c:353) 
do_idle (kernel/sched/idle.c:158 kernel/sched/idle.c:239 kernel/sched/idle.c:306) 
? arch_cpu_idle_exit+0x40/0x40 
cpu_startup_entry (kernel/sched/idle.c:402 (discriminator 1)) 
start_kernel (init/main.c:1137) 
secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:283) 
</TASK>
Modules linked in: qrtr_mhi qrtr ath11k_pci mhi ath11k qmi_helpers mac80211 kvm_amd btusb btrtl ccp btbcm rng_core btintel libarc4 evdev leds_apu bluetooth kvm snd_pcm snd_timer jitterentropy_rng cfg80211 snd sha512_ssse3 sha512_generic sg soundcore irqbypass ctr pcspkr drbg ansi_cprng k10temp ecdh_generic rfkill ecc sp5100_tco watchdog acpi_cpufreq button drm fuse configfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_common uas usb_storage ohci_pci ahci libahci ohci_hcd ehci_pci ehci_hcd libata r8169 realtek mdio_devres usbcore scsi_mod i2c_piix4 usb_common scsi_common libphy
---[ end trace dc622588d92d6988 ]---
RIP: 0010:skb_release_data (./include/linux/skbuff.h:1549 net/core/skbuff.c:669) 
Code: 00 00 48 8b 75 28 48 85 f6 0f 84 d2 00 00 00 40 f6 c6 01 0f 85 a3 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 f2 48 c1 ea 03 <80> 3c 02 00 0f 85 d3 03 00 00 48 8b 06 ba 01 00 00 00 48 89 df 0f
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	48 8b 75 28          	mov    0x28(%rbp),%rsi
   6:	48 85 f6             	test   %rsi,%rsi
   9:	0f 84 d2 00 00 00    	je     0xe1
   f:	40 f6 c6 01          	test   $0x1,%sil
  13:	0f 85 a3 00 00 00    	jne    0xbc
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df 
  23:	48 89 f2             	mov    %rsi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	0f 85 d3 03 00 00    	jne    0x407
  34:	48 8b 06             	mov    (%rsi),%rax
  37:	ba 01 00 00 00       	mov    $0x1,%edx
  3c:	48 89 df             	mov    %rbx,%rdi
  3f:	0f                   	.byte 0xf

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	0f 85 d3 03 00 00    	jne    0x3dd
   a:	48 8b 06             	mov    (%rsi),%rax
   d:	ba 01 00 00 00       	mov    $0x1,%edx
  12:	48 89 df             	mov    %rbx,%rdi
  15:	0f                   	.byte 0xf
RSP: 0018:ffff8880c7c09c50 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff888004c6bdc0 RCX: 1ffff1100076945d
RDX: 0008104200016463 RSI: 00408210000b231a RDI: ffff888003b4a2e8
RBP: ffff888003b4a2c0 R08: 0000000000000000 R09: ffff888004c6be97
R10: ffffed100098d7d2 R11: 0000000000000001 R12: ffff888003b4a2c0
R13: ffff888004c6be7c R14: ffff88800c641e58 R15: ffff888004c6be80
FS:  0000000000000000(0000) GS:ffff8880c7c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d3a95f6778 CR3: 0000000017c20000 CR4: 00000000000006f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x5c00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

--nextPart1643539.SFto10UAbY
Content-Disposition: attachment; filename="station_connect_crash2_decoded.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="station_connect_crash2_decoded.txt"

general protection fault, probably for non-canonical address 0xe0080c4200016463: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x00408210000b2318-0x00408210000b231f]
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc1+ #1
Hardware name: PC Engines APU/APU, BIOS 4.0 09/08/2014
RIP: 0010:skb_zcopy_clear (./include/linux/skbuff.h:1549) 
Code: e8 9a fe ff ff 48 85 c0 74 62 48 89 c5 48 89 df e8 ad ff ff ff 84 c0 75 2a 48 89 ea 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 75 41 41 0f b6 d4 48 8b 45 00 48 89 ee 48 89 df 0f ae
All code
========
   0:	e8 9a fe ff ff       	callq  0xfffffffffffffe9f
   5:	48 85 c0             	test   %rax,%rax
   8:	74 62                	je     0x6c
   a:	48 89 c5             	mov    %rax,%rbp
   d:	48 89 df             	mov    %rbx,%rdi
  10:	e8 ad ff ff ff       	callq  0xffffffffffffffc2
  15:	84 c0                	test   %al,%al
  17:	75 2a                	jne    0x43
  19:	48 89 ea             	mov    %rbp,%rdx
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df 
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	75 41                	jne    0x71
  30:	41 0f b6 d4          	movzbl %r12b,%edx
  34:	48 8b 45 00          	mov    0x0(%rbp),%rax
  38:	48 89 ee             	mov    %rbp,%rsi
  3b:	48 89 df             	mov    %rbx,%rdi
  3e:	0f                   	.byte 0xf
  3f:	ae                   	scas   %es:(%rdi),%al

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	75 41                	jne    0x47
   6:	41 0f b6 d4          	movzbl %r12b,%edx
   a:	48 8b 45 00          	mov    0x0(%rbp),%rax
   e:	48 89 ee             	mov    %rbp,%rsi
  11:	48 89 df             	mov    %rbx,%rdi
  14:	0f                   	.byte 0xf
  15:	ae                   	scas   %es:(%rdi),%al
RSP: 0018:ffff8880c3a09c30 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff88800c233b40 RCX: ffffffff9fce961b
RDX: 0008104200016463 RSI: 0000000000000001 RDI: ffff888015edeae8
RBP: 00408210000b231a R08: 0000000000000000 R09: ffff88800c233c17
R10: ffffed1001846782 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88800c233bbe R14: ffff88800b701e58 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880c3a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdccf1c75c0 CR3: 00000000063a4000 CR4: 00000000000006f0
Call Trace:
<IRQ>
skb_release_data (net/core/skbuff.c:671) 
skb_release_all (net/core/skbuff.c:743) 
__kfree_skb (net/core/skbuff.c:757) 
consume_skb (net/core/skbuff.c:912) 
__dev_kfree_skb_any (net/core/dev.c:3038) 
ath11k_ce_tx_process_cb (drivers/net/wireless/ath/ath11k/ce.c:515) ath11k
? __local_bh_enable_ip (./arch/x86/include/asm/preempt.h:103 kernel/softirq.c:390) 
? ath11k_ce_alloc_pipes (drivers/net/wireless/ath/ath11k/ce.c:500) ath11k
? ath11k_hal_srng_access_end (drivers/net/wireless/ath/ath11k/hal.c:849) ath11k
ath11k_ce_per_engine_service (drivers/net/wireless/ath/ath11k/ce.c:694) ath11k
? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:202 ./include/linux/atomic/atomic-instrumented.h:513 ./include/asm-generic/qspinlock.h:82 ./include/linux/spinlock.h:185 ./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
? __lock_text_start (kernel/locking/spinlock.c:161) 
? ath11k_ce_tx_process_cb (drivers/net/wireless/ath/ath11k/ce.c:689) ath11k
? __wake_up_bit (kernel/sched/wait_bit.c:192) 
? __irq_put_desc_unlock (kernel/irq/irqdesc.c:819) 
ath11k_pci_ce_tasklet (drivers/net/wireless/ath/ath11k/pci.c:637) ath11k_pci
? tasklet_clear_sched (kernel/softirq.c:752) 
tasklet_action_common.constprop.0 (kernel/softirq.c:783) 
__do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:212 ./include/trace/events/irq.h:142 kernel/softirq.c:559) 
__irq_exit_rcu (kernel/softirq.c:432 kernel/softirq.c:636) 
common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14)) 
</IRQ>
<TASK>
asm_common_interrupt (./arch/x86/include/asm/idtentry.h:629) 
RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:259) 
Code: ff e8 8e 95 db fe 80 3c 24 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 8e 06 00 00 31 ff e8 a1 b9 ef fe fb 66 0f 1f 44 00 00 <45> 85 ed 0f 88 52 03 00 00 4d 63 e5 4b 8d 04 64 49 8d 04 84 48 8d
All code
========
   0:	ff                   	(bad)  
   1:	e8 8e 95 db fe       	callq  0xfffffffffedb9594
   6:	80 3c 24 00          	cmpb   $0x0,(%rsp)
   a:	74 17                	je     0x23
   c:	9c                   	pushfq 
   d:	58                   	pop    %rax
   e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  13:	f6 c4 02             	test   $0x2,%ah
  16:	0f 85 8e 06 00 00    	jne    0x6aa
  1c:	31 ff                	xor    %edi,%edi
  1e:	e8 a1 b9 ef fe       	callq  0xfffffffffeefb9c4
  23:	fb                   	sti    
  24:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  2a:*	45 85 ed             	test   %r13d,%r13d		<-- trapping instruction
  2d:	0f 88 52 03 00 00    	js     0x385
  33:	4d 63 e5             	movslq %r13d,%r12
  36:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  3a:	49 8d 04 84          	lea    (%r12,%rax,4),%rax
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d

Code starting with the faulting instruction
===========================================
   0:	45 85 ed             	test   %r13d,%r13d
   3:	0f 88 52 03 00 00    	js     0x35b
   9:	4d 63 e5             	movslq %r13d,%r12
   c:	4b 8d 04 64          	lea    (%r12,%r12,2),%rax
  10:	49 8d 04 84          	lea    (%r12,%rax,4),%rax
  14:	48                   	rex.W
  15:	8d                   	.byte 0x8d
RSP: 0018:ffffffffa1407de0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff888003b20800 RCX: 1ffffffff41d935c
RDX: 1ffff11018748331 RSI: ffffffffa0a31b00 RDI: ffff8880c3a41988
RBP: ffffffffa18e0d20 R08: 0000000000000002 R09: ffff8880c3a41c2b
R10: ffffed1018748385 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000002 R14: 0000001dfc72dae5 R15: ffffffffa18e0e08
? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/preempt.h:103 ./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194) 
? tick_nohz_idle_stop_tick (./include/linux/hrtimer.h:419 kernel/time/tick-sched.c:920 kernel/time/tick-sched.c:1062 kernel/time/tick-sched.c:1083) 
cpuidle_enter (drivers/cpuidle/cpuidle.c:353) 
do_idle (kernel/sched/idle.c:158 kernel/sched/idle.c:239 kernel/sched/idle.c:306) 
? arch_cpu_idle_exit+0x40/0x40 
cpu_startup_entry (kernel/sched/idle.c:402 (discriminator 1)) 
start_kernel (init/main.c:1137) 
secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:283) 
</TASK>
Modules linked in: qrtr_mhi qrtr ath11k_pci mhi ath11k qmi_helpers mac80211 kvm_amd btusb btrtl btbcm ccp btintel libarc4 rng_core evdev bluetooth cfg80211 kvm leds_apu jitterentropy_rng sha512_ssse3 sha512_generic snd_pcm ctr sg drbg snd_timer irqbypass ansi_cprng snd ecdh_generic rfkill soundcore ecc pcspkr k10temp sp5100_tco watchdog button acpi_cpufreq drm fuse configfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_common uas usb_storage ohci_pci ahci libahci libata ehci_pci ohci_hcd r8169 ehci_hcd realtek mdio_devres scsi_mod usbcore i2c_piix4 usb_common scsi_common libphy
---[ end trace bd73d57ff2669c03 ]---
RIP: 0010:skb_zcopy_clear (./include/linux/skbuff.h:1549) 
Code: e8 9a fe ff ff 48 85 c0 74 62 48 89 c5 48 89 df e8 ad ff ff ff 84 c0 75 2a 48 89 ea 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 75 41 41 0f b6 d4 48 8b 45 00 48 89 ee 48 89 df 0f ae
All code
========
   0:	e8 9a fe ff ff       	callq  0xfffffffffffffe9f
   5:	48 85 c0             	test   %rax,%rax
   8:	74 62                	je     0x6c
   a:	48 89 c5             	mov    %rax,%rbp
   d:	48 89 df             	mov    %rbx,%rdi
  10:	e8 ad ff ff ff       	callq  0xffffffffffffffc2
  15:	84 c0                	test   %al,%al
  17:	75 2a                	jne    0x43
  19:	48 89 ea             	mov    %rbp,%rdx
  1c:	48 c1 ea 03          	shr    $0x3,%rdx
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df 
  2a:*	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)		<-- trapping instruction
  2e:	75 41                	jne    0x71
  30:	41 0f b6 d4          	movzbl %r12b,%edx
  34:	48 8b 45 00          	mov    0x0(%rbp),%rax
  38:	48 89 ee             	mov    %rbp,%rsi
  3b:	48 89 df             	mov    %rbx,%rdi
  3e:	0f                   	.byte 0xf
  3f:	ae                   	scas   %es:(%rdi),%al

Code starting with the faulting instruction
===========================================
   0:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   4:	75 41                	jne    0x47
   6:	41 0f b6 d4          	movzbl %r12b,%edx
   a:	48 8b 45 00          	mov    0x0(%rbp),%rax
   e:	48 89 ee             	mov    %rbp,%rsi
  11:	48 89 df             	mov    %rbx,%rdi
  14:	0f                   	.byte 0xf
  15:	ae                   	scas   %es:(%rdi),%al
RSP: 0018:ffff8880c3a09c30 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff88800c233b40 RCX: ffffffff9fce961b
RDX: 0008104200016463 RSI: 0000000000000001 RDI: ffff888015edeae8
RBP: 00408210000b231a R08: 0000000000000000 R09: ffff88800c233c17
R10: ffffed1001846782 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88800c233bbe R14: ffff88800b701e58 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880c3a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdccf1c75c0 CR3: 00000000063a4000 CR4: 00000000000006f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x1d800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

--nextPart1643539.SFto10UAbY
Content-Disposition: attachment; filename="station_connect_crash2.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="station_connect_crash2.txt"

general protection fault, probably for non-canonical address 0xe0080c4200016463: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x00408210000b2318-0x00408210000b231f]
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc1+ #1
Hardware name: PC Engines APU/APU, BIOS 4.0 09/08/2014
RIP: 0010:skb_zcopy_clear+0x34/0x8f
Code: e8 9a fe ff ff 48 85 c0 74 62 48 89 c5 48 89 df e8 ad ff ff ff 84 c0 75 2a 48 89 ea 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 75 41 41 0f b6 d4 48 8b 45 00 48 89 ee 48 89 df 0f ae
RSP: 0018:ffff8880c3a09c30 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff88800c233b40 RCX: ffffffff9fce961b
RDX: 0008104200016463 RSI: 0000000000000001 RDI: ffff888015edeae8
RBP: 00408210000b231a R08: 0000000000000000 R09: ffff88800c233c17
R10: ffffed1001846782 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88800c233bbe R14: ffff88800b701e58 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880c3a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdccf1c75c0 CR3: 00000000063a4000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 skb_release_data+0x91/0x1de
 skb_release_all+0x3e/0x47
 __kfree_skb+0xe/0x18
 consume_skb+0x24/0x26
 __dev_kfree_skb_any+0x2a/0x2b
 ath11k_ce_tx_process_cb+0x3ef/0x8d0 [ath11k]
 ? __local_bh_enable_ip+0x37/0x80
 ? ath11k_ce_alloc_pipes+0x5c0/0x5c0 [ath11k]
 ? ath11k_hal_srng_access_end+0x1d7/0x5d0 [ath11k]
 ath11k_ce_per_engine_service+0x96b/0xc60 [ath11k]
 ? _raw_spin_lock_irqsave+0x9a/0xf0
 ? __lock_text_start+0x8/0x8
 ? ath11k_ce_tx_process_cb+0x8d0/0x8d0 [ath11k]
 ? __wake_up_bit+0x100/0x100
 ? __irq_put_desc_unlock+0x18/0x90
 ath11k_pci_ce_tasklet+0x64/0x100 [ath11k_pci]
 ? tasklet_clear_sched+0x47/0xe0
 tasklet_action_common.constprop.0+0x240/0x2d0
 __do_softirq+0x1b0/0x5b9
 __irq_exit_rcu+0xc6/0x170
 common_interrupt+0xa9/0xc0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x1e/0x40
RIP: 0010:cpuidle_enter_state+0x196/0xa60
Code: ff e8 8e 95 db fe 80 3c 24 00 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 8e 06 00 00 31 ff e8 a1 b9 ef fe fb 66 0f 1f 44 00 00 <45> 85 ed 0f 88 52 03 00 00 4d 63 e5 4b 8d 04 64 49 8d 04 84 48 8d
RSP: 0018:ffffffffa1407de0 EFLAGS: 00000246
RAX: dffffc0000000000 RBX: ffff888003b20800 RCX: 1ffffffff41d935c
RDX: 1ffff11018748331 RSI: ffffffffa0a31b00 RDI: ffff8880c3a41988
RBP: ffffffffa18e0d20 R08: 0000000000000002 R09: ffff8880c3a41c2b
R10: ffffed1018748385 R11: 0000000000000001 R12: 0000000000000002
R13: 0000000000000002 R14: 0000001dfc72dae5 R15: ffffffffa18e0e08
 ? _raw_spin_unlock_irqrestore+0x25/0x40
 ? tick_nohz_idle_stop_tick+0x599/0xa60
 cpuidle_enter+0x4a/0xa0
 do_idle+0x3d7/0x530
 ? arch_cpu_idle_exit+0x40/0x40
 cpu_startup_entry+0x19/0x20
 start_kernel+0x38d/0x3ab
 secondary_startup_64_no_verify+0xb0/0xbb
 </TASK>
Modules linked in: qrtr_mhi qrtr ath11k_pci mhi ath11k qmi_helpers mac80211 kvm_amd btusb btrtl btbcm ccp btintel libarc4 rng_core evdev bluetooth cfg80211 kvm leds_apu jitterentropy_rng sha512_ssse3 sha512_generic snd_pcm ctr sg drbg snd_timer irqbypass ansi_cprng snd ecdh_generic rfkill soundcore ecc pcspkr k10temp sp5100_tco watchdog button acpi_cpufreq drm fuse configfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_common uas usb_storage ohci_pci ahci libahci libata ehci_pci ohci_hcd r8169 ehci_hcd realtek mdio_devres scsi_mod usbcore i2c_piix4 usb_common scsi_common libphy
---[ end trace bd73d57ff2669c03 ]---
RIP: 0010:skb_zcopy_clear+0x34/0x8f
Code: e8 9a fe ff ff 48 85 c0 74 62 48 89 c5 48 89 df e8 ad ff ff ff 84 c0 75 2a 48 89 ea 48 c1 ea 03 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 75 41 41 0f b6 d4 48 8b 45 00 48 89 ee 48 89 df 0f ae
RSP: 0018:ffff8880c3a09c30 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: ffff88800c233b40 RCX: ffffffff9fce961b
RDX: 0008104200016463 RSI: 0000000000000001 RDI: ffff888015edeae8
RBP: 00408210000b231a R08: 0000000000000000 R09: ffff88800c233c17
R10: ffffed1001846782 R11: 0000000000000001 R12: 0000000000000001
R13: ffff88800c233bbe R14: ffff88800b701e58 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880c3a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdccf1c75c0 CR3: 00000000063a4000 CR4: 00000000000006f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x1d800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

--nextPart1643539.SFto10UAbY
Content-Disposition: attachment; filename="station_connect_crash3.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="station_connect_crash3.txt"

general protection fault, probably for non-canonical address 0x408210000b231a: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc1+ #1
Hardware name: PC Engines APU/APU, BIOS 4.0 09/08/2014
RIP: 0010:skb_zcopy_clear+0x3f/0x70
Code: 48 89 c7 e8 81 02 00 00 48 89 45 f8 48 83 7d f8 00 74 45 48 8b 45 f0 48 89 c7 e8 ab 02 00 00 83 f0 01 84 c0 74 1e 48 8b 45 f8 <4c> 8b 00 0f b6 55 ec 48 8b 4d f8 48 8b 45 f0 48 89 ce 48 89 c7 e8
RSP: 0018:ffffb58e80003de8 EFLAGS: 00010202
RAX: 00408210000b231a RBX: ffff8aa303097b00 RCX: 0000000000000000
RDX: 0000000000000102 RSI: 0000000000000001 RDI: ffff8aa303097b00
RBP: ffffb58e80003e00 R08: 0000000000000212 R09: ffffffff922d24e8
R10: 0000000000000000 R11: 00000000db69d000 R12: ffff8aa310c69ac0
R13: ffff8aa303097b00 R14: ffff8aa3062235d8 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8aa31ac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dac9d55408 CR3: 00000001090fa000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
 skb_release_data+0x4b/0xa2
 skb_release_all+0x20/0x22
 __kfree_skb+0xe/0x18
 consume_skb+0x24/0x26
 __dev_kfree_skb_any+0x2a/0x2b
 ath11k_ce_tx_process_cb+0x157/0x220 [ath11k]
 ath11k_ce_per_engine_service+0x3c0/0x3d0 [ath11k]
 ? _raw_spin_lock_irqsave+0x26/0x50
 ath11k_pci_ce_tasklet+0x1c/0x40 [ath11k_pci]
 tasklet_action_common.constprop.0+0xaf/0xe0
 __do_softirq+0xec/0x2e9
 __irq_exit_rcu+0xbc/0x110
 common_interrupt+0xb8/0xd0
 </IRQ>
 <TASK>
 asm_common_interrupt+0x1e/0x40
RIP: 0010:cpuidle_enter_state+0xda/0x370
Code: 31 ff e8 d9 c6 9e ff 45 84 ff 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 78 02 00 00 31 ff e8 bd 97 a5 ff fb 66 0f 1f 44 00 00 <45> 85 f6 0f 88 11 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
RSP: 0018:ffffffff92203e60 EFLAGS: 00000246
RAX: ffff8aa31ac00000 RBX: 0000000000000002 RCX: 000000000000001f
RDX: 0000000000000000 RSI: ffffffff91b70667 RDI: ffffffff91b55729
RBP: ffff8aa300906c00 R08: 0000000955084e02 R09: 0000000000000018
R10: 0000000000000001 R11: 0000000000001015 R12: ffffffff923d05c0
R13: 0000000955084e02 R14: 0000000000000002 R15: 0000000000000000
 cpuidle_enter+0x29/0x40
 do_idle+0x200/0x2b0
 cpu_startup_entry+0x19/0x20
 start_kernel+0x6b7/0x6dc
 secondary_startup_64_no_verify+0xb0/0xbb
 </TASK>
Modules linked in: qrtr_mhi qrtr ath11k_pci mhi ath11k qmi_helpers mac80211 btusb btrtl btbcm btintel bluetooth libarc4 kvm_amd cfg80211 ccp rng_core jitterentropy_rng kvm sha512_ssse3 sha512_generic evdev ctr snd_pcm drbg sg snd_timer ansi_cprng leds_apu irqbypass ecdh_generic snd rfkill ecc soundcore pcspkr k10temp sp5100_tco watchdog button acpi_cpufreq drm fuse configfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_common uas usb_storage ohci_pci ahci libahci ohci_hcd ehci_pci ehci_hcd libata r8169 realtek mdio_devres scsi_mod usbcore i2c_piix4 usb_common scsi_common libphy
---[ end trace 23d792ef4816c4de ]---
RIP: 0010:skb_zcopy_clear+0x3f/0x70
Code: 48 89 c7 e8 81 02 00 00 48 89 45 f8 48 83 7d f8 00 74 45 48 8b 45 f0 48 89 c7 e8 ab 02 00 00 83 f0 01 84 c0 74 1e 48 8b 45 f8 <4c> 8b 00 0f b6 55 ec 48 8b 4d f8 48 8b 45 f0 48 89 ce 48 89 c7 e8
RSP: 0018:ffffb58e80003de8 EFLAGS: 00010202
RAX: 00408210000b231a RBX: ffff8aa303097b00 RCX: 0000000000000000
RDX: 0000000000000102 RSI: 0000000000000001 RDI: ffff8aa303097b00
RBP: ffffb58e80003e00 R08: 0000000000000212 R09: ffffffff922d24e8
R10: 0000000000000000 R11: 00000000db69d000 R12: ffff8aa310c69ac0
R13: ffff8aa303097b00 R14: ffff8aa3062235d8 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8aa31ac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dac9d55408 CR3: 00000001090fa000 CR4: 00000000000006f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0xfa00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

--nextPart1643539.SFto10UAbY
Content-Disposition: attachment; filename="station_connect_crash3_decoded.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="station_connect_crash3_decoded.txt"

general protection fault, probably for non-canonical address 0x408210000b231a: 0000 [#1] PREEMPT SMP NOPTI
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.16.0-rc1+ #1
Hardware name: PC Engines APU/APU, BIOS 4.0 09/08/2014
RIP: 0010:skb_zcopy_clear (./include/linux/skbuff.h:1551) 
Code: 48 89 c7 e8 81 02 00 00 48 89 45 f8 48 83 7d f8 00 74 45 48 8b 45 f0 48 89 c7 e8 ab 02 00 00 83 f0 01 84 c0 74 1e 48 8b 45 f8 <4c> 8b 00 0f b6 55 ec 48 8b 4d f8 48 8b 45 f0 48 89 ce 48 89 c7 e8
All code
========
   0:	48 89 c7             	mov    %rax,%rdi
   3:	e8 81 02 00 00       	callq  0x289
   8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  11:	74 45                	je     0x58
  13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  17:	48 89 c7             	mov    %rax,%rdi
  1a:	e8 ab 02 00 00       	callq  0x2ca
  1f:	83 f0 01             	xor    $0x1,%eax
  22:	84 c0                	test   %al,%al
  24:	74 1e                	je     0x44
  26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2a:*	4c 8b 00             	mov    (%rax),%r8		<-- trapping instruction
  2d:	0f b6 55 ec          	movzbl -0x14(%rbp),%edx
  31:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  39:	48 89 ce             	mov    %rcx,%rsi
  3c:	48 89 c7             	mov    %rax,%rdi
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	4c 8b 00             	mov    (%rax),%r8
   3:	0f b6 55 ec          	movzbl -0x14(%rbp),%edx
   7:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   f:	48 89 ce             	mov    %rcx,%rsi
  12:	48 89 c7             	mov    %rax,%rdi
  15:	e8                   	.byte 0xe8
RSP: 0018:ffffb58e80003de8 EFLAGS: 00010202
RAX: 00408210000b231a RBX: ffff8aa303097b00 RCX: 0000000000000000
RDX: 0000000000000102 RSI: 0000000000000001 RDI: ffff8aa303097b00
RBP: ffffb58e80003e00 R08: 0000000000000212 R09: ffffffff922d24e8
R10: 0000000000000000 R11: 00000000db69d000 R12: ffff8aa310c69ac0
R13: ffff8aa303097b00 R14: ffff8aa3062235d8 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8aa31ac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dac9d55408 CR3: 00000001090fa000 CR4: 00000000000006f0
Call Trace:
<IRQ>
skb_release_data (net/core/skbuff.c:671) 
skb_release_all (net/core/skbuff.c:743) 
__kfree_skb (net/core/skbuff.c:757) 
consume_skb (net/core/skbuff.c:912) 
__dev_kfree_skb_any (net/core/dev.c:3038) 
ath11k_ce_tx_process_cb (drivers/net/wireless/ath/ath11k/ce.c:515) ath11k
ath11k_ce_per_engine_service (drivers/net/wireless/ath/ath11k/ce.c:694) ath11k
? _raw_spin_lock_irqsave (./arch/x86/include/asm/atomic.h:202 ./include/linux/atomic/atomic-instrumented.h:513 ./include/asm-generic/qspinlock.h:82 ./include/linux/spinlock.h:185 ./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
ath11k_pci_ce_tasklet (drivers/net/wireless/ath/ath11k/pci.c:637) ath11k_pci
tasklet_action_common.constprop.0 (./arch/x86/include/asm/bitops.h:75 ./include/asm-generic/bitops/instrumented-atomic.h:42 kernel/softirq.c:879 kernel/softirq.c:787) 
__do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:212 ./include/trace/events/irq.h:142 kernel/softirq.c:559) 
__irq_exit_rcu (kernel/softirq.c:432 kernel/softirq.c:636) 
common_interrupt (arch/x86/kernel/irq.c:240 (discriminator 14)) 
</IRQ>
<TASK>
asm_common_interrupt (./arch/x86/include/asm/idtentry.h:629) 
RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:259) 
Code: 31 ff e8 d9 c6 9e ff 45 84 ff 74 17 9c 58 0f 1f 44 00 00 f6 c4 02 0f 85 78 02 00 00 31 ff e8 bd 97 a5 ff fb 66 0f 1f 44 00 00 <45> 85 f6 0f 88 11 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d
All code
========
   0:	31 ff                	xor    %edi,%edi
   2:	e8 d9 c6 9e ff       	callq  0xffffffffff9ec6e0
   7:	45 84 ff             	test   %r15b,%r15b
   a:	74 17                	je     0x23
   c:	9c                   	pushfq 
   d:	58                   	pop    %rax
   e:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  13:	f6 c4 02             	test   $0x2,%ah
  16:	0f 85 78 02 00 00    	jne    0x294
  1c:	31 ff                	xor    %edi,%edi
  1e:	e8 bd 97 a5 ff       	callq  0xffffffffffa597e0
  23:	fb                   	sti    
  24:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  2a:*	45 85 f6             	test   %r14d,%r14d		<-- trapping instruction
  2d:	0f 88 11 01 00 00    	js     0x144
  33:	49 63 c6             	movslq %r14d,%rax
  36:	4c 2b 2c 24          	sub    (%rsp),%r13
  3a:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
  3e:	48                   	rex.W
  3f:	8d                   	.byte 0x8d

Code starting with the faulting instruction
===========================================
   0:	45 85 f6             	test   %r14d,%r14d
   3:	0f 88 11 01 00 00    	js     0x11a
   9:	49 63 c6             	movslq %r14d,%rax
   c:	4c 2b 2c 24          	sub    (%rsp),%r13
  10:	48 8d 14 40          	lea    (%rax,%rax,2),%rdx
  14:	48                   	rex.W
  15:	8d                   	.byte 0x8d
RSP: 0018:ffffffff92203e60 EFLAGS: 00000246
RAX: ffff8aa31ac00000 RBX: 0000000000000002 RCX: 000000000000001f
RDX: 0000000000000000 RSI: ffffffff91b70667 RDI: ffffffff91b55729
RBP: ffff8aa300906c00 R08: 0000000955084e02 R09: 0000000000000018
R10: 0000000000000001 R11: 0000000000001015 R12: ffffffff923d05c0
R13: 0000000955084e02 R14: 0000000000000002 R15: 0000000000000000
cpuidle_enter (drivers/cpuidle/cpuidle.c:353) 
do_idle (kernel/sched/idle.c:158 kernel/sched/idle.c:239 kernel/sched/idle.c:306) 
cpu_startup_entry (kernel/sched/idle.c:402 (discriminator 1)) 
start_kernel (init/main.c:1137) 
secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:283) 
</TASK>
Modules linked in: qrtr_mhi qrtr ath11k_pci mhi ath11k qmi_helpers mac80211 btusb btrtl btbcm btintel bluetooth libarc4 kvm_amd cfg80211 ccp rng_core jitterentropy_rng kvm sha512_ssse3 sha512_generic evdev ctr snd_pcm drbg sg snd_timer ansi_cprng leds_apu irqbypass ecdh_generic snd rfkill ecc soundcore pcspkr k10temp sp5100_tco watchdog button acpi_cpufreq drm fuse configfs ip_tables x_tables autofs4 ext4 crc32c_generic crc16 mbcache jbd2 sd_mod t10_pi crc_t10dif crct10dif_generic crct10dif_common uas usb_storage ohci_pci ahci libahci ohci_hcd ehci_pci ehci_hcd libata r8169 realtek mdio_devres scsi_mod usbcore i2c_piix4 usb_common scsi_common libphy
---[ end trace 23d792ef4816c4de ]---
RIP: 0010:skb_zcopy_clear (./include/linux/skbuff.h:1551) 
Code: 48 89 c7 e8 81 02 00 00 48 89 45 f8 48 83 7d f8 00 74 45 48 8b 45 f0 48 89 c7 e8 ab 02 00 00 83 f0 01 84 c0 74 1e 48 8b 45 f8 <4c> 8b 00 0f b6 55 ec 48 8b 4d f8 48 8b 45 f0 48 89 ce 48 89 c7 e8
All code
========
   0:	48 89 c7             	mov    %rax,%rdi
   3:	e8 81 02 00 00       	callq  0x289
   8:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
   c:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
  11:	74 45                	je     0x58
  13:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  17:	48 89 c7             	mov    %rax,%rdi
  1a:	e8 ab 02 00 00       	callq  0x2ca
  1f:	83 f0 01             	xor    $0x1,%eax
  22:	84 c0                	test   %al,%al
  24:	74 1e                	je     0x44
  26:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  2a:*	4c 8b 00             	mov    (%rax),%r8		<-- trapping instruction
  2d:	0f b6 55 ec          	movzbl -0x14(%rbp),%edx
  31:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
  35:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
  39:	48 89 ce             	mov    %rcx,%rsi
  3c:	48 89 c7             	mov    %rax,%rdi
  3f:	e8                   	.byte 0xe8

Code starting with the faulting instruction
===========================================
   0:	4c 8b 00             	mov    (%rax),%r8
   3:	0f b6 55 ec          	movzbl -0x14(%rbp),%edx
   7:	48 8b 4d f8          	mov    -0x8(%rbp),%rcx
   b:	48 8b 45 f0          	mov    -0x10(%rbp),%rax
   f:	48 89 ce             	mov    %rcx,%rsi
  12:	48 89 c7             	mov    %rax,%rdi
  15:	e8                   	.byte 0xe8
RSP: 0018:ffffb58e80003de8 EFLAGS: 00010202
RAX: 00408210000b231a RBX: ffff8aa303097b00 RCX: 0000000000000000
RDX: 0000000000000102 RSI: 0000000000000001 RDI: ffff8aa303097b00
RBP: ffffb58e80003e00 R08: 0000000000000212 R09: ffffffff922d24e8
R10: 0000000000000000 R11: 00000000db69d000 R12: ffff8aa310c69ac0
R13: ffff8aa303097b00 R14: ffff8aa3062235d8 R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8aa31ac00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dac9d55408 CR3: 00000001090fa000 CR4: 00000000000006f0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0xfa00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

--nextPart1643539.SFto10UAbY--

--nextPart1776693.pgV9giMVx1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmGubHYACgkQXYcKB8Em
e0bp6g/+LFKvBQsh9faI+qF6goojs46bT5MJjRUb+r1fsewE4hqwvJP73WcYAvhW
cErhFHMZ0j+dtHnR4FivPyJhw5Q60VP/Z6fXGSZEevybQfGsI4fLKZObc3dZ17iE
MQrMYVUBfte+gja2gAaAbV152/VP4k3IezNzvgsAcJ/S5nkTNgV6dtis47sUjnsG
uPiQSSAi6OUOusuwAz2eZxYEVMZ+YMmdrp6T80cp02FRXsMBxdf9/oq4IExYc0vp
XpIqqIp6+hkc0/yPKWa897fTda66KfL1fPP9i+WJLQm0gxfJa6M8sqoZkW5dPuNY
msJ91y7asWbeeaIpjmnfaroBXabFvHwAwiyNFoy71RTdqTz1dG04jmKfFIaoUI61
24oSmdDouzdczebRhEyt18+L/iEWTv/e+856NNvrMt/fYnNhJl/qt+64wxu0F5Nj
B1B62UY84jEH7AHH9wGYWYQ4yYKzegnYYVn1hTUObW0XlC4b4lgwmGF6nUCSPu0R
xHZ7RlWSMNb1sdLGOOgCXLYg+q32ZzWCqUWwxiza1mHJGvTknO6yIe0ww48u3wum
hdTJwW9CuC4Os5rEy7VjUDdI1GgHG1TTK8uowfUl39017rvaADjy6m3vAc7YzyXR
7zG3KO/NSBjQhp4p9J32xzlnpYqRjnCyYndcEgTdwU4B1tqaGI0=
=p3lJ
-----END PGP SIGNATURE-----

--nextPart1776693.pgV9giMVx1--



