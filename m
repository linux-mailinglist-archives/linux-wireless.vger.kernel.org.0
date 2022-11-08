Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C05621886
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 16:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiKHPkR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 10:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiKHPkQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 10:40:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE4415A19
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 07:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5F5A4CE1BCC
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 15:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75568C433C1;
        Tue,  8 Nov 2022 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667922010;
        bh=nyVoaDkqdMOqHLSWWADJCSmrZlxRwzHj0bD7ZpwPLOQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mgFc6ZGmGERAwVKuhS0IxBrRfpCgSe/RB6GVDYL3RJeTgXjlUyM9l20+icFl9n/kr
         shJ/0gyO++zQ40rl88+8Mch7xetVlq7KHQQ6GHbJiVRsezsvlLyxBS1K65HTEcPnq0
         G3JhvKFRhHibpWuD24DKuFyKw0aKzjaSDLV1fS4zzew5IZydvK6cPUhj3RWLq6dzAx
         Rkj7vWMawg9mHCo4ED+96e544pWLirnYqcWcU7vlD8ltRLYLbBdUOGABorvCUtbzHf
         N1R8xeij6k4lT5QyonKlIz0NkQvR72YzSqXOqUObM5DH3mts91gujhHTVuSACb9mqm
         1st8fv4Zc1wgQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k\@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: Re: [PATCH 46/50] wifi: ath12k: add wmi.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-47-kvalo@kernel.org>
        <cfcc540a6cd7432fb214f7a059fd4c31@realtek.com>
Date:   Tue, 08 Nov 2022 17:40:05 +0200
In-Reply-To: <cfcc540a6cd7432fb214f7a059fd4c31@realtek.com> (Ping-Ke Shih's
        message of "Wed, 7 Sep 2022 07:36:56 +0000")
