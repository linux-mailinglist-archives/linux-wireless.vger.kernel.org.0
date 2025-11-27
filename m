Return-Path: <linux-wireless+bounces-29384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F3C8ECB4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092C73A32DF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Nov 2025 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DEE33345D;
	Thu, 27 Nov 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eenJNDpv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F6236435
	for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764254376; cv=none; b=QgXA83BiSt6pH6qP+L2YCHtN1+WbLtwL8EdRnwwVwV9cDF55y8XwAZ07PeEvZ0LHOtUspnYQz7AzLx0uymrw3U/jGyQ/N6QHASgydaRcFQrE0X/lk5PxOKSoGx1hxEyXFGcFS//nTDyfGv0HnPEx4hTsyfAs8WliGkuWa4By1ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764254376; c=relaxed/simple;
	bh=B3LyroSU2cR4D1kOhyezPehO+k55XekRosgH1WeB5Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=my7zc0HlhUq1ggjN/e1/DQKDo/cj/rNTKMVjXi3fr69E+o0bXCLftEbAszQieiMxBhfDYu6zBBeuF2jwTUgJOIWSdaVgHPz6ejk9xNVEJ1kg/fXVjBgk72/adqGtFjV9XtPQdoyWJrbL2nHkQ6Zd4QVzlq8jmvVmqw6XOW1SJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eenJNDpv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso8484985e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 27 Nov 2025 06:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764254371; x=1764859171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heVo+DHjafEN8eJsdnjeLP4ETOfR9djRjIT87uAVdH8=;
        b=eenJNDpv0+i/bM0wIFxefYawF+GsRS+zeVnb5Ufsj2ZvNCOtFz16MIKrF1tvgsiSc0
         GBGvyynQ0qef5mh8pr4FxbHepODGkwb+jJSe3U0/i3+1bB4VAFF0BKSPawEB3q5/ebJJ
         T0Twc+Iu7NeyVNgQPhJq4JxsuDLK1hOEo6liRfNh7N3TsJPN+GwrCoTwxjXdLDPykgNw
         qTH19I5gEazbj2+54O4p/1gky4T5Yki0jum/TDuW1evnP4nfyaqJqXIlvRmqf6t7dRit
         nZZ7XOcx/tk1oU0V8QUI7ngrejwwFkNbzmMSg9/bV9RRdj30jdH05bcBgyQ/xgSyFlvY
         abew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764254371; x=1764859171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heVo+DHjafEN8eJsdnjeLP4ETOfR9djRjIT87uAVdH8=;
        b=fiUNPNl7Y8oRCsjIqWLWAkhhSlC22ZHe9oCBaJn5l8ro3oDGIAkLo2PmwY8AHWigAM
         1MAp9kKWjiEfHgRo9uBYa43mkMZ4wVyd+3kue7z5LrpOSZzSrFJuMEnBa4r76+KXk/ln
         IXv14z26CspBftXfsTBK4l8YIoU6PI5ngsJ5hdbgeiHYY9cPJXZNIfIje9V/th/FALlD
         aPCOxBprVVZsHlTe0epNvdh3TVC2abAziZz1txcGmIZcXKlBK8QtI4mV2fiDCWx93GHK
         CnY1iiEjxTFr9+j8A9LdihQS3G17umyAzUiqi0H/0iZD12jEdIWBs1qP7l81sfKqrean
         Jhog==
X-Forwarded-Encrypted: i=1; AJvYcCUnxEi3gs181tlRJEkp87UPEZc+m0aRiZqx+O46FN6PFpvdCL67a1LoFCLoOJWAmOdAuCuZNzi+IiHu/62c2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ4euyO0F6O2FEmbaBVrLliyU9+L91wQlIHo2JEydcuDNmE4po
	uPicu/I0bi5yDGUgiyMZ1+Sp9uQZT+hM/LZkzCDafp2px5+RdRazpKbt
X-Gm-Gg: ASbGncun2arDgJBmcoAaeGutDuNYj2wGTro1z8MKYg1INSfhHUlopH8tA6nbSDfnyvY
	R8T7YQbDJAi46US9o/AsIWxsvjRJrx7y8pBWNtIYNzaKcSWPJ76vGqDqgOiBSJO6noHDaLmGJrQ
	S4KfWxgnD5Cln+JRzyYivdoe0aY4LfYc/3l9StGtQDDW/pU2zinyHg2tXhoz1rqcb3FBPqR1l98
	ALHQn8rvLK6x6a6GHgKMhLXxnKlKawDoKmj66joxGxIx24YCssp029uvpt1ChvWshkVS9JGYU3L
	kpxPKCkT4ZWJlLyd1ZktM1/yyZA9u2kZ+2+YCwW5uJssghaAglA+aMxAw8dS9tlGv25wlMdOFmj
	jAuhCU/ZcwdT2qb0fkIAejdpaNYZx93oyY8Hg91ehqO8mNP33b4MxgZE6cXeaNTYr+qnQQznj2q
	w3JK2rNkmaZmHRsLaZDRs=
