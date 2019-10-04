Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75FDCC3F2
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbfJDUJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 16:09:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42107 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfJDUJD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 16:09:03 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so16151518iod.9;
        Fri, 04 Oct 2019 13:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TzGHd63YhhSYgCiRZ9tl0C+QqBhc3B9t1YurdXMHHEk=;
        b=kWRjsMO7kWGMm/IT1zcaML7wX7Qq9Yq8WRm+RABc1yvFRuSkg1MJFKvuhIADpR86Sk
         vk1W0Z5v0fSKpGUd8/OWzfGGYUmUKyVV0GCdL13GMMOSK9DpPSyvyt77eG5WmY3ZmctQ
         TGC8Cmmzyp9qWwicYV847MUo/KmeyE8yz2h7Smb7WOcrkh2TV9S23hinrXd+nv5M0ZyF
         ASEYU02I8rRxFXPCLp8D/KgP4shuTzi8Fg2/Hk1WrnV7b+j7LB2iDWk/cyp1qilFIKMU
         ZBR7mheI1uaHirJEtlL1lGs5B+v25rI82daNM0pAfgJ1uilLnWPeFNCSgjxJjo/1l4rp
         Y9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TzGHd63YhhSYgCiRZ9tl0C+QqBhc3B9t1YurdXMHHEk=;
        b=i14dfaCVcowVdtunic+1Wp2wGV+1ZNLuoXJwp7E15v+1eEJZwFN3kPpygTaLhCxUcK
         GwKISgBQGzHrbHDnyg1HwrLXM02Ldx63K+ocW92bWoiabvGepNaNkKLLjh1Cc9Z5Udr5
         FaRfo4jqaLUlKwSETn1kU+GSCbHc7OjVJMEAosWc4bRRpy2Z+vcoUwHuCG5OaNg6EQsh
         rYclOJRJfMAu448q1becWoBHIpImXDm50NiWfQtEoUOj5o22/QPRUwaUeIC5LrB/sOiI
         ZDVFoRHgEjTok93ZXTlcDfOXok4PcETTA6aDez2v7cwSd2y9Z9PI3Ng1mnPK/vmvqmXW
         iQZw==
X-Gm-Message-State: APjAAAXV8P3/lHsEKg8iHeiLr3dvIg5sDmZQ5/1qeeMO2VMTctGtUgtN
        UfU23ad10Ce+u/Moful94ba6TP6V/uo=
X-Google-Smtp-Source: APXvYqzID3S043QvcjXSlnz2Lfed2XSsv1r0x047tSPe8/gvBVD1NyJxtMQ/ZV89X4qzhOAjTbC2WA==
X-Received: by 2002:a92:603:: with SMTP id x3mr17481056ilg.295.1570219742776;
        Fri, 04 Oct 2019 13:09:02 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id i67sm4267112ilf.84.2019.10.04.13.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 13:09:02 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mwifiex: pcie: Fix memory leak in mwifiex_pcie_alloc_cmdrsp_buf
Date:   Fri,  4 Oct 2019 15:08:52 -0500
Message-Id: <20191004200853.23353-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In mwifiex_pcie_alloc_cmdrsp_buf, a new skb is allocated which should be
released if mwifiex_map_pci_memory() fails. The release is added.

Fixes: fc3314609047 ("mwifiex: use pci_alloc/free_consistent APIs for PCIe")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index eff06d59e9df..1578eaa071bd 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -1029,8 +1029,10 @@ static int mwifiex_pcie_alloc_cmdrsp_buf(struct mwifiex_adapter *adapter)
 	}
 	skb_put(skb, MWIFIEX_UPLD_SIZE);
 	if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-				   PCI_DMA_FROMDEVICE))
+				   PCI_DMA_FROMDEVICE)) {
+		kfree_skb(skb);
 		return -1;
+	}
 
 	card->cmdrsp_buf = skb;
 
-- 
2.17.1

