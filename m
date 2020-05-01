Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57B61C0C02
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 04:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgEACOQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 22:14:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:16691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgEACOQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 22:14:16 -0400
IronPort-SDR: XCDbq7LW7sZ6bMWp2xkM7dXDMojsi0N6c8EtnSAOcW4SnYTPVy7E8YTjjwuiDN0UKItL813JeS
 A10w+WxvS4og==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 19:14:13 -0700
IronPort-SDR: 2TaF+7K7sxYe3g7lMSUR8tNCAu8HNhPnA58YL891mQVnsPCVjUsT78oQIIEduNvrMKY0Q8+kXj
 cv3uIqV6zuUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,338,1583222400"; 
   d="scan'208";a="294707433"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 30 Apr 2020 19:14:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jULBq-0005tc-GG; Fri, 01 May 2020 10:14:10 +0800
Date:   Fri, 1 May 2020 10:14:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     John Crispin <john@phrozen.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: Re: [PATCH V3 3/3] ath11k: add support for setting fixed HE
 rate/gi/ltf
Message-ID: <202005011012.mVlArqn5%lkp@intel.com>
References: <20200429145708.25992-3-john@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429145708.25992-3-john@phrozen.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi John,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mac80211/master]
[also build test WARNING on ath6kl/ath-next v5.7-rc3]
[cannot apply to mac80211-next/master next-20200430]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/John-Crispin/nl80211-add-support-for-setting-fixed-HE-rate-gi-ltf/20200430-040802
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-191-gc51a0382-dirty
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/ath/ath11k/mac.c:1310:27: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got tricted __le16 [usertype] v @@
>> drivers/net/wireless/ath/ath11k/mac.c:1310:27: sparse:    expected restricted __le16 [usertype] v
>> drivers/net/wireless/ath/ath11k/mac.c:1310:27: sparse:    got unsigned short [usertype]
>> drivers/net/wireless/ath/ath11k/mac.c:1311:83: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le16unsigned int @@
>> drivers/net/wireless/ath/ath11k/mac.c:1311:83: sparse:    expected unsigned int
>> drivers/net/wireless/ath/ath11k/mac.c:1311:83: sparse:    got restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1313:27: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got tricted __le16 [usertype] v @@
   drivers/net/wireless/ath/ath11k/mac.c:1313:27: sparse:    expected restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1313:27: sparse:    got unsigned short [usertype]
>> drivers/net/wireless/ath/ath11k/mac.c:1314:58: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned short [assigned] [usertype] tx_mcs_set @@    got  short [assigned] [usertype] tx_mcs_set @@
>> drivers/net/wireless/ath/ath11k/mac.c:1314:58: sparse:    expected unsigned short [assigned] [usertype] tx_mcs_set
   drivers/net/wireless/ath/ath11k/mac.c:1314:58: sparse:    got restricted __le16 [usertype] v
>> drivers/net/wireless/ath/ath11k/mac.c:1314:27: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got 16 [usertype] v @@
   drivers/net/wireless/ath/ath11k/mac.c:1314:27: sparse:    expected restricted __le16 [usertype] v
