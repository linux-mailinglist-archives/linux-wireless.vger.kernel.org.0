Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93ADA49BAF8
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jan 2022 19:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiAYSIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jan 2022 13:08:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241904AbiAYSHv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jan 2022 13:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643134061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wZ/YYJLB72Hf5p1POA1A36FlHc2x/OwYWfFRBmTnCrc=;
        b=KlNMckap2HQ6occpw2vg+tSuhmCz3C6D7cS7V8/z2IXIgitv0pnbDztv0uPosBCpKVUbDR
        YLxbPawlQsD0QkMJ5w/6nLu6Nalr0gj2ZtKnHkBi052xr1RYzNOqMGEwwJP/umNN05Pkwj
        Fyr276mV0vsTKjBzKhyZS6mc/cslZyg=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-yyyuSWsXPDSLll1_84N4pg-1; Tue, 25 Jan 2022 13:07:40 -0500
X-MC-Unique: yyyuSWsXPDSLll1_84N4pg-1
Received: by mail-oo1-f70.google.com with SMTP id n5-20020a4ab345000000b002dc79e4a2baso6202668ooo.15
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jan 2022 10:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wZ/YYJLB72Hf5p1POA1A36FlHc2x/OwYWfFRBmTnCrc=;
        b=Dm04hScY23nC0JnUXcjCNzy3xbY/o0VrcOgskq5L1NbC1nkUsFCs34dwsRjtQy+2WX
         hAtE7dvytoVKgdXVqM5x4xWqpW0qgyua1fufJNEf+I7o3wK+w7pMqVJzNHFe3XplXFPi
         r9BlhXoemTjEU3g93YztiU4aaKEtjZ+z6oYmn95MB/6MnJvVwv8K98Jl5yQspkUHUTs7
         p4nfRDtUdqWyGOwIyr3lLaViEu2tQtrGIaO2zvOzHIUrPY5WDMkOLSY+nd+RUWcPD2bq
         MRVv/vFLAZFFduI37tfaZ2ESaZNti8ug+xcmJQLiSULCgeWG/OsIvoCRvMgmniCZnAtB
         DTZA==
X-Gm-Message-State: AOAM530KPqnpIHG6dcpscf2xHDzjjimlb8k4J1wRlgq/thyUN65mehts
        t1dV1WXHdipTaCD5/9vVF6nzC6RppSVoan6oSYH+kF9ZdBJJQOnYMePSLfi4ryXoWHdP12tAasa
        IjFeIMAinoNG7pnAxuH+KxBOwsCQ=
X-Received: by 2002:a4a:b24b:: with SMTP id i11mr13990791ooo.17.1643134059524;
        Tue, 25 Jan 2022 10:07:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytoZMto/EuCrZnClcVErOkFB+/iGYfaRy6xZsTw6FNztkIPZWSOmFtpqPAHITjsWBX+8FnfQ==
X-Received: by 2002:a4a:b24b:: with SMTP id i11mr13990785ooo.17.1643134059351;
        Tue, 25 Jan 2022 10:07:39 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id a2sm8369284oiw.33.2022.01.25.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 10:07:38 -0800 (PST)
From:   trix@redhat.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ieee80211: cleanup double word in comment
Date:   Tue, 25 Jan 2022 10:07:35 -0800
Message-Id: <20220125180735.1123792-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'that'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 559b6c6449384..5475383936f8b 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -467,7 +467,7 @@ static inline bool ieee80211_is_data_qos(__le16 fc)
 static inline bool ieee80211_is_data_present(__le16 fc)
 {
 	/*
-	 * mask with 0x40 and test that that bit is clear to only return true
+	 * mask with 0x40 and test that bit is clear to only return true
 	 * for the data-containing substypes.
 	 */
 	return (fc & cpu_to_le16(IEEE80211_FCTL_FTYPE | 0x40)) ==
-- 
2.26.3

