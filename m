Return-Path: <linux-wireless+bounces-29286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E4C80EDB
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 15:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39588343E7C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D3627B349;
	Mon, 24 Nov 2025 14:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNBdZPMt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37112F7479
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763993435; cv=none; b=IzmK2RC2ql5ciWJLKGrU1nuG+xxgGkNPSa/JNvqgq2iPh4Q6pb9amsfsjulry1cMoxQSPlM4y4d5Jo43SSc7hcbnDyETYhkhbpRLBoAffLYC/zQ44S/VeimS/hvn13wZgNezg+1voVBPVO9lD3YgwRR4IIDp4yqYiF+6VlgkOFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763993435; c=relaxed/simple;
	bh=0UUH9h/HezLYaCwdef0ptqxpBjeLPhVZHVXt8Y3vIik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TI52EnxUBZmWPFY+bEXv1TStzvG4zrqY9wRJ3SKx18ehLsMxcnI9LE4Lq4eCsZVSTsXwY/nWDAccMg6dAbiNpFOPfnAHbDzHJBgl86tYiCohrqKuIEKZgqNeRTmz/nVaPBOeisQnabPLqb0nSK+Y5Vblzlb7W/v/uHgXhQXkLao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNBdZPMt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59431f57bf6so4622682e87.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 06:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763993432; x=1764598232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0UUH9h/HezLYaCwdef0ptqxpBjeLPhVZHVXt8Y3vIik=;
        b=dNBdZPMtGRZxg9snwLwQo49Y7q/SXORwiImV0dcKEq7ak9XaHLhCRJyCxtX08q39ft
         mmXC51GqTDmKBxGGiDlhpiODImt0t635mxgZy0+Fpk48ES1oSJxoH1zjYowSq3+TYbeC
         7R8abUMu7VIPvUAHcDF/bBD2ZdZpKwhRlxXTSFu7Q6Ot3xI45tHeu2uSIP4V97fG6YvJ
         FtK9qXJd5knLBOGZAay+DcRKUOO1YGTeUs7veq71SVlrRKy9vBOW0mPxqcinuuskqv8G
         vKRy8rdlqVcwGL1d5GekZtwpaB1a1nzZFyqmZR/WXxKZ/e7sv/rKNESSuLYUNFkjFF1b
         5mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763993432; x=1764598232;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0UUH9h/HezLYaCwdef0ptqxpBjeLPhVZHVXt8Y3vIik=;
        b=uR7vFicw2kTNqK7ptRwam0HgvRD1fviPB+bD5t4VE45sbS8OyOfL1l9JbHMq0hBNgg
         hoxy8Mdp7rFNGw/3XKCDp6fh/HqTLgGEbNXDRIdpE3EM/vJZFSvTAnwpaSG9kLdtkunn
         vPOcXvZW41bIpOID9PzNYenGEn9Y7dCZNODQq1A6D8zvLCZWmYi2hqPfXMUZITs0sOsh
         aXgoevzZ5vXvfkR6Dxm0l8RM0+UsNq/GrtcXeoapYq7js4u4voj18k13AkNXIEACO6yg
         wX5eYKIHpCMxbhC5W/HxnG0LNhAW/0kcnLjTwvG0viuxG/jDZBAydMV3UspurGYiYFks
         hrnw==
X-Forwarded-Encrypted: i=1; AJvYcCUPBpp6acbuLrEoEOuuR57afSjZZlujVMHaV5rxr8SzJcWDZuTC/oGeHiML/d9NqcVNnZQ5b39De2FwWLuc0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6fT+LXRM+iPmFOvPWQXNLyKRrw437D4hVMxA03cRE/ngmmpf
	Rxcp7VqF+PPr7s/mb1HeifuQhgqudC5fABgu2v4Dbzon3juJgwdurL0vpfOmAg==
