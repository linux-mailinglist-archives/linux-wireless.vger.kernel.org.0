Return-Path: <linux-wireless+bounces-27604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D100EB94E51
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 10:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D1C67B6B87
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 07:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA134BA3A;
	Tue, 23 Sep 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q155NzQd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1CD317707
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614435; cv=none; b=nfuh0mVYy+BT2d9YnhtYcXvHK3HY+ApnS+KYJ5BW5ssInyDwpO45o0SRBMWeBTtKeEnbEJKKrpt3figMGfug6IJyJMWU+h9FupyRAdG493ck0uQjj8rpTa4wgH12c8zrZb2WzHk+nYydKOlyPVBSwfd9S1yN2puC4fJ+hYNL1hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614435; c=relaxed/simple;
	bh=pynqdHGr2KaEnteSncwKdJUw6R/4uCF4/io9wLSLKfc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nb2pkWPdDHipnh6DKe0zsNPvAnLdVQhdeLHRZhjU5GPUSyx5GzqLifTslP21FgzxAbhXUkxdppbTX4HWoSFuw/KTZhtPmd1jLZHGrQpyZSm8YYExjg/thwsxQMEhfnFCfUh+F7dl1Vdu8aQoOjDH51dzDNNjK8PHMytP91IHku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q155NzQd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46b303f755aso24263105e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 01:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758614432; x=1759219232; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VfPpe/or52X+zhVBTtpPVXU4FPPLcpy3HAsFtg+RRoE=;
        b=Q155NzQdTvQHWJ3n/2/G32VofoP63ZNqft4GlzNUPrKlcXm81wIOGlhS/vHVZO7GOX
         xhwrbCpwerqIbcAQD5yman70zOa9kyDIQXF1pEW0PwgwjfOeZLlPrjDfAx6BsdY+lJKE
         qsFzoBJPpZbyJFgoOCyez3Ma/mBTU6fbmvypfqEwqFAisYI9DGwe5qCcVaBvEw6iAXOP
         DbTR9sZM1wolx8bXEeH+2kQEbnz5j9cVhHW6/nFmfK4EOYABnFrucVqGoyPJcR9RqCkK
         TaWwLrK02eL49kJcdTMX2F7l3bf1Gh1r8DboR8azturYmYTy/C0BMlOIy4WFUAN32/s8
         dbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758614432; x=1759219232;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfPpe/or52X+zhVBTtpPVXU4FPPLcpy3HAsFtg+RRoE=;
        b=AWF53cHRtHcWMfgE0q1ugGmkFOGrDNvbCfdozI67XqSjN/Suw2F4iEKk+um0uCydn/
         2Sbw8UTa9fC3G2VyH3+yZ738VIj5F/2QI/PstlhwcWOgYSri1wPN7/U6CXlmQI054ktL
         Qsr4Dn2lzpErsTtVcPuDH+P93Q4LPdwALVvPOUKYe+LJ2N90S0NQgVVmOvBmK0hdfFsy
         AQtb4M3zwz4cyAs+Ey+fxxiEnNG+n4qN3ubHxe6v5YGwDZtXMD8T6W1+7kterj5PvGEc
         V2TYdf5Y4TRFdGk5Kc1Fd+s5fhhfnWjtni0EVK1ZqQSNwqEoI0o0PBoEr8Iu6Ha55e+e
         FZZA==
X-Gm-Message-State: AOJu0Yzz8y6docxjWQBiIBzenxo4439W0wpGBy5m8EAXFWxzAihz2WRB
	HofyMCWpZZBoZ+CPbBBV28iOWsV3jn2Y0C2FSh2B8PP1WOjNtRDj/9VFHv+ZqSkjvJo=
X-Gm-Gg: ASbGncsEg5aQvvk8fYhIYAJ7H8pZzgi5RuD1ZPTaSjmhpiGJZPP36zeS4NSNchcUZ+7
	keI2R2F3+OuJnrg2IEYh4Mh/1LE5e8VUXNvQpEoM4yz0sIhIS1Cs0q9IIbEzI8k0UMZj+gFgLqe
	ZFTdTtfowlO9aDm0Q9OJLlwKgX0ZUD8lssJIiOmm8rQwzvMNJCxUqYm39KfN2hBJjeqnX0Pj/w8
	4rlkHXuh3mZrTYLjiFjLr/cV6OYi//1REWoiAp8CjepFc+OI1fUR/3Wb5dTYPO9MDk8UXQdZKZ6
	zdVIDqEc/Fx0qZYGj/GjcRsXInsj6/aJcIkMLhmVLnhyU9kTTqpzhnxc6IRQA3tc1FDmApgpL+O
	SMf9sG3tI6xAmnkr8lZsfzAdFXoA4
X-Google-Smtp-Source: AGHT+IEKEkfWWbkjde1dOLE+bL8O2HdDTlJTveliJYNiQVNvNq33H56qNuF9DYreJIpAj1wty36YjQ==
X-Received: by 2002:a05:600c:4fc7:b0:45f:286e:49a8 with SMTP id 5b1f17b1804b1-46e1e0564famr16811235e9.30.1758614431906;
        Tue, 23 Sep 2025 01:00:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-464f5a285efsm262577465e9.18.2025.09.23.01.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:00:28 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:00:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: mt7996: Set proper link destination address
 in mt7996_tx()
