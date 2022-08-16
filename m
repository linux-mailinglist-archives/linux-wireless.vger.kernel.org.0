Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF641596211
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 20:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiHPSLY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiHPSLE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 14:11:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D286060
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 11:10:00 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27GGGmJh017770;
        Tue, 16 Aug 2022 18:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8DTBfrZmcQs+AsjSs7g+kRFoT/2cFnBMBWKc2U65Rqo=;
 b=UpSZYrCJo3hiCxrvkYWce5UKZb8deBlrLXYbtP9ICZMlDKtf1hG7abWXMxYvj86Wj2sA
 8gOicZ1ScdtekRiVVZVoL2fWykMGJCIa3ZKkxKCrxgrYvj7KcVgIWLvBi47u3j08nfdS
 NnhHUPfd/tTXdwwoWCLZ9NNl3Hs3XCo1ekzNI7J9f4l70LsKpJySWWGmsHpfy5Hw70In
 gZBGJJngAmQdmDOvnd5ei85eH169Nd0cwo/gC7WPj37ZlkfBzWD0COastVLj9zmMyyfx
 K7dmUP0NIJPqTl+Nk0pF+v+uNjDTGh74Rki9SyUNNCZ+xKFrtSadL80EQC+/A92KcWmb lw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j08m2hsdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 18:09:51 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.47.97.222])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27GI9o2N010259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 18:09:51 GMT
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 16 Aug 2022 11:09:50 -0700
Received: from [10.110.78.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 16 Aug
 2022 11:09:49 -0700
Message-ID: <1a043aac-c160-c826-3933-99dbe3bb18fe@quicinc.com>
Date:   Tue, 16 Aug 2022 11:09:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 31/50] wifi: ath12k: add mac.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-32-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-32-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j4woF0MYvbwjOhNheXuwNEYZYoOKgsLz
X-Proofpoint-ORIG-GUID: j4woF0MYvbwjOhNheXuwNEYZYoOKgsLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_08,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/12/2022 9:09 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/mac.c | 7054 +++++++++++++++++++++++++++++++++
>   1 file changed, 7054 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> new file mode 100644
> index 000000000000..2ccbd83dc9ca
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath12k/mac.c

snip

> +u8 ath12k_mac_bw_to_mac80211_bw(u8 bw)

should the input param be of type enum ath12k_supported_bw to better 
describe it?
should the function return type be enum rate_info_bw to better describe it?

> +{
> +	u8 ret = 0;

change to use RATE_INFO_BW_20?

> +
> +	switch (bw) {
> +	case ATH12K_BW_20:
> +		ret = RATE_INFO_BW_20;
> +		break;
> +	case ATH12K_BW_40:
> +		ret = RATE_INFO_BW_40;
> +		break;
> +	case ATH12K_BW_80:
> +		ret = RATE_INFO_BW_80;
> +		break;
> +	case ATH12K_BW_160:
> +		ret = RATE_INFO_BW_160;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw bw)

correctly used the enums here :)

> +{
> +	switch (bw) {
> +	case RATE_INFO_BW_20:
> +		return ATH12K_BW_20;
> +	case RATE_INFO_BW_40:
> +		return ATH12K_BW_40;
> +	case RATE_INFO_BW_80:
> +		return ATH12K_BW_80;
> +	case RATE_INFO_BW_160:
> +		return ATH12K_BW_160;
> +	default:
> +		return ATH12K_BW_20;
> +	}
> +}

snip

