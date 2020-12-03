Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A863F2CD22D
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 10:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbgLCJJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 04:09:20 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388304AbgLCJJT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 04:09:19 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B3951RQ166947;
        Thu, 3 Dec 2020 09:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=SrA+odAgtquR/b/EWd2rjq/Px0ixDA0I4TC7Et9m7zE=;
 b=XbtUWIcyg3TAkM0GjGjghS8ihZnh8zgP2Cgr2W7ctNqr3qwZYX8LLrD6cBktRCZZ8QXb
 fbwBxu4e30ar+VHa7WgOH3KrxFD6P8Fk4ps1mKQxQ5dG2oDSiYNkxlOhJIzjwehy9hnG
 G6i4MOax2PNoeftvcJlgM8UJYRJYs6XvcCS7ffce/8f2zAYTBBF4MIWS40USH6xLFFpc
 BZWYz3qEVSlpfbHQJRxopRHIW2Xq2SCT5DWd3pjR1YPRdEZa53YiPaYdzHmdZujw2u2Q
 T38KLtp1Ypb+6U2gilCzdj807xiozP/oNOL0fYa3qqe752H3wBDomsKry7lfUOoVP/jt 2g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 353egkvn9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 09:08:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B396TSJ016369;
        Thu, 3 Dec 2020 09:08:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 35404qgw73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 09:08:36 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B398abs015414;
        Thu, 3 Dec 2020 09:08:36 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 01:08:35 -0800
Date:   Thu, 3 Dec 2020 12:08:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: support REDUCE_TX_POWER_CMD version 6
Message-ID: <X8irC3FP0QDE9QFe@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=767 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=3
 phishscore=0 mlxlogscore=781 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030056
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Luca Coelho,

The patch fbb7957d28ac: "iwlwifi: support REDUCE_TX_POWER_CMD version
6" from Sep 28, 2020, leads to the following static checker warning:

	drivers/net/wireless/intel/iwlwifi/fw/acpi.c:462 iwl_sar_fill_table()
	error: buffer overflow 'prof->table' 10 <= 15

drivers/net/wireless/intel/iwlwifi/fw/acpi.c
   422  static int iwl_sar_fill_table(struct iwl_fw_runtime *fwrt,
   423                                __le16 *per_chain, u32 n_subbands,
   424                                int prof_a, int prof_b)

Original n_subbands was ACPI_SAR_NUM_SUB_BANDS (5) but now it can be
IWL_NUM_SUB_BANDS_V2 (11) as well.

   425  {
   426          int profs[ACPI_SAR_NUM_CHAIN_LIMITS] = { prof_a, prof_b };
   427          int i, j, idx;
   428  
   429          for (i = 0; i < ACPI_SAR_NUM_CHAIN_LIMITS; i++) {
   430                  struct iwl_sar_profile *prof;
   431  
   432                  /* don't allow SAR to be disabled (profile 0 means disable) */
   433                  if (profs[i] == 0)
   434                          return -EPERM;
   435  
   436                  /* we are off by one, so allow up to ACPI_SAR_PROFILE_NUM */
   437                  if (profs[i] > ACPI_SAR_PROFILE_NUM)
   438                          return -EINVAL;
   439  
   440                  /* profiles go from 1 to 4, so decrement to access the array */
   441                  prof = &fwrt->sar_profiles[profs[i] - 1];
   442  
   443                  /* if the profile is disabled, do nothing */
   444                  if (!prof->enabled) {
   445                          IWL_DEBUG_RADIO(fwrt, "SAR profile %d is disabled.\n",
   446                                          profs[i]);
   447                          /*
   448                           * if one of the profiles is disabled, we
   449                           * ignore all of them and return 1 to
   450                           * differentiate disabled from other failures.
   451                           */
   452                          return 1;
   453                  }
   454  
   455                  IWL_DEBUG_INFO(fwrt,
   456                                 "SAR EWRD: chain %d profile index %d\n",
   457                                 i, profs[i]);
   458                  IWL_DEBUG_RADIO(fwrt, "  Chain[%d]:\n", i);
   459                  for (j = 0; j < n_subbands; j++) {
   460                          idx = i * ACPI_SAR_NUM_SUB_BANDS + j;
   461                          per_chain[i * n_subbands + j] =
   462                                  cpu_to_le16(prof->table[idx]);
                                                    ^^^^^^^^^^^^^^^^
But this table size wasn't increased so potentially we're reading beyond
the end of the array?

   463                          IWL_DEBUG_RADIO(fwrt, "    Band[%d] = %d * .125dBm\n",
   464                                          j, prof->table[idx]);
                                                   ^^^^^^^^^^^^^^^^
   465                  }
   466          }
   468          return 0;
   469  }

regards,
dan carpenter
