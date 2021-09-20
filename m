Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8635E4112F7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 12:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhITKhv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 06:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbhITKhu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 06:37:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B28C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 03:36:23 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q23so13700388pfs.9
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=QJyhrVoSOO2IQTkZ9g+9h4ijGGgC4fPSMvSxGZwtHXQ=;
        b=UuHz6htxo5BjBBwec8K3R7oQztXqLYfD24zsZ9YKZ+LGmJ+/uUENCvhwNOdvat4IrX
         B26LpGvQCMu/mVfWuLRkP3aFyZ3Lc6RG5xTknES85kw0weboMterTp8m0Bki9XXSG3S7
         LnhEQaw3kDj7WwR3zLV2HNx6SkJ2yV/C1eaY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=QJyhrVoSOO2IQTkZ9g+9h4ijGGgC4fPSMvSxGZwtHXQ=;
        b=j/IPAY9oY+GI1cQZPCoBbg+sVFHqfhQordnfi3HcCvWiETXBuaA5KcjMeeIsdQKYbQ
         QRqTz/h/ThC/3lXZRujZUoP8Fq+mNxqpyEDwGRwH56fqmL5gcYy/EC0aTrKXkdIUlHtS
         QGW3C6PeiyMI7PA2roiHwv6jwsOLOXZoqQWPYRwbo9U8tXj0K5XtRd/lEM1UT16Jh6+i
         TDIJuCf1jXKCDE5eEboh4I/lbAKWzHpB6Uti2QsE0SP9YVKFHNLtSXG1O56I7caoupk9
         tWYEL6rSSHmG21nQ1uwsIogN1ac9TGiBK7K+PqeJihIg9ojhmCDn9fcys8ZP22/ELkpu
         FVIw==
X-Gm-Message-State: AOAM5331GHfcVlOIYVKttNFpPgkAR0xenjHA94nPmu7d77Yw9VNV45Yl
        Lm1g3ab2KonVJmYB38S4ttEZJVcDwjp78l2MSNfzmO1gQP+syxDCAuLLZ+O+UMOpUE2XUXXJAoF
        gHAufoIzfbbJmkHxd4A==
X-Google-Smtp-Source: ABdhPJzdPPN8qoKHun1bmC/Lqjra7FD0grF8NGRJwkuV6aFx+NOiXLLtJyTyXIljn3ne/3IQFsNXdA==
X-Received: by 2002:a62:3383:0:b0:438:4b0d:e50e with SMTP id z125-20020a623383000000b004384b0de50emr24233761pfz.9.1632134183237;
        Mon, 20 Sep 2021 03:36:23 -0700 (PDT)
Received: from [10.176.68.97] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id p9sm15789266pgn.36.2021.09.20.03.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 03:36:22 -0700 (PDT)
Subject: Re: [PATCH mac80211] mac80211: limit mcs/nss to spec values in
 ieee80211_parse_tx_radiotap
To:     Lorenzo Bianconi <lorenzo@kernel.org>, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
References: <0529e19e583be780ba2488e891c50dcfcf2ce4c1.1632128258.git.lorenzo@kernel.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <e848121b-c0ee-d8e4-8f4b-dc9b64210261@broadcom.com>
Date:   Mon, 20 Sep 2021 12:36:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0529e19e583be780ba2488e891c50dcfcf2ce4c1.1632128258.git.lorenzo@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003e7d4a05cc6ada75"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000003e7d4a05cc6ada75
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US

