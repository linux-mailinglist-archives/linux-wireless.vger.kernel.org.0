Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B327E762D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjKJBBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjKJBBe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:01:34 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673843AA8
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:01:31 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0942628006B
        for <linux-wireless@vger.kernel.org>; Fri, 10 Nov 2023 01:01:28 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 6F13513C2B0
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:01:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6F13513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1699578088;
        bh=DegnwQPTJ7iWnchusbhk7UYT6JGb0sXwozhAAxXrR8A=;
        h=Date:To:From:Subject:From;
        b=Q5xyQnYmr3h2eNXdadcmTZs/JYoMYaXjmPGk/2Y8OU1sGPrd2asfcI+59yiCV/ASu
         Dd6NER07DjRUXukaw5Zc7vxz5amelFDRzl++rort5HbHMACk5ync39WkyHYEvPQ0ak
         6Od3+yDeTbSqmiwBKsz3E1wM8vb1nLOQwLEG8uX0=
Message-ID: <232e7566-36b0-a669-5b3f-71c8862b454b@candelatech.com>
Date:   Thu, 9 Nov 2023 17:01:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: KASAN memory detection problem with be200 in 6.7 + hacks.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1699578089-Fq0V4aN3-3Wc
X-MDID-O: us5;ut7;1699578089;Fq0V4aN3-3Wc;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

So, this log is huge.  The problem could easily start with the firmware crash,
though not certain of that.  I have a bunch of radios attempting to associate,
in order to reproduce the problems faster, but a single radio will cause the same
or similar issue after some time.

I think the more serious symptoms may start here.  The code is below, I guess active_links
is greater than expected.

[ 1248.567778] WARNING: CPU: 2 PID: 18904 at net/mac80211/link.c:228 ieee80211_set_vif_links_bitmaps+0xe6/0x110 [mac80211]

static void ieee80211_set_vif_links_bitmaps(struct ieee80211_sub_if_data *sdata,
					    u16 valid_links, u16 dormant_links)
{
	sdata->vif.valid_links = valid_links;
	sdata->vif.dormant_links = dormant_links;

	if (!valid_links ||
	    WARN((~valid_links & dormant_links) ||
		 !(valid_links & ~dormant_links),
		 "Invalid links: valid=0x%x, dormant=0x%x",
		 valid_links, dormant_links)) {
		sdata->vif.active_links = 0;
		sdata->vif.dormant_links = 0;
		return;
	}

	switch (sdata->vif.type) {
	case NL80211_IFTYPE_AP:
		/* in an AP all links are always active */
		sdata->vif.active_links = valid_links;

		/* AP links are not expected to be disabled */
		WARN_ON(dormant_links);
		break;
	case NL80211_IFTYPE_STATION:
		if (sdata->vif.active_links)
			break;
		sdata->vif.active_links = valid_links & ~dormant_links;

#### HERE is line 228
		WARN_ON(hweight16(sdata->vif.active_links) > 1);
		break;
	default:
		WARN_ON(1);
	}
}

After that, things go down hill,

This looks pretty bad:

[ 1248.608465] destroying interface with valid links 0x0007
[ 1248.608537] WARNING: CPU: 2 PID: 18904 at net/mac80211/iface.c:597 ieee80211_do_stop+0xdf0/0xe40 [mac80211]

Then a splat from iwlwifi:

[ 1248.611025] wlan1: do_stop, canceling dfs-cac-timer-work.
[ 1248.611203] ------------[ cut here ]------------
[ 1248.611207] WARNING: CPU: 2 PID: 18904 at drivers/net/wireless/intel/iwlwifi/mvm/link.c:104 iwl_mvm_link_changed+0x441/0x600 [iwlmvm]


Which maps to this warning below:

int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
			 struct ieee80211_bss_conf *link_conf,
			 u32 changes, bool active)
{
	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
	unsigned int link_id = link_conf->link_id;
	struct iwl_mvm_vif_link_info *link_info = mvmvif->link[link_id];
	struct iwl_mvm_phy_ctxt *phyctxt;
	struct iwl_link_config_cmd cmd = {};
	u32 ht_flag, flags = 0, flags_mask = 0;
	int ret;

	if (WARN_ON_ONCE(!link_info ||
			 link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
		return -EINVAL;


And finally:

[ 1255.019907] BUG: KASAN: invalid-free in iwl_mvm_mld_change_vif_links+0x36a/0x610 [iwlmvm]
[ 1255.026856] Free of addr ffff8881631779e0 by task wpa_supplicant/5831

Which maps to this code:

gdb) l *(iwl_mvm_mld_change_vif_links+0x36a)
0x77e9a is in iwl_mvm_mld_change_vif_links (/home/greearb/git/linux-6.7.dev.y/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c:1176).
1151			new_link[i]->ap_sta_id = IWL_MVM_INVALID_STA;
1152			new_link[i]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
1153	
1154			for (r = 0; r < NUM_IWL_MVM_SMPS_REQ; r++)
1155				new_link[i]->smps_requests[r] =
1156					IEEE80211_SMPS_AUTOMATIC;
1157		}
1158	
1159		mutex_lock(&mvm->mutex);
1160	
1161		if (old_links == 0) {
1162			err = iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
1163			if (err)
1164				goto out_err;
1165			mvmvif->link[0] = NULL;
1166		}
1167	
1168		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
1169			if (removed & BIT(i)) {
1170				struct ieee80211_bss_conf *link_conf = old[i];
1171	
1172				err = iwl_mvm_disable_link(mvm, vif, link_conf);
1173				if (err)
1174					goto out_err;
1175				kfree(mvmvif->link[i]);
1176				mvmvif->link[i] = NULL;
1177			} else if (added & BIT(i)) {
1178				struct ieee80211_bss_conf *link_conf;
1179	
1180				link_conf = link_conf_dereference_protected(vif, i);
1181				if (WARN_ON(!link_conf))
--Type <RET> for more, q to quit, c to continue without paging--
1182					continue;
1183	
1184				if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
1185					      &mvm->status))
1186					mvmvif->link[i] = new_link[i];
1187				new_link[i] = NULL;
1188				err = iwl_mvm_add_link(mvm, vif, link_conf);
1189				if (err)
1190					goto out_err;
1191			}
1192		}
1193	
1194		err = 0;
1195		if (new_links == 0) {
1196			mvmvif->link[0] = &mvmvif->deflink;
1197			err = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
1198		}
1199	
1200	out_err:
(gdb)


Any suggestions for improving this are welcome...

Thanks,
Ben


