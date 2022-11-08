Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2676213FB
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 14:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234804AbiKHN4B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 08:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiKHN4A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 08:56:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE523F4F
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 05:55:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61960B81AF2
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 13:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A94DC433D6;
        Tue,  8 Nov 2022 13:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667915756;
        bh=8EgEva8SGwONgvqVF+oT5XZ1onQ/RUXXCy8m098YtaI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=eyAq4xYFytIpU+xLpuIfvcK67wNFwlAnyur7FJsYZ/zKCIXBtgozt8CbstVf8SKWB
         Lu+0Mpp2EnFgYqxvGpjpdn2r47A6/VUci5czcSWGxLUGDDycsSTPSN0Zd/p51tYDVa
         k/+1rbaWtWJypv9XM9uGjWNrlfAAYQ91xBKoqCGrWTDNxaAaRFW9gKYvqGdSvXTUs/
         HPEtrq7BDyEuPYoJlYpul6ODt6T+fIE54RCOLj5tMktaJzcdTvrDD6t858NqcBh6Ro
         W18wp4RlHq2D6HHYJW9+6hI0unP3bqx94ZTPKXiO5Jq4SnTPI5Nh+zlv1mldPE2ZUp
         0B799gx8ohaVg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
Subject: Re: [PATCH 31/50] wifi: ath12k: add mac.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-32-kvalo@kernel.org>
        <1a043aac-c160-c826-3933-99dbe3bb18fe@quicinc.com>
