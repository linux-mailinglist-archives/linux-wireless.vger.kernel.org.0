Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58C35483A2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 11:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240724AbiFMJTh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 05:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiFMJTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 05:19:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CA018B3B
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so9890192ejj.10
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to
         :cc;
        bh=PeoD4vyIixsMwk5bCIFYVtHST011T3bAxZA3o7iE4JM=;
        b=YOzUjEkjkIPfAY0MZs1VE0tYXcPXIhimJfw9LIxPIs58H+TSuBKX4hwEbjSeqafUCZ
         kAsNypAuYv9rPG0rNTH7u16kURPHAWsy85bgi31K6/SyM+zwzkYgJyWOg6kmBonQsjmP
         1GnVGhcLPTmBdV7xVENXiUmltdVJcF9NYIhDge0LOW7S0dRVUNQYb4j0ypJNqP/5JnLn
         edHoRWSNoqSKBeKKMJFYgG7eXxiRmO/8Oem8YLesjTVmY6QxpaYApQvd3buI0bL7WtxO
         bE4b4w/DzfbI4++WVISfpCGZ5BWRnTQ7KFCdof24ad340EHXdibQOInhnpeF+jrn3sUu
         efqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to:cc;
        bh=PeoD4vyIixsMwk5bCIFYVtHST011T3bAxZA3o7iE4JM=;
        b=bFssKNqWd5Oi3uc8TINhILeFueckxHSFPJ4PveVn6na+Zz12MFEy/R2lxBc82XXlA6
         YOZQ/WUTeZa06q4AQZyTQmgrR6z7/1eszj+q8/is145Z5+iEESsIKDB29IrNtuilm6SS
         Qb4MUAlZNXPMWRTRrd40yzSSBDx4nwQPiMKg7TGH3m42qprW8o12N/1o6hHS0gV4FJ0j
         r+gyS6wmlco3zz4imSCy/yyqZ8w+MWPccZm0/jtmppw8jnKDSrCIcAxVX6HnDQlc3Yn4
         YCaTbxZlpbl1p5PterTIStAQnosP45po5upN4yj+qUVYQoPehX+63+DJCm0Q5NNbNQBt
         dWBQ==
X-Gm-Message-State: AOAM532j5GVoBjP8EldfmhIXAApPRehG2mLERDYt3J0OQ3/hvWbrt6g5
        Gi/vEy84j4OFIxH+TPbMv1hA1XofyovCNAq48Bg=
X-Google-Smtp-Source: ABdhPJzj3eonjaTeC9L/nS5m6qwjuC5DsinSrvKcWOnf3g6JFMWPEpj4RV1qXwzRroJmHS9JiyxUIInYkReVJznNpKY=
MIME-Version: 1.0
X-Received: by 2002:a17:907:8a1f:b0:711:da32:8410 with SMTP id
 sc31-20020a1709078a1f00b00711da328410mr33562574ejc.298.1655111969400; Mon, 13
 Jun 2022 02:19:29 -0700 (PDT)
Received: from 35650733073 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 13 Jun 2022 05:19:28 -0400
From:   aspriel@gmail.com
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
Date:   Mon, 13 Jun 2022 05:19:28 -0400
Message-ID: <CAJ65rDzePSvi_OqCjVD5zX6qhxiK71Tau+yhVLV1LgOkE6BfRQ@mail.gmail.com>
Subject: [PATCH 6/7] brcmfmac: add vendor name in revinfo debugfs file
To:     Kalle Valo <kvalo@kernel.org>, arend.vanspriel@broadcom.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Upon probe the driver determines the vendor supporting the device.
Expose this information in the revinfo debugfs file.

Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Franky Lin <franky.lin@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c  | 3 ++-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c | 5 +++++
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 9a77b100abbb..c2b3525f7103 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1139,7 +1139,8 @@ static int brcmf_revinfo_read(struct seq_file
*s, void *data)
 	seq_printf(s, "vendorid: 0x%04x\n", ri->vendorid);
 	seq_printf(s, "deviceid: 0x%04x\n", ri->deviceid);
 	seq_printf(s, "radiorev: %s\n", brcmu_dotrev_str(ri->radiorev, drev));
-	seq_printf(s, "chip: %s\n", ri->chipname);
+	seq_printf(s, "chip: %s (%s)\n", ri->chipname,
+		   brcmf_fwvid_vendor_name(bus_if->drvr));
 	seq_printf(s, "chippkg: %u\n", ri->chippkg);
 	seq_printf(s, "corerev: %u\n", ri->corerev);
 	seq_printf(s, "boardid: 0x%04x\n", ri->boardid);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
index 919c60172e08..d0ba2aba093b 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.c
@@ -198,3 +198,8 @@ void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr)

 	mutex_unlock(&fwvid_list_lock);
 }
+
+const char *brcmf_fwvid_vendor_name(struct brcmf_pub *drvr)
+{
+	return fwvid_list[drvr->bus_if->fwvid].name;
+}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
index cc79df8cc428..8344d473a549 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
@@ -22,6 +22,7 @@ int brcmf_fwvid_unregister_vendor(enum
brcmf_fwvendor fwvid, struct module *mod)
 /* core driver functions */
 int brcmf_fwvid_attach_ops(struct brcmf_pub *drvr);
 void brcmf_fwvid_detach_ops(struct brcmf_pub *drvr);
+const char *brcmf_fwvid_vendor_name(struct brcmf_pub *drvr);

 static inline int brcmf_fwvid_attach(struct brcmf_pub *drvr)
 {
-- 
2.32.0
