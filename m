Return-Path: <linux-wireless+bounces-22604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEA5AAB10F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EACF34A6A39
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8422128F528;
	Tue,  6 May 2025 00:11:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AC28DF32
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 23:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488189; cv=none; b=l36feOXguD/xVoYsEM2NTEQd9kBrSx7fNcuoXmmsowZGxquvLAS7B/eKPfKMT/Px28ajSZ2B5ndl3y3Ma66ISTNqUj+v1MSMYalngL3RV8d0+jmqDD6ZLK+GE2ceqog8VjPFVsEsokoJyt8l+R/i1DX7JjPFDN3ZEByqTCZGngg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488189; c=relaxed/simple;
	bh=8WfL1MskZ4UFAUHzZ5SF2u9MPZP+w9XzEdd0iKgulgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QB+YjjGqSr+t3vSZdVE9dr/rODREC9+53uLllz60Z8lJjnxx/ZmG8JjJQ86+KORG5VECRvXXTJL6g2pPzRc/ZQzN4MzMYCAoIQ/GI08EA9iaafCRAtecHo25oPoUN8TLWrLPKz9Awajjw8xDp/wgx70H+afNN4n8Jnn6uTe4eJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3fbc00143d6so3637667b6e.3
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 16:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746488186; x=1747092986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIQjpkWFRGm5s5KaWP1qLMQhdMk1jnzl4jrQy/3g0yo=;
        b=Wj9RF0AxX2OqCGwFVfZ+7wtfA0/15VqknXeQjs1wLnf58oyEdss5+pMBlQz5gYNSMd
         ivVpMOTf8/OkxE1DvarJVTC5S3Ia2gqDpyJxjbaXCmZW3Y3WHpa2kwFmXF9ROZb6N27A
         MygS+7TfVjZen/xRgPZ6b0gXXFQcdv4YVJG7P66BFHThe85Il6P1GFytltQK9FrjTVGK
         x9JXYs2wfoDJymnW5Wz2O44fCKzjFj/15tWai9aQHI/d4sMZZDnZ/XBel4Mvsd2WQDP2
         kQDR7jcPYwBghhAXrIluKtsqdqBM8L9JyqkR7stEsDwOcyLGzZ+PFL31DS5TblLCNBdT
         wzpw==
X-Forwarded-Encrypted: i=1; AJvYcCVT1Lk3ox8IRD7SJ5/+wlX1wh/anPLosr0bmMQsUHlXMxScPWsxOfZY87r1c0DxcNcwx52R/X3z3T8hzawoOg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEoo4h8oK6HoCmiqNI1HJcMBjeV2uqyRu7dvfOTvBFoV+n3wp
	XnZPRezKFNCX7jWDKAShSyJ/DkrFHMYaZRLwMD/h0P5nSxskOoiH
X-Gm-Gg: ASbGncsMv95WctMohf3fqVP+WOD20vj+Zn/a3oTv60tx9dKLH4DWn8BkXZhExTTf040
	iCiTY0LV3REgbl1qQHGyYJ+H0HLOjAMkMufmsCnQCbIUjaFRYkj1UjDWyWh6YQLFFt761S00vce
	5+WYyP02JSv++5aycsJmPWBVQYmPpy94QbblhfhPjko0NF6fxUffi+oNeEqsC57BuWX01sGsCB7
	nFjmouwCbHn4WJv4t+OMVzJmZsSmhjSZdSAvZqB4DrQWuXjYikL8v4Fe5IgByJxNRGXMgoxnZvz
	EI43d0NtUum11bKqqEyhiTftfvi+Py2Sk5tnJmwuwsnCDGUcdezWTT7fq2sdSydIJ7J/
X-Google-Smtp-Source: AGHT+IGmsWxqajR+mFPYzk4EBcM5JZ93WXPWhbLIELXxVqqggKeH/LKXShQeFFvQJmxFMo+Qn/lGvw==
X-Received: by 2002:a05:6808:13d6:b0:401:e963:e973 with SMTP id 5614622812f47-4035a5c7410mr6176930b6e.30.1746488185631;
        Mon, 05 May 2025 16:36:25 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dc83025sm2157543b6e.43.2025.05.05.16.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 16:36:24 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Michael Lo <michael.lo@mediatek.com>
Subject: [PATCH 2/2] wifi: mt76: mt7925: add test mode support
Date: Mon,  5 May 2025 16:36:18 -0700
Message-Id: <20250505233618.1951021-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505233618.1951021-1-sean.wang@kernel.org>
References: <20250505233618.1951021-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Lo <michael.lo@mediatek.com>

