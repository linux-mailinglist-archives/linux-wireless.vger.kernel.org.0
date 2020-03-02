Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE4181756F0
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 10:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgCBJYO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 04:24:14 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:42172 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCBJYO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 04:24:14 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0229O47w115727;
        Mon, 2 Mar 2020 09:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=L5s/2KkDnKUQeUzW5nA0QlVvM5PRywVEFDW/9xkZqu0=;
 b=vwz+88AVmnLeBh9tg06tbIxapFTTr4jkPmjIlTiT/9Nl6ezB+jHa0NgZZRM3M5y2Egyq
 ieMlYV6eE9isVKwlOTBxwrTHrurU+OCspxirawvJ/2Vz2bds3meZNzfGW6AI4433iu1j
 7qmGvx8hxmxDT97jj4N0/aoAfee5TYlhXCAAgcB23vMq9MfyQhoWDa5d2sp4EcD7HYAg
 f5O/5thS+gecYABLk+thRzW/V4sOz1NzWA4VAHNUy8vfKcWOIp1AOAaLmZ5WYz2u45Ok
 aIgwWapxoRUPeSJxE+y6RwN4G7l5zCuYIS7ngmELBO9tQFy7PVGgexMG80n7dE3q4+Ju NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2yffwqee52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 09:24:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0229IijF189919;
        Mon, 2 Mar 2020 09:24:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yg1p18qbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Mar 2020 09:24:01 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0229O04u019668;
        Mon, 2 Mar 2020 09:24:00 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Mar 2020 01:23:56 -0800
Date:   Mon, 2 Mar 2020 12:23:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, Venkateswara.Kaja@microchip.com,
        gregkh@linuxfoundation.org, Nicolas.Ferre@microchip.com,
        Adham.Abozaeid@microchip.com, johannes@sipsolutions.net
Subject: Re: [PATCH v3 00/18] wilc1000: move out of staging
Message-ID: <20200302092346.GA24308@kadam>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225074105.7740-1-ajay.kathat@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9547 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003020073
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are a few static checker warnings from Friday's linux-next.  Only
the first one is important.  (Not all these Smatch warnings have been
published).

drivers/staging/wilc1000/hif.c:804 wilc_hif_pack_sta_param() warn: '&params->ht_capa' sometimes too small '8' size = 29

drivers/staging/wilc1000/hif.c
   787  static void wilc_hif_pack_sta_param(u8 *cur_byte, const u8 *mac,
   788                                      struct station_parameters *params)
   789  {
   790          ether_addr_copy(cur_byte, mac);
   791          cur_byte += ETH_ALEN;
   792  
   793          put_unaligned_le16(params->aid, cur_byte);
   794          cur_byte += 2;
   795  
   796          *cur_byte++ = params->supported_rates_len;
   797          if (params->supported_rates_len > 0)
   798                  memcpy(cur_byte, params->supported_rates,
   799                         params->supported_rates_len);
   800          cur_byte += params->supported_rates_len;
   801  
   802          if (params->ht_capa) {
   803                  *cur_byte++ = true;
   804                  memcpy(cur_byte, &params->ht_capa,
                                         ^^^^^^^^^^^^^^^^
This is copying the wrong data.  The "&" is wrong.

   805                         sizeof(struct ieee80211_ht_cap));
   806          } else {
   807                  *cur_byte++ = false;
   808          }
   809          cur_byte += sizeof(struct ieee80211_ht_cap);
   810  
   811          put_unaligned_le16(params->sta_flags_mask, cur_byte);
   812          cur_byte += 2;
   813          put_unaligned_le16(params->sta_flags_set, cur_byte);
   814  }


drivers/staging/wilc1000/cfg80211.c:904 del_pmksa() warn: 'i < priv->pmkid_list.numpmkid' 'true' implies 'priv->pmkid_list.numpmkid > 0' is 'true'

drivers/staging/wilc1000/cfg80211.c
   887  static int del_pmksa(struct wiphy *wiphy, struct net_device *netdev,
   888                       struct cfg80211_pmksa *pmksa)
   889  {
   890          u32 i;
   891          int ret = 0;
   892          struct wilc_vif *vif = netdev_priv(netdev);
   893          struct wilc_priv *priv = &vif->priv;
   894  
   895          for (i = 0; i < priv->pmkid_list.numpmkid; i++) {
   896                  if (!memcmp(pmksa->bssid, priv->pmkid_list.pmkidlist[i].bssid,
   897                              ETH_ALEN)) {
   898                          memset(&priv->pmkid_list.pmkidlist[i], 0,
   899                                 sizeof(struct wilc_pmkid));
   900                          break;
   901                  }
   902          }
   903  
   904          if (i < priv->pmkid_list.numpmkid && priv->pmkid_list.numpmkid > 0) {
                                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This part of the condition is a given (must be true).  Delete it.  It's
better to reverse the test and say:

	if (i == priv->pmkid_list.numpmkid)
		return -EINVAL;

   905                  for (; i < (priv->pmkid_list.numpmkid - 1); i++) {
   906                          memcpy(priv->pmkid_list.pmkidlist[i].bssid,
   907                                 priv->pmkid_list.pmkidlist[i + 1].bssid,
   908                                 ETH_ALEN);
   909                          memcpy(priv->pmkid_list.pmkidlist[i].pmkid,
   910                                 priv->pmkid_list.pmkidlist[i + 1].pmkid,
   911                                 WLAN_PMKID_LEN);
   912                  }
   913                  priv->pmkid_list.numpmkid--;
   914          } else {
   915                  ret = -EINVAL;
   916          }
   917  
   918          return ret;
   919  }


drivers/staging/wilc1000/wlan.c:706 wilc_wlan_handle_rx_buff() warn: 'pkt_len' 'true' implies 'pkt_len > 0' is 'true'

drivers/staging/wilc1000/wlan.c
   686          int is_cfg_packet;
   687          u8 *buff_ptr;
   688  
   689          do {
   690                  buff_ptr = buffer + offset;
   691                  header = get_unaligned_le32(buff_ptr);
   692  
   693                  is_cfg_packet = FIELD_GET(WILC_PKT_HDR_CONFIG_FIELD, header);
   694                  pkt_offset = FIELD_GET(WILC_PKT_HDR_OFFSET_FIELD, header);
   695                  tp_len = FIELD_GET(WILC_PKT_HDR_TOTAL_LEN_FIELD, header);
   696                  pkt_len = FIELD_GET(WILC_PKT_HDR_LEN_FIELD, header);
   697  
   698                  if (pkt_len == 0 || tp_len == 0)
                            ^^^^^^^^^^^^

   699                          break;
   700  
   701                  if (pkt_offset & IS_MANAGMEMENT) {
   702                          buff_ptr += HOST_HDR_OFFSET;
   703                          wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len);
   704                  } else {
   705                          if (!is_cfg_packet) {
   706                                  if (pkt_len > 0) {
                                            ^^^^^^^^^^^
Delete.

   707                                          wilc_frmw_to_host(wilc, buff_ptr,
   708                                                            pkt_len, pkt_offset);
   709                                  }
   710                          } else {
   711                                  struct wilc_cfg_rsp rsp;
   712  
   713                                  buff_ptr += pkt_offset;
   714  

regards,
dan carpenter

