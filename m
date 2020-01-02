Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A60F12E1C3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2020 03:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgABCkJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jan 2020 21:40:09 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36524 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABCkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jan 2020 21:40:08 -0500
Received: by mail-pj1-f65.google.com with SMTP id n59so2742660pjb.1
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jan 2020 18:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U82gOUx2iPpX7MQb6sqEW0FhEcnhIyIP1xR2fom0214=;
        b=hqrKplcTN4Xj5PJL11Nm8DMcG8swCfN/a6b9aYVGJvUhxNmyjj9mKJyguR2ziikIs5
         7mAJ1d6JaOpGqz9fUPXaRf3sp4538oIzAkoBv4MDpmLmlQzqqM1VCVaZJ/5wna59nqZl
         KPve60sDRbp36ol125BNIoo8QaaG7z5VbVWclmsJsGDvn5TrVNQVZGzK9PfDlsfKF/ww
         HFh9BMLpzgOgWJfPcuIK2DkB57flRtjvGZkuv484q1VCyHxVwTUK0K5rzaeiZd4YfIsw
         ZcfN0PMbD47ZSE0ZCEkeZdD3fzIbg8uuhJIY4ej3UIOObmI36psG+uJZhgCG5mwNAKag
         4ugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U82gOUx2iPpX7MQb6sqEW0FhEcnhIyIP1xR2fom0214=;
        b=oBqKLTk4UDIOVv+O0MZkmaTaUra6ak9MJi5eTP9uPquRVoWVTnAyMnmSqQVVVoH0Mn
         TAbyjtvjkr/nYfjDZvj3riy8lC7YwaRAR0LFh/JMSnZDxEY4zXDPQ7V2xHqACu9ClDSq
         2gVh3DG6MCXiove53o9+lJYKWE8Bv79m++xnEaGagbt95pnLIOuluHB4qC5tRiYHyaDQ
         OncmvdWTxogerK8mpBxRrUlKpQloIDrKG/Oac6Dk/o9nFA+sCoqi3zhpmBoOZgWNEOZ+
         5RRCZ7ft8jVTiQIQBLApSlsa16vdatFBVkQnuxM1lZz12krCl0PQ6hF2JzKanR5Cm6cN
         V9kg==
X-Gm-Message-State: APjAAAXgEX40CpzjHLtwdMqP4Msxc1FL1DXNE9AIp+NL/81IGGb/8YfS
        mgJ1s7AViiZdFxwMfC8+cQzEUFB0Wl4=
X-Google-Smtp-Source: APXvYqxxvpzb1LCEfXBTgbbzUA9EnR+GxxKLW9BZyZdAVH1NB/4vYxX14X3My76g2OWf9do4nZzSaA==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr82623879plo.61.1577932807986;
        Wed, 01 Jan 2020 18:40:07 -0800 (PST)
Received: from localhost (172.96.199.36.16clouds.com. [172.96.199.36])
        by smtp.gmail.com with ESMTPSA id f127sm63410930pfa.112.2020.01.01.18.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jan 2020 18:40:07 -0800 (PST)
From:   m1s5p6688@gmail.com
To:     linux-wireless@vger.kernel.org
Cc:     amitkarwar@gmail.com, nishants@marvell.com, gbhat@marvell.com,
        huxinming820@gmail.com
Subject: [PATCH 1/2] mwifiex: Fix possible buffer overflows in mwifiex_ret_wmm_get_status()
Date:   Thu,  2 Jan 2020 10:39:26 +0800
Message-Id: <20200102023927.4687-2-m1s5p6688@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200102023927.4687-1-m1s5p6688@gmail.com>
References: <20200102023927.4687-1-m1s5p6688@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Qing Xu <m1s5p6688@gmail.com>

mwifiex_ret_wmm_get_status() calls memcpy() without checking the 
destination size.Since the source is given from remote AP which 
contains illegal wmm elements , this may trigger a heap buffer 
overflow.
Fix it by putting the length check before calling memcpy().

Signed-off-by: Qing Xu <m1s5p6688@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/wmm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index 41f023137..132f9e8ed 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -970,6 +970,10 @@ int mwifiex_ret_wmm_get_status(struct mwifiex_private *priv,
 				    "WMM Parameter Set Count: %d\n",
 				    wmm_param_ie->qos_info_bitmap & mask);
 
+			if (wmm_param_ie->vend_hdr.len + 2 >
+				sizeof(struct ieee_types_wmm_parameter))
+				break;
+
 			memcpy((u8 *) &priv->curr_bss_params.bss_descriptor.
 			       wmm_ie, wmm_param_ie,
 			       wmm_param_ie->vend_hdr.len + 2);
-- 
2.17.1

