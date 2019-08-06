Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83A97833E4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfHFOZE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 10:25:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44546 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHFOZE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 10:25:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76ENlfK140643;
        Tue, 6 Aug 2019 14:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=Fp9GAdiPrRuSQrsOAIrSsWJLshutiUuouZc0Z6OcFsQ=;
 b=T1V/NuNC7pSWrdX3NIgkXMOxmbr2jknMaOs9CdCsQ57KFD9fDA36XJcQKENTuLVX/JyH
 XHhlsdAfdiENLZOIQpn0fcbr3T0Appsiv8D6W/5TsPqR4tPjQO5qdweoMAcNCBfvSH5s
 tzOElkbK7kCxoDT7y3RWkCrvzHT9pzKzvIAh/+io4P+hiRVSoAbL3nTzpZdsDYvTKK1a
 oVntl9PFSOJlyszoqUBCk+OzHZroM/FXXFy6lKLsKCLxypmB/mwOxPk67IFkcKGQkfmZ
 x9IRZNO7/otvunPDW42IOaS7VUYi2sBz90GmXj9H6dIJLMzvqMXS9Suo8g1gp8P/wAYK jA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2u52wr6fyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 14:24:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76ENUqt160498;
        Tue, 6 Aug 2019 14:24:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2u763gsy38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 14:24:59 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x76EOwBT008099;
        Tue, 6 Aug 2019 14:24:58 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 07:24:58 -0700
Date:   Tue, 6 Aug 2019 17:24:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     haim.dreyfuss@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: Add support for SAR South Korea limitation
Message-ID: <20190806142435.GA13072@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=607
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=654 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060145
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Haim Dreyfuss,

The patch 0c3d7282233c: "iwlwifi: Add support for SAR South Korea
limitation" from Feb 27, 2019, leads to the following static checker
warning:

	drivers/net/wireless/intel/iwlwifi/fw/acpi.c:166 iwl_acpi_get_mcc()
	warn: passing a valid pointer to 'PTR_ERR'

drivers/net/wireless/intel/iwlwifi/fw/acpi.c
   153  int iwl_acpi_get_mcc(struct device *dev, char *mcc)
   154  {
   155          union acpi_object *wifi_pkg, *data;
   156          u32 mcc_val;
   157          int ret, tbl_rev;
   158  
   159          data = iwl_acpi_get_object(dev, ACPI_WRDD_METHOD);
   160          if (IS_ERR(data))
   161                  return PTR_ERR(data);
   162  
   163          wifi_pkg = iwl_acpi_get_wifi_pkg(dev, data, ACPI_WRDD_WIFI_DATA_SIZE,
   164                                           &tbl_rev);
   165          if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
                                        ^^^^^^^^^^^^
wifi_pkg is not a valid error code.  Also it feels like it might be more
future proof to blacklist rev 1 instead of whitelisting rev 0.

   166                  ret = PTR_ERR(wifi_pkg);
   167                  goto out_free;
   168          }
   169  
   170          if (wifi_pkg->package.elements[1].type != ACPI_TYPE_INTEGER) {
   171                  ret = -EINVAL;
   172                  goto out_free;
   173          }
   174  
   175          mcc_val = wifi_pkg->package.elements[1].integer.value;
   176  
   177          mcc[0] = (mcc_val >> 8) & 0xff;
   178          mcc[1] = mcc_val & 0xff;
   179          mcc[2] = '\0';
   180  
   181          ret = 0;
   182  out_free:
   183          kfree(data);
   184          return ret;
   185  }

regards,
dan carpenter