> +static u8 ath12k_parse_mpdudensity(u8 mpdudensity)
> +{
> +/* 802.11n D2.0 defined values for "Minimum MPDU Start Spacing":

nit: use an up-to-date reference?

snip

> +static int ath12k_recalc_rtscts_prot(struct ath12k_vif *arvif)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	u32 vdev_param, rts_cts = 0;

nit: unnecessary initializer that is always overwritten

> +	int ret;
> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	vdev_param = WMI_VDEV_PARAM_ENABLE_RTSCTS;
> +
> +	/* Enable RTS/CTS protection for sw retries (when legacy stations
> +	 * are in BSS) or by default only for second rate series.
> +	 * TODO: Check if we need to enable CTS 2 Self in any case
> +	 */
> +	rts_cts = WMI_USE_RTS_CTS;

always set here

snip

> +static int ath12k_monitor_vdev_up(struct ath12k *ar, int vdev_id)
> +{
> +	int ret = 0;

nit: unnecessary initializer that is always overwritten

> +
> +	ret = ath12k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);

snip

> +static int ath12k_mac_monitor_vdev_start(struct ath12k *ar, int vdev_id,
> +					 struct cfg80211_chan_def *chandef)
> +{
> +	struct ieee80211_channel *channel = NULL;

nit: unnecessary initializer that is always overwritten

> +	struct wmi_vdev_start_req_arg arg = {};
> +	int ret = 0;

nit: unnecessary initializer that is always overwritten

> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	channel = chandef->chan;
> +	arg.vdev_id = vdev_id;
> +	arg.freq = channel->center_freq;
> +	arg.band_center_freq1 = chandef->center_freq1;
> +	arg.band_center_freq2 = chandef->center_freq2;
> +	arg.mode = ath12k_phymodes[chandef->chan->band][chandef->width];
> +	arg.chan_radar = !!(channel->flags & IEEE80211_CHAN_RADAR);
> +
> +	arg.min_power = 0;
> +	arg.max_power = channel->max_power;
> +	arg.max_reg_power = channel->max_reg_power;
> +	arg.max_antenna_gain = channel->max_antenna_gain;
> +
> +	arg.pref_tx_streams = ar->num_tx_chains;
> +	arg.pref_rx_streams = ar->num_rx_chains;
> +
> +	arg.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
> +
> +	reinit_completion(&ar->vdev_setup_done);
> +	reinit_completion(&ar->vdev_delete_done);
> +
> +	ret = ath12k_wmi_vdev_start(ar, &arg, false);

snip

> +static int ath12k_mac_monitor_vdev_stop(struct ath12k *ar)
> +{
> +	int ret = 0;

nit: unnecessary initializer that is always overwritten

> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	reinit_completion(&ar->vdev_setup_done);
> +
> +	ret = ath12k_wmi_vdev_stop(ar, ar->monitor_vdev_id);

snip

> +static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
> +{
> +	struct ath12k_pdev *pdev = ar->pdev;
> +	struct ath12k_wmi_vdev_create_arg arg = {};
> +	int bit, ret = 0;

nit: unnecessary initializer that is always overwritten

> +	u8 tmp_addr[6] = {0};
> +	u16 nss = 0;

nit: unnecessary initializer that is always overwritten

> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	if (ar->monitor_vdev_created)
> +		return 0;
> +
> +	if (ar->ab->free_vdev_map == 0) {
> +		ath12k_warn(ar->ab, "failed to find free vdev id for monitor vdev\n");
> +		return -ENOMEM;
> +	}
> +
> +	bit = __ffs64(ar->ab->free_vdev_map);
> +
> +	ar->monitor_vdev_id = bit;
> +
> +	arg.if_id = ar->monitor_vdev_id;
> +	arg.type = WMI_VDEV_TYPE_MONITOR;
> +	arg.subtype = WMI_VDEV_SUBTYPE_NONE;
> +	arg.pdev_id = pdev->pdev_id;
> +	arg.if_stats_id = ATH12K_INVAL_VDEV_STATS_ID;
> +
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
> +		arg.chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
> +		arg.chains[NL80211_BAND_2GHZ].rx = ar->num_rx_chains;
> +	}
> +
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP) {
> +		arg.chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
> +		arg.chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
> +	}
> +
> +	ret = ath12k_wmi_vdev_create(ar, tmp_addr, &arg);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to request monitor vdev %i creation: %d\n",
> +			    ar->monitor_vdev_id, ret);
> +		ar->monitor_vdev_id = -1;
> +		return ret;
> +	}
> +
> +	nss = get_num_chains(ar->cfg_tx_chainmask) ? : 1;