Message-ID: <aNJTl89jpYob5XaR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Lorenzo Bianconi,

Commit f940c9b7aef6 ("wifi: mt76: mt7996: Set proper link destination
address in mt7996_tx()") from Jul 31, 2025 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7996/main.c:1344 mt7996_tx()
	error: testing array offset 'link_id' after use.

drivers/net/wireless/mediatek/mt76/mt7996/main.c
    1288 static void mt7996_tx(struct ieee80211_hw *hw,
    1289                       struct ieee80211_tx_control *control,
    1290                       struct sk_buff *skb)
    1291 {
    1292         struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
    1293         struct mt7996_dev *dev = mt7996_hw_dev(hw);
    1294         struct ieee80211_sta *sta = control->sta;
    1295         struct mt7996_sta *msta = sta ? (void *)sta->drv_priv : NULL;
    1296         struct mt76_phy *mphy = hw->priv;
    1297         struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
    1298         struct ieee80211_vif *vif = info->control.vif;
    1299         struct mt7996_vif *mvif = vif ? (void *)vif->drv_priv : NULL;
    1300         struct mt76_wcid *wcid = &dev->mt76.global_wcid;
    1301         u8 link_id = u32_get_bits(info->control.flags,
    1302                                   IEEE80211_TX_CTRL_MLO_LINK);
    1303 
    1304         rcu_read_lock();
    1305 
    1306         /* Use primary link_id if the value from mac80211 is set to
    1307          * IEEE80211_LINK_UNSPECIFIED.
    1308          */
    1309         if (link_id == IEEE80211_LINK_UNSPECIFIED) {
    1310                 if (msta)
    1311                         link_id = msta->deflink_id;
    1312                 else if (mvif)
    1313                         link_id = mvif->mt76.deflink_id;

Can link_id be IEEE80211_LINK_UNSPECIFIED after this if statement?

    1314         }
    1315 
    1316         if (vif && ieee80211_vif_is_mld(vif)) {
    1317                 struct ieee80211_bss_conf *link_conf;
    1318 
    1319                 if (msta) {
    1320                         struct ieee80211_link_sta *link_sta;
    1321 
    1322                         link_sta = rcu_dereference(sta->link[link_id]);

Some unchecked uses.  IEEE80211_LINK_UNSPECIFIED would be off-by-one.

    1323                         if (!link_sta)
    1324                                 link_sta = rcu_dereference(sta->link[msta->deflink_id]);
    1325 
    1326                         if (link_sta) {
    1327                                 memcpy(hdr->addr1, link_sta->addr, ETH_ALEN);
    1328                                 if (ether_addr_equal(sta->addr, hdr->addr3))
    1329                                         memcpy(hdr->addr3, link_sta->addr, ETH_ALEN);
    1330                         }
    1331                 }
    1332 
    1333                 link_conf = rcu_dereference(vif->link_conf[link_id]);

Here too.

    1334                 if (link_conf) {
    1335                         memcpy(hdr->addr2, link_conf->addr, ETH_ALEN);
    1336                         if (ether_addr_equal(vif->addr, hdr->addr3))
    1337                                 memcpy(hdr->addr3, link_conf->addr, ETH_ALEN);
    1338                 }
    1339         }
    1340 
    1341         if (mvif) {
    1342                 struct mt76_vif_link *mlink = &mvif->deflink.mt76;
    1343 
--> 1344                 if (link_id < IEEE80211_LINK_UNSPECIFIED)

Is this checker required?

    1345                         mlink = rcu_dereference(mvif->mt76.link[link_id]);
    1346 
    1347                 if (mlink->wcid)
    1348                         wcid = mlink->wcid;
    1349 
    1350                 if (mvif->mt76.roc_phy &&
    1351                     (info->flags & IEEE80211_TX_CTL_TX_OFFCHAN)) {
    1352                         mphy = mvif->mt76.roc_phy;
    1353                         if (mphy->roc_link)
    1354                                 wcid = mphy->roc_link->wcid;
    1355                 } else {
    1356                         mphy = mt76_vif_link_phy(mlink);
    1357                 }
    1358         }
    1359 
    1360         if (!mphy) {
    1361                 ieee80211_free_txskb(hw, skb);
    1362                 goto unlock;
    1363         }
    1364 
    1365         if (msta && link_id < IEEE80211_LINK_UNSPECIFIED) {

And this?

    1366                 struct mt7996_sta_link *msta_link;
    1367 
    1368                 msta_link = rcu_dereference(msta->link[link_id]);
    1369                 if (msta_link)
    1370                         wcid = &msta_link->wcid;
    1371         }
    1372         mt76_tx(mphy, control->sta, wcid, skb);
    1373 unlock:
    1374         rcu_read_unlock();
    1375 }

regards,
dan carpenter

