Return-Path: <linux-wireless+bounces-25759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B24B0CAA1
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 20:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BCD17E937
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8EF2874E5;
	Mon, 21 Jul 2025 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t54HNfjl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455D01FE44B;
	Mon, 21 Jul 2025 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753123014; cv=none; b=SVI4c0vTOJEIOGj9pBnHP9mWJ0n9e8TN+DeRXWckl2c17CGWMtGRoCPEkTLBDRz1uQ5yqOoJSqpMLeXGCPxn3leimS28vLJT9mROiudsFFx6T+LwsIwxmmV9ZGd9Ft9eYTMJ5hE7PySKkXbURbm58dhj6i6jyv+ZbrlDgAZX+3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753123014; c=relaxed/simple;
	bh=sNoysnLUM//CZo48EGjswW50D/RsGuk3kNd/j5gJbag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jkperXZfnw7DYaILygua7W02WM6y6cjRd75UG9NzFpgQrqyB0oJFZqj/+WYRAmbbzL9NB0THiEBtS1c69i0GdNBX+4V1QfRcEIk7jIhU+UJwmO0V/yJoNxPWBh+dFeqkAuc5lsKh+iPczuStdAwswHT5WWiHT3hcnqMNxONO0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t54HNfjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8CBC4CEED;
	Mon, 21 Jul 2025 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753123013;
	bh=sNoysnLUM//CZo48EGjswW50D/RsGuk3kNd/j5gJbag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t54HNfjlAJBI5qIvODCqXNBsOXb0kkgFG5/BTF5pWYt0e2bAmHCyYs68/yz1Dv9pm
	 wIEQZtVnic5AG3mHVdc6P/SgmMaZtc0W5D7a2eEDe+KZ3ENiR4idvYUOY2epQBIRLx
	 AMhuLB4eRFs777QnLPK7z0xiKnvr47bnM8qRaUoBPJdu0q13o+Bir5s91Q2fbtt42+
	 /ZuaM3Ufp6ASAgPVe/GfJVdzxtNKC2fzIjUl1WN4sPbUdcwCYJGYvJb70Ene8noNwt
	 Pg6muEYLzFx2GJf3wXzeIrw8NPPT1Nj8EyI7AbzH1JwXP+rp9FbqLNwldyANIh+hjc
	 gKqnzNWXhDC8g==
Date: Mon, 21 Jul 2025 11:36:53 -0700
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Review of __counted_by in wireless (was Re: [PATCH wireless] wifi:
 cfg80211: remove scan request n_channels counted_by)
Message-ID: <202507210907.987737BFD@keescook>
References: <20250714142130.9b0bbb7e1f07.I09112ccde72d445e11348fc2bef68942cb2ffc94@changeid>
 <202507142200.D315742C@keescook>
 <adb4d011c640aacb2273f81a4ad6e658ea2f52f1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb4d011c640aacb2273f81a4ad6e658ea2f52f1.camel@sipsolutions.net>

On Tue, Jul 15, 2025 at 10:24:16AM +0200, Johannes Berg wrote:
> If you feel motivated you could help review and perhaps annotate the
> still existing ones I guess, I'm thinking we should have comments there
> like this perhaps:
> 
> --- a/net/mac80211/parse.c
> +++ b/net/mac80211/parse.c
> @@ -54,8 +54,9 @@ struct ieee80211_elems_parse {
>          * scratch buffer that can be used for various element parsing related
>          * tasks, e.g., element de-fragmentation etc.
>          */
> -       size_t scratch_len;
>         u8 *scratch_pos;
> +       /* __counted_by: scratch_len tracks the allocation and doesn't change */
> +       size_t scratch_len;
>         u8 scratch[] __counted_by(scratch_len);
>  };

This seemed like a good project to compare my manual review against a
review performed by the LLM I've been playing with, and it did okay. It
missed several dynamic cases and I had to prod it into getting them
right, and it couldn't find some allocation patterns on its own. It did
spontaneously find the le/ge counted_by variants, which was nice. Anyway,
here are the results...


Static Counters (28 structures)

Almost all follow the pattern:
	instance = alloc(...N...);
	instance->counter = N;
where counter is set once and never changes. (Some are copying existing
data and never changing the counter variable.)

- struct ath10k_ce_ring (drivers/net/wireless/ath/ath10k/)
      void *per_transfer_context[] __counted_by(nentries)

- struct wmi_set_link_monitor_cmd (drivers/net/wireless/ath/wil6210/)
      s8 rssi_thresholds_list[] __counted_by(rssi_thresholds_list_size)

- struct mt76_rx_tid (drivers/net/wireless/mediatek/mt76/)
      struct sk_buff *reorder_buf[] __counted_by(size)

- struct p54_cal_database (drivers/net/wireless/intersil/p54/)
      u8 data[] __counted_by(len)

- struct libipw_txb (drivers/net/wireless/intel/ipw2x00/)
      struct sk_buff *fragments[] __counted_by(nr_frags)

- struct at76_command (drivers/net/wireless/atmel/)
      u8 data[] __counted_by_le(size)

- struct brcmf_gscan_config (drivers/net/wireless/broadcom/brcm80211/brcmfmac/)
      struct brcmf_gscan_bucket_config bucket[] __counted_by(count_of_channel_buckets)

- struct brcmf_fw_request (drivers/net/wireless/broadcom/brcm80211/brcmfmac/)
      struct brcmf_fw_item items[] __counted_by(n_items)