snip

> +static int ath12k_mac_monitor_vdev_delete(struct ath12k *ar)
> +{
> +	int ret = 0;

nit: unnecessary initializer that is always overwritten

> +	unsigned long time_left = 0;

nit: unnecessary initializer that is always overwritten

> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	if (!ar->monitor_vdev_created)
> +		return 0;
> +
> +	reinit_completion(&ar->vdev_delete_done);
> +
> +	ret = ath12k_wmi_vdev_delete(ar, ar->monitor_vdev_id);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to request wmi monitor vdev %i removal: %d\n",
> +			    ar->monitor_vdev_id, ret);
> +		return ret;
> +	}
> +
> +	time_left = wait_for_completion_timeout(&ar->vdev_delete_done,
> +						ATH12K_VDEV_DELETE_TIMEOUT_HZ);

snip

> +static void ath12k_control_beaconing(struct ath12k_vif *arvif,
> +				     struct ieee80211_bss_conf *info)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	int ret = 0;

nit: unnecessary initializer that is always overwritten

> +
> +	lockdep_assert_held(&arvif->ar->conf_mutex);
> +
> +	if (!info->enable_beacon) {
> +		ret = ath12k_wmi_vdev_down(ar, arvif->vdev_id);
> +		if (ret)
> +			ath12k_warn(ar->ab, "failed to down vdev_id %i: %d\n",
> +				    arvif->vdev_id, ret);
> +
> +		arvif->is_up = false;
> +		return;
> +	}
> +
> +	/* Install the beacon template to the FW */
> +	ret = ath12k_mac_setup_bcn_tmpl(arvif);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to update bcn tmpl during vdev up: %d\n",
> +			    ret);
> +		return;
> +	}
> +
> +	arvif->tx_seq_no = 0x1000;

why this magic number?

> +
> +	arvif->aid = 0;
> +
> +	ether_addr_copy(arvif->bssid, info->bssid);
> +
> +	ret = ath12k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
> +				 arvif->bssid);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
> +			    arvif->vdev_id, ret);
> +		return;
> +	}
> +
> +	arvif->is_up = true;
> +
> +	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d up\n", arvif->vdev_id);
> +}

snip

