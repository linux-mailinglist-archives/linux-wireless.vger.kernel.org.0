Return-Path: <linux-wireless+bounces-13876-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786169998C1
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 03:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA606284683
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E294B4C7D;
	Fri, 11 Oct 2024 01:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GRwRdAtn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D1BE4A;
	Fri, 11 Oct 2024 01:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609021; cv=none; b=a0H+kr+98d4WoDF3aYkfsrzZPqHkrAgXE5GN9ZBM7JE01PTtulNXBtArQFqK1CTfBLoJZZkCA/3MS2eFJgwyzc/xOiy3NWa9B+7kDf3Iv8fYvotZ710muJrZu97aIDuQhZ48tHDfZDO/VZG/g9t29JVlvvWt/VOY2H0h8jPfbTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609021; c=relaxed/simple;
	bh=AWbKCh81ztMi1RBcHBDGmYNoDL8AC12zvijs3iAuyR8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Yu3WJePS0sYX2BAx5mijh6aazLihnStGdGDUJhXKWav8FLZF20d5RDQ4u/METa4tcrSkFVAjUuwFw6JlxOUFG9qppEcR4rn1MVg3VlvUymfWmkmXZ6YfVCwa9GpIMWw/8sK4teD/6eV/ohB4BxI0Cacn3E4VUTrz86uTs3unWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GRwRdAtn; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1728609016;
	bh=vh/yYFUJJ/LUk4IlqTluOf25oGKEQmdsGuHGh5VentA=;
	h=Date:From:To:Cc:Subject:From;
	b=GRwRdAtn2irwdDstdRSkJK7tdwD9GLOCzu8isXVoyKB+gXF/4XtYoJRrWCd4+BvM6
	 J58SGc1TfEo25cxnDuTiqwO7RpPLj9IWkCjqDnnx4qTNVIFYXWn/lT8CeVjavO0yuA
	 OKY2Xx6tSJ0coRasLcfwLz0mBOuO2JQwhdGTOT4sKJv4cy+IFUbBbWR5RgxlVbhp2d
	 KJ2CZ+lAWL7lQk0NcNCwn+kgp5Gi5NY9luKSuwyv1fFVuzX7uodqsHoHXtaeI7P4pq
	 9OBZ6fUcZ3PSFsZtfIYNoYQM+rSHpFHsQ6GiQICyy+TSq2MDD/dNkFn3Jsyg6jcBuE
	 5t1+JtMW76SIA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XPpT25fKhz4wy9;
	Fri, 11 Oct 2024 12:10:14 +1100 (AEDT)
Date: Fri, 11 Oct 2024 12:10:14 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg
 <johannes@sipsolutions.net>, David Miller <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Johannes Berg
 <johannes.berg@intel.com>, Wireless <linux-wireless@vger.kernel.org>,
 Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the wireless-next tree with the
 net-next tree
Message-ID: <20241011121014.674661a0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Lm7gjBlT0r9DPTO5PB94P4e";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Lm7gjBlT0r9DPTO5PB94P4e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-next tree got a conflict in:

  Documentation/networking/net_cachelines/net_device.rst

between commit:

  54b771e6c675 ("doc: net: Fix .rst rendering of net_cachelines pages")

from the net-next tree and commit:

  836265d31631 ("wifi: remove iw_public_data from struct net_device")

from the wireless-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/networking/net_cachelines/net_device.rst
index 1b018ac35e9a,efea96862a76..000000000000
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@@ -5,184 -5,182 +5,183 @@@
  net_device struct fast path usage breakdown
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =20
 -Type                                Name                    fastpath_tx_a=
