Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F562567C85
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Jul 2022 05:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGFD12 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jul 2022 23:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGFD1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jul 2022 23:27:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CBAF5F
        for <linux-wireless@vger.kernel.org>; Tue,  5 Jul 2022 20:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657078040; x=1688614040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lGDLONxxNciCtzO6tEgXAoRmBs07JGpgsHtP1EPwKMg=;
  b=VRAe7tkN6cO/1hlBPVw1hKLYF7rpgGuOzdicHntjQF/i4oYfZr037FA9
   SS6vUGyRZ5tCn9eY3pnXBZWBo56xBnQE3liTxC2DhJtnYdqrHApgthzZi
   OBTEeQLILTM0VGQmhW5Gbm3iyGaIFDG6XGFBv8GBnwrbFUVsDQkAL/ONE
   t6hIk5wdEbw1VclcJBVlX2rvw4cO67qoCd3YqbAPJMRTwEQY49lqR7WkD
   /bkkuBAMFafcCc8rfJhGtzA9gXL4xTKGuy2+Xs/uNGM1/8gfAntvNeWgP
   fXmrT/m1mFFB9gc4f+J+LzbA6ryLbOZRky9Nu4C6YR/d7WAhqML6w/qtZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347614440"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="347614440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="735400160"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jul 2022 20:27:18 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8vh7-000JxD-Qc;
        Wed, 06 Jul 2022 03:27:17 +0000
Date:   Wed, 6 Jul 2022 11:27:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muna Sinada <quic_msinada@quicinc.com>, johannes@sipsolutions.net
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-wireless@vger.kernel.org,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: Re: [PATCH v2 1/2] mac80211: Add VHT MU-MIMO related flags in
 ieee80211_bss_conf
