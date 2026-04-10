Return-Path: <linux-wireless+bounces-34574-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJTqAyrP2GngiQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34574-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:21:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC333D5990
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0A693004621
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 10:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC9C332608;
	Fri, 10 Apr 2026 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5BIbt5w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC2F38228D
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816022; cv=none; b=cp028MadsuiN0gBgO/XZOytkhLfAH6RanPz0q2LO7bK66GeK+Zu6zf1bsQimSpY/F/wxL2eCTA21aWqM4sbboUHXTO7rPTspESRY6GYea/WjhgaLLLNeS+U/Q72SwBD5/QtnxOKBhupLeklFkj0kxyclzQXgR3iAqu77AYhtoK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816022; c=relaxed/simple;
	bh=3hN7KPxTlCsbSILsewOQ/ykUheRZtZQ3Rn/0qROUGIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VLyMcsgitwmQpS4WeZ/ytvdoRg9ytijjGRZ+GjylqdkTkzdAzKykBv6Z4ndQxpPx9UpiilgKgRnjB8yV9NLQBx79uVHJlQyL5G4zsIIdHbN+l+OxN3MUIgjoaL9hcih8n/oy1xymkKPi+IRqYcXNIHc+q6Kwr4K68+bocNtT5q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5BIbt5w; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so11991625e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775816019; x=1776420819; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qARg06qVMz9+DLd38HAj11nvFT4m9He5ePu4KsCy86E=;
        b=p5BIbt5wQkS7D2MFi1N1GnQ4U+ZYQm866EL1LjfouKStfmbSmP3UTsVBXMJYbs3iYv
         ioVgcwGLY5nnm80Qe4CbjaFopPi5T75Ir8WgyRKYWqGk/hPrOrzDXiFF0pTD4tP2hw2+
         tiBBt/EjJvgZRwfyCSwm7ZSQNSa+USxeTaizPSaDic7Y2+iHIXyfclpZJmPDjCS2LIHP
         e8JNUIWQyzwnBI9Tqm9OhQG3/0eXOnqrLCRjYiyMUkcKNAM/ecj2lQPG/XaiZZQFmchQ
         MavpuRrpyRXElKdMBzrk0MV4DsjYm9jd4ggitkkIKitFV8TiaGzL+ikFoDxDrKSCJUEs
         wevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775816019; x=1776420819;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qARg06qVMz9+DLd38HAj11nvFT4m9He5ePu4KsCy86E=;
        b=O2TdB2/vvxVKVe+/3Kl5f8w/6iYozf/7PMW1Jzpw7t07SAs05CMMr5j2Z4zga/862t
         v5L6S1YrcN3g8QUF0ytCMa1abASYzbCxlmxkORTxNcigKg+8qfh1JVyQw30IzntnZpB5
         eGmGyfeIAkKspDxW/aYOF3UThFCYMoPWQFLOt/9TDSmsuj+wRocKOO7JDuAhd82t8q9C
         meHnK9/cli4aCyUSLnS7hT8TvEyevg9SLE/oqBiS8zYyLm/pvn0BJKTnPmRTZ0mVpT6v
         /oEFES9mUCY/IGN+3b4fh1uE+ejxzl2Xtv/ymexdfO9rzO35zBYSGh3Hs34cdOK7Xj17
         W4fQ==
X-Gm-Message-State: AOJu0Yz8uAiT95g/nJJsTk/QZciFjyWPAGLxBjKzrNUqtt9zxvFsQYt4
	dDGnGU4+EQCLCLs9/meojeO141FztLVRDBycDkCUeyn+nSkCo63k5V33
X-Gm-Gg: AeBDievip+/Y41JexDwAyknqXNkDjNO18Gc722hNMI9akTPREaOTvobPSm/bofuz8TZ
	fOgdPMYiCkmvUVSIUqo2sEd2d/X/prhAi46g9p17vU2t0f1wjB+HLiDehlGvATgRnBGuZAVISZB
	RN+hmtBBL411RRDwxr6/TEGGaLXQ/jc7xlgDFgHuJ1IzIxot1FXMlk9XNnDwf6EkwnAEtQME4eq
	FQVHCaTMNVrOL0jd18XRwYHB4oLbPnUc2UyaOtwOEy686XR9yP2O4ni6OUu38IfU3p58a5Kb487
	sAlXOfnYuSoKBIbXqv57lVXLpjpnA6XdOCG+7UoOGm+pc6ZNUJbEc6GRa0Bk6iEJWaEc+CGsK9X
	xroAkzjOUVrTz4K6u4/tGcNCyHG/nCqUbNvSjgnbFirpyIut4exyAfpUwypAP/qyyAE+7wfsRHQ
	VgIFRBqyo2px0+4+cym7I=