ccess  fastpath_rx_access  Comments
 -..struct                            ..net_device                         =
                          =20
 -unsigned_long:32                    priv_flags              read_mostly  =
       -                   __dev_queue_xmit(tx)
 -unsigned_long:1                     lltx                    read_mostly  =
       -                   HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(tx)
 -char                                name[16]                -            =
       -                  =20
 -struct_netdev_name_node*            name_node                            =
                          =20
 -struct_dev_ifalias*                 ifalias                              =
                          =20
 -unsigned_long                       mem_end                              =
                          =20
 -unsigned_long                       mem_start                            =
                          =20
 -unsigned_long                       base_addr                            =
                          =20
 -unsigned_long                       state                   read_mostly  =
       read_mostly         netif_running(dev)
 -struct_list_head                    dev_list                             =
                          =20
 -struct_list_head                    napi_list                            =
                          =20
 -struct_list_head                    unreg_list                           =
                          =20
 -struct_list_head                    close_list                           =
                          =20
 -struct_list_head                    ptype_all               read_mostly  =
       -                   dev_nit_active(tx)
 -struct_list_head                    ptype_specific                       =
       read_mostly         deliver_ptype_list_skb/__netif_receive_skb_core(=
rx)
 -struct                              adj_list                             =
                          =20
 -unsigned_int                        flags                   read_mostly  =
       read_mostly         __dev_queue_xmit,__dev_xmit_skb,ip6_output,__ip6=
_finish_output(tx);ip6_rcv_core(rx)
 -xdp_features_t                      xdp_features                         =
                          =20
 -struct_net_device_ops*              netdev_ops              read_mostly  =
       -                   netdev_core_pick_tx,netdev_start_xmit(tx)
 -struct_xdp_metadata_ops*            xdp_metadata_ops                     =
                          =20
 -int                                 ifindex                 -            =
       read_mostly         ip6_rcv_core
 -unsigned_short                      gflags                               =
                          =20
 -unsigned_short                      hard_header_len         read_mostly  =
       read_mostly         ip6_xmit(tx);gro_list_prepare(rx)
 -unsigned_int                        mtu                     read_mostly  =
       -                   ip_finish_output2
 -unsigned_short                      needed_headroom         read_mostly  =
       -                   LL_RESERVED_SPACE/ip_finish_output2
 -unsigned_short                      needed_tailroom                      =
                          =20
 -netdev_features_t                   features                read_mostly  =
       read_mostly         HARD_TX_LOCK,netif_skb_features,sk_setup_caps(tx=
);netif_elide_gro(rx)
 -netdev_features_t                   hw_features                          =
                          =20
 -netdev_features_t                   wanted_features                      =
                          =20
 -netdev_features_t                   vlan_features                        =
                          =20
 -netdev_features_t                   hw_enc_features         -            =
       -                   netif_skb_features
 -netdev_features_t                   mpls_features                        =
                          =20
 -netdev_features_t                   gso_partial_features    read_mostly  =
                           gso_features_check
 -unsigned_int                        min_mtu                              =
                          =20
 -unsigned_int                        max_mtu                              =
                          =20
 -unsigned_short                      type                                 =
                          =20
 -unsigned_char                       min_header_len                       =
                          =20
 -unsigned_char                       name_assign_type                     =
                          =20
 -int                                 group                                =
                          =20
 -struct_net_device_stats             stats                                =
                          =20
 -struct_net_device_core_stats*       core_stats                           =
                          =20
 -atomic_t                            carrier_up_count                     =
                          =20
 -atomic_t                            carrier_down_count                   =
                          =20
 -struct_iw_handler_def*              wireless_handlers                    =
                          =20
 -struct_ethtool_ops*                 ethtool_ops                          =
                          =20
 -struct_l3mdev_ops*                  l3mdev_ops                           =
                          =20
 -struct_ndisc_ops*                   ndisc_ops                            =
                          =20
 -struct_xfrmdev_ops*                 xfrmdev_ops                          =
                          =20
 -struct_tlsdev_ops*                  tlsdev_ops                           =
                          =20
 -struct_header_ops*                  header_ops              read_mostly  =
       -                   ip_finish_output2,ip6_finish_output2(tx)
 -unsigned_char                       operstate                            =
                          =20
 -unsigned_char                       link_mode                            =
                          =20
 -unsigned_char                       if_port                              =
                          =20
 -unsigned_char                       dma                                  =
                          =20
 -unsigned_char                       perm_addr[32]                        =
                          =20
 -unsigned_char                       addr_assign_type                     =
                          =20
 -unsigned_char                       addr_len                             =
                          =20
 -unsigned_char                       upper_level                          =
                          =20
 -unsigned_char                       lower_level                          =
                          =20
 -unsigned_short                      neigh_priv_len                       =
                          =20
 -unsigned_short                      padded                               =
                          =20
 -unsigned_short                      dev_id                               =
                          =20
 -unsigned_short                      dev_port                             =
                          =20
 -spinlock_t                          addr_list_lock                       =
                          =20
 -int                                 irq                                  =
                          =20
 -struct_netdev_hw_addr_list          uc                                   =
                          =20
 -struct_netdev_hw_addr_list          mc                                   =
                          =20
 -struct_netdev_hw_addr_list          dev_addrs                            =
                          =20
 -struct_kset*                        queues_kset                          =
                          =20
 -struct_list_head                    unlink_list                          =
                          =20
 -unsigned_int                        promiscuity                          =
                          =20
 -unsigned_int                        allmulti                             =
                          =20
 -bool                                uc_promisc                           =
                          =20
 -unsigned_char                       nested_level                         =
                          =20
 -struct_in_device*                   ip_ptr                  read_mostly  =
       read_mostly         __in_dev_get
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +Type                                Name                        fastpath_=
tx_access  fastpath_rx_access  Comments
 +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 +unsigned_long:32                    priv_flags                  read_most=
