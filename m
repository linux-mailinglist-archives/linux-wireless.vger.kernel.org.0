Return-Path: <linux-wireless+bounces-15328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA49CF19B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 17:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DFC1F28350
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038CA1D61BC;
	Fri, 15 Nov 2024 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILvJbSYI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66961D61A7;
	Fri, 15 Nov 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688575; cv=none; b=BGmCVvxRK4YVMRlfyjnQJ9J7gCHC191/S7DRQvxu5MaJ1vuosXrF70b2qDXVTYtx/NLCp+r1APXMSytKosSTIXYcx4P8MsW7bVr/SgaHbNUipCQNQUDIKaXjtSLwj0NuLUynANFBNZzc9ZWHiV15PYphFc9Xc4tSiuT63RndgQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688575; c=relaxed/simple;
	bh=xUIHtYaifBThsN2tXO7CMALCnvm3PjdxIklSZGg7dUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ik06WDhyHrUEVD9d5q0nLxFmVNzTy2gvZp06Pt6s3Tqjaa9cLyNRz29oSRWDWANDnSigSaHk7x+sKIHqcAg2DhS7p3DyR1jMBGGceQxQbJPkjL8N7c2enWxHfGm3PwIh4PXEzR0hNP8GePtmdhAw2Cq1tMIqvNPXdHx0QCFzs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILvJbSYI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7C0C4CECF;
	Fri, 15 Nov 2024 16:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688575;
	bh=xUIHtYaifBThsN2tXO7CMALCnvm3PjdxIklSZGg7dUM=;
	h=From:To:Cc:Subject:Date:From;
	b=ILvJbSYIgeP4/CmdwAbZ+wuTjkauWCQAaaeiKoCH8gLDDRZ3qOWspZm2c4WHVC07H
	 rSnihbeC86DTkJt2PLn79HMj3HAJdWtaFf2Iy+XO0SCmCpqKY2QddTtHV2I5K7CZSr
	 rAARW6aizPNkei+fcK03yizEIo1uJfr2kC5oKdkuPz3zmkfGdX5jSOkGS0miUztyFy
	 OBfwliQS3kiLqmH2pa+JZdgaZ6B6sNz2EmEGxX1TEcdW/jSs6AGnf+uBwt00ZgIoAP
	 uk0eLqFTXyrrfxOFbMYYK5HRTLgV047UtgcwP7yFD7pKC70xfvHp0jgMzbCxVpkx1P
	 Mjf897iAueCVg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	pablo@netfilter.org,
	linux@armlinux.org.uk,
	richardcochran@gmail.com,
	johannes@sipsolutions.net,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	dsahern@kernel.org,
	wintera@linux.ibm.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	netfilter-devel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH net-next] net: reformat kdoc return statements
Date: Fri, 15 Nov 2024 08:36:12 -0800
Message-ID: <20241115163612.904906-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-doc -Wall warns about missing Return: statement for non-void
functions. We have a number of kdocs in our headers which are missing
the colon, IOW they use
 * Return some value
or
 * Returns some value