[ 1201.485805] wlan1: associate with 40:ed:00:14:f5:f5 (try 1/3)
[ 1201.513544] wlan1: RX AssocResp from 40:ed:00:14:f5:f5 (capab=0x511 status=0 aid=16)
[ 1201.526845] wlan1: [link 0] local address 4a:57:06:a5:18:17, AP link address 92:ed:00:14:f5:f2
[ 1201.526907] mgd-setup-link-sta, link: ffff8881919a0800 sdata: ffff888163174dc0 local: ffff88812a7a0f40
[ 1201.535032] wlan1: [link 1] local address 4e:b3:d7:5d:c4:fb, AP link address 52:ed:00:14:f5:f5
[ 1201.535134] mgd-setup-link-sta, link: ffff8881919a2000 sdata: ffff888163174dc0 local: ffff88812a7a0f40
[ 1201.543258] wlan1: [link 2] local address 5a:3e:62:02:9f:11, AP link address 92:ed:00:14:f5:f3 (assoc)
[ 1201.543266] mgd-setup-link-sta, link: ffff8881635ce800 sdata: ffff888163174dc0 local: ffff88812a7a0f40
[ 1201.551738] enabling LDPC due to HT Cap
[ 1201.551743] enabling LDPC due to HE cap
[ 1201.553923] wlan1: associated
[ 1201.579192] enabling LDPC due to HT Cap
[ 1201.579198] enabling LDPC due to HE cap
[ 1201.581903] enabling LDPC due to HT Cap
[ 1201.581908] enabling LDPC due to HE cap
[ 1202.010722] wlan1: Limiting TX power to 30 (30 - 0) dBm as advertised by 92:ed:00:14:f5:f3
[ 1202.011629] iwlwifi 0000:04:00.0: Microcode SW error detected. Restarting 0x0.
[ 1202.017905] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[ 1202.022224] iwlwifi 0000:04:00.0: Transport status: 0x0000004B, valid: 6
[ 1202.027654] iwlwifi 0000:04:00.0: Loaded firmware version: 83.d24e06ed.0 gl-c0-fm-c0-83.ucode
[ 1202.034911] iwlwifi 0000:04:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
[ 1202.040604] iwlwifi 0000:04:00.0: 0x00808200 | trm_hw_status0
[ 1202.045075] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[ 1202.049552] iwlwifi 0000:04:00.0: 0x002C27F2 | branchlink2
[ 1202.053767] iwlwifi 0000:04:00.0: 0x002BFDA6 | interruptlink1
[ 1202.058239] iwlwifi 0000:04:00.0: 0x002BFDA6 | interruptlink2
[ 1202.062708] iwlwifi 0000:04:00.0: 0x00015B9A | data1
[ 1202.066400] iwlwifi 0000:04:00.0: 0x00000010 | data2
[ 1202.070102] iwlwifi 0000:04:00.0: 0x00000000 | data3
[ 1202.073796] iwlwifi 0000:04:00.0: 0x014189D5 | beacon time
[ 1202.078006] iwlwifi 0000:04:00.0: 0x63F41A6B | tsf low
[ 1202.081871] iwlwifi 0000:04:00.0: 0x000001D2 | tsf hi
[ 1202.085650] iwlwifi 0000:04:00.0: 0x00007D7D | time gp1
[ 1202.089604] iwlwifi 0000:04:00.0: 0x03A9FF97 | time gp2
[ 1202.093554] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[ 1202.098461] iwlwifi 0000:04:00.0: 0x00000053 | uCode version major
[ 1202.103369] iwlwifi 0000:04:00.0: 0xD24E06ED | uCode version minor
[ 1202.108272] iwlwifi 0000:04:00.0: 0x00000472 | hw version
[ 1202.112395] iwlwifi 0000:04:00.0: 0x00C80002 | board version
[ 1202.116782] iwlwifi 0000:04:00.0: 0x0302001C | hcmd
[ 1202.120385] iwlwifi 0000:04:00.0: 0xE6F22000 | isr0
[ 1202.123991] iwlwifi 0000:04:00.0: 0x01400000 | isr1
[ 1202.127599] iwlwifi 0000:04:00.0: 0x58F00192 | isr2
[ 1202.131207] iwlwifi 0000:04:00.0: 0x00C0000D | isr3
[ 1202.134814] iwlwifi 0000:04:00.0: 0x18200000 | isr4
[ 1202.138418] iwlwifi 0000:04:00.0: 0x0302001C | last cmd Id
[ 1202.142626] iwlwifi 0000:04:00.0: 0x00015B9A | wait_event
[ 1202.146754] iwlwifi 0000:04:00.0: 0x000000D4 | l2p_control
[ 1202.150964] iwlwifi 0000:04:00.0: 0x00018014 | l2p_duration
[ 1202.155262] iwlwifi 0000:04:00.0: 0x0100004A | l2p_mhvalid
[ 1202.159474] iwlwifi 0000:04:00.0: 0x00000019 | l2p_addr_match
[ 1202.163946] iwlwifi 0000:04:00.0: 0x00000009 | lmpm_pmg_sel
[ 1202.168243] iwlwifi 0000:04:00.0: 0x00000000 | timestamp
[ 1202.172283] iwlwifi 0000:04:00.0: 0x0000689C | flow_handler
[ 1202.176876] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[ 1202.181168] iwlwifi 0000:04:00.0: Transport status: 0x0000004B, valid: 6
[ 1202.186589] iwlwifi 0000:04:00.0: Loaded firmware version: 83.d24e06ed.0 gl-c0-fm-c0-83.ucode
[ 1202.193844] iwlwifi 0000:04:00.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL
[ 1202.199540] iwlwifi 0000:04:00.0: 0x000002F0 | trm_hw_status0
[ 1202.204012] iwlwifi 0000:04:00.0: 0x00000000 | trm_hw_status1
[ 1202.208485] iwlwifi 0000:04:00.0: 0x002C27F2 | branchlink2
[ 1202.212696] iwlwifi 0000:04:00.0: 0x002B79AE | interruptlink1
[ 1202.217175] iwlwifi 0000:04:00.0: 0x002B79AE | interruptlink2
[ 1202.221646] iwlwifi 0000:04:00.0: 0x00015B9A | data1
[ 1202.225341] iwlwifi 0000:04:00.0: 0x00000010 | data2
[ 1202.229032] iwlwifi 0000:04:00.0: 0x00000000 | data3
[ 1202.232726] iwlwifi 0000:04:00.0: 0x014189D6 | beacon time
[ 1202.236940] iwlwifi 0000:04:00.0: 0x63F41A6B | tsf low
[ 1202.240806] iwlwifi 0000:04:00.0: 0x000001D2 | tsf hi
[ 1202.244588] iwlwifi 0000:04:00.0: 0x00000000 | time gp1
[ 1202.248544] iwlwifi 0000:04:00.0: 0x03A9FF97 | time gp2
[ 1202.252492] iwlwifi 0000:04:00.0: 0x00000001 | uCode revision type
[ 1202.257401] iwlwifi 0000:04:00.0: 0x00000053 | uCode version major
[ 1202.262310] iwlwifi 0000:04:00.0: 0xD24E06ED | uCode version minor
[ 1202.267220] iwlwifi 0000:04:00.0: 0x00000472 | hw version
[ 1202.271340] iwlwifi 0000:04:00.0: 0x00C80002 | board version
[ 1202.275723] iwlwifi 0000:04:00.0: 0x80AFFC00 | hcmd
[ 1202.279320] iwlwifi 0000:04:00.0: 0x00020000 | isr0
[ 1202.282921] iwlwifi 0000:04:00.0: 0x00000000 | isr1
[ 1202.286533] iwlwifi 0000:04:00.0: 0x58700082 | isr2
[ 1202.290141] iwlwifi 0000:04:00.0: 0x00C0000E | isr3
[ 1202.293751] iwlwifi 0000:04:00.0: 0x00000000 | isr4
[ 1202.297352] iwlwifi 0000:04:00.0: 0x00000000 | last cmd Id
[ 1202.301565] iwlwifi 0000:04:00.0: 0x00015B9A | wait_event
[ 1202.305691] iwlwifi 0000:04:00.0: 0x00000000 | l2p_control
[ 1202.309902] iwlwifi 0000:04:00.0: 0x00000000 | l2p_duration
[ 1202.314202] iwlwifi 0000:04:00.0: 0x003C0000 | l2p_mhvalid
[ 1202.318414] iwlwifi 0000:04:00.0: 0x00000007 | l2p_addr_match
[ 1202.322886] iwlwifi 0000:04:00.0: 0x00000009 | lmpm_pmg_sel
[ 1202.327190] iwlwifi 0000:04:00.0: 0x00000000 | timestamp
[ 1202.331231] iwlwifi 0000:04:00.0: 0x0000689C | flow_handler
[ 1202.335653] iwlwifi 0000:04:00.0: Start IWL Error Log Dump:
[ 1202.339946] iwlwifi 0000:04:00.0: Transport status: 0x0000004B, valid: 7
[ 1202.345378] iwlwifi 0000:04:00.0: 0x20103037 | ADVANCED_SYSASSERT
[ 1202.350198] iwlwifi 0000:04:00.0: 0x00000000 | umac branchlink1
[ 1202.354852] iwlwifi 0000:04:00.0: 0xC00809B0 | umac branchlink2
[ 1202.359501] iwlwifi 0000:04:00.0: 0xC008205C | umac interruptlink1
[ 1202.364408] iwlwifi 0000:04:00.0: 0x01002CAC | umac interruptlink2
[ 1202.369314] iwlwifi 0000:04:00.0: 0x00000000 | umac data1
[ 1202.373438] iwlwifi 0000:04:00.0: 0x00000003 | umac data2
[ 1202.377563] iwlwifi 0000:04:00.0: 0xDEADBEEF | umac data3
[ 1202.381689] iwlwifi 0000:04:00.0: 0x00000053 | umac major
[ 1202.385814] iwlwifi 0000:04:00.0: 0xD24E06ED | umac minor
[ 1202.389945] iwlwifi 0000:04:00.0: 0x03A9FF89 | frame pointer
[ 1202.394334] iwlwifi 0000:04:00.0: 0xD00D6BE8 | stack pointer
[ 1202.398720] iwlwifi 0000:04:00.0: 0x009C0305 | last host cmd
[ 1202.403106] iwlwifi 0000:04:00.0: 0x00000000 | isr status reg
[ 1202.407735] iwlwifi 0000:04:00.0: TCM1 status:
[ 1202.410897] iwlwifi 0000:04:00.0: 0x00000070 | error ID
[ 1202.414847] iwlwifi 0000:04:00.0: 0x0000184E | tcm branchlink2
[ 1202.419407] iwlwifi 0000:04:00.0: 0x00001C44 | tcm interruptlink1
[ 1202.424227] iwlwifi 0000:04:00.0: 0x00001C44 | tcm interruptlink2
[ 1202.429045] iwlwifi 0000:04:00.0: 0x40000000 | tcm data1
[ 1202.433089] iwlwifi 0000:04:00.0: 0xDEADBEEF | tcm data2
[ 1202.437130] iwlwifi 0000:04:00.0: 0xDEADBEEF | tcm data3
[ 1202.441167] iwlwifi 0000:04:00.0: 0x000018AC | tcm log PC
[ 1202.445295] iwlwifi 0000:04:00.0: 0x00803FF0 | tcm frame pointer
[ 1202.450029] iwlwifi 0000:04:00.0: 0x00803F4C | tcm stack pointer
[ 1202.454767] iwlwifi 0000:04:00.0: 0x00000000 | tcm msg ID
[ 1202.458893] iwlwifi 0000:04:00.0: 0x4000001F | tcm ISR status
[ 1202.463364] iwlwifi 0000:04:00.0: 0x00808200 | tcm HW status[0]
[ 1202.468007] iwlwifi 0000:04:00.0: 0x00000000 | tcm HW status[1]
[ 1202.472653] iwlwifi 0000:04:00.0: 0x00018014 | tcm HW status[2]
[ 1202.477302] iwlwifi 0000:04:00.0: 0x00008100 | tcm HW status[3]
[ 1202.481947] iwlwifi 0000:04:00.0: 0x00000000 | tcm HW status[4]
[ 1202.486591] iwlwifi 0000:04:00.0: 0x00000000 | tcm SW status[0]
[ 1202.491397] iwlwifi 0000:04:00.0: RCM1 status:
[ 1202.494566] iwlwifi 0000:04:00.0: 0x00000070 | error ID
[ 1202.498517] iwlwifi 0000:04:00.0: 0x00001B9E | rcm branchlink2
[ 1202.503080] iwlwifi 0000:04:00.0: 0x00002178 | rcm interruptlink1
[ 1202.507902] iwlwifi 0000:04:00.0: 0x00002178 | rcm interruptlink2
[ 1202.512721] iwlwifi 0000:04:00.0: 0x20000000 | rcm data1
[ 1202.516759] iwlwifi 0000:04:00.0: 0xDEADBEEF | rcm data2
[ 1202.520811] iwlwifi 0000:04:00.0: 0xDEADBEEF | rcm data3
[ 1202.524843] iwlwifi 0000:04:00.0: 0x00001C00 | rcm log PC
[ 1202.528972] iwlwifi 0000:04:00.0: 0x00803FF0 | rcm frame pointer
[ 1202.533699] iwlwifi 0000:04:00.0: 0x00803F4C | rcm stack pointer
[ 1202.538437] iwlwifi 0000:04:00.0: 0x00000000 | rcm msg ID
[ 1202.542561] iwlwifi 0000:04:00.0: 0x20060000 | rcm ISR status
[ 1202.547033] iwlwifi 0000:04:00.0: 0x005605CE | frame HW status
[ 1202.551590] iwlwifi 0000:04:00.0: 0x00000000 | LMAC-to-RCM request mbox
[ 1202.556932] iwlwifi 0000:04:00.0: 0x00000000 | RCM-to-LMAC request mbox
[ 1202.562272] iwlwifi 0000:04:00.0: 0x000000D4 | MAC header control
[ 1202.567086] iwlwifi 0000:04:00.0: 0xA506574A | MAC header addr1 low
[ 1202.572079] iwlwifi 0000:04:00.0: 0x0100004A | MAC header info
[ 1202.576640] iwlwifi 0000:04:00.0: 0x00000000 | MAC header error
[ 1202.581446] iwlwifi 0000:04:00.0: TCM2 status:
[ 1202.584621] iwlwifi 0000:04:00.0: 0x00000070 | error ID
[ 1202.588571] iwlwifi 0000:04:00.0: 0x0000184E | tcm branchlink2
[ 1202.593131] iwlwifi 0000:04:00.0: 0x00001C44 | tcm interruptlink1
[ 1202.597950] iwlwifi 0000:04:00.0: 0x00001C44 | tcm interruptlink2
[ 1202.602769] iwlwifi 0000:04:00.0: 0x40000000 | tcm data1
[ 1202.606805] iwlwifi 0000:04:00.0: 0xDEADBEEF | tcm data2
[ 1202.610843] iwlwifi 0000:04:00.0: 0xDEADBEEF | tcm data3
[ 1202.614883] iwlwifi 0000:04:00.0: 0x000018AC | tcm log PC
[ 1202.619007] iwlwifi 0000:04:00.0: 0x00803FF0 | tcm frame pointer
[ 1202.623749] iwlwifi 0000:04:00.0: 0x00803F4C | tcm stack pointer
[ 1202.628487] iwlwifi 0000:04:00.0: 0x00000000 | tcm msg ID
[ 1202.632611] iwlwifi 0000:04:00.0: 0x60000015 | tcm ISR status
[ 1202.637082] iwlwifi 0000:04:00.0: 0x000002F0 | tcm HW status[0]
[ 1202.641724] iwlwifi 0000:04:00.0: 0x00000000 | tcm HW status[1]
[ 1202.646370] iwlwifi 0000:04:00.0: 0x00000000 | tcm HW status[2]
[ 1202.651020] iwlwifi 0000:04:00.0: 0x00008000 | tcm HW status[3]
[ 1202.655670] iwlwifi 0000:04:00.0: 0x00000000 | tcm HW status[4]
[ 1202.660316] iwlwifi 0000:04:00.0: 0x00000000 | tcm SW status[0]
[ 1202.665121] iwlwifi 0000:04:00.0: RCM2 status:
[ 1202.668293] iwlwifi 0000:04:00.0: 0x00000070 | error ID
[ 1202.672241] iwlwifi 0000:04:00.0: 0x00001B9E | rcm branchlink2
[ 1202.676800] iwlwifi 0000:04:00.0: 0x00002178 | rcm interruptlink1
[ 1202.681615] iwlwifi 0000:04:00.0: 0x00002178 | rcm interruptlink2
[ 1202.686437] iwlwifi 0000:04:00.0: 0x20000000 | rcm data1
[ 1202.690482] iwlwifi 0000:04:00.0: 0xDEADBEEF | rcm data2
[ 1202.694523] iwlwifi 0000:04:00.0: 0xDEADBEEF | rcm data3
[ 1202.698561] iwlwifi 0000:04:00.0: 0x00001C00 | rcm log PC
[ 1202.702689] iwlwifi 0000:04:00.0: 0x00803FF0 | rcm frame pointer
[ 1202.707418] iwlwifi 0000:04:00.0: 0x00803F4C | rcm stack pointer
[ 1202.712152] iwlwifi 0000:04:00.0: 0x00000000 | rcm msg ID
[ 1202.716278] iwlwifi 0000:04:00.0: 0x20000000 | rcm ISR status
[ 1202.720756] iwlwifi 0000:04:00.0: 0x00020400 | frame HW status
[ 1202.725316] iwlwifi 0000:04:00.0: 0x00000000 | LMAC-to-RCM request mbox
[ 1202.730657] iwlwifi 0000:04:00.0: 0x00000000 | RCM-to-LMAC request mbox
[ 1202.735994] iwlwifi 0000:04:00.0: 0x00000000 | MAC header control
[ 1202.740814] iwlwifi 0000:04:00.0: 0x00000000 | MAC header addr1 low
[ 1202.745811] iwlwifi 0000:04:00.0: 0x003C0000 | MAC header info
[ 1202.750374] iwlwifi 0000:04:00.0: 0x00000000 | MAC header error
[ 1202.755072] iwlwifi 0000:04:00.0: IML/ROM dump:
[ 1202.758324] iwlwifi 0000:04:00.0: 0x00000B03 | IML/ROM error/state
[ 1202.763288] iwlwifi 0000:04:00.0: 0x0000E30B | IML/ROM data1
[ 1202.767718] iwlwifi 0000:04:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
[ 1202.773012] iwlwifi 0000:04:00.0: Fseq Registers:
[ 1202.776472] iwlwifi 0000:04:00.0: 0x60000000 | FSEQ_ERROR_CODE
[ 1202.781067] iwlwifi 0000:04:00.0: 0x80B00003 | FSEQ_TOP_INIT_VERSION
[ 1202.786186] iwlwifi 0000:04:00.0: 0x004F0000 | FSEQ_CNVIO_INIT_VERSION
[ 1202.791483] iwlwifi 0000:04:00.0: 0x0000AA14 | FSEQ_OTP_VERSION
[ 1202.796168] iwlwifi 0000:04:00.0: 0x0000000F | FSEQ_TOP_CONTENT_VERSION
[ 1202.801544] iwlwifi 0000:04:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
[ 1202.806227] iwlwifi 0000:04:00.0: 0x02001910 | FSEQ_CNVI_ID
[ 1202.810564] iwlwifi 0000:04:00.0: 0x02001910 | FSEQ_CNVR_ID
[ 1202.814897] iwlwifi 0000:04:00.0: 0x02001910 | CNVI_AUX_MISC_CHIP
[ 1202.819759] iwlwifi 0000:04:00.0: 0x02001910 | CNVR_AUX_MISC_CHIP
[ 1202.824615] iwlwifi 0000:04:00.0: 0x00001BEF | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 1202.831210] iwlwifi 0000:04:00.0: 0x00000000 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 1202.838153] iwlwifi 0000:04:00.0: 0x004F0000 | FSEQ_PREV_CNVIO_INIT_VERSION
[ 1202.843881] iwlwifi 0000:04:00.0: 0x00B00003 | FSEQ_WIFI_FSEQ_VERSION
[ 1202.849092] iwlwifi 0000:04:00.0: 0xFD7EF9FE | FSEQ_BT_FSEQ_VERSION
[ 1202.854119] iwlwifi 0000:04:00.0: 0x000000BF | FSEQ_CLASS_TP_VERSION
[ 1202.859259] iwlwifi 0000:04:00.0: UMAC CURRENT PC: 0x8026934e
[ 1202.863770] iwlwifi 0000:04:00.0: LMAC1 CURRENT PC: 0xd0
[ 1202.867841] iwlwifi 0000:04:00.0: LMAC2 CURRENT PC: 0xd0
[ 1202.871913] iwlwifi 0000:04:00.0: UMAC CURRENT PC 1: 0x8026934c
[ 1202.876596] iwlwifi 0000:04:00.0: TCM1 CURRENT PC: 0xd0
[ 1202.880582] iwlwifi 0000:04:00.0: RCM1 CURRENT PC: 0xd0
[ 1202.884572] iwlwifi 0000:04:00.0: RCM2 CURRENT PC: 0xd0
[ 1202.888570] iwlwifi 0000:04:00.0: Function Scratch status:
[ 1202.892784] iwlwifi 0000:04:00.0: 0x01010100 | Func Scratch
[ 1202.907429] iwlwifi 0000:04:00.0: FW error in SYNC CMD SESSION_PROTECTION_CMD
[ 1202.913305] CPU: 0 PID: 65 Comm: kworker/u16:1 Tainted: G        W          6.7.0-rc1+ #1
[ 1202.913316] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1202.913321] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
[ 1202.913569] Call Trace:
[ 1202.913575]  <TASK>
[ 1202.913580]  dump_stack_lvl+0x71/0x90
[ 1202.913594]  iwl_trans_txq_send_hcmd+0x585/0x770 [iwlwifi]
[ 1202.913718]  ? iwl_trans_txq_freeze_timer+0x1f0/0x1f0 [iwlwifi]
[ 1202.913820]  ? swake_up_locked+0xa0/0xa0
[ 1202.913830]  ? __list_del_entry_valid_or_report+0x63/0x110
[ 1202.913845]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1202.913857]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1202.913871]  iwl_trans_send_cmd+0xd2/0x1f0 [iwlwifi]
[ 1202.913971]  iwl_mvm_send_cmd+0x4a/0xc0 [iwlmvm]
[ 1202.914063]  iwl_mvm_send_cmd_pdu+0x9a/0xd0 [iwlmvm]
[ 1202.914153]  ? iwl_mvm_request_system_statistics+0x2c0/0x2c0 [iwlmvm]
[ 1202.914245]  ? iwl_fw_lookup_cmd_ver+0x8a/0xa0 [iwlwifi]
[ 1202.914344]  ? iwl_mvm_get_session_prot_id.isra.0+0xad/0xd0 [iwlmvm]
[ 1202.914436]  iwl_mvm_cancel_session_protection+0xc1/0x130 [iwlmvm]
[ 1202.914528]  ? iwl_mvm_get_session_prot_id.isra.0+0xd0/0xd0 [iwlmvm]
[ 1202.914622]  ? __list_del_entry_valid_or_report+0x63/0x110
[ 1202.914631]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1202.914641]  ? __local_bh_enable_ip+0x87/0xe0
[ 1202.914651]  __iwl_mvm_remove_time_event+0x112/0x170 [iwlmvm]
[ 1202.914748]  iwl_mvm_remove_time_event+0xaa/0x1a0 [iwlmvm]
[ 1202.914841]  ? iwl_mvm_rx_time_event_notif+0xb50/0xb50 [iwlmvm]
[ 1202.914932]  ? spin_bug+0xe0/0xe0
[ 1202.914943]  ? __local_bh_enable_ip+0x87/0xe0
[ 1202.914950]  ? trace_hardirqs_on+0x12/0xe0
[ 1202.914959]  ? iwl_mvm_stop_session_protection+0x62/0x130 [iwlmvm]
[ 1202.915052]  ? iwl_mvm_stop_session_protection+0x8b/0x130 [iwlmvm]
[ 1202.915145]  iwl_mvm_bss_info_changed_station_common+0x3f/0x140 [iwlmvm]
[ 1202.915234]  iwl_mvm_mld_link_info_changed+0x238/0x520 [iwlmvm]
[ 1202.915329]  drv_link_info_changed+0x195/0x3c0 [mac80211]
[ 1202.915561]  ieee80211_rx_mgmt_beacon+0x189b/0x3720 [mac80211]
[ 1202.915817]  ? ieee80211_rx_mgmt_assoc_resp+0x41f0/0x41f0 [mac80211]
[ 1202.916066]  ? ret_from_fork_asm+0x11/0x20
[ 1202.916078]  ? stack_trace_save+0x8c/0xc0
[ 1202.916091]  ? ieee80211_iface_work+0x1a7/0x5c0 [mac80211]
[ 1202.916323]  ? kasan_save_stack+0x1c/0x40
[ 1202.916331]  ? kasan_set_track+0x21/0x30
[ 1202.916337]  ? kasan_save_free_info+0x27/0x40
[ 1202.916345]  ? ____kasan_slab_free+0x13f/0x1a0
[ 1202.916352]  ? kmem_cache_free+0x126/0x3a0
[ 1202.916361]  ? ieee80211_iface_work+0x1a7/0x5c0 [mac80211]
[ 1202.916593]  ? cfg80211_wiphy_work+0x133/0x150 [cfg80211]
[ 1202.916805]  ? process_one_work+0x475/0x920
[ 1202.916814]  ? worker_thread+0x38a/0x680
[ 1202.916821]  ? kthread+0x199/0x1e0
[ 1202.916828]  ? ret_from_fork+0x28/0x50
[ 1202.916836]  ? ret_from_fork_asm+0x11/0x20
[ 1202.916845]  ? lock_acquire+0xc4/0x3b0
[ 1202.916854]  ? rcu_is_watching+0x1f/0x40
[ 1202.916862]  ? rcu_is_watching+0x1f/0x40
[ 1202.916869]  ? lock_acquire+0xc4/0x3b0
[ 1202.916879]  ? lock_sync+0xf0/0xf0
[ 1202.916890]  ieee80211_sta_rx_queued_mgmt+0x144/0x1490 [mac80211]
[ 1202.917127]  ? find_held_lock+0xa0/0xa0
[ 1202.917136]  ? rcu_is_watching+0x1f/0x40
[ 1202.917145]  ? ieee80211_sta_rx_queued_ext+0xb0/0xb0 [mac80211]
[ 1202.917379]  ? lock_acquire+0xc4/0x3b0
[ 1202.917388]  ? rcu_is_watching+0x1f/0x40
[ 1202.917396]  ? lock_release+0xb2/0x3b0
[ 1202.917404]  ? skb_dequeue+0x8d/0xa0
[ 1202.917413]  ? reacquire_held_locks+0x270/0x270
[ 1202.917422]  ? spin_bug+0xe0/0xe0
[ 1202.917431]  ? lock_acquire+0xc4/0x3b0
[ 1202.917440]  ? rcu_is_watching+0x1f/0x40
[ 1202.917448]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1202.917457]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1202.917466]  ? trace_hardirqs_on+0x12/0xe0
[ 1202.917475]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1202.917486]  ieee80211_iface_work+0x494/0x5c0 [mac80211]
[ 1202.917713]  cfg80211_wiphy_work+0x133/0x150 [cfg80211]
[ 1202.917924]  process_one_work+0x475/0x920
[ 1202.917938]  ? kick_pool+0x1b0/0x1b0
[ 1202.917946]  ? __list_add_valid_or_report+0x33/0xd0
[ 1202.917964]  worker_thread+0x38a/0x680
[ 1202.917977]  ? create_worker+0x390/0x390
[ 1202.917985]  kthread+0x199/0x1e0
[ 1202.917992]  ? kthread+0xed/0x1e0
[ 1202.918000]  ? kthread_complete_and_exit+0x20/0x20
[ 1202.918009]  ret_from_fork+0x28/0x50
[ 1202.918016]  ? kthread_complete_and_exit+0x20/0x20
[ 1202.918025]  ret_from_fork_asm+0x11/0x20
[ 1202.918041]  </TASK>
[ 1202.918063] iwlwifi 0000:04:00.0: Couldn't send the SESSION_PROTECTION_CMD: -5
[ 1202.924018] iwlwifi 0000:04:00.0: failed to update power mode
[ 1205.951478] iwlwifi 0000:04:00.0: mcast filter cmd error. ret=-5
[ 1205.956222] iwlwifi 0000:04:00.0: Failed to synchronize multicast groups update
[ 1208.172812] wlan7: do_stop, canceling dfs-cac-timer-work.
[ 1208.274809] wlan4: do_stop, canceling dfs-cac-timer-work.
[ 1208.387769] wlan3: do_stop, canceling dfs-cac-timer-work.
[ 1208.508015] wlan6: do_stop, canceling dfs-cac-timer-work.
[ 1208.627864] wlan17: do_stop, canceling dfs-cac-timer-work.
[ 1208.736801] wlan21: do_stop, canceling dfs-cac-timer-work.
[ 1208.850804] wlan16: do_stop, canceling dfs-cac-timer-work.
[ 1208.971798] wlan20: do_stop, canceling dfs-cac-timer-work.
[ 1209.219801] wlan9: do_stop, canceling dfs-cac-timer-work.
[ 1209.342807] wlan15: do_stop, canceling dfs-cac-timer-work.
[ 1209.463576] iwlwifi 0000:1a:00.0: WRT: Invalid buffer destination: 0
[ 1209.819528] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1209.819590] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1209.819646] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1209.819718] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1209.819775] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1209.819850] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1209.819953] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1209.824818] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan18' already present!
[ 1209.831298] iwlwifi 0000:1a:00.0: Failed to create debugfs directory under netdev:wlan18 (mvm-vif-add-debugfs)
[ 1209.965262] iwlwifi 0000:1c:00.0: WRT: Invalid buffer destination: 0
[ 1210.319859] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.319921] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.319978] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.320033] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.320088] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.320143] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.320198] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.324600] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan22' already present!
[ 1210.331088] iwlwifi 0000:1c:00.0: Failed to create debugfs directory under netdev:wlan22 (mvm-vif-add-debugfs)
[ 1210.361788] wlan11: do_stop, canceling dfs-cac-timer-work.
[ 1210.602133] iwlwifi 0000:23:00.0: WRT: Invalid buffer destination: 0
[ 1210.961419] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.961482] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.961539] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.961595] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.961651] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.961734] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.961790] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1210.966580] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan13' already present!
[ 1210.973080] iwlwifi 0000:23:00.0: Failed to create debugfs directory under netdev:wlan13 (mvm-vif-add-debugfs)
[ 1211.163926] iwlwifi 0000:05:00.0: WRT: Invalid buffer destination: 0
[ 1211.519941] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1211.520004] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1211.520060] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1211.520115] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1211.520171] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1211.520226] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1211.520282] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1211.525018] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan7' already present!
[ 1211.531410] iwlwifi 0000:05:00.0: Failed to create debugfs directory under netdev:wlan7 (mvm-vif-add-debugfs)
[ 1211.697834] iwlwifi 0000:09:00.0: WRT: Invalid buffer destination: 0
[ 1212.057697] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.057760] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.057816] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.057871] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.057926] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.057981] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.058036] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.062739] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan4' already present!
[ 1212.069129] iwlwifi 0000:09:00.0: Failed to create debugfs directory under netdev:wlan4 (mvm-vif-add-debugfs)
[ 1212.140086] iwlwifi 0000:0a:00.0: WRT: Invalid buffer destination: 0
[ 1212.497599] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.497680] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.497737] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.497793] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.497848] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.497903] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.497958] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1212.501876] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan3' already present!
[ 1212.508264] iwlwifi 0000:0a:00.0: Failed to create debugfs directory under netdev:wlan3 (mvm-vif-add-debugfs)
[ 1212.675273] iwlwifi 0000:0e:00.0: WRT: Invalid buffer destination: 0
[ 1213.034699] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.034762] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.034819] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.034874] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.034929] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.034984] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.035039] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.040148] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan6' already present!
[ 1213.046537] iwlwifi 0000:0e:00.0: Failed to create debugfs directory under netdev:wlan6 (mvm-vif-add-debugfs)
[ 1213.214593] iwlwifi 0000:12:00.0: WRT: Invalid buffer destination: 0
[ 1213.568227] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.568289] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.568345] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.568401] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.568456] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.568510] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.568566] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1213.573839] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan17' already present!
[ 1213.580314] iwlwifi 0000:12:00.0: Failed to create debugfs directory under netdev:wlan17 (mvm-vif-add-debugfs)
[ 1213.649686] iwlwifi 0000:15:00.0: WRT: Invalid buffer destination: 0
[ 1213.911992] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1214.023714] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.023794] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.023867] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.023940] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.024012] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.024084] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.024156] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.027926] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan21' already present!
[ 1214.034411] iwlwifi 0000:15:00.0: Failed to create debugfs directory under netdev:wlan21 (mvm-vif-add-debugfs)
[ 1214.214756] iwlwifi 0000:16:00.0: WRT: Invalid buffer destination: 0
[ 1214.522984] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1214.577757] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.577819] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.577875] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.577930] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.577986] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.578041] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.578096] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1214.583001] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan16' already present!
[ 1214.589478] iwlwifi 0000:16:00.0: Failed to create debugfs directory under netdev:wlan16 (mvm-vif-add-debugfs)
[ 1214.701857] iwlwifi 0000:17:00.0: WRT: Invalid buffer destination: 0
[ 1215.036965] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1215.058187] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.058249] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.058306] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.058361] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.058416] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.058471] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.058526] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.063166] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan20' already present!
[ 1215.069650] iwlwifi 0000:17:00.0: Failed to create debugfs directory under netdev:wlan20 (mvm-vif-add-debugfs)
[ 1215.212055] iwlwifi 0000:20:00.0: WRT: Invalid buffer destination: 0
[ 1215.567633] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.567696] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.567752] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.567808] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.567863] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.567918] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.567974] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1215.572332] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan9' already present!
[ 1215.578722] iwlwifi 0000:20:00.0: Failed to create debugfs directory under netdev:wlan9 (mvm-vif-add-debugfs)
[ 1215.653099] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4000  need_scan_psc: 1 req-n-channels: 41
[ 1215.685166] iwlwifi 0000:21:00.0: WRT: Invalid buffer destination: 0
[ 1216.047482] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.047545] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.047601] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.047669] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.047725] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.047779] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.047834] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.052027] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan15' already present!
[ 1216.058504] iwlwifi 0000:21:00.0: Failed to create debugfs directory under netdev:wlan15 (mvm-vif-add-debugfs)
[ 1216.219461] iwlwifi 0000:26:00.0: WRT: Invalid buffer destination: 0
[ 1216.570965] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4000  need_scan_psc: 1 req-n-channels: 41
[ 1216.573737] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.578828] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.578885] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.578941] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.578996] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.579065] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.579167] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1216.580186] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1216.583755] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan11' already present!
[ 1216.594460] iwlwifi 0000:26:00.0: Failed to create debugfs directory under netdev:wlan11 (mvm-vif-add-debugfs)
[ 1217.199982] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1218.110734] cfg80211-scan-6ghz, n-channels is 0, flags: 0x2  need_scan_psc: 1 req-n-channels: 41
[ 1218.120739] cfg80211-scan-6ghz, n-channels is 0, flags: 0x2  need_scan_psc: 1 req-n-channels: 41
[ 1219.131955] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1219.131967] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1219.649087] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1220.157947] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1220.670950] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1227.613881] prep-connection, link-id: 2 link: ffff888162cc3800 sdata: ffff88814255cdc0 local: ffff88812bda0f40 sdata->local: ffff88812bda0f40 have_sta: 0 mlo: 1
[ 1227.626957] __sta-info-alloc, sdata: ffff88814255cdc0  local: ffff88812bda0f40 link-id: 2
[ 1227.633880] __sta-info-alloc-1, sdata: ffff88814255cdc0  sdata->local: ffff88812bda0f40
[ 1227.640647] __sta-info-alloc-2, sdata: ffff88814255cdc0  sdata->local: ffff88812bda0f40
[ 1227.647434] __sta-info-alloc-3, sdata: ffff88814255cdc0  sdata->local: ffff88812bda0f40
[ 1227.654215] __sta-info-alloc-4, sdata: ffff88814255cdc0  sdata->local: ffff88812bda0f40
[ 1227.661195] __sta-info-alloc-5, sdata: ffff88814255cdc0  sdata->local: ffff88812bda0f40
[ 1227.668058] __sta-info-alloc-6, sdata: ffff88814255cdc0  sdata->local: ffff88812bda0f40
[ 1227.674834] prep-connection-1a, link-id: 2 link: ffff888162cc3800 sdata: ffff88814255cdc0 local: ffff88812bda0f40 sdata->local: ffff88812bda0f40
[ 1227.686576] prep-connection-2, link: ffff888162cc3800 link->sdata: ffff88814255cdc0  sdata: ffff88814255cdc0 new_sta: ffff8881d0c30000  link_sta: 
ffff8881d0c30a58  cbss: ffff888154c7ca68 sdata->local: ffff88812bda0f40
[ 1227.704590] mgd-setup-link-sta, link: ffff888162cc3800 sdata: ffff88814255cdc0 local: ffff88812bda0f40
[ 1227.731705] wlan0: e4:60:17:64:e0:33 authenticate with 40:ed:00:14:f5:f5 (local address=d6:2b:f2:7c:a8:ea)
[ 1227.733432] wlan0: send auth to 40:ed:00:14:f5:f5 (try 1/4)
[ 1227.762796] wlan0: authenticated
[ 1227.765010] prep-connection, link-id: 2 link: ffff888162cc3800 sdata: ffff88814255cdc0 local: ffff88812bda0f40 sdata->local: ffff88812bda0f40 have_sta: 1 mlo: 1
[ 1227.778079] prep-connection-1a, link-id: 2 link: ffff888162cc3800 sdata: ffff88814255cdc0 local: ffff88812bda0f40 sdata->local: ffff88812bda0f40
[ 1227.790643] wlan0: associate with 40:ed:00:14:f5:f5 (try 1/3)
[ 1227.816572] wlan0: RX AssocResp from 40:ed:00:14:f5:f5 (capab=0x511 status=0 aid=17)
[ 1227.827586] wlan0: [link 0] local address 3e:26:3d:ad:58:a9, AP link address 92:ed:00:14:f5:f2
[ 1227.827648] mgd-setup-link-sta, link: ffff888155fd5000 sdata: ffff88814255cdc0 local: ffff88812bda0f40
[ 1227.835775] wlan0: [link 1] local address 2e:d1:1a:42:56:df, AP link address 52:ed:00:14:f5:f5
[ 1227.835846] mgd-setup-link-sta, link: ffff888199b1b800 sdata: ffff88814255cdc0 local: ffff88812bda0f40
[ 1227.844004] wlan0: [link 2] local address d6:2b:f2:7c:a8:ea, AP link address 92:ed:00:14:f5:f3 (assoc)
[ 1227.844012] mgd-setup-link-sta, link: ffff888162cc3800 sdata: ffff88814255cdc0 local: ffff88812bda0f40
[ 1227.852600] enabling LDPC due to HT Cap
[ 1227.852604] enabling LDPC due to HE cap
[ 1227.855387] wlan0: associated
[ 1227.857087] wlan0: Limiting TX power to 30 (30 - 0) dBm as advertised by 92:ed:00:14:f5:f3
[ 1227.885770] enabling LDPC due to HT Cap
[ 1227.885776] enabling LDPC due to HE cap
[ 1227.888132] enabling LDPC due to HT Cap
[ 1227.888137] enabling LDPC due to HE cap
[ 1228.411980] wlan0: deauthenticating from 40:ed:00:14:f5:f5 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 1229.353392] enabling LDPC due to HT Cap
[ 1229.353398] enabling LDPC due to HE cap
[ 1229.353405] enabling LDPC due to HT Cap
[ 1229.353408] enabling LDPC due to HE cap
[ 1229.397657] wlan0: do_stop, canceling dfs-cac-timer-work.
[ 1248.412245] wlan1: deauthenticating from 40:ed:00:14:f5:f5 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 1248.412381] iwlwifi 0000:04:00.0: Failed to send flush command (-5)
[ 1248.417425] iwlwifi 0000:04:00.0: flush request fail
[ 1248.421941] ------------[ cut here ]------------
[ 1248.421947] WARNING: CPU: 6 PID: 18904 at drivers/net/wireless/intel/iwlwifi/mvm/../iwl-trans.h:1442 iwl_mvm_wait_sta_queues_empty+0xdd/0x120 [iwlmvm]
[ 1248.422066] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 snd_hda_codec_hdmi iTCO_vendor_support snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel snd_intel_dspcfg snd_hda_codec 
intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm snd_timer irqbypass intel_wmi_thunderbolt snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm igb i2c_algo_bit ixgbe mdio drm dca agpgart
[ 1248.422434]  xhci_pci mei_wdt i2c_core hwmon xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 1248.422469] CPU: 6 PID: 18904 Comm: ip Tainted: G        W          6.7.0-rc1+ #1
[ 1248.422478] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1248.422485] RIP: 0010:iwl_mvm_wait_sta_queues_empty+0xdd/0x120 [iwlmvm]
[ 1248.422604] Code: c0 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f c3 0f 0b 48 83 c4 10 b8 f4 fd ff ff 5b 5d 41 5c 41 5d 41 5e 41 5f c3 44 89 04 24 <0f> 0b 49 8d 
7c 24 40 e8 27 91 c2 df 49 8b 7c 24 40 44 8b 04 24 31
[ 1248.422613] RSP: 0018:ffff88819ef4e8a0 EFLAGS: 00010293
[ 1248.422623] RAX: 0000000000000000 RBX: ffff88812d5b5258 RCX: dffffc0000000000
[ 1248.422631] RDX: 0000000000000003 RSI: ffffffffa19e1e7e RDI: ffff8881369c4058
[ 1248.422639] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
[ 1248.422645] R10: ffffffff83f2fdd7 R11: ffffffff81609051 R12: ffff8881369c4028
[ 1248.422653] R13: ffff88812d5b5208 R14: ffff88812d5b53c0 R15: ffffffffa164cc50
[ 1248.422661] FS:  00007fb449a8ec40(0000) GS:ffff88841c100000(0000) knlGS:0000000000000000
[ 1248.422670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1248.422677] CR2: 00000000004cd060 CR3: 00000001538d0001 CR4: 00000000003706f0
[ 1248.422685] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1248.422692] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1248.422699] Call Trace:
[ 1248.422705]  <TASK>
[ 1248.422713]  ? __warn+0x9c/0x1f0
[ 1248.422726]  ? iwl_mvm_wait_sta_queues_empty+0xdd/0x120 [iwlmvm]
[ 1248.422906]  ? report_bug+0x1aa/0x1e0
[ 1248.422922]  ? handle_bug+0x41/0x80
[ 1248.422932]  ? exc_invalid_op+0x13/0x40
[ 1248.422943]  ? asm_exc_invalid_op+0x16/0x20
[ 1248.422954]  ? iwl_trans_pcie_read_mem+0x1d0/0x1d0 [iwlwifi]
[ 1248.423132]  ? kasan_set_track+0x21/0x30
[ 1248.423147]  ? iwl_mvm_wait_sta_queues_empty+0x8e/0x120 [iwlmvm]
[ 1248.423412]  ? iwl_mvm_wait_sta_queues_empty+0xdd/0x120 [iwlmvm]
[ 1248.423564]  iwl_mvm_mac_flush+0x2b9/0x580 [iwlmvm]
[ 1248.423686]  __ieee80211_flush_queues+0x283/0x570 [mac80211]
[ 1248.423978]  ? ieee80211_get_vif_queues+0x160/0x160 [mac80211]
[ 1248.424269]  ? __ieee80211_tx_skb_tid_band+0x103/0x330 [mac80211]
[ 1248.424576]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.424587]  ? __rcu_read_unlock+0x66/0x290
[ 1248.424605]  ieee80211_set_disassoc+0x9c2/0xbf0 [mac80211]
[ 1248.424984]  ? ieee80211_chswitch_done+0x2f0/0x2f0 [mac80211]
[ 1248.425295]  ieee80211_mgd_deauth+0x288/0xb50 [mac80211]
[ 1248.425609]  ? rcu_is_watching+0x1f/0x40
[ 1248.425622]  ? ieee80211_mgd_assoc+0x2910/0x2910 [mac80211]
[ 1248.425997]  ? rcu_is_watching+0x1f/0x40
[ 1248.426009]  ? rcu_is_watching+0x1f/0x40
[ 1248.426020]  ? lock_acquire+0xc4/0x3b0
[ 1248.426033]  ? lock_sync+0xf0/0xf0
[ 1248.426048]  ? reacquire_held_locks+0x270/0x270
[ 1248.426068]  cfg80211_mlme_deauth+0x1db/0x480 [cfg80211]
[ 1248.426358]  ? cfg80211_mlme_assoc+0x590/0x590 [cfg80211]
[ 1248.426714]  ? pvh_start_xen+0x3/0x80
[ 1248.426726]  ? is_bpf_text_address+0x60/0xf0
[ 1248.426735]  ? cfg80211_pmsr_wdev_down+0x93/0xa0 [cfg80211]
[ 1248.427066]  ? reacquire_held_locks+0x270/0x270
[ 1248.427082]  cfg80211_mlme_down+0xf5/0x160 [cfg80211]
[ 1248.427362]  ? cfg80211_mlme_disassoc+0x3c0/0x3c0 [cfg80211]
[ 1248.427632]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.427643]  ? cfg80211_pmsr_wdev_down+0x93/0xa0 [cfg80211]
[ 1248.427916]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.427926]  ? cfg80211_stop_background_radar_detection+0x4b/0x290 [cfg80211]
[ 1248.428194]  cfg80211_disconnect+0x2ce/0x400 [cfg80211]
[ 1248.428473]  cfg80211_netdev_notifier_call+0x497/0x860 [cfg80211]
[ 1248.428738]  ? cfg80211_register_netdevice+0x140/0x140 [cfg80211]
[ 1248.428993]  ? select_task_rq_fair+0x2fd/0x26e0
[ 1248.429012]  ? rcu_is_watching+0x1f/0x40
[ 1248.429021]  ? lock_acquire+0xc4/0x3b0
[ 1248.429034]  ? lock_sync+0xf0/0xf0
[ 1248.429045]  ? rcu_is_watching+0x1f/0x40
[ 1248.429055]  ? lock_acquire+0xc4/0x3b0
[ 1248.429065]  ? rcu_is_watching+0x1f/0x40
[ 1248.429075]  ? lock_acquire+0xc4/0x3b0
[ 1248.429086]  ? rcu_is_watching+0x1f/0x40
[ 1248.429096]  ? lock_release+0xb2/0x3b0
[ 1248.429106]  ? reacquire_held_locks+0x270/0x270
[ 1248.429116]  ? packet_notifier+0x100/0x440
[ 1248.429126]  ? reacquire_held_locks+0x270/0x270
[ 1248.429138]  ? mutex_is_locked+0x16/0x30
[ 1248.429148]  ? rtnl_is_locked+0xc/0x10
[ 1248.429157]  ? inetdev_event+0x91/0xbd0
[ 1248.429174]  ? packet_notifier+0x105/0x440
[ 1248.429187]  notifier_call_chain+0x51/0x180
[ 1248.429202]  __dev_close_many+0xb8/0x1d0
[ 1248.429213]  ? netdev_notify_peers+0x20/0x20
[ 1248.429223]  ? queue_work_on+0x4d/0x80
[ 1248.429232]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.429244]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.429253]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.429267]  __dev_change_flags+0x2ba/0x390
[ 1248.429278]  ? lock_sync+0xf0/0xf0
[ 1248.429289]  ? dev_set_allmulti+0x10/0x10
[ 1248.429300]  ? rcu_is_watching+0x1f/0x40
[ 1248.429324]  ? lock_release+0xb2/0x3b0
[ 1248.429338]  dev_change_flags+0x53/0xb0
[ 1248.429352]  do_setlink+0x5b3/0x1a70
[ 1248.429366]  ? rtnl_bridge_getlink+0x420/0x420
[ 1248.429376]  ? unwind_next_frame+0xbb9/0xeb0
[ 1248.429387]  ? stack_access_ok+0x40/0xf0
[ 1248.429403]  ? is_bpf_text_address+0x65/0xf0
[ 1248.429412]  ? kernel_text_address+0x89/0x110
[ 1248.429424]  ? __kernel_text_address+0x9/0x30
[ 1248.429436]  ? unwind_get_return_address+0x2a/0x40
[ 1248.429447]  ? write_profile+0x220/0x220
[ 1248.429456]  ? arch_stack_walk+0x93/0xe0
[ 1248.429471]  ? __nla_validate_parse+0xb0/0x1250
[ 1248.429483]  ? stack_trace_save+0x8c/0xc0
[ 1248.429498]  ? filter_irq_stacks+0x18/0x60
[ 1248.429508]  ? nla_get_range_signed+0x160/0x160
[ 1248.429517]  ? filter_irq_stacks+0x18/0x60
[ 1248.429530]  ? kasan_save_stack+0x2b/0x40
[ 1248.429539]  ? kasan_save_stack+0x1c/0x40
[ 1248.429556]  __rtnl_newlink+0x70b/0xcf0
[ 1248.429570]  ? ___slab_alloc+0x109a/0x1210
[ 1248.429585]  ? rtnl_link_unregister+0x1d0/0x1d0
[ 1248.429598]  ? rtnl_newlink+0x31/0x70
[ 1248.429614]  ? kasan_unpoison+0x23/0x50
[ 1248.429624]  ? __kasan_slab_alloc+0x2f/0x70
[ 1248.429635]  ? __kmem_cache_alloc_node+0x159/0x280
[ 1248.429649]  ? rtnetlink_rcv_msg+0x1c0/0x7d0
[ 1248.429659]  ? rtnl_newlink+0x31/0x70
[ 1248.429670]  ? kasan_save_stack+0x1c/0x40
[ 1248.429683]  rtnl_newlink+0x4a/0x70
[ 1248.429698]  rtnetlink_rcv_msg+0x20c/0x7d0
[ 1248.429712]  ? rtnl_getlink+0x580/0x580
[ 1248.429721]  ? __alloc_skb+0xcb/0x210
[ 1248.429730]  ? netlink_sendmsg+0x507/0x6f0
[ 1248.429746]  ? __sock_sendmsg+0x6e/0xb0
[ 1248.429756]  ? ____sys_sendmsg+0x3e6/0x470
[ 1248.429764]  ? ___sys_sendmsg+0xdc/0x140
[ 1248.429774]  ? __sys_sendmsg+0xc4/0x150
[ 1248.429784]  ? do_syscall_64+0x3b/0x110
[ 1248.429796]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1248.429807]  ? ____sys_sendmsg+0x3e6/0x470
[ 1248.429816]  ? ___sys_sendmsg+0xdc/0x140
[ 1248.429831]  netlink_rcv_skb+0xcf/0x210
[ 1248.429845]  ? rcu_is_watching+0x1f/0x40
[ 1248.429855]  ? rtnl_getlink+0x580/0x580
[ 1248.429866]  ? netlink_ack+0x840/0x840
[ 1248.429876]  ? lock_sync+0xf0/0xf0
[ 1248.429890]  ? lock_release+0xb2/0x3b0
[ 1248.429909]  ? __rcu_read_unlock+0x66/0x290
[ 1248.429920]  ? netlink_deliver_tap+0x9f/0x630
[ 1248.429931]  ? netlink_deliver_tap+0xf9/0x630
[ 1248.429950]  netlink_unicast+0x2ee/0x490
[ 1248.429963]  ? netlink_attachskb+0x430/0x430
[ 1248.429974]  ? reacquire_held_locks+0x270/0x270
[ 1248.429988]  ? __virt_addr_valid+0xab/0x130
[ 1248.429998]  ? check_stack_object+0x1d/0x60
[ 1248.430011]  ? __check_object_size+0x22c/0x3b0
[ 1248.430026]  netlink_sendmsg+0x3ca/0x6f0
[ 1248.430043]  ? netlink_unicast+0x490/0x490
[ 1248.430056]  ? import_ubuf+0xa9/0xd0
[ 1248.430069]  ? __import_iovec+0x256/0x290
[ 1248.430086]  ? netlink_unicast+0x490/0x490
[ 1248.430097]  __sock_sendmsg+0x6e/0xb0
[ 1248.430109]  ____sys_sendmsg+0x3e6/0x470
[ 1248.430122]  ? kernel_sendmsg+0x30/0x30
[ 1248.430138]  ? __copy_msghdr+0x1a0/0x1a0
[ 1248.430149]  ? rcu_is_watching+0x1f/0x40
[ 1248.430163]  ? lock_release+0xb2/0x3b0
[ 1248.430175]  ? is_bpf_text_address+0x60/0xf0
[ 1248.430285]  ___sys_sendmsg+0xdc/0x140
[ 1248.430298]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 1248.430323]  ? is_bpf_text_address+0x65/0xf0
[ 1248.430337]  ? kernel_text_address+0x89/0x110
[ 1248.430351]  ? __kernel_text_address+0x9/0x30
[ 1248.430363]  ? unwind_get_return_address+0x2a/0x40
[ 1248.430379]  ? write_profile+0x220/0x220
[ 1248.430389]  ? arch_stack_walk+0x93/0xe0
[ 1248.430408]  ? rcu_is_watching+0x1f/0x40
[ 1248.430420]  ? __fget_light+0xd2/0xf0
[ 1248.430438]  __sys_sendmsg+0xc4/0x150
[ 1248.430451]  ? __sys_sendmsg_sock+0x10/0x10
[ 1248.430462]  ? rcu_is_watching+0x1f/0x40
[ 1248.430472]  ? lock_release+0xb2/0x3b0
[ 1248.430483]  ? __x64_sys_close+0x4c/0x90
[ 1248.430498]  ? __x64_sys_close+0x4c/0x90
[ 1248.430506]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.430518]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1248.430530]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.430547]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 1248.430558]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.430571]  do_syscall_64+0x3b/0x110
[ 1248.430581]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1248.430596] RIP: 0033:0x7fb449d13737
[ 1248.430605] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[ 1248.430614] RSP: 002b:00007fff9b396228 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1248.430625] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb449d13737
[ 1248.430639] RDX: 0000000000000000 RSI: 00007fff9b396290 RDI: 0000000000000004
[ 1248.430645] RBP: 0000000000000003 R08: 00000000654d79f7 R09: 00007fff9b39898a
[ 1248.430652] R10: 00007fb449c0df08 R11: 0000000000000246 R12: 00000000654d79f8
[ 1248.430659] R13: 0000000000484540 R14: 0000000000000001 R15: 0000000000000000
[ 1248.430677]  </TASK>
[ 1248.430687] irq event stamp: 0
[ 1248.430692] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1248.430700] hardirqs last disabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1248.430712] softirqs last  enabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1248.430722] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1248.430729] ---[ end trace 0000000000000000 ]---
[ 1248.430739] iwlwifi 0000:04:00.0: iwl_trans_wait_txq_empty bad state = 0
[ 1248.436663] iwlwifi 0000:04:00.0: Failed to trigger RX queues sync (-5)
[ 1248.442098] enabling LDPC due to HT Cap
[ 1248.442103] enabling LDPC due to HE cap
[ 1248.442113] iwlwifi 0000:04:00.0: Failed to send rate scale config (-5)
[ 1248.447516] enabling LDPC due to HT Cap
[ 1248.447520] enabling LDPC due to HE cap
[ 1248.447528] iwlwifi 0000:04:00.0: Failed to send rate scale config (-5)
[ 1248.453553] iwlwifi 0000:04:00.0: Failed to send flush command (-5)
[ 1248.458566] iwlwifi 0000:04:00.0: flush request fail
[ 1248.462340] iwlwifi 0000:04:00.0: Failed to send flush command (-5)
[ 1248.467341] iwlwifi 0000:04:00.0: flush request fail
[ 1248.471121] wlan1: failed to remove key (0, 40:ed:00:14:f5:f5) from hardware (-5)
[ 1248.478007] iwlwifi 0000:04:00.0: Failed to send flush command (-5)
[ 1248.486126] iwlwifi 0000:04:00.0: Failed to send MAC_CONFIG_CMD (action:2): -5
[ 1248.492090] iwlwifi 0000:04:00.0: failed to update MAC e4:60:17:65:34:7f
[ 1248.497519] iwlwifi 0000:04:00.0: Failed to remove station. Id=1
[ 1248.502328] iwlwifi 0000:04:00.0: failed to remove AP station
[ 1248.506795] iwlwifi 0000:04:00.0: Failed to remove station. Id=0
[ 1248.511594] iwlwifi 0000:04:00.0: failed to remove AP station
[ 1248.516073] iwlwifi 0000:04:00.0: Failed to synchronize multicast groups update
[ 1248.523000] iwlwifi 0000:04:00.0: failed to deactivate ESR mode (-5)
[ 1248.528119] iwlwifi 0000:04:00.0: Failed to send LINK_CONFIG_CMD (action:2): -5
[ 1248.534221] iwlwifi 0000:04:00.0: PHY ctxt cmd error. ret=-5
[ 1248.538623] iwlwifi 0000:04:00.0: Failed to send LINK_CONFIG_CMD (action:2): -5
[ 1248.544717] iwlwifi 0000:04:00.0: PHY ctxt cmd error. ret=-5
[ 1248.558774] iwlwifi 0000:04:00.0: Failed to send LINK_CONFIG_CMD (action:3): -5
[ 1248.567774] ------------[ cut here ]------------
[ 1248.567778] WARNING: CPU: 2 PID: 18904 at net/mac80211/link.c:228 ieee80211_set_vif_links_bitmaps+0xe6/0x110 [mac80211]
[ 1248.567932] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 snd_hda_codec_hdmi iTCO_vendor_support snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel snd_intel_dspcfg snd_hda_codec 
intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm snd_timer irqbypass intel_wmi_thunderbolt snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm igb i2c_algo_bit ixgbe mdio drm dca agpgart
[ 1248.568129]  xhci_pci mei_wdt i2c_core hwmon xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 1248.568149] CPU: 2 PID: 18904 Comm: ip Tainted: G        W          6.7.0-rc1+ #1
[ 1248.568156] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1248.568160] RIP: 0010:ieee80211_set_vif_links_bitmaps+0xe6/0x110 [mac80211]
[ 1248.568303] Code: 20 2a e9 df 66 83 bb c2 27 00 00 00 75 b6 41 f7 d4 41 21 ec 41 0f b7 fc 66 44 89 a3 c2 27 00 00 f3 0f b8 c7 90 83 f8 01 76 9a <0f> 0b eb 96 
48 8d bb c2 27 00 00 e8 5a 2a e9 df 66 89 ab c2 27 00
[ 1248.568319] RSP: 0018:ffff88819ef4e5f0 EFLAGS: 00010202
[ 1248.568325] RAX: 0000000000000003 RBX: ffff888163174dc0 RCX: ffffffffa17783f0
[ 1248.568330] RDX: dffffc0000000000 RSI: 0000000000000003 RDI: 0000000000000007
[ 1248.568334] RBP: 0000000000000007 R08: 0000000000000000 R09: 0000000000000000
[ 1248.568338] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000007
[ 1248.568341] R13: ffff888163177584 R14: 0000000000000000 R15: ffff8881631770d8
[ 1248.568345] FS:  00007fb449a8ec40(0000) GS:ffff88841bf00000(0000) knlGS:0000000000000000
[ 1248.568350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1248.568354] CR2: 00007fd997cc15a0 CR3: 00000001538d0002 CR4: 00000000003706f0
[ 1248.568358] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1248.568362] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1248.568366] Call Trace:
[ 1248.568369]  <TASK>
[ 1248.568374]  ? __warn+0x9c/0x1f0
[ 1248.568382]  ? ieee80211_set_vif_links_bitmaps+0xe6/0x110 [mac80211]
[ 1248.568525]  ? report_bug+0x1aa/0x1e0
[ 1248.568534]  ? handle_bug+0x41/0x80
[ 1248.568539]  ? exc_invalid_op+0x13/0x40
[ 1248.568545]  ? asm_exc_invalid_op+0x16/0x20
[ 1248.568554]  ? ieee80211_set_vif_links_bitmaps+0xc0/0x110 [mac80211]
[ 1248.568707]  ? ieee80211_set_vif_links_bitmaps+0xe6/0x110 [mac80211]
[ 1248.568862]  ieee80211_vif_update_links+0x5cd/0x9f0 [mac80211]
[ 1248.569024]  ? ieee80211_link_init+0x350/0x350 [mac80211]
[ 1248.569171]  ? stack_trace_save+0x8c/0xc0
[ 1248.569177]  ? filter_irq_stacks+0x18/0x60
[ 1248.569186]  ? lock_release+0xb2/0x3b0
[ 1248.569193]  ? debug_object_assert_init+0x1d1/0x270
[ 1248.569430]  ? lock_acquire+0xc4/0x3b0
[ 1248.569438]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.569454]  ? rcu_is_watching+0x1f/0x40
[ 1248.569463]  ieee80211_vif_set_links+0x72/0xf0 [mac80211]
[ 1248.569654]  ? ieee80211_find_best_sta_link+0x260/0x260 [mac80211]
[ 1248.569831]  ? _raw_spin_lock_irqsave+0x47/0x60
[ 1248.569839]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.569845]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1248.569851]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.569858]  ieee80211_set_disassoc+0x741/0xbf0 [mac80211]
[ 1248.570131]  ? ieee80211_chswitch_done+0x2f0/0x2f0 [mac80211]
[ 1248.570291]  ieee80211_mgd_deauth+0x288/0xb50 [mac80211]
[ 1248.571075]  ? rcu_is_watching+0x1f/0x40
[ 1248.571083]  ? ieee80211_mgd_assoc+0x2910/0x2910 [mac80211]
[ 1248.571239]  ? rcu_is_watching+0x1f/0x40
[ 1248.571245]  ? rcu_is_watching+0x1f/0x40
[ 1248.571250]  ? lock_acquire+0xc4/0x3b0
[ 1248.571257]  ? lock_sync+0xf0/0xf0
[ 1248.571263]  ? reacquire_held_locks+0x270/0x270
[ 1248.571273]  cfg80211_mlme_deauth+0x1db/0x480 [cfg80211]
[ 1248.571426]  ? cfg80211_mlme_assoc+0x590/0x590 [cfg80211]
[ 1248.571563]  ? pvh_start_xen+0x3/0x80
[ 1248.571569]  ? is_bpf_text_address+0x60/0xf0
[ 1248.571574]  ? cfg80211_pmsr_wdev_down+0x93/0xa0 [cfg80211]
[ 1248.571733]  ? reacquire_held_locks+0x270/0x270
[ 1248.571743]  cfg80211_mlme_down+0xf5/0x160 [cfg80211]
[ 1248.572430]  ? cfg80211_mlme_disassoc+0x3c0/0x3c0 [cfg80211]
[ 1248.572577]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.572584]  ? cfg80211_pmsr_wdev_down+0x93/0xa0 [cfg80211]
[ 1248.572819]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.572826]  ? cfg80211_stop_background_radar_detection+0x4b/0x290 [cfg80211]
[ 1248.572985]  cfg80211_disconnect+0x2ce/0x400 [cfg80211]
[ 1248.573144]  cfg80211_netdev_notifier_call+0x497/0x860 [cfg80211]
[ 1248.573350]  ? cfg80211_register_netdevice+0x140/0x140 [cfg80211]
[ 1248.573525]  ? select_task_rq_fair+0x2fd/0x26e0
[ 1248.573539]  ? rcu_is_watching+0x1f/0x40
[ 1248.573549]  ? lock_acquire+0xc4/0x3b0
[ 1248.573560]  ? lock_sync+0xf0/0xf0
[ 1248.573571]  ? rcu_is_watching+0x1f/0x40
[ 1248.573581]  ? lock_acquire+0xc4/0x3b0
[ 1248.573592]  ? rcu_is_watching+0x1f/0x40
[ 1248.573601]  ? lock_acquire+0xc4/0x3b0
[ 1248.573613]  ? rcu_is_watching+0x1f/0x40
[ 1248.573622]  ? lock_release+0xb2/0x3b0
[ 1248.573632]  ? reacquire_held_locks+0x270/0x270
[ 1248.573643]  ? packet_notifier+0x100/0x440
[ 1248.573653]  ? reacquire_held_locks+0x270/0x270
[ 1248.573664]  ? mutex_is_locked+0x16/0x30
[ 1248.573673]  ? rtnl_is_locked+0xc/0x10
[ 1248.573681]  ? inetdev_event+0x91/0xbd0
[ 1248.573696]  ? packet_notifier+0x105/0x440
[ 1248.573710]  notifier_call_chain+0x51/0x180
[ 1248.573726]  __dev_close_many+0xb8/0x1d0
[ 1248.573736]  ? netdev_notify_peers+0x20/0x20
[ 1248.573746]  ? queue_work_on+0x4d/0x80
[ 1248.573756]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.573768]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.573777]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.573789]  __dev_change_flags+0x2ba/0x390
[ 1248.573798]  ? lock_sync+0xf0/0xf0
[ 1248.573804]  ? dev_set_allmulti+0x10/0x10
[ 1248.573810]  ? rcu_is_watching+0x1f/0x40
[ 1248.573816]  ? lock_release+0xb2/0x3b0
[ 1248.573823]  dev_change_flags+0x53/0xb0
[ 1248.573833]  do_setlink+0x5b3/0x1a70
[ 1248.573842]  ? rtnl_bridge_getlink+0x420/0x420
[ 1248.573847]  ? unwind_next_frame+0xbb9/0xeb0
[ 1248.573854]  ? stack_access_ok+0x40/0xf0
[ 1248.573862]  ? is_bpf_text_address+0x65/0xf0
[ 1248.573867]  ? kernel_text_address+0x89/0x110
[ 1248.573874]  ? __kernel_text_address+0x9/0x30
[ 1248.573884]  ? unwind_get_return_address+0x2a/0x40
[ 1248.573891]  ? write_profile+0x220/0x220
[ 1248.573896]  ? arch_stack_walk+0x93/0xe0
[ 1248.573904]  ? __nla_validate_parse+0xb0/0x1250
[ 1248.573911]  ? stack_trace_save+0x8c/0xc0
[ 1248.573916]  ? filter_irq_stacks+0x18/0x60
[ 1248.573922]  ? nla_get_range_signed+0x160/0x160
[ 1248.573927]  ? filter_irq_stacks+0x18/0x60
[ 1248.573937]  ? kasan_save_stack+0x2b/0x40
[ 1248.573943]  ? kasan_save_stack+0x1c/0x40
[ 1248.573951]  __rtnl_newlink+0x70b/0xcf0
[ 1248.573959]  ? ___slab_alloc+0x109a/0x1210
[ 1248.573966]  ? rtnl_link_unregister+0x1d0/0x1d0
[ 1248.573972]  ? rtnl_newlink+0x31/0x70
[ 1248.573980]  ? kasan_unpoison+0x23/0x50
[ 1248.573986]  ? __kasan_slab_alloc+0x2f/0x70
[ 1248.573992]  ? __kmem_cache_alloc_node+0x159/0x280
[ 1248.573998]  ? rtnetlink_rcv_msg+0x1c0/0x7d0
[ 1248.574153]  ? rtnl_newlink+0x31/0x70
[ 1248.574161]  ? kasan_save_stack+0x1c/0x40
[ 1248.574168]  rtnl_newlink+0x4a/0x70
[ 1248.574174]  rtnetlink_rcv_msg+0x20c/0x7d0
[ 1248.574181]  ? rtnl_getlink+0x580/0x580
[ 1248.574186]  ? __alloc_skb+0xcb/0x210
[ 1248.574191]  ? netlink_sendmsg+0x507/0x6f0
[ 1248.574197]  ? __sock_sendmsg+0x6e/0xb0
[ 1248.574202]  ? ____sys_sendmsg+0x3e6/0x470
[ 1248.574207]  ? ___sys_sendmsg+0xdc/0x140
[ 1248.574212]  ? __sys_sendmsg+0xc4/0x150
[ 1248.574217]  ? do_syscall_64+0x3b/0x110
[ 1248.574222]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1248.574228]  ? ____sys_sendmsg+0x3e6/0x470
[ 1248.574233]  ? ___sys_sendmsg+0xdc/0x140
[ 1248.574242]  netlink_rcv_skb+0xcf/0x210
[ 1248.574247]  ? rcu_is_watching+0x1f/0x40
[ 1248.574252]  ? rtnl_getlink+0x580/0x580
[ 1248.574258]  ? netlink_ack+0x840/0x840
[ 1248.574263]  ? lock_sync+0xf0/0xf0
[ 1248.574269]  ? lock_release+0xb2/0x3b0
[ 1248.574279]  ? __rcu_read_unlock+0x66/0x290
[ 1248.574285]  ? netlink_deliver_tap+0x9f/0x630
[ 1248.574291]  ? netlink_deliver_tap+0xf9/0x630
[ 1248.574299]  netlink_unicast+0x2ee/0x490
[ 1248.574305]  ? netlink_attachskb+0x430/0x430
[ 1248.574326]  ? reacquire_held_locks+0x270/0x270
[ 1248.574336]  ? __virt_addr_valid+0xab/0x130
[ 1248.574341]  ? check_stack_object+0x1d/0x60
[ 1248.574349]  ? __check_object_size+0x22c/0x3b0
[ 1248.574356]  netlink_sendmsg+0x3ca/0x6f0
[ 1248.574364]  ? netlink_unicast+0x490/0x490
[ 1248.574371]  ? import_ubuf+0xa9/0xd0
[ 1248.574378]  ? __import_iovec+0x256/0x290
[ 1248.574385]  ? netlink_unicast+0x490/0x490
[ 1248.574391]  __sock_sendmsg+0x6e/0xb0
[ 1248.574398]  ____sys_sendmsg+0x3e6/0x470
[ 1248.574411]  ? kernel_sendmsg+0x30/0x30
[ 1248.574421]  ? __copy_msghdr+0x1a0/0x1a0
[ 1248.574429]  ? rcu_is_watching+0x1f/0x40
[ 1248.574442]  ? lock_release+0xb2/0x3b0
[ 1248.574454]  ? is_bpf_text_address+0x60/0xf0
[ 1248.574468]  ___sys_sendmsg+0xdc/0x140
[ 1248.574480]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 1248.574495]  ? is_bpf_text_address+0x65/0xf0
[ 1248.574504]  ? kernel_text_address+0x89/0x110
[ 1248.574517]  ? __kernel_text_address+0x9/0x30
[ 1248.574530]  ? unwind_get_return_address+0x2a/0x40
[ 1248.574541]  ? write_profile+0x220/0x220
[ 1248.574551]  ? arch_stack_walk+0x93/0xe0
[ 1248.574571]  ? rcu_is_watching+0x1f/0x40
[ 1248.574583]  ? __fget_light+0xd2/0xf0
[ 1248.574597]  __sys_sendmsg+0xc4/0x150
[ 1248.574608]  ? __sys_sendmsg_sock+0x10/0x10
[ 1248.574619]  ? rcu_is_watching+0x1f/0x40
[ 1248.574627]  ? lock_release+0xb2/0x3b0
[ 1248.574637]  ? __x64_sys_close+0x4c/0x90
[ 1248.574653]  ? __x64_sys_close+0x4c/0x90
[ 1248.574661]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.574667]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1248.574673]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.574680]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 1248.574689]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.574696]  do_syscall_64+0x3b/0x110
[ 1248.574702]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1248.574708] RIP: 0033:0x7fb449d13737
[ 1248.574713] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[ 1248.574718] RSP: 002b:00007fff9b396228 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1248.574725] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb449d13737
[ 1248.574731] RDX: 0000000000000000 RSI: 00007fff9b396290 RDI: 0000000000000004
[ 1248.574737] RBP: 0000000000000003 R08: 00000000654d79f7 R09: 00007fff9b39898a
[ 1248.574804] R10: 00007fb449c0df08 R11: 0000000000000246 R12: 00000000654d79f8
[ 1248.574812] R13: 0000000000484540 R14: 0000000000000001 R15: 0000000000000000
[ 1248.574829]  </TASK>
[ 1248.574835] irq event stamp: 0
[ 1248.574843] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1248.574852] hardirqs last disabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1248.574864] softirqs last  enabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1248.574873] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1248.574880] ---[ end trace 0000000000000000 ]---
[ 1248.586560] iwlwifi 0000:04:00.0: Failed to synchronize multicast groups update
[ 1248.608460] ------------[ cut here ]------------
[ 1248.608465] destroying interface with valid links 0x0007
[ 1248.608537] WARNING: CPU: 2 PID: 18904 at net/mac80211/iface.c:597 ieee80211_do_stop+0xdf0/0xe40 [mac80211]
[ 1248.608688] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 snd_hda_codec_hdmi iTCO_vendor_support snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel snd_intel_dspcfg snd_hda_codec 
intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm snd_timer irqbypass intel_wmi_thunderbolt snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm igb i2c_algo_bit ixgbe mdio drm dca agpgart
[ 1248.608885]  xhci_pci mei_wdt i2c_core hwmon xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 1248.608905] CPU: 2 PID: 18904 Comm: ip Tainted: G        W          6.7.0-rc1+ #1
[ 1248.608911] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1248.608915] RIP: 0010:ieee80211_do_stop+0xdf0/0xe40 [mac80211]
[ 1248.609057] Code: e8 75 e9 cd ff e9 7a fd ff ff 48 8b 34 24 48 89 df e8 94 b5 fc ff e9 52 fd ff ff 0f b7 f0 48 c7 c7 40 85 90 a1 e8 40 7c a6 df <0f> 0b e9 c7 
f4 ff ff 48 89 df e8 81 ec ff ff e9 98 fd ff ff 89 c6
[ 1248.609062] RSP: 0018:ffff88819ef4ef18 EFLAGS: 00010286
[ 1248.609069] RAX: 0000000000000000 RBX: ffff88812a7a0f40 RCX: 0000000000000027
[ 1248.609073] RDX: 0000000000000027 RSI: ffffffff814190fe RDI: ffff88841bf287c8
[ 1248.609077] RBP: ffff888163175e10 R08: 0000000000000001 R09: ffffed10837e50f9
[ 1248.609081] R10: ffff88841bf287cb R11: 0000000000141888 R12: ffff888163174000
[ 1248.609085] R13: ffff88812a7a2028 R14: ffff888163174dc0 R15: ffff888163174dc0
[ 1248.609089] FS:  00007fb449a8ec40(0000) GS:ffff88841bf00000(0000) knlGS:0000000000000000
[ 1248.609094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1248.609098] CR2: 00007fd997cc15a0 CR3: 00000001538d0003 CR4: 00000000003706f0
[ 1248.609102] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1248.609106] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1248.609109] Call Trace:
[ 1248.609113]  <TASK>
[ 1248.609117]  ? __warn+0x9c/0x1f0
[ 1248.609125]  ? ieee80211_do_stop+0xdf0/0xe40 [mac80211]
[ 1248.609268]  ? report_bug+0x1aa/0x1e0
[ 1248.609276]  ? handle_bug+0x41/0x80
[ 1248.609281]  ? exc_invalid_op+0x13/0x40
[ 1248.609287]  ? asm_exc_invalid_op+0x16/0x20
[ 1248.609296]  ? irq_work_claim+0x1e/0x40
[ 1248.609302]  ? ieee80211_do_stop+0xdf0/0xe40 [mac80211]
[ 1248.609462]  ? ieee80211_do_stop+0xdf0/0xe40 [mac80211]
[ 1248.609606]  ? lock_sync+0xf0/0xf0
[ 1248.609613]  ? lock_release+0xb2/0x3b0
[ 1248.609620]  ? ieee80211_del_virtual_monitor+0x190/0x190 [mac80211]
[ 1248.609772]  ? reacquire_held_locks+0x270/0x270
[ 1248.609779]  ? reacquire_held_locks+0x270/0x270
[ 1248.609787]  ? _raw_spin_lock_irqsave+0x47/0x60
[ 1248.609794]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.609802]  ieee80211_stop+0x90/0x2d0 [mac80211]
[ 1248.609959]  ? dev_deactivate_many+0x41a/0x570
[ 1248.609968]  __dev_close_many+0x12a/0x1d0
[ 1248.609974]  ? netdev_notify_peers+0x20/0x20
[ 1248.609979]  ? queue_work_on+0x4d/0x80
[ 1248.609985]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.609991]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.609996]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.610004]  __dev_change_flags+0x2ba/0x390
[ 1248.610010]  ? lock_sync+0xf0/0xf0
[ 1248.610020]  ? dev_set_allmulti+0x10/0x10
[ 1248.610027]  ? rcu_is_watching+0x1f/0x40
[ 1248.610032]  ? lock_release+0xb2/0x3b0
[ 1248.610040]  dev_change_flags+0x53/0xb0
[ 1248.610047]  do_setlink+0x5b3/0x1a70
[ 1248.610055]  ? rtnl_bridge_getlink+0x420/0x420
[ 1248.610061]  ? unwind_next_frame+0xbb9/0xeb0
[ 1248.610070]  ? stack_access_ok+0x40/0xf0
[ 1248.610078]  ? is_bpf_text_address+0x65/0xf0
[ 1248.610084]  ? kernel_text_address+0x89/0x110
[ 1248.610090]  ? __kernel_text_address+0x9/0x30
[ 1248.610097]  ? unwind_get_return_address+0x2a/0x40
[ 1248.610103]  ? write_profile+0x220/0x220
[ 1248.610109]  ? arch_stack_walk+0x93/0xe0
[ 1248.610120]  ? __nla_validate_parse+0xb0/0x1250
[ 1248.610127]  ? stack_trace_save+0x8c/0xc0
[ 1248.610132]  ? filter_irq_stacks+0x18/0x60
[ 1248.610138]  ? nla_get_range_signed+0x160/0x160
[ 1248.610143]  ? filter_irq_stacks+0x18/0x60
[ 1248.610150]  ? kasan_save_stack+0x2b/0x40
[ 1248.610155]  ? kasan_save_stack+0x1c/0x40
[ 1248.610166]  __rtnl_newlink+0x70b/0xcf0
[ 1248.610174]  ? ___slab_alloc+0x109a/0x1210
[ 1248.610182]  ? rtnl_link_unregister+0x1d0/0x1d0
[ 1248.610187]  ? rtnl_newlink+0x31/0x70
[ 1248.610196]  ? kasan_unpoison+0x23/0x50
[ 1248.610202]  ? __kasan_slab_alloc+0x2f/0x70
[ 1248.610207]  ? __kmem_cache_alloc_node+0x159/0x280
[ 1248.610213]  ? rtnetlink_rcv_msg+0x1c0/0x7d0
[ 1248.610219]  ? rtnl_newlink+0x31/0x70
[ 1248.610225]  ? kasan_save_stack+0x1c/0x40
[ 1248.610232]  rtnl_newlink+0x4a/0x70
[ 1248.610238]  rtnetlink_rcv_msg+0x20c/0x7d0
[ 1248.610245]  ? rtnl_getlink+0x580/0x580
[ 1248.610249]  ? __alloc_skb+0xcb/0x210
[ 1248.610255]  ? netlink_sendmsg+0x507/0x6f0
[ 1248.610260]  ? __sock_sendmsg+0x6e/0xb0
[ 1248.610266]  ? ____sys_sendmsg+0x3e6/0x470
[ 1248.610270]  ? ___sys_sendmsg+0xdc/0x140
[ 1248.610276]  ? __sys_sendmsg+0xc4/0x150
[ 1248.610281]  ? do_syscall_64+0x3b/0x110
[ 1248.610294]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1248.610301]  ? ____sys_sendmsg+0x3e6/0x470
[ 1248.610306]  ? ___sys_sendmsg+0xdc/0x140
[ 1248.610323]  netlink_rcv_skb+0xcf/0x210
[ 1248.610333]  ? rcu_is_watching+0x1f/0x40
[ 1248.610339]  ? rtnl_getlink+0x580/0x580
[ 1248.610344]  ? netlink_ack+0x840/0x840
[ 1248.610350]  ? lock_sync+0xf0/0xf0
[ 1248.610355]  ? lock_release+0xb2/0x3b0
[ 1248.610365]  ? __rcu_read_unlock+0x66/0x290
[ 1248.610640]  ? netlink_deliver_tap+0x9f/0x630
[ 1248.610647]  ? netlink_deliver_tap+0xf9/0x630
[ 1248.610655]  netlink_unicast+0x2ee/0x490
[ 1248.610662]  ? netlink_attachskb+0x430/0x430
[ 1248.610670]  ? reacquire_held_locks+0x270/0x270
[ 1248.610677]  ? __virt_addr_valid+0xab/0x130
[ 1248.610682]  ? check_stack_object+0x1d/0x60
[ 1248.610690]  ? __check_object_size+0x22c/0x3b0
[ 1248.610697]  netlink_sendmsg+0x3ca/0x6f0
[ 1248.610705]  ? netlink_unicast+0x490/0x490
[ 1248.610712]  ? import_ubuf+0xa9/0xd0
[ 1248.610723]  ? __import_iovec+0x256/0x290
[ 1248.610730]  ? netlink_unicast+0x490/0x490
[ 1248.610736]  __sock_sendmsg+0x6e/0xb0
[ 1248.610742]  ____sys_sendmsg+0x3e6/0x470
[ 1248.610749]  ? kernel_sendmsg+0x30/0x30
[ 1248.610754]  ? __copy_msghdr+0x1a0/0x1a0
[ 1248.610759]  ? rcu_is_watching+0x1f/0x40
[ 1248.610778]  ? lock_release+0xb2/0x3b0
[ 1248.610784]  ? is_bpf_text_address+0x60/0xf0
[ 1248.610792]  ___sys_sendmsg+0xdc/0x140
[ 1248.610798]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 1248.610805]  ? is_bpf_text_address+0x65/0xf0
[ 1248.610810]  ? kernel_text_address+0x89/0x110
[ 1248.610817]  ? __kernel_text_address+0x9/0x30
[ 1248.610823]  ? unwind_get_return_address+0x2a/0x40
[ 1248.610829]  ? write_profile+0x220/0x220
[ 1248.610838]  ? arch_stack_walk+0x93/0xe0
[ 1248.610849]  ? rcu_is_watching+0x1f/0x40
[ 1248.610855]  ? __fget_light+0xd2/0xf0
[ 1248.610863]  __sys_sendmsg+0xc4/0x150
[ 1248.610869]  ? __sys_sendmsg_sock+0x10/0x10
[ 1248.610874]  ? rcu_is_watching+0x1f/0x40
[ 1248.610880]  ? lock_release+0xb2/0x3b0
[ 1248.610889]  ? __x64_sys_close+0x4c/0x90
[ 1248.610897]  ? __x64_sys_close+0x4c/0x90
[ 1248.610902]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.610908]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1248.610914]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.610920]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 1248.610926]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.610933]  do_syscall_64+0x3b/0x110
[ 1248.610939]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1248.610945] RIP: 0033:0x7fb449d13737
[ 1248.610950] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[ 1248.610958] RSP: 002b:00007fff9b396228 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1248.610965] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb449d13737
[ 1248.610970] RDX: 0000000000000000 RSI: 00007fff9b396290 RDI: 0000000000000004
[ 1248.610973] RBP: 0000000000000003 R08: 00000000654d79f7 R09: 00007fff9b39898a
[ 1248.610977] R10: 00007fb449c0df08 R11: 0000000000000246 R12: 00000000654d79f8
[ 1248.610981] R13: 0000000000484540 R14: 0000000000000001 R15: 0000000000000000
[ 1248.610990]  </TASK>
[ 1248.610993] irq event stamp: 0
[ 1248.610996] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1248.611001] hardirqs last disabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1248.611010] softirqs last  enabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1248.611016] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1248.611020] ---[ end trace 0000000000000000 ]---
[ 1248.611025] wlan1: do_stop, canceling dfs-cac-timer-work.
[ 1248.611203] ------------[ cut here ]------------
[ 1248.611207] WARNING: CPU: 2 PID: 18904 at drivers/net/wireless/intel/iwlwifi/mvm/link.c:104 iwl_mvm_link_changed+0x441/0x600 [iwlmvm]
[ 1248.611284] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 snd_hda_codec_hdmi iTCO_vendor_support snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel snd_intel_dspcfg snd_hda_codec 
intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm snd_timer irqbypass intel_wmi_thunderbolt snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm igb i2c_algo_bit ixgbe mdio drm dca agpgart
[ 1248.611585]  xhci_pci mei_wdt i2c_core hwmon xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 1248.611608] CPU: 2 PID: 18904 Comm: ip Tainted: G        W          6.7.0-rc1+ #1
[ 1248.611614] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1248.611618] RIP: 0010:iwl_mvm_link_changed+0x441/0x600 [iwlmvm]
[ 1248.611693] Code: fb ff 89 c3 85 c0 0f 85 f6 00 00 00 41 83 e6 01 74 14 49 8d 7c 24 51 e8 bd 83 bf df 0f b6 44 24 04 41 88 44 24 51 31 db eb 07 <0f> 0b bb ea 
ff ff ff 48 b8 00 00 00 00 00 fc ff df 48 8b 54 24 08
[ 1248.611700] RSP: 0018:ffff88819ef4ecb8 EFLAGS: 00010246
[ 1248.611706] RAX: 0000000000000000 RBX: ffff8881631771f0 RCX: ffffffffa1a126c0
[ 1248.611710] RDX: 1ffff1103a0559d5 RSI: ffffffffa1a1266a RDI: ffff8881d02aceaf
[ 1248.611714] RBP: ffff888163177198 R08: 0000000000000000 R09: fffffbfff07e5fba
[ 1248.611718] R10: ffffffff83f2fdd7 R11: 0000000000000000 R12: ffff8881d02acea8
[ 1248.611722] R13: ffff88812a7a54e8 R14: 0000000000000001 R15: 00000000000000ff
[ 1248.611725] FS:  00007fb449a8ec40(0000) GS:ffff88841bf00000(0000) knlGS:0000000000000000
[ 1248.611730] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1248.611734] CR2: 00007fd997cc15a0 CR3: 00000001538d0003 CR4: 00000000003706f0
[ 1248.611740] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1248.611745] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1248.611749] Call Trace:
[ 1248.611752]  <TASK>
[ 1248.611756]  ? __warn+0x9c/0x1f0
[ 1248.611762]  ? iwl_mvm_link_changed+0x441/0x600 [iwlmvm]
[ 1248.611864]  ? report_bug+0x1aa/0x1e0
[ 1248.611872]  ? handle_bug+0x41/0x80
[ 1248.611877]  ? exc_invalid_op+0x13/0x40
[ 1248.611883]  ? asm_exc_invalid_op+0x16/0x20
[ 1248.611896]  ? iwl_mvm_link_changed+0xf0/0x600 [iwlmvm]
[ 1248.611960]  ? iwl_mvm_link_changed+0x9a/0x600 [iwlmvm]
[ 1248.612031]  ? iwl_mvm_link_changed+0x441/0x600 [iwlmvm]
[ 1248.612098]  ? iwl_mvm_link_changed+0xf0/0x600 [iwlmvm]
[ 1248.612251]  ? iwl_mvm_add_link+0x310/0x310 [iwlmvm]
[ 1248.612335]  ? spin_bug+0xe0/0xe0
[ 1248.612347]  ? do_raw_spin_unlock+0x8e/0xe0
[ 1248.612355]  iwl_mvm_disable_link+0x1a/0x40 [iwlmvm]
[ 1248.612429]  iwl_mvm_mld_mac_remove_interface+0x25c/0x300 [iwlmvm]
[ 1248.612498]  drv_remove_interface+0xf3/0x300 [mac80211]
[ 1248.612659]  ieee80211_do_stop+0xddc/0xe40 [mac80211]
[ 1248.612910]  ? lock_release+0xb2/0x3b0
[ 1248.612918]  ? ieee80211_del_virtual_monitor+0x190/0x190 [mac80211]
[ 1248.613083]  ? reacquire_held_locks+0x270/0x270
[ 1248.613090]  ? reacquire_held_locks+0x270/0x270
[ 1248.613098]  ? _raw_spin_lock_irqsave+0x47/0x60
[ 1248.613104]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.613113]  ieee80211_stop+0x90/0x2d0 [mac80211]
[ 1248.613398]  ? dev_deactivate_many+0x41a/0x570
[ 1248.613781]  __dev_close_many+0x12a/0x1d0
[ 1248.613789]  ? netdev_notify_peers+0x20/0x20
[ 1248.613794]  ? queue_work_on+0x4d/0x80
[ 1248.613800]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.613806]  ? __local_bh_enable_ip+0x87/0xe0
[ 1248.613812]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.613819]  __dev_change_flags+0x2ba/0x390
[ 1248.613825]  ? lock_sync+0xf0/0xf0
[ 1248.613831]  ? dev_set_allmulti+0x10/0x10
[ 1248.613837]  ? rcu_is_watching+0x1f/0x40
[ 1248.613842]  ? lock_release+0xb2/0x3b0
[ 1248.613851]  dev_change_flags+0x53/0xb0
[ 1248.613861]  do_setlink+0x5b3/0x1a70
[ 1248.613869]  ? rtnl_bridge_getlink+0x420/0x420
[ 1248.613875]  ? unwind_next_frame+0xbb9/0xeb0
[ 1248.613881]  ? stack_access_ok+0x40/0xf0
[ 1248.613889]  ? is_bpf_text_address+0x65/0xf0
[ 1248.613894]  ? kernel_text_address+0x89/0x110
[ 1248.613902]  ? __kernel_text_address+0x9/0x30
[ 1248.613910]  ? unwind_get_return_address+0x2a/0x40
[ 1248.613916]  ? write_profile+0x220/0x220
[ 1248.613921]  ? arch_stack_walk+0x93/0xe0
[ 1248.613929]  ? __nla_validate_parse+0xb0/0x1250
[ 1248.613936]  ? stack_trace_save+0x8c/0xc0
[ 1248.613941]  ? filter_irq_stacks+0x18/0x60
[ 1248.613955]  ? nla_get_range_signed+0x160/0x160
[ 1248.613960]  ? filter_irq_stacks+0x18/0x60
[ 1248.613967]  ? kasan_save_stack+0x2b/0x40
[ 1248.613972]  ? kasan_save_stack+0x1c/0x40
[ 1248.613980]  __rtnl_newlink+0x70b/0xcf0
[ 1248.613988]  ? ___slab_alloc+0x109a/0x1210
[ 1248.613999]  ? rtnl_link_unregister+0x1d0/0x1d0
[ 1248.614005]  ? rtnl_newlink+0x31/0x70
[ 1248.614013]  ? kasan_unpoison+0x23/0x50
[ 1248.614019]  ? __kasan_slab_alloc+0x2f/0x70
[ 1248.614025]  ? __kmem_cache_alloc_node+0x159/0x280
[ 1248.614031]  ? rtnetlink_rcv_msg+0x1c0/0x7d0
[ 1248.614036]  ? rtnl_newlink+0x31/0x70
[ 1248.614045]  ? kasan_save_stack+0x1c/0x40
[ 1248.614052]  rtnl_newlink+0x4a/0x70
[ 1248.614058]  rtnetlink_rcv_msg+0x20c/0x7d0
[ 1248.614065]  ? rtnl_getlink+0x580/0x580
[ 1248.614070]  ? __alloc_skb+0xcb/0x210
[ 1248.614075]  ? netlink_sendmsg+0x507/0x6f0
[ 1248.614080]  ? __sock_sendmsg+0x6e/0xb0
[ 1248.614085]  ? ____sys_sendmsg+0x3e6/0x470
[ 1248.614090]  ? ___sys_sendmsg+0xdc/0x140
[ 1248.614099]  ? __sys_sendmsg+0xc4/0x150
[ 1248.614104]  ? do_syscall_64+0x3b/0x110
[ 1248.614109]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1248.614115]  ? ____sys_sendmsg+0x3e6/0x470
[ 1248.614119]  ? ___sys_sendmsg+0xdc/0x140
[ 1248.614128]  netlink_rcv_skb+0xcf/0x210
[ 1248.614133]  ? rcu_is_watching+0x1f/0x40
[ 1248.614139]  ? rtnl_getlink+0x580/0x580
[ 1248.614148]  ? netlink_ack+0x840/0x840
[ 1248.614158]  ? lock_sync+0xf0/0xf0
[ 1248.614169]  ? lock_release+0xb2/0x3b0
[ 1248.614188]  ? __rcu_read_unlock+0x66/0x290
[ 1248.614199]  ? netlink_deliver_tap+0x9f/0x630
[ 1248.614209]  ? netlink_deliver_tap+0xf9/0x630
[ 1248.614218]  netlink_unicast+0x2ee/0x490
[ 1248.614225]  ? netlink_attachskb+0x430/0x430
[ 1248.614230]  ? reacquire_held_locks+0x270/0x270
[ 1248.614236]  ? __virt_addr_valid+0xab/0x130
[ 1248.614241]  ? check_stack_object+0x1d/0x60
[ 1248.614251]  ? __check_object_size+0x22c/0x3b0
[ 1248.614259]  netlink_sendmsg+0x3ca/0x6f0
[ 1248.614267]  ? netlink_unicast+0x490/0x490
[ 1248.614366]  ? import_ubuf+0xa9/0xd0
[ 1248.614374]  ? __import_iovec+0x256/0x290
[ 1248.614381]  ? netlink_unicast+0x490/0x490
[ 1248.614387]  __sock_sendmsg+0x6e/0xb0
[ 1248.614394]  ____sys_sendmsg+0x3e6/0x470
[ 1248.614400]  ? kernel_sendmsg+0x30/0x30
[ 1248.614405]  ? __copy_msghdr+0x1a0/0x1a0
[ 1248.614411]  ? rcu_is_watching+0x1f/0x40
[ 1248.614418]  ? lock_release+0xb2/0x3b0
[ 1248.614427]  ? is_bpf_text_address+0x60/0xf0
[ 1248.614436]  ___sys_sendmsg+0xdc/0x140
[ 1248.614443]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 1248.614450]  ? is_bpf_text_address+0x65/0xf0
[ 1248.614455]  ? kernel_text_address+0x89/0x110
[ 1248.614461]  ? __kernel_text_address+0x9/0x30
[ 1248.614468]  ? unwind_get_return_address+0x2a/0x40
[ 1248.614478]  ? write_profile+0x220/0x220
[ 1248.614487]  ? arch_stack_walk+0x93/0xe0
[ 1248.614506]  ? rcu_is_watching+0x1f/0x40
[ 1248.614518]  ? __fget_light+0xd2/0xf0
[ 1248.614533]  __sys_sendmsg+0xc4/0x150
[ 1248.614541]  ? __sys_sendmsg_sock+0x10/0x10
[ 1248.614546]  ? rcu_is_watching+0x1f/0x40
[ 1248.614551]  ? lock_release+0xb2/0x3b0
[ 1248.614557]  ? __x64_sys_close+0x4c/0x90
[ 1248.614565]  ? __x64_sys_close+0x4c/0x90
[ 1248.614570]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.614577]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[ 1248.614586]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1248.614592]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 1248.614599]  ? trace_hardirqs_on+0x12/0xe0
[ 1248.614605]  do_syscall_64+0x3b/0x110
[ 1248.614611]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1248.614617] RIP: 0033:0x7fb449d13737
[ 1248.614714] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[ 1248.614721] RSP: 002b:00007fff9b396228 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1248.614729] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb449d13737
[ 1248.614735] RDX: 0000000000000000 RSI: 00007fff9b396290 RDI: 0000000000000004
[ 1248.614739] RBP: 0000000000000003 R08: 00000000654d79f7 R09: 00007fff9b39898a
[ 1248.614742] R10: 00007fb449c0df08 R11: 0000000000000246 R12: 00000000654d79f8
[ 1248.614746] R13: 0000000000484540 R14: 0000000000000001 R15: 0000000000000000
[ 1248.614756]  </TASK>
[ 1248.614759] irq event stamp: 0
[ 1248.614761] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1248.614766] hardirqs last disabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1248.614773] softirqs last  enabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1248.614778] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1248.614782] ---[ end trace 0000000000000000 ]---
[ 1248.614799] iwlwifi 0000:04:00.0: Failed to send MAC_CONFIG_CMD (action:3): -5
[ 1248.621568] iwlwifi 0000:04:00.0: LED command failed: -5
[ 1248.787391] wlan5: do_stop, canceling dfs-cac-timer-work.
[ 1248.951406] wlan2: do_stop, canceling dfs-cac-timer-work.
[ 1249.082398] wlan23: do_stop, canceling dfs-cac-timer-work.
[ 1249.203415] wlan19: do_stop, canceling dfs-cac-timer-work.
[ 1249.335430] wlan12: do_stop, canceling dfs-cac-timer-work.
[ 1249.453989] iwlwifi 0000:04:00.0: WRT: Invalid buffer destination: 0
[ 1249.822261] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1249.822358] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1249.822416] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1249.822471] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1249.822527] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1249.822582] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1249.822637] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1249.827828] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan1' already present!
[ 1249.834221] iwlwifi 0000:04:00.0: Failed to create debugfs directory under netdev:wlan1 (mvm-vif-add-debugfs)
[ 1249.873400] wlan8: do_stop, canceling dfs-cac-timer-work.
[ 1249.997397] iwlwifi 0000:08:00.0: WRT: Invalid buffer destination: 0
[ 1250.356083] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1250.356146] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1250.356203] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1250.356259] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1250.356335] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1250.356392] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1250.356448] ACPI: \: failed to evaluate _DSM bf0212f2-788f-c64d-a5b3-1f738e285ade (0x1001)
[ 1250.361519] debugfs: Directory 'iwlmvm' with parent 'netdev:wlan0' already present!
[ 1250.367915] iwlwifi 0000:08:00.0: Failed to create debugfs directory under netdev:wlan0 (mvm-vif-add-debugfs)
[ 1250.404402] wlan10: do_stop, canceling dfs-cac-timer-work.
[ 1250.537361] wlan14: do_stop, canceling dfs-cac-timer-work.
[ 1250.593433] cfg80211-scan-6ghz, n-channels is 0, flags: 0x0  need_scan_psc: 1 req-n-channels: 1
[ 1254.561629] cfg80211-scan-6ghz, n-channels is 0, flags: 0x4002  need_scan_psc: 1 req-n-channels: 41
[ 1255.013966] ==================================================================
[ 1255.019907] BUG: KASAN: invalid-free in iwl_mvm_mld_change_vif_links+0x36a/0x610 [iwlmvm]
[ 1255.026856] Free of addr ffff8881631779e0 by task wpa_supplicant/5831

