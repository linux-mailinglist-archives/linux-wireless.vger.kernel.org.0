Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58C1E42BB
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 14:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgE0MxX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 08:53:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41138 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbgE0MxX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 08:53:23 -0400
Received: by mail-pf1-f195.google.com with SMTP id 23so11778279pfy.8
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 05:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:resent-from:resent-date:resent-message-id
         :resent-to:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6RbYv5B1MYyKpilgE+iTClDmvIVUX2RuuOQOJ/aMVQ=;
        b=mnYO83srxb539PZ/8409bBJqD5VWKtAWlFJEC/Y/F5j6vATpB8kQzutiJEZCEn+p9F
         VOwpd48zfhuw6xLL76esu/cZyyKd2MmQSBpTu5hAQAlNVnuXD3KLmAC+hziblfsmqt+6
         29G/LNnmd3LoDgLEvx6tIfS1k2xaMttqsbwTRoe/L9ZpjJMUPbBaBY7VhttE4N/woZ80
         ITHNoaAzCZHKjD53ijrB0fbPoGuS3jUZaLKOfdw3cl36J8JP1Wv15u7ZUbyBmVlLdlO4
         36G9JMcFTcuAcfVCFZGA1c1woUKw4nIh8S9cg15sZkw7wA3vUnZWsHnMP+iu+VTGdr4d
         Dadw==
X-Gm-Message-State: AOAM531KDia0JVQqHOFRUHli3UVjkW1I/RXdLGmPoi60uhgyxBwqG3WE
        2bfgBrt9ZvGhJ70798lG1ipGe01wmpYNmw==
X-Google-Smtp-Source: ABdhPJzG/32mtruxm/l4NDI4+3wD/Nhstlo9iBFx63ZoqYd6Q0glKeMs85z9Xeel7PnPlJdGFnvI5g==
X-Received: by 2002:aa7:9508:: with SMTP id b8mr3977687pfp.48.1590584002086;
        Wed, 27 May 2020 05:53:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k31sm2260089pje.19.2020.05.27.05.53.21
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:53:21 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0852640605; Wed, 27 May 2020 12:53:21 +0000 (UTC)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a6sm15582861pfa.111.2020.05.26.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:58:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0547C4230A; Tue, 26 May 2020 14:58:19 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     michael.chan@broadcom.com, dchickles@marvell.com,
        sburla@marvell.com, fmanlunas@marvell.com, aelior@marvell.com,
        GR-everest-linux-l2@marvell.com, kvalo@codeaurora.org,
        johannes@sipsolutions.net, akpm@linux-foundation.org,
        arnd@arndb.de, rostedt@goodmis.org, mingo@redhat.com,
        aquini@redhat.com, cai@lca.pw, dyoung@redhat.com, bhe@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, gpiccoli@canonical.com,
        pmladek@suse.com, tiwai@suse.de, schlad@suse.de,
        andriy.shevchenko@linux.intel.com, derosier@gmail.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, vkoul@kernel.org,
        mchehab+huawei@kernel.org, robh@kernel.org, mhiramat@kernel.org,
        sfr@canb.auug.org.au, linux@dominikbrodowski.net,
        glider@google.com, paulmck@kernel.org, elver@google.com,
        bauerman@linux.ibm.com, yamada.masahiro@socionext.com,
        samitolvanen@google.com, yzaikin@google.com, dvyukov@google.com,
        rdunlap@infradead.org, corbet@lwn.net, dianders@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>
Subject: [PATCH v3 8/8] qed: use new taint_firmware_crashed()
Date:   Tue, 26 May 2020 14:58:15 +0000
Message-Id: <20200526145815.6415-9-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200526145815.6415-1-mcgrof@kernel.org>
References: <20200526145815.6415-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TUID: ft9zMR0oDEMI
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This makes use of the new taint_firmware_crashed() to help
annotate when firmware for device drivers crash. When firmware
crashes devices can sometimes become unresponsive, and recovery
sometimes requires a driver unload / reload and in the worst cases
a reboot.

Using a taint flag allows us to annotate when this happens clearly.

Cc: Ariel Elior <aelior@marvell.com>
Cc: GR-everest-linux-l2@marvell.com
Reviewed-by: Igor Russkikh <irusskikh@marvell.com>
Acked-by: Rafael Aquini <aquini@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_mcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 9624616806e7..dd4357b0b5d1 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -566,6 +566,7 @@ _qed_mcp_cmd_and_union(struct qed_hwfn *p_hwfn,
 		DP_NOTICE(p_hwfn,
 			  "The MFW failed to respond to command 0x%08x [param 0x%08x].\n",
 			  p_mb_params->cmd, p_mb_params->param);
+		taint_firmware_crashed();
 		qed_mcp_print_cpu_info(p_hwfn, p_ptt);
 
 		spin_lock_bh(&p_hwfn->mcp_info->cmd_lock);
-- 
2.26.2