Having the colon makes some sense, it should help kdoc parser avoid
false positives. So add them. This is mostly done with a sed script,
and removing the unnecessary cases (mostly the comments which aren't
kdoc).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
LMK if I should have split this into smaller chunks, I don't really
expect much review here, TBH.
---
CC: pablo@netfilter.org
CC: linux@armlinux.org.uk
CC: richardcochran@gmail.com
CC: johannes@sipsolutions.net
CC: loic.poulain@linaro.org
CC: ryazanov.s.a@gmail.com
CC: dsahern@kernel.org
CC: wintera@linux.ibm.com
CC: hawk@kernel.org
CC: ilias.apalodimas@linaro.org
CC: jhs@mojatatu.com
CC: jiri@resnulli.us
CC: ecree.xilinx@gmail.com
CC: przemyslaw.kitszel@intel.com
CC: netfilter-devel@vger.kernel.org
CC: linux-wireless@vger.kernel.org
---
 include/linux/etherdevice.h        | 18 ++++++------
 include/linux/ethtool.h            |  6 ++--
 include/linux/if_vlan.h            | 28 +++++++++----------
 include/linux/netdevice.h          | 14 +++++-----
 include/linux/netfilter/x_tables.h |  2 +-
 include/linux/netfilter_netdev.h   |  3 +-
 include/linux/phylink.h            | 12 ++++----
 include/linux/ptp_clock_kernel.h   |  4 +--
 include/linux/rfkill.h             |  2 +-
 include/linux/rtnetlink.h          |  2 +-
 include/linux/skbuff.h             | 16 +++++------
 include/linux/wwan.h               |  2 +-
 include/net/cfg80211.h             |  2 +-
 include/net/dst.h                  |  2 +-
 include/net/genetlink.h            |  6 ++--
 include/net/ipv6.h                 |  2 +-
 include/net/iucv/iucv.h            | 30 ++++++++++----------
 include/net/mac80211.h             |  2 +-
 include/net/netfilter/nf_tproxy.h  |  4 +--
 include/net/netlink.h              | 44 +++++++++++++++---------------
 include/net/page_pool/helpers.h    |  6 ++--
 include/net/pkt_cls.h              |  4 +--
 include/net/tcp.h                  |  2 +-
 23 files changed, 107 insertions(+), 106 deletions(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index ecf203f01034..9a1eacf35d37 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -81,7 +81,7 @@ static const u8 eth_ipv6_mcast_addr_base[ETH_ALEN] __aligned(2) =
  * is_link_local_ether_addr - Determine if given Ethernet address is link-local
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *
- * Return true if address is link local reserved addr (01:80:c2:00:00:0X) per
+ * Return: true if address is link local reserved addr (01:80:c2:00:00:0X) per
  * IEEE 802.1Q 8.6.3 Frame filtering.
  *
  * Please note: addr must be aligned to u16.
@@ -104,7 +104,7 @@ static inline bool is_link_local_ether_addr(const u8 *addr)
  * is_zero_ether_addr - Determine if give Ethernet address is all zeros.
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *
- * Return true if the address is all zeroes.
+ * Return: true if the address is all zeroes.
  *
  * Please note: addr must be aligned to u16.
  */
@@ -123,7 +123,7 @@ static inline bool is_zero_ether_addr(const u8 *addr)
  * is_multicast_ether_addr - Determine if the Ethernet address is a multicast.
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *
- * Return true if the address is a multicast address.
+ * Return: true if the address is a multicast address.
  * By definition the broadcast address is also a multicast address.
  */
 static inline bool is_multicast_ether_addr(const u8 *addr)
@@ -157,7 +157,7 @@ static inline bool is_multicast_ether_addr_64bits(const u8 *addr)
  * is_local_ether_addr - Determine if the Ethernet address is locally-assigned one (IEEE 802).
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *
- * Return true if the address is a local address.
+ * Return: true if the address is a local address.
  */
 static inline bool is_local_ether_addr(const u8 *addr)
 {
@@ -168,7 +168,7 @@ static inline bool is_local_ether_addr(const u8 *addr)
  * is_broadcast_ether_addr - Determine if the Ethernet address is broadcast
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *
- * Return true if the address is the broadcast address.
+ * Return: true if the address is the broadcast address.
  *
  * Please note: addr must be aligned to u16.
  */
@@ -183,7 +183,7 @@ static inline bool is_broadcast_ether_addr(const u8 *addr)
  * is_unicast_ether_addr - Determine if the Ethernet address is unicast
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *
- * Return true if the address is a unicast address.
+ * Return: true if the address is a unicast address.
  */
 static inline bool is_unicast_ether_addr(const u8 *addr)
 {
@@ -197,7 +197,7 @@ static inline bool is_unicast_ether_addr(const u8 *addr)
  * Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
  * a multicast address, and is not FF:FF:FF:FF:FF:FF.
  *
- * Return true if the address is valid.
+ * Return: true if the address is valid.
  *
  * Please note: addr must be aligned to u16.
  */
@@ -214,7 +214,7 @@ static inline bool is_valid_ether_addr(const u8 *addr)
  *
  * Check that the value from the Ethertype/length field is a valid Ethertype.
  *
- * Return true if the valid is an 802.3 supported Ethertype.
+ * Return: true if the valid is an 802.3 supported Ethertype.
  */
 static inline bool eth_proto_is_802_3(__be16 proto)
 {
@@ -458,7 +458,7 @@ static inline bool ether_addr_is_ip_mcast(const u8 *addr)
  * ether_addr_to_u64 - Convert an Ethernet address into a u64 value.
  * @addr: Pointer to a six-byte array containing the Ethernet address
  *
- * Return a u64 value of the address
+ * Return: a u64 value of the address
  */
 static inline u64 ether_addr_to_u64(const u8 *addr)
 {
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 1199e308c8dd..c6acd93f5578 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -257,7 +257,7 @@ struct ethtool_link_ksettings {
  *   @mode : one of the ETHTOOL_LINK_MODE_*_BIT
  * (not atomic, no bound checking)
  *
- * Returns true/false.
+ * Returns: true/false.
  */
 #define ethtool_link_ksettings_test_link_mode(ptr, name, mode)		\
 	test_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
@@ -1195,7 +1195,7 @@ ethtool_params_from_link_mode(struct ethtool_link_ksettings *link_ksettings,
  * @dev: pointer to net_device structure
  * @vclock_index: pointer to pointer of vclock index
  *
- * Return number of phc vclocks
+ * Return: number of phc vclocks
  */
 int ethtool_get_phc_vclocks(struct net_device *dev, int **vclock_index);
 
@@ -1249,7 +1249,7 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
  * ethtool_get_ts_info_by_layer - Obtains time stamping capabilities from the MAC or PHY layer.
  * @dev: pointer to net_device structure
  * @info: buffer to hold the result
- * Returns zero on success, non-zero otherwise.
+ * Returns: zero on success, non-zero otherwise.
  */
 int ethtool_get_ts_info_by_layer(struct net_device *dev,
 				 struct kernel_ethtool_ts_info *info);
diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
index c1645c86eed9..d6326b53e336 100644
--- a/include/linux/if_vlan.h
+++ b/include/linux/if_vlan.h
@@ -310,7 +310,7 @@ static inline bool vlan_uses_dev(const struct net_device *dev)
  * eth_type_vlan - check for valid vlan ether type.
  * @ethertype: ether type to check
  *
- * Returns true if the ether type is a vlan ether type.
+ * Returns: true if the ether type is a vlan ether type.
  */
 static inline bool eth_type_vlan(__be16 ethertype)
 {
@@ -341,9 +341,9 @@ static inline bool vlan_hw_offload_capable(netdev_features_t features,
  * @mac_len: MAC header length including outer vlan headers
  *
  * Inserts the VLAN tag into @skb as part of the payload at offset mac_len
- * Returns error if skb_cow_head fails.
- *
  * Does not change skb->protocol so this function can be used during receive.
+ *
+ * Returns: error if skb_cow_head fails.
  */
 static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
 					  __be16 vlan_proto, u16 vlan_tci,
@@ -390,9 +390,9 @@ static inline int __vlan_insert_inner_tag(struct sk_buff *skb,
  * @vlan_tci: VLAN TCI to insert
  *
  * Inserts the VLAN tag into @skb as part of the payload
- * Returns error if skb_cow_head fails.
- *
  * Does not change skb->protocol so this function can be used during receive.
+ *
+ * Returns: error if skb_cow_head fails.
  */
 static inline int __vlan_insert_tag(struct sk_buff *skb,
 				    __be16 vlan_proto, u16 vlan_tci)
@@ -533,7 +533,7 @@ static inline void __vlan_hwaccel_put_tag(struct sk_buff *skb,
  * @skb: skbuff to query
  * @vlan_tci: buffer to store value
  *
- * Returns error if the skb is not of VLAN type
+ * Returns: error if the skb is not of VLAN type
  */
 static inline int __vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 {
@@ -551,7 +551,7 @@ static inline int __vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
  * @skb: skbuff to query
  * @vlan_tci: buffer to store value
  *
- * Returns error if @skb->vlan_tci is not set correctly
+ * Returns: error if @skb->vlan_tci is not set correctly
  */
 static inline int __vlan_hwaccel_get_tag(const struct sk_buff *skb,
 					 u16 *vlan_tci)
@@ -570,7 +570,7 @@ static inline int __vlan_hwaccel_get_tag(const struct sk_buff *skb,
  * @skb: skbuff to query
  * @vlan_tci: buffer to store value
  *
- * Returns error if the skb is not VLAN tagged
+ * Returns: error if the skb is not VLAN tagged
  */
 static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
 {
@@ -587,7 +587,7 @@ static inline int vlan_get_tag(const struct sk_buff *skb, u16 *vlan_tci)
  * @type: first vlan protocol
  * @depth: buffer to store length of eth and vlan tags in bytes
  *
- * Returns the EtherType of the packet, regardless of whether it is
+ * Returns: the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
 static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
@@ -629,7 +629,7 @@ static inline __be16 __vlan_get_protocol(const struct sk_buff *skb, __be16 type,
  * vlan_get_protocol - get protocol EtherType.
  * @skb: skbuff to query
  *
- * Returns the EtherType of the packet, regardless of whether it is
+ * Returns: the EtherType of the packet, regardless of whether it is
  * vlan encapsulated (normal or hardware accelerated) or not.
  */
 static inline __be16 vlan_get_protocol(const struct sk_buff *skb)
@@ -710,7 +710,7 @@ static inline void vlan_set_encap_proto(struct sk_buff *skb,
  * Expects the skb to contain a VLAN tag in the payload, and to have skb->data
  * pointing at the MAC header.
  *
- * Returns a new pointer to skb->data, or NULL on failure to pull.
+ * Returns: a new pointer to skb->data, or NULL on failure to pull.
  */
 static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
 {
@@ -727,7 +727,7 @@ static inline void *vlan_remove_tag(struct sk_buff *skb, u16 *vlan_tci)
  * skb_vlan_tagged - check if skb is vlan tagged.
  * @skb: skbuff to query
  *
- * Returns true if the skb is tagged, regardless of whether it is hardware
+ * Returns: true if the skb is tagged, regardless of whether it is hardware
  * accelerated or not.
  */
 static inline bool skb_vlan_tagged(const struct sk_buff *skb)
@@ -743,7 +743,7 @@ static inline bool skb_vlan_tagged(const struct sk_buff *skb)
  * skb_vlan_tagged_multi - check if skb is vlan tagged with multiple headers.
  * @skb: skbuff to query
  *
- * Returns true if the skb is tagged with multiple vlan headers, regardless
+ * Returns: true if the skb is tagged with multiple vlan headers, regardless
  * of whether it is hardware accelerated or not.
  */
 static inline bool skb_vlan_tagged_multi(struct sk_buff *skb)
@@ -774,7 +774,7 @@ static inline bool skb_vlan_tagged_multi(struct sk_buff *skb)
  * @skb: skbuff to query
  * @features: features to be checked
  *
- * Returns features without unsafe ones if the skb has multiple tags.
+ * Returns: features without unsafe ones if the skb has multiple tags.
  */
 static inline netdev_features_t vlan_features_check(struct sk_buff *skb,
 						    netdev_features_t features)
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0aae346d919e..ed549a2e02b2 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -509,7 +509,7 @@ static inline bool napi_prefer_busy_poll(struct napi_struct *n)
  * is scheduled for example in the context of delayed timer
  * that can be skipped if a NAPI is already scheduled.
  *
- * Return True if NAPI is scheduled, False otherwise.
+ * Return: True if NAPI is scheduled, False otherwise.
  */
 static inline bool napi_is_scheduled(struct napi_struct *n)
 {
@@ -524,7 +524,7 @@ bool napi_schedule_prep(struct napi_struct *n);
  *
  * Schedule NAPI poll routine to be called if it is not already
  * running.
- * Return true if we schedule a NAPI or false if not.
+ * Return: true if we schedule a NAPI or false if not.
  * Refer to napi_schedule_prep() for additional reason on why
  * a NAPI might not be scheduled.
  */
@@ -558,7 +558,7 @@ static inline void napi_schedule_irqoff(struct napi_struct *n)
  * Mark NAPI processing as complete. Should only be called if poll budget
  * has not been completely consumed.
  * Prefer over napi_complete().
- * Return false if device should avoid rearming interrupts.
+ * Return: false if device should avoid rearming interrupts.
  */
 bool napi_complete_done(struct napi_struct *n, int work_done);
 
@@ -3548,7 +3548,7 @@ static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
  * that they should not test BQL status themselves.
  * We do want to change __QUEUE_STATE_STACK_XOFF only for the last
  * skb of a batch.
- * Returns true if the doorbell must be used to kick the NIC.
+ * Return true if the doorbell must be used to kick the NIC.
  */
 static inline bool __netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 					  unsigned int bytes,
@@ -3802,7 +3802,7 @@ static inline bool netif_attr_test_mask(unsigned long j,
  *	@online_mask: bitmask for CPUs/Rx queues that are online
  *	@nr_bits: number of bits in the bitmask
  *
- * Returns true if a CPU/Rx queue is online.
+ * Returns: true if a CPU/Rx queue is online.
  */
 static inline bool netif_attr_test_online(unsigned long j,
 					  const unsigned long *online_mask,
@@ -3822,7 +3822,7 @@ static inline bool netif_attr_test_online(unsigned long j,
  *	@srcp: the cpumask/Rx queue mask pointer
  *	@nr_bits: number of bits in the bitmask
  *
- * Returns >= nr_bits if no further CPUs/Rx queues set.
+ * Returns: >= nr_bits if no further CPUs/Rx queues set.
  */
 static inline unsigned int netif_attrmask_next(int n, const unsigned long *srcp,
 					       unsigned int nr_bits)
@@ -3844,7 +3844,7 @@ static inline unsigned int netif_attrmask_next(int n, const unsigned long *srcp,
  *	@src2p: the second CPUs/Rx queues mask pointer
  *	@nr_bits: number of bits in the bitmask
  *
- * Returns >= nr_bits if no further CPUs/Rx queues set in both.
+ * Returns: >= nr_bits if no further CPUs/Rx queues set in both.
  */
 static inline int netif_attrmask_next_and(int n, const unsigned long *src1p,
 					  const unsigned long *src2p,
diff --git a/include/linux/netfilter/x_tables.h b/include/linux/netfilter/x_tables.h
index 5897f3dbaf7c..f39f688d7285 100644
--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -357,7 +357,7 @@ extern struct static_key xt_tee_enabled;
  * Begin packet processing : all readers must wait the end
  * 1) Must be called with preemption disabled
  * 2) softirqs must be disabled too (or we should use this_cpu_add())
- * Returns :
+ * Returns:
  *  1 if no recursion on this cpu
  *  0 if recursion detected
  */
diff --git a/include/linux/netfilter_netdev.h b/include/linux/netfilter_netdev.h
index 8676316547cc..3175073a66ba 100644
--- a/include/linux/netfilter_netdev.h
+++ b/include/linux/netfilter_netdev.h
@@ -66,7 +66,6 @@ static inline bool nf_hook_egress_active(void)
  * @rc: result code which shall be returned by __dev_queue_xmit() on failure
  * @dev: netdev whose egress hooks shall be applied to @skb
  *
- * Returns @skb on success or %NULL if the packet was consumed or filtered.
  * Caller must hold rcu_read_lock.
  *
  * On ingress, packets are classified first by tc, then by netfilter.
@@ -81,6 +80,8 @@ static inline bool nf_hook_egress_active(void)
  * called recursively by tunnel drivers such as vxlan, the flag is reverted to
  * false after sch_handle_egress().  This ensures that netfilter is applied
  * both on the overlay and underlying network.
+ *
+ * Returns: @skb on success or %NULL if the packet was consumed or filtered.
  */
 static inline struct sk_buff *nf_hook_egress(struct sk_buff *skb, int *rc,
 					     struct net_device *dev)
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 5c01048860c4..fe0d005cd5d8 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -213,7 +213,7 @@ unsigned long mac_get_caps(struct phylink_config *config,
  * @config: a pointer to a &struct phylink_config.
  * @interface: PHY interface mode for PCS
  *
- * Return the &struct phylink_pcs for the specified interface mode, or
+ * Return: the &struct phylink_pcs for the specified interface mode, or
  * NULL if none is required, or an error pointer on error.
  *
  * This must not modify any state. It is used to query which PCS should
@@ -243,7 +243,7 @@ struct phylink_pcs *mac_select_pcs(struct phylink_config *config,
  * - possible pcs_an_restart()
  * - mac_finish()
  *
- * Returns zero on success, or negative errno on failure which will be
+ * Returns: zero on success, or negative errno on failure which will be
  * reported to the kernel log.
  */
 int mac_prepare(struct phylink_config *config, unsigned int mode,
@@ -336,7 +336,7 @@ void mac_config(struct phylink_config *config, unsigned int mode,
  * for the @mode and @iface. E.g. a MAC driver may wish to re-enable the
  * Serdes PHY here if it was previously disabled by mac_prepare().
  *
- * Returns zero on success, or negative errno on failure which will be
+ * Returns: zero on success, or negative errno on failure which will be
  * reported to the kernel log.
  */
 int mac_finish(struct phylink_config *config, unsigned int mode,
@@ -464,8 +464,8 @@ struct phylink_pcs_ops {
  * mask. Phylink will propagate the changes to the advertising mask. See the
  * &struct phylink_mac_ops validate() method.
  *
- * Returns -EINVAL if the interface mode/autoneg mode is not supported.
- * Returns non-zero positive if the link state can be supported.
+ * Returns: -EINVAL if the interface mode/autoneg mode is not supported.
+ * Returns: non-zero positive if the link state can be supported.
  */
 int pcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 		 const struct phylink_link_state *state);
@@ -647,7 +647,7 @@ void phylink_set_port_modes(unsigned long *bits);
  * phylink_get_link_timer_ns - return the PCS link timer value
  * @interface: link &typedef phy_interface_t mode
  *
- * Return the PCS link timer setting in nanoseconds for the PHY @interface
+ * Return: the PCS link timer setting in nanoseconds for the PHY @interface
  * mode, or -EINVAL if not appropriate.
  */
 static inline int phylink_get_link_timer_ns(phy_interface_t interface)
diff --git a/include/linux/ptp_clock_kernel.h b/include/linux/ptp_clock_kernel.h
index c892d22ce0a7..0d68d09bedd1 100644
--- a/include/linux/ptp_clock_kernel.h
+++ b/include/linux/ptp_clock_kernel.h
@@ -307,7 +307,7 @@ static inline u64 adjust_by_scaled_ppm(u64 base, long scaled_ppm)
  * @info:   Structure describing the new clock.
  * @parent: Pointer to the parent device of the new clock.
  *
- * Returns a valid pointer on success or PTR_ERR on failure.  If PHC
+ * Returns: a valid pointer on success or PTR_ERR on failure.  If PHC
  * support is missing at the configuration level, this function
  * returns NULL, and drivers are expected to gracefully handle that
  * case separately.
@@ -445,7 +445,7 @@ int ptp_get_vclocks_index(int pclock_index, int **vclock_index);
  * @hwtstamp:     timestamp
  * @vclock_index: phc index of ptp vclock.
  *
- * Returns converted timestamp, or 0 on error.
+ * Returns: converted timestamp, or 0 on error.
  */
 ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp, int vclock_index);
 #else
diff --git a/include/linux/rfkill.h b/include/linux/rfkill.h
index 997b34197385..6816e4c5f3f0 100644
--- a/include/linux/rfkill.h
+++ b/include/linux/rfkill.h
@@ -241,7 +241,7 @@ bool rfkill_soft_blocked(struct rfkill *rfkill);
  * rfkill_find_type - Helper for finding rfkill type by name
  * @name: the name of the type
  *
- * Returns enum rfkill_type that corresponds to the name.
+ * Returns: enum rfkill_type that corresponds to the name.
  */
 enum rfkill_type rfkill_find_type(const char *name);
 
diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 14b88f551920..811ce44113f6 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -78,7 +78,7 @@ static inline bool lockdep_rtnl_is_held(void)
  * rtnl_dereference - fetch RCU pointer when updates are prevented by RTNL
  * @p: The pointer to read, prior to dereferencing
  *
- * Return the value of the specified RCU-protected pointer, but omit
+ * Return: the value of the specified RCU-protected pointer, but omit
  * the READ_ONCE(), because caller holds RTNL.
  */
 #define rtnl_dereference(p)					\
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 58009fa66102..22260b34ea78 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1134,7 +1134,7 @@ static inline bool skb_pfmemalloc(const struct sk_buff *skb)
  * skb_dst - returns skb dst_entry
  * @skb: buffer
  *
- * Returns skb dst_entry, regardless of reference taken or not.
+ * Returns: skb dst_entry, regardless of reference taken or not.
  */
 static inline struct dst_entry *skb_dst(const struct sk_buff *skb)
 {
@@ -1222,7 +1222,7 @@ static inline bool skb_wifi_acked_valid(const struct sk_buff *skb)
  * skb_unref - decrement the skb's reference count
  * @skb: buffer
  *
- * Returns true if we can free the skb.
+ * Returns: true if we can free the skb.
  */
 static inline bool skb_unref(struct sk_buff *skb)
 {
@@ -1344,7 +1344,7 @@ struct sk_buff_fclones {
  *	@sk: socket
  *	@skb: buffer
  *
- * Returns true if skb is a fast clone, and its clone is not freed.
+ * Returns: true if skb is a fast clone, and its clone is not freed.
  * Some drivers call skb_orphan() in their ndo_start_xmit(),
  * so we also check that didn't happen.
  */
@@ -3516,7 +3516,7 @@ static inline struct page *__dev_alloc_page_noprof(gfp_t gfp_mask)
  * A page shouldn't be considered for reusing/recycling if it was allocated
  * under memory pressure or at a distant memory node.
  *
- * Returns false if this page should be returned to page allocator, true
+ * Returns: false if this page should be returned to page allocator, true
  * otherwise.
  */
 static inline bool dev_page_is_reusable(const struct page *page)
@@ -3633,7 +3633,7 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
  * skb_frag_address - gets the address of the data contained in a paged fragment
  * @frag: the paged fragment buffer
  *
- * Returns the address of the data within @frag. The page must already
+ * Returns: the address of the data within @frag. The page must already
  * be mapped.
  */
 static inline void *skb_frag_address(const skb_frag_t *frag)
@@ -3648,7 +3648,7 @@ static inline void *skb_frag_address(const skb_frag_t *frag)
  * skb_frag_address_safe - gets the address of the data contained in a paged fragment
  * @frag: the paged fragment buffer
  *
- * Returns the address of the data within @frag. Checks that the page
+ * Returns: the address of the data within @frag. Checks that the page
  * is mapped and returns %NULL otherwise.
  */
 static inline void *skb_frag_address_safe(const skb_frag_t *frag)
@@ -3890,7 +3890,7 @@ static inline int skb_linearize(struct sk_buff *skb)
  * skb_has_shared_frag - can any frag be overwritten
  * @skb: buffer to test
  *
- * Return true if the skb has at least one frag that might be modified
+ * Return: true if the skb has at least one frag that might be modified
  * by an external entity (as in vmsplice()/sendfile())
  */
 static inline bool skb_has_shared_frag(const struct sk_buff *skb)
@@ -4612,7 +4612,7 @@ static inline void __skb_reset_checksum_unnecessary(struct sk_buff *skb)
 
 /* Check if we need to perform checksum complete validation.
  *
- * Returns true if checksum complete is needed, false otherwise
+ * Returns: true if checksum complete is needed, false otherwise
  * (either checksum is unnecessary or zero checksum is allowed).
  */
 static inline bool __skb_checksum_validate_needed(struct sk_buff *skb,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 79c781875c09..a4d6cc0c9f68 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -97,7 +97,7 @@ struct wwan_port_caps {
  *
  * This function must be balanced with a call to wwan_remove_port().
  *
- * Returns a valid pointer to wwan_port on success or PTR_ERR on failure
+ * Returns: a valid pointer to wwan_port on success or PTR_ERR on failure
  */
 struct wwan_port *wwan_create_port(struct device *parent,
 				   enum wwan_port_type type,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 27acf1292a5c..182f7965048f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5957,7 +5957,7 @@ int wiphy_register(struct wiphy *wiphy);
  * @wiphy: the wiphy to check the locking on
  * @p: The pointer to read, prior to dereferencing
  *
- * Return the value of the specified RCU-protected pointer, but omit the
+ * Return: the value of the specified RCU-protected pointer, but omit the
  * READ_ONCE(), because caller holds the wiphy mutex used for updates.
  */
 #define wiphy_dereference(wiphy, p)				\
diff --git a/include/net/dst.h b/include/net/dst.h
index 0f303cc60252..b01003ca7206 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -307,7 +307,7 @@ static inline bool dst_hold_safe(struct dst_entry *dst)
  * @skb: buffer
  *
  * If dst is not yet refcounted and not destroyed, grab a ref on it.
- * Returns true if dst is refcounted.
+ * Returns: true if dst is refcounted.
  */
 static inline bool skb_dst_force(struct sk_buff *skb)
 {
diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index d096cc6352de..a03d56765832 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -354,7 +354,7 @@ __genlmsg_iput(struct sk_buff *skb, const struct genl_info *info, int flags)
  * such requests) or a struct initialized by genl_info_init_ntf()
  * when constructing notifications.
  *
- * Returns pointer to new genetlink header.
+ * Returns: pointer to new genetlink header.
  */
 static inline void *
 genlmsg_iput(struct sk_buff *skb, const struct genl_info *info)
@@ -366,7 +366,7 @@ genlmsg_iput(struct sk_buff *skb, const struct genl_info *info)
  * genlmsg_nlhdr - Obtain netlink header from user specified header
  * @user_hdr: user header as returned from genlmsg_put()
  *
- * Returns pointer to netlink header.
+ * Returns: pointer to netlink header.
  */
 static inline struct nlmsghdr *genlmsg_nlhdr(void *user_hdr)
 {
@@ -435,7 +435,7 @@ static inline void genl_dump_check_consistent(struct netlink_callback *cb,
  * @flags: netlink message flags
  * @cmd: generic netlink command
  *
- * Returns pointer to user specific header
+ * Returns: pointer to user specific header
  */
 static inline void *genlmsg_put_reply(struct sk_buff *skb,
 				      struct genl_info *info,
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 248bfb26e2af..f5c43ad1565e 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -471,7 +471,7 @@ struct ipv6_txoptions *ipv6_update_options(struct sock *sk,
 /* This helper is specialized for BIG TCP needs.
  * It assumes the hop_jumbo_hdr will immediately follow the IPV6 header.
  * It assumes headers are already in skb->head.
- * Returns 0, or IPPROTO_TCP if a BIG TCP packet is there.
+ * Returns: 0, or IPPROTO_TCP if a BIG TCP packet is there.
  */
 static inline int ipv6_has_hopopt_jumbo(const struct sk_buff *skb)
 {
diff --git a/include/net/iucv/iucv.h b/include/net/iucv/iucv.h
index dd9e93c12260..9804fa5d9c67 100644
--- a/include/net/iucv/iucv.h
+++ b/include/net/iucv/iucv.h
@@ -202,7 +202,7 @@ struct iucv_handler {
  *
  * Registers a driver with IUCV.
  *
- * Returns 0 on success, -ENOMEM if the memory allocation for the pathid
+ * Returns: 0 on success, -ENOMEM if the memory allocation for the pathid
  * table failed, or -EIO if IUCV_DECLARE_BUFFER failed on all cpus.
  */
 int iucv_register(struct iucv_handler *handler, int smp);
@@ -224,7 +224,7 @@ void iucv_unregister(struct iucv_handler *handle, int smp);
  *
  * Allocate a new path structure for use with iucv_connect.
  *
- * Returns NULL if the memory allocation failed or a pointer to the
+ * Returns: NULL if the memory allocation failed or a pointer to the
  * path structure.
  */
 static inline struct iucv_path *iucv_path_alloc(u16 msglim, u8 flags, gfp_t gfp)
@@ -260,7 +260,7 @@ static inline void iucv_path_free(struct iucv_path *path)
  * This function is issued after the user received a connection pending
  * external interrupt and now wishes to complete the IUCV communication path.
  *
- * Returns the result of the CP IUCV call.
+ * Returns: the result of the CP IUCV call.
  */
 int iucv_path_accept(struct iucv_path *path, struct iucv_handler *handler,
 		     u8 *userdata, void *private);
@@ -278,7 +278,7 @@ int iucv_path_accept(struct iucv_path *path, struct iucv_handler *handler,
  * successfully, you are not able to use the path until you receive an IUCV
  * Connection Complete external interrupt.
  *
- * Returns the result of the CP IUCV call.
+ * Returns: the result of the CP IUCV call.
  */
 int iucv_path_connect(struct iucv_path *path, struct iucv_handler *handler,
 		      u8 *userid, u8 *system, u8 *userdata,
@@ -292,7 +292,7 @@ int iucv_path_connect(struct iucv_path *path, struct iucv_handler *handler,
  * This function temporarily suspends incoming messages on an IUCV path.
  * You can later reactivate the path by invoking the iucv_resume function.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_path_quiesce(struct iucv_path *path, u8 *userdata);
 
@@ -304,7 +304,7 @@ int iucv_path_quiesce(struct iucv_path *path, u8 *userdata);
  * This function resumes incoming messages on an IUCV path that has
  * been stopped with iucv_path_quiesce.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_path_resume(struct iucv_path *path, u8 *userdata);
 
@@ -315,7 +315,7 @@ int iucv_path_resume(struct iucv_path *path, u8 *userdata);
  *
  * This function terminates an IUCV path.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_path_sever(struct iucv_path *path, u8 *userdata);
 
@@ -327,7 +327,7 @@ int iucv_path_sever(struct iucv_path *path, u8 *userdata);
  *
  * Cancels a message you have sent.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_purge(struct iucv_path *path, struct iucv_message *msg,
 		       u32 srccls);
@@ -347,7 +347,7 @@ int iucv_message_purge(struct iucv_path *path, struct iucv_message *msg,
  *
  * Locking:	local_bh_enable/local_bh_disable
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 			 u8 flags, void *buffer, size_t size, size_t *residual);
@@ -367,7 +367,7 @@ int iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
  *
  * Locking:	no locking.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
 			   u8 flags, void *buffer, size_t size,
@@ -382,7 +382,7 @@ int __iucv_message_receive(struct iucv_path *path, struct iucv_message *msg,
  * are notified of a message and the time that you complete the message,
  * the message may be rejected.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg);
 
@@ -399,7 +399,7 @@ int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg);
  * pathid, msgid, and trgcls. Prmmsg signifies the data is moved into
  * the parameter list.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_reply(struct iucv_path *path, struct iucv_message *msg,
 		       u8 flags, void *reply, size_t size);
@@ -419,7 +419,7 @@ int iucv_message_reply(struct iucv_path *path, struct iucv_message *msg,
  *
  * Locking:	local_bh_enable/local_bh_disable
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 		      u8 flags, u32 srccls, void *buffer, size_t size);
@@ -439,7 +439,7 @@ int iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
  *
  * Locking:	no locking.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int __iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
 			u8 flags, u32 srccls, void *buffer, size_t size);
@@ -461,7 +461,7 @@ int __iucv_message_send(struct iucv_path *path, struct iucv_message *msg,
  * reply to the message and a buffer is provided into which IUCV moves
  * the reply to this message.
  *
- * Returns the result from the CP IUCV call.
+ * Returns: the result from the CP IUCV call.
  */
 int iucv_message_send2way(struct iucv_path *path, struct iucv_message *msg,
 			  u8 flags, u32 srccls, void *buffer, size_t size,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a97c9f85ae9a..cc0f96056960 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7497,7 +7497,7 @@ ieee80211_return_txq(struct ieee80211_hw *hw, struct ieee80211_txq *txq,
  * fairness accounting without using the scheduling order enforced by
  * next_txq().
  *
- * Returns %true if the airtime scheduler thinks the TXQ should be allowed to
+ * Returns: %true if the airtime scheduler thinks the TXQ should be allowed to
  * transmit, and %false if it should be throttled. This function can also have
  * the side effect of rotating the TXQ in the scheduler rotation, which will
  * eventually bring the deficit to positive and allow the station to transmit
diff --git a/include/net/netfilter/nf_tproxy.h b/include/net/netfilter/nf_tproxy.h
index 5adf6fda11e8..06985530517b 100644
--- a/include/net/netfilter/nf_tproxy.h
+++ b/include/net/netfilter/nf_tproxy.h
@@ -49,7 +49,7 @@ __be32 nf_tproxy_laddr4(struct sk_buff *skb, __be32 user_laddr, __be32 daddr);
  *
  * nf_tproxy_handle_time_wait4() consumes the socket reference passed in.
  *
- * Returns the listener socket if there's one, the TIME_WAIT socket if
+ * Returns: the listener socket if there's one, the TIME_WAIT socket if
  * no such listener is found, or NULL if the TCP header is incomplete.
  */
 struct sock *
@@ -108,7 +108,7 @@ nf_tproxy_laddr6(struct sk_buff *skb, const struct in6_addr *user_laddr,
  *
  * nf_tproxy_handle_time_wait6() consumes the socket reference passed in.
  *
- * Returns the listener socket if there's one, the TIME_WAIT socket if
+ * Returns: the listener socket if there's one, the TIME_WAIT socket if
  * no such listener is found, or NULL if the TCP header is incomplete.
  */
 struct sock *
diff --git a/include/net/netlink.h b/include/net/netlink.h
index 39eaa6be6ca8..e015ffbed819 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -649,7 +649,7 @@ static inline int nlmsg_ok(const struct nlmsghdr *nlh, int remaining)
  * @nlh: netlink message header
  * @remaining: number of bytes remaining in message stream
  *
- * Returns the next netlink message in the message stream and
+ * Returns: the next netlink message in the message stream and
  * decrements remaining by the size of the current message.
  */
 static inline struct nlmsghdr *
@@ -676,7 +676,7 @@ nlmsg_next(const struct nlmsghdr *nlh, int *remaining)
  * exceeding maxtype will be rejected, policy must be specified, attributes
  * will be validated in the strictest way possible.
  *
- * Returns 0 on success or a negative error code.
+ * Returns: 0 on success or a negative error code.
  */
 static inline int nla_parse(struct nlattr **tb, int maxtype,
 			    const struct nlattr *head, int len,
@@ -701,7 +701,7 @@ static inline int nla_parse(struct nlattr **tb, int maxtype,
  * exceeding maxtype will be ignored and attributes from the policy are not
  * always strictly validated (only for new attributes).
  *
- * Returns 0 on success or a negative error code.
+ * Returns: 0 on success or a negative error code.
  */
 static inline int nla_parse_deprecated(struct nlattr **tb, int maxtype,
 				       const struct nlattr *head, int len,
@@ -726,7 +726,7 @@ static inline int nla_parse_deprecated(struct nlattr **tb, int maxtype,
  * exceeding maxtype will be rejected as well as trailing data, but the
  * policy is not completely strictly validated (only for new attributes).
  *
- * Returns 0 on success or a negative error code.
+ * Returns: 0 on success or a negative error code.
  */
 static inline int nla_parse_deprecated_strict(struct nlattr **tb, int maxtype,
 					      const struct nlattr *head,
@@ -833,7 +833,7 @@ nlmsg_parse_deprecated_strict(const struct nlmsghdr *nlh, int hdrlen,
  * @hdrlen: length of family specific header
  * @attrtype: type of attribute to look for
  *
- * Returns the first attribute which matches the specified type.
+ * Returns: the first attribute which matches the specified type.
  */
 static inline struct nlattr *nlmsg_find_attr(const struct nlmsghdr *nlh,
 					     int hdrlen, int attrtype)
@@ -854,7 +854,7 @@ static inline struct nlattr *nlmsg_find_attr(const struct nlmsghdr *nlh,
  * specified policy. Validation is done in liberal mode.
  * See documentation of struct nla_policy for more details.
  *
- * Returns 0 on success or a negative error code.
+ * Returns: 0 on success or a negative error code.
  */
 static inline int nla_validate_deprecated(const struct nlattr *head, int len,
 					  int maxtype,
@@ -877,7 +877,7 @@ static inline int nla_validate_deprecated(const struct nlattr *head, int len,
  * specified policy. Validation is done in strict mode.
  * See documentation of struct nla_policy for more details.
  *
- * Returns 0 on success or a negative error code.
+ * Returns: 0 on success or a negative error code.
  */
 static inline int nla_validate(const struct nlattr *head, int len, int maxtype,
 			       const struct nla_policy *policy,
@@ -914,7 +914,7 @@ static inline int nlmsg_validate_deprecated(const struct nlmsghdr *nlh,
  * nlmsg_report - need to report back to application?
  * @nlh: netlink message header
  *
- * Returns 1 if a report back to the application is requested.
+ * Returns: 1 if a report back to the application is requested.
  */
 static inline int nlmsg_report(const struct nlmsghdr *nlh)
 {
@@ -925,7 +925,7 @@ static inline int nlmsg_report(const struct nlmsghdr *nlh)
  * nlmsg_seq - return the seq number of netlink message
  * @nlh: netlink message header
  *
- * Returns 0 if netlink message is NULL
+ * Returns: 0 if netlink message is NULL
  */
 static inline u32 nlmsg_seq(const struct nlmsghdr *nlh)
 {
@@ -952,7 +952,7 @@ static inline u32 nlmsg_seq(const struct nlmsghdr *nlh)
  * @payload: length of message payload
  * @flags: message flags
  *
- * Returns NULL if the tailroom of the skb is insufficient to store
+ * Returns: NULL if the tailroom of the skb is insufficient to store
  * the message header and payload.
  */
 static inline struct nlmsghdr *nlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
@@ -971,7 +971,7 @@ static inline struct nlmsghdr *nlmsg_put(struct sk_buff *skb, u32 portid, u32 se
  *
  * Append data to an existing nlmsg, used when constructing a message
  * with multiple fixed-format headers (which is rare).
- * Returns NULL if the tailroom of the skb is insufficient to store
+ * Returns: NULL if the tailroom of the skb is insufficient to store
  * the extra payload.
  */
 static inline void *nlmsg_append(struct sk_buff *skb, u32 size)
@@ -993,7 +993,7 @@ static inline void *nlmsg_append(struct sk_buff *skb, u32 size)
  * @payload: length of message payload
  * @flags: message flags
  *
- * Returns NULL if the tailroom of the skb is insufficient to store
+ * Returns: NULL if the tailroom of the skb is insufficient to store
  * the message header and payload.
  */
 static inline struct nlmsghdr *nlmsg_put_answer(struct sk_buff *skb,
@@ -1050,7 +1050,7 @@ static inline void nlmsg_end(struct sk_buff *skb, struct nlmsghdr *nlh)
  * nlmsg_get_pos - return current position in netlink message
  * @skb: socket buffer the message is stored in
  *
- * Returns a pointer to the current tail of the message.
+ * Returns: a pointer to the current tail of the message.
  */
 static inline void *nlmsg_get_pos(struct sk_buff *skb)
 {
@@ -1276,7 +1276,7 @@ static inline int nla_ok(const struct nlattr *nla, int remaining)
  * @nla: netlink attribute
  * @remaining: number of bytes remaining in attribute stream
  *
- * Returns the next netlink attribute in the attribute stream and
+ * Returns: the next netlink attribute in the attribute stream and
  * decrements remaining by the size of the current attribute.
  */
 static inline struct nlattr *nla_next(const struct nlattr *nla, int *remaining)
@@ -1292,7 +1292,7 @@ static inline struct nlattr *nla_next(const struct nlattr *nla, int *remaining)
  * @nla: attribute containing the nested attributes
  * @attrtype: type of attribute to look for
  *
- * Returns the first attribute which matches the specified type.
+ * Returns: the first attribute which matches the specified type.
  */
 static inline struct nlattr *
 nla_find_nested(const struct nlattr *nla, int attrtype)
@@ -2091,7 +2091,7 @@ static inline int nla_get_flag(const struct nlattr *nla)
  * nla_get_msecs - return payload of msecs attribute
  * @nla: msecs netlink attribute
  *
- * Returns the number of milliseconds in jiffies.
+ * Returns: the number of milliseconds in jiffies.
  */
 static inline unsigned long nla_get_msecs(const struct nlattr *nla)
 {
@@ -2183,7 +2183,7 @@ static inline void *nla_memdup_noprof(const struct nlattr *src, gfp_t gfp)
  * marked their nest attributes with NLA_F_NESTED flag. New APIs should use
  * nla_nest_start() which sets the flag.
  *
- * Returns the container attribute or NULL on error
+ * Returns: the container attribute or NULL on error
  */
 static inline struct nlattr *nla_nest_start_noflag(struct sk_buff *skb,
 						   int attrtype)
@@ -2204,7 +2204,7 @@ static inline struct nlattr *nla_nest_start_noflag(struct sk_buff *skb,
  * Unlike nla_nest_start_noflag(), mark the nest attribute with NLA_F_NESTED
  * flag. This is the preferred function to use in new code.
  *
- * Returns the container attribute or NULL on error
+ * Returns: the container attribute or NULL on error
  */
 static inline struct nlattr *nla_nest_start(struct sk_buff *skb, int attrtype)
 {
@@ -2219,7 +2219,7 @@ static inline struct nlattr *nla_nest_start(struct sk_buff *skb, int attrtype)
  * Corrects the container attribute header to include the all
  * appended attributes.
  *
- * Returns the total data length of the skb.
+ * Returns: the total data length of the skb.
  */
 static inline int nla_nest_end(struct sk_buff *skb, struct nlattr *start)
 {
@@ -2252,7 +2252,7 @@ static inline void nla_nest_cancel(struct sk_buff *skb, struct nlattr *start)
  * specified policy. Attributes with a type exceeding maxtype will be
  * ignored. See documentation of struct nla_policy for more details.
  *
- * Returns 0 on success or a negative error code.
+ * Returns: 0 on success or a negative error code.
  */
 static inline int __nla_validate_nested(const struct nlattr *start, int maxtype,
 					const struct nla_policy *policy,
@@ -2285,7 +2285,7 @@ nla_validate_nested_deprecated(const struct nlattr *start, int maxtype,
  * nla_need_padding_for_64bit - test 64-bit alignment of the next attribute
  * @skb: socket buffer the message is stored in
  *
- * Return true if padding is needed to align the next attribute (nla_data()) to
+ * Return: true if padding is needed to align the next attribute (nla_data()) to
  * a 64-bit aligned area.
  */
 static inline bool nla_need_padding_for_64bit(struct sk_buff *skb)
@@ -2312,7 +2312,7 @@ static inline bool nla_need_padding_for_64bit(struct sk_buff *skb)
  * This will only be done in architectures which do not have
  * CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS defined.
  *
- * Returns zero on success or a negative error code.
+ * Returns: zero on success or a negative error code.
  */
 static inline int nla_align_64bit(struct sk_buff *skb, int padattr)
 {
diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 793e6fd78bc5..25fde4d598cb 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -105,7 +105,7 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
  * Get a page fragment from the page allocator or page_pool caches.
  *
  * Return:
- * Return allocated page fragment, otherwise return NULL.
+ * Return: allocated page fragment, otherwise return NULL.
  */
 static inline struct page *page_pool_dev_alloc_frag(struct page_pool *pool,
 						    unsigned int *offset,
@@ -156,7 +156,7 @@ static inline struct page *page_pool_alloc(struct page_pool *pool,
  * utilization and performance penalty.
  *
  * Return:
- * Return allocated page or page fragment, otherwise return NULL.
+ * Return: allocated page or page fragment, otherwise return NULL.
  */
 static inline struct page *page_pool_dev_alloc(struct page_pool *pool,
 					       unsigned int *offset,
@@ -191,7 +191,7 @@ static inline void *page_pool_alloc_va(struct page_pool *pool,
  * it returns va of the allocated page or page fragment.
  *
  * Return:
- * Return the va for the allocated page or page fragment, otherwise return NULL.
+ * Return: the va for the allocated page or page fragment, otherwise return NULL.
  */
 static inline void *page_pool_dev_alloc_va(struct page_pool *pool,
 					   unsigned int *size)
diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index cf199af85c52..22c5ab4269d7 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -319,7 +319,7 @@ tcf_exts_hw_stats_update(const struct tcf_exts *exts,
  * tcf_exts_has_actions - check if at least one action is present
  * @exts: tc filter extensions handle
  *
- * Returns true if at least one action is present.
+ * Returns: true if at least one action is present.
  */
 static inline bool tcf_exts_has_actions(struct tcf_exts *exts)
 {
@@ -501,7 +501,7 @@ int __tcf_em_tree_match(struct sk_buff *, struct tcf_ematch_tree *,
  * through all ematches respecting their logic relations returning
  * as soon as the result is obvious.
  *
- * Returns 1 if the ematch tree as-one matches, no ematches are configured
+ * Returns: 1 if the ematch tree as-one matches, no ematches are configured
  * or ematch is not enabled in the kernel, otherwise 0 is returned.
  */
 static inline int tcf_em_tree_match(struct sk_buff *skb,
diff --git a/include/net/tcp.h b/include/net/tcp.h
index e9b37b76e894..5b2b04835688 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1817,7 +1817,7 @@ int tcp_sigpool_hash_skb_data(struct tcp_sigpool *hp,
  * @id: tcp_sigpool that was previously allocated by tcp_sigpool_alloc_ahash()
  * @c: returned tcp_sigpool for usage (uninitialized on failure)
  *
- * Returns 0 on success, error otherwise.
+ * Returns: 0 on success, error otherwise.
  */
 int tcp_sigpool_start(unsigned int id, struct tcp_sigpool *c);
 /**
-- 
2.47.0