X-Received: by 2002:a05:600c:3ba4:b0:488:c6e9:1e0c with SMTP id 5b1f17b1804b1-488d6847de9mr28556345e9.5.1775816019154;
        Fri, 10 Apr 2026 03:13:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm6388557f8f.33.2026.04.10.03.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:13:38 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:13:35 +0300
From: Dan Carpenter <error27@gmail.com>
To: Sean Wang <sean.wang@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: mt7921: handle MT7902 irq_map quirk with
 mutable copy
Message-ID: <adjNTwO_ziI9eLWU@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34574-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 6BC333D5990
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Sean Wang,

Commit 222606f43b58 ("wifi: mt76: mt7921: handle MT7902 irq_map quirk
with mutable copy") from Feb 18, 2026 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7921/pci.c:363 mt7921_pci_probe()
	warn: missing unwind goto?

drivers/net/wireless/mediatek/mt76/mt7921/pci.c
    258 static int mt7921_pci_probe(struct pci_dev *pdev,
    259                             const struct pci_device_id *id)
    260 {
    261         static const struct mt76_driver_ops drv_ops = {
    262                 /* txwi_size = txd size + txp size */
    263                 .txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_hw_txp),
    264                 .drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
    265                              MT_DRV_AMSDU_OFFLOAD,
    266                 .survey_flags = SURVEY_INFO_TIME_TX |
    267                                 SURVEY_INFO_TIME_RX |
    268                                 SURVEY_INFO_TIME_BSS_RX,
    269                 .token_size = MT7921_TOKEN_SIZE,
    270                 .tx_prepare_skb = mt7921e_tx_prepare_skb,
    271                 .tx_complete_skb = mt76_connac_tx_complete_skb,
    272                 .rx_check = mt7921_rx_check,
    273                 .rx_skb = mt7921_queue_rx_skb,
    274                 .rx_poll_complete = mt792x_rx_poll_complete,
    275                 .sta_add = mt7921_mac_sta_add,
    276                 .sta_event = mt7921_mac_sta_event,
    277                 .sta_remove = mt7921_mac_sta_remove,
    278                 .update_survey = mt792x_update_channel,
    279                 .set_channel = mt7921_set_channel,
    280         };
    281         static const struct mt792x_hif_ops mt7921_pcie_ops = {
    282                 .init_reset = mt7921e_init_reset,
    283                 .reset = mt7921e_mac_reset,
    284                 .mcu_init = mt7921e_mcu_init,
    285                 .drv_own = mt792xe_mcu_drv_pmctrl,
    286                 .fw_own = mt792xe_mcu_fw_pmctrl,
    287         };
    288         static const struct mt792x_irq_map irq_map = {
    289                 .host_irq_enable = MT_WFDMA0_HOST_INT_ENA,
    290                 .tx = {
    291                         .all_complete_mask = MT_INT_TX_DONE_ALL,
    292                         .mcu_complete_mask = MT_INT_TX_DONE_MCU,
    293                 },
    294                 .rx = {
    295                         .data_complete_mask = MT_INT_RX_DONE_DATA,
    296                         .wm_complete_mask = MT_INT_RX_DONE_WM,
    297                         .wm2_complete_mask = MT_INT_RX_DONE_WM2,
    298                 },
    299         };
    300         struct ieee80211_ops *ops;
    301         struct mt76_bus_ops *bus_ops;
    302         struct mt792x_dev *dev;
    303         struct mt76_dev *mdev;
    304         void __iomem *regs;
    305         u16 cmd, chipid;
    306         u8 features;
    307         int ret;
    308 
    309         ret = pcim_enable_device(pdev);
    310         if (ret)
    311                 return ret;
    312 
    313         pci_read_config_word(pdev, PCI_COMMAND, &cmd);
    314         if (!(cmd & PCI_COMMAND_MEMORY)) {
    315                 cmd |= PCI_COMMAND_MEMORY;
    316                 pci_write_config_word(pdev, PCI_COMMAND, cmd);
    317         }
    318         pci_set_master(pdev);
    319 
    320         ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
    321         if (ret < 0)
    322                 return ret;
    323 
    324         ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
    325         if (ret)
    326                 goto err_free_pci_vec;
    327 
    328         if (mt7921_disable_aspm)
    329                 mt76_pci_disable_aspm(pdev);
    330 
    331         ops = mt792x_get_mac80211_ops(&pdev->dev, &mt7921_ops,
    332                                       (void *)id->driver_data, &features);
    333         if (!ops) {
    334                 ret = -ENOMEM;
    335                 goto err_free_pci_vec;
    336         }
    337 
    338         mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), ops, &drv_ops);
    339         if (!mdev) {
    340                 ret = -ENOMEM;
    341                 goto err_free_pci_vec;
    342         }
    343 
    344         pci_set_drvdata(pdev, mdev);
    345 
    346         regs =  pcim_iomap_region(pdev, 0, pci_name(pdev));
    347         if (IS_ERR(regs))
    348                 return PTR_ERR(regs);

