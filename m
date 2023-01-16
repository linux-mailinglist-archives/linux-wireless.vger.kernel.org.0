Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA05466D018
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 21:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjAPUYp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 15:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjAPUYn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 15:24:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC6C241D4
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:42 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m7-20020a17090a730700b00225ebb9cd01so34931907pjk.3
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 12:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ekO/5E+sI7rrywBLWFcPeU6/uU3IUJDtpodEXrmlTs=;
        b=XJvUdQ4df94kt0lk8nbK57bGB+0tB8SnwaWc6FArsECYtbTqqJNsCmsBBFvvfGM82a
         JGmLMeszA68jBpeSH6Tnm3gCBTL5RZNCtPB6groKKD7ScnUkIc/zd9MKjEAjtVBESAp4
         LUGpZCIxLWaxVEzkhtAfgag/GVeF83LWbf1Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ekO/5E+sI7rrywBLWFcPeU6/uU3IUJDtpodEXrmlTs=;
        b=VBarlinb+3vPmxZ8B9xy3fTM2fHrMQxMzP4uI9LsRHbAEQnp9LAQ2owxfCAdAAb3Ft
         Bu2Un7MtUCMktHT+0shMBNA68WmU0WXlJUpf8tNU5942I2gzv4SqK0WBlIdJL23ZBzFU
         i41K9HmoPilFAiaJVpn350v6LYyLQv7ZJWAvqvOQChQGioz+Wk+eQWyzrUNG+MmB8+bV
         2Aews13rC9rxrm+WzGYaGfMeQjFSgjBgQ95d/0qvMRCvaTP2Ed6AHGLuajXcE3NQwiBX
         6OfS9muK+RLWIePxdFCxXwhlieIJs/vXjZ/CbWLLL8nQwRLzjUjbGB6tE68I/skYjYHI
         PC3Q==
X-Gm-Message-State: AFqh2kpKldJPxYzOK/VJT4QMRANN69PdIIxGFEGlbUDLqS3nEsK/Ej4u
        klPLnn84y7qh2hvo4l4dz3738Q==
X-Google-Smtp-Source: AMrXdXu2AuF93nX3A7ICqBtyfTfvp2COHkH2ko2jsGeGCqYcOM+cS737/sNi93dVX7j0p7P3zKBw0w==
X-Received: by 2002:a17:902:b58a:b0:193:2b86:bdc7 with SMTP id a10-20020a170902b58a00b001932b86bdc7mr964607pls.42.1673900681513;
        Mon, 16 Jan 2023 12:24:41 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902f0cb00b00180033438a0sm19782636pla.106.2023.01.16.12.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 12:24:40 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Dan Williams <dcbw@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 0/4] wifi: libertas: IE handling fixes
Date:   Mon, 16 Jan 2023 12:21:22 -0800
Message-Id: <20230116202126.50400-1-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series implements two fixes for the libertas driver that restore
compatibility with modern wpa_supplicant versions, and adds (or at least
improves) support for WPS in the process.

1) Better handling of the RSN/WPA IE in association requests:
   The previous logic was always just grabbing the first one, and didn't
   handle multiple IEs properly, which wpa_supplicant adds nowadays.

2) Support for IEs in scan requests:
   Modern wpa_supplicant always adds an "extended capabilities" IE,
   which violates max_scan_ie_len in this driver. Go ahead and allow
   scan IEs, and handle WPS based on the info that Dan provided.

These changes have been tested on a Marvell PXA168-based device with a
Marvell 88W8686 Wi-Fi chipset. I've confirmed that with these changes
applied, modern wpa_supplicant versions connect properly and WPS also
works correctly (tested with "wpa_cli -i wlan0 wps_pbc any").

Changes since V2:
- Add missing cpu_to_le16 as suggested by Simon Horman

Changes since V1 (which was a single patch linked here [1]):

- Switch to cfg80211_find_*_elem when looking for specific IEs,
  resulting in cleaner/safer code.
- Use mrvl_ie_data struct for cleaner manipulation of TLV buffer, and
  fix capitalization of the "data" member to avoid checkpatch warnings.
- Implement idea suggested by Dan to change max_scan_ie_len to be
  nonzero and enable WPS support in probe requests while we're at it.
- Remove "Fixes:" tag; I'm not sure if it's still appropriate or not
  with it depending on the capitalization fix.
- Clarify comments.

[1] https://lore.kernel.org/all/20230102234714.169831-1-doug@schmorgal.com/

Doug Brown (4):
  wifi: libertas: fix capitalization in mrvl_ie_data struct
  wifi: libertas: only add RSN/WPA IE in lbs_add_wpa_tlv
  wifi: libertas: add new TLV type for WPS enrollee IE
  wifi: libertas: add support for WPS enrollee IE in probe requests

 drivers/net/wireless/marvell/libertas/cfg.c   | 76 +++++++++++++++----
 drivers/net/wireless/marvell/libertas/types.h |  3 +-
 2 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.34.1