Message-ID: <87leolcv56.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Saturday, August 13, 2022 12:10 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: ath12k@lists.infradead.org
>> Subject: [PATCH 46/50] wifi: ath12k: add wmi.c
>> 
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>> 
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath12k/wmi.c | 6558 +++++++++++++++++++++++++++++++++
>>  1 file changed, 6558 insertions(+)
>> 
>> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c
>> b/drivers/net/wireless/ath/ath12k/wmi.c
>> new file mode 100644
>> index 000000000000..82aaedb5d0af
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
>> @@ -0,0 +1,6558 @@
>
> [...]
>
>> +
>> +static int ath12k_pull_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
>> +				     const void *ptr,
>> +				     struct ath12k_wmi_service_ext_arg *arg)
>> +{
>> +	const struct wmi_service_ready_ext_event *ev = ptr;
>> +
>> +	if (!ev)
>> +		return -EINVAL;
>> +
>> +	/* Move this to host based bitmap */
>> +	arg->default_conc_scan_config_bits =
>> +		le32_to_cpu(ev->default_conc_scan_config_bits);
>> +	arg->default_fw_config_bits = le32_to_cpu(ev->default_fw_config_bits);
>> +	arg->he_cap_info = le32_to_cpu(ev->he_cap_info);
>> +	arg->mpdu_density = le32_to_cpu(ev->mpdu_density);
>> +	arg->max_bssid_rx_filters = le32_to_cpu(ev->max_bssid_rx_filters);
>> +	memcpy(&arg->ppet, &ev->ppet, sizeof(arg->ppet));
>
> Originally, I would like to say the memcpy() statement can be replaced by
> arg->ppet = ev->ppet;
>
> But I found the struct(s) are different:
>
> arg->ppet is 
>
> struct ath12k_wmi_ppe_threshold_arg {
> 	u32 numss_m1;
> 	u32 ru_bit_mask;
> 	u32 ppet16_ppet8_ru3_ru0[PSOC_HOST_MAX_NUM_SS];
> };
>
> ev->ppet is
>
> struct ath12k_wmi_ppe_threshold_params {
> 	__le32 numss_m1; /** NSS - 1*/
> 	union {
> 		__le32 ru_count;
> 		__le32 ru_mask;
> 	} __packed;
> 	__le32 ppet16_ppet8_ru3_ru0[WMI_MAX_NUM_SS];
> } __packed;
>
> Then, using memcpy() doesn't work on big-endian machine.

This is now fixed like this:

	arg->ppet.numss_m1 = le32_to_cpu(ev->ppet.numss_m1);
	arg->ppet.ru_bit_mask = le32_to_cpu(ev->ppet.ru_info);

	for (i = 0; i < PSOC_HOST_MAX_NUM_SS; i++)
		arg->ppet.ppet16_ppet8_ru3_ru0[i] =
			le32_to_cpu(ev->ppet.ppet16_ppet8_ru3_ru0[i]);

But now the code assumes that both PSOC_HOST_MAX_NUM_SS and
WMI_MAX_NUM_SS are 8, which is not a safe assumption without a proper
check. I think the best would be to remove PSOC_HOST_MAX_NUM_SS and use
MAX_HE_NSS everywhere. I added that to the todo list.

>> +static int
>> +ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
>> +				      struct ath12k_wmi_svc_rdy_ext_parse *svc,
>> +				      u8 hw_mode_id, u8 phy_id,
>> +				      struct ath12k_pdev *pdev)
>> +{
>> +	const struct ath12k_wmi_mac_phy_caps_params *mac_phy_caps;
>> + const struct ath12k_wmi_soc_mac_phy_hw_mode_caps_params *hw_caps =
>> svc->hw_caps;
>> + const struct ath12k_wmi_hw_mode_cap_params *wmi_hw_mode_caps =
>> svc->hw_mode_caps;
>> + const struct ath12k_wmi_mac_phy_caps_params *wmi_mac_phy_caps =
>> svc->mac_phy_caps;
>> +	struct ath12k_band_cap *cap_band;
>> +	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
>> +	u32 phy_map;
>> +	u32 hw_idx, phy_idx = 0;
>> +
>> +	if (!hw_caps || !wmi_hw_mode_caps || !svc->soc_hal_reg_caps)
>> +		return -EINVAL;
>> +
>> +	for (hw_idx = 0; hw_idx < le32_to_cpu(hw_caps->num_hw_modes); hw_idx++) {
>> +		if (hw_mode_id == le32_to_cpu(wmi_hw_mode_caps[hw_idx].hw_mode_id))
>> +			break;
>> +
>> +		phy_map = le32_to_cpu(wmi_hw_mode_caps[hw_idx].phy_id_map);
>> +		while (phy_map) {
>> +			phy_map >>= 1;
>> +			phy_idx++;
>> +		}
>
> phy_idx = fls(phy_map)

Fixed.

>> +	if (le32_to_cpu(mac_phy_caps->supported_bands) & WMI_HOST_WLAN_2G_CAP) {
>> +		cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
>> +		cap_band->phy_id = le32_to_cpu(mac_phy_caps->phy_id);
>> +		cap_band->max_bw_supported =
>> +			le32_to_cpu(mac_phy_caps->max_bw_supported_2g);
>> +		cap_band->ht_cap_info = le32_to_cpu(mac_phy_caps->ht_cap_info_2g);
>> +		cap_band->he_cap_info[0] = le32_to_cpu(mac_phy_caps->he_cap_info_2g);
>> + cap_band->he_cap_info[1] =
>> le32_to_cpu(mac_phy_caps->he_cap_info_2g_ext);
>> +		cap_band->he_mcs = le32_to_cpu(mac_phy_caps->he_supp_mcs_2g);
>> +		memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_2g,
>> +		       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
>> +		memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet2g,
>> +		       sizeof(struct ath12k_wmi_ppe_threshold_arg));
>
> These two copy __le32 to u32.

These are now replaced with a loop using le32_to_cpu().

>> +	if (le32_to_cpu(mac_phy_caps->supported_bands) & WMI_HOST_WLAN_5G_CAP) {
>> +		cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
>> +		cap_band->phy_id = le32_to_cpu(mac_phy_caps->phy_id);
>> +		cap_band->max_bw_supported =
>> +			le32_to_cpu(mac_phy_caps->max_bw_supported_5g);
>> +		cap_band->ht_cap_info = le32_to_cpu(mac_phy_caps->ht_cap_info_5g);
>> +		cap_band->he_cap_info[0] = le32_to_cpu(mac_phy_caps->he_cap_info_5g);
>> + cap_band->he_cap_info[1] =
>> le32_to_cpu(mac_phy_caps->he_cap_info_5g_ext);
>> +		cap_band->he_mcs = le32_to_cpu(mac_phy_caps->he_supp_mcs_5g);
>> +		memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_5g,
>> +		       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
>> +		memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
>> +		       sizeof(struct ath12k_wmi_ppe_threshold_arg));
>
> copy __le32 to u32

This is also fixed.

>> +
>> +		cap_band = &pdev_cap->band[NL80211_BAND_6GHZ];
>> +		cap_band->max_bw_supported =
>> +			le32_to_cpu(mac_phy_caps->max_bw_supported_5g);
>> +		cap_band->ht_cap_info = le32_to_cpu(mac_phy_caps->ht_cap_info_5g);
>> +		cap_band->he_cap_info[0] = le32_to_cpu(mac_phy_caps->he_cap_info_5g);
>> + cap_band->he_cap_info[1] =
>> le32_to_cpu(mac_phy_caps->he_cap_info_5g_ext);
>> +		cap_band->he_mcs = le32_to_cpu(mac_phy_caps->he_supp_mcs_5g);
>> +		memcpy(cap_band->he_cap_phy_info, &mac_phy_caps->he_cap_phy_info_5g,
>> +		       sizeof(u32) * PSOC_HOST_MAX_PHY_SIZE);
>> +		memcpy(&cap_band->he_ppet, &mac_phy_caps->he_ppet5g,
>> +		       sizeof(struct ath12k_wmi_ppe_threshold_arg));
>
> and, these two.

And this is fixed as well.

> It seems like we don't have a simple way to convert struct with __le32 to
> another struct with cpu order. The only way is to convert fields of struct
> one by one.

Yeah, at least I can't think of any other solution.

>> +int ath12k_wmi_mgmt_send(struct ath12k *ar, u32 vdev_id, u32 buf_id,
>> +			 struct sk_buff *frame)
>> +{
>> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
>> +	struct wmi_mgmt_send_cmd *cmd;
>> +	struct wmi_tlv *frame_tlv;
>> +	struct sk_buff *skb;
>> +	u32 buf_len;
>> +	int ret, len;
>> +
>> +	buf_len = frame->len < WMI_MGMT_SEND_DOWNLD_LEN ?
>> +		  frame->len : WMI_MGMT_SEND_DOWNLD_LEN;
>
> buf_len = min(frame->len, WMI_MGMT_SEND_DOWNLD_LEN);

Fixed.

>> +int ath12k_wmi_vdev_install_key(struct ath12k *ar,
>> +				struct wmi_vdev_install_key_arg *arg)
>> +{
>> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
>> +	struct wmi_vdev_install_key_cmd *cmd;
>> +	struct wmi_tlv *tlv;
>> +	struct sk_buff *skb;
>> +	int ret, len;
>> +	int key_len_aligned = roundup(arg->key_len, sizeof(uint32_t));
>
> Not sure why 'uint32_t'?  Maybe, just '4' like other wmi functions.

Yeah, we changed that to '4'.

> mac80211 defines 
> struct ieee80211_key_conf {
> 	u8 key[];
> };
>
> And, this driver defines
> struct wmi_vdev_install_key_arg {
> 	const void *key_data;
> };
>
>> +
>> +	len = sizeof(*cmd) + TLV_HDR_SIZE + key_len_aligned;
>> +
>> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	cmd = (struct wmi_vdev_install_key_cmd *)skb->data;
>> +	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_VDEV_INSTALL_KEY_CMD,
>> +						 sizeof(*cmd));
>> +	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
>> +	ether_addr_copy(cmd->peer_macaddr.addr, arg->macaddr);
>> +	cmd->key_idx = cpu_to_le32(arg->key_idx);
>> +	cmd->key_flags = cpu_to_le32(arg->key_flags);
>> +	cmd->key_cipher = cpu_to_le32(arg->key_cipher);
>> +	cmd->key_len = cpu_to_le32(arg->key_len);
>> +	cmd->key_txmic_len = cpu_to_le32(arg->key_txmic_len);
>> +	cmd->key_rxmic_len = cpu_to_le32(arg->key_rxmic_len);
>> +
>> +	if (arg->key_rsc_counter)
>> +		cmd->key_rsc_counter = cpu_to_le64(arg->key_rsc_counter);
>> +
>> +	tlv = (struct wmi_tlv *)(skb->data + sizeof(*cmd));
>> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_BYTE, key_len_aligned);
>> +	memcpy(tlv->value, arg->key_data, key_len_aligned);
>
> If arg->key_len wasn't align of 4, this could access out of range of arg->key_data.

Yeah, this doesn't look right. Added this to the todo list.

>> +int ath12k_wmi_send_peer_assoc_cmd(struct ath12k *ar,
>> +				   struct ath12k_wmi_peer_assoc_arg *arg)
>> +{
>> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
>> +	struct wmi_peer_assoc_complete_cmd *cmd;
>> +	struct ath12k_wmi_vht_rate_set_params *mcs;
>> +	struct ath12k_wmi_he_rate_set_params *he_mcs;
>> +	struct sk_buff *skb;
>> +	struct wmi_tlv *tlv;
>> +	void *ptr;
>> +	u32 peer_legacy_rates_align;
>> +	u32 peer_ht_rates_align;
>> +	int i, ret, len;
>> +
>> +	peer_legacy_rates_align = roundup(arg->peer_legacy_rates.num_rates,
>> +					  sizeof(u32));
>> +	peer_ht_rates_align = roundup(arg->peer_ht_rates.num_rates,
>> +				      sizeof(u32));
>> +
>> +	len = sizeof(*cmd) +
>> +	      TLV_HDR_SIZE + (peer_legacy_rates_align * sizeof(u8)) +
>> +	      TLV_HDR_SIZE + (peer_ht_rates_align * sizeof(u8)) +
>> +	      sizeof(*mcs) + TLV_HDR_SIZE +
>> +	      (sizeof(*he_mcs) * arg->peer_he_mcs_count);
>> +
>> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	ptr = skb->data;
>> +
>> +	cmd = ptr;
>> +	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_PEER_ASSOC_COMPLETE_CMD,
>> +						 sizeof(*cmd));
>> +
>> +	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
>> +
>> +	cmd->peer_new_assoc = cpu_to_le32(arg->peer_new_assoc);
>> +	cmd->peer_associd = cpu_to_le32(arg->peer_associd);
>> +
>> +	ath12k_wmi_copy_peer_flags(cmd, arg,
>> +				   test_bit(ATH12K_FLAG_HW_CRYPTO_DISABLED,
>> +					    &ar->ab->dev_flags));
>> +
>> +	ether_addr_copy(cmd->peer_macaddr.addr, arg->peer_mac);
>> +
>> +	cmd->peer_rate_caps = cpu_to_le32(arg->peer_rate_caps);
>> +	cmd->peer_caps = cpu_to_le32(arg->peer_caps);
>> +	cmd->peer_listen_intval = cpu_to_le32(arg->peer_listen_intval);
>> +	cmd->peer_ht_caps = cpu_to_le32(arg->peer_ht_caps);
>> +	cmd->peer_max_mpdu = cpu_to_le32(arg->peer_max_mpdu);
>> +	cmd->peer_mpdu_density = cpu_to_le32(arg->peer_mpdu_density);
>> +	cmd->peer_vht_caps = cpu_to_le32(arg->peer_vht_caps);
>> +	cmd->peer_phymode = cpu_to_le32(arg->peer_phymode);
>> +
>> +	/* Update 11ax capabilities */
>> +	cmd->peer_he_cap_info = cpu_to_le32(arg->peer_he_cap_macinfo[0]);
>> +	cmd->peer_he_cap_info_ext = cpu_to_le32(arg->peer_he_cap_macinfo[1]);
>> + cmd->peer_he_cap_info_internal =
>> cpu_to_le32(arg->peer_he_cap_macinfo_internal);
>> +	cmd->peer_he_caps_6ghz = cpu_to_le32(arg->peer_he_caps_6ghz);
>> +	cmd->peer_he_ops = cpu_to_le32(arg->peer_he_ops);
>> +	memcpy(&cmd->peer_he_cap_phy, &arg->peer_he_cap_phyinfo,
>> +	       sizeof(arg->peer_he_cap_phyinfo));
>> +	memcpy(&cmd->peer_ppet, &arg->peer_ppet,
>> +	       sizeof(arg->peer_ppet));
>
> copy u32 to __le32

Fixed.

>> +int ath12k_wmi_send_scan_start_cmd(struct ath12k *ar,
>> +				   struct ath12k_wmi_scan_req_arg *arg)
>> +{
>> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
>> +	struct wmi_start_scan_cmd *cmd;
>> +	struct ath12k_wmi_ssid_params *ssid = NULL;
>> +	struct ath12k_wmi_mac_addr_params *bssid;
>> +	struct sk_buff *skb;
>> +	struct wmi_tlv *tlv;
>> +	void *ptr;
>> +	int i, ret, len;
>> +	u32 *tmp_ptr;
>> +	u8 extraie_len_with_pad = 0;
>> +	struct ath12k_wmi_hint_short_ssid_arg *s_ssid = NULL;
>> +	struct ath12k_wmi_hint_bssid_arg *hint_bssid = NULL;
>> +
>> +	len = sizeof(*cmd);
>> +
>> +	len += TLV_HDR_SIZE;
>> +	if (arg->num_chan)
>> +		len += arg->num_chan * sizeof(u32);
>> +
>> +	len += TLV_HDR_SIZE;
>> +	if (arg->num_ssids)
>> +		len += arg->num_ssids * sizeof(*ssid);
>> +
>> +	len += TLV_HDR_SIZE;
>> +	if (arg->num_bssid)
>> +		len += sizeof(*bssid) * arg->num_bssid;
>> +
>> +	len += TLV_HDR_SIZE;
>> +	if (arg->extraie.len)
>> +		extraie_len_with_pad =
>> +			roundup(arg->extraie.len, sizeof(u32));
>> +	len += extraie_len_with_pad;
>> +
>> +	if (arg->num_hint_bssid)
>> +		len += TLV_HDR_SIZE +
>> +		       arg->num_hint_bssid * sizeof(*hint_bssid);
>> +
>> +	if (arg->num_hint_s_ssid)
>> +		len += TLV_HDR_SIZE +
>> +		       arg->num_hint_s_ssid * sizeof(*s_ssid);
>> +
>> +	skb = ath12k_wmi_alloc_skb(wmi->wmi_ab, len);
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	ptr = skb->data;
>> +
>> +	cmd = ptr;
>> +	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_START_SCAN_CMD,
>> +						 sizeof(*cmd));
>> +
>> +	cmd->scan_id = cpu_to_le32(arg->scan_id);
>> +	cmd->scan_req_id = cpu_to_le32(arg->scan_req_id);
>> +	cmd->vdev_id = cpu_to_le32(arg->vdev_id);
>> +	cmd->scan_priority = cpu_to_le32(arg->scan_priority);
>> +	cmd->notify_scan_events = cpu_to_le32(arg->notify_scan_events);
>> +
>> +	ath12k_wmi_copy_scan_event_cntrl_flags(cmd, arg);
>> +
>> +	cmd->dwell_time_active = cpu_to_le32(arg->dwell_time_active);
>> +	cmd->dwell_time_active_2g = cpu_to_le32(arg->dwell_time_active_2g);
>> +	cmd->dwell_time_passive = cpu_to_le32(arg->dwell_time_passive);
>> +	cmd->dwell_time_active_6g = cpu_to_le32(arg->dwell_time_active_6g);
>> +	cmd->dwell_time_passive_6g = cpu_to_le32(arg->dwell_time_passive_6g);
>> +	cmd->min_rest_time = cpu_to_le32(arg->min_rest_time);
>> +	cmd->max_rest_time = cpu_to_le32(arg->max_rest_time);
>> +	cmd->repeat_probe_time = cpu_to_le32(arg->repeat_probe_time);
>> +	cmd->probe_spacing_time = cpu_to_le32(arg->probe_spacing_time);
>> +	cmd->idle_time = cpu_to_le32(arg->idle_time);
>> +	cmd->max_scan_time = cpu_to_le32(arg->max_scan_time);
>> +	cmd->probe_delay = cpu_to_le32(arg->probe_delay);
>> +	cmd->burst_duration = cpu_to_le32(arg->burst_duration);
>> +	cmd->num_chan = cpu_to_le32(arg->num_chan);
>> +	cmd->num_bssid = cpu_to_le32(arg->num_bssid);
>> +	cmd->num_ssids = cpu_to_le32(arg->num_ssids);
>> +	cmd->ie_len = cpu_to_le32(arg->extraie.len);
>> +	cmd->n_probes = cpu_to_le32(arg->n_probes);
>> +
>> +	ptr += sizeof(*cmd);
>> +
>> +	len = arg->num_chan * sizeof(u32);
>> +
>> +	tlv = ptr;
>> +	tlv->header = ath12k_wmi_tlv_hdr(WMI_TAG_ARRAY_UINT32, len);
>> +	ptr += TLV_HDR_SIZE;
>> +	tmp_ptr = (u32 *)ptr;
>> +
>> +	for (i = 0; i < arg->num_chan; ++i)
>> +		tmp_ptr[i] = arg->chan_list[i];
>
> nit.
> memcpy(tmp_ptr, arg->chan_list, arg->num_chan);

Heh, indeed. But we added '* 4':

memcpy(tmp_ptr, arg->chan_list, arg->num_chan * 4)

>> +int ath12k_wmi_send_scan_chan_list_cmd(struct ath12k *ar,
>> +				       struct ath12k_wmi_scan_chan_list_arg *arg)
>> +{
>> +	struct ath12k_wmi_pdev *wmi = ar->wmi;
>> +	struct wmi_scan_chan_list_cmd *cmd;
>> +	struct sk_buff *skb;
>> +	struct ath12k_wmi_channel_params *chan_info;
>> +	struct ath12k_wmi_channel_arg *channel_arg;
>> +	struct wmi_tlv *tlv;
>> +	void *ptr;
>> +	int i, ret, len;
>> +	u16 num_send_chans, num_sends = 0, max_chan_limit = 0;
>> +	__le32 *reg1, *reg2;
>> +
>> +	channel_arg = &arg->channel[0];
>> +	while (arg->nallchans) {
>> +		len = sizeof(*cmd) + TLV_HDR_SIZE;
>> +		max_chan_limit = (wmi->wmi_ab->max_msg_len[ar->pdev_idx] - len) /
>> +			sizeof(*chan_info);
>> +
>> +		if (arg->nallchans > max_chan_limit)
>> +			num_send_chans = max_chan_limit;
>> +		else
>> +			num_send_chans = arg->nallchans;
>
> num_send_chans = min(arg->nallchans, max_chan_limit);

Fixed.

>> +static void
>> +ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cfg,
>> +				struct ath12k_wmi_resource_config_arg *tg_cfg)
>> +{
>> +	wmi_cfg->num_vdevs = cpu_to_le32(tg_cfg->num_vdevs);
>> +	wmi_cfg->num_peers = cpu_to_le32(tg_cfg->num_peers);
>> +	wmi_cfg->num_offload_peers = cpu_to_le32(tg_cfg->num_offload_peers);
>> +	wmi_cfg->num_offload_reorder_buffs =
>> +		cpu_to_le32(tg_cfg->num_offload_reorder_buffs);
>> +	wmi_cfg->num_peer_keys = cpu_to_le32(tg_cfg->num_peer_keys);
>> +	wmi_cfg->num_tids = cpu_to_le32(tg_cfg->num_tids);
>> +	wmi_cfg->ast_skid_limit = cpu_to_le32(tg_cfg->ast_skid_limit);
>> +	wmi_cfg->tx_chain_mask = cpu_to_le32(tg_cfg->tx_chain_mask);
>> +	wmi_cfg->rx_chain_mask = cpu_to_le32(tg_cfg->rx_chain_mask);
>> +	wmi_cfg->rx_timeout_pri[0] = cpu_to_le32(tg_cfg->rx_timeout_pri[0]);
>> +	wmi_cfg->rx_timeout_pri[1] = cpu_to_le32(tg_cfg->rx_timeout_pri[1]);
>> +	wmi_cfg->rx_timeout_pri[2] = cpu_to_le32(tg_cfg->rx_timeout_pri[2]);
>> +	wmi_cfg->rx_timeout_pri[3] = cpu_to_le32(tg_cfg->rx_timeout_pri[3]);
>> +	wmi_cfg->rx_decap_mode = cpu_to_le32(tg_cfg->rx_decap_mode);
>> +	wmi_cfg->scan_max_pending_req = cpu_to_le32(tg_cfg->scan_max_pending_req);
>> +	wmi_cfg->bmiss_offload_max_vdev = cpu_to_le32(tg_cfg->bmiss_offload_max_vdev);
>> +	wmi_cfg->roam_offload_max_vdev = cpu_to_le32(tg_cfg->roam_offload_max_vdev);
>> +	wmi_cfg->roam_offload_max_ap_profiles =
>> +		cpu_to_le32(tg_cfg->roam_offload_max_ap_profiles);
>> +	wmi_cfg->num_mcast_groups = cpu_to_le32(tg_cfg->num_mcast_groups);
>> +	wmi_cfg->num_mcast_table_elems = cpu_to_le32(tg_cfg->num_mcast_table_elems);
>> +	wmi_cfg->mcast2ucast_mode = cpu_to_le32(tg_cfg->mcast2ucast_mode);
>> +	wmi_cfg->tx_dbg_log_size = cpu_to_le32(tg_cfg->tx_dbg_log_size);
>> +	wmi_cfg->num_wds_entries = cpu_to_le32(tg_cfg->num_wds_entries);
>> +	wmi_cfg->dma_burst_size = cpu_to_le32(tg_cfg->dma_burst_size);
>> +	wmi_cfg->mac_aggr_delim = cpu_to_le32(tg_cfg->mac_aggr_delim);
>> +	wmi_cfg->rx_skip_defrag_timeout_dup_detection_check =
>> +		cpu_to_le32(tg_cfg->rx_skip_defrag_timeout_dup_detection_check);
>> +	wmi_cfg->vow_config = cpu_to_le32(tg_cfg->vow_config);
>> +	wmi_cfg->gtk_offload_max_vdev = cpu_to_le32(tg_cfg->gtk_offload_max_vdev);
>> +	wmi_cfg->num_msdu_desc = cpu_to_le32(tg_cfg->num_msdu_desc);
>> +	wmi_cfg->max_frag_entries = cpu_to_le32(tg_cfg->max_frag_entries);
>> +	wmi_cfg->num_tdls_vdevs = cpu_to_le32(tg_cfg->num_tdls_vdevs);
>> +	wmi_cfg->num_tdls_conn_table_entries =
>> +		cpu_to_le32(tg_cfg->num_tdls_conn_table_entries);
>> +	wmi_cfg->beacon_tx_offload_max_vdev =
>> +		cpu_to_le32(tg_cfg->beacon_tx_offload_max_vdev);
>> +	wmi_cfg->num_multicast_filter_entries =
>> +		cpu_to_le32(tg_cfg->num_multicast_filter_entries);
>> +	wmi_cfg->num_wow_filters = cpu_to_le32(tg_cfg->num_wow_filters);
>> +	wmi_cfg->num_keep_alive_pattern = cpu_to_le32(tg_cfg->num_keep_alive_pattern);
>> + wmi_cfg->keep_alive_pattern_size =
>> cpu_to_le32(tg_cfg->keep_alive_pattern_size);
>> +	wmi_cfg->max_tdls_concurrent_sleep_sta =
>> +		cpu_to_le32(tg_cfg->max_tdls_concurrent_sleep_sta);
>> +	wmi_cfg->max_tdls_concurrent_buffer_sta =
>> +		cpu_to_le32(tg_cfg->max_tdls_concurrent_buffer_sta);
>> +	wmi_cfg->wmi_send_separate = cpu_to_le32(tg_cfg->wmi_send_separate);
>> +	wmi_cfg->num_ocb_vdevs = cpu_to_le32(tg_cfg->num_ocb_vdevs);
>> +	wmi_cfg->num_ocb_channels = cpu_to_le32(tg_cfg->num_ocb_channels);
>> +	wmi_cfg->num_ocb_schedules = cpu_to_le32(tg_cfg->num_ocb_schedules);
>> +	wmi_cfg->bpf_instruction_size = cpu_to_le32(tg_cfg->bpf_instruction_size);
>> +	wmi_cfg->max_bssid_rx_filters = cpu_to_le32(tg_cfg->max_bssid_rx_filters);
>> +	wmi_cfg->use_pdev_id = cpu_to_le32(tg_cfg->use_pdev_id);
>> +	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config);
>> +	wmi_cfg->peer_map_unmap_version = cpu_to_le32(tg_cfg->peer_map_unmap_version);
>> +	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
>> +	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
>> +	wmi_cfg->twt_ap_sta_count = cpu_to_le32(tg_cfg->twt_ap_sta_count);
>> +	wmi_cfg->host_service_flags |=
>> +		cpu_to_le32(1 << WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT);
>
> Why not just '=' instead of '|=' ?

Fixed.

>> +int ath12k_wmi_pdev_lro_cfg(struct ath12k *ar,
>> +			    int pdev_id)
>> +{
>> +	struct ath12k_wmi_pdev_lro_config_cmd *cmd;
>> +	struct sk_buff *skb;
>> +	int ret;
>> +
>> +	skb = ath12k_wmi_alloc_skb(ar->wmi->wmi_ab, sizeof(*cmd));
>> +	if (!skb)
>> +		return -ENOMEM;
>> +
>> +	cmd = (struct ath12k_wmi_pdev_lro_config_cmd *)skb->data;
>> +	cmd->tlv_header = ath12k_wmi_tlv_cmd_hdr(WMI_TAG_LRO_INFO_CMD,
>> +						 sizeof(*cmd));
>> +
>> +	get_random_bytes(cmd->th_4, sizeof(uint32_t) * ATH12K_IPV4_TH_SEED_SIZE);
>> +	get_random_bytes(cmd->th_6, sizeof(uint32_t) * ATH12K_IPV6_TH_SEED_SIZE);
>
> get_random_bytes(cmd->th_4, sizeof(cmd->th_4));
> get_random_bytes(cmd->th_6, sizeof(cmd->th_6));

Fixed.

>> +static int ath12k_wmi_hw_mode_caps_parse(struct ath12k_base *soc,
>> +					 u16 tag, u16 len,
>> +					 const void *ptr, void *data)
>> +{
>> +	struct ath12k_wmi_svc_rdy_ext_parse *svc_rdy_ext = data;
>> +	struct ath12k_wmi_hw_mode_cap_params *hw_mode_cap;
>> +	u32 phy_map = 0;
>> +
>> +	if (tag != WMI_TAG_HW_MODE_CAPABILITIES)
>> +		return -EPROTO;
>> +
>> +	if (svc_rdy_ext->n_hw_mode_caps >= svc_rdy_ext->arg.num_hw_modes)
>> +		return -ENOBUFS;
>> +
>> +	hw_mode_cap = container_of(ptr, struct ath12k_wmi_hw_mode_cap_params,
>> +				   hw_mode_id);
>> +	svc_rdy_ext->n_hw_mode_caps++;
>> +
>> +	phy_map = le32_to_cpu(hw_mode_cap->phy_id_map);
>> +	while (phy_map) {
>> +		svc_rdy_ext->tot_phy_id++;
>> +		phy_map = phy_map >> 1;
>> +	}
>
> svc_rdy_ext->tot_phy_id = fls(phy_map);
> or
> svc_rdy_ext->tot_phy_id += fls(phy_map);

We chose the latter:

	phy_map = le32_to_cpu(hw_mode_cap->phy_id_map);
	svc_rdy_ext->tot_phy_id += fls(phy_map);

>> +static int ath12k_wmi_hw_mode_caps(struct ath12k_base *soc,
>> +				   u16 len, const void *ptr, void *data)
>> +{
>> +	struct ath12k_wmi_svc_rdy_ext_parse *svc_rdy_ext = data;
>> +	const struct ath12k_wmi_hw_mode_cap_params *hw_mode_caps;
>> +	enum wmi_host_hw_mode_config_type mode, pref;
>> +	u32 i;
>> +	int ret;
>> +
>> +	svc_rdy_ext->n_hw_mode_caps = 0;
>> +	svc_rdy_ext->hw_mode_caps = ptr;
>> +
>> +	ret = ath12k_wmi_tlv_iter(soc, ptr, len,
>> +				  ath12k_wmi_hw_mode_caps_parse,
>> +				  svc_rdy_ext);
>> +	if (ret) {
>> +		ath12k_warn(soc, "failed to parse tlv %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	i = 0;
>> +	while (i < svc_rdy_ext->n_hw_mode_caps) {
>
> for (i = 0; i < svc_rdy_ext->n_hw_mode_caps; i++) {

Fixed.

>> +		hw_mode_caps = &svc_rdy_ext->hw_mode_caps[i];
>> +		mode = le32_to_cpu(hw_mode_caps->hw_mode_id);
>> +		pref = soc->wmi_ab.preferred_hw_mode;
>> +
>> +		if (ath12k_hw_mode_pri_map[mode] < ath12k_hw_mode_pri_map[pref]) {
>> +			svc_rdy_ext->pref_hw_mode_caps = *hw_mode_caps;
>> +			soc->wmi_ab.preferred_hw_mode = mode;
>> +		}
>> +		i++;
>
> With 'for', remove this i++.

Done.

>> +static int ath12k_wmi_ext_hal_reg_caps(struct ath12k_base *soc,
>> +				       u16 len, const void *ptr, void *data)
>> +{
>> +	struct ath12k_wmi_pdev *wmi_handle = &soc->wmi_ab.wmi[0];
>> +	struct ath12k_wmi_svc_rdy_ext_parse *svc_rdy_ext = data;
>> +	struct ath12k_wmi_hal_reg_capabilities_ext_arg reg_cap;
>> +	int ret;
>> +	u32 i;
>> +
>> +	svc_rdy_ext->n_ext_hal_reg_caps = 0;
>> +	svc_rdy_ext->ext_hal_reg_caps = ptr;
>> +	ret = ath12k_wmi_tlv_iter(soc, ptr, len,
>> +				  ath12k_wmi_ext_hal_reg_caps_parse,
>> +				  svc_rdy_ext);
>> +	if (ret) {
>> +		ath12k_warn(soc, "failed to parse tlv %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < svc_rdy_ext->arg.num_phy; i++) {
>> +		ret = ath12k_pull_reg_cap_svc_rdy_ext(wmi_handle,
>> +						      svc_rdy_ext->soc_hal_reg_caps,
>> + svc_rdy_ext->ext_hal_reg_caps, i,
>> +						      &reg_cap);
>> +		if (ret) {
>> +			ath12k_warn(soc, "failed to extract reg cap %d\n", i);
>> +			return ret;
>> +		}
>> +
>> +		memcpy(&soc->hal_reg_cap[reg_cap.phy_id],
>> +		       &reg_cap, sizeof(reg_cap));
>
> soc->hal_reg_cap[reg_cap.phy_id] = reg_cap;

Fixed.

>> +static int ath12k_reg_chan_list_event(struct ath12k_base *ab, struct sk_buff *skb)
>> +{
>
> [...]
>
>> +
>> +	/* Avoid multiple overwrites to default regd, during core
>> +	 * stop-start after mac registration.
>> +	 */
>> +	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
>> +	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
>> +		    (char *)reg_info->alpha2, 2))
>
> cast "(char *)" is unnecessary.

Fixed.

>> +		goto mem_free;
>> +
>> +	/* Intersect new rules with default regd if a new country setting was
>> +	 * requested, i.e a default regd was already set during initialization
>> +	 * and the regd coming from this event has a valid country info.
>> +	 */
>
> [...]
>
>> +
>> +static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
>> +{
>
> [...]
>
>> +
>> +	if ((test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) ||
>> +	    (rx_ev.status & (WMI_RX_STATUS_ERR_DECRYPT |
>> +	    WMI_RX_STATUS_ERR_KEY_CACHE_MISS | WMI_RX_STATUS_ERR_CRC))) {
>
> nit: coding style
>
> 	if ((test_bit(ATH12K_CAC_RUNNING, &ar->dev_flags)) ||
> 	    (rx_ev.status & (WMI_RX_STATUS_ERR_DECRYPT |
> 			     WMI_RX_STATUS_ERR_KEY_CACHE_MISS |
> 			     WMI_RX_STATUS_ERR_CRC))) {

Fixed.

>> +static int ath12k_connect_pdev_htc_service(struct ath12k_base *ab,
>> +					   u32 pdev_idx)
>> +{
>> +	int status;
>> +	u32 svc_id[] = { ATH12K_HTC_SVC_ID_WMI_CONTROL,
>> +			 ATH12K_HTC_SVC_ID_WMI_CONTROL_MAC1,
>> +			 ATH12K_HTC_SVC_ID_WMI_CONTROL_MAC2 };
>> +
>
> nit.
> coding style: no blank line within declaration.

Fixed.

Thank you very much for the good comments!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
