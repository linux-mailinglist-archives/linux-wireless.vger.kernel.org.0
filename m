Return-Path: <linux-wireless+bounces-35292-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uA6QHD/i7GlvdQAAu9opvQ
	(envelope-from <linux-wireless+bounces-35292-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 17:48:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD95C466CA2
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 17:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F633009FA2
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2026 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1351282F2F;
	Sat, 25 Apr 2026 15:48:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2F14F70
	for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777132092; cv=none; b=nCvJfrEXAGpVDfXfhWzojPQSUBqfjfKiqqnHJoDgn75NNb6EokBp/kd1AU7+6EVgMoHlZKrTTyHV1meBkjKzmgxSmm7+RXIanky/eVEqeP2OXFTczKoAJl2oTLfJ942k10wnqRPrWhrybn/iO1vNz9sPwbzsxLnwnWlcmTfANZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777132092; c=relaxed/simple;
	bh=Y2OUaD1H8K2qh9zoqBnGgZooEtQFr5keEz4qDJQRig4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XVA7DcDjLrYv4JlySdovLTkefqCcDIEuGeEmVG+VUc/VzublE4iWgrlAI/RkHWQOEjfixq9f+Kp9ypXXFUr7B3/18CC70N5J1dmLOeehgtpsDizBsofjQEVuaE62IfaOHHmddC6CKf8meVw0jaMFvMd+1Zs3WLQeNlMhwCuLpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbd801138eso4640804a34.1
        for <linux-wireless@vger.kernel.org>; Sat, 25 Apr 2026 08:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777132090; x=1777736890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fw48R4PzR3KFTTv359LsUwBmKa+PCYa6JMxKAyiv4UA=;
        b=cmvn2ePlZjeKm37C6TEfTLyqNb+KD+ZDVDh9o9Txfmo/WqxGxjd4iVzMZr/jgCTUAS
         25cfUSEsOscSjp7mtqzMvVk2/MeG9V33PZhMUthOeQ3Q2Tz+HZvANwQb352xn+c34KmC
         MP48mIABQBa0ZO10ccXHt265dFi/ouaTjjZP2U6FYzyAcujkTwum76mhj/ulf0V/mucx
         C6EirV6VF4C8qpypdb8rBCsYAzd3kdpH8bFmA4X9bkQL09Efv99/JeVZTqx1NjyC3crJ
         hV8EgDHfIZSW2vWM6jTkFOD700jzbfr2q8gj0lD34U5Qgjn7sLUG6ankwwP1Cz45upZy
         5MzA==
X-Gm-Message-State: AOJu0Yyu4/qjES0F2Chc58NACyYljQtZidh85LzX5nOJ3IJsHn0zSoiY
	VA5Ogzc3sqkGAbIneaptBwaypH7vU1gnKpB2C28/uuSljUCCxhrC3DLRyT5RAg==
X-Gm-Gg: AeBDieuDoTL9WkYAWOtzWyvhu4fzK1tcB1nbXmwu44Ns7pFFpVDw1NQwAq7anj5BjAV
	z83xtIU1x7nyUKwiVY4WqSsPGe7aM5LKckzoePQ8MLDoIjo3v9oJQMXXy8SfJB+UM2UkxOzmery
	z4x948V63688CEm7dcMObGxHp8SNh+4h34AzG/2fnpqlpEEu/ljuFrTCMMQOJPccuf6OLKDMncv
	XtOmM/cubF46PNn4KclUfp9KwjvNmVdlsbkoEpr4TTKyn1AxQs+HbLLQsp6fHnZZzPnALAVoCz0
	+apQUseT28gH2n2ZcwqkUAovcLP9XGz6X0DZdVmIA2iqRmqFVqHMzNvHooPkiwgR7c1ALn/a2/3
	4GarmpvKXx5R7udl8jfV+TpAhOKV0bLWROBXjgryVbptU+wsWjbd+veDQSnI6Wi8oDoQACu+LWu
	NOk124y1zQ+aDQ/+5PRWqp8PBTXUuOMBH9jRZnArl0By9ldveK/uZl8yjSvsLAhBhB2tFyuVwzs
	A==
X-Received: by 2002:a05:6820:83ce:10b0:694:85a9:d898 with SMTP id 006d021491bc7-69485a9e036mr8923901eaf.23.1777132090179;
        Sat, 25 Apr 2026 08:48:10 -0700 (PDT)
Received: from sean-HP-EliteBook-830-G6.attlocal.net ([2600:1702:5083:7610:9f96:11d3:5f6c:5582])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69493183021sm10094808eaf.13.2026.04.25.08.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 08:48:08 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>,
	Yao Ting Hsieh <yao-ting.hsieh@mediatek.com>
Subject: [PATCH 2/3] wifi: mt76: mt7925: pass WCID explicitly to mt7925_mcu_sta_ba()
Date: Sat, 25 Apr 2026 10:47:20 -0500
Message-ID: <20260425154721.738101-2-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425154721.738101-1-sean.wang@kernel.org>
References: <20260425154721.738101-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD95C466CA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-35292-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org]

From: Sean Wang <sean.wang@mediatek.com>

mt7925_mcu_sta_ba() currently hides the BA target behind an implicit WCID
lookup.

Pass the WCID explicitly so the caller controls which BA context is being
programmed.

No functional change intended.

Tested-by: Yao Ting Hsieh <yao-ting.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 37cdf3e8a067..c720d21c1727 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -624,9 +624,8 @@ void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 static int
 mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 		  struct ieee80211_ampdu_params *params,
-		  bool enable, bool tx)
+		  struct mt76_wcid *wcid, bool enable, bool tx)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
 	struct sta_rec_ba_uni *ba;
 	struct sk_buff *skb;
 	struct tlv *tlv;
@@ -664,6 +663,7 @@ int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
 		msta->deflink.wcid.amsdu = false;
 
 	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 &msta->deflink.wcid,
 				 enable, true);
 }
 
@@ -675,6 +675,7 @@ int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
 	struct mt792x_vif *mvif = msta->vif;
 
 	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
+				 &msta->deflink.wcid,
 				 enable, false);
 }
 
-- 
2.43.0