Date:   Tue, 08 Nov 2022 15:55:50 +0200
In-Reply-To: <1a043aac-c160-c826-3933-99dbe3bb18fe@quicinc.com> (Jeff
        Johnson's message of "Tue, 16 Aug 2022 11:09:49 -0700")
Message-ID: <87leoleejd.fsf@kernel.org>
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

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 8/12/2022 9:09 AM, Kalle Valo wrote:
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>>
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>>
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/mac.c | 7054 +++++++++++++++++++++++++++++++++
>>   1 file changed, 7054 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c
>> b/drivers/net/wireless/ath/ath12k/mac.c
>> new file mode 100644
>> index 000000000000..2ccbd83dc9ca
>> --- /dev/null
>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>
> snip
>
>> +u8 ath12k_mac_bw_to_mac80211_bw(u8 bw)
>
> should the input param be of type enum ath12k_supported_bw to better
> describe it? should the function return type be enum rate_info_bw to
> better describe it?

Fixed.

>
>> +{
>> +	u8 ret = 0;
>
> change to use RATE_INFO_BW_20?

Fixed.

>> +static u8 ath12k_parse_mpdudensity(u8 mpdudensity)
>> +{
>> +/* 802.11n D2.0 defined values for "Minimum MPDU Start Spacing":
>
> nit: use an up-to-date reference?

Fixed.

>> +static int ath12k_recalc_rtscts_prot(struct ath12k_vif *arvif)
>> +{
>> +	struct ath12k *ar = arvif->ar;
>> +	u32 vdev_param, rts_cts = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +static int ath12k_monitor_vdev_up(struct ath12k *ar, int vdev_id)
>> +{
>> +	int ret = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +static int ath12k_mac_monitor_vdev_start(struct ath12k *ar, int vdev_id,
>> +					 struct cfg80211_chan_def *chandef)
>> +{
>> +	struct ieee80211_channel *channel = NULL;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +	struct wmi_vdev_start_req_arg arg = {};
>> +	int ret = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +static int ath12k_mac_monitor_vdev_stop(struct ath12k *ar)
>> +{
>> +	int ret = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
>> +{
>> +	struct ath12k_pdev *pdev = ar->pdev;
>> +	struct ath12k_wmi_vdev_create_arg arg = {};
>> +	int bit, ret = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +	u8 tmp_addr[6] = {0};
>> +	u16 nss = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed as well.

>> +static int ath12k_mac_monitor_vdev_delete(struct ath12k *ar)
>> +{
>> +	int ret = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +	unsigned long time_left = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +static void ath12k_control_beaconing(struct ath12k_vif *arvif,
>> +				     struct ieee80211_bss_conf *info)
>> +{
>> +	struct ath12k *ar = arvif->ar;
>> +	int ret = 0;
>
> nit: unnecessary initializer that is always overwritten

Fixed.

>> +
>> +	lockdep_assert_held(&arvif->ar->conf_mutex);
>> +
>> +	if (!info->enable_beacon) {
>> +		ret = ath12k_wmi_vdev_down(ar, arvif->vdev_id);
>> +		if (ret)
>> +			ath12k_warn(ar->ab, "failed to down vdev_id %i: %d\n",
>> +				    arvif->vdev_id, ret);
>> +
>> +		arvif->is_up = false;
>> +		return;
>> +	}
>> +
>> +	/* Install the beacon template to the FW */
>> +	ret = ath12k_mac_setup_bcn_tmpl(arvif);
>> +	if (ret) {
>> +		ath12k_warn(ar->ab, "failed to update bcn tmpl during vdev up: %d\n",
>> +			    ret);
>> +		return;
>> +	}
>> +
>> +	arvif->tx_seq_no = 0x1000;
>
> why this magic number?

Ramya removed the initialisation in commit:

640978f9fb1f wifi: ath12k: Fix typo and initializer in mac.c

But the unused field is still in struct ath12k_vif, I added that to todo
list.

>> +static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
>> +				    struct ieee80211_vif *vif,
>> +				    struct ieee80211_sta *sta,
>> +				    struct ath12k_wmi_peer_assoc_arg *arg)
>> +{
>
> snip
>
>> +	/* In IPQ8074 platform, VHT mcs rate 10 and 11 is enabled by default.
>> +	 * VHT mcs rate 10 and 11 is not suppoerted in 11ac standard.
>
> typo: s/suppoerted/supported/

Fixed.

> bigger question: why concern about IPQ8074 when this driver isn't for
> that platform

This was changed to QCN9274.

>> +static void ath12k_peer_assoc_h_he(struct ath12k *ar,
>> +				   struct ieee80211_vif *vif,
>> +				   struct ieee80211_sta *sta,
>> +				   struct ath12k_wmi_peer_assoc_arg *arg)
>> +{
>
> snip
>
>> +	/* As per section 26.6.1 11ax Draft5.0, if the Max AMPDU Exponent Extension
>
> nit: get an up-to-date reference?

Fixed.

>> +static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
>> +					   struct ieee80211_vif *vif,
>> +					   struct ieee80211_bss_conf *info,
>> +					   u64 changed)
>> +{
>> +	struct ath12k *ar = hw->priv;
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	struct cfg80211_chan_def def;
>> +	u32 param_id, param_value;
>> +	enum nl80211_band band;
>> +	u32 vdev_param;
>> +	int mcast_rate;
>> +	u32 preamble;
>> +	u16 hw_value;
>> +	u16 bitrate;
>> +	int ret = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
>> +				 struct ieee80211_vif *vif,
>> +				 struct ieee80211_scan_request *hw_req)
>> +{
>> +	struct ath12k *ar = hw->priv;
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	struct cfg80211_scan_request *req = &hw_req->req;
>> +	struct ath12k_wmi_scan_req_arg arg = {};
>> +	int ret = 0;
>
> nit: unnecessary initializer since this is set in all cases of switch
> (ar->scan.state)

Fixed.

>> +	ret = ath12k_start_scan(ar, &arg);
>> +	if (ret) {
>> +		ath12k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
>> +		spin_lock_bh(&ar->data_lock);
>> +		ar->scan.state = ATH12K_SCAN_IDLE;
>> +		spin_unlock_bh(&ar->data_lock);
>> +	}
>> +
>> +	/* Add a 200ms margin to account for event/command processing */
>
> nit: remove 200ms from the comment. the value of the macro will be the
> actual value, and values in comments like this tend to get out of sync
> with the macros over time

Indeed, fixed.

>> +static int ath12k_station_assoc(struct ath12k *ar,
>> +				struct ieee80211_vif *vif,
>> +				struct ieee80211_sta *sta,
>> +				bool reassoc)
>> +{
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	struct ath12k_wmi_peer_assoc_arg peer_arg;
>> +	int ret = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +static int ath12k_station_disassoc(struct ath12k *ar,
>> +				   struct ieee80211_vif *vif,
>> +				   struct ieee80211_sta *sta)
>> +{
>> +	struct ath12k_vif *arvif = (void *)vif->drv_priv;
>> +	int ret = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
>> +				       struct ieee80211_vif *vif,
>> +				       struct ieee80211_sta *sta)
>> +{
>> +	struct ath12k *ar = hw->priv;
>> +	struct ath12k_vif *arvif = (void *)vif->drv_priv;
>> +	int ret = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +static int ath12k_conf_tx_uapsd(struct ath12k *ar, struct ieee80211_vif *vif,
>> +				u16 ac, bool enable)
>> +{
>> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
>> +	u32 value = 0;
>> +	int ret = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +static int ath12k_mac_set_txbf_conf(struct ath12k_vif *arvif)
>> +{
>
> snip
>
>> +	/* TODO: SUBFEE not validated in HK, disable here until validated? */
>
> nit: remove cryptic reference?

Fixed.

>> +static void ath12k_set_vht_txbf_cap(struct ath12k *ar, u32 *vht_cap)
>> +{
>> +	bool subfer, subfee;
>> +	int sound_dim = 0;
>> +
>> +	subfer = !!(*vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
>> +	subfee = !!(*vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
>> +
>> +	if (ar->num_tx_chains < 2) {
>> +		*vht_cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
>> +		subfer = false;
>> +	}
>> +
>> +	/* If SU Beaformer is not set, then disable MU Beamformer Capability */
>> +	if (!subfer)
>> +		*vht_cap &= ~(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
>> +
>> +	/* If SU Beaformee is not set, then disable MU Beamformee Capability */
>> +	if (!subfee)
>> +		*vht_cap &= ~(IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
>> +
>> +	sound_dim = (*vht_cap & IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK);
>> +	sound_dim >>= IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT;
>> +	*vht_cap &= ~IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK;
>
> use bitops?

Indeed, added to todo.

>> +static int ath12k_mac_vif_txmgmt_idr_remove(int buf_id, void *skb, void *ctx)
>> +{
>> +	struct ieee80211_vif *vif = ctx;
>> +	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB((struct sk_buff *)skb);
>
> nit: unnecessary typecast from void *?

Fixed.

>> +static u32
>> +ath12k_mac_prepare_he_mode(struct ath12k_pdev *pdev, u32 viftype)
>> +{
>> +	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
>> +	struct ath12k_band_cap *cap_band = NULL;
>> +	u32 *hecap_phy_ptr = NULL;
>> +	u32 hemode = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +static int ath12k_set_he_mu_sounding_mode(struct ath12k *ar,
>> +					  struct ath12k_vif *arvif)
>> +{
>> +	u32 param_id, param_value;
>> +	struct ath12k_base *ab = ar->ab;
>> +	int ret = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
>> +					   unsigned int changed_flags,
>> +					   unsigned int *total_flags,
>> +					   u64 multicast)
>> +{
>> +	struct ath12k *ar = hw->priv;
>> +	bool reset_flag = false;
>
> nit: unnecessary initializer?

Fixed.

>
>> +	int ret = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
>> +			      const struct cfg80211_chan_def *chandef,
>> +			      bool restart)
>> +{
>> +	struct ath12k *ar = arvif->ar;
>> +	struct ath12k_base *ab = ar->ab;
>> +	struct wmi_vdev_start_req_arg arg = {};
>> +	int he_support = arvif->vif->bss_conf.he_support;
>> +	int ret = 0;
>
> nit: unnecessary initializer?

Fixed.

>> +static int
>> +ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
>> +				 struct ieee80211_vif *vif,
>> +				 struct ieee80211_bss_conf *link_conf,
>> +				 struct ieee80211_chanctx_conf *ctx)
>> +{
>
> snip
>
>> +	ret = ath12k_mac_vdev_start(arvif, &ctx->def);
>> +	if (ret) {
>> +		ath12k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
>> +			    arvif->vdev_id, vif->addr,
>> +			    ctx->def.chan->center_freq, ret);
>> +		goto out;
>> +	}
>> +
>> +	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR && ar->monitor_vdev_created)
>> +		ath12k_mac_monitor_start(ar);
>> +
>> +	arvif->is_started = true;
>> +
>> +	/* TODO: Setup ps and cts/rts protection */
>> +
>> +	ret = 0;
>
> unnecessary assignment -- already set from ath12k_mac_vdev_start()

Fixed.

> rest snipped. hard to review such a long file :P

Indeed, mac.c is 7000 lines long. We should consider refactoring it to
smaller files at some point.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