ly                             __dev_queue_xmit(tx)
 +unsigned_long:1                     lltx                        read_most=
ly                             HARD_TX_LOCK,HARD_TX_TRYLOCK,HARD_TX_UNLOCK(=
tx)
 +char                                name[16]
 +struct netdev_name_node*            name_node
 +struct dev_ifalias*                 ifalias
 +unsigned_long                       mem_end
 +unsigned_long                       mem_start
 +unsigned_long                       base_addr
 +unsigned_long                       state                       read_most=
ly         read_mostly         netif_running(dev)
 +struct list_head                    dev_list
 +struct list_head                    napi_list
 +struct list_head                    unreg_list
 +struct list_head                    close_list
 +struct list_head                    ptype_all                   read_most=
ly                             dev_nit_active(tx)
 +struct list_head                    ptype_specific                       =
           read_mostly         deliver_ptype_list_skb/__netif_receive_skb_c=
ore(rx)
 +struct                              adj_list
 +unsigned_int                        flags                       read_most=
ly         read_mostly         __dev_queue_xmit,__dev_xmit_skb,ip6_output,_=
_ip6_finish_output(tx);ip6_rcv_core(rx)
 +xdp_features_t                      xdp_features
 +struct net_device_ops*              netdev_ops                  read_most=
ly                             netdev_core_pick_tx,netdev_start_xmit(tx)
 +struct xdp_metadata_ops*            xdp_metadata_ops
 +int                                 ifindex                              =
           read_mostly         ip6_rcv_core
 +unsigned_short                      gflags
 +unsigned_short                      hard_header_len             read_most=
ly         read_mostly         ip6_xmit(tx);gro_list_prepare(rx)
 +unsigned_int                        mtu                         read_most=
ly                             ip_finish_output2
 +unsigned_short                      needed_headroom             read_most=
ly                             LL_RESERVED_SPACE/ip_finish_output2
 +unsigned_short                      needed_tailroom
 +netdev_features_t                   features                    read_most=
ly         read_mostly         HARD_TX_LOCK,netif_skb_features,sk_setup_cap=
s(tx);netif_elide_gro(rx)
 +netdev_features_t                   hw_features
 +netdev_features_t                   wanted_features
 +netdev_features_t                   vlan_features
 +netdev_features_t                   hw_enc_features                      =
                               netif_skb_features
 +netdev_features_t                   mpls_features
 +netdev_features_t                   gso_partial_features        read_most=
ly                             gso_features_check
 +unsigned_int                        min_mtu
 +unsigned_int                        max_mtu
 +unsigned_short                      type
 +unsigned_char                       min_header_len
 +unsigned_char                       name_assign_type
 +int                                 group
 +struct net_device_stats             stats
 +struct net_device_core_stats*       core_stats
 +atomic_t                            carrier_up_count
 +atomic_t                            carrier_down_count
 +struct iw_handler_def*              wireless_handlers
- struct iw_public_data*              wireless_data
 +struct ethtool_ops*                 ethtool_ops
 +struct l3mdev_ops*                  l3mdev_ops
 +struct ndisc_ops*                   ndisc_ops
 +struct xfrmdev_ops*                 xfrmdev_ops
 +struct tlsdev_ops*                  tlsdev_ops
 +struct header_ops*                  header_ops                  read_most=
