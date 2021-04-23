Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839C5369174
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhDWLrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 07:47:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3904 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhDWLrc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 07:47:32 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13NBkk01002138;
        Fri, 23 Apr 2021 11:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=V8eWeMAcsLl7tZpXsts53bUBVHL96c2xc8DdfKsfDts=;
 b=zTflOAY84jMUMEdHzVGpEokyI9OpgQoJBROzpRkYsE5Aw/SKaFa1qS589IpCigvg7wzq
 3ZHxQrEOtiXsyx6ZHZr3FPUdddh3nM/LnIa7wD8Wa/8h+p6quzFuR9OVOHEOErogi/zz
 8wL9Lut9UcIywn4gB8GOux9B0O4KE25a0aN5fzXdrFjK+1yR8V9o3wiaEjTrh6PgrG76
 Q1e7ZiuHVyISr80fqWOmgme/XCkVYH/He9ByBjC51sTz7InJiOkWdZKhyKQiFED8nYvT
 bfPq1FiHGzDkgXGq/EiZ3OaqM51EWXGH6mcHBvnu8JqZ8HcEzgZ8NLWwkfU2j+KQ64lG Iw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 383duh89qd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:46:45 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13NBkZsb023885;
        Fri, 23 Apr 2021 11:46:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 383ccffqkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:46:44 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13NBkiDN024104;
        Fri, 23 Apr 2021 11:46:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 383ccffqk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 11:46:44 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13NBkhMg006515;
        Fri, 23 Apr 2021 11:46:43 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 23 Apr 2021 04:46:42 -0700
Date:   Fri, 23 Apr 2021 14:46:34 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] brcmfmac: fix a loop exit condition
Message-ID: <YIKzmoMiTdToaIyP@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-ORIG-GUID: 9dYnMahR47TC0akC679jUJB2bGjB4VYE
X-Proofpoint-GUID: 9dYnMahR47TC0akC679jUJB2bGjB4VYE
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This code is supposed to loop over the whole board_type[] string.  The
current code kind of works just because ascii values start 97 and the
string is likely shorter than that so it will break when we hit the NUL
terminator.  But really the condition should be "i < len" instead of
"i < board_type[i]".

Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
index a7554265f95f..9b75e396fc50 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/of.c
@@ -34,7 +34,7 @@ void brcmf_of_probe(struct device *dev, enum brcmf_bus_type bus_type,
 		len = strlen(tmp) + 1;
 		board_type = devm_kzalloc(dev, len, GFP_KERNEL);
 		strscpy(board_type, tmp, len);
-		for (i = 0; i < board_type[i]; i++) {
+		for (i = 0; i < len; i++) {
 			if (board_type[i] == '/')
 				board_type[i] = '-';
 		}
-- 
2.30.2