[ 1255.032213] CPU: 0 PID: 5831 Comm: wpa_supplicant Tainted: G        W          6.7.0-rc1+ #1
[ 1255.039364] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1255.045903] Call Trace:
[ 1255.047071]  <TASK>
[ 1255.047883]  dump_stack_lvl+0x57/0x90
[ 1255.050269]  print_report+0xc5/0x610
[ 1255.052567]  ? __virt_addr_valid+0xab/0x130
[ 1255.055469]  ? iwl_mvm_mld_change_vif_links+0x36a/0x610 [iwlmvm]
[ 1255.060246]  kasan_report_invalid_free+0x97/0xb0
[ 1255.063582]  ? iwl_mvm_mld_change_vif_links+0x36a/0x610 [iwlmvm]
[ 1255.068362]  free_large_kmalloc+0x3a/0xa0
[ 1255.071089]  iwl_mvm_mld_change_vif_links+0x36a/0x610 [iwlmvm]
[ 1255.075695]  ? iwl_mvm_mld_count_active_links+0xd0/0xd0 [iwlmvm]
[ 1255.080484]  drv_change_vif_links+0x207/0x460 [mac80211]
[ 1255.084654]  ieee80211_vif_update_links+0x767/0x9f0 [mac80211]
[ 1255.089346]  ? ieee80211_link_init+0x350/0x350 [mac80211]
[ 1255.093597]  ? unwind_get_return_address+0x2a/0x40
[ 1255.097104]  ? arch_stack_walk+0x93/0xe0
[ 1255.099752]  ? ieee80211_mgd_auth+0x209/0xcb0 [mac80211]
[ 1255.103934]  ? stack_trace_save+0x8c/0xc0
[ 1255.106665]  ? ieee80211_mgd_auth+0x209/0xcb0 [mac80211]
[ 1255.110843]  ? kasan_save_stack+0x2b/0x40
[ 1255.113571]  ? kasan_save_stack+0x1c/0x40
[ 1255.116301]  ? kasan_set_track+0x21/0x30
[ 1255.118950]  ? do_syscall_64+0x3b/0x110
[ 1255.121501]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1255.125443]  ? netlink_sendmsg+0x3ca/0x6f0
[ 1255.128260]  ? __sock_sendmsg+0x6e/0xb0
[ 1255.130809]  ? ____sys_sendmsg+0x3e6/0x470
[ 1255.133625]  ? ___sys_sendmsg+0xdc/0x140
[ 1255.136268]  ? __sys_sendmsg+0xc4/0x150
[ 1255.138823]  ? do_syscall_64+0x3b/0x110
[ 1255.141374]  ieee80211_vif_set_links+0x72/0xf0 [mac80211]
[ 1255.145634]  ? ieee80211_find_best_sta_link+0x260/0x260 [mac80211]
[ 1255.150670]  ? __kasan_slab_alloc+0x2f/0x70
[ 1255.153570]  ? __kmem_cache_alloc_node+0x173/0x280
[ 1255.157081]  ieee80211_prep_connection+0x6f/0xba0 [mac80211]
[ 1255.161605]  ? __kasan_kmalloc+0x83/0x90
[ 1255.164246]  ? rcu_is_watching+0x1f/0x40
[ 1255.166890]  ieee80211_mgd_auth+0x656/0xcb0 [mac80211]
[ 1255.170899]  ? cfg80211_get_bss+0x277/0x4d0 [cfg80211]
[ 1255.174890]  ? ieee80211_mlme_notify_scan_completed+0x1f0/0x1f0 [mac80211]
[ 1255.180629]  ? cfg80211_find_elem_match+0xa4/0xd0 [cfg80211]
[ 1255.185136]  ? memcmp+0x83/0xa0
[ 1255.186992]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1255.190678]  ? __local_bh_enable_ip+0x87/0xe0
[ 1255.193756]  ? trace_hardirqs_on+0x12/0xe0
[ 1255.196572]  ? cfg80211_get_bss+0x277/0x4d0 [cfg80211]
[ 1255.200551]  ? rcu_is_watching+0x1f/0x40
[ 1255.203195]  cfg80211_mlme_auth+0x1e6/0x410 [cfg80211]
[ 1255.207185]  nl80211_authenticate+0x5c7/0x630 [cfg80211]
[ 1255.211342]  ? nl80211_parse_key+0x5c0/0x5c0 [cfg80211]
[ 1255.215413]  ? netdev_run_todo+0x1d0/0x840
[ 1255.218234]  ? validate_ie_attr+0xb0/0xb0 [cfg80211]
[ 1255.222047]  ? nl80211_pre_doit+0x32b/0x3d0 [cfg80211]
[ 1255.226034]  genl_family_rcv_msg_doit+0x151/0x1d0
[ 1255.229454]  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x120/0x120
[ 1255.234702]  ? cap_capable+0x9a/0xd0
[ 1255.236995]  ? security_capable+0x29/0x60
[ 1255.239723]  genl_rcv_msg+0x281/0x3b0
[ 1255.242109]  ? genl_family_rcv_msg_dumpit+0x1e0/0x1e0
[ 1255.245877]  ? set_track_prepare+0x3b/0x60
[ 1255.248693]  ? kmalloc_reserve+0xa3/0x120
[ 1255.251424]  ? __alloc_skb+0xcb/0x210
[ 1255.253805]  ? nl80211_assoc_bss+0xf0/0xf0 [cfg80211]
[ 1255.257699]  ? nl80211_parse_key+0x5c0/0x5c0 [cfg80211]
[ 1255.261762]  ? cfg80211_external_auth_request+0x340/0x340 [cfg80211]
[ 1255.266957]  ? do_syscall_64+0x3b/0x110
[ 1255.269512]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1255.273454]  ? ____sys_sendmsg+0x3e6/0x470
[ 1255.276272]  ? ___sys_sendmsg+0xdc/0x140
[ 1255.278916]  netlink_rcv_skb+0xcf/0x210
[ 1255.281470]  ? lock_sync+0xf0/0xf0
[ 1255.283593]  ? genl_family_rcv_msg_dumpit+0x1e0/0x1e0
[ 1255.287366]  ? netlink_ack+0x840/0x840
[ 1255.289838]  ? rwsem_down_read_slowpath+0x920/0x920
[ 1255.293432]  ? netlink_deliver_tap+0x9f/0x630
[ 1255.296506]  ? netlink_deliver_tap+0xf9/0x630
[ 1255.299576]  genl_rcv+0x1f/0x30
[ 1255.301440]  netlink_unicast+0x2ee/0x490
[ 1255.304084]  ? netlink_attachskb+0x430/0x430
[ 1255.307072]  ? __virt_addr_valid+0xab/0x130
[ 1255.309976]  ? check_stack_object+0x1d/0x60
[ 1255.312881]  ? __check_object_size+0x22c/0x3b0
[ 1255.316046]  netlink_sendmsg+0x3ca/0x6f0
[ 1255.318687]  ? netlink_unicast+0x490/0x490
[ 1255.321504]  ? import_ubuf+0xa9/0xd0
[ 1255.323801]  ? __import_iovec+0x256/0x290
[ 1255.326529]  ? netlink_unicast+0x490/0x490
[ 1255.329346]  __sock_sendmsg+0x6e/0xb0
[ 1255.331731]  ____sys_sendmsg+0x3e6/0x470
[ 1255.334373]  ? kernel_sendmsg+0x30/0x30
[ 1255.336927]  ? __copy_msghdr+0x1a0/0x1a0
[ 1255.339565]  ? up_write+0xfb/0x2d0
[ 1255.341687]  ___sys_sendmsg+0xdc/0x140
[ 1255.344159]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 1255.347321]  ? netlink_setsockopt+0x2da/0x420
[ 1255.350400]  ? netlink_realloc_groups+0x180/0x180
[ 1255.353823]  ? reacquire_held_locks+0x270/0x270
[ 1255.357070]  ? copy_msghdr_from_user+0x110/0x110
[ 1255.360410]  ? sock_do_ioctl+0xaf/0x180
[ 1255.362963]  ? rcu_is_watching+0x1f/0x40
[ 1255.365597]  ? do_sock_setsockopt+0x162/0x2a0
[ 1255.368667]  ? move_addr_to_user+0xf0/0xf0
[ 1255.371485]  ? __fget_light+0xd2/0xf0
[ 1255.373868]  __sys_sendmsg+0xc4/0x150
[ 1255.376248]  ? __sys_sendmsg_sock+0x10/0x10
[ 1255.379144]  ? __sys_setsockopt+0x119/0x190
[ 1255.382042]  ? __ia32_sys_recv+0x60/0x60
[ 1255.384688]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1255.388367]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 1255.392138]  ? trace_hardirqs_on+0x12/0xe0
[ 1255.394954]  do_syscall_64+0x3b/0x110
[ 1255.397337]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1255.401108] RIP: 0033:0x7feab6113737
[ 1255.403403] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[ 1255.420883] RSP: 002b:00007ffefbd2e088 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1255.427171] RAX: ffffffffffffffda RBX: 0000000001935bc0 RCX: 00007feab6113737
[ 1255.433019] RDX: 0000000000000000 RSI: 00007ffefbd2e0e0 RDI: 0000000000000007
[ 1255.438871] RBP: 00000000019398f0 R08: 0000000000000004 R09: 00000000000000f0
[ 1255.444721] R10: 00007ffefbd2e1a4 R11: 0000000000000246 R12: 0000000001935ad0
[ 1255.450569] R13: 00007ffefbd2e0e0 R14: 000000000079cd98 R15: 00007feab6984000
[ 1255.456425]  </TASK>

