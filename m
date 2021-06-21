Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963A13AE921
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jun 2021 14:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFUMf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Jun 2021 08:35:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19080 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFUMf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Jun 2021 08:35:59 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LCRUm5018765;
        Mon, 21 Jun 2021 12:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=y0MMEAfZ2w9bZHucceJzRm8LU11CvbC3WGt+fD7ZgaE=;
 b=Sctmrf0IA/aLusV8EPGKvfwc+C89O0nivKcdkNVa9qwX1LO0/YdAaK//exu2cOCXZDdu
 zEjNdBnhkBHUQhnho2G14R80/vErj0jq+VXYGjTE+H4/9doC3O5beqXJKa7Ibs51pjSq
 WYRlyArjn9olPt1DpxGCNlMzVcLt6ZzYDW1HW5DE7IK0csOET/p8B+W1W626isvLnQec
 ZjaEQBoNHyozxlcwgM5N1gmG+uHQFDXiztianApb8NhwNGwXLgZjiwSYo73myVy+0sOF
 bdSmo20QYsOFW6l6NGF079w1HCvkituWAy7dKrNjZ5hJJWS1wg+Zwlnc1QF2SKaXhTxe tg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvrck7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:33:33 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15LCXWmH129027;
        Mon, 21 Jun 2021 12:33:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 3996mbvgyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:33:32 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15LCXV4Z129004;
        Mon, 21 Jun 2021 12:33:31 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 3996mbvgy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:33:31 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15LCXUmd027872;
        Mon, 21 Jun 2021 12:33:30 GMT
Received: from mwanda (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Jun 2021 05:33:29 -0700
Date:   Mon, 21 Jun 2021 15:33:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, kernel-janitors@vger.kernel.org
Subject: [PATCH v2] brcmfmac: fix "board_type" in brcmf_of_probe()
Message-ID: <YNCHELb14+eNV94n@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: zLJix7DsWZkbTPlzInMk9nDxrEeSaQNb
X-Proofpoint-GUID: zLJix7DsWZkbTPlzInMk9nDxrEeSaQNb
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two bugs here:
1) devm_kzalloc() needs to be checked for allocation errors.
2) The loop was intended to be:

 Bad:	for (i = 0; i < board_type[i]; i++) {
Good:	for (i = 0; i < len; i++) {

Neither of these bugs are likely to cause an issue in practice but
they're worth fixing.  Also the code could be made simpler by using the
devm_kstrdup() and strreplace() functions.

Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: Basically a completely different patch.  :)

 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c    | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index a7554265f95f..8ca62cd0e8ac 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -24,20 +24,16 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 	/* Set board-type to the first string of the machine compatible prop */
 	root = of_find_node_by_path("/");
 	if (root) {
-		int i, len;
 		char *board_type;
 		const char *tmp;
 
 		of_property_read_string_index(root, "compatible", 0, &tmp);
 
 		/* get rid of '/' in the compatible string to be able to find the FW */
-		len = strlen(tmp) + 1;
-		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
-		strscpy(board_type, tmp, len);
-		for (i = 0; i < board_type[i]; i++) {
-			if (board_type[i] == '/')
-				board_type[i] = '-';
-		}
+		board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+		if (!board_type)
+			return;
+		strreplace(board_type, '/', '-');
 		settings->board_type = board_type;
 
 		of_node_put(root);
-- 
2.30.2

