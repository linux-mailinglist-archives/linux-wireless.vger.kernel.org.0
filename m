Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78692CD1FC
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Dec 2020 10:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgLCJCF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Dec 2020 04:02:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:40672 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgLCJCE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Dec 2020 04:02:04 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B38xVod146077;
        Thu, 3 Dec 2020 09:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=bRqUzkQwqugyqk/6XDRFOSP862Hmo1kn42iyW5F3VB4=;
 b=ikOQVoCSMIKWZB/5WsQyyGRVxGuwlHTVBD7hKEAEovxXcl//rjh9iDUmC6TcGb3TlGuP
 PyNuyt5LRHyx/410S9Ll7D4smlBZDFkpMiJgkBmiN+ZVDkL2GeMQgFckulowo/NDQDJr
 5ZdM0kEKzh+exiIPFzYWJdt1jeTlQJEbFWE0gN00TKu6ABkIfRXNaJHkmdSqN7XmVb+M
 FOpfLc7CjkYoeWGY14LbzoyHhj53HOu6FgJOnOAO76L/YUScQwqO8MGn8ztaJkaCQISX
 OxwTwprL0Ng9OMCaqCvP1vuZYGdYy+/0uSRnGuwT+iAND10fdWtoln/W2Bi0vv5aDz+K IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 353egkvmby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Dec 2020 09:01:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B38oN65158684;
        Thu, 3 Dec 2020 08:59:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3540avqdh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Dec 2020 08:59:17 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B38xGgf029392;
        Thu, 3 Dec 2020 08:59:16 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Dec 2020 00:59:15 -0800
Date:   Thu, 3 Dec 2020 11:59:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     pkshih@realtek.com
Cc:     linux-wireless@vger.kernel.org
Subject: [bug report] rtlwifi: 8192de: Reduce indentation and fix coding style
Message-ID: <X8io2e+H+Y7j8IxH@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=3
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030054
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9823 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=3
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012030055
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[ This code is predates your patch which just cleaned up the code. - dan ]

Hello Ping-Ke Shih,

The patch 3bde4ed3da38: "rtlwifi: 8192de: Reduce indentation and fix
coding style" from May 10, 2019, leads to the following static
checker warning:

	drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c:999 rtl92d_dm_txpower_tracking_callback_thermalmeter()
	error: buffer overflow 'ofdm_index' 2 <= 2 (assuming for loop doesn't break)

drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
   769  static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
   770                          struct ieee80211_hw *hw)
   771  {
   772          struct rtl_priv *rtlpriv = rtl_priv(hw);
   773          struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
   774          struct rtl_phy *rtlphy = &(rtlpriv->phy);
   775          struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
   776          u8 thermalvalue, delta, delta_lck, delta_iqk, delta_rxgain;
   777          u8 offset, thermalvalue_avg_count = 0;
   778          u32 thermalvalue_avg = 0;
   779          bool internal_pa = false;
   780          long ele_a = 0, ele_d, temp_cck, val_x, value32;
   781          long val_y, ele_c = 0;
   782          u8 ofdm_index[2];
                ^^^^^^^^^^^^^^^^
ofdm_index[] has two elements.

   783          s8 cck_index = 0;
   784          u8 ofdm_index_old[2] = {0, 0};
   785          s8 cck_index_old = 0;
   786          u8 index;
   787          int i;
   788          bool is2t = IS_92D_SINGLEPHY(rtlhal->version);
                ^^^^^^^^^^^
is2t is set here.

   789          u8 ofdm_min_index = 6, ofdm_min_index_internal_pa = 3, rf;
   790          u8 indexforchannel =
   791              rtl92d_get_rightchnlplace_for_iqk(rtlphy->current_channel);
   792          static const u8 index_mapping[5][INDEX_MAPPING_NUM] = {
   793                  /* 5G, path A/MAC 0, decrease power  */
   794                  {0, 1, 3, 6, 8, 9,      11, 13, 14, 16, 17, 18, 18},
   795                  /* 5G, path A/MAC 0, increase power  */

[ snip ]

   830          rtl92d_phy_ap_calibrate(hw, (thermalvalue -
   831                                       rtlefuse->eeprom_thermalmeter));
   832  
   833          if (!thermalvalue)
   834                  goto exit;
   835  
   836          if (is2t)
   837                  rf = 2;
   838          else
   839                  rf = 1;

"rf" is either 1 or 2 depending on "is2t".

   840  
   841          if (rtlpriv->dm.thermalvalue && !rtlhal->reloadtxpowerindex)
   842                  goto old_index_done;
   843  
   844          ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,  MASKDWORD) & MASKOFDM_D;

[ snip ]

   983                  rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
   984                          "temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
   985                          rtlpriv->dm.ofdm_index[0],
   986                          rtlpriv->dm.cck_index);
   987          }
   988          for (i = 0; i < rf; i++) {
   989                  if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1)
   990                          ofdm_index[i] = OFDM_TABLE_SIZE_92D - 1;
   991                  else if (ofdm_index[i] < ofdm_min_index)
   992                          ofdm_index[i] = ofdm_min_index;
   993          }

i is equal to "rf" after this loop.

   994          if (rtlhal->current_bandtype == BAND_ON_2_4G) {
   995                  if (cck_index > CCK_TABLE_SIZE - 1) {
   996                          cck_index = CCK_TABLE_SIZE - 1;
   997                  } else if (internal_pa ||
   998                             rtlhal->current_bandtype == BAND_ON_2_4G) {
   999                          if (ofdm_index[i] < ofdm_min_index_internal_pa)
                                    ^^^^^^^^^^^^^
  1000                                  ofdm_index[i] = ofdm_min_index_internal_pa;
                                        ^^^^^^^^^^^^^

Using "i" after we exited the loop without hitting a break looks wrong
to me.  It's potentially correct if we know that "is2t" is false but how
do we know that?

  1001                  } else if (cck_index < 0) {
  1002                          cck_index = 0;
  1003                  }
  1004          }
  1005          if (is2t) {
  1006                  rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
  1007                          "new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
  1008                          ofdm_index[0], ofdm_index[1],
  1009                          cck_index);

regards,
dan carpenter