The test mode interface allows controlled execution of chip-level
operations such as continuous transmission, reception tests, and
register access, which are essential during bring-up, diagnostics
, and factory testing.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7925/Makefile    |   1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |   2 +
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |   5 +
 .../wireless/mediatek/mt76/mt7925/testmode.c  | 204 ++++++++++++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/testmode.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/Makefile b/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
index d321e4ed732f..ade5e647c941 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_MT7925E) += mt7925e.o
 obj-$(CONFIG_MT7925U) += mt7925u.o
 
 mt7925-common-y := mac.o mcu.o main.o init.o debugfs.o
+mt7925-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
 mt7925e-y := pci.o pci_mac.o pci_mcu.o
 mt7925u-y := usb.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 83f93f9e002c..17fc5f05cb7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2244,6 +2244,8 @@ const struct ieee80211_ops mt7925_ops = {
 	.sta_statistics = mt792x_sta_statistics,
 	.sched_scan_start = mt7925_start_sched_scan,
 	.sched_scan_stop = mt7925_stop_sched_scan,
+	CFG80211_TESTMODE_CMD(mt7925_testmode_cmd)
+	CFG80211_TESTMODE_DUMP(mt7925_testmode_dump)
 #ifdef CONFIG_PM
 	.suspend = mt7925_suspend,
 	.resume = mt7925_resume,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 4e50f2597ccd..c507dcae07d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -366,4 +366,9 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_sta *sta,
 				     int link_id);
 
