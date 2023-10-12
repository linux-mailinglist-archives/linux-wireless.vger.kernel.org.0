Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98197C69E5
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjJLJnQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 05:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjJLJnP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 05:43:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FFF91
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 02:43:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so7760905e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697103792; x=1697708592; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VRMgvCnEA8kgiHSYk2SxnRT5MMPGrktxGH8s2RgpHQ=;
        b=anyCJxxsFnecTDNZcbFd49ECWSKtVyfMfhuY339SqGie1lhunFFWEoqs8MLJ6fr+pv
         cU/aXPfl/cTAVOhrlQM0+NSSSijB4CAryyy/QMOzEBd3LLKfNHw7XBsxOi+gI24bJWXg
         h1LTGxRSwY0ehgXY1A2wQjSVySl9B7Qg274UpzA3Kz49tTztZ4Ew1ve+SY5GD4+63itM
         LKTdv6KoOHnf1xo+B0qzFJVYMNBkAw2KXOrmc93JTfj8xFCngSS5V76jRFxh/m7eF/2v
         3yTxO79P7DOLfvc1wNmgAKY45eyO0fmW614JNsR7lCvoRGWheYcRm754fxe7vwIw/a6U
         huTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103792; x=1697708592;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VRMgvCnEA8kgiHSYk2SxnRT5MMPGrktxGH8s2RgpHQ=;
        b=UWywjRBsqLlEDEUq9MPyAqNWVBKvaX9kir5URrVGk/jiPluELcLGIG2lKXxydRxWHA
         Wck9R9s0sQi63SBOZY4AQttjWYOSrLM12IM2kB/j7MkdKzY2E8kvhwYzZCNfhOTUOmTI
         jy0UDHBALpG1w5HP81O9ZIye82Yv4f4074tchO+67lIZe34wvaZnnRsMm57yx8hB+XD0
         Ops1R92acfXLPVAHzLGn6aWhR/MATbeiks1IeOdoAk0LP0zrH5VQsty0KVKodazqzLm6
         FVj4dNbLmTVVG4a4wNf8W9SKGmczbY49zYRgBBng2sywLIToSzpxjXG5nJRzRJ0eaqk5
         LCRw==
X-Gm-Message-State: AOJu0YzHs9ra6pSrBt/vfSalohygsBAZZsTiXUsny0Jwp2ITkwwIOCOD
        HXqRdzD/X9sLNXO//RA3vZcLSZLGSD2UOhyCh3w=
X-Google-Smtp-Source: AGHT+IHCwgBj3x6+SrOcE0hptJkfx2cSC4duQpC3JPxcT2Y6Xd5RJTwKY8iaIIwurvg/O0MkOUlW+Q==
X-Received: by 2002:a05:6000:104a:b0:32d:8b1a:31ad with SMTP id c10-20020a056000104a00b0032d8b1a31admr2201712wrx.24.1697103792493;
        Thu, 12 Oct 2023 02:43:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w15-20020adfcd0f000000b0030647449730sm18076443wrm.74.2023.10.12.02.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:43:12 -0700 (PDT)
Date:   Thu, 12 Oct 2023 12:43:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: fix race condition related to checking tx
 queue fill status
Message-ID: <4af93047-2767-4859-b41f-82be7fa2309d@moroto.mountain>
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

Hello Felix Fietkau,

The patch 0335c034e726: "wifi: mt76: fix race condition related to
checking tx queue fill status" from Aug 29, 2023 (linux-next), leads
to the following Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/tx.c:348 mt76_tx()
	error: we previously assumed 'wcid' could be null (see line 342)

drivers/net/wireless/mediatek/mt76/tx.c
    338 
    339         if (WARN_ON(skb_get_queue_mapping(skb) >= MT_TXQ_PSD))
    340                 skb_set_queue_mapping(skb, MT_TXQ_BE);
    341 
    342         if (wcid && !(wcid->tx_info & MT_WCID_TX_INFO_SET))
                    ^^^^
This assumes wcid can be NULL

    343                 ieee80211_get_tx_rates(info->control.vif, sta, skb,
    344                                        info->control.rates, 1);
    345 
    346         info->hw_queue |= FIELD_PREP(MT_TX_HW_QUEUE_PHY, phy->band_idx);
    347 
--> 348         spin_lock_bh(&wcid->tx_pending.lock);
                             ^^^^^^^
Unchecked dereference

    349         __skb_queue_tail(&wcid->tx_pending, skb);
    350         spin_unlock_bh(&wcid->tx_pending.lock);
    351 
    352         spin_lock_bh(&phy->tx_lock);
    353         if (list_empty(&wcid->tx_list))
    354                 list_add_tail(&wcid->tx_list, &phy->tx_list);
    355         spin_unlock_bh(&phy->tx_lock);
    356 
    357         mt76_worker_schedule(&phy->dev->tx_worker);
    358 }

regards,
dan carpenter
