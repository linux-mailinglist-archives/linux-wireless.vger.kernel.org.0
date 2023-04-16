Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CAE6E3AD2
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 19:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDPRr5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 13:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDPRr4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 13:47:56 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2539C271B
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 10:47:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fw30so5655701ejc.5
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681667272; x=1684259272;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uglpDOp7goqbtE2J4rWdMlmwo93bZX1oiv/KXPq3Ivs=;
        b=ORbfzb5yM0zynidkQjLeUDBd0NWYN43ToXrFil4WbmxCpj6w/w324AyIPDtXiKCLyM
         fm+XxMjNYszRT6r+CfwgfPgQQHyu5FXS3AZ0gmJkzPwT+hdbG/I/0XaV5nIbuknYamfd
         pRTzKYiKK0Yyf2kB2ziQ6vfIfac8SDh8a7qyBnF4gL0W+5Jj5zug3BPCP4HNo3Cjz3vi
         iIlAt0GKNBVk1xcQQWPklqih/MsVBbkXyiKLTxDtCbHtPKap3HqV6svWkzNCWGN2e+py
         TuyFBFLSBkOZBUm3UbKtk5amSRRVe2JkWLQ0a+jw9px0ddspPwdzk9MZun+EcYQu4PUN
         f0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681667272; x=1684259272;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uglpDOp7goqbtE2J4rWdMlmwo93bZX1oiv/KXPq3Ivs=;
        b=kHcWDcaGh/BrmMn8NPZc6QDeCrWOrC6nv8dnczZbATrsa7B3cLhMHRGWrGW7jHkK4Q
         R4II9xF9PbEUP3qaAKS2HOHFY1brECXv1FNcWpK88pL17PdhQpxum3uBu/rBj0aBfr86
         D58nmc+/Z+Omj/DlqD/NLiZwogDeWEXZR8gQEAFMW8tEkaOkuNjR8CzWTmh/YI/2gJbz
         S8n0TZ6/myJozWsvjsVh71Li1U9Q1s8yFEfZOn55AgUj0b8giMyidq+ZrVrMoBe9r3Uo
         moKA9XLUwzbcCRBUQvP3XqoVi3QoH6oy/2u8JyOoMROfQTnR6WAiCeU969udqaB8XBbf
         AAvQ==
X-Gm-Message-State: AAQBX9fTE5wahzO1tKZ97EJQgHZZALgo+dr0qB8vef6L6139r/IB+Jnf
        akp5wdNc03s/DnaanbNT3sw=
X-Google-Smtp-Source: AKy350bFlCckVE6ibcAq+DrEh085/pduyFReK19MDw6psRYzpviv2GdnJ2DMBVs3LrnsTmuJMPilyw==
X-Received: by 2002:a17:907:770e:b0:94a:58a5:2300 with SMTP id kw14-20020a170907770e00b0094a58a52300mr4909164ejc.27.1681667272238;
        Sun, 16 Apr 2023 10:47:52 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.55])
        by smtp.gmail.com with ESMTPSA id mc2-20020a170906eb4200b00932fa67b48fsm5319415ejb.183.2023.04.16.10.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 10:47:51 -0700 (PDT)
