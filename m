Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59584187BD7
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 10:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgCQJSw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 05:18:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40634 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQJSw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 05:18:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02H9Dl5n139965;
        Tue, 17 Mar 2020 09:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=fHg+5qrrYSU3VQUK48LKicYRSK2xSEZqXR8N6XCv85Y=;
 b=C7z7Y5etdu05PtO27d93nRNNb9RV0zArIvCPap9f/ijyHUlQ7/QwXPMYv8MhatSHJcKb
 q0TVwyhmeRHGU+Sfun+Gz+QrYQgQWh6Ip4IiAJHkwOrOlVSt2N2hvvgRktFNt9Q1FY5S
 VosLplHX49WeoALpyYELZp3/DybGzGvTE7+cXFMoHqxEix6tDC4UHPqvUT+CqUKZI/Pp
 zWNLV1vjFoPVZrIwlQkrTGB195PteghgbRZ6sj9nQMAwwKm2tw73uOI/qo60yRiOh2PQ
 Yv9VRC4KNuoXYVWvoQIL1v6GwmtV1Plt4OcyWtcq9cIqUIVJE3+k2Z4ivBWS1E6iyo5Q Uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2yrqwn3m5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 09:18:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02H9CXu5059940;
        Tue, 17 Mar 2020 09:18:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ys8reeu7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Mar 2020 09:18:46 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02H9IhX9030126;
        Tue, 17 Mar 2020 09:18:43 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Mar 2020 02:18:43 -0700
Date:   Tue, 17 Mar 2020 12:18:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] wireless: mwifiex: initial commit for Marvell mwifiex
 driver
Message-ID: <20200317091837.GA18001@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003170041
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9562 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0 suspectscore=1
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003170041
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[ This is old, but maybe the driver is still really actively maintained
  so maybe someone knows the answer.  - dan ]

Hello Marvell Developers,

The patch 5e6e3a92b9a4: "wireless: mwifiex: initial commit for
Marvell mwifiex driver" from Mar 21, 2011, leads to the following
static checker warning:

	drivers/net/wireless/marvell/mwifiex/11n.c:505 mwifiex_11n_delete_tx_ba_stream_tbl_entry()
	error: we previously assumed 'tx_ba_tsr_tbl' could be null (see line 498)

drivers/net/wireless/marvell/mwifiex/11n.c
   472  /*
   473   * This function checks if the given pointer is valid entry of
   474   * Tx BA Stream table.
   475   */
   476  static int mwifiex_is_tx_ba_stream_ptr_valid(struct mwifiex_private *priv,
   477                                  struct mwifiex_tx_ba_stream_tbl *tx_tbl_ptr)
                                                                         ^^^^^^^^^^
This is always NULL.

   478  {
   479          struct mwifiex_tx_ba_stream_tbl *tx_ba_tsr_tbl;
   480  
   481          list_for_each_entry(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr, list) {
   482                  if (tx_ba_tsr_tbl == tx_tbl_ptr)
                            ^^^^^^^^^^^^^
tx_ba_tsr_tbl is the list iterator, which is never NULL so this will
never return true.

   483                          return true;
   484          }
   485  
   486          return false;
   487  }
   488  
   489  /*
   490   * This function deletes the given entry in Tx BA Stream table.
   491   *
   492   * The function also performs a validity check on the supplied
   493   * pointer before trying to delete.
   494   */
   495  void mwifiex_11n_delete_tx_ba_stream_tbl_entry(struct mwifiex_private *priv,
   496                                  struct mwifiex_tx_ba_stream_tbl *tx_ba_tsr_tbl)
   497  {
   498          if (!tx_ba_tsr_tbl &&
                     ^^^^^^^^^^^^^
Check for NULL

   499              mwifiex_is_tx_ba_stream_ptr_valid(priv, tx_ba_tsr_tbl))
                                                            ^^^^^^^^^^^^^
Which is passed to here.  So maybe the NULL check is reversed?

   500                  return;
   501  
   502          mwifiex_dbg(priv->adapter, INFO,
   503                      "info: tx_ba_tsr_tbl %p\n", tx_ba_tsr_tbl);
   504  
   505          list_del(&tx_ba_tsr_tbl->list);
                          ^^^^^^^^^^^^^^^^^^^
Unchecked NULL dereference

   506  
   507          kfree(tx_ba_tsr_tbl);
   508  }

regards,
dan carpenter