[ 1255.457532] The buggy address belongs to the physical page:
[ 1255.461820] page:ffffea00058c5d00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x163174
[ 1255.461826] head:ffffea00058c5d00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 1255.461830] flags: 0x5fff8000000040(head|node=0|zone=2|lastcpupid=0x3fff)
[ 1255.461836] page_type: 0xffffffff()
[ 1255.461841] raw: 005fff8000000040 0000000000000000 dead000000000122 0000000000000000
[ 1255.461845] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[ 1255.461849] page dumped because: kasan: bad access detected

[ 1255.462054] Memory state around the buggy address:
[ 1255.465561]  ffff888163177880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1255.471494]  ffff888163177900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1255.477433] >ffff888163177980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1255.483364]                                                        ^
[ 1255.488435]  ffff888163177a00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1255.494375]  ffff888163177a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1255.500309] ==================================================================
[ 1255.506422] BUG: unable to handle page fault for address: ffff888163177a80
[ 1255.512019] #PF: supervisor write access in kernel mode
[ 1255.515957] #PF: error_code(0x0002) - not-present page
[ 1255.519807] PGD 5801067 P4D 5801067 PUD 46d829067 PMD 46d710067 PTE 800ffffe9ce88060
[ 1255.526276] Oops: 0002 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[ 1255.530738] CPU: 0 PID: 5831 Comm: wpa_supplicant Tainted: G    B   W          6.7.0-rc1+ #1
[ 1255.537889] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1255.544432] RIP: 0010:iwl_mvm_mld_change_vif_links+0x372/0x610 [iwlmvm]
[ 1255.549822] Code: 48 8b 7c 24 10 e8 ce af ff ff 85 c0 0f 85 bd 00 00 00 48 89 df e8 6e 31 bf df 48 8b 3b e8 06 ce b3 df 48 89 df e8 de 31 bf df <48> c7 03 00 
00 00 00 eb 9d e8 e0 2c cf e0 85 c0 0f 85 22 01 00 00
[ 1255.567299] RSP: 0018:ffff888192f3eca0 EFLAGS: 00010282
[ 1255.571246] RAX: 0000000000000000 RBX: ffff888163177a80 RCX: ffffffffa1a17ea2
[ 1255.577095] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888163177a80
[ 1255.582947] RBP: ffff888192f3efb0 R08: 0000000000000000 R09: ffffed10837c8340
[ 1255.588796] R10: ffff88841be41a03 R11: 0000000000000000 R12: ffff888192f3ed18
[ 1255.594647] R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
[ 1255.600495] FS:  00007feab683c780(0000) GS:ffff88841be00000(0000) knlGS:0000000000000000
[ 1255.607298] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1255.611761] CR2: ffff888163177a80 CR3: 00000001d779c006 CR4: 00000000003706f0
[ 1255.617614] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1255.623461] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1255.629314] Call Trace:
[ 1255.630480]  <TASK>
[ 1255.631293]  ? __die+0x1a/0x60
[ 1255.633070]  ? page_fault_oops+0x1ea/0x550
[ 1255.635886]  ? show_ldttss+0x180/0x180
[ 1255.638347]  ? dump_pagetable+0x410/0x410
[ 1255.641071]  ? search_bpf_extables+0xe9/0x190
[ 1255.644147]  ? fixup_exception+0x32/0x390
[ 1255.646878]  ? lock_acquire+0xc4/0x3b0
[ 1255.649351]  ? exc_page_fault+0xd7/0xf0
[ 1255.651904]  ? asm_exc_page_fault+0x22/0x30
[ 1255.654809]  ? iwl_mvm_mld_change_vif_links+0x372/0x610 [iwlmvm]
[ 1255.659587]  ? iwl_mvm_mld_change_vif_links+0x372/0x610 [iwlmvm]
[ 1255.664365]  ? iwl_mvm_mld_count_active_links+0xd0/0xd0 [iwlmvm]
[ 1255.669150]  drv_change_vif_links+0x207/0x460 [mac80211]
[ 1255.673323]  ieee80211_vif_update_links+0x767/0x9f0 [mac80211]
[ 1255.678017]  ? ieee80211_link_init+0x350/0x350 [mac80211]
[ 1255.682263]  ? unwind_get_return_address+0x2a/0x40
[ 1255.685773]  ? arch_stack_walk+0x93/0xe0
[ 1255.688419]  ? ieee80211_mgd_auth+0x209/0xcb0 [mac80211]
[ 1255.692596]  ? stack_trace_save+0x8c/0xc0
[ 1255.695327]  ? ieee80211_mgd_auth+0x209/0xcb0 [mac80211]
[ 1255.699504]  ? kasan_save_stack+0x2b/0x40
[ 1255.702232]  ? kasan_save_stack+0x1c/0x40
[ 1255.704964]  ? kasan_set_track+0x21/0x30
[ 1255.707610]  ? do_syscall_64+0x3b/0x110
[ 1255.710162]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1255.714105]  ? netlink_sendmsg+0x3ca/0x6f0
[ 1255.716921]  ? __sock_sendmsg+0x6e/0xb0
[ 1255.719478]  ? ____sys_sendmsg+0x3e6/0x470
[ 1255.722293]  ? ___sys_sendmsg+0xdc/0x140
[ 1255.724931]  ? __sys_sendmsg+0xc4/0x150
[ 1255.727484]  ? do_syscall_64+0x3b/0x110
[ 1255.730034]  ieee80211_vif_set_links+0x72/0xf0 [mac80211]
[ 1255.734282]  ? ieee80211_find_best_sta_link+0x260/0x260 [mac80211]
[ 1255.739322]  ? __kasan_slab_alloc+0x2f/0x70
[ 1255.742219]  ? __kmem_cache_alloc_node+0x173/0x280
[ 1255.745732]  ieee80211_prep_connection+0x6f/0xba0 [mac80211]
[ 1255.750258]  ? __kasan_kmalloc+0x83/0x90
[ 1255.752898]  ? rcu_is_watching+0x1f/0x40
[ 1255.755542]  ieee80211_mgd_auth+0x656/0xcb0 [mac80211]
[ 1255.759551]  ? cfg80211_get_bss+0x277/0x4d0 [cfg80211]
[ 1255.763543]  ? ieee80211_mlme_notify_scan_completed+0x1f0/0x1f0 [mac80211]
[ 1255.769284]  ? cfg80211_find_elem_match+0xa4/0xd0 [cfg80211]
[ 1255.773785]  ? memcmp+0x83/0xa0
[ 1255.775648]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1255.779332]  ? __local_bh_enable_ip+0x87/0xe0
[ 1255.782406]  ? trace_hardirqs_on+0x12/0xe0
[ 1255.785226]  ? cfg80211_get_bss+0x277/0x4d0 [cfg80211]
[ 1255.789204]  ? rcu_is_watching+0x1f/0x40
[ 1255.791848]  cfg80211_mlme_auth+0x1e6/0x410 [cfg80211]
[ 1255.795837]  nl80211_authenticate+0x5c7/0x630 [cfg80211]
[ 1255.799995]  ? nl80211_parse_key+0x5c0/0x5c0 [cfg80211]
[ 1255.804067]  ? netdev_run_todo+0x1d0/0x840
[ 1255.806885]  ? validate_ie_attr+0xb0/0xb0 [cfg80211]
[ 1255.810698]  ? nl80211_pre_doit+0x32b/0x3d0 [cfg80211]
[ 1255.814683]  genl_family_rcv_msg_doit+0x151/0x1d0
[ 1255.818107]  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x120/0x120
[ 1255.823352]  ? cap_capable+0x9a/0xd0
[ 1255.825645]  ? security_capable+0x29/0x60
[ 1255.828379]  genl_rcv_msg+0x281/0x3b0
[ 1255.830758]  ? genl_family_rcv_msg_dumpit+0x1e0/0x1e0
[ 1255.834529]  ? set_track_prepare+0x3b/0x60
[ 1255.837346]  ? kmalloc_reserve+0xa3/0x120
[ 1255.840076]  ? __alloc_skb+0xcb/0x210
[ 1255.842457]  ? nl80211_assoc_bss+0xf0/0xf0 [cfg80211]
[ 1255.846352]  ? nl80211_parse_key+0x5c0/0x5c0 [cfg80211]
[ 1255.850425]  ? cfg80211_external_auth_request+0x340/0x340 [cfg80211]
[ 1255.855627]  ? do_syscall_64+0x3b/0x110
[ 1255.858180]  ? entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1255.862124]  ? ____sys_sendmsg+0x3e6/0x470
[ 1255.864941]  ? ___sys_sendmsg+0xdc/0x140
[ 1255.867587]  netlink_rcv_skb+0xcf/0x210
[ 1255.870139]  ? lock_sync+0xf0/0xf0
[ 1255.872265]  ? genl_family_rcv_msg_dumpit+0x1e0/0x1e0
[ 1255.876034]  ? netlink_ack+0x840/0x840
[ 1255.878509]  ? rwsem_down_read_slowpath+0x920/0x920
[ 1255.882099]  ? netlink_deliver_tap+0x9f/0x630
[ 1255.885169]  ? netlink_deliver_tap+0xf9/0x630
[ 1255.888248]  genl_rcv+0x1f/0x30
[ 1255.890108]  netlink_unicast+0x2ee/0x490
[ 1255.892752]  ? netlink_attachskb+0x430/0x430
[ 1255.895744]  ? __virt_addr_valid+0xab/0x130
[ 1255.898645]  ? check_stack_object+0x1d/0x60
[ 1255.901547]  ? __check_object_size+0x22c/0x3b0
[ 1255.904713]  netlink_sendmsg+0x3ca/0x6f0
[ 1255.907358]  ? netlink_unicast+0x490/0x490
[ 1255.910175]  ? import_ubuf+0xa9/0xd0
[ 1255.912471]  ? __import_iovec+0x256/0x290
[ 1255.915197]  ? netlink_unicast+0x490/0x490
[ 1255.918006]  __sock_sendmsg+0x6e/0xb0
[ 1255.920391]  ____sys_sendmsg+0x3e6/0x470
[ 1255.923034]  ? kernel_sendmsg+0x30/0x30
[ 1255.925589]  ? __copy_msghdr+0x1a0/0x1a0
[ 1255.928228]  ? up_write+0xfb/0x2d0
[ 1255.930350]  ___sys_sendmsg+0xdc/0x140
[ 1255.932817]  ? __ia32_sys_recvmmsg+0x160/0x160
[ 1255.935972]  ? netlink_setsockopt+0x2da/0x420
[ 1255.939051]  ? netlink_realloc_groups+0x180/0x180
[ 1255.942473]  ? reacquire_held_locks+0x270/0x270
[ 1255.945724]  ? copy_msghdr_from_user+0x110/0x110
[ 1255.949061]  ? sock_do_ioctl+0xaf/0x180
[ 1255.951615]  ? rcu_is_watching+0x1f/0x40
[ 1255.954259]  ? do_sock_setsockopt+0x162/0x2a0
[ 1255.957327]  ? move_addr_to_user+0xf0/0xf0
[ 1255.960145]  ? __fget_light+0xd2/0xf0
[ 1255.962528]  __sys_sendmsg+0xc4/0x150
[ 1255.964911]  ? __sys_sendmsg_sock+0x10/0x10
[ 1255.967816]  ? __sys_setsockopt+0x119/0x190
[ 1255.970721]  ? __ia32_sys_recv+0x60/0x60
[ 1255.973364]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1255.977045]  ? syscall_enter_from_user_mode+0x1c/0x50
[ 1255.980817]  ? trace_hardirqs_on+0x12/0xe0
[ 1255.983634]  do_syscall_64+0x3b/0x110
[ 1255.986014]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1255.989785] RIP: 0033:0x7feab6113737
[ 1255.992080] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 
ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[ 1256.009553] RSP: 002b:00007ffefbd2e088 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[ 1256.015842] RAX: ffffffffffffffda RBX: 0000000001935bc0 RCX: 00007feab6113737
[ 1256.021689] RDX: 0000000000000000 RSI: 00007ffefbd2e0e0 RDI: 0000000000000007
[ 1256.027540] RBP: 00000000019398f0 R08: 0000000000000004 R09: 00000000000000f0
[ 1256.033388] R10: 00007ffefbd2e1a4 R11: 0000000000000246 R12: 0000000001935ad0
[ 1256.039238] R13: 00007ffefbd2e0e0 R14: 000000000079cd98 R15: 00007feab6984000
[ 1256.045096]  </TASK>
[ 1256.045993] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 snd_hda_codec_hdmi iTCO_vendor_support snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel snd_intel_dspcfg snd_hda_codec 
intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm snd_timer irqbypass intel_wmi_thunderbolt snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm igb i2c_algo_bit ixgbe mdio drm dca agpgart
[ 1256.046179]  xhci_pci mei_wdt i2c_core hwmon xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 1256.142316] CR2: ffff888163177a80
[ 1256.144349] ---[ end trace 0000000000000000 ]---
[ 1256.144350] BUG: unable to handle page fault for address: ffff888163174000
[ 1256.147676] RIP: 0010:iwl_mvm_mld_change_vif_links+0x372/0x610 [iwlmvm]
[ 1256.153252] #PF: supervisor read access in kernel mode
[ 1256.158572] Code: 48 8b 7c 24 10 e8 ce af ff ff 85 c0 0f 85 bd 00 00 00 48 89 df e8 6e 31 bf df 48 8b 3b e8 06 ce b3 df 48 89 df e8 de 31 bf df <48> c7 03 00 
00 00 00 eb 9d e8 e0 2c cf e0 85 c0 0f 85 22 01 00 00
[ 1256.162420] #PF: error_code(0x0000) - not-present page
[ 1256.179875] RSP: 0018:ffff888192f3eca0 EFLAGS: 00010282
[ 1256.183722] PGD 5801067

