Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB8FA966
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 06:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfKMFPo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 00:15:44 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:63934 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbfKMFPo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 00:15:44 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAD59u1r021829;
        Tue, 12 Nov 2019 21:15:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=WeNRinFdTnxt91l8lIGbvTKtH0Y8WtPSSkvIGRBUSFQ=;
 b=KWKc4Da4peRpAwHuDK4ejzpjDABk3AoYXYFPeLwh17AOMhvgxUrCV8fWwHCWEPwvXrif
 y1bcvksU43fxwdaxXMxZhAvzwVJdV5+32vu86g4u3ZTJ/qwHVBNOIFMgL54kukf3Aszb
 KYv8Mau8H0Ia/W2vFZVuxpro+NPmPipUWTjbMru3KIRMDjMHKtos04XTS2GoLersbZgQ
 pMbL1LVnV3hn8G3wiHrxCDyUAgnqSAl3rrHXrbPxoG+bK1UZu1NjY+/UNCYdZcdwyXP5
 2hbksH+7hFqLCPz6mjQCU0PEsLmw4sRVDS8xXUhwB7nLVAn/yFT1CQaVWJy1gWvAmqaZ Fw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2w5wurxcmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 21:15:42 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 12 Nov
 2019 21:15:40 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 12 Nov 2019 21:15:40 -0800
Received: from testmailhost.marvell.com (unknown [10.31.130.105])
        by maili.marvell.com (Postfix) with ESMTP id 7BF683F7044;
        Tue, 12 Nov 2019 21:15:37 -0800 (PST)
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Sharvari Harisangam <sharvari@marvell.com>,
        Ganapathi Bhat <gbhat@marvell.com>
Subject: [PATCH 1/2] mwifiex: fix requesting zero memory for firmware dump
Date:   Wed, 13 Nov 2019 10:45:31 +0530
Message-ID: <1573622132-16181-1-git-send-email-gbhat@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-12_10:2019-11-11,2019-11-12 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sharvari Harisangam <sharvari@marvell.com>

mwifiex_pcie_fw_dump would read firmware scratch registers, to
get the size of the dump. It does a vmalloc of memory_size + 1,
read above, to save the dump. It is possible that the value read
by  memory_size scratch register be invalid, i.e 0xffffffff. This
would pass an invalid size(0) to vmalloc. To fix this check for
invalid scratch register read.

Signed-off-by: Sharvari Harisangam <sharvari@marvell.com>
Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index fc1706d..483b521 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2727,6 +2727,13 @@ static void mwifiex_pcie_fw_dump(struct mwifiex_adapter *adapter)
 			break;
 		}
 
+		if (memory_size == 0xffffffff) {
+			mwifiex_dbg(adapter, ERROR,
+				    "Invalid dump size: 0x%x, for %s\n",
+				    memory_size, entry->mem_name);
+			return;
+		}
+
 		mwifiex_dbg(adapter, DUMP,
 			    "%s_SIZE=0x%x\n", entry->mem_name, memory_size);
 		entry->mem_ptr = vmalloc(memory_size + 1);
-- 
1.9.1

