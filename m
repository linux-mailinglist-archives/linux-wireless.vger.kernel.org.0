Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C2D19E6F8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2020 20:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDDSJf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Apr 2020 14:09:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37870 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgDDSJe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Apr 2020 14:09:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 034I9WW8037220;
        Sat, 4 Apr 2020 18:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=UovoAokAIlYpydvbxv4p/W1/FCljxlIVu+23FZCTw5U=;
 b=auz2IoCCZerDakBjN0XgbQ0PQXIGYVJSE1Rp7OQjrQ6TysoHrNFur5y6evArdW6aCHTv
 MNyp7B8HviEo/lqjq73KKXIBvHSLMKz9IoaKKBKbz1IPau6zSVcIla7lCcakBnFjI3cd
 F+x+Nkc8dZOgymRi3hxNOG1K5ThOgh9fpvkmQqw/ubEPPAkWYQXjJYimR6u9x2Iaupyt
 StG4BnHvEHFQzRU75s1lkHd6daPuXbvGHXk8js8OURUz88r5ofAicPM0TY8E5HJ9eXJT
 bbeBmQBP05w8psdROzVAf2Dj7e7kUZlMrklenjY96CnCHR9tg15LesINnBSMGaOYR2ZU 8g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 306jvmscpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Apr 2020 18:09:32 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 034I7CCu101248;
        Sat, 4 Apr 2020 18:09:32 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 306fbswfhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Apr 2020 18:09:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 034I9VqJ010345;
        Sat, 4 Apr 2020 18:09:31 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 04 Apr 2020 11:09:30 -0700
Date:   Sat, 4 Apr 2020 21:09:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: add mac/rf types and 160MHz to the device
 tables
Message-ID: <20200404180924.GA174138@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9581 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=914 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004040168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9581 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=3
 mlxlogscore=949 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004040168
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Luca Coelho,

The patch d6f2134a3831: "iwlwifi: add mac/rf types and 160MHz to the
device tables" from Mar 9, 2020, leads to the following static
checker warning:

	drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1007 iwl_pci_probe()
	warn: mask and shift to zero

drivers/net/wireless/intel/iwlwifi/pcie/drv.c
   989                  if ((dev_info->device == (u16)IWL_CFG_ANY ||
   990                       dev_info->device == pdev->device) &&
   991                      (dev_info->subdevice == (u16)IWL_CFG_ANY ||
   992                       dev_info->subdevice == pdev->subsystem_device) &&
   993                      (dev_info->mac_type == (u16)IWL_CFG_ANY ||
   994                       dev_info->mac_type ==
   995                       CSR_HW_REV_TYPE(iwl_trans->hw_rev)) &&
   996                      (dev_info->mac_step == (u8)IWL_CFG_ANY ||
   997                       dev_info->mac_step ==
   998                       CSR_HW_REV_STEP(iwl_trans->hw_rev)) &&
   999                      (dev_info->rf_type == (u16)IWL_CFG_ANY ||
  1000                       dev_info->rf_type ==
  1001                       CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id)) &&
  1002                      (dev_info->rf_id == (u8)IWL_CFG_ANY ||
  1003                       dev_info->rf_id ==
  1004                       IWL_SUBDEVICE_RF_ID(pdev->subsystem_device)) &&
  1005                      (dev_info->no_160 == (u8)IWL_CFG_ANY ||
  1006                       dev_info->no_160 ==
  1007                       IWL_SUBDEVICE_NO_160(pdev->subsystem_device)) &&

IWL_SUBDEVICE_NO_160() is always zero because 0x100 >> 9 is zero.

  1008                      (dev_info->cores == (u8)IWL_CFG_ANY ||
  1009                       dev_info->cores ==
  1010                       IWL_SUBDEVICE_CORES(pdev->subsystem_device))) {
  1011                          iwl_trans->cfg = dev_info->cfg;
  1012                          iwl_trans->name = dev_info->name;
  1013                  }
  1014          }

regards,
dan carpenter