[ 1256.187657] P4D 5801067
[ 1256.188898] RAX: 0000000000000000 RBX: ffff888163177a80 RCX: ffffffffa1a17ea2
[ 1256.189107] PUD 46d829067
[ 1256.190350] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888163177a80
[ 1256.196187] PMD 46d710067
[ 1256.197609] RBP: ffff888192f3efb0 R08: 0000000000000000 R09: ffffed10837c8340
[ 1256.203451] PTE 800ffffe9ce8b060
[ 1256.204869] R10: ffff88841be41a03 R11: 0000000000000000 R12: ffff888192f3ed18

[ 1256.212645] R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
[ 1256.218484] Oops: 0000 [#2] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[ 1256.218684] FS:  00007feab683c780(0000) GS:ffff88841be00000(0000) knlGS:0000000000000000
[ 1256.224529] CPU: 2 PID: 3737 Comm: btserver Tainted: G    B D W          6.7.0-rc1+ #1
[ 1256.228982] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1256.235774] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1256.242395] CR2: ffff888163177a80 CR3: 00000001d779c006 CR4: 00000000003706f0
[ 1256.246841] RIP: 0010:strcmp+0x24/0x50
[ 1256.253367] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1256.259203] Code: 00 00 00 0f 1f 00 41 54 55 48 89 fd 53 48 89 f3 eb 05 45 84 e4 74 2d 48 89 ef 48 83 c5 01 e8 f3 be f1 fe 48 89 df 48 83 c3 01 <44> 0f b6 65 
ff e8 e2 be f1 fe 44 3a 63 ff 74 d8 19 c0 5b 5d 83 c8
[ 1256.261663] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1256.267503] RSP: 0018:ffff8881464d7c60 EFLAGS: 00010282
[ 1256.284958] note: wpa_supplicant[5831] exited with irqs disabled