> +static void ath12k_peer_assoc_h_vht(struct ath12k *ar,
> +				    struct ieee80211_vif *vif,
> +				    struct ieee80211_sta *sta,
> +				    struct ath12k_wmi_peer_assoc_arg *arg)
> +{

snip

> +	/* In IPQ8074 platform, VHT mcs rate 10 and 11 is enabled by default.
> +	 * VHT mcs rate 10 and 11 is not suppoerted in 11ac standard.

typo: s/suppoerted/supported/

bigger question: why concern about IPQ8074 when this driver isn't for 
that platform


> +	 * so explicitly disable the VHT MCS rate 10 and 11 in 11ac mode.
> +	 */

snip

> +static void ath12k_peer_assoc_h_he(struct ath12k *ar,
> +				   struct ieee80211_vif *vif,
> +				   struct ieee80211_sta *sta,
> +				   struct ath12k_wmi_peer_assoc_arg *arg)
> +{

snip

> +	/* As per section 26.6.1 11ax Draft5.0, if the Max AMPDU Exponent Extension

nit: get an up-to-date reference?

> +	 * in HE cap is zero, use the arg->peer_max_mpdu as calculated while parsing
> +	 * VHT caps(if VHT caps is present) or HT caps (if VHT caps is not present).
> +	 *
> +	 * For non-zero value of Max AMPDU Extponent Extension in HE MAC caps,
> +	 * if a HE STA sends VHT cap and HE cap IE in assoc request then, use
> +	 * MAX_AMPDU_LEN_FACTOR as 20 to calculate max_ampdu length.
> +	 * If a HE STA that does not send VHT cap, but HE and HT cap in assoc
> +	 * request, then use MAX_AMPDU_LEN_FACTOR as 16 to calculate max_ampdu
> +	 * length.
> +	 */

snip

> +static void ath12k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
> +					   struct ieee80211_vif *vif,
> +					   struct ieee80211_bss_conf *info,
> +					   u64 changed)
> +{
> +	struct ath12k *ar = hw->priv;
> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +	struct cfg80211_chan_def def;
> +	u32 param_id, param_value;
> +	enum nl80211_band band;
> +	u32 vdev_param;
> +	int mcast_rate;
> +	u32 preamble;
> +	u16 hw_value;
> +	u16 bitrate;
> +	int ret = 0;
nit: unnecessary initializer?

snip

> +static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
> +				 struct ieee80211_vif *vif,
> +				 struct ieee80211_scan_request *hw_req)
> +{
> +	struct ath12k *ar = hw->priv;
> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +	struct cfg80211_scan_request *req = &hw_req->req;
> +	struct ath12k_wmi_scan_req_arg arg = {};
> +	int ret = 0;

nit: unnecessary initializer since this is set in all cases of switch 
(ar->scan.state)

> +	int i;
> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	spin_lock_bh(&ar->data_lock);
> +	switch (ar->scan.state) {
> +	case ATH12K_SCAN_IDLE:
> +		reinit_completion(&ar->scan.started);
> +		reinit_completion(&ar->scan.completed);
> +		ar->scan.state = ATH12K_SCAN_STARTING;
> +		ar->scan.is_roc = false;
> +		ar->scan.vdev_id = arvif->vdev_id;
> +		ret = 0;
> +		break;
> +	case ATH12K_SCAN_STARTING:
> +	case ATH12K_SCAN_RUNNING:
> +	case ATH12K_SCAN_ABORTING:
> +		ret = -EBUSY;
> +		break;
> +	}
> +	spin_unlock_bh(&ar->data_lock);
> +
> +	if (ret)
> +		goto exit;
> +
> +	ath12k_wmi_start_scan_init(ar, &arg);
> +	arg.vdev_id = arvif->vdev_id;
> +	arg.scan_id = ATH12K_SCAN_ID;
> +
> +	if (req->ie_len) {
> +		arg.extraie.len = req->ie_len;
> +		arg.extraie.ptr = kzalloc(req->ie_len, GFP_KERNEL);
> +		memcpy(arg.extraie.ptr, req->ie, req->ie_len);
> +	}
> +
> +	if (req->n_ssids) {
> +		arg.num_ssids = req->n_ssids;
> +		for (i = 0; i < arg.num_ssids; i++)
> +			arg.ssid[i] = req->ssids[i];
> +	} else {
> +		arg.scan_flags |= WMI_SCAN_FLAG_PASSIVE;
> +	}
> +
> +	if (req->n_channels) {
> +		arg.num_chan = req->n_channels;
> +		for (i = 0; i < arg.num_chan; i++)
> +			arg.chan_list[i] = req->channels[i]->center_freq;
> +	}
> +
> +	ret = ath12k_start_scan(ar, &arg);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
> +		spin_lock_bh(&ar->data_lock);
> +		ar->scan.state = ATH12K_SCAN_IDLE;
> +		spin_unlock_bh(&ar->data_lock);
> +	}
> +
> +	/* Add a 200ms margin to account for event/command processing */

nit: remove 200ms from the comment. the value of the macro will be the 
actual value, and values in comments like this tend to get out of sync 
with the macros over time

> +	ieee80211_queue_delayed_work(ar->hw, &ar->scan.timeout,
> +				     msecs_to_jiffies(arg.max_scan_time +
> +						      ATH12K_MAC_SCAN_TIMEOUT_MSECS));
> +
> +exit:
> +	if (req->ie_len)
> +		kfree(arg.extraie.ptr);
> +
> +	mutex_unlock(&ar->conf_mutex);
> +	return ret;
> +}

snip

