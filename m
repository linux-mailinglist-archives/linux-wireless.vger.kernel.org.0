Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77864A9C32
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 16:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359664AbiBDPrw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 10:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBDPrv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 10:47:51 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63835C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 07:47:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k13so13433721lfg.9
        for <linux-wireless@vger.kernel.org>; Fri, 04 Feb 2022 07:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVwab4TfcccXXqCGUHK9nc7lKj1PiAidFfbcBOSSj64=;
        b=axMVRzwvKICE+mBEeohotURYQg4yaHWWtiV3x6r1n15fqgXjDS2RRtJeZpGGy3PB2t
         kTFns4+WNuaAsM4IpaE3dt1Oh6o9U/pXGZ03PXXpAAmQTv2Oq6L2GeyGV4rZw1XW9yQa
         rnYclvj/NNm0uhBYatgInM0ekI8xsU5N7STwZKiKFZvYbtxBUDRYvU6t4iBG0MBOfUdP
         5D3MiGepiSzKwNUgfe/mCXRCFrmGQF4wfnlFYYdxn8QHetAxCm5WTGcVRCq3VrC1ne9b
         RpUswRJph1LA5tmTVOUuGRIsZ68Qc5AnL9UF0O6n7tBeBwFUrmEqPDBHkHl6ghoMCXtg
         7D8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uVwab4TfcccXXqCGUHK9nc7lKj1PiAidFfbcBOSSj64=;
        b=zwd8NFTOQzFcDPK+33ynUd+aXof+Y3PoLYiQJIuQr1+DQUHS4plZOpKm7XvhooMemY
         jceAVZ3N4T5ovTpFCGh4SrUmtyUx5+O3BkPMKT+QbyjrtPGqK96x9cQxzaR0fwhddjHg
         6Wu1KU8YMw/QWnJhptp7xoRMnvV5w9EH30EBj8BFEi5A2fEdanjgDe9wKUap7VTrghcE
         ApeMjvG1KtVrA28Oj8q5OaGWPWza+jqmorK7yA3gmJZ3rC2JNeZPoqbR/+4xhDU3Dh60
         8nWztKujh2Iw+34BCoXZ8gMBLQMzN20kkKIg7cTbLidvSrjvGe1ao2/TKqlmydWrBNE6
         Nbuw==
X-Gm-Message-State: AOAM530jMGAcNKLPzmlIRknlJAzgytdBmKTRsh+9CGVWzB0VfaOMqbRO
        7MckyA6M++3dLmqrjqh+VmJKJg==
X-Google-Smtp-Source: ABdhPJwLcH185puSRhw6N5y57DMbc+a+mhdQeAKkCS4bq/8rMJx2b00R2HWuG13TNj6H9F7ipVurEA==
X-Received: by 2002:a05:6512:11f2:: with SMTP id p18mr2506351lfs.665.1643989669654;
        Fri, 04 Feb 2022 07:47:49 -0800 (PST)
Received: from anpc2.lan ([62.119.107.74])
        by smtp.gmail.com with ESMTPSA id k5sm364983lfe.19.2022.02.04.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 07:47:49 -0800 (PST)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     nbd@nbd.name, lorenzo.bianconi83@gmail.com
Cc:     ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH] mt76: mt7915: fix injected MPDU transmission to not use HW A-MSDU
Date:   Fri,  4 Feb 2022 16:47:30 +0100
Message-Id: <20220204154730.166194-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before, the hardware would be allowed to transmit injected 802.11 MPDUs
as A-MSDU. This resulted in corrupted frames being transmitted. Now,
injected MPDUs are transmitted as-is, without A-MSDU.

The fix was verified with frame injection on MT7915 hardware, both with
and without the injected frame being encrypted.

If the hardware cannot do A-MSDU aggregation on MPDUs, this problem
would also be present in the TX path where mac80211 does the 802.11
encapsulation. However, I have not observed any such problem when
disabling IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD to force that mode.
Therefore this fix is isolated to injected frames only.

The same A-MSDU logic is also present in the mt7921 driver, so it is
likely that this fix should be applied there too. I do not have access
to mt7921 hardware so I have not been able to test that.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 mt7915/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mt7915/mac.c b/mt7915/mac.c
index 08ee78f6..1848fa16 100644
--- a/mt7915/mac.c
+++ b/mt7915/mac.c
@@ -1121,6 +1121,7 @@ mt7915_mac_write_txwi_80211(struct mt7915_dev *dev, __le32 *txwi,
 		val = MT_TXD3_SN_VALID |
 		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
 		txwi[3] |= cpu_to_le32(val);
+		txwi[7] &= ~cpu_to_le32(MT_TXD7_HW_AMSDU);
 	}
 
 	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
-- 
2.30.2