[ 1256.299849] RAX: 0000000000000000 RBX: ffff8881464d7d51 RCX: ffffffff826eee7d
[ 1256.305697] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881464d7d50
[ 1256.311550] RBP: ffff888163174001 R08: 000000316e616c77 R09: fffffbfff07e5fba
[ 1256.317400] R10: ffffffff83f2fdd7 R11: 0000000000000000 R12: ffffffff855f1c80
[ 1256.323254] R13: 0000000000000000 R14: ffffffff855f1c80 R15: 00000000027796f0
[ 1256.329107] FS:  00007fe886c30740(0000) GS:ffff88841bf00000(0000) knlGS:0000000000000000
[ 1256.335909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1256.340371] CR2: ffff888163174000 CR3: 000000016b4fd004 CR4: 00000000003706f0
[ 1256.346223] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1256.352076] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1256.357924] Call Trace:
[ 1256.359091]  <TASK>
[ 1256.359902]  ? __die+0x1a/0x60
[ 1256.361672]  ? page_fault_oops+0x1ea/0x550
[ 1256.364491]  ? show_ldttss+0x180/0x180
[ 1256.366958]  ? dump_pagetable+0x410/0x410
[ 1256.369685]  ? search_bpf_extables+0xe9/0x190
[ 1256.372757]  ? fixup_exception+0x32/0x390
[ 1256.375493]  ? exc_page_fault+0xd7/0xf0
[ 1256.378046]  ? asm_exc_page_fault+0x22/0x30
[ 1256.380951]  ? strcmp+0x1d/0x50
[ 1256.382811]  ? strcmp+0x24/0x50
[ 1256.384677]  dev_get_by_name_rcu+0x65/0xb0
[ 1256.387491]  dev_load+0x45/0x140
[ 1256.389442]  dev_ioctl+0x2d3/0x700
[ 1256.391568]  sock_do_ioctl+0x13b/0x180
[ 1256.394036]  ? put_user_ifreq+0x90/0x90
[ 1256.396593]  ? do_vfs_ioctl+0x9a5/0xc90
[ 1256.399149]  ? vfs_fileattr_set+0x4b0/0x4b0
[ 1256.402053]  ? rcu_is_watching+0x1f/0x40
[ 1256.404693]  ? lock_acquire+0xc4/0x3b0
[ 1256.407168]  sock_ioctl+0x236/0x3f0
[ 1256.409375]  ? br_ioctl_call+0x80/0x80
[ 1256.411845]  ? rcu_is_watching+0x1f/0x40
[ 1256.414490]  ? lock_release+0xb2/0x3b0
[ 1256.416958]  ? __x64_sys_close+0x4c/0x90
[ 1256.419601]  ? reacquire_held_locks+0x270/0x270
[ 1256.422852]  ? init_object+0x2e/0xc0
[ 1256.425151]  ? free_to_partial_list+0x14f/0x5b0
[ 1256.428400]  __x64_sys_ioctl+0xb9/0xf0
[ 1256.430868]  do_syscall_64+0x3b/0x110
[ 1256.433258]  entry_SYSCALL_64_after_hwframe+0x46/0x4e
[ 1256.437031] RIP: 0033:0x7fe88650774f
[ 1256.439326] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 
f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1256.456807] RSP: 002b:00007ffc75d243e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1256.463095] RAX: ffffffffffffffda RBX: 00000000027aad30 RCX: 00007fe88650774f
[ 1256.468944] RDX: 00007ffc75d24470 RSI: 0000000000008946 RDI: 0000000000000007
[ 1256.474795] RBP: 00007ffc75d26060 R08: 0000000000000500 R09: 0000000000000000
[ 1256.480644] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000469fb8
[ 1256.486495] R13: 0000000000000000 R14: 0000000000b16a78 R15: 00007fe886e06000
[ 1256.492350]  </TASK>
[ 1256.493251] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 snd_hda_codec_hdmi iTCO_vendor_support snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel snd_intel_dspcfg snd_hda_codec 
intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm snd_timer irqbypass intel_wmi_thunderbolt snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm igb i2c_algo_bit ixgbe mdio drm dca agpgart
[ 1256.493442]  xhci_pci mei_wdt i2c_core hwmon xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 1256.589570] CR2: ffff888163174000
[ 1256.591604] ---[ end trace 0000000000000000 ]---
[ 1256.591605] BUG: unable to handle page fault for address: ffff888163174090
[ 1256.594934] RIP: 0010:iwl_mvm_mld_change_vif_links+0x372/0x610 [iwlmvm]
[ 1256.600513] #PF: supervisor read access in kernel mode
[ 1256.605829] Code: 48 8b 7c 24 10 e8 ce af ff ff 85 c0 0f 85 bd 00 00 00 48 89 df e8 6e 31 bf df 48 8b 3b e8 06 ce b3 df 48 89 df e8 de 31 bf df <48> c7 03 00 
00 00 00 eb 9d e8 e0 2c cf e0 85 c0 0f 85 22 01 00 00
[ 1256.609676] #PF: error_code(0x0000) - not-present page
[ 1256.627130] RSP: 0018:ffff888192f3eca0 EFLAGS: 00010282
[ 1256.630979] PGD 5801067

