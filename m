Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75787D8F06
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 08:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjJ0G50 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Oct 2023 02:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjJ0G5Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Oct 2023 02:57:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7612B1B5
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 23:57:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a6190af24aso271933466b.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 23:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698389841; x=1698994641; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kj3Zu6WMlpxQr17sM16EXcoz5cOx2Zq8aggknXeJGWY=;
        b=JN948EZBExUcOWDWNBCyXB7eXJTLvHeQgvMLPe7NICB1+aIqkhHu6x1TNOtsCaOnLB
         Mk1VsZcik65aIEirET+Dbu2FICYmMvkPeZqiEkZgRaxEGeBsRqPSrCe207P31kxxqPDr
         7tA2Zc+dMs1FEQ6LuvYR5p02u6yUeWxFRLEGNnpMC51HEU3VcWuqnZGibuHpUpUlf4L9
         dSfWQa2ccNjJHwSud8X4e/qTjYhdy6W1spdy1aCj/bzoeR7cr2AIez7kg3BsXz7xQy8j
         9Z+ixaXR4OtTAwn9GFgFacH/terwG40qJs7DUWIM5HDHLSVkV1faUiZ8sUw18cWoQ66c
         PRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698389841; x=1698994641;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj3Zu6WMlpxQr17sM16EXcoz5cOx2Zq8aggknXeJGWY=;
        b=jxDjI0TCRH77u100QLdz/OYM9qN44rGEssniXL2b+AjlAmgyhgr+i4HL06OJtDdgik
         UWC88Zxi8aTdsdhDcdGJtAvc1GpXymKoialY/J+SbCJyR+gEWsqmXEbpsRMlXuSlMDxH
         qZiz7nzRVe3D2MFe4VpxzDrQeBFWSnm4oGYxJCc6e6I6F6a+RK6LeUgGyURD9KqL5Y1s
         BGER9O12v5FX8LPfQu0atIDFB0gEVH91QhrKmVTr24K1/88R/kSDldzEhx8uc8IIOb4T
         JvqDMbE1r5kDYMnaFhlQ8kRVVWOCMB6GlPTT/ElPmaP4822KMxDopI0y0qaSyodKyft2
         p1zA==
X-Gm-Message-State: AOJu0Yx2By5FMMEoCe4kXQuIPPJvRwUVoHgraagIDgUufmxxUTCUkpjc
        PQm3+xw8ZFGUz7AJu2GIouUW1Q==
X-Google-Smtp-Source: AGHT+IHq5doa0BQX+kMaVEeO5/zwweZM2r10RQCthE0JiUtVHXqbkVYblKtKbVO/w75KYeXdp21e6Q==
X-Received: by 2002:a17:907:9718:b0:9be:6395:6b0f with SMTP id jg24-20020a170907971800b009be63956b0fmr1436632ejc.29.1698389840852;
        Thu, 26 Oct 2023 23:57:20 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id rp28-20020a170906d97c00b009b296ce13a3sm731381ejb.18.2023.10.26.23.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 23:57:20 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 27 Oct 2023 08:57:18 +0200
Subject: [PATCH] wifi: ath11k: Defer on rproc_get failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-ath11k-rproc-defer-v1-1-f6b6a812cd18@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAE1fO2UC/x3MMQqAMAxA0atIZgNNBYteRRxKm2oQVFIRQXp3i
 +Mb/n8hswpnGJsXlG/JcuwV1DYQVr8vjBKrwRrbkbEO/bUSbainHgEjJ1aM1PfODckTdVDDUzn
 J80+nuZQPzjDaZmQAAAA=
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If we already have gotten the rproc_handle (meaning the "qcom,rproc"
property is defined in the devicetree), it's a valid state that the
remoteproc module hasn't probed yet so we should defer probing instead
of just failing to probe.

This resolves a race condition when the ath11k driver probes and fails
before the wpss remoteproc driver has probed, like the following:

  [    6.232360] ath11k 17a10040.wifi: failed to get rproc
  [    6.232366] ath11k 17a10040.wifi: failed to get rproc: -22
  [    6.232478] ath11k: probe of 17a10040.wifi failed with error -22
       ...
  [    6.252415] remoteproc remoteproc2: 8a00000.remoteproc is available
  [    6.252776] remoteproc remoteproc2: powering up 8a00000.remoteproc
  [    6.252781] remoteproc remoteproc2: Booting fw image qcom/qcm6490/fairphone5/wpss.mdt, size 7188

So, defer the probe if we hit that so we can retry later once the wpss
remoteproc is available.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 235336ef2a7a..f8f5e653cd03 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -803,8 +803,8 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
 
 	prproc = rproc_get_by_phandle(rproc_phandle);
 	if (!prproc) {
-		ath11k_err(ab, "failed to get rproc\n");
-		return -EINVAL;
+		ath11k_dbg(ab, ATH11K_DBG_AHB, "failed to get rproc, deferring\n");
+		return -EPROBE_DEFER;
 	}
 	ab_ahb->tgt_rproc = prproc;
 

---
base-commit: 2ef7141596eed0b4b45ef18b3626f428a6b0a822
change-id: 20231027-ath11k-rproc-defer-d166779fa113

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

