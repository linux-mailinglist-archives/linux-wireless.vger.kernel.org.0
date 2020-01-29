Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB6714C8C8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 11:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgA2Ke4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 05:34:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55774 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2Ke4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 05:34:56 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TANLMg068813;
        Wed, 29 Jan 2020 10:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=QFtwn2bpK8wEKShSizFhDFOQZoZyxhR8RogebRUqGrs=;
 b=TjeBIETpEeeeF7GXi82b5Us+qAcVEQZeu6WCOAdFB44ebOLodIypzOoLZ/S++GlZnjaS
 hrRvOStntP4bsybaFlvn82Fs/3snrsUvwEj9U1aomAUySqFUUQS+XpKVOdeXEzI3dmld
 6h7LyAiU+n4JwXrAt5lhfyTcTJ9uvIfC7yXdwNwGhO/C+AVo/VVW+TYR0VX4O/jneav+
 AMK/cTceEVHnjHoEbCF9JVFxJ5PZVA14c/0cPdBjRdYlwcfKNgksuqz0q33oW/OH5XIs
 za8d3P16s75F0/u1iVU9vApy0f5qJ3X2oH36PG2nkFeQaaEHXrh2aLHxoJovriB7tlnE xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xrearbxcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 10:34:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00TAORhM063446;
        Wed, 29 Jan 2020 10:34:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2xth5jvar1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jan 2020 10:34:52 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00TAYp0d019213;
        Wed, 29 Jan 2020 10:34:52 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jan 2020 02:34:51 -0800
Date:   Wed, 29 Jan 2020 13:34:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: implement a new device configuration table
Message-ID: <20200129103445.5cngpvhjktmvt57i@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=891
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001290086
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9514 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=956 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001290086
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Luca Coelho,

The patch 2a612a60ab44: "iwlwifi: implement a new device
configuration table" from Oct 10, 2019, leads to the following static
checker warning:

    drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1034 iwl_pci_probe()
    warn: impossible condition '(dev_info->device == (~0)) => (0-u16max == (-1))'

    drivers/net/wireless/intel/iwlwifi/pcie/drv.c:1036 iwl_pci_probe()
    warn: impossible condition '(dev_info->subdevice == (~0)) => (0-u16max == (-1))'

drivers/net/wireless/intel/iwlwifi/pcie/drv.c
  1029          iwl_trans->trans_cfg = trans;
  1030  
  1031          for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
  1032                  const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
  1033  
  1034                  if ((dev_info->device == IWL_CFG_ANY ||
                                                 ^^^^^^^^^^^
A u16 can't be -1.

  1035                       dev_info->device == pdev->device) &&
  1036                      (dev_info->subdevice == IWL_CFG_ANY ||
                                                    ^^^^^^^^^^^

  1037                       dev_info->subdevice == pdev->subsystem_device)) {
  1038                          iwl_trans->cfg = dev_info->cfg;
  1039                          iwl_trans->name = dev_info->name;
  1040                          goto found;
  1041                  }
  1042          }


regards,
dan carpenter