[ 1256.634913] P4D 5801067
[ 1256.636162] RAX: 0000000000000000 RBX: ffff888163177a80 RCX: ffffffffa1a17ea2
[ 1256.636368] PUD 46d829067
[ 1256.637616] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888163177a80
[ 1256.643457] PMD 46d710067
[ 1256.644879] RBP: ffff888192f3efb0 R08: 0000000000000000 R09: ffffed10837c8340
[ 1256.650722] PTE 800ffffe9ce8b060
[ 1256.652141] R10: ffff88841be41a03 R11: 0000000000000000 R12: ffff888192f3ed18

[ 1256.659924] R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
[ 1256.665767] Oops: 0000 [#3] PREEMPT SMP DEBUG_PAGEALLOC KASAN
[ 1256.665975] FS:  00007fe886c30740(0000) GS:ffff88841bf00000(0000) knlGS:0000000000000000
[ 1256.671815] CPU: 5 PID: 5831 Comm: wpa_supplicant Tainted: G    B D W          6.7.0-rc1+ #1
[ 1256.676269] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1256.683065] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1256.690207] CR2: ffff888163174000 CR3: 000000016b4fd004 CR4: 00000000003706f0
[ 1256.694659] RIP: 0010:__dev_remove_pack+0x4e/0x130
[ 1256.701188] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1256.707028] Code: 0f 84 cf 00 00 00 4d 85 e4 0f 84 e1 00 00 00 49 81 c4 90 00 00 00 48 c7 c7 40 16 e0 83 e8 2a dd 44 00 4c 89 e7 e8 f2 87 33 ff <49> 8b 04 24 
48 8d 58 c0 49 39 c4 75 1b e9 88 00 00 00 48 8d 7b 40
[ 1256.710531] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1256.716371] RSP: 0018:ffff888192f3fbc8 EFLAGS: 00010286
[ 1256.733826] note: btserver[3737] exited with irqs disabled

[ 1256.748211] RAX: 0000000000000000 RBX: 0000000000000d89 RCX: ffffffff822d280e
[ 1256.752686] ------------[ cut here ]------------
[ 1256.754054] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888163174090
[ 1256.757383] Voluntary context switch within RCU read-side critical section!
[ 1256.763222] RBP: ffff888124e3c900 R08: 0000000000000001 R09: ffffed10325e7f6b
[ 1256.763241] WARNING: CPU: 6 PID: 3737 at kernel/rcu/tree_plugin.h:320 rcu_note_context_switch+0x6ee/0x990
[ 1256.768893] R10: 0000000000000003 R11: 0000000000000001 R12: ffff888163174090
[ 1256.774733] Modules linked in:
[ 1256.783001] R13: ffff888124e3c850 R14: ffff888124e3c030 R15: ffff888124e3c080
[ 1256.788842]  nf_conntrack_netlink
[ 1256.790608] FS:  0000000000000000(0000) GS:ffff88841c080000(0000) knlGS:0000000000000000
[ 1256.796442]  nf_conntrack
[ 1256.798464] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1256.805257]  nfnetlink
[ 1256.806591] CR2: ffff888163174090 CR3: 0000000153cb2004 CR4: 00000000003706f0
[ 1256.811039]  vrf
[ 1256.812111] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1256.817944]  nf_defrag_ipv6
[ 1256.818500] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1256.824342]  nf_defrag_ipv4
[ 1256.825848] Call Trace:
[ 1256.831683]  bpfilter
[ 1256.833190]  <TASK>
[ 1256.834350]  8021q
[ 1256.835330]  ? __die+0x1a/0x60
[ 1256.836134]  garp
[ 1256.836857]  ? page_fault_oops+0x1ea/0x550
[ 1256.838625]  mrp
[ 1256.839267]  ? show_ldttss+0x180/0x180
[ 1256.842074]  stp
[ 1256.842627]  ? dump_pagetable+0x410/0x410
[ 1256.845081]  llc
[ 1256.845637]  ? search_bpf_extables+0xe9/0x190
[ 1256.848358]  macvlan
[ 1256.848911]  ? fixup_exception+0x32/0x390
[ 1256.851978]  pktgen
[ 1256.852876]  ? exc_page_fault+0xd7/0xf0
[ 1256.855592]  rpcrdma
[ 1256.856399]  ? asm_exc_page_fault+0x22/0x30
[ 1256.858939]  rdma_cm
[ 1256.859844]  ? __dev_remove_pack+0x4e/0x130
[ 1256.862734]  iw_cm
[ 1256.863637]  ? __dev_remove_pack+0x4e/0x130
[ 1256.866520]  ib_cm
[ 1256.867242]  ? __dev_remove_pack+0x4e/0x130
[ 1256.870135]  ib_core
[ 1256.870865]  __unregister_prot_hook+0x270/0x290
[ 1256.873757]  qrtr
[ 1256.874655]  packet_release+0x533/0x680
[ 1256.877891]  f71882fg
[ 1256.878529]  ? packet_set_ring+0xa40/0xa40
[ 1256.881075]  intel_rapl_msr
[ 1256.882061]  ? down_write+0x103/0x1a0
[ 1256.884870]  iTCO_wdt
[ 1256.886378]  ? rwsem_down_write_slowpath+0xd90/0xd90
[ 1256.888754]  intel_pmc_bxt
[ 1256.889739]  ? fcntl_setlk+0x5a0/0x5a0
[ 1256.893406]  ee1004
[ 1256.894830]  __sock_release+0x5c/0x120
[ 1256.897290]  snd_hda_codec_hdmi
[ 1256.898104]  sock_close+0xf/0x20
[ 1256.900556]  iTCO_vendor_support
[ 1256.902409]  __fput+0x12d/0x4d0
[ 1256.904344]  snd_hda_codec_realtek
[ 1256.906290]  task_work_run+0xed/0x170
[ 1256.908140]  snd_hda_codec_generic
[ 1256.910257]  ? task_work_cancel+0x10/0x10
[ 1256.912629]  ledtrig_audio
[ 1256.914744]  ? do_raw_spin_unlock+0x8e/0xe0
[ 1256.917467]  coretemp
[ 1256.918891]  do_exit+0x5d3/0x11f0
[ 1256.921783]  intel_rapl_common
[ 1256.922772]  ? is_current_pgrp_orphaned+0x60/0x60
[ 1256.924795]  intel_tcc_cooling
[ 1256.926558]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1256.929972]  x86_pkg_temp_thermal
[ 1256.931742]  make_task_dead+0xba/0x200
[ 1256.935413]  snd_hda_intel
[ 1256.937434]  rewind_stack_and_make_dead+0x17/0x20
[ 1256.939894]  snd_intel_dspcfg
[ 1256.941315] RIP: 0033:0x7feab6113737
[ 1256.944723]  snd_hda_codec
[ 1256.946403] Code: Unable to access opcode bytes at 0x7feab611370d.
[ 1256.948691]  intel_powerclamp
[ 1256.950113] RSP: 002b:00007ffefbd2e088 EFLAGS: 00000246
[ 1256.955001]  snd_hda_core
[ 1256.956680]  ORIG_RAX: 000000000000002e
[ 1256.960610]  snd_hwdep
[ 1256.961944] RAX: ffffffffffffffda RBX: 0000000001935bc0 RCX: 00007feab6113737
[ 1256.964490]  snd_seq
[ 1256.965557] RDX: 0000000000000000 RSI: 00007ffefbd2e0e0 RDI: 0000000000000007
[ 1256.971397]  snd_seq_device
[ 1256.972299] RBP: 00000000019398f0 R08: 0000000000000004 R09: 00000000000000f0
[ 1256.978139]  kvm_intel
[ 1256.979639] R10: 00007ffefbd2e1a4 R11: 0000000000000246 R12: 0000000001935ad0
[ 1256.985479]  snd_pcm
[ 1256.986547] R13: 00007ffefbd2e0e0 R14: 000000000079cd98 R15: 00007feab6984000
[ 1256.992389]  kvm
[ 1256.993297]  </TASK>
[ 1256.999132]  snd_timer
[ 1256.999684] Modules linked in:
[ 1257.000579]  irqbypass
[ 1257.001655]  nf_conntrack_netlink
[ 1257.003419]  intel_wmi_thunderbolt
[ 1257.004488]  nf_conntrack
[ 1257.006514]  snd
[ 1257.008620]  nfnetlink
[ 1257.009946]  i2c_i801
[ 1257.010494]  vrf
[ 1257.011568]  pcspkr
[ 1257.012557]  nf_defrag_ipv6
[ 1257.013112]  soundcore
[ 1257.013925]  nf_defrag_ipv4
[ 1257.015432]  i2c_smbus
[ 1257.016500]  bpfilter
[ 1257.018006]  iwlmvm
[ 1257.019074]  8021q
[ 1257.020061]  mac80211
[ 1257.020875]  garp
[ 1257.021596]  iwlwifi
[ 1257.022584]  mrp
[ 1257.023225]  cfg80211
[ 1257.024127]  stp
[ 1257.024679]  bfq
[ 1257.025659]  llc
[ 1257.026206]  mei_pxp
[ 1257.026762]  macvlan
[ 1257.027314]  mei_hdcp
[ 1257.028208]  pktgen
[ 1257.029111]  intel_pch_thermal
[ 1257.030098]  rpcrdma
[ 1257.030911]  tpm_crb
[ 1257.032672]  rdma_cm
[ 1257.033572]  tpm_tis
[ 1257.034475]  iw_cm
[ 1257.035377]  tpm_tis_core
[ 1257.036275]  ib_cm
[ 1257.036996]  tpm
[ 1257.038331]  ib_core
[ 1257.039059]  acpi_pad
[ 1257.039614]  qrtr
[ 1257.040517]  sch_fq_codel
[ 1257.041504]  f71882fg
[ 1257.042144]  nfsd
[ 1257.043478]  intel_rapl_msr
[ 1257.044457]  auth_rpcgss
[ 1257.045090]  iTCO_wdt
[ 1257.046589]  nfs_acl
[ 1257.047830]  intel_pmc_bxt
[ 1257.048817]  lockd
[ 1257.049719]  ee1004
[ 1257.051141]  grace
[ 1257.051867]  snd_hda_codec_hdmi
[ 1257.052672]  sunrpc
[ 1257.053394]  iTCO_vendor_support
[ 1257.055250]  fuse
[ 1257.056063]  snd_hda_codec_realtek
[ 1257.058005]  zram
[ 1257.058645]  snd_hda_codec_generic
[ 1257.060760]  raid1
[ 1257.061401]  ledtrig_audio
[ 1257.063508]  dm_raid
[ 1257.064235]  coretemp
[ 1257.065658]  raid456
[ 1257.066560]  intel_rapl_common
[ 1257.067548]  libcrc32c
[ 1257.068450]  intel_tcc_cooling
[ 1257.070215]  async_raid6_recov
[ 1257.071283]  x86_pkg_temp_thermal
[ 1257.073048]  async_memcpy
[ 1257.074809]  snd_hda_intel
[ 1257.076837]  async_pq
[ 1257.078170]  snd_intel_dspcfg
[ 1257.079586]  async_xor
[ 1257.080573]  snd_hda_codec
[ 1257.082253]  xor
[ 1257.083328]  intel_powerclamp
[ 1257.084750]  async_tx
[ 1257.085306]  snd_hda_core
[ 1257.086986]  raid6_pq
[ 1257.087973]  snd_hwdep
[ 1257.089308]  i915
[ 1257.090286]  snd_seq
[ 1257.091355]  drm_buddy
[ 1257.091995]  snd_seq_device
[ 1257.092895]  intel_gtt
[ 1257.093962]  kvm_intel
[ 1257.095470]  drm_display_helper
[ 1257.096537]  snd_pcm
[ 1257.097610]  drm_kms_helper
[ 1257.099458]  kvm
[ 1257.100360]  cec
[ 1257.101866]  snd_timer
[ 1257.102414]  rc_core
[ 1257.102966]  irqbypass
[ 1257.104034]  ttm
[ 1257.104936]  intel_wmi_thunderbolt
[ 1257.106008]  igb
[ 1257.106556]  snd
[ 1257.108671]  i2c_algo_bit
[ 1257.109226]  i2c_i801
[ 1257.109781]  ixgbe
[ 1257.111115]  pcspkr
[ 1257.112101]  mdio
[ 1257.112831]  soundcore
[ 1257.113645]  drm
[ 1257.114284]  i2c_smbus
[ 1257.115353]  dca
[ 1257.115908]  iwlmvm
[ 1257.116981]  agpgart
[ 1257.117537]  mac80211
[ 1257.118350]  xhci_pci
[ 1257.119244]  iwlwifi
[ 1257.120230]  mei_wdt
[ 1257.121209]  cfg80211
[ 1257.122103]  i2c_core
[ 1257.123005]  bfq
[ 1257.123991]  hwmon
[ 1257.124971]  mei_pxp
[ 1257.125519]  xhci_pci_renesas
[ 1257.126244]  mei_hdcp
[ 1257.127139]  video
[ 1257.128821]  intel_pch_thermal
[ 1257.129809]  wmi
[ 1257.130537]  tpm_crb
[ 1257.132306]  [last unloaded: nfnetlink]
[ 1257.132857]  tpm_tis

