Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F21C734B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 16:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgEFOtI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 10:49:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57746 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgEFOtI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 10:49:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046EhFUX157433;
        Wed, 6 May 2020 14:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=mxNfavGfe7vYdijPtGwnwJWm7JTQMM+KiVmIlYF/Uyg=;
 b=O47/RomRbeuHrUmJn8TnRjgVzEEa7M0DOLRkTwwGkUzGz5vF+w09lni9zwSE1OQyOMze
 fR1KpZd1ECmPT52f2JwJ/ZMfKh+1kq0lOGPZJ4hKHKZ059GDXxFFgO0dhrxmdv+Hcoux
 I+ShS0hQqmCj3y4xkm3VypBTZnhUNRQE9X2xDpk24tGglk1zBaoPeinimnXd0QgfjCLf
 gXfND5uabKyn2DmSVQ4GbRWAioIx76uCERMlH85+ZNNNqJVecwK7l4DbyHdr38HY78vt
 Z0i38knLTaJibEnz1m70zR0SPlppoEEvBvAj1BbhW9epOV9MF5xTIAH9Kjx3pF5GcUIB Ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30usgq1wbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 14:49:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046EkttH183245;
        Wed, 6 May 2020 14:47:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdvnywc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 14:47:05 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046El3Ud006792;
        Wed, 6 May 2020 14:47:04 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 07:47:03 -0700
Date:   Wed, 6 May 2020 17:46:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     shahar.s.matityahu@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: dbg: support multiple dumps in legacy dump flow
Message-ID: <20200506144657.GA115454@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=10 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=655 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9613 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=715 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=10 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060117
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Shahar S Matityahu,

This is a semi-automatic email about new static checker warnings.

The patch 7a99c877ae8e: "iwlwifi: dbg: support multiple dumps in 
legacy dump flow" from Apr 17, 2020, leads to the following Smatch 
complaint:

    drivers/net/wireless/intel/iwlwifi/fw/dbg.c:2182 iwl_fw_free_dump_desc()
    error: we previously assumed 'desc' could be null (see line 2179)

drivers/net/wireless/intel/iwlwifi/fw/dbg.c
  2178	{
  2179		if (desc && *desc != &iwl_dump_desc_assert)
                    ^^^^
New check for NULL

  2180			kfree(*desc);
  2181	
  2182		*desc = NULL;
                ^^^^^
New unchecked dereference.

  2183		fwrt->dump.lmac_err_id[0] = 0;
  2184		if (fwrt->smem_cfg.num_lmacs > 1)

regards,
dan carpenter