+int mt7925_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			void *data, int len);
+int mt7925_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+			 struct netlink_callback *cb, void *data, int len);
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c
new file mode 100644
index 000000000000..6a41b95ce56c
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/testmode.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: ISC
+
+#include "mt7925.h"
+#include "mcu.h"
+
+#define MT7925_EVT_RSP_LEN 512
+
+enum mt7925_testmode_attr {
+	MT7925_TM_ATTR_UNSPEC,
+	MT7925_TM_ATTR_SET,
+	MT7925_TM_ATTR_QUERY,
+	MT7925_TM_ATTR_RSP,
+
+	/* keep last */
+	NUM_MT7925_TM_ATTRS,
+	MT7925_TM_ATTR_MAX = NUM_MT7925_TM_ATTRS - 1,
+};
+
+struct mt7925_tm_cmd {
+	u8 padding[4];
+	struct uni_cmd_testmode_ctrl c;
+} __packed;
+
+struct mt7925_tm_evt {
+	u32 param0;
+	u32 param1;
+} __packed;
+
+static const struct nla_policy mt7925_tm_policy[NUM_MT7925_TM_ATTRS] = {
+	[MT7925_TM_ATTR_SET] = NLA_POLICY_EXACT_LEN(sizeof(struct mt7925_tm_cmd)),
+	[MT7925_TM_ATTR_QUERY] = NLA_POLICY_EXACT_LEN(sizeof(struct mt7925_tm_cmd)),
+};
+
+static int
+mt7925_tm_set(struct mt792x_dev *dev, struct mt7925_tm_cmd *req)
+{
+	struct mt7925_rftest_cmd cmd;
+	struct mt7925_rftest_cmd *pcmd = &cmd;
+	bool testmode = false, normal = false;
+	struct mt76_connac_pm *pm = &dev->pm;
+	struct mt76_phy *phy = &dev->mphy;
+	int ret = -ENOTCONN;
+
+	memset(pcmd, 0, sizeof(*pcmd));
+	memcpy(pcmd, req, sizeof(struct mt7925_tm_cmd));
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (pcmd->ctrl.action == CMD_TEST_CTRL_ACT_SWITCH_MODE) {
+		if (pcmd->ctrl.data.op_mode == CMD_TEST_CTRL_ACT_SWITCH_MODE_NORMAL)
+			normal = true;
+		else
+			testmode = true;
+	}
+
+	if (testmode) {
+		/* Make sure testmode running on full power mode */
+		pm->enable = false;
+		cancel_delayed_work_sync(&pm->ps_work);
+		cancel_work_sync(&pm->wake_work);
+		__mt792x_mcu_drv_pmctrl(dev);
+
+		phy->test.state = MT76_TM_STATE_ON;
+	}
+
+	if (!mt76_testmode_enabled(phy))
+		goto out;
+
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(TESTMODE_CTRL), &cmd,
+				sizeof(cmd), false);
+
+	if (ret)
+		goto out;
+
+	if (normal) {
+		/* Switch back to the normal world */
+		phy->test.state = MT76_TM_STATE_OFF;
+		pm->enable = true;
+	}
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
+}
+
+static int
+mt7925_tm_query(struct mt792x_dev *dev, struct mt7925_tm_cmd *req,
+		char *evt_resp)
+{
+	struct mt7925_rftest_cmd cmd;
+	char *pcmd = (char *)&cmd;
+	struct uni_cmd_testmode_evt *evt;
+	struct sk_buff *skb = NULL;
+	int ret = 1;
+
+	memset(pcmd, 0, sizeof(*pcmd));
+	memcpy(pcmd + 4, (char *)&req->c, sizeof(struct uni_cmd_testmode_ctrl));
+
+	if (*((uint16_t *)req->padding) == MCU_UNI_CMD_TESTMODE_CTRL)
+		ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_QUERY(TESTMODE_CTRL),
+						&cmd, sizeof(cmd), true, &skb);
+	else if (*((uint16_t *)req->padding) == MCU_UNI_CMD_TESTMODE_RX_STAT)
+		ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_UNI_QUERY(TESTMODE_RX_STAT),
+						&cmd, sizeof(cmd), true, &skb);
+
+	if (ret)
+		goto out;
+
+	evt = (struct uni_cmd_testmode_evt *)skb->data;
+
+	memcpy((char *)evt_resp, (char *)skb->data + 8, MT7925_EVT_RSP_LEN);
+
+out:
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
+int mt7925_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			void *data, int len)
+{
+	struct nlattr *tb[NUM_MT76_TM_ATTRS];
+	struct mt76_phy *mphy = hw->priv;
+	struct mt792x_phy *phy = mphy->priv;
+	int err;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
+	    !(hw->conf.flags & IEEE80211_CONF_MONITOR))
+		return -ENOTCONN;
+
+	err = nla_parse_deprecated(tb, MT76_TM_ATTR_MAX, data, len,
+				   mt76_tm_policy, NULL);
+	if (err)
+		return err;
+
+	if (tb[MT76_TM_ATTR_DRV_DATA]) {
+		struct nlattr *drv_tb[NUM_MT7925_TM_ATTRS], *data;
+		int ret;
+
+		data = tb[MT76_TM_ATTR_DRV_DATA];
+		ret = nla_parse_nested_deprecated(drv_tb,
+						  MT7925_TM_ATTR_MAX,
+						  data, mt7925_tm_policy,
+						  NULL);
+		if (ret)
+			return ret;
+
+		data = drv_tb[MT7925_TM_ATTR_SET];
+		if (data)
+			return mt7925_tm_set(phy->dev, nla_data(data));
+	}
+
+	return -EINVAL;
+}
+
+int mt7925_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
+			 struct netlink_callback *cb, void *data, int len)
+{
+	struct nlattr *tb[NUM_MT76_TM_ATTRS];
+	struct mt76_phy *mphy = hw->priv;
+	struct mt792x_phy *phy = mphy->priv;
+	int err;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state) ||
+	    !(hw->conf.flags & IEEE80211_CONF_MONITOR) ||
+	    !mt76_testmode_enabled(mphy))
+		return -ENOTCONN;
+
+	if (cb->args[2]++ > 0)
+		return -ENOENT;
+
+	err = nla_parse_deprecated(tb, MT76_TM_ATTR_MAX, data, len,
+				   mt76_tm_policy, NULL);
+	if (err)
+		return err;
+
+	if (tb[MT76_TM_ATTR_DRV_DATA]) {
+		struct nlattr *drv_tb[NUM_MT7925_TM_ATTRS], *data;
+		int ret;
+
+		data = tb[MT76_TM_ATTR_DRV_DATA];
+		ret = nla_parse_nested_deprecated(drv_tb,
+						  MT7925_TM_ATTR_MAX,
+						  data, mt7925_tm_policy,
+						  NULL);
+		if (ret)
+			return ret;
+
+		data = drv_tb[MT7925_TM_ATTR_QUERY];
+		if (data) {
+			char evt_resp[MT7925_EVT_RSP_LEN];
+
+			err = mt7925_tm_query(phy->dev, nla_data(data),
+					      evt_resp);
+			if (err)
+				return err;
+
+			return nla_put(msg, MT7925_TM_ATTR_RSP,
+				       sizeof(evt_resp), evt_resp);
+		}
+	}
+
+	return -EINVAL;
+}
-- 
2.25.1


