Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4472CF08B
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgLDPPy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 10:15:54 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50880 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgLDPPx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 10:15:53 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4FDvWY112304;
        Fri, 4 Dec 2020 15:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=sKzUT9iTbAJ26R/YZ/f4H7e9oUPl3feVCxgPWIZg3GA=;
 b=LCWHHctXlF+Oq6C/3mySl3p2tLM5Bq59xarE9Mak+M460sKr0TxQhUEuJBl8abwbFTdp
 Gpy/Lw/M+vPZXyoc9XcfYotMFGUFTjdWiSoccxUq1XJmRzWpW16JY6SuvHV7LOTEpEjA
 cS+XxZT9fW2Kn8+Te92QrtRK5QN/TFpjlpuDCU4yyr6ia0uHGV+tuc86+xpdmF7iL/2y
 mbd8FJw/KZmZ9oeQpgtP/Br058Ypmnk5PseGg47oWqfp/Ufk3pSamO0L5M9VBOWzCAH8
 5qHQPpjxjCTRWcdlo7Z0j4P+tRlv6KXVj4ScpQZoqqQyjflVnImZLxWrGVwSp8TZmQ5i GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 353dyr3ny5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 04 Dec 2020 15:15:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B4F6G2j040763;
        Fri, 4 Dec 2020 15:15:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 3540f3ehnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Dec 2020 15:15:07 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B4FF5Ht019679;
        Fri, 4 Dec 2020 15:15:05 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 04 Dec 2020 07:15:04 -0800
Date:   Fri, 4 Dec 2020 18:14:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ku920601@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtw88: coex: add feature to enhance HID coexistence
 performance
Message-ID: <X8pSc4CnDcskUVvE@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=3 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=705
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012040088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9824 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1011 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=719
 suspectscore=3 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040089
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Ching-Te Ku,

The patch 5b2e9a35e456: "rtw88: coex: add feature to enhance HID
coexistence performance" from Nov 26, 2020, leads to the following
static checker warning:

	drivers/net/wireless/realtek/rtw88/coex.c:2099 rtw_coex_action_bt_a2dp_hid()
	error: uninitialized symbol 'interval'.

drivers/net/wireless/realtek/rtw88/coex.c
  2047  static void rtw_coex_action_bt_a2dp_hid(struct rtw_dev *rtwdev)
  2048  {
  2049          struct rtw_coex *coex = &rtwdev->coex;
  2050          struct rtw_coex_stat *coex_stat = &coex->stat;
  2051          struct rtw_coex_dm *coex_dm = &coex->dm;
  2052          struct rtw_efuse *efuse = &rtwdev->efuse;
  2053          struct rtw_chip_info *chip = rtwdev->chip;
  2054          u8 table_case, tdma_case, interval;
                                          ^^^^^^^^
  2055          u32 slot_type = 0;
  2056          bool is_toggle_table = false;
  2057  
  2058          slot_type = TDMA_4SLOT;
  2059  
  2060          rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], %s()\n", __func__);
  2061          rtw_coex_set_ant_path(rtwdev, false, COEX_SET_ANT_2G);
  2062          rtw_coex_set_rf_para(rtwdev, chip->wl_rf_para_rx[0]);
  2063  
  2064          if (efuse->share_ant) {
  2065                  /* Shared-Ant */
  2066                  if (coex_stat->bt_ble_exist) {
  2067                          table_case = 26; /* for RCU */
  2068                  } else if (coex_stat->bt_418_hid_exist) {
  2069                          table_case = 9;
  2070                          interval = 1;
                                ^^^^^^^^^^^^
The "interval" variable is only set here and not on the other paths.

  2071                  } else {
  2072                          table_case = 9;
  2073                  }
  2074  
  2075                  if (coex_stat->wl_connecting || !coex_stat->wl_gl_busy) {
  2076                          tdma_case = 14;
  2077                  } else if (coex_stat->bt_418_hid_exist) {
  2078                          is_toggle_table = true;
  2079                          tdma_case = 23;
  2080                  } else {
  2081                          tdma_case = 13;
  2082                  }
  2083          } else {
  2084                  /* Non-Shared-Ant */
  2085                  if (coex_stat->bt_ble_exist)
  2086                          table_case = 121;
  2087                  else
  2088                          table_case = 113;
  2089  
  2090                  if (COEX_RSSI_HIGH(coex_dm->wl_rssi_state[1]))
  2091                          tdma_case = 112;
  2092                  else
  2093                          tdma_case = 113;
  2094          }
  2095  
  2096          rtw_coex_table(rtwdev, false, table_case);
  2097          if (is_toggle_table) {
  2098                  rtw_btc_wltoggle_table_a(rtwdev, true, table_case);
  2099                  rtw_btc_wltoggle_table_b(rtwdev, false, interval, COEX_WL_SLOT_TOGLLE);
                                                                ^^^^^^^^

  2100          }
  2101          rtw_coex_tdma(rtwdev, false, tdma_case | slot_type);
  2102  }

regards,
dan carpenter