Need to goto to err_free_pci_vec before returning

    349 
    350         dev = container_of(mdev, struct mt792x_dev, mt76);
    351         dev->fw_features = features;
    352         dev->hif_ops = &mt7921_pcie_ops;
    353         dev->irq_map = &irq_map;
    354         mt76_mmio_init(&dev->mt76, regs);
    355 
    356         if (id->device == 0x7902) {
    357                 struct mt792x_irq_map *map;
    358 
    359                 /* MT7902 needs a mutable copy because wm2_complete_mask differs */
    360                 map = devm_kmemdup(&pdev->dev, &irq_map,
    361                                    sizeof(irq_map), GFP_KERNEL);
    362                 if (!map)
--> 363                         return -ENOMEM;

Same.

    364 
    365                 map->rx.wm2_complete_mask = 0;
    366                 dev->irq_map = map;
    367         }
    368 
    369         tasklet_init(&mdev->irq_tasklet, mt792x_irq_tasklet, (unsigned long)dev);
    370 
    371         dev->phy.dev = dev;
    372         dev->phy.mt76 = &dev->mt76.phy;
    373         dev->mt76.phy.priv = &dev->phy;
    374         dev->bus_ops = dev->mt76.bus;
    375         bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
    376                                GFP_KERNEL);
    377         if (!bus_ops) {
    378                 ret = -ENOMEM;
    379                 goto err_free_dev;
    380         }
    381 
    382         bus_ops->rr = mt7921_rr;
    383         bus_ops->wr = mt7921_wr;
    384         bus_ops->rmw = mt7921_rmw;
    385         dev->mt76.bus = bus_ops;
    386 
    387         if (!mt7921_disable_aspm && mt76_pci_aspm_supported(pdev))
    388                 dev->aspm_supported = true;
    389 
    390         ret = mt792xe_mcu_fw_pmctrl(dev);
    391         if (ret)
    392                 goto err_free_dev;
    393 
    394         ret = __mt792xe_mcu_drv_pmctrl(dev);
    395         if (ret)
    396                 goto err_free_dev;
    397 
    398         chipid = mt7921_l1_rr(dev, MT_HW_CHIPID);
    399         if (chipid == 0x7961 && (mt7921_l1_rr(dev, MT_HW_BOUND) & BIT(7)))
    400                 chipid = 0x7920;
    401         mdev->rev = (chipid << 16) |
    402                     (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
    403         dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
    404 
    405         ret = mt792x_wfsys_reset(dev);
    406         if (ret)
    407                 goto err_free_dev;
    408 
    409         mt76_wr(dev, irq_map.host_irq_enable, 0);
    410 
    411         mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
    412 
    413         ret = devm_request_irq(mdev->dev, pdev->irq, mt792x_irq_handler,
    414                                IRQF_SHARED, KBUILD_MODNAME, dev);
    415         if (ret)
    416                 goto err_free_dev;
    417 
    418         ret = mt7921_dma_init(dev);
    419         if (ret)
    420                 goto err_free_irq;
    421 
    422         ret = mt7921_register_device(dev);
    423         if (ret)
    424                 goto err_free_irq;
    425 
    426         if (of_property_read_bool(dev->mt76.dev->of_node, "wakeup-source"))
    427                 device_init_wakeup(dev->mt76.dev, true);
    428 
    429         return 0;
    430 
    431 err_free_irq:
    432         devm_free_irq(&pdev->dev, pdev->irq, dev);
    433 err_free_dev:
    434         mt76_free_device(&dev->mt76);
    435 err_free_pci_vec:
    436         pci_free_irq_vectors(pdev);
    437 
    438         return ret;
    439 }

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