> +static int ath12k_station_assoc(struct ath12k *ar,
> +				struct ieee80211_vif *vif,
> +				struct ieee80211_sta *sta,
> +				bool reassoc)
> +{
> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +	struct ath12k_wmi_peer_assoc_arg peer_arg;
> +	int ret = 0;

nit: unnecessary initializer?

> +	struct cfg80211_chan_def def;
> +	enum nl80211_band band;
> +	struct cfg80211_bitrate_mask *mask;
> +	u8 num_vht_rates;
> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	if (WARN_ON(ath12k_mac_vif_chan(vif, &def)))
> +		return -EPERM;
> +
> +	band = def.chan->band;
> +	mask = &arvif->bitrate_mask;
> +
> +	ath12k_peer_assoc_prepare(ar, vif, sta, &peer_arg, reassoc);
> +
> +	ret = ath12k_wmi_send_peer_assoc_cmd(ar, &peer_arg);

snip

> +static int ath12k_station_disassoc(struct ath12k *ar,
> +				   struct ieee80211_vif *vif,
> +				   struct ieee80211_sta *sta)
> +{
> +	struct ath12k_vif *arvif = (void *)vif->drv_priv;
> +	int ret = 0;

nit: unnecessary initializer?

> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	if (!sta->wme) {
> +		arvif->num_legacy_stations--;
> +		ret = ath12k_recalc_rtscts_prot(arvif);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ath12k_clear_peer_keys(arvif, sta->addr);

snip

> +static int ath12k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
> +				       struct ieee80211_vif *vif,
> +				       struct ieee80211_sta *sta)
> +{
> +	struct ath12k *ar = hw->priv;
> +	struct ath12k_vif *arvif = (void *)vif->drv_priv;
> +	int ret = 0;

nit: unnecessary initializer?

> +	s16 txpwr;
> +
> +	if (sta->deflink.txpwr.type == NL80211_TX_POWER_AUTOMATIC) {
> +		txpwr = 0;
> +	} else {
> +		txpwr = sta->deflink.txpwr.power;
> +		if (!txpwr)
> +			return -EINVAL;
> +	}
> +
> +	if (txpwr > ATH12K_TX_POWER_MAX_VAL || txpwr < ATH12K_TX_POWER_MIN_VAL)
> +		return -EINVAL;
> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	ret = ath12k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
> +					WMI_PEER_USE_FIXED_PWR, txpwr);

snip

> +static int ath12k_conf_tx_uapsd(struct ath12k *ar, struct ieee80211_vif *vif,
> +				u16 ac, bool enable)
> +{
> +	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
> +	u32 value = 0;
> +	int ret = 0;

nit: unnecessary initializer?

> +
> +	if (arvif->vdev_type != WMI_VDEV_TYPE_STA)
> +		return 0;
> +
> +	switch (ac) {
> +	case IEEE80211_AC_VO:
> +		value = WMI_STA_PS_UAPSD_AC3_DELIVERY_EN |
> +			WMI_STA_PS_UAPSD_AC3_TRIGGER_EN;
> +		break;
> +	case IEEE80211_AC_VI:
> +		value = WMI_STA_PS_UAPSD_AC2_DELIVERY_EN |
> +			WMI_STA_PS_UAPSD_AC2_TRIGGER_EN;
> +		break;
> +	case IEEE80211_AC_BE:
> +		value = WMI_STA_PS_UAPSD_AC1_DELIVERY_EN |
> +			WMI_STA_PS_UAPSD_AC1_TRIGGER_EN;
> +		break;
> +	case IEEE80211_AC_BK:
> +		value = WMI_STA_PS_UAPSD_AC0_DELIVERY_EN |
> +			WMI_STA_PS_UAPSD_AC0_TRIGGER_EN;
> +		break;
> +	}
> +
> +	if (enable)
> +		arvif->u.sta.uapsd |= value;
> +	else
> +		arvif->u.sta.uapsd &= ~value;
> +
> +	ret = ath12k_wmi_set_sta_ps_param(ar, arvif->vdev_id,
> +					  WMI_STA_PS_PARAM_UAPSD,
> +					  arvif->u.sta.uapsd);

snip

> +static int ath12k_mac_set_txbf_conf(struct ath12k_vif *arvif)
> +{

snip

> +	/* TODO: SUBFEE not validated in HK, disable here until validated? */

nit: remove cryptic reference?

snip

> +static void ath12k_set_vht_txbf_cap(struct ath12k *ar, u32 *vht_cap)
> +{
> +	bool subfer, subfee;
> +	int sound_dim = 0;
> +
> +	subfer = !!(*vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE));
> +	subfee = !!(*vht_cap & (IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE));
> +
> +	if (ar->num_tx_chains < 2) {
> +		*vht_cap &= ~(IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE);
> +		subfer = false;
> +	}
> +
> +	/* If SU Beaformer is not set, then disable MU Beamformer Capability */
> +	if (!subfer)
> +		*vht_cap &= ~(IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE);
> +
> +	/* If SU Beaformee is not set, then disable MU Beamformee Capability */
> +	if (!subfee)
> +		*vht_cap &= ~(IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
> +
> +	sound_dim = (*vht_cap & IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK);
> +	sound_dim >>= IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT;
> +	*vht_cap &= ~IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK;

use bitops?

> +
> +	/* TODO: Need to check invalid STS and Sound_dim values set by FW? */
> +
> +	/* Enable Sounding Dimension Field only if SU BF is enabled */
> +	if (subfer) {
> +		if (sound_dim > (ar->num_tx_chains - 1))
> +			sound_dim = ar->num_tx_chains - 1;
> +
> +		sound_dim <<= IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT;
> +		sound_dim &= IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_MASK;
> +		*vht_cap |= sound_dim;
> +	}
> +
> +	/* Use the STS advertised by FW unless SU Beamformee is not supported*/
> +	if (!subfee)
> +		*vht_cap &= ~(IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK);
> +}

snip

> +static int ath12k_mac_vif_txmgmt_idr_remove(int buf_id, void *skb, void *ctx)
> +{
> +	struct ieee80211_vif *vif = ctx;
> +	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB((struct sk_buff *)skb);

nit: unnecessary typecast from void *?

snip

> +static u32
> +ath12k_mac_prepare_he_mode(struct ath12k_pdev *pdev, u32 viftype)
> +{
> +	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
> +	struct ath12k_band_cap *cap_band = NULL;
> +	u32 *hecap_phy_ptr = NULL;
> +	u32 hemode = 0;

nit: unnecessary initializer?

> +
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP)
> +		cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
> +	else
> +		cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
> +
> +	hecap_phy_ptr = &cap_band->he_cap_phy_info[0];
> +
> +	hemode = u32_encode_bits(HE_SU_BFEE_ENABLE, HE_MODE_SU_TX_BFEE) |
> +		 u32_encode_bits(HECAP_PHY_SUBFMR_GET(hecap_phy_ptr),
> +				 HE_MODE_SU_TX_BFER) |
> +		 u32_encode_bits(HECAP_PHY_ULMUMIMO_GET(hecap_phy_ptr),
> +				 HE_MODE_UL_MUMIMO);

snip

> +static int ath12k_set_he_mu_sounding_mode(struct ath12k *ar,
> +					  struct ath12k_vif *arvif)
> +{
> +	u32 param_id, param_value;
> +	struct ath12k_base *ab = ar->ab;
> +	int ret = 0;

nit: unnecessary initializer?

> +
> +	param_id = WMI_VDEV_PARAM_SET_HEMU_MODE;
> +	param_value = ath12k_mac_prepare_he_mode(ar->pdev, arvif->vif->type);
> +	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
> +					    param_id, param_value);

snip

> +static void ath12k_mac_op_configure_filter(struct ieee80211_hw *hw,
> +					   unsigned int changed_flags,
> +					   unsigned int *total_flags,
> +					   u64 multicast)
> +{
> +	struct ath12k *ar = hw->priv;
> +	bool reset_flag = false;

nit: unnecessary initializer?

> +	int ret = 0;

nit: unnecessary initializer?

> +
> +	mutex_lock(&ar->conf_mutex);
> +
> +	changed_flags &= SUPPORTED_FILTERS;
> +	*total_flags &= SUPPORTED_FILTERS;
> +	ar->filter_flags = *total_flags;
> +
> +	/* For monitor mode */
> +	reset_flag = !(ar->filter_flags & FIF_BCN_PRBRESP_PROMISC);
> +
> +	ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, reset_flag);

snip

> +ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
> +			      const struct cfg80211_chan_def *chandef,
> +			      bool restart)
> +{
> +	struct ath12k *ar = arvif->ar;
> +	struct ath12k_base *ab = ar->ab;
> +	struct wmi_vdev_start_req_arg arg = {};
> +	int he_support = arvif->vif->bss_conf.he_support;
> +	int ret = 0;

nit: unnecessary initializer?

> +
> +	lockdep_assert_held(&ar->conf_mutex);
> +
> +	reinit_completion(&ar->vdev_setup_done);
> +
> +	arg.vdev_id = arvif->vdev_id;
> +	arg.dtim_period = arvif->dtim_period;
> +	arg.bcn_intval = arvif->beacon_interval;
> +
> +	arg.freq = chandef->chan->center_freq;
> +	arg.band_center_freq1 = chandef->center_freq1;
> +	arg.band_center_freq2 = chandef->center_freq2;
> +	arg.mode = ath12k_phymodes[chandef->chan->band][chandef->width];
> +
> +	arg.min_power = 0;
> +	arg.max_power = chandef->chan->max_power * 2;
> +	arg.max_reg_power = chandef->chan->max_reg_power * 2;
> +	arg.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
> +
> +	arg.pref_tx_streams = ar->num_tx_chains;
> +	arg.pref_rx_streams = ar->num_rx_chains;
> +
> +	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
> +		arg.ssid = arvif->u.ap.ssid;
> +		arg.ssid_len = arvif->u.ap.ssid_len;
> +		arg.hidden_ssid = arvif->u.ap.hidden_ssid;
> +
> +		/* For now allow DFS for AP mode */
> +		arg.chan_radar = !!(chandef->chan->flags & IEEE80211_CHAN_RADAR);
> +
> +		arg.passive = arg.chan_radar;
> +
> +		spin_lock_bh(&ab->base_lock);
> +		arg.regdomain = ar->ab->dfs_region;
> +		spin_unlock_bh(&ab->base_lock);
> +
> +		/* TODO: Notify if secondary 80Mhz also needs radar detection */
> +		if (he_support) {
> +			ret = ath12k_set_he_mu_sounding_mode(ar, arvif);
> +			if (ret) {
> +				ath12k_warn(ar->ab, "failed to set he mode vdev %i\n",
> +					    arg.vdev_id);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	arg.passive |= !!(chandef->chan->flags & IEEE80211_CHAN_NO_IR);
> +
> +	ath12k_dbg(ab, ATH12K_DBG_MAC,
> +		   "mac vdev %d start center_freq %d phymode %s\n",
> +		   arg.vdev_id, arg.freq,
> +		   ath12k_mac_phymode_str(arg.mode));
> +
> +	ret = ath12k_wmi_vdev_start(ar, &arg, restart);

snip

> +static int
> +ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
> +				 struct ieee80211_vif *vif,
> +				 struct ieee80211_bss_conf *link_conf,
> +				 struct ieee80211_chanctx_conf *ctx)
> +{

snip

> +	ret = ath12k_mac_vdev_start(arvif, &ctx->def);
> +	if (ret) {
> +		ath12k_warn(ab, "failed to start vdev %i addr %pM on freq %d: %d\n",
> +			    arvif->vdev_id, vif->addr,
> +			    ctx->def.chan->center_freq, ret);
> +		goto out;
> +	}
> +
> +	if (arvif->vdev_type != WMI_VDEV_TYPE_MONITOR && ar->monitor_vdev_created)
> +		ath12k_mac_monitor_start(ar);
> +
> +	arvif->is_started = true;
> +
> +	/* TODO: Setup ps and cts/rts protection */
> +
> +	ret = 0;

unnecessary assignment -- already set from ath12k_mac_vdev_start()

rest snipped. hard to review such a long file :P
