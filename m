Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A78646B1E9
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 05:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbhLGEij (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Dec 2021 23:38:39 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:35746 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233659AbhLGEii (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Dec 2021 23:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638851709; x=1670387709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ck/9kJVbHGjzIq/0++Aop7jqg3AwVFY9bc8I1ixJHwE=;
  b=Yjykii/dqcEeqFnjv8ZVAYjNd/dggf+iQ2zo7S+FfPJ9cXMCUScnq3bi
   zWvQ7kkVQWwnXnOvQQ4m8uctzd9sXSueUP+N8c5C5LQyyxdT1Ruwahi4h
   mBc8Gk3cAjzjmnJKfUBKI8DL2jzAcro6YKn6mJoc34wACGeqk4okJuQfe
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 20:35:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 20:35:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 20:35:08 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 20:35:07 -0800
Message-ID: <1880129e-ed91-25f6-bdeb-38c09ae058bb@quicinc.com>
Date:   Tue, 7 Dec 2021 12:35:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for
 WCN6855
Content-Language: en-US
To:     Sven Eckelmann <sven@narfation.org>, <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20211129101309.2931-1-quic_wgong@quicinc.com>
 <7418334.kqliQQpNxi@ripper>
 <71ee85b5-8d8c-c6e5-20a2-d225800de2ba@quicinc.com>
 <7286726.fyvdfvlfLW@ripper>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <7286726.fyvdfvlfLW@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/7/2021 4:03 AM, Sven Eckelmann wrote:
> On Monday, 6 December 2021 08:10:40 CET Wen Gong wrote:
>>> On Monday, 6 December 2021 04:29:39 CET Wen Gong wrote:
>>> [...]
>>>> I did test in my setup, not see the crash.
>>>>
>>>> I am afraid you also need this patch("ath11k: change to use dynamic
>>>> memory for channel list of scan",
>>>>
>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20211129110939.15711-1-quic_wgong@quicinc.com
>>>> )
>>>>
>>>> Could you apply this patch and try again?
>>> Tried it and I see the same problem.
>> Could you tell what is your test steps?
> Start kernel with commit a93789ae541c ("ath11k: Avoid NULL ptr
> access during mgmt tx cleanup") + patches:
>
> * ath11k: enable IEEE80211_HW_SINGLE_SCAN_ON_ALL_BANDS for WCN6855
> * ath11k: change to use dynamic memory for channel list of scan
>
> You can find the config in the first mail. But I have now enabled KASAN inline
> to hopefully create some better error messages.
>
> The firmware + board data (see mail "ath11k: incorrect board_id retrieval")
> was prepared like this:
>
>     git clone https://github.com/kvalo/ath11k-firmware /root/ath11k-firmware
>     mkdir -p /lib/firmware/ath11k/WCN6855/hw2.0/
>     cp /root/ath11k-firmware/WCN6855/hw2.0/*.bin /lib/firmware/ath11k/WCN6855/hw2.0/
>     cp /root/ath11k-firmware/WCN6855/hw2.0/1.1/WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1/*.bin /lib/firmware/ath11k/WCN6855/hw2.0/
>
>     git clone https://github.com/qca/qca-swiss-army-knife /root/qca-swiss-army-knife
>     apt install python2
>     python2 /root/qca-swiss-army-knife/tools/scripts/ath11k/ath11k-bdencoder  -e /lib/firmware/ath11k/WCN6855/hw2.0/board-2.bin
>     rm /lib/firmware/ath11k/WCN6855/hw2.0/board-2.bin
>     cp 'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=2,qmi-board-id=266.bin' /lib/firmware/ath11k/WCN6855/hw2.0/board.bin
>
> Then I am just starting up the device as usual, and start wpa_supplicant (with
> defconfig + CONFIG_MESH=y) from commit 14ab4a816c68 ("Reject
> ap_vendor_elements if its length is odd")
>
>      cat << "EOF" > station_test.cfg
>      network={
>        ssid="MyTestAP"
>        key_mgmt=WPA-PSK FT-PSK
>        proto=RSN
>        psk="testtest"
>      }
>      EOF
>      ip link set up dev wlp6s0
>      ~/hostap/wpa_supplicant/wpa_supplicant -D nl80211 -i wlp6s0 -c station_test.cfg
>
> The actual SSID + PSK is valid and multiple access points (4) have this BSS on
> 2.4GHz + 5GHz.
>
> So you are basically always calling dev_kfree_skb_any in ath11k_ce_tx_process_cb
> because wcn6855 hw2.0 has credit_flow has set. But it seems like one of the
> entries returned by ath11k_ce_completed_send_next is bogus and causes this
> problems during the ath11k_ce_tx_process_cb. And for some reason, this is
> triggered here by this firmware feature.
>
>      ./scripts/faddr2line --list vmlinux consume_skb+0x9f/0x1c0
>      consume_skb+0x9f/0x1c0:
>      
>      __kfree_skb at net/core/skbuff.c:757
>       752     */
>       753
>       754    void __kfree_skb(struct sk_buff *skb)
>       755    {
>       756            skb_release_all(skb);
>      >757<           kfree_skbmem(skb);
>       758    }
>       759    EXPORT_SYMBOL(__kfree_skb);
>       760
>       761    /**
>       762     *      kfree_skb - free an sk_buff
>      
>      (inlined by) consume_skb at net/core/skbuff.c:912
>       907    {
>       908            if (!skb_unref(skb))
>       909                    return;
>       910
>       911            trace_consume_skb(skb);
>      >912<           __kfree_skb(skb);
>       913    }
>       914    EXPORT_SYMBOL(consume_skb);
>       915    #endif
>       916
>       917    /**
>      
>      (inlined by) consume_skb at net/core/skbuff.c:906
>       901     *
>       902     *      Drop a ref to the buffer and free it if the usage count has hit zero
>       903     *      Functions identically to kfree_skb, but kfree_skb assumes that the frame
>       904     *      is being dropped after a failure and notes that
>       905     */
>      >906<   void consume_skb(struct sk_buff *skb)
>       907    {
>       908            if (!skb_unref(skb))
>       909                    return;
>       910
>       911            trace_consume_skb(skb);
>
>
>      ./scripts/faddr2line --list vmlinux skb_release_data+0x1b0/0x5c0
>      skb_release_data+0x1b0/0x5c0:
>      
>      skb_zcopy_clear at include/linux/skbuff.h:1549
>       1544   {
>       1545           struct ubuf_info *uarg = skb_zcopy(skb);
>       1546
>       1547           if (uarg) {
>       1548                   if (!skb_zcopy_is_nouarg(skb))
>      >1549<                          uarg->callback(skb, uarg, zerocopy_success);
>       1550
>       1551                   skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
>       1552           }
>       1553   }
>       1554
>      
>      (inlined by) skb_release_data at net/core/skbuff.c:669
>       664            if (skb->cloned &&
>       665                atomic_sub_return(skb->nohdr ? (1 << SKB_DATAREF_SHIFT) + 1 : 1,
>       666                                  &shinfo->dataref))
>       667                    goto exit;
>       668
>      >669<           skb_zcopy_clear(skb, true);
>       670
>       671            for (i = 0; i < shinfo->nr_frags; i++)
>       672                    __skb_frag_unref(&shinfo->frags[i], skb->pp_recycle);
>       673
>       674            if (shinfo->frag_list)
>
> But I didn't like the inlined code. So I've changed the compilation flags
> slightly:
>
>      diff --git a/net/core/Makefile b/net/core/Makefile
>      index 6bdcb2cafed8..5eda226c5f27 100644
>      --- a/net/core/Makefile
>      +++ b/net/core/Makefile
>      @@ -37,3 +37,4 @@ obj-$(CONFIG_NET_SOCK_MSG) += skmsg.o
>       obj-$(CONFIG_BPF_SYSCALL) += sock_map.o
>       obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
>       obj-$(CONFIG_OF)	+= of_net.o
>      +ccflags-y += -fno-inline -O1 -fno-optimize-sibling-calls
>
> Now the stacktrace is a lot more readable. And the returned
> crash location makes a lot more sense:
>
>      ./scripts/faddr2line --list vmlinux 'skb_zcopy_clear+0x34/0x8f'
>      skb_zcopy_clear+0x34/0x8f:
>      
>      skb_zcopy_clear at include/linux/skbuff.h:1549
>       1544   {
>       1545           struct ubuf_info *uarg = skb_zcopy(skb);
>       1546
>       1547           if (uarg) {
>       1548                   if (!skb_zcopy_is_nouarg(skb))
>      >1549<                          uarg->callback(skb, uarg, zerocopy_success);
>       1550
>       1551                   skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
>       1552           }
>       1553   }
>       1554
>
> Or with the assembler:
>
>       (gdb) disassemble /m *(skb_zcopy_clear+0x34/0x8f)
>       Dump of assembler code for function skb_zcopy_clear:
>       1544    {
>          0x000000000000072a <+0>:     push   %r12
>          0x000000000000072c <+2>:     push   %rbp
>          0x000000000000072d <+3>:     push   %rbx
>          0x000000000000072e <+4>:     mov    %rdi,%rbx
>          0x0000000000000731 <+7>:     mov    %esi,%r12d
>       
>       1545            struct ubuf_info *uarg = skb_zcopy(skb);
>          0x0000000000000734 <+10>:    call   0x5d3 <skb_zcopy>
>       
>       1546
>       1547            if (uarg) {
>          0x0000000000000739 <+15>:    test   %rax,%rax
>          0x000000000000073c <+18>:    je     0x7a0 <skb_zcopy_clear+118>
>          0x000000000000073e <+20>:    mov    %rax,%rbp
>       
>       1548                    if (!skb_zcopy_is_nouarg(skb))
>          0x0000000000000741 <+23>:    mov    %rbx,%rdi
>          0x0000000000000744 <+26>:    call   0x6f6 <skb_zcopy_is_nouarg>
>          0x0000000000000749 <+31>:    test   %al,%al
>          0x000000000000074b <+33>:    jne    0x777 <skb_zcopy_clear+77>
>       
>       1549                            uarg->callback(skb, uarg, zerocopy_success);
>          0x000000000000074d <+35>:    mov    %rbp,%rdx
>          0x0000000000000750 <+38>:    shr    $0x3,%rdx
>          0x0000000000000754 <+42>:    movabs $0xdffffc0000000000,%rax
>          0x000000000000075e <+52>:    cmpb   $0x0,(%rdx,%rax,1)
>          0x0000000000000762 <+56>:    jne    0x7a5 <skb_zcopy_clear+123>
>          0x0000000000000764 <+58>:    movzbl %r12b,%edx
>          0x0000000000000768 <+62>:    mov    0x0(%rbp),%rax
>          0x000000000000076c <+66>:    mov    %rbp,%rsi
>          0x000000000000076f <+69>:    mov    %rbx,%rdi
>          0x0000000000000772 <+72>:    call   0x777 <skb_zcopy_clear+77>
>          0x00000000000007a5 <+123>:   mov    %rbp,%rdi
>          0x00000000000007a8 <+126>:   call   0x7ad <skb_zcopy_clear+131>
>          0x00000000000007ad <+131>:   jmp    0x764 <skb_zcopy_clear+58>
>       
>       1550
>       1551                    skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
>          0x0000000000000777 <+77>:    mov    %rbx,%rdi
>          0x000000000000077a <+80>:    call   0x518 <skb_end_pointer>
>          0x000000000000077f <+85>:    mov    %rax,%rbx
>          0x0000000000000782 <+88>:    mov    %rax,%rdx
>          0x0000000000000785 <+91>:    shr    $0x3,%rdx
>          0x0000000000000789 <+95>:    movabs $0xdffffc0000000000,%rax
>          0x0000000000000793 <+105>:   movzbl (%rdx,%rax,1),%eax
>          0x0000000000000797 <+109>:   test   %al,%al
>          0x0000000000000799 <+111>:   je     0x79d <skb_zcopy_clear+115>
>          0x000000000000079b <+113>:   jle    0x7af <skb_zcopy_clear+133>
>          0x000000000000079d <+115>:   andb   $0xf8,(%rbx)
>          0x00000000000007af <+133>:   mov    %rbx,%rdi
>          0x00000000000007b2 <+136>:   call   0x7b7 <skb_zcopy_clear+141>
>          0x00000000000007b7 <+141>:   jmp    0x79d <skb_zcopy_clear+115>
>       
>       1552            }
>       1553    }
>          0x00000000000007a0 <+118>:   pop    %rbx
>          0x00000000000007a1 <+119>:   pop    %rbp
>          0x00000000000007a2 <+120>:   pop    %r12
>          0x00000000000007a4 <+122>:   ret
>       
>       End of assembler dump.
>
> To make it even easier to read, just disable the inline KASAN and reduce the
> optimization level for this for it:
>
>      diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>      index 059b6266dcd7..819cc58ab051 100644
>      --- a/include/linux/skbuff.h
>      +++ b/include/linux/skbuff.h
>      @@ -1540,6 +1540,8 @@ static inline void net_zcopy_put_abort(struct ubuf_info *uarg, bool have_uref)
>       }
>       
>       /* Release a reference on a zerocopy structure */
>      +#pragma GCC push_options
>      +#pragma GCC optimize ("O0")
>       static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
>       {
>       	struct ubuf_info *uarg = skb_zcopy(skb);
>      @@ -1551,6 +1553,7 @@ static inline void skb_zcopy_clear(struct sk_buff *skb, bool zerocopy_success)
>       		skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
>       	}
>       }
>      +#pragma GCC pop_options
>       
>       static inline void skb_mark_not_on_list(struct sk_buff *skb)
>       {
>
> This creates this nice, unoptimized function which crashes at +63:
>
>      $ gdb net/core/skbuff.o -q
>      Reading symbols from net/core/skbuff.o...
>      (gdb) disassemble /m *(skb_zcopy_clear+0x3f/0x70)
>      Dump of assembler code for function skb_zcopy_clear:
>      1546    {
>         0x0000000000000000 <+0>:     push   %rbp
>         0x0000000000000001 <+1>:     mov    %rsp,%rbp
>         0x0000000000000004 <+4>:     sub    $0x18,%rsp
>         0x0000000000000008 <+8>:     mov    %rdi,-0x10(%rbp)
>         0x000000000000000c <+12>:    mov    %esi,%eax
>         0x000000000000000e <+14>:    mov    %al,-0x14(%rbp)
>      
>      1547            struct ubuf_info *uarg = skb_zcopy(skb);
>         0x0000000000000011 <+17>:    mov    -0x10(%rbp),%rax
>         0x0000000000000015 <+21>:    mov    %rax,%rdi
>         0x0000000000000018 <+24>:    call   0x29e <skb_zcopy>
>         0x000000000000001d <+29>:    mov    %rax,-0x8(%rbp)
>      
>      1548
>      1549            if (uarg) {
>         0x0000000000000021 <+33>:    cmpq   $0x0,-0x8(%rbp)
>         0x0000000000000026 <+38>:    je     0x6d <skb_zcopy_clear+109>
>      
>      1550                    if (!skb_zcopy_is_nouarg(skb))
>         0x0000000000000028 <+40>:    mov    -0x10(%rbp),%rax
>         0x000000000000002c <+44>:    mov    %rax,%rdi
>         0x000000000000002f <+47>:    call   0x2df <skb_zcopy_is_nouarg>
>         0x0000000000000034 <+52>:    xor    $0x1,%eax
>         0x0000000000000037 <+55>:    test   %al,%al
>         0x0000000000000039 <+57>:    je     0x59 <skb_zcopy_clear+89>
>      
>      1551                            uarg->callback(skb, uarg, zerocopy_success);
>         0x000000000000003b <+59>:    mov    -0x8(%rbp),%rax
>         0x000000000000003f <+63>:    mov    (%rax),%r8
>         0x0000000000000042 <+66>:    movzbl -0x14(%rbp),%edx
>         0x0000000000000046 <+70>:    mov    -0x8(%rbp),%rcx
>         0x000000000000004a <+74>:    mov    -0x10(%rbp),%rax
>         0x000000000000004e <+78>:    mov    %rcx,%rsi
>         0x0000000000000051 <+81>:    mov    %rax,%rdi
>         0x0000000000000054 <+84>:    call   0x59 <skb_zcopy_clear+89>
>      
>      1552
>      1553                    skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;
>         0x0000000000000059 <+89>:    mov    -0x10(%rbp),%rax
>         0x000000000000005d <+93>:    mov    %rax,%rdi
>         0x0000000000000060 <+96>:    call   0x27f <skb_end_pointer>
>         0x0000000000000065 <+101>:   movzbl (%rax),%edx
>         0x0000000000000068 <+104>:   and    $0xfffffff8,%edx
>         0x000000000000006b <+107>:   mov    %dl,(%rax)
>      
>      1554            }
>      1555    }
>         0x000000000000006d <+109>:   nop
>         0x000000000000006e <+110>:   leave
>         0x000000000000006f <+111>:   ret
>      
>      End of assembler dump.
>
> The question now: What is causing the unclean state of the skb and thus
> doesn't let it get rejected by skb_zcopy_is_nouarg before the uarg
> callback is tried.
>
> Kind regards,
> 	Sven

Thanks Sven a lot for your analyze.

I still can not reproduce it.

I think it is because the write over skb->tail in scan, because the 
invalid address

is same for each crash(0x408210000b231a/0xe0080c4200016463), and it is 
caused by this instruction

"0x000000000000003f <+63>:    mov    (%rax),%r8" which is assign the value of uarg->callback to %r8.

Could you add below change?

It will print the log to help us find out the bug.

diff --git a/drivers/net/wireless/ath/ath11k/mac.c 
b/drivers/net/wireless/ath/ath11k/mac.c
index 26181f237e23..2147f74f5ebf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3421,12 +3421,15 @@ static int ath11k_mac_op_hw_scan(struct 
ieee80211_hw *hw,
                 memcpy(arg.extraie.ptr, req->ie, req->ie_len);
         }

+       ath11k_info(ar->ab, "n_ssids %d\n", req->n_ssids);
+
         if (req->n_ssids) {
                 arg.num_ssids = req->n_ssids;
                 for (i = 0; i < arg.num_ssids; i++) {
                         arg.ssid[i].length  = req->ssids[i].ssid_len;
                         memcpy(&arg.ssid[i].ssid, req->ssids[i].ssid,
                                req->ssids[i].ssid_len);
+                       ath11k_info(ar->ab, "ssid[%d] len %d\n", i, 
arg.ssid[i].length);
                 }
         } else {
                 arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c 
b/drivers/net/wireless/ath/ath11k/wmi.c
index 7d7f76d4bf1f..e42a64251799 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2271,6 +2271,7 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
                 }
         }

+       ath11k_info(ar->ab, "%s ptr %px skb data %px len %d over %d", 
__func__, ptr, skb->data, skb->len, ((unsigned char 
*)ptr)-skb->data-skb->len);
         ret = ath11k_wmi_cmd_send(wmi, skb,
                                   WMI_START_SCAN_CMDID);
         if (ret) {