Message-ID: <bfe732f4-60dd-4d78-1259-5f9f6c11adbc@gmail.com>
Date:   Sun, 16 Apr 2023 20:47:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: RTL8188EU (LogiLink WL0151A) - Malformed packets
To:     Artem Makhutov <artem.makhutov@gmail.com>
References: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
Content-Language: en-US
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CALbLcfAXrHp4vsVGqU0nBdB_gFmKTKx0GcdrFJA7R_kodAy0Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16/04/2023 16:45, Artem Makhutov wrote:
> Hello,
> 
> I am not sure if it is ok to write to you directly but I could not find a place where to open a ticket about the rtl8xxxu driver.
> 
> I am having issues with the RTL8188EU (LogiLink WL0151A) where I get truncated packets when sending large packets. It's easy to reproduce with ping:
> 
> ping -s 1430 10.10.0.1
> PING 10.10.0.1 (10.10.0.1) 1430(1458) bytes of data.
> 1438 bytes from 10.10.0.1 <http://10.10.0.1>: icmp_seq=5 ttl=64 time=19.9 ms
> 1438 bytes from 10.10.0.1 <http://10.10.0.1>: icmp_seq=8 ttl=64 time=250 ms
> 1438 bytes from 10.10.0.1 <http://10.10.0.1>: icmp_seq=9 ttl=64 time=5.59 ms
> 1438 bytes from 10.10.0.1 <http://10.10.0.1>: icmp_seq=10 ttl=64 time=1.94 ms
> 1438 bytes from 10.10.0.1 <http://10.10.0.1>: icmp_seq=11 ttl=64 time=3.40 ms
> 1438 bytes from 10.10.0.1 <http://10.10.0.1>: icmp_seq=12 ttl=64 time=1.94 ms
> 1438 bytes from 10.10.0.1 <http://10.10.0.1>: icmp_seq=13 ttl=64 time=1.89 ms
> [...]
> 15 packets transmitted, 7 received, 53.3333% packet loss, time 14345ms
> rtt min/avg/max/mdev = 1.885/40.654/249.918/85.640 ms
> 
> With tcpdump I see logs like this on the wireless interface. Some parts of the packets seem to be broken...
> 
> 13:16:54.448318 IP 10.10.0.111 > 10.10.0.1 <http://10.10.0.1>: ICMP echo request, id 63056, seq 14, length 1438
> 13:16:54.450391 IP truncated-ip - 4 bytes missing! 10.10.0.1 > 10.10.0.111 <http://10.10.0.111>: ICMP echo reply, id 63056, seq 14, length 1438
> 
> Can you assist me to fix this issue?
> 
> Thanks, Artem

Hi!

Adding linux-wireless because that's the place to report bugs.
Also bugzilla.kernel.org, but that's more dead.

Unfortunately my TP-Link TL-WN725N is fine even with bigger packets:

PING 192.168.1.7 (192.168.1.7) 2300(2328) bytes of data.
[1681659077.535489] 2308 bytes from 192.168.1.7: icmp_seq=1 ttl=64 time=7.93 ms
[1681659078.536313] 2308 bytes from 192.168.1.7: icmp_seq=2 ttl=64 time=6.24 ms
...
--- 192.168.1.7 ping statistics ---
24 packets transmitted, 24 received, 0% packet loss, time 23033ms
rtt min/avg/max/mdev = 6.210/8.375/22.621/3.633 ms

(The router wouldn't reply to anything more than "-s 1472" but
another computer on the network did.)


What version of the kernel/driver are you running? On what kind
of computer?

Did you use any module parameters?

Do you know if the other computer is receiving correct packets
from your RTL8188EU?

What's the biggest packet size which still works correctly?

Did you test any other driver, like this one:
https://github.com/lwfinger/rtl8188eu/tree/v5.2.2.4
or this one:
https://github.com/aircrack-ng/rtl8188eus
?


If the other computer is receiving correct packets, try this untested
patch to see what rtl8xxxu is actually receiving:

diff --git a/rtl8xxxu_core.c b/rtl8xxxu_core.c
index c158137..5bec979 100644
--- a/rtl8xxxu_core.c
+++ b/rtl8xxxu_core.c
@@ -6142,6 +6147,8 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 		return RX_TYPE_ERROR;
 	}
 
+	pr_warn("urb_len %d\n", urb_len);
+
 	do {
 		rx_desc = (struct rtl8xxxu_rxdesc16 *)skb->data;
 		_rx_desc_le = (__le32 *)skb->data;
@@ -6164,6 +6171,11 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 		pkt_offset = roundup(pkt_len + drvinfo_sz + desc_shift +
 				     sizeof(struct rtl8xxxu_rxdesc16), 128);
 
+		pr_warn("  pkt_cnt %d pkt_len %d drvinfo_sz %d desc_shift %d\n", pkt_cnt, pkt_len, drvinfo_sz, desc_shift);
+
+		print_hex_dump(KERN_WARNING, "  ", DUMP_PREFIX_OFFSET, 32, 4,
+		       skb->data, skb->len, EFUSE_MAP_LEN, true);
+
 		/*
 		 * Only clone the skb if there's enough data at the end to
 		 * at least cover the rx descriptor