- struct brcmf_fweh_event_map (drivers/net/wireless/broadcom/brcm80211/brcmfmac/)
      struct brcmf_fweh_event_name items[] __counted_by(n_items)

- struct brcmf_fweh_info (drivers/net/wireless/broadcom/brcm80211/brcmfmac/)
      int evt_handler[] __counted_by(num_event_codes)

- struct brcmf_fweh_queue_item (drivers/net/wireless/broadcom/brcm80211/brcmfmac/)
      u8 data[] __counted_by(datalen)

- struct brcmf_eventmsgs_ext (drivers/net/wireless/broadcom/brcm80211/brcmfmac/)
      u8 mask[] __counted_by(len)

- struct brcmf_mf_params_le (drivers/net/wireless/broadcom/brcm80211/brcmfmac/)
      u8 data[] __counted_by(len)

- struct wcn36xx_hal_ind_msg (drivers/net/wireless/ath/wcn36xx/)
      u8 msg[] __counted_by(msg_len)

- struct iwl_mvm_acs_survey (drivers/net/wireless/intel/iwlwifi/)
      struct iwl_mvm_acs_survey_channel channels[] __counted_by(n_channels)

- struct rtw89_btc_btf_set_slot_table (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_btc_btf_slot tbls[] __counted_by(tbl_num)

- struct rtw89_btc_btf_set_mon_reg_v1 (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_btc_btf_reg regs[] __counted_by(reg_num)

- struct rtw89_btc_btf_set_mon_reg_v7 (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_btc_btf_reg regs[] __counted_by(len)

- struct rtw89_h2c_chinfo (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_h2c_ch elem[] __counted_by(ch_num)

- struct rtw89_h2c_chinfo_be (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_h2c_ch_be elem[] __counted_by(ch_num)

- struct rtw89_h2c_mrc_req_tsf (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_h2c_mrc_req_tsf_info infos[] __counted_by(req_tsf_num)

- struct rtw89_acpi_data (drivers/net/wireless/realtek/rtw89/)
      u8 buf[] __counted_by(len)

- struct rtw89_acpi_policy_6ghz (drivers/net/wireless/realtek/rtw89/)
      char country_list[] __counted_by(country_count)

- struct rtw89_regd_data (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_regulatory_info map[] __counted_by(nr)

- struct cfg80211_cqm_config (net/wireless/)
      s32 rssi_thresholds[] __counted_by(n_rssi_thresholds)

- struct ieee80211_elems_parse (net/mac80211/)
      u8 scratch[] __counted_by(scratch_len)

- struct cfg80211_tid_config (include/net/cfg80211.h)
      struct cfg80211_tid_cfg tid_conf[] __counted_by(n_tid_conf)

- struct cfg80211_acl_data (include/net/cfg80211.h)
      struct mac_address mac_addrs[] __counted_by(n_acl_entries)

- struct cfg80211_coalesce (include/net/cfg80211.h)
      struct cfg80211_coalesce_rules rules[] __counted_by(n_rules)

- struct cfg80211_pmsr_request (include/net/cfg80211.h)
      struct cfg80211_pmsr_request_peer peers[] __counted_by(n_peers)

Dynamic Counters (10 structures):

- struct wmi_start_scan_cmd (drivers/net/wireless/ath/wil6210/)
      struct wmi_start_scan_cmd_channel_list channel_list[] __counted_by(num_channels)

- struct rtw89_vif (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_vif_link links_inst[] __counted_by(links_inst_valid_num)

- struct rtw89_sta (drivers/net/wireless/realtek/rtw89/)
      struct rtw89_sta_link links_inst[] __counted_by(links_inst_valid_num)

- struct cfg80211_scan_request (include/net/cfg80211.h)
      struct ieee80211_channel *channels[] __counted_by(n_channels)

- struct cfg80211_sched_scan_request (include/net/cfg80211.h)
      struct ieee80211_channel *channels[] __counted_by(n_channels)

- struct cfg80211_mbssid_elems (include/net/cfg80211.h)
      struct cfg80211_mbssid_elem elem[] __counted_by(cnt)

- struct cfg80211_rnr_elems (include/net/cfg80211.h)
      struct cfg80211_rnr_elem elem[] __counted_by(cnt)

- struct cfg80211_sar_specs (include/net/cfg80211.h)
      struct cfg80211_sar_sub_specs sub_specs[] __counted_by(num_sub_specs)

- struct cfg80211_wowlan_nd_match (include/net/cfg80211.h)
      u32 channels[] __counted_by(n_channels)

- struct cfg80211_wowlan_nd_info (include/net/cfg80211.h)
      struct cfg80211_wowlan_nd_match *matches[] __counted_by(n_matches)


In the review, I found 3 existing bugs, which I've set as separate
patches now:
https://lore.kernel.org/lkml/20250721181810.work.575-kees@kernel.org/
https://lore.kernel.org/lkml/20250721182521.work.540-kees@kernel.org/
https://lore.kernel.org/lkml/20250721183125.work.183-kees@kernel.org/

At the end of the day, with the above fixes, I think the dynamic cases
appear safe, as they all follow basically the same pattern of allocating
some max size and then filling/filtering the actual population of the
array. (So I think cfg80211_scan_request is correctly used at this point,
but I understand your desire to remove __counted_by on it.)

Do you want me to send patches for the static cases to add comments or
is that too much churn?

-Kees

-- 
Kees Cook

