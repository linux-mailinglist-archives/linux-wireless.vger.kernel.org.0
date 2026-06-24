Return-Path: <linux-wireless+bounces-38056-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8un1Or3tO2ocfggAu9opvQ
	(envelope-from <linux-wireless+bounces-38056-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 16:46:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 603BD6BF477
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 16:46:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HyQnEbJS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38056-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38056-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A273030038E8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2026 14:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5102FF164;
	Wed, 24 Jun 2026 14:45:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B82FFDEA
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 14:45:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312346; cv=none; b=LNv55qB6p2+y5Mx/2mSVEoGreqh8EchXPnFhYBREnte72qdrJdIjBxDVKdzj96JcbSfvlzIcZ8ltLjjHuGXJ4te2gJL8ZhkVNuOqNoWiJVu17v2/Ns2rr0MS0QrTUi2713khGffxJzozLbVcueoh0M1M/nlWUJdoDWNdZv0B3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312346; c=relaxed/simple;
	bh=SIxcE3UQx0mhZH0P1JA270bUDPyvNng0rsY7BIL41zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpSoCUNUMpyS+nS6p47QTteTqpTUTNXW5oH1UH5RZ3bWDohkwupT5QtrNT4UDfyKMA3IxvSWJLj+c/TcLs58dBD0qI0lH5Qc1ufU1JobI0coJst00weNUuqTAu/DzK1K6jnAzoZWtm/t1VuAugz+sdOdEB6vytYqlC9jW3nTGrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyQnEbJS; arc=none smtp.client-ip=74.125.82.169
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30bf132969bso1523086eec.0
        for <linux-wireless@vger.kernel.org>; Wed, 24 Jun 2026 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782312342; x=1782917142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bXUdI+guwfcRMBA0cDxWQJ5EDYVxWF74RchWdZtg0c=;
        b=HyQnEbJSDPo02faC4PlQCD49o2hSxMUrvRIQSazOQu2WYAnNol2PTjOml7TvxjcvhT
         uQsH3UOSY7tvTqXKh9rIHRASp43ED6zoR5UtzUYXw9eW66y3qn4Nstc2rbPtl11cbTKi
         uUBd2I6HlFwnaLpoGSh6jnfsufEBnW+gzyn4BHBTYNepCN45qqoLh1Fzz7xQ6bSMfTv3
         /eAbgPrJlBdGOfE8vaIobEguzRn89SvsWQWWQnZi498yHE3EC2W9+nbvDrF2+N2xV1Ll
         QBbEt67C+6xy6pTuMwXZrKItZb2CFEuz41FrQ3QWYvKk5Fe/apEOt9wsitr/rufpNUNN
         OA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782312342; x=1782917142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8bXUdI+guwfcRMBA0cDxWQJ5EDYVxWF74RchWdZtg0c=;
        b=tJQezjNJ2xB8SdHSenBJdeXKBlwBqGjv/sL2xr2LfnazaQuQtr6a3C+EL/G+/G6l6p
         bU2QvU5XUfMS74f8OkHlt31pwjDTJkjJnUUlQXxYsMfRy5Mkw2Z3wZoBGlBS79SB8QQs
         l4KuAL8tEWl1yQeXSEPGS8yhfcg5Vm/xitQB4VQriBYrjNJ28STgIzEMEjemUdrMXLcz
         fsE0Prj2bEkqrIagxaSfXT6/zupGOEfF4HdzIjyRZ1wNbXUi41WiENbpkba/xk8kVsco
         J1nabovuL5O+V5It88U+5GyLz+D21bjxUMyAWMsZQ5mV0xQQTelJe9l5nIkguTIr9P59
         4gQA==
X-Forwarded-Encrypted: i=1; AHgh+RrJ5JM4wv5ujcqSxHwMAY9Cr2XfpqkwzCJehR9N7raVe9rHhRstR8hHCItklTjGXn1YxgtPbpAsR6x1gIaaoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsRR2NyeBr8cwZrq3+NSkR+KTZLHG642jVbHPwzFdNOYX+u4Sq
	0JrASKXgBiAay22SqgKHz+3trw9fB8CABaGKLxgnkk3Bu0LeI/duE2QK
X-Gm-Gg: AfdE7cmLdxki2gYf1S+3MS3tzBKYA5rYvMtnX62kl0hIZlYDScvcd3DgOd1o8KFI7Yf
	eM+OJ1SdkN59jvPklisF/grIJ2mVM61QcG3zdwsxIp0zpF94jXnX1DKUlcFii5NVZzjQICsrlu3
	AP4xD8b/ZsMIoTypkn3aLnCjdUqFlAihoWhTnhXOE7TYOZjs2BJvJzSTOqnD2B4zGgqSb/OSB9T
	6trcX1uobRESP86NhctJTOO9Sx5E/WG6SCWmWH+UV1Y3c8EFnwY/We1k+zw/bUW5tl5CvIK/PWn
	UFhYNY6lr3ywtHNRYM3rz94KZmmu9uWDn5QL5gYO9H0PsCR+PLk9yq/gLCJk9O3zVUhULFiUpZQ
	rfYD1lUWbGwr1554oCnCqo1gwE+mw3kB4VNK044ShpLjedZK8bFugTAyjyTUjr//xVg5lzeBvWF
	aX6XmqccjzLpFSRztgHXyqkX/uVC/8ITRSuQ92
X-Received: by 2002:a05:7300:cb13:b0:307:934e:da79 with SMTP id 5a478bee46e88-30c68e9019emr3758358eec.34.1782312342370;
        Wed, 24 Jun 2026 07:45:42 -0700 (PDT)
Received: from yyh-VMware-Virtual-Platform.lan ([45.32.131.238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba5c25csm24899292eec.8.2026.06.24.07.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:45:41 -0700 (PDT)
From: Yanghan Ye <yyh94306@gmail.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.wu@mediatek.com>
Cc: linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	Yanghan Ye <yyh94306@gmail.com>
Subject: [PATCH v1 1/2] wifi: mt76: mt7996: refresh power limits on txpower changes
Date: Wed, 24 Jun 2026 22:45:15 +0800
Message-ID: <20260624144516.1841063-2-yyh94306@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624144516.1841063-1-yyh94306@gmail.com>
References: <20260624144516.1841063-1-yyh94306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38056-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:deren.wu@mediatek.com,m:linux-mediatek@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:yyh94306@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yyh94306@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yyh94306@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 603BD6BF477

mt7996_config() currently ignores mac80211 configuration changes. As a
result, user txpower updates may change the cfg80211 visible power level
without refreshing the firmware SKU table used by mt7996.

Refresh the SKU table when mac80211 reports power or channel changes. Only
copy hw->conf.power_level into the cached PHY txpower on global power
changes so channel-only updates do not overwrite a BSS txpower limit.

Also refresh the SKU table and channel information for BSS txpower changes,
and report MCU failures instead of silently ignoring them.

Signed-off-by: Yanghan Ye <yyh94306@gmail.com>
---
 mt7996/main.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/mt7996/main.c b/mt7996/main.c
index 560fe30d..c32e7819 100644
--- a/mt7996/main.c
+++ b/mt7996/main.c
@@ -736,7 +736,50 @@ static int mt7996_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 static int mt7996_config(struct ieee80211_hw *hw, int radio_idx, u32 changed)
 {
-	return 0;
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy;
+	int ret = 0;
+
+	if (!(changed & (IEEE80211_CONF_CHANGE_POWER |
+			 IEEE80211_CONF_CHANGE_CHANNEL)))
+		return 0;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	if (radio_idx >= 0) {
+		if (radio_idx >= ARRAY_SIZE(dev->radio_phy)) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		phy = dev->radio_phy[radio_idx];
+		if (phy) {
+			if (changed & IEEE80211_CONF_CHANGE_POWER)
+				phy->txpower = hw->conf.power_level;
+
+			ret = mt7996_mcu_set_txpower_sku(phy);
+			if (!ret && (changed & IEEE80211_CONF_CHANGE_POWER))
+				ret = mt7996_mcu_set_chan_info(phy,
+							       UNI_CHANNEL_SWITCH);
+		}
+	} else {
+		mt7996_for_each_phy(dev, phy) {
+			if (changed & IEEE80211_CONF_CHANGE_POWER)
+				phy->txpower = hw->conf.power_level;
+
+			ret = mt7996_mcu_set_txpower_sku(phy);
+			if (!ret && (changed & IEEE80211_CONF_CHANGE_POWER))
+				ret = mt7996_mcu_set_chan_info(phy,
+							       UNI_CHANNEL_SWITCH);
+			if (ret)
+				break;
+		}
+	}
+
+out:
+	mutex_unlock(&dev->mt76.mutex);
+
+	return ret;
 }
 
 static int
@@ -1025,9 +1068,24 @@ mt7996_link_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mt7996_update_mu_group(hw, link, info);
 
 	if (changed & BSS_CHANGED_TXPOWER &&
+	    info->txpower != INT_MIN &&
 	    info->txpower != phy->txpower) {
+		int ret;
+
 		phy->txpower = info->txpower;
-		mt7996_mcu_set_txpower_sku(phy);
+		ret = mt7996_mcu_set_txpower_sku(phy);
+		if (ret) {
+			dev_err_ratelimited(dev->mt76.dev,
+					    "failed to update txpower SKU: %d\n",
+					    ret);
+			goto out;
+		}
+
+		ret = mt7996_mcu_set_chan_info(phy, UNI_CHANNEL_SWITCH);
+		if (ret)
+			dev_err_ratelimited(dev->mt76.dev,
+					    "failed to update txpower channel info: %d\n",
+					    ret);
 	}
 
 out:
-- 
2.43.0