X-Google-Smtp-Source: AGHT+IGaTaYMXIZM701yF5+2x/nm3odlNuZS1iDe6JBbBSrWVb1Rk2QQZ2uv7RVffi+oayRRGAHF8Q==
X-Received: by 2002:a05:600c:1d0e:b0:471:21:554a with SMTP id 5b1f17b1804b1-477c01860aemr239468195e9.13.1764254371015;
        Thu, 27 Nov 2025 06:39:31 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3f1sm3841853f8f.28.2025.11.27.06.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 06:39:30 -0800 (PST)
Message-ID: <d2be7248-67d6-4157-a10a-79cd243da0ab@gmail.com>
Date: Thu, 27 Nov 2025 16:39:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF
 mode table fail
To: Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
 Chukun Pan <amadeus@jmu.edu.cn>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8734yff8vr.fsf@kernel.org>
 <20231022090901.430143-1-amadeus@jmu.edu.cn> <878r7t21gm.fsf@kernel.org>
 <c2360ee8-9fdf-484f-9bfc-cff6f4e0a1e5@gmail.com>
 <97237da189ec42459ff92bf78d22592c@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <97237da189ec42459ff92bf78d22592c@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/11/2025 02:30, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 23/10/2023 11:21, Kalle Valo wrote:
>>> Chukun Pan <amadeus@jmu.edu.cn> writes:
>>>
>>>>> _Why_ is that warning printed? Are your devices uncalibrated or are they
>>>>> somehow else special?
>>>>
>>>> I don't know, but not only my rtl8822be wifi module will have this call trace
>>>> every time when the driver probes. This can be considered a common problem.
>>>> So I prefer to disable this call trace and use the driver warning instead.
>>>
>>> Why do you say this is a common problem? AFAIK you are the only one
>>> reporting this issue, right? It would help to understand _why_ you are
>>> seeing this, ie. what's the root cause? Just randomly removing warnings
>>> without understanding the root cause is frowned upon.
>>>
>>
>> Finally I got some useful reports about this. Someone added a printk
>> that shows the value of RF register 0x33 is 0xaeaea. This is why the
>> WARNING is triggered. The value 0xaeaea hints that the chip is powered
>> off.
>>
>> Then someone else provided a useful backtrace:
>>
>> [ 406.705972] ------------[ cut here ]------------
>> [ 406.710517] WARNING: CPU: 0 PID: 10287 at
>> backports-6.12.44/drivers/net/wireless/realtek/rtw88/rtw8822b.c:824 rtw8822b_set_antenna+0x3c/0x74
>> [rtw88_8822b]
>> [ 406.724296] write RF mode table fail
>> [ 406.727768] Modules linked in: rtw88_8822cu(O) rtw88_8822c(O) rtw88_8822bu(O) rtw88_8822b(O) pppoe
>> ppp_async wireguard rtw88_usb(O) rtw88_core(O) qcserial pppox ppp_generic option nft_fib_inet
>> nf_flow_table_inet mac80211(O) libchacha20poly1305 ipt_REJECT cfg80211(O) xt_time xt_tcpudp xt_tcpmss
>> xt_statistic xt_state xt_recent xt_policy xt_multiport xt_mark xt_mac xt_limit xt_length xt_hl xt_helper
>> xt_esp xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_LOG xt_HL
>> xt_DSCP xt_CT xt_CLASSIFY xfrm_interface usb_wwan slhc rtc_ds1307 rndis_host rfcomm qmi_wwan poly1305_arm
>> nft_xfrm nft_reject_ipv6 nft_reject_ipv4 nft_reject_inet nft_reject_bridge nft_reject nft_redir nft_quota
>> nft_numgen nft_nat nft_meta_bridge nft_masq nft_log nft_limit nft_hash nft_flow_offload nft_fib_ipv6
>> nft_fib_ipv4 nft_fib nft_ct nft_compat nft_chain_nat nf_tables nf_reject_ipv4 nf_nat nf_log_syslog
>> nf_flow_table nf_conntrack_bridge nf_conncount mdio_netlink(O) lm75 libcurve25519_generic libcrc32c
>> iptable_raw
>> [ 406.728658] iptable_mangle iptable_filter ipt_ah ipt_ECN ip_tables hwmon hidp hci_uart crc_ccitt compat(O)
>> chacha_neon cdc_ether btusb btrtl btmtk btintel bnep bluetooth act_connmark nf_conntrack nf_defrag_ipv6
>> nf_defrag_ipv4 sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_route cls_matchall cls_fw cls_flow
>> cls_basic act_skbedit act_mirred act_gact configs hid ledtrig_pattern ledtrig_oneshot cryptodev(O) xt_set
>> ip_set_list_set ip_set_hash_netportnet ip_set_hash_netport ip_set_hash_netnet ip_set_hash_netiface
>> ip_set_hash_net ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ipportip ip_set_hash_ipport
>> ip_set_hash_ipmark ip_set_hash_ipmac ip_set_hash_ip ip_set_bitmap_port ip_set_bitmap_ipmac
>> ip_set_bitmap_ip ip_set nfnetlink ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables
>> nf_reject_ipv6 swconfig qmi_wwan_q(O) usbnet cdc_wdm ip6_gre ip_gre gre ifb dummy ip6_vti ip_vti
>> ip6_udp_tunnel udp_tunnel ipcomp6 xfrm6_tunnel esp6 ah6 xfrm4_tunnel ipcomp esp4 ah4 ipip ip6_tunnel tunnel6
>> tunnel4 ip_tunnel vrf
>> [ 406.818527] tun xfrm_user xfrm_ipcomp af_key xfrm_algo ecdh_generic ecc crypto_user algif_skcipher
>> algif_rng algif_hash algif_aead af_alg sha512_arm sha1_generic sha1_arm md5 kpp echainiv ecb des_generic
>> libdes cmac cbc authencesn authenc gpio_keys_polled ledtrig_transient fsl_mph_dr_of ehci_platform ehci_fsl
>> microchip mii
>> [ 406.937051] CPU: 0 PID: 10287 Comm: iw Tainted: G W O 6.6.104 #0
>> [ 406.944163] Hardware name: Atmel SAMA5
>> [ 406.947867] unwind_backtrace from show_stack+0x10/0x14
>> [ 406.953043] show_stack from dump_stack_lvl+0x24/0x2c
>> [ 406.958033] dump_stack_lvl from __warn+0x98/0xc0
>> [ 406.962668] __warn from warn_slowpath_fmt+0x68/0x78
>> [ 406.967561] warn_slowpath_fmt from rtw8822b_set_antenna+0x3c/0x74 [rtw88_8822b]
>> [ 406.974877] rtw8822b_set_antenna [rtw88_8822b] from rtw_ops_set_antenna+0x4c/0x6c [rtw88_core]
>> [ 406.983566] rtw_ops_set_antenna [rtw88_core] from ieee80211_set_antenna+0x34/0x5c [mac80211]
>> [ 406.992524] ieee80211_set_antenna [mac80211] from nl80211_set_wiphy+0x37c/0x634 [cfg80211]
>> [ 407.001418] nl80211_set_wiphy [cfg80211] from genl_rcv_msg+0x24c/0x390
>> [ 407.008146] genl_rcv_msg from netlink_rcv_skb+0xb8/0x11c
>> [ 407.013465] netlink_rcv_skb from genl_rcv+0x28/0x34
>> [ 407.018358] genl_rcv from netlink_unicast+0x220/0x314
>> [ 407.023423] netlink_unicast from netlink_sendmsg+0x1cc/0x434
>> [ 407.029089] netlink_sendmsg from ____sys_sendmsg+0x1f0/0x284
>> [ 407.034758] ____sys_sendmsg from ___sys_sendmsg+0x6c/0xa4
>> [ 407.040165] ___sys_sendmsg from sys_sendmsg+0x44/0x74
>> [ 407.045230] sys_sendmsg from ret_fast_syscall+0x0/0x54
>>
>> So I tried to run "iw phy5 set antenna all" on my computer. When the
>> interface is UP this command fails with error -95. No WARNING.
>>
>> When the interface is DOWN this command succeeds but the WARNING
>> appears because the chip is powered off.
> 
> So I think rtw8822b_config_trx_mode() should not be called by
> rtw8822b_set_antenna() as chip is powered off.
> 

Indeed. I will send a patch.

