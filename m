Return-Path: <linux-wireless+bounces-32420-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKS8AbBCp2kNgAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32420-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 21:21:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FDB1F6BC3
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 21:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 84A1D303B902
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 20:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01BB37F003;
	Tue,  3 Mar 2026 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="nlL8kREO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E65379ED5
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569260; cv=none; b=r9zRN0MPuB4K9t3cZ35mUhtqwQMJZVfQjeHXvETNgpQVqn/3Lk9N7scxE00pothqvNjEiw8ty+ZLwE4ZGciQh1InyPfj0tC3E2fYmml6bctgIAv5BS4QfDaKoKy6PURaNzh1eY6ha466YhOsmuWPyMw2on+dW06D6wYrnqQgFQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569260; c=relaxed/simple;
	bh=feabjz+BSbiisquD11YhQ5UdWUpGJ0UqAcFhSpGKGeQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pM0hFkrFABAjx14lKMhDx02UW5roDU9SCSWvFPvtqN/MtQ9QvNDHVlmQvJscbBBSJrv+CvNwfTAiV9tK1jmc+FiY7dQlvGdtdKtX6sPywXFucwmDc/cV6yxYRJ35Km6+h0m2f8KqSadF3I8galy61agfgsX0uiDy3VqS+6o5PMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=nlL8kREO; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C0E9D440067;
	Tue,  3 Mar 2026 20:20:50 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 09B3F13C2B0;
	Tue,  3 Mar 2026 12:20:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 09B3F13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1772569249;
	bh=feabjz+BSbiisquD11YhQ5UdWUpGJ0UqAcFhSpGKGeQ=;
	h=Date:To:From:Subject:From;
	b=nlL8kREOVRFPRcFI3RDqhmTbNaoVcqYgWDo90iEMTthdeibiAhBLw2RmdH4TZQVZe
	 d6WiOZ0s1kuqRg8tvmKuSgeppfV2fDU/6fH9k7zBDN8crwwc2IRfFNFeg37DTVfZCp
	 kZRsmdNRJQquEawT5LGH+Br8rOQ54dsc3Yjm6NP4=
Message-ID: <4075b0b5-85fc-a037-82d3-c6102807f561@candelatech.com>
Date: Tue, 3 Mar 2026 12:20:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>,
 "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
