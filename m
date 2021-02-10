Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE4316478
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 11:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBJK7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 05:59:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39034 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhBJKz4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 05:55:56 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AAjITq177161;
        Wed, 10 Feb 2021 10:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=K0+MBTYB6e2lrriv26seIhs1rrL1dU7wLrW/utl/aPk=;
 b=gb0VeEWxzTCnHj1f+0MGfeEVnkkErKwZe0xH1FndDCNExx7b6bEmFrsXLaSn7j+Ii+1N
 nqA+1sjyr5zLSgLjqGDMmw3ei/hikGlzt8MeYQSuhAKuRD5Ky0VNPwEjOscZEqtPpKQZ
 x3EhwcLGre6ycyECKxY1K+crror1OT4oJ5gGPrgSNf96gThSDQ4b96QS4SKsQuP+IOPh
 swDvSb7sKf29JhWfr6HB6Xn6VlxEwDZiHkGseRlWR4jPKoz9+yFTUJt2Al6VGnv4Esom
 Q6uzC2mpFnWLpS3a+vH3NiJklhtJ0rGSqq+8OlClxMczyg8bO5o5e5jtQbZ96z3Dvqo4 Zw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36m4upseeu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 10:55:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11AAjw1V161181;
        Wed, 10 Feb 2021 10:55:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 36j4pq03st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 10:55:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11AAt3i0021866;
        Wed, 10 Feb 2021 10:55:03 GMT
Received: from mwanda (/10.175.183.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 10 Feb 2021 02:55:03 -0800
Date:   Wed, 10 Feb 2021 13:54:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     avraham.stern@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] iwlwifi: mvm: toggle tx antenna if tx fails during
 connection establishment
Message-ID: <YCO7gahK0ktH8YkY@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100106
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100106
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[ Sorry, I don't know why Smatch is warning about a three year old bug
  and I'm not sure that it's blaming the correct commit but the warning
  looks correct.  - dan ]

Hello Avraham Stern,

This is a semi-automatic email about new static checker warnings.

The patch 0dde2440a77f: "iwlwifi: mvm: toggle tx antenna if tx fails
during connection establishment" from Jul 11, 2018, leads to the
following Smatch complaint:

    drivers/net/wireless/intel/iwlwifi/mvm/tx.c:356 iwl_mvm_set_tx_cmd_rate()
    error: we previously assumed 'sta' could be null (see line 341)

drivers/net/wireless/intel/iwlwifi/mvm/tx.c
   340	
   341		if (ieee80211_is_data(fc) && sta) {
                                             ^^^
This assumes that "sta" can be NULL.

   342			struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
   343	
   344			if (mvmsta->sta_state >= IEEE80211_STA_AUTHORIZED) {
   345				tx_cmd->initial_rate_index = 0;
   346				tx_cmd->tx_flags |= cpu_to_le32(TX_CMD_FLG_STA_RATE);
   347				return;
   348			}
   349		} else if (ieee80211_is_back_req(fc)) {
   350			tx_cmd->tx_flags |=
   351				cpu_to_le32(TX_CMD_FLG_ACK | TX_CMD_FLG_BAR);
   352		}
   353	
   354		/* Set the rate in the TX cmd */
   355		tx_cmd->rate_n_flags =
   356			cpu_to_le32(iwl_mvm_get_tx_rate_n_flags(mvm, info, sta, fc));
                                                                           ^^^
It is dereferenced unconsiditionally inside the function.

   357	}
   358	

See also:
drivers/net/wireless/intel/iwlwifi/mvm/tx.c:486 iwl_mvm_set_tx_params() error: we previously assumed 'sta' could be null (see line 482)

regards,
dan carpenter
