Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE673922A
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 18:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfFGQdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 12:33:16 -0400
Received: from nbd.name ([46.4.11.11]:57604 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfFGQdP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 12:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uXw3//qd+I2pK7CtfpdalPywBMi7hFycl9lmXlygp/A=; b=S5Ds95/6WnIrGIgQyvVMPELfSa
        2hY07id4z4Bfz10Jg0qKyTjYJCAgcngF89f3jYFAmRucI94+Lqg+H4KPfrX5sz6hcySTiz+uLtufI
        opoZ1CQB26yG7KMLlDrSD3qB7J7GvPy1Lw6Qs0KIzwN3olJpBMZLipl6Y0MWHt6G3y6E=;
Received: from p4ff13bc7.dip0.t-ipconnect.de ([79.241.59.199] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hZHni-0007JL-0d; Fri, 07 Jun 2019 18:33:10 +0200
Subject: Re: [PATCH] mt76: mt7615: do not process rx packets if the device is
 not initialized
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
References: <cover.1557825294.git.lorenzo@kernel.org>
 <f3117ed5577bdcc2b0bf98c20d07e81f0f52476e.1557825294.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Openpgp: preference=signencrypt
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 mQGiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwbQcRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPohgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQuQINBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabiEkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <6af07e9b-f840-d1e2-81c7-59556503a129@nbd.name>
Date:   Fri, 7 Jun 2019 18:33:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <f3117ed5577bdcc2b0bf98c20d07e81f0f52476e.1557825294.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-14 11:18, Lorenzo Bianconi wrote:
> Fix following crash that occurs when the driver is processing rx packets
> while the device is not initialized yet
> 
> $ rmmod mt7615e
> [   67.210261] mt7615e 0000:01:00.0: Message -239 (seq 2) timeout
> $ modprobe mt7615e
> [   72.406937] bus=0x1, slot = 0x0, irq=0x16
> [   72.436590] CPU 0 Unable to handle kernel paging request at virtual address 00000004, epc == 8eec4240, ra == 8eec41e0
> [   72.450291] mt7615e 0000:01:00.0: Firmware is not ready for download
> [   72.457724] Oops[#1]:
> [   72.470494] mt7615e: probe of 0000:01:00.0 failed with error -5
> [   72.474829] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.114 #0
> [   72.498702] task: 805769e0 task.stack: 80564000
> [   72.507709] $ 0   : 00000000 00000001 00000000 00000001
> [   72.518106] $ 4   : 8f704dbc 00000000 00000000 8f7046c0
> [   72.528500] $ 8   : 00000024 8045e98c 81210008 11000000
> [   72.538895] $12   : 8fc09f60 00000008 00000019 00000033
> [   72.549289] $16   : 8f704d80 e00000ff 8f0c7800 3c182406
> [   72.559684] $20   : 00000006 8ee615a0 4e000108 00000000
> [   72.570078] $24   : 0000004c 8000cf94
> [   72.580474] $28   : 80564000 8fc09e38 00000001 8eec41e0
> [   72.590869] Hi    : 00000001
> [   72.596582] Lo    : 00000000
> [   72.602319] epc   : 8eec4240 mt7615_mac_fill_rx+0xac/0x494 [mt7615e]
> [   72.614953] ra    : 8eec41e0 mt7615_mac_fill_rx+0x4c/0x494 [mt7615e]
> [   72.627580] Status: 11008403 KERNEL EXL IE
> [   72.635899] Cause : 40800008 (ExcCode 02)
> [   72.643860] BadVA : 00000004
> [   72.649573] PrId  : 0001992f (MIPS 1004Kc)
> [   72.657704] Modules linked in: mt7615e pppoe ppp_async pppox ppp_generic nf_conntrack_ipv6 mt76x2e mt76x2_common mt76x02_lib mt7603e mt76 mac80211 iptable_nat ipt_REJECT ipt_MASQUERADE cfg80211 xt_time xt_tcpudp xt_state xt_nat xt_mu]
> [   72.792717] Process swapper/0 (pid: 0, threadinfo=80564000, task=805769e0, tls=00000000)
> [   72.808799] Stack : 8f0c7800 00000800 8f0c7800 8032b874 00000000 40000000 8f704d80 8ee615a0
> [   72.825428]         8dc88010 00000001 8ee615e0 8eec09b0 8dc88010 8032b914 8f3aee80 80567d20
> [   72.842055]         00000000 8ee615e0 40000000 8f0c7800 00000108 8eec9944 00000000 00000000
> [   72.858682]         80508f10 80510000 00000001 80567d20 8ee615a0 00000000 00000000 8ee61c00
> [   72.875308]         8ee61c40 00000040 80610000 80580000 00000000 8ee615dc 8ee61a68 00000001
> [   72.891936]         ...
> [   72.896793] Call Trace:
> [   72.901649] [<8eec4240>] mt7615_mac_fill_rx+0xac/0x494 [mt7615e]
> [   72.913602] [<8eec09b0>] mt7615_queue_rx_skb+0xe4/0x12c [mt7615e]
> [   72.925734] [<8eec9944>] mt76_dma_cleanup+0x390/0x42c [mt76]
> [   72.936988] Code: ae020018  8ea20004  24030001 <94420004> a602002a  8ea20004  90420000  14430003  a2020034
> [   72.956390]
> [   72.959676] ---[ end trace f176967739edb19f ]---
> 
> Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Applied, thanks.

- Felix
