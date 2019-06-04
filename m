Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E787034ED6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2019 19:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFDRbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Jun 2019 13:31:48 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39836 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDRbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Jun 2019 13:31:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id 196so10761050pgc.6
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2019 10:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8548ahNIiNfZOmNZGvAfjcomKImaYWHxzGsRMnII4c8=;
        b=Jwrr8OxWF2ZF45rqbpkpmf0LoUi0OrM0izOLHBoS88YLVrLh+AhzsrS+ODHGVwTSal
         i9V6EGrJE0BA9TSUzJc1rEEe4X4xjS01X8DT/mBQR8JSD3VB4lPRyl5hPThycCK2KVeI
         QoRnWMcKAIeRpVxoiI579ZetsiR5g/Hh8brSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8548ahNIiNfZOmNZGvAfjcomKImaYWHxzGsRMnII4c8=;
        b=UGULrrmbvYRE/XWefDfx99eu+mN7yZeZ6+X+9/PbvZHGZ+fIl0O7OfHiL5Fk0vR7BJ
         eKZ7wmjrpzrx8DPADK/bpv1SDhk2wQ30S+qJdb3qow2Qx/AVzAti7Vqk9uqrKDgmKMNR
         f7b5DSEMei4FqA0N/qlm2jKmOcPGhyHGNbXrcT5AbcDYOT4uNsOIEkxwsE7E63tWMMpK
         AfszXytVCSWJz5pHXmesSg4uwL2IPr6i8wWdzlMHMxhs70j8rk+q6P4N+KYT3LA6Cc26
         TOO2UKVCzpUheoNpNG2GuSLj3QkxF4iATeO5OyVaCIUkk+sn0zyWJhdi/Cf4GAnnjjjG
         XjIg==
X-Gm-Message-State: APjAAAU8EftAHQfGll/fpI1DLkXgMh3zR7eWVnGiB7HxgQE6B9jzylrA
        j+A0EOpDp/3ouEjKlehT/RYLEQ==
X-Google-Smtp-Source: APXvYqwfHjgtY5SiYME01mj7y6hPrwiq80g8qEIZz6RZp0jn3tm9VHBdf9FZsrH8258Quqrh7vm/DQ==
X-Received: by 2002:a63:1119:: with SMTP id g25mr36045566pgl.380.1559669507811;
        Tue, 04 Jun 2019 10:31:47 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id j97sm17565184pje.5.2019.06.04.10.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:31:47 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Ganapathi Bhat <gbhat@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] mwifiex: print PCI mmap with %pK
Date:   Tue,  4 Jun 2019 10:31:44 -0700
Message-Id: <20190604173144.109142-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Unadorned '%p' has restrictive policies these days, such that it usually
just prints garbage at early boot (see
Documentation/core-api/printk-formats.rst, "kernel will print
``(ptrval)`` until it gathers enough entropy"). Annotating with %pK
(for "kernel pointer") allows the kptr_restrict sysctl to control
printing policy better.

We might just as well drop this message entirely, but this fix was easy
enough for now.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 82f58bf0fc43..b54f73e3d508 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2959,7 +2959,7 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 		goto err_iomap2;
 	}
 
-	pr_notice("PCI memory map Virt0: %p PCI memory map Virt2: %p\n",
+	pr_notice("PCI memory map Virt0: %pK PCI memory map Virt2: %pK\n",
 		  card->pci_mmap, card->pci_mmap1);
 
 	ret = mwifiex_pcie_alloc_buffers(adapter);
-- 
2.22.0.rc1.311.g5d7573a151-goog

