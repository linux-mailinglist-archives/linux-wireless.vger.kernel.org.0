Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBBB436C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 23:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbfIPVor (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 17:44:47 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:24288 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbfIPVor (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 17:44:47 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 17:44:46 EDT
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 69E67507AF;
        Mon, 16 Sep 2019 23:37:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 6hfBl1mXJvza; Mon, 16 Sep 2019 23:36:58 +0200 (CEST)
Subject: Re: [PATCH] ath10k: Check if station exists before forwarding tx
 airtime report
To:     kvalo@codeaurora.org
Cc:     hannu.nyman@iki.fi, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, mpubbise@codeaurora.org
References: <20190818190920.22813-1-hauke@hauke-m.de>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hauke@hauke-m.de; keydata=
 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
Message-ID: <768b757b-7896-9dd0-3fc9-c1a7532333d9@hauke-m.de>
Date:   Mon, 16 Sep 2019 23:36:53 +0200
MIME-Version: 1.0
In-Reply-To: <20190818190920.22813-1-hauke@hauke-m.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="z0lKSHxyTcj1NO7mcakd6yX5eBoGCajkP"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z0lKSHxyTcj1NO7mcakd6yX5eBoGCajkP
Content-Type: multipart/mixed; boundary="IYyUJQXknpPaiz7LN2mDKesfI03LucIOH";
 protected-headers="v1"
From: Hauke Mehrtens <hauke@hauke-m.de>
To: kvalo@codeaurora.org
Cc: hannu.nyman@iki.fi, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org, mpubbise@codeaurora.org
Message-ID: <768b757b-7896-9dd0-3fc9-c1a7532333d9@hauke-m.de>
Subject: Re: [PATCH] ath10k: Check if station exists before forwarding tx
 airtime report
References: <20190818190920.22813-1-hauke@hauke-m.de>
In-Reply-To: <20190818190920.22813-1-hauke@hauke-m.de>

--IYyUJQXknpPaiz7LN2mDKesfI03LucIOH
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/18/19 9:09 PM, Hauke Mehrtens wrote:
> It looks like the FW on QCA9984 already reports the tx airtimes before
> the station is added to the peer entry. The peer entry is created in
> ath10k_peer_map_event() just with the vdev_id and the ethaddr, but
> not with a station entry, this is added later in ath10k_peer_create() i=
n
> callbacks from mac80211.
>=20
> When there is no sta added to the peer entry, this function fails
> because it calls ieee80211_sta_register_airtime() with NULL.
>=20
> This was reported in OpenWrt some time ago:
> https://bugs.openwrt.org/index.php?do=3Ddetails&task_id=3D2414
>=20
> This commit should fix this crash:
> [   75.991714] Unable to handle kernel paging request at virtual addres=
s fffff9e8
> [   75.991756] pgd =3D c0204000
> [   75.997955] [fffff9e8] *pgd=3D5fdfd861, *pte=3D00000000, *ppte=3D000=
00000
> [   76.000537] Internal error: Oops: 37 [#1] SMP ARM
> [   76.006686] Modules linked in: pppoe ppp_async ath10k_pci ath10k_cor=
e ath pptp pppox ppp_mppe ppp_generic mac80211 iptable_nat ipt_REJECT ipt=
_MASQUERADE cfg80211 xt_time xt_tcpudp xt_tcpmss xt_statistic xt_state xt=
_recent xt_nat xt_multiport xt_mark xt_mac xt_limit xt_length xt_hl xt_he=
lper xt_esp xt_ecn xt_dscp xt_conntrack xt_connmark xt_connlimit xt_connb=
ytes xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP=
 xt_CT xt_CLASSIFY usbserial slhc nf_reject_ipv4 nf_nat_redirect nf_nat_m=
asquerade_ipv4 nf_conntrack_ipv4 nf_nat_ipv4 nf_log_ipv4 nf_flow_table_hw=
 nf_flow_table nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack_netlink i=
ptable_raw iptable_mangle iptable_filter ipt_ah ipt_ECN ip_tables crc_cci=
tt compat chaoskey fuse sch_cake sch_tbf sch_ingress sch_htb sch_hfsc em_=
u32 cls_u32
> [   76.059974]  cls_tcindex cls_route cls_matchall cls_fw cls_flow cls_=
basic act_skbedit act_mirred ledtrig_usbport xt_set ip_set_list_set ip_se=
t_hash_netportnet ip_set_hash_netport ip_set_hash_netnet ip_set_hash_neti=
face ip_set_hash_net ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ip=
portip ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ip ip_set_bitmap=
_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set nfnetlink ip6table_nat =
nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6t_NPT ip6t_MASQUERADE nf_=
nat_masquerade_ipv6 nf_nat nf_conntrack nf_log_ipv6 nf_log_common ip6tabl=
e_mangle ip6table_filter ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 m=
sdos ip_gre gre ifb sit tunnel4 ip_tunnel tun vfat fat hfsplus cifs nls_u=
tf8 nls_iso8859_15 nls_iso8859_1 nls_cp850 nls_cp437 nls_cp1250 sha1_gene=
ric md5 md4
> [   76.130634]  usb_storage leds_gpio xhci_plat_hcd xhci_pci xhci_hcd d=
wc3 dwc3_of_simple ohci_platform ohci_hcd phy_qcom_dwc3 ahci ehci_platfor=
m sd_mod ahci_platform libahci_platform libahci libata scsi_mod ehci_hcd =
gpio_button_hotplug ext4 mbcache jbd2 exfat crc32c_generic
> [   76.154772] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.14.132 #0
> [   76.177001] Hardware name: Generic DT based system
> [   76.182990] task: c0b06d80 task.stack: c0b00000
> [   76.187832] PC is at ieee80211_sta_register_airtime+0x24/0x148 [mac8=
0211]
> [   76.192211] LR is at ath10k_htt_t2h_msg_handler+0x678/0x10f4 [ath10k=
_core]
> [   76.199052] pc : [<bf75bfac>]    lr : [<bf83e8b0>]    psr: a0000113
> [   76.205820] sp : c0b01d54  ip : 00000002  fp : bf869c0c
> [   76.211981] r10: 0000003c  r9 : dbdca138  r8 : 00060002
> [   76.217192] r7 : 00000000  r6 : dabe1150  r5 : 00000000  r4 : dbdc95=
c0
> [   76.222401] r3 : 00000000  r2 : 00060002  r1 : 00000000  r0 : 000000=
00
> [   76.229003] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Seg=
ment none
> [   76.235509] Control: 10c5787d  Table: 5c94006a  DAC: 00000051
> [   76.242716] Process swapper/0 (pid: 0, stack limit =3D 0xc0b00210)
> [   76.248446] Stack: (0xc0b01d54 to 0xc0b02000)
> [   76.254532] 1d40:                                              dbdc9=
5c0 00000000 dabe1150
> [   76.258808] 1d60: 00000001 dabe1150 dbdca138 0000003c bf869c0c bf83e=
8b0 00000002 c0314b10
> [   76.266969] 1d80: dbdc9c70 00000001 00000001 dabe114c 00010000 00000=
000 dbdcd724 bf88f3d8
> [   76.275126] 1da0: c0310d28 db393c00 dbdc95c0 00000000 c0b01dd0 c07fb=
4c4 dbdcd724 00000001
> [   76.283286] 1dc0: 00000022 bf88b09c db393c00 00000022 c0b01dd0 c0b01=
dd0 00000000 dbdcc5c0
> [   76.291445] 1de0: bf88f04c dbdcd654 dbdcd71c dbdc95c0 00000014 dbdcd=
724 dbdcc5c0 00000005
> [   76.299605] 1e00: 0004b400 bf85c360 00000000 bf87101c c0b01e24 00000=
006 00000000 dbdc95c0
> [   76.307764] 1e20: 00000001 00000040 0000012c c0b01e80 1cf51000 bf85c=
448 dbdcd440 dbdc95c0
> [   76.315925] 1e40: dbdca440 ffffa880 00000040 bf88cb68 dbdcd440 00000=
001 00000040 ffffa880
> [   76.324084] 1e60: c0b02d00 c06d72e0 dd990080 c0a3f080 c0b255dc c0b04=
7e4 c090afac c090e80c
> [   76.332244] 1e80: c0b01e80 c0b01e80 c0b01e88 c0b01e88 dd4cc200 00000=
000 00000003 c0b0208c
> [   76.340405] 1ea0: c0b02080 40000003 ffffe000 00000100 c0b02080 c0301=
5c8 00000000 00000001
> [   76.348564] 1ec0: dd408000 c0a38210 c0b2c7c0 0000000a ffffa880 c0b02=
d00 c07fb764 00200102
> [   76.356723] 1ee0: dd4cc268 c0a3e414 00000000 00000000 00000001 dd408=
000 de803000 00000000
> [   76.364883] 1f00: 00000000 c03247cc c0a3e414 c0368f1c c0b03f60 c0b15=
3cc de80200c de802000
> [   76.373042] 1f20: c0b01f48 c0301488 c0308630 60000013 ffffffff c0b01=
f7c 00000000 c0b00000
> [   76.381204] 1f40: 00000000 c030c08c 00000001 00000000 00000000 c0315=
180 ffffe000 c0b03cc0
> [   76.389363] 1f60: c0b03c70 00000000 00000000 c0a2da28 00000000 00000=
000 c0b01f90 c0b01f98
> [   76.397522] 1f80: c030862c c0308630 60000013 ffffffff 00000051 00000=
000 ffffe000 c035dd18
> [   76.405681] 1fa0: 000000bf c0b03c40 00000000 c0b2c000 dddfce80 c035e=
060 c0b2c040 c0a00cf4
> [   76.413842] 1fc0: ffffffff ffffffff 00000000 c0a0067c c0a2da28 00000=
000 00000000 c0b2c1d4
> [   76.422001] 1fe0: c0b03c5c c0a2da24 c0b07ee0 4220406a 512f04d0 42208=
07c 00000000 00000000
> [   76.430335] [<bf75bfac>] (ieee80211_sta_register_airtime [mac80211])=
 from [<00000002>] (0x2)
> [   76.438314] Code: e1cd81f0 e1a08002 e1cda1f8 e58de020 (e5102618)
> [   76.446965] ---[ end trace 227a38ade964d642 ]---
>=20
> Fixes: bb31b7cb106c ("ath10k: report tx airtime provided by fw")
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

What is the status of this patch? It fixes a problem multiple OpenWrt
user complained about.

Hauke

>  drivers/net/wireless/ath/ath10k/htt_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wir=
eless/ath/ath10k/htt_rx.c
> index 83a7fb68fd24..7f3ec7fa5a44 100644
> --- a/drivers/net/wireless/ath/ath10k/htt_rx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
> @@ -2639,7 +2639,7 @@ static void ath10k_htt_rx_tx_compl_ind(struct ath=
10k *ar,
>  		spin_lock_bh(&ar->data_lock);
> =20
>  		peer =3D ath10k_peer_find_by_id(ar, peer_id);
> -		if (!peer) {
> +		if (!peer || !peer->sta) {
>  			spin_unlock_bh(&ar->data_lock);
>  			rcu_read_unlock();
>  			continue;
>=20



--IYyUJQXknpPaiz7LN2mDKesfI03LucIOH--

--z0lKSHxyTcj1NO7mcakd6yX5eBoGCajkP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEyz0/uAcd+JwXmwtD8bdnhZyy68cFAl2AAHUACgkQ8bdnhZyy
68d+Ygf/SDPYQ0z7KvZure77DT5jqehpTBUb0GiVcYpwynMetp6FnAUsvHmag8BQ
XciBMO76Is4UK49mnpwbSlS6AvPkjXcG+ql7miGPyC247cg6MBIgBBb/xoMRegbV
5DzAw1UkkdzEzg1zHHOwxXIzojo6CU0xMRcwlSWrvvUcNViNSYe9q4tvL9wLV/28
MjOs6eA+b7uZh1zz0pM2MkG0Cm7YQ4yDzsdxi6dAo/djJavPY5PihDN9mDxF545w
9AN9LS2cwxrKN/rjBIT7IXn2i8GU6oP9aF4N+5FuWG99++kEifiY9SjpVN24pcOC
OoAWRriItr3+hf5QfrNb8S7XmLXfyQ==
=+ejs
-----END PGP SIGNATURE-----

--z0lKSHxyTcj1NO7mcakd6yX5eBoGCajkP--