>> drivers/net/wireless/ath/ath11k/mac.c:1314:27: sparse:    got unsigned short
   drivers/net/wireless/ath/ath11k/mac.c:1315:83: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le16unsigned int @@
   drivers/net/wireless/ath/ath11k/mac.c:1315:83: sparse:    expected unsigned int
   drivers/net/wireless/ath/ath11k/mac.c:1315:83: sparse:    got restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1320:19: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got tricted __le16 [usertype] v @@
   drivers/net/wireless/ath/ath11k/mac.c:1320:19: sparse:    expected restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1320:19: sparse:    got unsigned short [usertype]
   drivers/net/wireless/ath/ath11k/mac.c:1321:73: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le16unsigned int @@
   drivers/net/wireless/ath/ath11k/mac.c:1321:73: sparse:    expected unsigned int
   drivers/net/wireless/ath/ath11k/mac.c:1321:73: sparse:    got restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1323:19: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got tricted __le16 [usertype] v @@
   drivers/net/wireless/ath/ath11k/mac.c:1323:19: sparse:    expected restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1323:19: sparse:    got unsigned short [usertype]
   drivers/net/wireless/ath/ath11k/mac.c:1324:50: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned short [assigned] [usertype] tx_mcs_set @@    got  short [assigned] [usertype] tx_mcs_set @@
   drivers/net/wireless/ath/ath11k/mac.c:1324:50: sparse:    expected unsigned short [assigned] [usertype] tx_mcs_set
   drivers/net/wireless/ath/ath11k/mac.c:1324:50: sparse:    got restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1324:19: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got 16 [usertype] v @@
   drivers/net/wireless/ath/ath11k/mac.c:1324:19: sparse:    expected restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1324:19: sparse:    got unsigned short
   drivers/net/wireless/ath/ath11k/mac.c:1325:73: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le16unsigned int @@
   drivers/net/wireless/ath/ath11k/mac.c:1325:73: sparse:    expected unsigned int
   drivers/net/wireless/ath/ath11k/mac.c:1325:73: sparse:    got restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1333:19: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got tricted __le16 [usertype] v @@
   drivers/net/wireless/ath/ath11k/mac.c:1333:19: sparse:    expected restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1333:19: sparse:    got unsigned short [usertype]
   drivers/net/wireless/ath/ath11k/mac.c:1334:72: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le16unsigned int @@
   drivers/net/wireless/ath/ath11k/mac.c:1334:72: sparse:    expected unsigned int
   drivers/net/wireless/ath/ath11k/mac.c:1334:72: sparse:    got restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1336:19: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got tricted __le16 [usertype] v @@
   drivers/net/wireless/ath/ath11k/mac.c:1336:19: sparse:    expected restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1336:19: sparse:    got unsigned short [usertype]
   drivers/net/wireless/ath/ath11k/mac.c:1337:50: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned short [assigned] [usertype] tx_mcs_set @@    got  short [assigned] [usertype] tx_mcs_set @@
   drivers/net/wireless/ath/ath11k/mac.c:1337:50: sparse:    expected unsigned short [assigned] [usertype] tx_mcs_set
   drivers/net/wireless/ath/ath11k/mac.c:1337:50: sparse:    got restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1337:19: sparse: sparse: incorrect type in assignment (different base types) @@    expected restricted __le16 [usertype] v @@    got 16 [usertype] v @@
   drivers/net/wireless/ath/ath11k/mac.c:1337:19: sparse:    expected restricted __le16 [usertype] v
   drivers/net/wireless/ath/ath11k/mac.c:1337:19: sparse:    got unsigned short
   drivers/net/wireless/ath/ath11k/mac.c:1338:72: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int @@    got restricted __le16unsigned int @@
   drivers/net/wireless/ath/ath11k/mac.c:1338:72: sparse:    expected unsigned int
   drivers/net/wireless/ath/ath11k/mac.c:1338:72: sparse:    got restricted __le16 [usertype] v
>> drivers/net/wireless/ath/ath11k/mac.c:5292:47: sparse: sparse: incorrect type in return expression (different base types) @@    expected unsigned short @@    got restricted __le16 conunsigned short @@
>> drivers/net/wireless/ath/ath11k/mac.c:5292:47: sparse:    expected unsigned short
>> drivers/net/wireless/ath/ath11k/mac.c:5292:47: sparse:    got restricted __le16 const [usertype] tx_mcs_80p80
   drivers/net/wireless/ath/ath11k/mac.c:5296:47: sparse: sparse: incorrect type in return expression (different base types) @@    expected unsigned short @@    got restricted __le16 conunsigned short @@
   drivers/net/wireless/ath/ath11k/mac.c:5296:47: sparse:    expected unsigned short
>> drivers/net/wireless/ath/ath11k/mac.c:5296:47: sparse:    got restricted __le16 const [usertype] tx_mcs_160
   drivers/net/wireless/ath/ath11k/mac.c:5298:39: sparse: sparse: incorrect type in return expression (different base types) @@    expected unsigned short @@    got restricted __le16 conunsigned short @@
   drivers/net/wireless/ath/ath11k/mac.c:5298:39: sparse:    expected unsigned short
>> drivers/net/wireless/ath/ath11k/mac.c:5298:39: sparse:    got restricted __le16 const [usertype] tx_mcs_80
>> drivers/net/wireless/ath/ath11k/mac.c:5288:5: sparse: sparse: symbol 'ath11k_mac_get_tx_mcs_map' was not declared. Should it be static?
>> drivers/net/wireless/ath/ath11k/mac.c:5339:22: sparse: sparse: cast to restricted __le16

Please review and possibly fold the followup patch.

