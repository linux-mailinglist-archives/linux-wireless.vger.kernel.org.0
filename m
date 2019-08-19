Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DB921CF
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 13:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfHSLGv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 07:06:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSLGv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 07:06:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4791A106E96C;
        Mon, 19 Aug 2019 11:06:50 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B5E211C9B1;
        Mon, 19 Aug 2019 11:06:45 +0000 (UTC)
Date:   Mon, 19 Aug 2019 13:06:40 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH 5.3] mt76: mt76x0e: don't use hw encryption for MT7630E
Message-ID: <20190819110639.GA6037@redhat.com>
References: <1565703400-10623-1-git-send-email-sgruszka@redhat.com>
 <CAJ0CqmXM4NRMYU6Lt_a4f+DXE2bVmhYrjQbgxHG0g=N+o3TeQw@mail.gmail.com>
 <20190815100936.GA21775@redhat.com>
 <727fd528-16c1-e3b3-e1a9-2edbcbdddee7@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727fd528-16c1-e3b3-e1a9-2edbcbdddee7@nbd.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Mon, 19 Aug 2019 11:06:50 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Aug 15, 2019 at 12:20:54PM +0200, Felix Fietkau wrote:
> On 2019-08-15 12:09, Stanislaw Gruszka wrote:
> >> Hi Stanislaw,
> >> 
> >> Can you please try if disabling/enabling the tx tasklet during hw key
> >> configuration fixes the issue?
> >> Doing something like:
> >> 
> >> tasklet_disable(tx_tasklet)
> >> mt76x02_set_key()
> >> tasklet_enable(tx_tasklet)
> > 
> > It does not help with the problem.
> > 
> >> Moreover, have you double checked if there is any performance impact
> >> of not using hw encryption?
> > 
> > I didn't observe any, but realized on this machine I have
> > aesni_intel encryption accelerator. After rebuild kernel without
> > CONFIG_CRYPTO_AES_NI_INTEL, 'perf top' showed extra 20% of cpu usage
> > in aes_encrypt() when sending data with HW encryption disabled.
> > 
> >> If so, I guess it is better to just redefine mt76_wake_tx_queue for
> >> mt76x0e and run mt76_txq_schedule for 7630e:
> >> 
> >> void mt76x0e_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
> >> {
> >>         if (is_mt7630(dev)) {
> >>             mt76_txq_schedule(dev, txq->ac);
> >>         } else {
> >>             tasklet_schedule(&dev->tx_tasklet);
> >>         }
> >> }
> > 
> > Not sure about reduction of lock contention for which the tx_tasklet
> > was introduced here, but looks ok for me as fix.
> I think if we work around the bug like this, it can easily come back to
> bite us again later. 

I'm not into workarounds any kind, but this is really strange issue,
maybe FW bug that triggers just by slightly different driver behaviour.

> I don't see any logical explanation as to how this
> makes a difference with hardware encryption.
> Also, I think it would be helpful to figure out what key operation (if
> any) triggers this, adding or removing keys.

Seems not to be related with set_key operation at all. We set 2 HW
keys at the beginning and hang happen after some tx/rx traffic
without any re-keyring.

I'm not sure why disabling HW encryption helps. Maybe it is due to
ordering or timing. With SW encryption we spend more time in mac80211
before pass skb's to the driver. Or maybe we just mix some HW keys 
and SW (group) keys in way that FW does not like.

> Maybe it could also help if we change the order in which the WCID table
> entries are updated, i.e. changing MT_WCID_ATTR first when removing keys.
> 
> Maybe temporarily clearing MT_MAC_SYS_CTRL_ENABLE_TX before the key
> update and setting it again afterwards could also help.

I tested below patch and it did not help.

Stanislaw

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 82bafb5ac326..846652f2b3f1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -105,11 +105,14 @@ int mt76x02_mac_wcid_set_key(struct mt76x02_dev *dev, u8 idx,
 	if (cipher == MT_CIPHER_NONE && key)
 		return -EOPNOTSUPP;
 
+	if (!key)
+		mt76_rmw_field(dev, MT_WCID_ATTR(idx), MT_WCID_ATTR_PKEY_MODE, MT_CIPHER_NONE);
+
 	mt76_wr_copy(dev, MT_WCID_KEY(idx), key_data, sizeof(key_data));
-	mt76_rmw_field(dev, MT_WCID_ATTR(idx), MT_WCID_ATTR_PKEY_MODE, cipher);
 
 	memset(iv_data, 0, sizeof(iv_data));
 	if (key) {
+		mt76_rmw_field(dev, MT_WCID_ATTR(idx), MT_WCID_ATTR_PKEY_MODE, cipher);
 		mt76_rmw_field(dev, MT_WCID_ATTR(idx), MT_WCID_ATTR_PAIRWISE,
 			       !!(key->flags & IEEE80211_KEY_FLAG_PAIRWISE));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index fa45ed280ab1..6f624e3329f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -391,7 +391,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76x02_ampdu_action);
 
-int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+int __mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		    struct ieee80211_vif *vif, struct ieee80211_sta *sta,
 		    struct ieee80211_key_conf *key)
 {
@@ -466,6 +466,35 @@ int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	return mt76x02_mac_wcid_set_key(dev, msta->wcid.idx, key);
 }
+
+int mt76x02_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+		    struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		    struct ieee80211_key_conf *key)
+{
+	struct mt76x02_dev *dev = hw->priv;
+	int ret;
+	int i = 200;
+
+	tasklet_disable(&dev->mt76.tx_tasklet);
+
+	/* Page count on TxQ */
+	while (i-- && ((mt76_rr(dev, 0x0438) & 0xffffffff) ||
+		       (mt76_rr(dev, 0x0a30) & 0x000000ff) ||
+		       (mt76_rr(dev, 0x0a34) & 0x00ff00ff)))
+		msleep(10);
+
+	if (!mt76_poll(dev, MT_MAC_STATUS, MT_MAC_STATUS_TX, 0, 1000))
+		dev_warn(dev->mt76.dev, "Warning: SET KEY: MAC TX did not stop!\n");
+
+	mt76_clear(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_ENABLE_TX);
+
+	ret = __mt76x02_set_key(hw, cmd, vif, sta, key);
+
+	mt76_set(dev, MT_MAC_SYS_CTRL, MT_MAC_SYS_CTRL_ENABLE_TX);
+	tasklet_enable(&dev->mt76.tx_tasklet);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(mt76x02_set_key);
 
 int mt76x02_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
