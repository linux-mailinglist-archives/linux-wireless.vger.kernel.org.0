Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC98114D78
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 09:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfLFIS5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 03:18:57 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:9878 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfLFIS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 03:18:56 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB68FjNT014996;
        Fri, 6 Dec 2019 00:17:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=aU7JJ1oIsaulqFpy9w3pyKdvbxrh71Bm9oSTTFUy2MM=;
 b=n++wD0QK9FVQXeVETBF4j0GUmEOPA26vUvIESFH/6dbLfzE3CJSLx+cdOl5M/0b+dBYq
 umuPZP2+e+8Qs4HNx4awXkyJdUd3Bkjc7JWSA98XcrdnTuzfGEtgP+JIBQ5MCCODy/gG
 dYTpOjbiGfV16DJHCalwQJ7sMjfD3kQ802RmKFai13RPhw9wg8nKSrEYaaey0xviy5Bd
 xS5z5eLii7bpHD5jEkSjhyWvN4iDPyICcYuY6sZ1KO0ns9TTMX8mQ+pWHk07/faf6Uf1
 04nsTlE/2ywKSmH1wST/srUvGarGq31xB0hGplLeJmR+b8BJXlTx/7nISjB4tP0ByPNt 2A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2wpybwmqhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Dec 2019 00:17:54 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 6 Dec
 2019 00:17:52 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 6 Dec 2019 00:17:52 -0800
Received: from testmailhost.marvell.com (testmailhost.marvell.com [10.31.130.105])
        by maili.marvell.com (Postfix) with ESMTP id C4AF03F703F;
        Fri,  6 Dec 2019 00:17:50 -0800 (PST)
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Brian Norris <briannorris@chromium.org>,
        Ganapathi Bhat <gbhat@marvell.com>
Subject: [PATCH] MAINTAINERS: update Ganapathi Bhat's email address
Date:   Fri, 6 Dec 2019 13:47:48 +0530
Message-ID: <1575620268-4613-1-git-send-email-gbhat@marvell.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_01:2019-12-04,2019-12-06 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'd like to use this email-id from now on.

Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7600494..67b5e65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9821,7 +9821,7 @@ F:	drivers/net/ethernet/marvell/mvneta.*
 MARVELL MWIFIEX WIRELESS DRIVER
 M:	Amitkumar Karwar <amitkarwar@gmail.com>
 M:	Nishant Sarmukadam <nishants@marvell.com>
-M:	Ganapathi Bhat <gbhat@marvell.com>
+M:	Ganapathi Bhat <ganapathi.bhat@nxp.com>
 M:	Xinming Hu <huxinming820@gmail.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-- 
1.9.1

