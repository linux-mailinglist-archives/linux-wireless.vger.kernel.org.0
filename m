Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED0817A665
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 14:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgCENcb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 08:32:31 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:34218 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgCENcb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 08:32:31 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j9qby-0019Cd-Ob; Thu, 05 Mar 2020 14:32:26 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Erel Geron <erelx.geron@intel.com>
Subject: [PATCH] mac80211_hwsim: add frame transmission support over virtio
Date:   Thu,  5 Mar 2020 14:32:14 +0100
Message-Id: <20200305143212.c6e4c87d225b.I7ce60bf143e863dcdf0fb8040aab7168ba549b99@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Erel Geron <erelx.geron@intel.com>

This allows communication with external entities.

It also required fixing up the netlink policy, since NLA_UNSPEC
attributes are no longer accepted.

Signed-off-by: Erel Geron <erelx.geron@intel.com>
[port to backports, inline the ID, use 29 as the ID as requested,
 drop != NULL checks, reduce ifdefs]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 331 ++++++++++++++++++++++++--
 drivers/net/wireless/mac80211_hwsim.h |  21 ++
 2 files changed, 334 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index da0a6b6c4771..3fb003a7fbad 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
  * Copyright (c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  */
 
 /*
@@ -33,6 +33,9 @@
 #include <net/netns/generic.h>
 #include <linux/rhashtable.h>
 #include <linux/nospec.h>
+#include <linux/virtio.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
 #include "mac80211_hwsim.h"
 
 #define WARN_QUEUE 100
@@ -613,14 +616,14 @@ static const struct genl_multicast_group hwsim_mcgrps[] = {
 /* MAC80211_HWSIM netlink policy */
 
 static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
-	[HWSIM_ATTR_ADDR_RECEIVER] = { .type = NLA_UNSPEC, .len = ETH_ALEN },
-	[HWSIM_ATTR_ADDR_TRANSMITTER] = { .type = NLA_UNSPEC, .len = ETH_ALEN },
+	[HWSIM_ATTR_ADDR_RECEIVER] = NLA_POLICY_ETH_ADDR_COMPAT,
+	[HWSIM_ATTR_ADDR_TRANSMITTER] = NLA_POLICY_ETH_ADDR_COMPAT,
 	[HWSIM_ATTR_FRAME] = { .type = NLA_BINARY,
 			       .len = IEEE80211_MAX_DATA_LEN },
 	[HWSIM_ATTR_FLAGS] = { .type = NLA_U32 },
 	[HWSIM_ATTR_RX_RATE] = { .type = NLA_U32 },
 	[HWSIM_ATTR_SIGNAL] = { .type = NLA_U32 },
-	[HWSIM_ATTR_TX_INFO] = { .type = NLA_UNSPEC,
+	[HWSIM_ATTR_TX_INFO] = { .type = NLA_BINARY,
 				 .len = IEEE80211_TX_MAX_RATES *
 					sizeof(struct hwsim_tx_rate)},
 	[HWSIM_ATTR_COOKIE] = { .type = NLA_U64 },
@@ -630,15 +633,65 @@ static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
 	[HWSIM_ATTR_REG_CUSTOM_REG] = { .type = NLA_U32 },
 	[HWSIM_ATTR_REG_STRICT_REG] = { .type = NLA_FLAG },
 	[HWSIM_ATTR_SUPPORT_P2P_DEVICE] = { .type = NLA_FLAG },
+	[HWSIM_ATTR_USE_CHANCTX] = { .type = NLA_FLAG },
 	[HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE] = { .type = NLA_FLAG },
 	[HWSIM_ATTR_RADIO_NAME] = { .type = NLA_STRING },
 	[HWSIM_ATTR_NO_VIF] = { .type = NLA_FLAG },
 	[HWSIM_ATTR_FREQ] = { .type = NLA_U32 },
-	[HWSIM_ATTR_PERM_ADDR] = { .type = NLA_UNSPEC, .len = ETH_ALEN },
+	[HWSIM_ATTR_TX_INFO_FLAGS] = { .type = NLA_BINARY },
+	[HWSIM_ATTR_PERM_ADDR] = NLA_POLICY_ETH_ADDR_COMPAT,
 	[HWSIM_ATTR_IFTYPE_SUPPORT] = { .type = NLA_U32 },
 	[HWSIM_ATTR_CIPHER_SUPPORT] = { .type = NLA_BINARY },
 };
 
+#if IS_REACHABLE(CONFIG_VIRTIO)
+
+#ifndef VIRTIO_ID_MAC80211_HWSIM
+#define VIRTIO_ID_MAC80211_HWSIM 29
+#endif
+
+/* MAC80211_HWSIM virtio queues */
+static struct virtqueue *hwsim_vqs[HWSIM_NUM_VQS];
+static bool hwsim_virtio_enabled;
+static spinlock_t hwsim_virtio_lock;
+
+static void hwsim_virtio_rx_work(struct work_struct *work);
+static DECLARE_WORK(hwsim_virtio_rx, hwsim_virtio_rx_work);
+
+static int hwsim_tx_virtio(struct mac80211_hwsim_data *data,
+			   struct sk_buff *skb)
+{
+	struct scatterlist sg[1];
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	if (!hwsim_virtio_enabled) {
+		err = -ENODEV;
+		goto out_free;
+	}
+
+	sg_init_one(sg, skb->head, skb_end_offset(skb));
+	err = virtqueue_add_outbuf(hwsim_vqs[HWSIM_VQ_TX], sg, 1, skb,
+				   GFP_ATOMIC);
+	if (err)
+		goto out_free;
+	virtqueue_kick(hwsim_vqs[HWSIM_VQ_TX]);
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+	return 0;
+
+out_free:
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+	nlmsg_free(skb);
+	return err;
+}
+#else
+/* cause a linker error if this ends up being needed */
+extern int hwsim_tx_virtio(struct mac80211_hwsim_data *data,
+			   struct sk_buff *skb);
+#define hwsim_virtio_enabled false
+#endif
+
 static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 				    struct sk_buff *skb,
 				    struct ieee80211_channel *chan);