X-Gm-Gg: ASbGncsxQstk82k9NFqHFKGTZYFC/qaRkJSvSHLp0pIwZcHKlJOIAeh9+pV8CnnBt8z
	5ilezdzTF/f4svIC0s29Tp8hjHbQkTNV3Wo7jg66DpF2RGThvp6upjhNRosrRgZu/o3JGQ0ufQr
	aXj0lEbPXSeLlf5mpHfA7X4GaOpJp//vvPkrfeORbLUl3wk/AmHVIkZEAsmu6JRb1dA+ACe1Ep4
	15aNuW2eLTcMC93xfxUAzmgOlpxFVC5PhS53o2DMibNMdvYYDEnaKo7Aui6JTT4GrClYy3vQPWq
	imik+M16Ua74uvJU7Hh77W6XOy+dlFtdxLpY2h7UbZ6eh8o45WVpVms5BwRIBAPVoZEUOQwE8oB
	DVM9hQG7BufFKPhNUPtjUQN26K8XXu/uI8PUjF63+0HP5gJ9Y0DvsUZTJ07W8uRZN4274El1VJy
	f1NpYdSTT2C/VhwOyyOZPJxhT6UhBs3g==
X-Google-Smtp-Source: AGHT+IE+53nGlLAe2sDQDfpDFGtKmkdL6nuwMgP5ZUa1TZLNamJOFPR/5G38IgV+zx98USsjI9cCDw==
X-Received: by 2002:a05:6512:31cf:b0:594:2f46:3906 with SMTP id 2adb3069b0e04-596a3efd50amr4302040e87.42.1763993431651;
        Mon, 24 Nov 2025 06:10:31 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.59])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969dbc5e07sm4249879e87.83.2025.11.24.06.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 06:10:31 -0800 (PST)
Message-ID: <c2360ee8-9fdf-484f-9bfc-cff6f4e0a1e5@gmail.com>
Date: Mon, 24 Nov 2025 16:10:28 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: rtw88: 8822b: disable call trace when write RF
 mode table fail
To: Kalle Valo <kvalo@kernel.org>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: pkshih@realtek.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org
References: <8734yff8vr.fsf@kernel.org>
 <20231022090901.430143-1-amadeus@jmu.edu.cn> <878r7t21gm.fsf@kernel.org>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <878r7t21gm.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 23/10/2023 11:21, Kalle Valo wrote:
> Chukun Pan <amadeus@jmu.edu.cn> writes:
>=20
>>> _Why_ is that warning printed? Are your devices uncalibrated or are t=
hey
>>> somehow else special?
>>
>> I don't know, but not only my rtl8822be wifi module will have this cal=
l trace
>> every time when the driver probes. This can be considered a common pro=
blem.
>> So I prefer to disable this call trace and use the driver warning inst=
ead.
>=20
> Why do you say this is a common problem? AFAIK you are the only one
> reporting this issue, right? It would help to understand _why_ you are
> seeing this, ie. what's the root cause? Just randomly removing warnings=

> without understanding the root cause is frowned upon.
>=20

Finally I got some useful reports about this. Someone added a printk
that shows the value of RF register 0x33 is 0xaeaea. This is why the
WARNING is triggered. The value 0xaeaea hints that the chip is powered
off.

Then someone else provided a useful backtrace:

[ 406.705972] ------------[ cut here ]------------
[ 406.710517] WARNING: CPU: 0 PID: 10287 at backports-6.12.44/drivers/net=
/wireless/realtek/rtw88/rtw8822b.c:824 rtw8822b_set_antenna+0x3c/0x74 [rt=
w88_8822b]
[ 406.724296] write RF mode table fail
[ 406.727768] Modules linked in: rtw88_8822cu(O) rtw88_8822c(O) rtw88_882=
2bu(O) rtw88_8822b(O) pppoe ppp_async wireguard rtw88_usb(O) rtw88_core(O=
) qcserial pppox ppp_generic option nft_fib_inet nf_flow_table_inet mac80=
211(O) libchacha20poly1305 ipt_REJECT cfg80211(O) xt_time xt_tcpudp xt_tc=
pmss xt_statistic xt_state xt_recent xt_policy xt_multiport xt_mark xt_ma=
c xt_limit xt_length xt_hl xt_helper xt_esp xt_ecn xt_dscp xt_conntrack x=
t_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_LOG xt_HL xt=
_DSCP xt_CT xt_CLASSIFY xfrm_interface usb_wwan slhc rtc_ds1307 rndis_hos=
t rfcomm qmi_wwan poly1305_arm nft_xfrm nft_reject_ipv6 nft_reject_ipv4 n=
ft_reject_inet nft_reject_bridge nft_reject nft_redir nft_quota nft_numge=
n nft_nat nft_meta_bridge nft_masq nft_log nft_limit nft_hash nft_flow_of=
fload nft_fib_ipv6 nft_fib_ipv4 nft_fib nft_ct nft_compat nft_chain_nat n=
f_tables nf_reject_ipv4 nf_nat nf_log_syslog nf_flow_table nf_conntrack_b=
ridge nf_conncount mdio_netlink(O) lm75 libcurve25519_generic libcrc32c i=
ptable_raw
[ 406.728658] iptable_mangle iptable_filter ipt_ah ipt_ECN ip_tables hwmo=
n hidp hci_uart crc_ccitt compat(O) chacha_neon cdc_ether btusb btrtl btm=
tk btintel bnep bluetooth act_connmark nf_conntrack nf_defrag_ipv6 nf_def=
rag_ipv4 sch_tbf sch_ingress sch_htb sch_hfsc em_u32 cls_u32 cls_route cl=
s_matchall cls_fw cls_flow cls_basic act_skbedit act_mirred act_gact conf=
igs hid ledtrig_pattern ledtrig_oneshot cryptodev(O) xt_set ip_set_list_s=
et ip_set_hash_netportnet ip_set_hash_netport ip_set_hash_netnet ip_set_h=
ash_netiface ip_set_hash_net ip_set_hash_mac ip_set_hash_ipportnet ip_set=
_hash_ipportip ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ipmac ip=
_set_hash_ip ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_s=
et nfnetlink ip6table_mangle ip6table_filter ip6_tables ip6t_REJECT x_tab=
les nf_reject_ipv6 swconfig qmi_wwan_q(O) usbnet cdc_wdm ip6_gre ip_gre g=
re ifb dummy ip6_vti ip_vti ip6_udp_tunnel udp_tunnel ipcomp6 xfrm6_tunne=
l esp6 ah6 xfrm4_tunnel ipcomp esp4 ah4 ipip ip6_tunnel tunnel6 tunnel4 i=
p_tunnel vrf
[ 406.818527] tun xfrm_user xfrm_ipcomp af_key xfrm_algo ecdh_generic ecc=
 crypto_user algif_skcipher algif_rng algif_hash algif_aead af_alg sha512=
_arm sha1_generic sha1_arm md5 kpp echainiv ecb des_generic libdes cmac c=
bc authencesn authenc gpio_keys_polled ledtrig_transient fsl_mph_dr_of eh=
ci_platform ehci_fsl microchip mii
[ 406.937051] CPU: 0 PID: 10287 Comm: iw Tainted: G W O 6.6.104 #0
[ 406.944163] Hardware name: Atmel SAMA5
[ 406.947867] unwind_backtrace from show_stack+0x10/0x14
[ 406.953043] show_stack from dump_stack_lvl+0x24/0x2c
[ 406.958033] dump_stack_lvl from __warn+0x98/0xc0
[ 406.962668] __warn from warn_slowpath_fmt+0x68/0x78
[ 406.967561] warn_slowpath_fmt from rtw8822b_set_antenna+0x3c/0x74 [rtw8=
8_8822b]
[ 406.974877] rtw8822b_set_antenna [rtw88_8822b] from rtw_ops_set_antenna=
+0x4c/0x6c [rtw88_core]
[ 406.983566] rtw_ops_set_antenna [rtw88_core] from ieee80211_set_antenna=
+0x34/0x5c [mac80211]
[ 406.992524] ieee80211_set_antenna [mac80211] from nl80211_set_wiphy+0x3=
7c/0x634 [cfg80211]
[ 407.001418] nl80211_set_wiphy [cfg80211] from genl_rcv_msg+0x24c/0x390
[ 407.008146] genl_rcv_msg from netlink_rcv_skb+0xb8/0x11c
[ 407.013465] netlink_rcv_skb from genl_rcv+0x28/0x34
[ 407.018358] genl_rcv from netlink_unicast+0x220/0x314
[ 407.023423] netlink_unicast from netlink_sendmsg+0x1cc/0x434
[ 407.029089] netlink_sendmsg from ____sys_sendmsg+0x1f0/0x284
[ 407.034758] ____sys_sendmsg from ___sys_sendmsg+0x6c/0xa4
[ 407.040165] ___sys_sendmsg from sys_sendmsg+0x44/0x74
[ 407.045230] sys_sendmsg from ret_fast_syscall+0x0/0x54

So I tried to run "iw phy5 set antenna all" on my computer. When the
interface is UP this command fails with error -95. No WARNING.

When the interface is DOWN this command succeeds but the WARNING
appears because the chip is powered off.

