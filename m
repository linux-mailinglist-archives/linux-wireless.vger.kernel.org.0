Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0AB7CD1
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 16:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbfISOaH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 10:30:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35958 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbfISOaH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 10:30:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JETUs9095797;
        Thu, 19 Sep 2019 14:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=qUbOStrVXIHQziILMTaLssQlXxHZRGFxJiMinEidD8U=;
 b=heZkjnR3s8LTqnoqhBsXPG3BUda+7I5Pe21Z93gRtLct+K2/LWCeDkZ/RZ7sW5hGoCwg
 o5GPhe45PwI+AGTCcTcKltMKEiuhwNCXnBJQo8yg7TDrxnWAkfFXD9Jjwt6aRpPtkW4l
 fCwk7Q5tt5fn359b3ZbQzSMEEvWvLyw0xKRxtwb5h5zzIvlZnrFdd4KQ45vCimx4Bu32
 3g9UO3a2ZBMcdgxu4PR+kYo/tpbOA/xkSgoGHWMTw0wIE68MydNMJyZF7GcfB4JNQBO4
 76WQ8USwpE5xdr6ppiO4PAUGm0s0rV8CX4s44R55VfNratw8DkBMT9XmYvF4vFUJPlq8 FA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2v3vb4ve4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 14:30:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8JEMkhU174094;
        Thu, 19 Sep 2019 14:30:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2v3vb5tjb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 14:30:03 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8JEU3cg023030;
        Thu, 19 Sep 2019 14:30:03 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Sep 2019 07:30:02 -0700
Date:   Thu, 19 Sep 2019 17:29:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     gil.adam@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: support per-platform antenna gain
Message-ID: <20190919142957.GA3554@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=2 spamscore=0 mlxscore=0 mlxlogscore=653
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909190136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9385 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=1 spamscore=0 clxscore=1011
 lowpriorityscore=1 mlxscore=0 impostorscore=0 mlxlogscore=733 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909190137
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Gil Adam,

The patch 6ce1e5c0c207: "iwlwifi: support per-platform antenna gain"
from Jun 16, 2019, leads to the following static checker warning:

	drivers/net/wireless/intel/iwlwifi/mvm/fw.c:1022 iwl_mvm_get_ppag_table()
	warn: passing a valid pointer to 'PTR_ERR'

drivers/net/wireless/intel/iwlwifi/mvm/fw.c
  1007  static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
  1008  {
  1009          union acpi_object *wifi_pkg, *data, *enabled;
  1010          int i, j, ret, tbl_rev;
  1011          int idx = 2;
  1012  
  1013          mvm->ppag_table.enabled = cpu_to_le32(0);
  1014          data = iwl_acpi_get_object(mvm->dev, ACPI_PPAG_METHOD);
  1015          if (IS_ERR(data))
  1016                  return PTR_ERR(data);
  1017  
  1018          wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
  1019                                           ACPI_PPAG_WIFI_DATA_SIZE, &tbl_rev);
  1020  
  1021          if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
                                        ^^^^^^^^^^^^
Should we set the error code if "tbl_rev" is wrong?

  1022                  ret = PTR_ERR(wifi_pkg);
  1023                  goto out_free;
  1024          }
  1025  
  1026          enabled = &wifi_pkg->package.elements[1];
  1027          if (enabled->type != ACPI_TYPE_INTEGER ||
  1028              (enabled->integer.value != 0 && enabled->integer.value != 1)) {
  1029                  ret = -EINVAL;
  1030                  goto out_free;
  1031          }

regards,
dan carpenter