ly                             ip_finish_output2,ip6_finish_output2(tx)
 +unsigned_char                       operstate
 +unsigned_char                       link_mode
 +unsigned_char                       if_port
 +unsigned_char                       dma
 +unsigned_char                       perm_addr[32]
 +unsigned_char                       addr_assign_type
 +unsigned_char                       addr_len
 +unsigned_char                       upper_level
 +unsigned_char                       lower_level
 +unsigned_short                      neigh_priv_len
 +unsigned_short                      padded
 +unsigned_short                      dev_id
 +unsigned_short                      dev_port
 +spinlock_t                          addr_list_lock
 +int                                 irq
 +struct netdev_hw_addr_list          uc
 +struct netdev_hw_addr_list          mc
 +struct netdev_hw_addr_list          dev_addrs
 +struct kset*                        queues_kset
 +struct list_head                    unlink_list
 +unsigned_int                        promiscuity
 +unsigned_int                        allmulti
 +bool                                uc_promisc
 +unsigned_char                       nested_level
 +struct in_device*                   ip_ptr                      read_most=
ly         read_mostly         __in_dev_get
  struct hlist_head                   fib_nh_head
 -struct_inet6_dev*                   ip6_ptr                 read_mostly  =
       read_mostly         __in6_dev_get
 -struct_vlan_info*                   vlan_info                            =
                          =20
 -struct_dsa_port*                    dsa_ptr                              =
                          =20
 -struct_tipc_bearer*                 tipc_ptr                             =
                          =20
 -void*                               atalk_ptr                            =
                          =20
 -void*                               ax25_ptr                             =
                          =20
 -struct_wireless_dev*                ieee80211_ptr                        =
                          =20
 -struct_wpan_dev*                    ieee802154_ptr                       =
                          =20
 -struct_mpls_dev*                    mpls_ptr                             =
                          =20
 -struct_mctp_dev*                    mctp_ptr                             =
                          =20
 -unsigned_char*                      dev_addr                             =
                          =20
 -struct_netdev_queue*                _rx                     read_mostly  =
       -                   netdev_get_rx_queue(rx)
 -unsigned_int                        num_rx_queues                        =
                          =20
 -unsigned_int                        real_num_rx_queues      -            =
       read_mostly         get_rps_cpu
 -struct_bpf_prog*                    xdp_prog                -            =
       read_mostly         netif_elide_gro()
 -unsigned_long                       gro_flush_timeout       -            =
       read_mostly         napi_complete_done
 -u32                                 napi_defer_hard_irqs    -            =
       read_mostly         napi_complete_done
 -unsigned_int                        gro_max_size            -            =
       read_mostly         skb_gro_receive
 -unsigned_int                        gro_ipv4_max_size       -            =
       read_mostly         skb_gro_receive
 -rx_handler_func_t*                  rx_handler              read_mostly  =
       -                   __netif_receive_skb_core
 -void*                               rx_handler_data         read_mostly  =
       -                  =20
 -struct_netdev_queue*                ingress_queue           read_mostly  =
       -                  =20
 -struct_bpf_mprog_entry              tcx_ingress             -            =
       read_mostly         sch_handle_ingress
 -struct_nf_hook_entries*             nf_hooks_ingress                     =
                          =20
 -unsigned_char                       broadcast[32]                        =
                          =20
 -struct_cpu_rmap*                    rx_cpu_rmap                          =
                          =20
 -struct_hlist_node                   index_hlist                          =
                          =20
 -struct_netdev_queue*                _tx                     read_mostly  =
       -                   netdev_get_tx_queue(tx)
 -unsigned_int                        num_tx_queues           -            =
       -                  =20
 -unsigned_int                        real_num_tx_queues      read_mostly  =
       -                   skb_tx_hash,netdev_core_pick_tx(tx)
 -unsigned_int                        tx_queue_len                         =
                          =20
 -spinlock_t                          tx_global_lock                       =
                          =20
 -struct_xdp_dev_bulk_queue__percpu*  xdp_bulkq                            =
                          =20
 -struct_xps_dev_maps*                xps_maps[2]             read_mostly  =
       -                   __netif_set_xps_queue
 -struct_bpf_mprog_entry              tcx_egress              read_mostly  =
       -                   sch_handle_egress
 -struct_nf_hook_entries*             nf_hooks_egress         read_mostly  =
       -                  =20
 -struct_hlist_head                   qdisc_hash[16]                       =
                          =20
 -struct_timer_list                   watchdog_timer                       =
                          =20
 -int                                 watchdog_timeo                       =
                          =20
 -u32                                 proto_down_reason                    =
                          =20
 -struct_list_head                    todo_list                            =
                          =20
 -int__percpu*                        pcpu_refcnt                          =
                          =20
 -refcount_t                          dev_refcnt                           =
                          =20
 -struct_ref_tracker_dir              refcnt_tracker                       =
                          =20
 -struct_list_head                    link_watch_list                      =
                          =20
 -enum:8                              reg_state                            =
                          =20
 -bool                                dismantle                            =
                          =20
 -enum:16                             rtnl_link_state                      =
                          =20
 -bool                                needs_free_netdev                    =
                          =20
 -void*priv_destructor                struct_net_device                    =
                          =20
 -struct_netpoll_info*                npinfo                  -            =
       read_mostly         napi_poll/napi_poll_lock
 -possible_net_t                      nd_net                  -            =
       read_mostly         (dev_net)napi_busy_loop,tcp_v(4/6)_rcv,ip(v6)_rc=