@@ -1138,8 +1191,14 @@ static void mac80211_hwsim_tx_frame_nl(struct ieee80211_hw *hw,
 		goto nla_put_failure;
 
 	genlmsg_end(skb, msg_head);
-	if (hwsim_unicast_netgroup(data, skb, dst_portid))
-		goto err_free_txskb;
+
+	if (hwsim_virtio_enabled) {
+		if (hwsim_tx_virtio(data, skb))
+			goto err_free_txskb;
+	} else {
+		if (hwsim_unicast_netgroup(data, skb, dst_portid))
+			goto err_free_txskb;
+	}
 
 	/* Enqueue the packet */
 	skb_queue_tail(&data->pending, my_skb);
@@ -1441,7 +1500,7 @@ static void mac80211_hwsim_tx(struct ieee80211_hw *hw,
 	/* wmediumd mode check */
 	_portid = READ_ONCE(data->wmediumd);
 
-	if (_portid)
+	if (_portid || hwsim_virtio_enabled)
 		return mac80211_hwsim_tx_frame_nl(hw, skb, _portid);
 
 	/* NO wmediumd detected, perfect medium simulation */
@@ -1547,7 +1606,7 @@ static void mac80211_hwsim_tx_frame(struct ieee80211_hw *hw,
 
 	mac80211_hwsim_monitor_rx(hw, skb, chan);
 
-	if (_pid)
+	if (_pid || hwsim_virtio_enabled)
 		return mac80211_hwsim_tx_frame_nl(hw, skb, _pid);
 
 	mac80211_hwsim_tx_frame_no_nl(hw, skb, chan);
@@ -3293,11 +3352,14 @@ static int hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
 	if (!data2)
 		goto out;
 
-	if (hwsim_net_get_netgroup(genl_info_net(info)) != data2->netgroup)
-		goto out;
+	if (!hwsim_virtio_enabled) {
+		if (hwsim_net_get_netgroup(genl_info_net(info)) !=
+		    data2->netgroup)
+			goto out;
 
-	if (info->snd_portid != data2->wmediumd)
-		goto out;
+		if (info->snd_portid != data2->wmediumd)
+			goto out;
+	}
 
 	/* look for the skb matching the cookie passed back from user */
 	skb_queue_walk_safe(&data2->pending, skb, tmp) {
@@ -3387,11 +3449,14 @@ static int hwsim_cloned_frame_received_nl(struct sk_buff *skb_2,
 	if (!data2)
 		goto out;
 
-	if (hwsim_net_get_netgroup(genl_info_net(info)) != data2->netgroup)
-		goto out;
+	if (!hwsim_virtio_enabled) {
+		if (hwsim_net_get_netgroup(genl_info_net(info)) !=
+		    data2->netgroup)
+			goto out;
 
-	if (info->snd_portid != data2->wmediumd)
-		goto out;
+		if (info->snd_portid != data2->wmediumd)
+			goto out;
+	}
 
 	/* check if radio is configured properly */
 
@@ -3932,6 +3997,229 @@ static void hwsim_exit_netlink(void)
 	genl_unregister_family(&hwsim_genl_family);
 }
 
+#if IS_REACHABLE(CONFIG_VIRTIO)
+static void hwsim_virtio_tx_done(struct virtqueue *vq)
+{
+	unsigned int len;
+	struct sk_buff *skb;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	while ((skb = virtqueue_get_buf(vq, &len)))
+		nlmsg_free(skb);
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+}
+
+static int hwsim_virtio_handle_cmd(struct sk_buff *skb)
+{
+	struct nlmsghdr *nlh;
+	struct genlmsghdr *gnlh;
+	struct nlattr *tb[HWSIM_ATTR_MAX + 1];
+	struct genl_info info = {};
+	int err;
+
+	nlh = nlmsg_hdr(skb);
+	gnlh = nlmsg_data(nlh);
+	err = genlmsg_parse(nlh, &hwsim_genl_family, tb, HWSIM_ATTR_MAX,
+			    hwsim_genl_policy, NULL);
+	if (err) {
+		pr_err_ratelimited("hwsim: genlmsg_parse returned %d\n", err);
+		return err;
+	}
+
+	info.attrs = tb;
+
+	switch (gnlh->cmd) {
+	case HWSIM_CMD_FRAME:
+		hwsim_cloned_frame_received_nl(skb, &info);
+		break;
+	case HWSIM_CMD_TX_INFO_FRAME:
+		hwsim_tx_info_frame_received_nl(skb, &info);
+		break;
+	default:
+		pr_err_ratelimited("hwsim: invalid cmd: %d\n", gnlh->cmd);
+		return -EPROTO;
+	}
+	return 0;
+}
+
+static void hwsim_virtio_rx_work(struct work_struct *work)
+{
+	struct virtqueue *vq;
+	unsigned int len;
+	struct sk_buff *skb;
+	struct scatterlist sg[1];
+	int err;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	if (!hwsim_virtio_enabled)
+		goto out_unlock;
+
+	skb = virtqueue_get_buf(hwsim_vqs[HWSIM_VQ_RX], &len);
+	if (!skb)
+		goto out_unlock;
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+
+	skb->data = skb->head;
+	skb_set_tail_pointer(skb, len);
+	hwsim_virtio_handle_cmd(skb);
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	if (!hwsim_virtio_enabled) {
+		nlmsg_free(skb);
+		goto out_unlock;
+	}
+	vq = hwsim_vqs[HWSIM_VQ_RX];
+	sg_init_one(sg, skb->head, skb_end_offset(skb));
+	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
+	if (WARN(err, "virtqueue_add_inbuf returned %d\n", err))
+		nlmsg_free(skb);
+	else
+		virtqueue_kick(vq);
+	schedule_work(&hwsim_virtio_rx);
+
+out_unlock:
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+}
+
+static void hwsim_virtio_rx_done(struct virtqueue *vq)
+{
+	schedule_work(&hwsim_virtio_rx);
+}
+
+static int init_vqs(struct virtio_device *vdev)
+{
+	vq_callback_t *callbacks[HWSIM_NUM_VQS] = {
+		[HWSIM_VQ_TX] = hwsim_virtio_tx_done,
+		[HWSIM_VQ_RX] = hwsim_virtio_rx_done,
+	};
+	const char *names[HWSIM_NUM_VQS] = {
+		[HWSIM_VQ_TX] = "tx",
+		[HWSIM_VQ_RX] = "rx",
+	};
+
+	return virtio_find_vqs(vdev, HWSIM_NUM_VQS,
+			       hwsim_vqs, callbacks, names, NULL);
+}
+
+static int fill_vq(struct virtqueue *vq)
+{
+	int i, err;
+	struct sk_buff *skb;
+	struct scatterlist sg[1];
+
+	for (i = 0; i < virtqueue_get_vring_size(vq); i++) {
+		skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+
+		sg_init_one(sg, skb->head, skb_end_offset(skb));
+		err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);
+		if (err) {
+			nlmsg_free(skb);
+			return err;
+		}
+	}
+	virtqueue_kick(vq);
+	return 0;
+}
+
+static void remove_vqs(struct virtio_device *vdev)
+{
+	int i;
+
+	vdev->config->reset(vdev);
+
+	for (i = 0; i < ARRAY_SIZE(hwsim_vqs); i++) {
+		struct virtqueue *vq = hwsim_vqs[i];
+		struct sk_buff *skb;
+
+		while ((skb = virtqueue_detach_unused_buf(vq)))
+			nlmsg_free(skb);
+	}
+
+	vdev->config->del_vqs(vdev);
+}
+
+static int hwsim_virtio_probe(struct virtio_device *vdev)
+{
+	int err;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	if (hwsim_virtio_enabled) {
+		spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+		return -EEXIST;
+	}
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+
+	err = init_vqs(vdev);
+	if (err)
+		return err;
+
+	err = fill_vq(hwsim_vqs[HWSIM_VQ_RX]);
+	if (err)
+		goto out_remove;
+
+	spin_lock_irqsave(&hwsim_virtio_lock, flags);
+	hwsim_virtio_enabled = true;
+	spin_unlock_irqrestore(&hwsim_virtio_lock, flags);
+
+	schedule_work(&hwsim_virtio_rx);
+	return 0;
+
+out_remove:
+	remove_vqs(vdev);
+	return err;
+}
+
+static void hwsim_virtio_remove(struct virtio_device *vdev)
+{
+	hwsim_virtio_enabled = false;
+
+	cancel_work_sync(&hwsim_virtio_rx);
+
+	remove_vqs(vdev);
+}
+
+/* MAC80211_HWSIM virtio device id table */
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_MAC80211_HWSIM, VIRTIO_DEV_ANY_ID },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+static struct virtio_driver virtio_hwsim = {
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = id_table,
+	.probe = hwsim_virtio_probe,
+	.remove = hwsim_virtio_remove,
+};
+
+static int hwsim_register_virtio_driver(void)
+{
+	spin_lock_init(&hwsim_virtio_lock);
+
+	return register_virtio_driver(&virtio_hwsim);
+}
+
+static void hwsim_unregister_virtio_driver(void)
+{
+	unregister_virtio_driver(&virtio_hwsim);
+}
+#else
+static inline int hwsim_register_virtio_driver(void)
+{
+	return 0;
+}
+
+static inline void hwsim_unregister_virtio_driver(void)
+{
+}
+#endif
+
 static int __init init_mac80211_hwsim(void)
 {
 	int i, err;
@@ -3960,10 +4248,14 @@ static int __init init_mac80211_hwsim(void)
 	if (err)
 		goto out_unregister_driver;
 
+	err = hwsim_register_virtio_driver();
+	if (err)
+		goto out_exit_netlink;
+
 	hwsim_class = class_create(THIS_MODULE, "mac80211_hwsim");
 	if (IS_ERR(hwsim_class)) {
 		err = PTR_ERR(hwsim_class);
-		goto out_exit_netlink;
+		goto out_exit_virtio;
 	}
 
 	for (i = 0; i < radios; i++) {
@@ -4075,6 +4367,8 @@ static int __init init_mac80211_hwsim(void)
 	free_netdev(hwsim_mon);
 out_free_radios:
 	mac80211_hwsim_free();
+out_exit_virtio:
+	hwsim_unregister_virtio_driver();
 out_exit_netlink:
 	hwsim_exit_netlink();
 out_unregister_driver:
@@ -4091,6 +4385,7 @@ static void __exit exit_mac80211_hwsim(void)
 {
 	pr_debug("mac80211_hwsim: unregister radios\n");
 
+	hwsim_unregister_virtio_driver();
 	hwsim_exit_netlink();
 
 	mac80211_hwsim_free();
diff --git a/drivers/net/wireless/mac80211_hwsim.h b/drivers/net/wireless/mac80211_hwsim.h
index a85bc7c5c030..28ade92adcb4 100644
--- a/drivers/net/wireless/mac80211_hwsim.h
+++ b/drivers/net/wireless/mac80211_hwsim.h
@@ -3,6 +3,7 @@
  * mac80211_hwsim - software simulator of 802.11 radio(s) for mac80211
  * Copyright (c) 2008, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2011, Javier Lopez <jlopex@gmail.com>
+ * Copyright (C) 2020 Intel Corporation
  */
 
 #ifndef __MAC80211_HWSIM_H
@@ -245,4 +246,24 @@ struct hwsim_tx_rate_flag {
 	s8 idx;
 	u16 flags;
 } __packed;
+
+/**
+ * DOC: Frame transmission support over virtio
+ *
+ * Frame transmission is also supported over virtio to allow communication
+ * with external entities.
+ */
+
+/**
+ * enum hwsim_vqs - queues for virtio frame transmission
+ *
+ * @HWSIM_VQ_TX: send frames to external entity
+ * @HWSIM_VQ_RX: receive frames and transmission info reports
+ * @HWSIM_NUM_VQS: enum limit
+ */
+enum {
+	HWSIM_VQ_TX,
+	HWSIM_VQ_RX,
+	HWSIM_NUM_VQS,
+};
 #endif /* __MAC80211_HWSIM_H */
-- 
2.24.1