From: Ben Greear <greearb@candelatech.com>
Subject: iwlwifi: improve cleanup to fix use-after-free.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1772569251-wzcQku4ipjZR
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1772569251;wzcQku4ipjZR;<greearb@candelatech.com>;b05365583a7ac22983513582f8b41fd7
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Queue-Id: 61FDB1F6BC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32420-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[candelatech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

I believe I found the cause of the use-after-free crash related to iwl_mld_rm_link_from_fw
access.

 From the logging I've added, we see that the logic in mlme.c is failing:

static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
				     struct cfg80211_bss *cbss, s8 link_id,
				     const u8 *ap_mld_addr, bool assoc,
				     struct ieee80211_conn_settings *conn,
				     bool override,
				     unsigned long *userspace_selectors)
{
	struct ieee80211_local *local = sdata->local;
	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
	struct ieee80211_bss *bss = (void *)cbss->priv;
	struct sta_info *new_sta = NULL;
	struct ieee80211_link_data *link;
	bool have_sta = false;
	bool mlo;
	int err;
	u16 new_links;

	if (link_id >= 0) {
		mlo = true;
		if (WARN_ON(!ap_mld_addr))
			return -EINVAL;
		new_links = BIT(link_id);
	} else {
		if (WARN_ON(ap_mld_addr))
			return -EINVAL;
		ap_mld_addr = cbss->bssid;
		new_links = 0;
		link_id = 0;
		mlo = false;
	}

	if (assoc) {
		rcu_read_lock();
		have_sta = sta_info_get(sdata, ap_mld_addr);
		rcu_read_unlock();
	}

	if (mlo && !have_sta &&
	    WARN_ON_ONCE(sdata->vif.valid_links || sdata->vif.active_links)) {
		pr_err("%s: prep-connection, no-have-sta, valid-links: 0x%x  active-links: 0x%x\n",
		       sdata->dev->name, sdata->vif.valid_links, sdata->vif.active_links);
		return -EINVAL;
	}


I'm not sure exactly how, but this path (or something related) appears to only half-configure
the iwlwifi driver.

I added improved safety code in iwlwifi to force clearing pointers and I see that code hitting.  The system
did not crash this time, and STA reconnected.  This patch below is on top of some previous debugging
I had added, I'll paste code w/out diff below the diff.

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index a5472ede2803..c0ee7de35aa9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -507,32 +507,49 @@ void iwl_mld_remove_link(struct iwl_mld *mld,
         struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
         struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
         bool is_deflink = link == &mld_vif->deflink;
-       u8 fw_id;
+       u16 fw_id;

         if (WARN_ON_ONCE(!link)) {
-               IWL_ERR(mld, "Attempted to remove nonexistent link.\n");
-               return;
+               IWL_ERR(mld, "Remove nonexistent link, bss_conf: 0x%px link-id: %d\n",
+                       bss_conf, bss_conf->link_id);
+               fw_id = 0xffff;
         }
-
-       if (WARN_ON_ONCE(link->active)) {
-               IWL_ERR(mld, "Attempted to remove active link.\n");
-               return;
+       else {
+               fw_id  = link->fw_id;
         }

-       fw_id  = link->fw_id;
+       /* Not cleaning it up seems worse than cleaning up an active link,
+        * so continue on even in warning case.
+        */
+       if (link && WARN_ON_ONCE(link->active))
+               IWL_ERR(mld, "Removing active link, id: %d\n",
+                       bss_conf->link_id);

         iwl_mld_rm_link_from_fw(mld, bss_conf);
         /* Continue cleanup on failure */

-       if (!is_deflink)
+       if (link && !is_deflink)
                 kfree_rcu(link, rcu_head);

         RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);

-       if (WARN_ON(fw_id >= mld->fw->ucode_capa.num_links))
-               return;
-
-       RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
+       if (fw_id >= mld->fw->ucode_capa.num_links) {
+               struct ieee80211_bss_conf *tmp_bss_conf;
+               int i;
+
+               /* Search for any existing back-pointer */
+               for (i = 0; i<ARRAY_SIZE(mld->fw_id_to_bss_conf); i++) {
+                       tmp_bss_conf = rcu_dereference(mld->fw_id_to_bss_conf[i]);
+                       if (tmp_bss_conf == bss_conf) {
+                               IWL_ERR(mld, "WARNING: Found bss_conf in fw_id_to_bss_conf[%i], Nulling pointer.\n",
+                                       i);
+                               RCU_INIT_POINTER(mld->fw_id_to_bss_conf[i], NULL);
+                       }
+               }
+       }
+       else {
+               RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
+       }
  }


/* Remove link from fw, unmap the bss_conf, and destroy the link structure */
void iwl_mld_remove_link(struct iwl_mld *mld,
			 struct ieee80211_bss_conf *bss_conf)
{
	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(bss_conf->vif);
	struct iwl_mld_link *link = iwl_mld_link_from_mac80211(bss_conf);
	bool is_deflink = link == &mld_vif->deflink;
	u16 fw_id;

	if (WARN_ON_ONCE(!link)) {
		IWL_ERR(mld, "Remove nonexistent link, bss_conf: 0x%px link-id: %d\n",
			bss_conf, bss_conf->link_id);
		fw_id = 0xffff;
	}
	else {
		fw_id  = link->fw_id;
	}

	/* Not cleaning it up seems worse than cleaning up an active link,
	 * so continue on even in warning case.
	 */
	if (link && WARN_ON_ONCE(link->active))
		IWL_ERR(mld, "Removing active link, id: %d\n",
			bss_conf->link_id);

	iwl_mld_rm_link_from_fw(mld, bss_conf);
	/* Continue cleanup on failure */

	if (link && !is_deflink)
		kfree_rcu(link, rcu_head);

	RCU_INIT_POINTER(mld_vif->link[bss_conf->link_id], NULL);

	if (fw_id >= mld->fw->ucode_capa.num_links) {
		struct ieee80211_bss_conf *tmp_bss_conf;
		int i;

		/* Search for any existing back-pointer */
		for (i = 0; i<ARRAY_SIZE(mld->fw_id_to_bss_conf); i++) {
			tmp_bss_conf = rcu_dereference(mld->fw_id_to_bss_conf[i]);
			if (tmp_bss_conf == bss_conf) {
				IWL_ERR(mld, "WARNING: Found bss_conf in fw_id_to_bss_conf[%i], Nulling pointer.\n",
					i);
				RCU_INIT_POINTER(mld->fw_id_to_bss_conf[i], NULL);
			}
		}
	}
	else {
		RCU_INIT_POINTER(mld->fw_id_to_bss_conf[fw_id], NULL);
	}
}


Miriam, please let me know if you are interested in a patch like this, and if so, do you
want the IWL_ERR printing in there or not?


Here are the logs of this happening:

Mar 03 11:45:01 ct523c-ccbc kernel: wlan10: prep-connection, no-have-sta, valid-links: 0x4  active-links: 0x4
Mar 03 11:45:01 ct523c-ccbc kernel: wlan10: mgd_auth, prep connection failed: -22
Mar 03 11:45:01 ct523c-ccbc kernel: wlan10: mgd_auth failed, err: -22
Mar 03 11:45:01 ct523c-ccbc kernel: wlan10: prep-connection, no-have-sta, valid-links: 0x4  active-links: 0x4
Mar 03 11:45:01 ct523c-ccbc kernel: wlan10: mgd_auth, prep connection failed: -22
Mar 03 11:45:01 ct523c-ccbc kernel: wlan10: mgd_auth failed, err: -22
Mar 03 11:45:01 ct523c-ccbc kernel: wlan10: ieee80211_vif_set_links: new_links=0x0; dormant_links=0x0
Mar 03 11:45:01 ct523c-ccbc kernel: iwlwifi 0000:38:00.0: Attempted to remove nonexistent link, bss_conf: 0xffff888186c1c470 link-id: 2
Mar 03 11:45:01 ct523c-ccbc kernel: ------------[ cut here ]------------
Mar 03 11:45:01 ct523c-ccbc kernel: WARNING: CPU: 1 PID: 44077 at drivers/net/wireless/intel/iwlwifi/mld/link.c:432 iwl_mld_rm_link_from_fw+0x25a/0x3a0 [iwlmld]
Mar 03 11:45:01 ct523c-ccbc kernel: Modules linked in: vrf nf_conntrack_netlink nf_conntrack nfnetlink nf_defrag_ipv6 nf_defrag_ipv4 8021q garp mrp stp llc 
macvlan pktgen rfcomm rpcrdma rdma_cm iw_cm nfsv3 ib_cm ib_core nfs netfs qrtr bnep intel_rapl_msr iTCO_wdt ee1004 intel_pmc_bxt coretemp intel_rapl_common 
snd_hda_codec_intelhdmi intel_uncore_frequency snd_hda_codec_hdmi intel_uncore_frequency_common iTCO_vendor_support snd_hda_codec_alc662 
snd_hda_codec_realtek_lib snd_hda_codec_generic iwlmld intel_tcc_cooling x86_pkg_temp_thermal snd_hda_intel intel_wmi_thunderbolt intel_powerclamp 
snd_intel_dspcfg pcspkr snd_hda_codec snd_hda_core mac80211 snd_hwdep snd_seq btusb snd_seq_device btbcm btmtk btrtl btintel snd_pcm bluetooth iwlwifi snd_timer 
cfg80211 ftdi_sio i2c_i801 snd i2c_smbus soundcore i2c_mux mei_hdcp mei_pxp intel_pch_thermal intel_pmc_core pmt_telemetry pmt_discovery pmt_class 
intel_pmc_ssram_telemetry intel_vsec acpi_pad bfq sch_fq_codel nfsd auth_rpcgss nfs_acl lockd grace nfs_localio sunrpc zram raid1 dm_raid raid456
Mar 03 11:45:01 ct523c-ccbc kernel:  async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq i915 drm_buddy intel_gtt drm_client_lib 
drm_display_helper drm_kms_helper cec rc_core igb ttm agpgart dca i2c_algo_bit hwmon drm mei_wdt i2c_core intel_oc_wdt video wmi scsi_dh_rdac scsi_dh_emc 
scsi_dh_alua dm_multipath fuse [last unloaded: nfnetlink]
Mar 03 11:45:01 ct523c-ccbc kernel: CPU: 1 UID: 0 PID: 44077 Comm: wpa_supplicant Kdump: loaded Tainted: G        W           6.18.14+ #28 PREEMPT(full)
Mar 03 11:45:01 ct523c-ccbc kernel: Tainted: [W]=WARN
Mar 03 11:45:01 ct523c-ccbc kernel: Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/21/2023
Mar 03 11:45:01 ct523c-ccbc kernel: RIP: 0010:iwl_mld_rm_link_from_fw+0x25a/0x3a0 [iwlmld]
Mar 03 11:45:01 ct523c-ccbc kernel: Code: 00 49 8b 84 24 18 11 00 00 be ff ff ff ff 48 8d 78 68 e8 c9 07 9e e1 85 c0 0f 85 03 ff ff ff 0f 0b 4d 85 ff 0f 85 01 
ff ff ff <0f> 0b e9 69 ff ff ff 48 8d ba e0 05 00 00 48 b8 00 00 00 00 00 fc
Mar 03 11:45:01 ct523c-ccbc kernel: RSP: 0018:ffff88821104eae0 EFLAGS: 00010246
Mar 03 11:45:01 ct523c-ccbc kernel: RAX: 0000000000000000 RBX: 1ffff11042209d5d RCX: 1ffffffff0b57d64
Mar 03 11:45:01 ct523c-ccbc kernel: RDX: 0000000000000000 RSI: ffff888186c1c470 RDI: ffff88821104ebe8
Mar 03 11:45:01 ct523c-ccbc kernel: RBP: ffff888186c1c470 R08: 0000000000000001 R09: ffffed1042209cfe
Mar 03 11:45:01 ct523c-ccbc kernel: R10: ffff88821104e7f7 R11: 0000000000086478 R12: ffff888168665508
Mar 03 11:45:01 ct523c-ccbc kernel: R13: ffff888186c1c488 R14: ffff88821104eb18 R15: 0000000000000000
Mar 03 11:45:01 ct523c-ccbc kernel: FS:  00007fdab99f5780(0000) GS:ffff8884973c6000(0000) knlGS:0000000000000000
Mar 03 11:45:01 ct523c-ccbc kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Mar 03 11:45:01 ct523c-ccbc kernel: CR2: 0000000002d4e878 CR3: 000000020ebc2001 CR4: 00000000003706f0
Mar 03 11:45:01 ct523c-ccbc kernel: Call Trace:
Mar 03 11:45:01 ct523c-ccbc kernel:  <TASK>
Mar 03 11:45:01 ct523c-ccbc kernel:  ? iwl_mld_send_link_cmd+0x360/0x360 [iwlmld]
Mar 03 11:45:01 ct523c-ccbc kernel:  ? iwl_mld_remove_link+0x3ee/0x5c0 [iwlmld]
Mar 03 11:45:01 ct523c-ccbc kernel:  iwl_mld_remove_link+0x460/0x5c0 [iwlmld]
Mar 03 11:45:01 ct523c-ccbc kernel:  iwl_mld_change_vif_links+0xf9/0x760 [iwlmld]
Mar 03 11:45:01 ct523c-ccbc kernel:  drv_change_vif_links+0x2e7/0x620 [mac80211]
Mar 03 11:45:01 ct523c-ccbc kernel:  ieee80211_vif_update_links+0xced/0x1500 [mac80211]
Mar 03 11:45:01 ct523c-ccbc kernel:  ? irq_work_queue+0x69/0xa0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? ieee80211_apvlan_link_clear+0x60/0x60 [mac80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? vprintk_emit+0x2e4/0x3e0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? wake_up_klogd_work_func+0x80/0x80
Mar 03 11:45:02 ct523c-ccbc kernel:  ? _printk+0xb2/0xe0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? printk_get_console_flush_type+0x2d0/0x2d0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? lock_release+0x1cc/0x290
Mar 03 11:45:02 ct523c-ccbc kernel:  ieee80211_vif_set_links+0xa8/0x130 [mac80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? ieee80211_find_best_sta_link+0x430/0x430 [mac80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? unwind_get_return_address+0x56/0xa0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? write_profile+0xf0/0xf0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? arch_stack_walk+0x97/0xe0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? ieee80211_send_teardown_neg_ttlm+0x2e0/0x2e0 [mac80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ieee80211_prep_connection+0xe3/0x1550 [mac80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ieee80211_mgd_auth+0xec6/0x1960 [mac80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? kasan_save_stack+0x2a/0x40
Mar 03 11:45:02 ct523c-ccbc kernel:  ? ieee80211_mlme_notify_scan_completed+0x300/0x300 [mac80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __kmalloc_noprof+0x24e/0x7d0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? cfg80211_find_elem_match+0xd6/0x1b0 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? lock_release+0x1cc/0x290
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __cfg80211_get_bss+0x429/0xa50 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? trace_irq_enable.constprop.0+0xbe/0x100
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __cfg80211_get_bss+0x429/0xa50 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __cfg80211_get_bss+0x46f/0xa50 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  cfg80211_mlme_auth+0x458/0x7f0 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  nl80211_authenticate+0xa90/0x1180 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __rtnl_unlock+0x65/0xf0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? nl80211_parse_key+0xe60/0xe60 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __kasan_kmalloc+0x83/0x90
Mar 03 11:45:02 ct523c-ccbc kernel:  ? nl80211_pre_doit+0x3f3/0x750 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  genl_family_rcv_msg_doit+0x1cb/0x2a0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? genl_family_rcv_msg_attrs_parse.constprop.0+0x230/0x230
Mar 03 11:45:02 ct523c-ccbc kernel:  ? security_capable+0x2d/0x80
Mar 03 11:45:02 ct523c-ccbc kernel:  genl_rcv_msg+0x3f7/0x6b0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? genl_family_rcv_msg_dumpit+0x2a0/0x2a0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? ext4_inode_csum+0x27e/0x350
Mar 03 11:45:02 ct523c-ccbc kernel:  ? nl80211_get_reg_dump+0x450/0x450 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? nl80211_parse_key+0xe60/0xe60 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? nlmsg_trim+0x60/0x60 [cfg80211]
Mar 03 11:45:02 ct523c-ccbc kernel:  ? from_kprojid+0x8b/0xc0
Mar 03 11:45:02 ct523c-ccbc kernel:  netlink_rcv_skb+0x125/0x380
Mar 03 11:45:02 ct523c-ccbc kernel:  ? genl_family_rcv_msg_dumpit+0x2a0/0x2a0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? lock_acquire+0x291/0x2e0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? netlink_ack+0xda0/0xda0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? netlink_deliver_tap+0x14f/0xb60
Mar 03 11:45:02 ct523c-ccbc kernel:  genl_rcv+0x24/0x40
Mar 03 11:45:02 ct523c-ccbc kernel:  netlink_unicast+0x5dd/0x9d0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? netlink_attachskb+0x9b0/0x9b0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __virt_addr_valid+0x205/0x3f0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __check_object_size+0x489/0x640
Mar 03 11:45:02 ct523c-ccbc kernel:  netlink_sendmsg+0x749/0xc00
Mar 03 11:45:02 ct523c-ccbc kernel:  ? netlink_unicast+0x9d0/0x9d0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? lock_release+0x1cc/0x290
Mar 03 11:45:02 ct523c-ccbc kernel:  ? netlink_unicast+0x9d0/0x9d0
Mar 03 11:45:02 ct523c-ccbc kernel:  __sock_sendmsg+0xc1/0x150
Mar 03 11:45:02 ct523c-ccbc kernel:  ____sys_sendmsg+0x5f4/0x8f0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? kernel_sendmsg+0x30/0x30
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __copy_msghdr+0x400/0x400
Mar 03 11:45:02 ct523c-ccbc kernel:  ? ext4_buffered_write_iter+0xf4/0x360
Mar 03 11:45:02 ct523c-ccbc kernel:  ___sys_sendmsg+0xed/0x170
Mar 03 11:45:02 ct523c-ccbc kernel:  ? copy_msghdr_from_user+0x110/0x110
Mar 03 11:45:02 ct523c-ccbc kernel:  ? _copy_from_user+0x4f/0x90
Mar 03 11:45:02 ct523c-ccbc kernel:  ? lock_acquire+0x291/0x2e0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? netlink_setsockopt+0x32d/0x650
Mar 03 11:45:02 ct523c-ccbc kernel:  ? lock_release+0x1cc/0x290
Mar 03 11:45:02 ct523c-ccbc kernel:  ? kfree+0x2ae/0x580
Mar 03 11:45:02 ct523c-ccbc kernel:  ? vfs_write+0x2d9/0x1150
Mar 03 11:45:02 ct523c-ccbc kernel:  ? do_sock_setsockopt+0x1c2/0x3b0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? do_sock_setsockopt+0x1c2/0x3b0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? move_addr_to_user+0x150/0x150
Mar 03 11:45:02 ct523c-ccbc kernel:  __sys_sendmsg+0x107/0x1a0
Mar 03 11:45:02 ct523c-ccbc kernel:  ? __sys_sendmsg_sock+0x20/0x20
Mar 03 11:45:02 ct523c-ccbc kernel:  do_syscall_64+0x69/0x1210
Mar 03 11:45:02 ct523c-ccbc kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0x53
Mar 03 11:45:02 ct523c-ccbc kernel: RIP: 0033:0x7fdab9335e24
Mar 03 11:45:02 ct523c-ccbc kernel: Code: 15 f1 ff 0b 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d 45 85 0c 00 00 74 13 b8 2e 00 00 
00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
Mar 03 11:45:02 ct523c-ccbc kernel: RSP: 002b:00007ffd9daf6308 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
Mar 03 11:45:02 ct523c-ccbc kernel: RAX: ffffffffffffffda RBX: 0000000002cc6f50 RCX: 00007fdab9335e24
Mar 03 11:45:02 ct523c-ccbc kernel: RDX: 0000000000000000 RSI: 00007ffd9daf6360 RDI: 0000000000000007
Mar 03 11:45:02 ct523c-ccbc kernel: RBP: 0000000002d47af0 R08: 0000000000000004 R09: 000000000000000d
Mar 03 11:45:02 ct523c-ccbc kernel: R10: 00007ffd9daf642c R11: 0000000000000202 R12: 0000000002cc6e60
Mar 03 11:45:02 ct523c-ccbc kernel: R13: 00007ffd9daf6360 R14: 00007fdab9b47000 R15: 00000000007e3d78
Mar 03 11:45:02 ct523c-ccbc kernel:  </TASK>
Mar 03 11:45:02 ct523c-ccbc kernel: irq event stamp: 0
Mar 03 11:45:02 ct523c-ccbc kernel: hardirqs last  enabled at (0): [<0000000000000000>] 0x0
Mar 03 11:45:02 ct523c-ccbc kernel: hardirqs last disabled at (0): [<ffffffff814500f7>] copy_process+0x1c07/0x67e0
Mar 03 11:45:02 ct523c-ccbc kernel: softirqs last  enabled at (0): [<ffffffff81450144>] copy_process+0x1c54/0x67e0
Mar 03 11:45:02 ct523c-ccbc kernel: softirqs last disabled at (0): [<0000000000000000>] 0x0
Mar 03 11:45:02 ct523c-ccbc kernel: ---[ end trace 0000000000000000 ]---
Mar 03 11:45:02 ct523c-ccbc kernel: iwlwifi 0000:38:00.0: WARNING: Found bss_conf in fw_id_to_bss_conf[0], Nulling pointer.
Mar 03 11:45:02 ct523c-ccbc kernel: iwlwifi 0000:38:00.0: add-link-sta, allocated fw_id_to_link_sta[4]
Mar 03 11:45:02 ct523c-ccbc kernel: wlan10: sta-info-insert-drv-state, sta is uploaded
Mar 03 11:45:02 ct523c-ccbc kernel: wlan10: e0:8f:4c:a0:2a:8a authenticate with 70:58:a4:ff:75:59 (local address=e0:8f:4c:a0:2a:8a)
Mar 03 11:45:02 ct523c-ccbc kernel: wlan10: send auth to 70:58:a4:ff:75:59 (try 1/4)
Mar 03 11:45:03 ct523c-ccbc dhclient[43442]: DHCPDISCOVER on wlan1 to 255.255.255.255 port 67 interval 9
Mar 03 11:45:03 ct523c-ccbc kernel: wlan10: send auth to 70:58:a4:ff:75:59 (try 2/4)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


