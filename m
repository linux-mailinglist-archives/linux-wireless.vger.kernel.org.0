Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2E17C69E6
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbjJLJn2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjJLJn0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 05:43:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A04B7
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 02:43:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so1064532e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697103803; x=1697708603; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ev4LIOcPBHb3dZB/MpdIQpGNibYTwjPMmscB5eDijmM=;
        b=tKdHXeDLNx0Zpro8BJZ4zHToWiPPwmG78ldbA2ajRaVNYTXFXBoi4R+aBx4KiWxQ3U
         ZTbzHzbug2zh1Huvhf10AIjno2xJWei4o5hTlilfG/k3YsQiyCOaTLSjbgZUDnbR77my
         qzSUZvJYEPAAlJWYH6JoyvTpHFpzJifPmKOSl6IAK6RkA0VEQnILBviBfILEnXPJUx6G
         SIMg7wq35cctGCvejXi7EifD2I1P9cxaIKDbGWDDmWxV/2LnZWOj9dTfj+wmuyPP/JKu
         kID556EZ9/cWSbc39LuUY5iXdUywZs7H3usN4eW1H5UjgSEXeraHoVuLqAAA92f3aAQ3
         YQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103803; x=1697708603;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ev4LIOcPBHb3dZB/MpdIQpGNibYTwjPMmscB5eDijmM=;
        b=St5MOqs8on9S8HWOWbmIq8AvPGSrj/RUnFD3SrFbRaIE9DBXZjD70WhsjhNBqNptEX
         lMrtP+FyxrfeN5yC26OwqwViKFoGgqgy3FJWnCZ0IoRD0FInSI4BrgkkDLNg+A4q7wOg
         avJAbqwXLGCsbJbOj/wyC+sW7lZARoO/HEiNavk0rqhCoYT4fQZO1lW3TMgo01slspjd
         q0eX57HYk456SrhFv3UsYf+NyyDKq6FbZVZadlZu1IUYzb83zBlA+5rRYdWNaeeGz0lA
         JvrDoG18tv4hqEjBTLgor6WhI9+kJuaD1lUP40Dt/IxoQOsYZofGHdkpYMfIqzys9BiO
         I5JQ==
X-Gm-Message-State: AOJu0Yzj6XWyyTPtDYpTxU9KDuhpLDdd8wYGeGY4iaq1BTFSAhOts6p6
        U96tbT+6qwaEqy20ltHehbsnZQ==
X-Google-Smtp-Source: AGHT+IFdy4xiMItgwXPE78wsSzqRNEoOOAX+Tw3dvj2Do2sVc/I4a1Ayw2fXFbHUIafCkVWCPMe3IQ==
X-Received: by 2002:a19:ee0e:0:b0:4f9:6842:afc with SMTP id g14-20020a19ee0e000000b004f968420afcmr17754005lfb.64.1697103802659;
        Thu, 12 Oct 2023 02:43:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b0040596352951sm21500897wmj.5.2023.10.12.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:43:22 -0700 (PDT)
Date:   Thu, 12 Oct 2023 12:43:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     yi-chia.hsieh@mediatek.com
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: mt7996: get tx_retries and tx_failed from
 txfree
Message-ID: <1a35373d-0d71-4564-af86-e95f0ffb7312@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Yi-Chia Hsieh,

The patch 2461599f835e: "wifi: mt76: mt7996: get tx_retries and
tx_failed from txfree" from Sep 21, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1130 mt7996_mac_tx_free()
	error: uninitialized symbol 'wcid'.