Message-ID: <202207061106.QWMt1tGm-lkp@intel.com>
References: <1657058586-4621-1-git-send-email-quic_msinada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657058586-4621-1-git-send-email-quic_msinada@quicinc.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Muna,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on wireless/main]
[also build test ERROR on linus/master v5.19-rc5]
[cannot apply to wireless-next/main next-20220705]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Muna-Sinada/mac80211-Add-VHT-MU-MIMO-related-flags-in-ieee80211_bss_conf/20220706-060509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
config: hexagon-randconfig-r045-20220703 (https://download.01.org/0day-ci/archive/20220706/202207061106.QWMt1tGm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f553287b588916de09c66e3e32bf75e5060f967f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d0909fa7d00b2857a0b258722221e1e94ba9c05e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muna-Sinada/mac80211-Add-VHT-MU-MIMO-related-flags-in-ieee80211_bss_conf/20220706-060509
        git checkout d0909fa7d00b2857a0b258722221e1e94ba9c05e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash net/mac80211/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> net/mac80211/cfg.c:1169:13: error: use of undeclared identifier 'ap_vht_cap'
                          !!(ap_vht_cap->vht_cap_info &
                             ^
   net/mac80211/cfg.c:1172:13: error: use of undeclared identifier 'ap_vht_cap'
                          !!(ap_vht_cap->vht_cap_info &
                             ^
   net/mac80211/cfg.c:1175:13: error: use of undeclared identifier 'ap_vht_cap'
                          !!(ap_vht_cap->vht_cap_info &
                             ^
   net/mac80211/cfg.c:1178:13: error: use of undeclared identifier 'ap_vht_cap'
                          !!(ap_vht_cap->vht_cap_info &
                             ^
   4 errors generated.


vim +/ap_vht_cap +1169 net/mac80211/cfg.c

  1135	
  1136	static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
  1137				      struct cfg80211_ap_settings *params)
  1138	{
  1139		struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
  1140		struct ieee80211_local *local = sdata->local;
  1141		struct beacon_data *old;
  1142		struct ieee80211_sub_if_data *vlan;
  1143		u32 changed = BSS_CHANGED_BEACON_INT |
  1144			      BSS_CHANGED_BEACON_ENABLED |
  1145			      BSS_CHANGED_BEACON |
  1146			      BSS_CHANGED_SSID |
  1147			      BSS_CHANGED_P2P_PS |
  1148			      BSS_CHANGED_TXPOWER |
  1149			      BSS_CHANGED_TWT;
  1150		int i, err;
  1151		int prev_beacon_int;
  1152	
  1153		old = sdata_dereference(sdata->u.ap.beacon, sdata);
  1154		if (old)
  1155			return -EALREADY;
  1156	
  1157		if (params->smps_mode != NL80211_SMPS_OFF)
  1158			return -ENOTSUPP;
  1159	
  1160		sdata->smps_mode = IEEE80211_SMPS_OFF;
  1161	
  1162		sdata->needed_rx_chains = sdata->local->rx_chains;
  1163	
  1164		prev_beacon_int = sdata->vif.bss_conf.beacon_int;
  1165		sdata->vif.bss_conf.beacon_int = params->beacon_interval;
  1166	
  1167		if (params->vht_cap) {
  1168			sdata->vif.bss_conf.vht_su_beamformer =
> 1169			       !!(ap_vht_cap->vht_cap_info &
  1170				  cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
  1171			sdata->vif.bss_conf.vht_su_beamformee =
  1172			       !!(ap_vht_cap->vht_cap_info &
  1173				  cpu_to_le32(IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
  1174			sdata->vif.bss_conf.vht_mu_beamformer =
  1175			       !!(ap_vht_cap->vht_cap_info &
  1176				  cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE));
  1177			sdata->vif.bss_conf.vht_mu_beamformee =
  1178			       !!(ap_vht_cap->vht_cap_info &
  1179				  cpu_to_le32(IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE));
  1180		}
  1181	
  1182		if (params->he_cap && params->he_oper) {
  1183			sdata->vif.bss_conf.he_support = true;
  1184			sdata->vif.bss_conf.htc_trig_based_pkt_ext =
  1185				le32_get_bits(params->he_oper->he_oper_params,
  1186				      IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK);
  1187			sdata->vif.bss_conf.frame_time_rts_th =
  1188				le32_get_bits(params->he_oper->he_oper_params,
  1189				      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
  1190			changed |= BSS_CHANGED_HE_OBSS_PD;
  1191	
  1192			if (params->beacon.he_bss_color.enabled)
  1193				changed |= BSS_CHANGED_HE_BSS_COLOR;
  1194		}
  1195	
  1196		if (sdata->vif.type == NL80211_IFTYPE_AP &&
  1197		    params->mbssid_config.tx_wdev) {
  1198			err = ieee80211_set_ap_mbssid_options(sdata,
  1199							      params->mbssid_config);
  1200			if (err)
  1201				return err;
  1202		}
  1203	
  1204		mutex_lock(&local->mtx);
  1205		err = ieee80211_vif_use_channel(sdata, &params->chandef,
  1206						IEEE80211_CHANCTX_SHARED);
  1207		if (!err)
  1208			ieee80211_vif_copy_chanctx_to_vlans(sdata, false);
  1209		mutex_unlock(&local->mtx);
  1210		if (err) {
  1211			sdata->vif.bss_conf.beacon_int = prev_beacon_int;
  1212			return err;
  1213		}
  1214	
  1215		/*
  1216		 * Apply control port protocol, this allows us to
  1217		 * not encrypt dynamic WEP control frames.
  1218		 */
  1219		sdata->control_port_protocol = params->crypto.control_port_ethertype;
  1220		sdata->control_port_no_encrypt = params->crypto.control_port_no_encrypt;
  1221		sdata->control_port_over_nl80211 =
  1222					params->crypto.control_port_over_nl80211;
  1223		sdata->control_port_no_preauth =
  1224					params->crypto.control_port_no_preauth;
  1225		sdata->encrypt_headroom = ieee80211_cs_headroom(sdata->local,
  1226								&params->crypto,
  1227								sdata->vif.type);
  1228	
  1229		list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
  1230			vlan->control_port_protocol =
  1231				params->crypto.control_port_ethertype;
  1232			vlan->control_port_no_encrypt =
  1233				params->crypto.control_port_no_encrypt;
  1234			vlan->control_port_over_nl80211 =
  1235				params->crypto.control_port_over_nl80211;
  1236			vlan->control_port_no_preauth =
  1237				params->crypto.control_port_no_preauth;
  1238			vlan->encrypt_headroom =
  1239				ieee80211_cs_headroom(sdata->local,
  1240						      &params->crypto,
  1241						      vlan->vif.type);
  1242		}
  1243	
  1244		sdata->vif.bss_conf.dtim_period = params->dtim_period;
  1245		sdata->vif.bss_conf.enable_beacon = true;
  1246		sdata->vif.bss_conf.allow_p2p_go_ps = sdata->vif.p2p;
  1247		sdata->vif.bss_conf.twt_responder = params->twt_responder;
  1248		sdata->vif.bss_conf.he_obss_pd = params->he_obss_pd;
  1249		sdata->vif.bss_conf.he_bss_color = params->beacon.he_bss_color;
  1250		sdata->vif.bss_conf.s1g = params->chandef.chan->band ==
  1251					  NL80211_BAND_S1GHZ;
  1252	
  1253		sdata->vif.bss_conf.ssid_len = params->ssid_len;
  1254		if (params->ssid_len)
  1255			memcpy(sdata->vif.bss_conf.ssid, params->ssid,
  1256			       params->ssid_len);
  1257		sdata->vif.bss_conf.hidden_ssid =
  1258			(params->hidden_ssid != NL80211_HIDDEN_SSID_NOT_IN_USE);
  1259	
  1260		memset(&sdata->vif.bss_conf.p2p_noa_attr, 0,
  1261		       sizeof(sdata->vif.bss_conf.p2p_noa_attr));
  1262		sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow =
  1263			params->p2p_ctwindow & IEEE80211_P2P_OPPPS_CTWINDOW_MASK;
  1264		if (params->p2p_opp_ps)
  1265			sdata->vif.bss_conf.p2p_noa_attr.oppps_ctwindow |=
  1266						IEEE80211_P2P_OPPPS_ENABLE_BIT;
  1267	
  1268		sdata->beacon_rate_set = false;
  1269		if (wiphy_ext_feature_isset(local->hw.wiphy,
  1270					    NL80211_EXT_FEATURE_BEACON_RATE_LEGACY)) {
  1271			for (i = 0; i < NUM_NL80211_BANDS; i++) {
  1272				sdata->beacon_rateidx_mask[i] =
  1273					params->beacon_rate.control[i].legacy;
  1274				if (sdata->beacon_rateidx_mask[i])
  1275					sdata->beacon_rate_set = true;
  1276			}
  1277		}
  1278	
  1279		if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
  1280			sdata->vif.bss_conf.beacon_tx_rate = params->beacon_rate;
  1281	
  1282		err = ieee80211_assign_beacon(sdata, &params->beacon, NULL, NULL);
  1283		if (err < 0)
  1284			goto error;
  1285		changed |= err;
  1286	
  1287		if (params->fils_discovery.max_interval) {
  1288			err = ieee80211_set_fils_discovery(sdata,
  1289							   &params->fils_discovery);
  1290			if (err < 0)
  1291				goto error;
  1292			changed |= BSS_CHANGED_FILS_DISCOVERY;
  1293		}
  1294	
  1295		if (params->unsol_bcast_probe_resp.interval) {
  1296			err = ieee80211_set_unsol_bcast_probe_resp(sdata,
  1297								   &params->unsol_bcast_probe_resp);
  1298			if (err < 0)
  1299				goto error;
  1300			changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
  1301		}
  1302	
  1303		err = drv_start_ap(sdata->local, sdata);
  1304		if (err) {
  1305			old = sdata_dereference(sdata->u.ap.beacon, sdata);
  1306	
  1307			if (old)
  1308				kfree_rcu(old, rcu_head);
  1309			RCU_INIT_POINTER(sdata->u.ap.beacon, NULL);
  1310			goto error;
  1311		}
  1312	
  1313		ieee80211_recalc_dtim(local, sdata);
  1314		ieee80211_bss_info_change_notify(sdata, changed);
  1315	
  1316		netif_carrier_on(dev);
  1317		list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
  1318			netif_carrier_on(vlan->dev);
  1319	
  1320		return 0;
  1321	
  1322	error:
  1323		mutex_lock(&local->mtx);
  1324		ieee80211_vif_release_channel(sdata);
  1325		mutex_unlock(&local->mtx);
  1326	
  1327		return err;
  1328	}
  1329	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