[ 1257.136299]  tpm_tis_core
[ 1257.137194] CPU: 6 PID: 3737 Comm: btserver Tainted: G    B D W          6.7.0-rc1+ #1
[ 1257.137402]  tpm
[ 1257.138735] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1257.145356]  acpi_pad
[ 1257.145912] RIP: 0010:rcu_note_context_switch+0x6ee/0x990
[ 1257.152447]  sch_fq_codel
[ 1257.153435] Code: 48 8b 7c 24 08 4c 8b 75 58 e8 be ce 30 00 4c 8b 63 20 e9 8e fc ff ff 48 c7 c7 20 82 ab 82 c6 05 63 fe bd 02 01 e8 32 f7 ed ff <0f> 0b e9 98 
f9 ff ff 81 e5 ff ff ff 7f 0f 84 8e fa ff ff 65 48 8b
[ 1257.157540]  nfsd
[ 1257.158866] RSP: 0018:ffff8881464d7708 EFLAGS: 00010086
[ 1257.176323]  auth_rpcgss

[ 1257.180900]  nfs_acl
[ 1257.182145] RAX: 0000000000000000 RBX: ffff88841c13d280 RCX: 0000000000000027
[ 1257.182346]  lockd
[ 1257.183246] RDX: 0000000000000027 RSI: ffffffff814190fe RDI: ffff88841c1287c8
[ 1257.189081]  grace
[ 1257.189806] RBP: ffff888131c50040 R08: 0000000000000001 R09: ffffed10838250f9
[ 1257.195641]  sunrpc
[ 1257.196369] R10: ffff88841c1287cb R11: 00000000001fb570 R12: ffff888131c50040
[ 1257.202209]  fuse
[ 1257.203026] R13: ffff888131c50040 R14: ffffffff82711e93 R15: 0000000000000000
[ 1257.208866]  zram
[ 1257.209507] FS:  0000000000000000(0000) GS:ffff88841c100000(0000) knlGS:0000000000000000
[ 1257.215351]  raid1
[ 1257.215989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1257.222785]  dm_raid
[ 1257.223511] CR2: 0000000002700f90 CR3: 0000000003696004 CR4: 00000000003706f0
[ 1257.227968]  raid456
[ 1257.228870] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1257.234711]  libcrc32c
[ 1257.235613] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1257.241451]  async_raid6_recov
[ 1257.242520] Call Trace:
[ 1257.248362]  async_memcpy
[ 1257.250127]  <TASK>
[ 1257.251280]  async_pq
[ 1257.252615]  ? __warn+0x9c/0x1f0
[ 1257.253429]  async_xor
[ 1257.254410]  ? rcu_note_context_switch+0x6ee/0x990
[ 1257.256349]  xor
[ 1257.257418]  ? report_bug+0x1aa/0x1e0
[ 1257.260918]  async_tx
[ 1257.261477]  ? handle_bug+0x41/0x80
[ 1257.263848]  raid6_pq
[ 1257.264835]  ? exc_invalid_op+0x13/0x40
[ 1257.267037]  i915
[ 1257.268024]  ? asm_exc_invalid_op+0x16/0x20
[ 1257.270566]  drm_buddy
[ 1257.271206]  ? schedule+0x63/0x170
[ 1257.274102]  intel_gtt
[ 1257.275176]  ? irq_work_claim+0x1e/0x40
[ 1257.277280]  drm_display_helper
[ 1257.278349]  ? rcu_note_context_switch+0x6ee/0x990
[ 1257.280896]  drm_kms_helper
[ 1257.282750]  ? rcu_note_context_switch+0x6ee/0x990
[ 1257.286251]  cec
[ 1257.287758]  ? unwind_next_frame+0xbb9/0xeb0
[ 1257.291253]  rc_core
[ 1257.291806]  ? stack_access_ok+0x40/0xf0
[ 1257.294790]  ttm
[ 1257.295690]  ? schedule+0x63/0x170
[ 1257.298316]  igb
[ 1257.298872]  __schedule+0x173/0x1780
[ 1257.300986]  i2c_algo_bit
[ 1257.301539]  ? rcu_is_watching+0x1f/0x40
[ 1257.303817]  ixgbe
[ 1257.305143]  ? lock_acquire+0xc4/0x3b0
[ 1257.307772]  mdio
[ 1257.308498]  ? rcu_is_watching+0x1f/0x40
[ 1257.310951]  drm
[ 1257.311593]  ? io_schedule_timeout+0xb0/0xb0
[ 1257.314217]  dca
[ 1257.314765]  ? rcu_is_watching+0x1f/0x40
[ 1257.317747]  agpgart
[ 1257.318303]  ? lock_release+0xb2/0x3b0
[ 1257.320937]  xhci_pci
[ 1257.321837]  ? schedule+0x12d/0x170
[ 1257.324298]  mei_wdt
[ 1257.325285]  ? reacquire_held_locks+0x270/0x270
[ 1257.327480]  i2c_core
[ 1257.328379]  ? rcu_is_watching+0x1f/0x40
[ 1257.331614]  hwmon
[ 1257.332600]  ? lock_acquire+0xc4/0x3b0
[ 1257.335235]  xhci_pci_renesas
[ 1257.335965]  ? rcu_is_watching+0x1f/0x40
[ 1257.338426]  video
[ 1257.340106]  ? lock_release+0xb2/0x3b0
[ 1257.342741]  wmi
[ 1257.343471]  ? __wait_for_common+0x2a0/0x380
[ 1257.345929]  [last unloaded: nfnetlink]
[ 1257.346478]  schedule+0x63/0x170

[ 1257.352006]  schedule_timeout+0x1d3/0x1e0
[ 1257.353948] CR2: ffff888163174090
[ 1257.354156]  ? usleep_range_state+0x110/0x110
[ 1257.356875] ---[ end trace 0000000000000000 ]---
[ 1257.358898]  ? reacquire_held_locks+0x270/0x270
[ 1257.361963] RIP: 0010:iwl_mvm_mld_change_vif_links+0x372/0x610 [iwlmvm]
[ 1257.365283]  ? do_raw_spin_lock+0x114/0x1a0
[ 1257.368524] Code: 48 8b 7c 24 10 e8 ce af ff ff 85 c0 0f 85 bd 00 00 00 48 89 df e8 6e 31 bf df 48 8b 3b e8 06 ce b3 df 48 89 df e8 de 31 bf df <48> c7 03 00 
00 00 00 eb 9d e8 e0 2c cf e0 85 c0 0f 85 22 01 00 00
[ 1257.373846]  ? spin_bug+0xe0/0xe0
[ 1257.376740] RSP: 0018:ffff888192f3eca0 EFLAGS: 00010282
[ 1257.394194]  ? debug_object_active_state+0x200/0x210

[ 1257.400152]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1257.403825] RAX: 0000000000000000 RBX: ffff888163177a80 RCX: ffffffffa1a17ea2
[ 1257.404033]  ? _raw_spin_unlock_irq+0x1f/0x40
[ 1257.407707] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff888163177a80
[ 1257.413547]  ? trace_hardirqs_on+0x12/0xe0
[ 1257.416616] RBP: ffff888192f3efb0 R08: 0000000000000000 R09: ffffed10837c8340
[ 1257.422460]  __wait_for_common+0x2ca/0x380
[ 1257.425266] R10: ffff88841be41a03 R11: 0000000000000000 R12: ffff888192f3ed18
[ 1257.431106]  ? usleep_range_state+0x110/0x110
[ 1257.433915] R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
[ 1257.439759]  ? out_of_line_wait_on_bit_timeout+0x150/0x150
[ 1257.442823] FS:  0000000000000000(0000) GS:ffff88841c080000(0000) knlGS:0000000000000000
[ 1257.448664]  ? __call_rcu_common.constprop.0+0x220/0x480
[ 1257.452851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1257.459647]  ? trace_hardirqs_on+0x12/0xe0
[ 1257.463669] CR2: ffff888163174090 CR3: 0000000153cb2004 CR4: 00000000003706f0
[ 1257.468125]  ? __call_rcu_common.constprop.0+0x220/0x480
[ 1257.470931] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1257.476776]  __wait_rcu_gp+0x1e6/0x200
[ 1257.480794] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1257.486639]  synchronize_rcu+0x288/0x2a0
[ 1257.489097] note: wpa_supplicant[5831] exited with irqs disabled
[ 1257.494938]  ? synchronize_rcu_expedited+0x620/0x620
[ 1257.497620] note: wpa_supplicant[5831] exited with preempt_count 2
[ 1257.502288]  ? __call_rcu_common.constprop.0+0x480/0x480
[ 1257.502295]  ? __mutex_unlock_slowpath+0x110/0x3d0
[ 1257.502300]  ? rcu_tasks_pregp_step+0x10/0x10
[ 1257.502310]  ? __might_sleep+0x22/0xa0
[ 1257.502319]  packet_release+0x400/0x680
[ 1257.502325]  ? lock_acquire+0xc4/0x3b0
[ 1257.502331]  ? packet_set_ring+0xa40/0xa40
[ 1257.502334]  ? down_write+0x103/0x1a0
[ 1257.502338]  ? rwsem_down_write_slowpath+0xd90/0xd90
[ 1257.502343]  ? fcntl_setlk+0x5a0/0x5a0
[ 1257.502348]  ? rcu_is_watching+0x1f/0x40
[ 1257.502354]  __sock_release+0x5c/0x120
[ 1257.502359]  sock_close+0xf/0x20
[ 1257.502362]  __fput+0x12d/0x4d0
[ 1257.502370]  task_work_run+0xed/0x170
[ 1257.502375]  ? task_work_cancel+0x10/0x10
[ 1257.502380]  ? do_raw_spin_unlock+0x8e/0xe0
[ 1257.502387]  do_exit+0x5d3/0x11f0
[ 1257.502392]  ? is_current_pgrp_orphaned+0x60/0x60
[ 1257.502399]  ? lockdep_hardirqs_on_prepare+0xe/0x200
[ 1257.502405]  make_task_dead+0xba/0x200
[ 1257.502409]  rewind_stack_and_make_dead+0x17/0x20
[ 1257.502415] RIP: 0033:0x7fe88650774f
[ 1257.502418] Code: Unable to access opcode bytes at 0x7fe886507725.
[ 1257.502420] RSP: 002b:00007ffc75d243e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1257.502424] RAX: ffffffffffffffda RBX: 00000000027aad30 RCX: 00007fe88650774f
[ 1257.502427] RDX: 00007ffc75d24470 RSI: 0000000000008946 RDI: 0000000000000007
[ 1257.502430] RBP: 00007ffc75d26060 R08: 0000000000000500 R09: 0000000000000000
[ 1257.502432] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000469fb8
[ 1257.502434] R13: 0000000000000000 R14: 0000000000b16a78 R15: 00007fe886e06000
[ 1257.502442]  </TASK>
[ 1257.502443] irq event stamp: 0
[ 1257.502445] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1257.502448] hardirqs last disabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1257.502453] softirqs last  enabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1257.502457] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1257.502460] ---[ end trace 0000000000000000 ]---
[ 1257.646723] Fixing recursive fault but reboot is needed!
[ 1257.650779] BUG: scheduling while atomic: wpa_supplicant/5831/0x00000000
[ 1257.656248] INFO: lockdep is turned off.
[ 1257.658924] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 snd_hda_codec_hdmi iTCO_vendor_support snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel snd_intel_dspcfg snd_hda_codec 
intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm snd_timer irqbypass intel_wmi_thunderbolt snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm igb i2c_algo_bit ixgbe mdio drm dca agpgart
[ 1257.659121]  xhci_pci mei_wdt i2c_core hwmon xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 1257.755444] ------------[ cut here ]------------
[ 1257.756300] CPU: 1 PID: 5831 Comm: wpa_supplicant Tainted: G    B D W          6.7.0-rc1+ #1
[ 1257.758778] refcount_t: underflow; use-after-free.
[ 1257.765913] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1257.765916] Call Trace:
[ 1257.777256] WARNING: CPU: 0 PID: 366 at lib/refcount.c:28 refcount_warn_saturate+0xfd/0x110
[ 1257.784339] Modules linked in: nf_conntrack_netlink nf_conntrack nfnetlink vrf nf_defrag_ipv6 nf_defrag_ipv4 bpfilter 8021q garp mrp stp llc macvlan pktgen 
rpcrdma rdma_cm iw_cm ib_cm ib_core qrtr f71882fg intel_rapl_msr iTCO_wdt intel_pmc_bxt ee1004 snd_hda_codec_hdmi iTCO_vendor_support snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio coretemp intel_rapl_common intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel snd_intel_dspcfg snd_hda_codec 
intel_powerclamp snd_hda_core snd_hwdep snd_seq snd_seq_device kvm_intel snd_pcm kvm snd_timer irqbypass intel_wmi_thunderbolt snd i2c_i801 pcspkr soundcore 
i2c_smbus iwlmvm mac80211 iwlwifi cfg80211 bfq mei_pxp mei_hdcp intel_pch_thermal tpm_crb tpm_tis tpm_tis_core tpm acpi_pad sch_fq_codel nfsd auth_rpcgss 
nfs_acl lockd grace sunrpc fuse zram raid1 dm_raid raid456 libcrc32c async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy 
intel_gtt drm_display_helper drm_kms_helper cec rc_core ttm igb i2c_algo_bit ixgbe mdio drm dca agpgart
[ 1257.784528]  xhci_pci mei_wdt i2c_core hwmon xhci_pci_renesas video wmi [last unloaded: nfnetlink]
[ 1257.880835] CPU: 0 PID: 366 Comm: kworker/0:2 Tainted: G    B D W          6.7.0-rc1+ #1
[ 1257.887661] Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
[ 1257.894227] Workqueue:  0x0 (events)
[ 1257.896579] RIP: 0010:refcount_warn_saturate+0xfd/0x110
[ 1257.900533] Code: 00 6f c4 82 c6 05 6e 5e 47 02 01 e8 6d 56 77 ff 0f 0b e9 53 ff ff ff 48 c7 c7 40 6e c4 82 c6 05 56 5e 47 02 01 e8 53 56 77 ff <0f> 0b e9 39 
ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 54 be
[ 1257.918038] RSP: 0018:ffff888138b1fca0 EFLAGS: 00010282
[ 1257.921990] RAX: 0000000000000000 RBX: 0000000000000003 RCX: ffffffff81347108
[ 1257.927889] RDX: 1ffff110837c58a4 RSI: 0000000000000008 RDI: ffff88841be2c520
[ 1257.933757] RBP: ffff88817ef6a520 R08: 0000000000000001 R09: ffffed1027163f59
[ 1257.939631] R10: ffff888138b1facf R11: 000000000015bae8 R12: ffff88817ef68040
[ 1257.945508] R13: 0000000000000000 R14: ffff88841be3c458 R15: 0000000000000000
[ 1257.951399] FS:  0000000000000000(0000) GS:ffff88841be00000(0000) knlGS:0000000000000000
[ 1257.958225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1257.962711] CR2: ffff888163177a80 CR3: 0000000003696003 CR4: 00000000003706f0
[ 1257.968580] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1257.974455] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1257.980356] Call Trace:
[ 1257.981543]  <TASK>
[ 1257.982400]  ? __warn+0x9c/0x1f0
[ 1257.984371]  ? refcount_warn_saturate+0xfd/0x110
[ 1257.987738]  ? report_bug+0x1aa/0x1e0
[ 1257.990141]  ? handle_bug+0x41/0x80
[ 1257.992388]  ? exc_invalid_op+0x13/0x40
[ 1257.994954]  ? asm_exc_invalid_op+0x16/0x20
[ 1257.997887]  ? tick_nohz_tick_stopped+0x18/0x30
[ 1258.001157]  ? refcount_warn_saturate+0xfd/0x110
[ 1258.004516]  finish_task_switch.isra.0+0x3e5/0x490
[ 1258.008082]  __schedule+0x7e4/0x1780
[ 1258.010403]  ? io_schedule_timeout+0xb0/0xb0
[ 1258.013431]  ? rcu_is_watching+0x1f/0x40
[ 1258.016086]  ? lock_release+0xb2/0x3b0
[ 1258.018581]  ? schedule+0x12d/0x170
[ 1258.020797]  ? reacquire_held_locks+0x270/0x270
[ 1258.024097]  schedule+0x63/0x170
[ 1258.026058]  ? worker_thread+0x92/0x680
[ 1258.028635]  worker_thread+0xc3/0x680
[ 1258.031038]  ? create_worker+0x390/0x390
[ 1258.033719]  kthread+0x199/0x1e0
[ 1258.035677]  ? kthread+0xed/0x1e0
[ 1258.037732]  ? kthread_complete_and_exit+0x20/0x20
[ 1258.041256]  ret_from_fork+0x28/0x50
[ 1258.043590]  ? kthread_complete_and_exit+0x20/0x20
[ 1258.047120]  ret_from_fork_asm+0x11/0x20
[ 1258.049838]  </TASK>
[ 1258.050759] irq event stamp: 0
[ 1258.052551] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[ 1258.057551] hardirqs last disabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1258.064473] softirqs last  enabled at (0): [<ffffffff811d9d28>] copy_process+0xf68/0x32f0
[ 1258.071424] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1258.076434] ---[ end trace 0000000000000000 ]---
-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