v,ip(6)_input,ip(6)_input_finish
 -void*                               ml_priv                              =
                          =20
 -enum_netdev_ml_priv_type            ml_priv_type                         =
                          =20
 -struct_pcpu_lstats__percpu*         lstats                  read_mostly  =
                           dev_lstats_add()
 -struct_pcpu_sw_netstats__percpu*    tstats                  read_mostly  =
                           dev_sw_netstats_tx_add()
 -struct_pcpu_dstats__percpu*         dstats                               =
                          =20
 -struct_garp_port*                   garp_port                            =
                          =20
 -struct_mrp_port*                    mrp_port                             =
                          =20
 -struct_dm_hw_stat_delta*            dm_private                           =
                          =20
 -struct_device                       dev                     -            =
       -                  =20
 -struct_attribute_group*             sysfs_groups[4]                      =
                          =20
 -struct_attribute_group*             sysfs_rx_queue_group                 =
                          =20
 -struct_rtnl_link_ops*               rtnl_link_ops                        =
                          =20
 -unsigned_int                        gso_max_size            read_mostly  =
       -                   sk_dst_gso_max_size
 -unsigned_int                        tso_max_size                         =
                          =20
 -u16                                 gso_max_segs            read_mostly  =
       -                   gso_max_segs
 -u16                                 tso_max_segs                         =
                          =20
 -unsigned_int                        gso_ipv4_max_size       read_mostly  =
       -                   sk_dst_gso_max_size
 -struct_dcbnl_rtnl_ops*              dcbnl_ops                            =
                          =20
 -s16                                 num_tc                  read_mostly  =
       -                   skb_tx_hash
 -struct_netdev_tc_txq                tc_to_txq[16]           read_mostly  =
       -                   skb_tx_hash
 -u8                                  prio_tc_map[16]                      =
                          =20
 -unsigned_int                        fcoe_ddp_xid                         =
                          =20
 -struct_netprio_map*                 priomap                              =
                          =20
 -struct_phy_device*                  phydev                               =
                          =20
 -struct_sfp_bus*                     sfp_bus                              =
                          =20
 -struct_lock_class_key*              qdisc_tx_busylock                    =
                          =20
 -bool                                proto_down                           =
                          =20
 -unsigned:1                          wol_enabled                          =
                          =20
 -unsigned:1                          threaded                -            =
       -                   napi_poll(napi_enable,dev_set_threaded)
 -unsigned_long:1                     see_all_hwtstamp_requests            =
                          =20
 -unsigned_long:1                     change_proto_down                    =
                          =20
 -unsigned_long:1                     netns_local                          =
                          =20
 -unsigned_long:1                     fcoe_mtu                             =
                          =20
 -struct_list_head                    net_notifier_list                    =
                          =20
 -struct_macsec_ops*                  macsec_ops                           =
                          =20
 -struct_udp_tunnel_nic_info*         udp_tunnel_nic_info                  =
                          =20
 -struct_udp_tunnel_nic*              udp_tunnel_nic                       =
                          =20
 -unsigned_int                        xdp_zc_max_segs                      =
                          =20
 -struct_bpf_xdp_entity               xdp_state[3]                         =
                          =20
 -u8                                  dev_addr_shadow[32]                  =
                          =20
 -netdevice_tracker                   linkwatch_dev_tracker                =
                          =20
 -netdevice_tracker                   watchdog_dev_tracker                 =
                          =20
 -netdevice_tracker                   dev_registered_tracker               =
                          =20
 -struct_rtnl_hw_stats64*             offload_xstats_l3                    =
                          =20
 -struct_devlink_port*                devlink_port                         =
                          =20
 -struct_dpll_pin*                    dpll_pin                             =
                          =20
 +struct inet6_dev*                   ip6_ptr                     read_most=