vim +1310 drivers/net/wireless/ath/ath11k/mac.c

f4740f8f367c7c Miles Hu     2020-04-29  1231  
d5c65159f28953 Kalle Valo   2019-11-23  1232  static void ath11k_peer_assoc_h_he(struct ath11k *ar,
d5c65159f28953 Kalle Valo   2019-11-23  1233  				   struct ieee80211_vif *vif,
d5c65159f28953 Kalle Valo   2019-11-23  1234  				   struct ieee80211_sta *sta,
d5c65159f28953 Kalle Valo   2019-11-23  1235  				   struct peer_assoc_params *arg)
d5c65159f28953 Kalle Valo   2019-11-23  1236  {
f4740f8f367c7c Miles Hu     2020-04-29  1237  	struct ath11k_vif *arvif = (void *)vif->drv_priv;
f4740f8f367c7c Miles Hu     2020-04-29  1238  	struct cfg80211_chan_def def;
9f056ed8ee01ad John Crispin 2019-11-25  1239  	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
f4740f8f367c7c Miles Hu     2020-04-29  1240  	enum nl80211_band band;
f4740f8f367c7c Miles Hu     2020-04-29  1241  	const u16 *he_mcs_mask;
f4740f8f367c7c Miles Hu     2020-04-29  1242  	u8 max_nss, he_mcs;
f4740f8f367c7c Miles Hu     2020-04-29  1243  	__le16 he_tx_mcs = 0, v = 0;
f4740f8f367c7c Miles Hu     2020-04-29  1244  	int i;
f4740f8f367c7c Miles Hu     2020-04-29  1245  
f4740f8f367c7c Miles Hu     2020-04-29  1246  	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
f4740f8f367c7c Miles Hu     2020-04-29  1247  		return;
9f056ed8ee01ad John Crispin 2019-11-25  1248  
9f056ed8ee01ad John Crispin 2019-11-25  1249  	if (!he_cap->has_he)
9f056ed8ee01ad John Crispin 2019-11-25  1250  		return;
9f056ed8ee01ad John Crispin 2019-11-25  1251  
f4740f8f367c7c Miles Hu     2020-04-29  1252  	band = def.chan->band;
f4740f8f367c7c Miles Hu     2020-04-29  1253  	he_mcs_mask = arvif->bitrate_mask.control[band].he_mcs;
f4740f8f367c7c Miles Hu     2020-04-29  1254  
f4740f8f367c7c Miles Hu     2020-04-29  1255  	if (ath11k_peer_assoc_h_he_masked(he_mcs_mask))
f4740f8f367c7c Miles Hu     2020-04-29  1256  		return;
f4740f8f367c7c Miles Hu     2020-04-29  1257  
9f056ed8ee01ad John Crispin 2019-11-25  1258  	arg->he_flag = true;
9f056ed8ee01ad John Crispin 2019-11-25  1259  
9f056ed8ee01ad John Crispin 2019-11-25  1260  	memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
9f056ed8ee01ad John Crispin 2019-11-25  1261  	       sizeof(arg->peer_he_cap_macinfo));
9f056ed8ee01ad John Crispin 2019-11-25  1262  	memcpy(&arg->peer_he_cap_phyinfo, he_cap->he_cap_elem.phy_cap_info,
9f056ed8ee01ad John Crispin 2019-11-25  1263  	       sizeof(arg->peer_he_cap_phyinfo));
9f056ed8ee01ad John Crispin 2019-11-25  1264  	memcpy(&arg->peer_he_ops, &vif->bss_conf.he_operation,
9f056ed8ee01ad John Crispin 2019-11-25  1265  	       sizeof(arg->peer_he_ops));
9f056ed8ee01ad John Crispin 2019-11-25  1266  
9f056ed8ee01ad John Crispin 2019-11-25  1267  	/* the top most byte is used to indicate BSS color info */
9f056ed8ee01ad John Crispin 2019-11-25  1268  	arg->peer_he_ops &= 0xffffff;
9f056ed8ee01ad John Crispin 2019-11-25  1269  
9f056ed8ee01ad John Crispin 2019-11-25  1270  	if (he_cap->he_cap_elem.phy_cap_info[6] &
9f056ed8ee01ad John Crispin 2019-11-25  1271  	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
9f056ed8ee01ad John Crispin 2019-11-25  1272  		int bit = 7;
9f056ed8ee01ad John Crispin 2019-11-25  1273  		int nss, ru;
9f056ed8ee01ad John Crispin 2019-11-25  1274  
9f056ed8ee01ad John Crispin 2019-11-25  1275  		arg->peer_ppet.numss_m1 = he_cap->ppe_thres[0] &
9f056ed8ee01ad John Crispin 2019-11-25  1276  					  IEEE80211_PPE_THRES_NSS_MASK;
9f056ed8ee01ad John Crispin 2019-11-25  1277  		arg->peer_ppet.ru_bit_mask =
9f056ed8ee01ad John Crispin 2019-11-25  1278  			(he_cap->ppe_thres[0] &
9f056ed8ee01ad John Crispin 2019-11-25  1279  			 IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK) >>
9f056ed8ee01ad John Crispin 2019-11-25  1280  			IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS;
9f056ed8ee01ad John Crispin 2019-11-25  1281  
9f056ed8ee01ad John Crispin 2019-11-25  1282  		for (nss = 0; nss <= arg->peer_ppet.numss_m1; nss++) {
9f056ed8ee01ad John Crispin 2019-11-25  1283  			for (ru = 0; ru < 4; ru++) {
9f056ed8ee01ad John Crispin 2019-11-25  1284  				u32 val = 0;
9f056ed8ee01ad John Crispin 2019-11-25  1285  				int i;
9f056ed8ee01ad John Crispin 2019-11-25  1286  
9f056ed8ee01ad John Crispin 2019-11-25  1287  				if ((arg->peer_ppet.ru_bit_mask & BIT(ru)) == 0)
9f056ed8ee01ad John Crispin 2019-11-25  1288  					continue;
9f056ed8ee01ad John Crispin 2019-11-25  1289  				for (i = 0; i < 6; i++) {
9f056ed8ee01ad John Crispin 2019-11-25  1290  					val >>= 1;
9f056ed8ee01ad John Crispin 2019-11-25  1291  					val |= ((he_cap->ppe_thres[bit / 8] >>
9f056ed8ee01ad John Crispin 2019-11-25  1292  						 (bit % 8)) & 0x1) << 5;
9f056ed8ee01ad John Crispin 2019-11-25  1293  					bit++;
9f056ed8ee01ad John Crispin 2019-11-25  1294  				}
9f056ed8ee01ad John Crispin 2019-11-25  1295  				arg->peer_ppet.ppet16_ppet8_ru3_ru0[nss] |=
9f056ed8ee01ad John Crispin 2019-11-25  1296  								val << (ru * 6);
9f056ed8ee01ad John Crispin 2019-11-25  1297  			}
9f056ed8ee01ad John Crispin 2019-11-25  1298  		}
9f056ed8ee01ad John Crispin 2019-11-25  1299  	}
9f056ed8ee01ad John Crispin 2019-11-25  1300  
6d293d447670da John Crispin 2019-11-25  1301  	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_RES)
6d293d447670da John Crispin 2019-11-25  1302  		arg->twt_responder = true;
6d293d447670da John Crispin 2019-11-25  1303  	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_REQ)
6d293d447670da John Crispin 2019-11-25  1304  		arg->twt_requester = true;
6d293d447670da John Crispin 2019-11-25  1305  
9f056ed8ee01ad John Crispin 2019-11-25  1306  	switch (sta->bandwidth) {
9f056ed8ee01ad John Crispin 2019-11-25  1307  	case IEEE80211_STA_RX_BW_160:
9f056ed8ee01ad John Crispin 2019-11-25  1308  		if (he_cap->he_cap_elem.phy_cap_info[0] &
9f056ed8ee01ad John Crispin 2019-11-25  1309  		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
9f056ed8ee01ad John Crispin 2019-11-25 @1310  			v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80p80);
9f056ed8ee01ad John Crispin 2019-11-25 @1311  			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
9f056ed8ee01ad John Crispin 2019-11-25  1312  
9f056ed8ee01ad John Crispin 2019-11-25  1313  			v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80p80);
f4740f8f367c7c Miles Hu     2020-04-29 @1314  			v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
9f056ed8ee01ad John Crispin 2019-11-25  1315  			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
9f056ed8ee01ad John Crispin 2019-11-25  1316  
9f056ed8ee01ad John Crispin 2019-11-25  1317  			arg->peer_he_mcs_count++;
f4740f8f367c7c Miles Hu     2020-04-29  1318  			he_tx_mcs = v;
9f056ed8ee01ad John Crispin 2019-11-25  1319  		}
9f056ed8ee01ad John Crispin 2019-11-25  1320  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
9f056ed8ee01ad John Crispin 2019-11-25  1321  		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
9f056ed8ee01ad John Crispin 2019-11-25  1322  
9f056ed8ee01ad John Crispin 2019-11-25  1323  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
f4740f8f367c7c Miles Hu     2020-04-29  1324  		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
9f056ed8ee01ad John Crispin 2019-11-25  1325  		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
9f056ed8ee01ad John Crispin 2019-11-25  1326  
9f056ed8ee01ad John Crispin 2019-11-25  1327  		arg->peer_he_mcs_count++;
f4740f8f367c7c Miles Hu     2020-04-29  1328  		if (!he_tx_mcs)
f4740f8f367c7c Miles Hu     2020-04-29  1329  			he_tx_mcs = v;
9f056ed8ee01ad John Crispin 2019-11-25  1330  		/* fall through */
9f056ed8ee01ad John Crispin 2019-11-25  1331  
9f056ed8ee01ad John Crispin 2019-11-25  1332  	default:
9f056ed8ee01ad John Crispin 2019-11-25  1333  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
9f056ed8ee01ad John Crispin 2019-11-25  1334  		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
9f056ed8ee01ad John Crispin 2019-11-25  1335  
9f056ed8ee01ad John Crispin 2019-11-25  1336  		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
f4740f8f367c7c Miles Hu     2020-04-29 @1337  		v = ath11k_peer_assoc_h_he_limit(v, he_mcs_mask);
9f056ed8ee01ad John Crispin 2019-11-25 @1338  		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
9f056ed8ee01ad John Crispin 2019-11-25  1339  
9f056ed8ee01ad John Crispin 2019-11-25  1340  		arg->peer_he_mcs_count++;
f4740f8f367c7c Miles Hu     2020-04-29  1341  		if (!he_tx_mcs)
f4740f8f367c7c Miles Hu     2020-04-29  1342  			he_tx_mcs = v;
9f056ed8ee01ad John Crispin 2019-11-25  1343  		break;
9f056ed8ee01ad John Crispin 2019-11-25  1344  	}
f4740f8f367c7c Miles Hu     2020-04-29  1345  	/* Calculate peer NSS capability from HE capabilities if STA
f4740f8f367c7c Miles Hu     2020-04-29  1346  	 * supports HE.
f4740f8f367c7c Miles Hu     2020-04-29  1347  	 */
f4740f8f367c7c Miles Hu     2020-04-29  1348  	for (i = 0, max_nss = 0, he_mcs = 0; i < NL80211_HE_NSS_MAX; i++) {
f4740f8f367c7c Miles Hu     2020-04-29  1349  		he_mcs = __le16_to_cpu(he_tx_mcs) >> (2 * i) & 3;
f4740f8f367c7c Miles Hu     2020-04-29  1350  
f4740f8f367c7c Miles Hu     2020-04-29  1351  		if (he_mcs != IEEE80211_HE_MCS_NOT_SUPPORTED &&
f4740f8f367c7c Miles Hu     2020-04-29  1352  		    he_mcs_mask[i])
f4740f8f367c7c Miles Hu     2020-04-29  1353  			max_nss = i + 1;
f4740f8f367c7c Miles Hu     2020-04-29  1354  	}
f4740f8f367c7c Miles Hu     2020-04-29  1355  	arg->peer_nss = min(sta->rx_nss, max_nss);
f4740f8f367c7c Miles Hu     2020-04-29  1356  
f4740f8f367c7c Miles Hu     2020-04-29  1357  	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
f4740f8f367c7c Miles Hu     2020-04-29  1358  		   "mac he peer %pM nss %d mcs cnt %d\n",
f4740f8f367c7c Miles Hu     2020-04-29  1359  		   sta->addr, arg->peer_nss, arg->peer_he_mcs_count);
d5c65159f28953 Kalle Valo   2019-11-23  1360  }
d5c65159f28953 Kalle Valo   2019-11-23  1361  

:::::: The code at line 1310 was first introduced by commit
:::::: 9f056ed8ee01ad6898db49707cdc70ce923be3d0 ath11k: add HE support

:::::: TO: John Crispin <john@phrozen.org>
:::::: CC: Kalle Valo <kvalo@codeaurora.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