drivers/net/wireless/mediatek/mt76/mt7996/mac.c
    1068 static void
    1069 mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
    1070 {
    1071         __le32 *tx_free = (__le32 *)data, *cur_info;
    1072         struct mt76_dev *mdev = &dev->mt76;
    1073         struct mt76_phy *phy2 = mdev->phys[MT_BAND1];
    1074         struct mt76_phy *phy3 = mdev->phys[MT_BAND2];
    1075         struct mt76_txwi_cache *txwi;
    1076         struct ieee80211_sta *sta = NULL;
    1077         struct mt76_wcid *wcid;
    1078         LIST_HEAD(free_list);
    1079         struct sk_buff *skb, *tmp;
    1080         void *end = data + len;
    1081         bool wake = false;
    1082         u16 total, count = 0;
    1083 
    1084         /* clean DMA queues and unmap buffers first */
    1085         mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
    1086         mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
    1087         if (phy2) {
    1088                 mt76_queue_tx_cleanup(dev, phy2->q_tx[MT_TXQ_PSD], false);
    1089                 mt76_queue_tx_cleanup(dev, phy2->q_tx[MT_TXQ_BE], false);
    1090         }
    1091         if (phy3) {
    1092                 mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_PSD], false);
    1093                 mt76_queue_tx_cleanup(dev, phy3->q_tx[MT_TXQ_BE], false);
    1094         }
    1095 
    1096         if (WARN_ON_ONCE(le32_get_bits(tx_free[1], MT_TXFREE1_VER) < 5))
    1097                 return;
    1098 
    1099         total = le32_get_bits(tx_free[0], MT_TXFREE0_MSDU_CNT);
    1100         for (cur_info = &tx_free[2]; count < total; cur_info++) {
    1101                 u32 msdu, info;
    1102                 u8 i;
    1103 
    1104                 if (WARN_ON_ONCE((void *)cur_info >= end))
    1105                         return;
    1106                 /* 1'b1: new wcid pair.
    1107                  * 1'b0: msdu_id with the same 'wcid pair' as above.
    1108                  */
    1109                 info = le32_to_cpu(*cur_info);
    1110                 if (info & MT_TXFREE_INFO_PAIR) {
    1111                         struct mt7996_sta *msta;
    1112                         u16 idx;
    1113 
    1114                         idx = FIELD_GET(MT_TXFREE_INFO_WLAN_ID, info);
    1115                         wcid = rcu_dereference(dev->mt76.wcid[idx]);

Initialized here

    1116                         sta = wcid_to_sta(wcid);
    1117                         if (!sta)
    1118                                 continue;
    1119 
    1120                         msta = container_of(wcid, struct mt7996_sta, wcid);
    1121                         spin_lock_bh(&mdev->sta_poll_lock);
    1122                         if (list_empty(&msta->wcid.poll_list))
    1123                                 list_add_tail(&msta->wcid.poll_list,
    1124                                               &mdev->sta_poll_list);
    1125                         spin_unlock_bh(&mdev->sta_poll_lock);
    1126                         continue;
    1127                 } else if (info & MT_TXFREE_INFO_HEADER) {
    1128                         u32 tx_retries = 0, tx_failed = 0;
    1129 
--> 1130                         if (!wcid)

Uninitialized on first iteration

    1131                                 continue;
    1132 
    1133                         tx_retries =
    1134                                 FIELD_GET(MT_TXFREE_INFO_COUNT, info) - 1;
    1135                         tx_failed = tx_retries +
    1136                                 !!FIELD_GET(MT_TXFREE_INFO_STAT, info);
    1137 
    1138                         wcid->stats.tx_retries += tx_retries;
    1139                         wcid->stats.tx_failed += tx_failed;
    1140                         continue;
    1141                 }
    1142 
    1143                 for (i = 0; i < 2; i++) {
    1144                         msdu = (info >> (15 * i)) & MT_TXFREE_INFO_MSDU_ID;
    1145                         if (msdu == MT_TXFREE_INFO_MSDU_ID)
    1146                                 continue;
    1147 
    1148                         count++;
    1149                         txwi = mt76_token_release(mdev, msdu, &wake);
    1150                         if (!txwi)
    1151                                 continue;
    1152 
    1153                         mt7996_txwi_free(dev, txwi, sta, &free_list);
    1154                 }
    1155         }
    1156 
    1157         mt7996_mac_sta_poll(dev);
    1158 
    1159         if (wake)
    1160                 mt76_set_tx_blocked(&dev->mt76, false);
    1161 
    1162         mt76_worker_schedule(&dev->mt76.tx_worker);
    1163 
    1164         list_for_each_entry_safe(skb, tmp, &free_list, list) {
    1165                 skb_list_del_init(skb);
    1166                 napi_consume_skb(skb, 1);
    1167         }
    1168 }

regards,
dan carpenter