ly         read_mostly         __in6_dev_get
 +struct vlan_info*                   vlan_info
 +struct dsa_port*                    dsa_ptr
 +struct tipc_bearer*                 tipc_ptr
 +void*                               atalk_ptr
 +void*                               ax25_ptr
 +struct wireless_dev*                ieee80211_ptr
 +struct wpan_dev*                    ieee802154_ptr
 +struct mpls_dev*                    mpls_ptr
 +struct mctp_dev*                    mctp_ptr
 +unsigned_char*                      dev_addr
 +struct netdev_queue*                _rx                         read_most=
ly                             netdev_get_rx_queue(rx)
 +unsigned_int                        num_rx_queues
 +unsigned_int                        real_num_rx_queues                   =
           read_mostly         get_rps_cpu
 +struct bpf_prog*                    xdp_prog                             =
           read_mostly         netif_elide_gro()
 +unsigned_long                       gro_flush_timeout                    =
           read_mostly         napi_complete_done
 +u32                                 napi_defer_hard_irqs                 =
           read_mostly         napi_complete_done
 +unsigned_int                        gro_max_size                         =
           read_mostly         skb_gro_receive
 +unsigned_int                        gro_ipv4_max_size                    =
           read_mostly         skb_gro_receive
 +rx_handler_func_t*                  rx_handler                  read_most=
ly                             __netif_receive_skb_core
 +void*                               rx_handler_data             read_most=
ly
 +struct netdev_queue*                ingress_queue               read_most=
ly
 +struct bpf_mprog_entry              tcx_ingress                          =
           read_mostly         sch_handle_ingress
 +struct nf_hook_entries*             nf_hooks_ingress
 +unsigned_char                       broadcast[32]
 +struct cpu_rmap*                    rx_cpu_rmap
 +struct hlist_node                   index_hlist
 +struct netdev_queue*                _tx                         read_most=
ly                             netdev_get_tx_queue(tx)
 +unsigned_int                        num_tx_queues
 +unsigned_int                        real_num_tx_queues          read_most=
ly                             skb_tx_hash,netdev_core_pick_tx(tx)
 +unsigned_int                        tx_queue_len
 +spinlock_t                          tx_global_lock
 +struct xdp_dev_bulk_queue__percpu*  xdp_bulkq
 +struct xps_dev_maps*                xps_maps[2]                 read_most=
ly                             __netif_set_xps_queue
 +struct bpf_mprog_entry              tcx_egress                  read_most=
ly                             sch_handle_egress
 +struct nf_hook_entries*             nf_hooks_egress             read_most=
ly
 +struct hlist_head                   qdisc_hash[16]
 +struct timer_list                   watchdog_timer
 +int                                 watchdog_timeo
 +u32                                 proto_down_reason
 +struct list_head                    todo_list
 +int__percpu*                        pcpu_refcnt
 +refcount_t                          dev_refcnt
 +struct ref_tracker_dir              refcnt_tracker
 +struct list_head                    link_watch_list
 +enum:8                              reg_state
 +bool                                dismantle
 +enum:16                             rtnl_link_state
 +bool                                needs_free_netdev
 +void*priv_destructor                struct net_device
 +struct netpoll_info*                npinfo                               =
           read_mostly         napi_poll/napi_poll_lock
 +possible_net_t                      nd_net                               =
           read_mostly         (dev_net)napi_busy_loop,tcp_v(4/6)_rcv,ip(v6=
)_rcv,ip(6)_input,ip(6)_input_finish
 +void*                               ml_priv
 +enum_netdev_ml_priv_type            ml_priv_type
 +struct pcpu_lstats__percpu*         lstats                      read_most=
