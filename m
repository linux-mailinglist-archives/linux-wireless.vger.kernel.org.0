Return-Path: <linux-wireless+bounces-17736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEED7A16998
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6906E3A9A08
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8811CCEDB;
	Mon, 20 Jan 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tce4eONn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4964149DF0
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365223; cv=none; b=Lamr1tIeeOrgjfDw5ZdIm+Gz1tettxh2Bs6ka2c/d0ktimzCriACy/IVCJSwMpihX6Gya6pt1WrkTOOIObF2XtSECbIp0DHzDKszRQxGEFMLZmpzudYqwtOfWoVe4PpvgnZBHsWXcJDXMsjBK9TZDBMyICCQTr5+dbNgvmIrzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365223; c=relaxed/simple;
	bh=QHxDocMx29bJDaXV/xcilMtjX1C0iht1PKP6txBmVJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RB3FRLQvuSFM4Q2obhvzwsMU2zqx/MNJuJs7UgDCOPSAhUQT9mnrb9UBqFGwMmldE6thdaZwBcZpMcn36ICpY+W6G7MDOWgmpowO33F0TMlr7e+kQuP5PrY0QCCCEQap3UbELMBIyLZ+LK8CBFUbKdmJb7q0Llfpl++PbvnroAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tce4eONn; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a88ba968aso3868707f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 01:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737365220; x=1737970020; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xmYZF3aY3IGdwvZxAqaP4zRoLJKQUo9DuM2QltNNDDU=;
        b=Tce4eONnMdZbkt3OCoUsnqCpq3eifouDp4YO7SN3YNDkIRydD/vRaP8UVaGVg1XbXq
         qP50FIR0FeBlyqL9TyLpbWuvWf7XP/+qxfEfBW27fGv4NrzEHumSvESGdOtZvsDxQqvj
         oEUTs72XPsRKmHWYYKhOfO6iyAMJpiCI435+brwLAmgV7+QRxCVUQsgx1zwYNelBdrb3
         TdBgGnqQqVOGLn73MaS8xboneDXuobBppYQnXbxAvFGW5fRBXncsDXh4dQv91i1puusY
         Ni0l86fvyzRqUmCvEer75lK9j2zdJ7B7j4nbja3pIizdj6xTq9rD4QOq/jnpXryENMjk
         Znqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737365220; x=1737970020;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xmYZF3aY3IGdwvZxAqaP4zRoLJKQUo9DuM2QltNNDDU=;
        b=MNJqbSuWPMagvpm9cxUyQjn6zWSE9V9kcYeUcT0u/rUrnMwem+MWC1Ve5KZ90lnYuQ
         kfeMHeQEYOPeMLuUMrk3mMjlRhAe5n9GBa4YJ7vKP0Ai35kNdipJsJ2AZn8miicF+Dwd
         qxfk26SzcWEwFYFNOZSEYH8WyG194bzfcet4In/CLtknZYyCL2m517U4x8Ig5TkWXJAm
         J5HzPvvIKF1EPFm0JEVxjmG2oUVSeDbiVj6c2gOLg5hDIk2z6LKLqD/NmOcYHYViHFTK
         DbE7Lcz4Y1et3AQxSe/HwV7XgcjZ/+2MH60n649bSwjH6CT8nz3keDpV+FxD2UBYtL8O
         HPSQ==
X-Gm-Message-State: AOJu0YxVzKDZzhWk2jqUvKgtr6FK+NlrF/Bs3mrn3iQcO0TOkcEvznG8
	MIKaWEeX+8M/RQE2Fb31e+wpv7SCh7Siyxs1iST//2ncetNflPuPUJMQEzyiAy8=
X-Gm-Gg: ASbGnctmi9eH6JiDze2Duy/or+0aItsrdsoxtHtgu7YQ1avNCGckw6fAySLDAOXuD4T
	S2EBkq9NXAAczntiXpA8TtWj4EurNIw+6IxRVeHzzmIOq72iy16xJd+f9UlnG99SLpQWpxkipkf
	am7ifJIN85YwDIYPayQCGl5sMstq2A8dxZ6zgSB45rv4CfMuH17FbeHWqzBXW3SK8zWRC4DyHmn
	IFrkXPkmDCJnDohwjOMljvI6chttaIxkLYmNW+Nw7QYvB/ht+wAy11t/4LTp0C1Se/Ezef5kBA=
X-Google-Smtp-Source: AGHT+IEVRfdM1hjC3nGZZpvEdm6bzTgZFb7R/65Me2vRHosAaz6iorR5ffRyvaw1YPc15jH9CgTzcA==
X-Received: by 2002:a05:6000:2a6:b0:385:eb7c:5d0f with SMTP id ffacd0b85a97d-38bf566a239mr11066302f8f.26.1737365219788;
        Mon, 20 Jan 2025 01:26:59 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf32755f0sm9891123f8f.76.2025.01.20.01.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:26:59 -0800 (PST)
Date: Mon, 20 Jan 2025 12:26:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: connac: rework connac helpers
Message-ID: <e8b8790f-e828-44ee-8389-68f82bc1b099@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shayne Chen,

Commit a0facfc80ec1 ("wifi: mt76: connac: rework connac helpers")
from Jan 2, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c:588 mt76_connac2_mac_write_txwi()
	error: we previously assumed 'vif' could be null (see line 510)

drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
   492  void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
   493                                   struct sk_buff *skb, struct mt76_wcid *wcid,
   494                                   struct ieee80211_key_conf *key, int pid,
   495                                   enum mt76_txq_id qid, u32 changed)
   496  {
   497          struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
   498          u8 phy_idx = (info->hw_queue & MT_TX_HW_QUEUE_PHY) >> 2;
   499          struct ieee80211_vif *vif = info->control.vif;
   500          struct mt76_phy *mphy = &dev->phy;
   501          u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0, band_idx = 0;
   502          u32 val, sz_txd = mt76_is_mmio(dev) ? MT_TXD_SIZE : MT_SDIO_TXD_SIZE;
   503          bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
   504          bool beacon = !!(changed & (BSS_CHANGED_BEACON |
   505                                      BSS_CHANGED_BEACON_ENABLED));
   506          bool inband_disc = !!(changed & (BSS_CHANGED_UNSOL_BCAST_PROBE_RESP |
   507                                           BSS_CHANGED_FILS_DISCOVERY));
   508          bool amsdu_en = wcid->amsdu;
   509  
   510          if (vif) {
                    ^^^
This code assumes the "vif" can be NULL.

   511                  struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
   512  
   513                  omac_idx = mvif->omac_idx;
   514                  wmm_idx = mvif->wmm_idx;
   515                  band_idx = mvif->band_idx;
   516          }
   517  
   518          if (phy_idx && dev->phys[MT_BAND1])
   519                  mphy = dev->phys[MT_BAND1];
   520  
   521          if (inband_disc) {
   522                  p_fmt = MT_TX_TYPE_FW;
   523                  q_idx = MT_LMAC_ALTX0;
   524          } else if (beacon) {
   525                  p_fmt = MT_TX_TYPE_FW;
   526                  q_idx = MT_LMAC_BCN0;
   527          } else if (qid >= MT_TXQ_PSD) {
   528                  p_fmt = mt76_is_mmio(dev) ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
   529                  q_idx = MT_LMAC_ALTX0;
   530          } else {
   531                  p_fmt = mt76_is_mmio(dev) ? MT_TX_TYPE_CT : MT_TX_TYPE_SF;
   532                  q_idx = wmm_idx * MT76_CONNAC_MAX_WMM_SETS +
   533                          mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
   534  
   535                  /* mt7915 WA only counts WED path */
   536                  if (is_mt7915(dev) && mtk_wed_device_active(&dev->mmio.wed))
   537                          wcid->stats.tx_packets++;
   538          }
   539  
   540          val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
   541                FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
   542                FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
   543          txwi[0] = cpu_to_le32(val);
   544  
   545          val = MT_TXD1_LONG_FORMAT |
   546                FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
   547                FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
   548          if (!is_mt7921(dev))
   549                  val |= MT_TXD1_VTA;
   550          if (phy_idx || band_idx)
   551                  val |= MT_TXD1_TGID;
   552  
   553          txwi[1] = cpu_to_le32(val);
   554          txwi[2] = 0;
   555  
   556          val = FIELD_PREP(MT_TXD3_REM_TX_COUNT, 15);
   557          if (!is_mt7921(dev))
   558                  val |= MT_TXD3_SW_POWER_MGMT;
   559          if (key)
   560                  val |= MT_TXD3_PROTECT_FRAME;
   561          if (info->flags & IEEE80211_TX_CTL_NO_ACK)
   562                  val |= MT_TXD3_NO_ACK;
   563  
   564          txwi[3] = cpu_to_le32(val);
   565          txwi[4] = 0;
   566  
   567          val = FIELD_PREP(MT_TXD5_PID, pid);
   568          if (pid >= MT_PACKET_ID_FIRST) {
   569                  val |= MT_TXD5_TX_STATUS_HOST;
   570                  amsdu_en = 0;
   571          }
   572  
   573          txwi[5] = cpu_to_le32(val);
   574          txwi[6] = 0;
   575          txwi[7] = amsdu_en ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
   576  
   577          if (is_8023)
   578                  mt76_connac2_mac_write_txwi_8023(txwi, skb, wcid);
   579          else
   580                  mt76_connac2_mac_write_txwi_80211(dev, txwi, skb, key);
   581  
   582          if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
   583                  /* Fixed rata is available just for 802.11 txd */
   584                  struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
   585                  bool multicast = ieee80211_is_data(hdr->frame_control) &&
   586                                   is_multicast_ether_addr(hdr->addr1);
   587                  u16 rate = mt76_connac2_mac_tx_rate_val(mphy, &vif->bss_conf, beacon,
                                                                      ^^^^^^^^^^^^^^
This code dereferences vif without checking.  Technically the
mt76_connac2_mac_tx_rate_val() has a NULL check but it doesn't work
because the address of &vif->bss_conf can't be NULL since it's in the
middle of the struct.

   588                                                          multicast);
   589                  u32 val = MT_TXD6_FIXED_BW;
   590  
   591                  /* hardware won't add HTC for mgmt/ctrl frame */
   592                  txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
   593  
   594                  val |= FIELD_PREP(MT_TXD6_TX_RATE, rate);
   595                  txwi[6] |= cpu_to_le32(val);
   596                  txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
   597  
   598                  if (!is_mt7921(dev)) {
   599                          u8 spe_idx = mt76_connac_spe_idx(mphy->antenna_mask);
   600  
   601                          if (!spe_idx)
   602                                  spe_idx = 24 + phy_idx;
   603                          txwi[7] |= cpu_to_le32(FIELD_PREP(MT_TXD7_SPE_IDX, spe_idx));
   604                  }
   605  
   606                  txwi[7] &= ~cpu_to_le32(MT_TXD7_HW_AMSDU);
   607          }
   608  }


regards,
dan carpenter

