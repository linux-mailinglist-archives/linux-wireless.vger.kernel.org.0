Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED816C8E7B
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Mar 2023 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCYN1C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Mar 2023 09:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCYN1B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Mar 2023 09:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044B24C19
        for <linux-wireless@vger.kernel.org>; Sat, 25 Mar 2023 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679750776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Iii/UTDXaMnO4Wo0x/DUKmtgVb8N0aI08+TcTOIFrv0=;
        b=Fu2OvQQznxcuCLF5rS8h+BlOW76lYNAwwDEc9o6MbARtwWmZDs0YMwgZ8y5ivK2ujyGCT1
        LwQgBy2wrbbzOdcYKzUCI5Lzbw0vL9QCvES+wQyGTxkOrKO/G1IWI7VfaZxdWygNrMg5Uf
        YZRPRc3+g/RAJ/XYOpDmXfSVD74eyJ4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-H1K4F1mkOA2RgfYTJDMvhg-1; Sat, 25 Mar 2023 09:26:14 -0400
X-MC-Unique: H1K4F1mkOA2RgfYTJDMvhg-1
Received: by mail-qt1-f199.google.com with SMTP id h21-20020ac87d55000000b003bffb1c9745so2769431qtb.4
        for <linux-wireless@vger.kernel.org>; Sat, 25 Mar 2023 06:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679750773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iii/UTDXaMnO4Wo0x/DUKmtgVb8N0aI08+TcTOIFrv0=;
        b=BTPhxtM9V6cvv++acFNyo+ZYhVHDZ+SsAaejvxUk7Jzz6WMJ6X7uYdEIpFbwUFJ+ZZ
         e08M6kSeZYHSeZkxihq2VFXqV+bckU9XD9e+D/5gJMzdpKh7Q/BL//coXfabutNgmelh
         VFGcuxL7Mb1xqWeFi8fKUDxieZErBuHT6pb7GEDJkC40EhenLQUa3aH5YkZbRqQQzw3u
         Sn4mwHjWO0zrwOMGxmNR17lPgjpBqk1tTHb7dtZ+qJ4hD/IcN8XXAIB8PNP5T+BoCslf
         DwG1k2vvyZ81fUNxUNYlGR/9GZJU5NKT/5lEYVUHfhSnQ2GyGI59HEJSwILzu7ylfB7W
         yXWw==
X-Gm-Message-State: AAQBX9ejfsG7ZISmHB3P/zjuuShmfh9iCfzNhAgEDZ1KyDuW4FoU2pwi
        usAmsMaHmWDrZsQ6K0wmDxihxXa0ZxIVJzdtM7QxyvCWT4/8IZmrmtk/k43Ids/g9CsV5cfZwY4
        cO3Defox2W6rmtlUVxwk6w2TYhv+PkiGb+K8=
X-Received: by 2002:ad4:5bca:0:b0:5db:4d15:524d with SMTP id t10-20020ad45bca000000b005db4d15524dmr9054498qvt.52.1679750773656;
        Sat, 25 Mar 2023 06:26:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZlSGE95XTMsRO2eDXbclLRJ4kBq2KCSDNceqlNvQKjXpkqvXFlqtmH3evRGVGbNTwKl3s28w==
X-Received: by 2002:ad4:5bca:0:b0:5db:4d15:524d with SMTP id t10-20020ad45bca000000b005db4d15524dmr9054475qvt.52.1679750773419;
        Sat, 25 Mar 2023 06:26:13 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 11-20020a05620a040b00b007468733cd1fsm4212329qkp.58.2023.03.25.06.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:26:13 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mac80211: minstrel_ht: remove unused n_supported variable
Date:   Sat, 25 Mar 2023 09:26:10 -0400
Message-Id: <20230325132610.1334820-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

clang with W=1 reports
net/mac80211/rc80211_minstrel_ht.c:1711:6: error: variable
  'n_supported' set but not used [-Werror,-Wunused-but-set-variable]
        int n_supported = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/mac80211/rc80211_minstrel_ht.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 762346598338..b34c80522047 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1708,7 +1708,6 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	struct sta_info *sta_info;
 	bool ldpc, erp;
 	int use_vht;
-	int n_supported = 0;
 	int ack_dur;
 	int stbc;
 	int i;
@@ -1791,8 +1790,6 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 				continue;
 
 			mi->supported[i] = mcs->rx_mask[nss - 1];
-			if (mi->supported[i])
-				n_supported++;
 			continue;
 		}
 
@@ -1819,9 +1816,6 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 
 		mi->supported[i] = minstrel_get_valid_vht_rates(bw, nss,
 				vht_cap->vht_mcs.tx_mcs_map);
-
-		if (mi->supported[i])
-			n_supported++;
 	}
 
 	sta_info = container_of(sta, struct sta_info, sta);
-- 
2.27.0