ly                             dev_lstats_add()
 +struct pcpu_sw_netstats__percpu*    tstats                      read_most=
ly                             dev_sw_netstats_tx_add()
 +struct pcpu_dstats__percpu*         dstats
 +struct garp_port*                   garp_port
 +struct mrp_port*                    mrp_port
 +struct dm_hw_stat_delta*            dm_private
 +struct device                       dev
 +struct attribute_group*             sysfs_groups[4]
 +struct attribute_group*             sysfs_rx_queue_group
 +struct rtnl_link_ops*               rtnl_link_ops
 +unsigned_int                        gso_max_size                read_most=
ly                             sk_dst_gso_max_size
 +unsigned_int                        tso_max_size
 +u16                                 gso_max_segs                read_most=
ly                             gso_max_segs
 +u16                                 tso_max_segs
 +unsigned_int                        gso_ipv4_max_size           read_most=
ly                             sk_dst_gso_max_size
 +struct dcbnl_rtnl_ops*              dcbnl_ops
 +s16                                 num_tc                      read_most=
ly                             skb_tx_hash
 +struct netdev_tc_txq                tc_to_txq[16]               read_most=
ly                             skb_tx_hash
 +u8                                  prio_tc_map[16]
 +unsigned_int                        fcoe_ddp_xid
 +struct netprio_map*                 priomap
 +struct phy_device*                  phydev
 +struct sfp_bus*                     sfp_bus
 +struct lock_class_key*              qdisc_tx_busylock
 +bool                                proto_down
 +unsigned:1                          wol_enabled
 +unsigned:1                          threaded                             =
                               napi_poll(napi_enable,dev_set_threaded)
 +unsigned_long:1                     see_all_hwtstamp_requests
 +unsigned_long:1                     change_proto_down
 +unsigned_long:1                     netns_local
 +unsigned_long:1                     fcoe_mtu
 +struct list_head                    net_notifier_list
 +struct macsec_ops*                  macsec_ops
 +struct udp_tunnel_nic_info*         udp_tunnel_nic_info
 +struct udp_tunnel_nic*              udp_tunnel_nic
 +unsigned_int                        xdp_zc_max_segs
 +struct bpf_xdp_entity               xdp_state[3]
 +u8                                  dev_addr_shadow[32]
 +netdevice_tracker                   linkwatch_dev_tracker
 +netdevice_tracker                   watchdog_dev_tracker
 +netdevice_tracker                   dev_registered_tracker
 +struct rtnl_hw_stats64*             offload_xstats_l3
 +struct devlink_port*                devlink_port
 +struct dpll_pin*                    dpll_pin
  struct hlist_head                   page_pools
  struct dim_irq_moder*               irq_moder
  u64                                 max_pacing_offload_horizon

--Sig_/Lm7gjBlT0r9DPTO5PB94P4e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmcIevYACgkQAVBC80lX
0Gz2cAf/dbgbBDr+MOnZzk15n9R77f9VjjrDt9Sn9GVnROiSCAS1+uKeJiO6pzXc
PmCNXsP+BnWQVnnf68nKyFy3xwNOIbLCsb1/T6PZdY8F3sB3454qzxFm/Csd7pDn
y38tF83KLM5b1hZomJsjqCLxBROUKJp671mMnOaneX250of+hWKgxFUGTUBCktTR
yma/giL5+G7+rll0d9yEBTDp7H7XuH/4Yk84bM3O3+u05YTs+XUscM8X3AItQu+g
lZpGhaOx9w8dNdUlg+woFTcdL8sXEL5vbf4bDdds23pjlQsdM+BYSp5khhpyWn6i
RVrM0cnej6NwNQj289OBNDQ17QWguA==
=oyBK
-----END PGP SIGNATURE-----

--Sig_/Lm7gjBlT0r9DPTO5PB94P4e--