On 9/20/2021 11:03 AM, Lorenzo Bianconi wrote:
> Limit max value for mcs and nss according to specs in order to fix the
> following warning reported by syzbot:
> 
> WARNING: CPU: 0 PID: 10717 at include/net/mac80211.h:989 ieee80211_rate_set_vht include/net/mac80211.h:989 [inline]
> WARNING: CPU: 0 PID: 10717 at include/net/mac80211.h:989 ieee80211_parse_tx_radiotap+0x101e/0x12d0 net/mac80211/tx.c:2244
> Modules linked in:
> CPU: 0 PID: 10717 Comm: syz-executor.5 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:ieee80211_rate_set_vht include/net/mac80211.h:989 [inline]
> RIP: 0010:ieee80211_parse_tx_radiotap+0x101e/0x12d0 net/mac80211/tx.c:2244
> RSP: 0018:ffffc9000186f3e8 EFLAGS: 00010216
> RAX: 0000000000000618 RBX: ffff88804ef76500 RCX: ffffc900143a5000
> RDX: 0000000000040000 RSI: ffffffff888f478e RDI: 0000000000000003
> RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000100
> R10: ffffffff888f46f9 R11: 0000000000000000 R12: 00000000fffffff8
> R13: ffff88804ef7653c R14: 0000000000000001 R15: 0000000000000004
> FS:  00007fbf5718f700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2de23000 CR3: 000000006a671000 CR4: 00000000001506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
> Call Trace:
>   ieee80211_monitor_select_queue+0xa6/0x250 net/mac80211/iface.c:740
>   netdev_core_pick_tx+0x169/0x2e0 net/core/dev.c:4089
>   __dev_queue_xmit+0x6f9/0x3710 net/core/dev.c:4165
>   __bpf_tx_skb net/core/filter.c:2114 [inline]
>   __bpf_redirect_no_mac net/core/filter.c:2139 [inline]
>   __bpf_redirect+0x5ba/0xd20 net/core/filter.c:2162
>   ____bpf_clone_redirect net/core/filter.c:2429 [inline]
>   bpf_clone_redirect+0x2ae/0x420 net/core/filter.c:2401
>   bpf_prog_eeb6f53a69e5c6a2+0x59/0x234
>   bpf_dispatcher_nop_func include/linux/bpf.h:717 [inline]
>   __bpf_prog_run include/linux/filter.h:624 [inline]
>   bpf_prog_run include/linux/filter.h:631 [inline]
>   bpf_test_run+0x381/0xa30 net/bpf/test_run.c:119
>   bpf_prog_test_run_skb+0xb84/0x1ee0 net/bpf/test_run.c:663
>   bpf_prog_test_run kernel/bpf/syscall.c:3307 [inline]
>   __sys_bpf+0x2137/0x5df0 kernel/bpf/syscall.c:4605
>   __do_sys_bpf kernel/bpf/syscall.c:4691 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:4689 [inline]
>   __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:4689
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665f9
> 
> Reported-by: syzbot+0196ac871673f0c20f68@syzkaller.appspotmail.com
> Fixes: 646e76bb5daf4 ("mac80211: parse VHT info in injected frames")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   net/mac80211/tx.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 2d1193ed3eb5..d81a9409fd0e 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -2209,7 +2209,11 @@ bool ieee80211_parse_tx_radiotap(struct sk_buff *skb,
>   			}
>   
>   			vht_mcs = iterator.this_arg[4] >> 4;
> +			if (vht_mcs > 9)
> +				vht_mcs = 0;

Some devices can use higher mcs values so maybe we may want to allow 
higher values(?). See cfg80211_calculate_bitrate_vht() [1].

>   			vht_nss = iterator.this_arg[4] & 0xF;
> +			if (!vht_nss || vht_nss > 8)
> +				vht_nss = 1;
>   			break;
>   
>   		/*
> 

Regards,
Arend

[1] https://elixir.bootlin.com/linux/latest/source/net/wireless/util.c#L1250

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--0000000000003e7d4a05cc6ada75
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
XSlOP9s1dqWlRRnnNxV7BVC87lkKKy0+1M2DOF6qRYQlnW4EfOyCToYLAG5zeV+AjepMoX6J9bUz
yj4BlDtwH4HFjaRIlPPbdLshUA54/tV84x8woATuLGBq+hTZEpkZAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKb+3b9pz8zo
0QsCHGb/p0UrBlU+MA0GCSqGSIb3DQEBCwUAA4IBAQCHisuRNqP0NfYfG3U3XF+bocf//aGLOCGj
NvbnSbaUDT/ZkRFb9dQfDRVnZUJ7eDZWHfC+kukEzFwiSK1irDPZQAG9diwy4p9dM0xw5RXSAC1w
FzQ0ClJvhK8PsjXF2yzITFmZsEhYEToTn2owD613HvBNijAnDDLV8D0K5gtDnVqkVB9TUAGjHsmo
aAwIDFKdqL0O19Kui0WI1qNsu1tE2wAZk0XE9FG0OKyY2a2oFwJ85c5IO0q53U7+YePIwv4/J5aP
OGM6lFPJCVnfKc3H76g/FyPyaE4AL/hfdNP8ObvCB6N/BVCccjNdglRsL2ewttAG3GM06LkvrLhv
UCvjMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMMSnY
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCA7xspX/VTNkV2JAwFy
7LkDQhhDMvEPwIyMVLetJAN8QTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMTA5MjAxMDM2MjNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAeudkmm/fCh5vTKWd7OmhA3ISMWEKis54rwAP
bj3hsFWmq5mHrDuqc1dmDGdZWDC1s9IVPPOm7eQOlsmv9GUNaNt5Cmv3OaJlT+6GV2sJ/vIKSF23
tWwnI8jPnsXJO+WsLqZTdy7OuKc9bPSfsWUmoiou9e4C1bqTiERZIMmprGElZ3dXx1eiQaFZprfP
H9zlR9spdRE3hW/yX+3BtaRbltDW0b4MD6W1TvMil2iAgHCyr4Q+KnZ8c21kHbvENSBYNpSe5yzJ
7k2YdUPs3tkaKWAgcmQMYawqlwj2ko2DOj9xDdcPhxGr/k5ymPmyZ54+9isrzoz8vmcs+yzOfwYL
pQ==
--0000000000003e7d4a05cc6ada75--
