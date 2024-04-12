Return-Path: <linux-wireless+bounces-6239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05F8A2C14
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 12:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1137E281349
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559450A63;
	Fri, 12 Apr 2024 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdakgzOU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3030481C2
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916976; cv=none; b=P+K3ER0Iu3nbCQY0ZDCOpVSmRU76WvXlcE4oURRAShmIy1mvyvUszEFMFzpfE+0alEtYnIbuPW15Kk1wA+jQ/aN4QT1DJMD+bQPgsqcUfiwXMOr3BggaU8NSpruIjYNFdlqKv+olg8tDkexCylMFgBYUTdzmsrWPkkS54c9NE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916976; c=relaxed/simple;
	bh=RITZpDGpGGZw+40MZOv+dar/fjjE//K8HH8WByVSyT8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=AlBUWlbEvHzvgntmtDu+TkzwRifLZ4OYAt7Y4qIVUzH3cRihtzmrovGu0PGxx5eFGv7IWkw3D+a6i/sewHXD58LqHEQievqa9ewest1spg5ZaoCcTtQM3UKEqcUHx0gcfKW0tcfNpiS4uMCXdL6+ORIFwxjBarYWPg57qXbAsss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdakgzOU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5171a529224so924927e87.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712916973; x=1713521773; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGrRWcDAzHnrgpG3aebm5DhxSp1gebBKe7MwUgBFSPA=;
        b=EdakgzOUgcEkZFFsfffyVb+MdPqh1jcNvQGNEsXCv5/8OGfQZ3nyF6rutfnjOJ5t+j
         Js81LN/KHeGJPYLk3A+fW46fSB8t1m4sdLSEenU2ee+76+VJ76dKMsD9uPiYjwFPSj+D
         fIPyq1gECmS5x6pZFb9TQRK9Gk+t3vpKDqdDt7Bm64VfEQCv/drnDz0Q9fefw81cEbCn
         ZHRBbBhNFYLcqbzReCULCWUbTaSrOEexI+7WSoIp6emQDZEoyRR269aXlL4gxI+DHh+P
         XDtTkrWZxXyl3HwhPZmvdl+o28q5T7h9xDGYvBphoLW+g7KdxUmL9hR9n9dN0qYT3ptv
         iZUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712916973; x=1713521773;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BGrRWcDAzHnrgpG3aebm5DhxSp1gebBKe7MwUgBFSPA=;
        b=Ng2nV1jNen1MWgIyhdw2gqXJlZZ6FNE+lkpPaJIly3e9/JCNc1ZxIW7ijvv6qkwMHe
         AU8etNON/ObHPm2BN07oWFFomkjuNNALogyxCChjWJ83fyoMWrSZRnb5yNO0c6WwrteZ
         zjrQUT0JNpmrkvxBjzNu9gfvZwhlhMKlU/qi7hRu5LZnxMgAJtWJDjejrqKbg/eC2f4B
         ZXBrt4tr+HI1dTxVXvXgLqjx7aCvU/CE4tVc/4tRqkTU2YuhL9kDPE/jPbnYEQTIkbSb
         0uOO8cvZJ9ZJ8hMnMBXJTReuOOR0gu6DAx14uxcck8RQIMNUFSCyvqM5xjC9Nw9mj4AF
         ZwJw==
X-Gm-Message-State: AOJu0YxAWjWLLNOJ6ZtwSz9oe8NFs+hFT9EzPsQ9W3Tf3nQ6OreYhOS6
	nRXk2dmDyST1AKKwRWVP0vHuGStRe0A8bh5/8ebn63CT2lkXpB7emGtC2Q==
X-Google-Smtp-Source: AGHT+IHAhqUMNAs4au7XNEG9h1rC96yaBYY144lJPsY1DCLhu1ZUbIcRpWNF+w2WYXcZDpVqJiZMag==
X-Received: by 2002:a19:2d56:0:b0:518:8d15:8810 with SMTP id t22-20020a192d56000000b005188d158810mr478079lft.14.1712916972856;
        Fri, 12 Apr 2024 03:16:12 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d6404000000b00343b09729easm3925777wru.69.2024.04.12.03.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 03:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Apr 2024 12:16:12 +0200
Message-Id: <D0I2E1O0GLM5.12RQY3BJEOKVY@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "kangyang" <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3] wifi: ath12k: add support to handle beacon miss for
 WCN7850
X-Mailer: aerc 0.17.0
References: <20240412094447.2063-1-quic_kangyang@quicinc.com>
In-Reply-To: <20240412094447.2063-1-quic_kangyang@quicinc.com>

On Fri Apr 12, 2024 at 11:44 AM CEST, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
>
> When AP goes down or too far away without indication to STA, beacon miss
> will be detected. Then for WCN7850's firmware, it will use roam event
> to send beacon miss to host.
>
> If STA doesn't handle the beacon miss, will keep the fake connection
> and unable to roam.
>
> So add support for WCN7850 to trigger disconnection from AP when
> receiving this event from firmware.
>
> It has to be noted that beacon miss event notification for QCN9274
> to be handled in a separate patch as it uses STA kickout WMI event
> to notify beacon miss and the current STA kickout event is processed
> as low_ack.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_S=
ILICONZ-3
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>
> v3: move INIT_DELAYED_WORK to add_interface().
> v2: rebased on latest tag: ath-202404101413.
>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  2 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 75 +++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h  |  2 +
>  drivers/net/wireless/ath/ath12k/wmi.c  | 34 ++++++------
>  drivers/net/wireless/ath/ath12k/wmi.h  |  3 ++
>  5 files changed, 98 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireles=
s/ath/ath12k/core.h
> index 397d8c973265..e125efe20dde 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -46,6 +46,7 @@
>  #define ATH12K_SMBIOS_BDF_EXT_MAGIC "BDF_"
> =20
>  #define ATH12K_INVALID_HW_MAC_ID	0xFF
> +#define ATH12K_CONNECTION_LOSS_HZ	(3 * HZ)
>  #define	ATH12K_RX_RATE_TABLE_NUM	320
>  #define	ATH12K_RX_RATE_TABLE_11AX_NUM	576
> =20
> @@ -275,6 +276,7 @@ struct ath12k_vif {
>  	u32 aid;
>  	u8 bssid[ETH_ALEN];
>  	struct cfg80211_bitrate_mask bitrate_mask;
> +	struct delayed_work connection_loss_work;
>  	int num_legacy_stations;
>  	int rtscts_prot_mode;
>  	int txpower;
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless=
/ath/ath12k/mac.c
> index f15dcd75157d..e8ce9b940753 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1398,6 +1398,75 @@ static void ath12k_control_beaconing(struct ath12k=
_vif *arvif,
>  	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac vdev %d up\n", arvif->vdev_id);
>  }
> =20
> +static void ath12k_mac_handle_beacon_iter(void *data, u8 *mac,
> +					  struct ieee80211_vif *vif)
> +{
> +	struct sk_buff *skb =3D data;
> +	struct ieee80211_mgmt *mgmt =3D (void *)skb->data;
> +	struct ath12k_vif *arvif =3D ath12k_vif_to_arvif(vif);
> +
> +	if (vif->type !=3D NL80211_IFTYPE_STATION)
> +		return;
> +
> +	if (!ether_addr_equal(mgmt->bssid, vif->bss_conf.bssid))
> +		return;
> +
> +	cancel_delayed_work(&arvif->connection_loss_work);
> +}
> +
> +void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb)
> +{
> +	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
> +						   IEEE80211_IFACE_ITER_NORMAL,
> +						   ath12k_mac_handle_beacon_iter,
> +						   skb);
> +}
> +
> +static void ath12k_mac_handle_beacon_miss_iter(void *data, u8 *mac,
> +					       struct ieee80211_vif *vif)
> +{
> +	u32 *vdev_id =3D data;
> +	struct ath12k_vif *arvif =3D ath12k_vif_to_arvif(vif);
> +	struct ath12k *ar =3D arvif->ar;
> +	struct ieee80211_hw *hw =3D ath12k_ar_to_hw(ar);
> +
> +	if (arvif->vdev_id !=3D *vdev_id)
> +		return;
> +
> +	if (!arvif->is_up)
> +		return;
> +
> +	ieee80211_beacon_loss(vif);
> +
> +	/* Firmware doesn't report beacon loss events repeatedly. If AP probe
> +	 * (done by mac80211) succeeds but beacons do not resume then it
> +	 * doesn't make sense to continue operation. Queue connection loss work
> +	 * which can be cancelled when beacon is received.
> +	 */
> +	ieee80211_queue_delayed_work(hw, &arvif->connection_loss_work,
> +				     ATH12K_CONNECTION_LOSS_HZ);
> +}
> +
> +void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id)
> +{
> +	ieee80211_iterate_active_interfaces_atomic(ath12k_ar_to_hw(ar),
> +						   IEEE80211_IFACE_ITER_NORMAL,
> +						   ath12k_mac_handle_beacon_miss_iter,
> +						   &vdev_id);
> +}
> +
> +static void ath12k_mac_vif_sta_connection_loss_work(struct work_struct *=
work)
> +{
> +	struct ath12k_vif *arvif =3D container_of(work, struct ath12k_vif,
> +						connection_loss_work.work);
> +	struct ieee80211_vif *vif =3D arvif->vif;
> +
> +	if (!arvif->is_up)
> +		return;
> +
> +	ieee80211_connection_loss(vif);
> +}
> +
>  static void ath12k_peer_assoc_h_basic(struct ath12k *ar,
>  				      struct ieee80211_vif *vif,
>  				      struct ieee80211_sta *sta,
> @@ -2570,7 +2639,7 @@ static void ath12k_bss_disassoc(struct ath12k *ar,
> =20
>  	arvif->is_up =3D false;
> =20
> -	/* TODO: cancel connection_loss_work */
> +	cancel_delayed_work(&arvif->connection_loss_work);
>  }
> =20
>  static u32 ath12k_mac_get_rate_hw_value(int bitrate)
> @@ -6317,6 +6386,8 @@ static int ath12k_mac_op_add_interface(struct ieee8=
0211_hw *hw,
>  	arvif->vif =3D vif;
> =20
>  	INIT_LIST_HEAD(&arvif->list);
> +	INIT_DELAYED_WORK(&arvif->connection_loss_work,
> +			  ath12k_mac_vif_sta_connection_loss_work);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(arvif->bitrate_mask.control); i++) {
>  		arvif->bitrate_mask.control[i].legacy =3D 0xffffffff;
> @@ -6449,6 +6520,8 @@ static void ath12k_mac_op_remove_interface(struct i=
eee80211_hw *hw,
>  	ar =3D arvif->ar;
>  	ab =3D ar->ab;
> =20
> +	cancel_delayed_work_sync(&arvif->connection_loss_work);
> +
>  	mutex_lock(&ar->conf_mutex);
> =20
>  	ath12k_dbg(ab, ATH12K_DBG_MAC, "mac remove interface (vdev %d)\n",
> diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless=
/ath/ath12k/mac.h
> index 3f5e1be0dff9..bfc655a4dfce 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.h
> +++ b/drivers/net/wireless/ath/ath12k/mac.h
> @@ -78,4 +78,6 @@ enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath1=
2k_bw(enum rate_info_bw b
>  enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
>  int ath12k_mac_rfkill_enable_radio(struct ath12k *ar, bool enable);
>  int ath12k_mac_rfkill_config(struct ath12k *ar);
> +void ath12k_mac_handle_beacon(struct ath12k *ar, struct sk_buff *skb);
> +void ath12k_mac_handle_beacon_miss(struct ath12k *ar, u32 vdev_id);
>  #endif
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless=
/ath/ath12k/wmi.c
> index a5575ce9eed4..4fe39e920902 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -5927,10 +5927,8 @@ static void ath12k_mgmt_rx_event(struct ath12k_bas=
e *ab, struct sk_buff *skb)
>  		}
>  	}
> =20
> -	/* TODO: Pending handle beacon implementation
> -	 *if (ieee80211_is_beacon(hdr->frame_control))
> -	 *	ath12k_mac_handle_beacon(ar, skb);
> -	 */
> +	if (ieee80211_is_beacon(hdr->frame_control))
> +		ath12k_mac_handle_beacon(ar, skb);
> =20
>  	ath12k_dbg(ab, ATH12K_DBG_MGMT,
>  		   "event mgmt rx skb %pK len %d ftype %02x stype %02x\n",
> @@ -6137,42 +6135,44 @@ static void ath12k_roam_event(struct ath12k_base =
*ab, struct sk_buff *skb)
>  {
>  	struct wmi_roam_event roam_ev =3D {};
>  	struct ath12k *ar;
> +	u32 vdev_id;
> +	u8 roam_reason;
> =20
>  	if (ath12k_pull_roam_ev(ab, skb, &roam_ev) !=3D 0) {
>  		ath12k_warn(ab, "failed to extract roam event");
>  		return;
>  	}
> =20
> +	vdev_id =3D le32_to_cpu(roam_ev.vdev_id);
> +	roam_reason =3D u32_get_bits(le32_to_cpu(roam_ev.reason),
> +				   WMI_ROAM_REASON_MASK);
> +
>  	ath12k_dbg(ab, ATH12K_DBG_WMI,
> -		   "wmi roam event vdev %u reason 0x%08x rssi %d\n",
> -		   roam_ev.vdev_id, roam_ev.reason, roam_ev.rssi);
> +		   "wmi roam event vdev %u reason %d rssi %d\n",
> +		   vdev_id, roam_reason, roam_ev.rssi);
> =20
>  	rcu_read_lock();
> -	ar =3D ath12k_mac_get_ar_by_vdev_id(ab, le32_to_cpu(roam_ev.vdev_id));
> +	ar =3D ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
>  	if (!ar) {
> -		ath12k_warn(ab, "invalid vdev id in roam ev %d",
> -			    roam_ev.vdev_id);
> +		ath12k_warn(ab, "invalid vdev id in roam ev %d", vdev_id);
>  		rcu_read_unlock();
>  		return;
>  	}
> =20
> -	if (le32_to_cpu(roam_ev.reason) >=3D WMI_ROAM_REASON_MAX)
> +	if (roam_reason >=3D WMI_ROAM_REASON_MAX)
>  		ath12k_warn(ab, "ignoring unknown roam event reason %d on vdev %i\n",
> -			    roam_ev.reason, roam_ev.vdev_id);
> +			    roam_reason, vdev_id);
> =20
> -	switch (le32_to_cpu(roam_ev.reason)) {
> +	switch (roam_reason) {
>  	case WMI_ROAM_REASON_BEACON_MISS:
> -		/* TODO: Pending beacon miss and connection_loss_work
> -		 * implementation
> -		 * ath12k_mac_handle_beacon_miss(ar, vdev_id);
> -		 */
> +		ath12k_mac_handle_beacon_miss(ar, vdev_id);
>  		break;
>  	case WMI_ROAM_REASON_BETTER_AP:
>  	case WMI_ROAM_REASON_LOW_RSSI:
>  	case WMI_ROAM_REASON_SUITABLE_AP_FOUND:
>  	case WMI_ROAM_REASON_HO_FAILED:
>  		ath12k_warn(ab, "ignoring not implemented roam event reason %d on vdev=
 %i\n",
> -			    roam_ev.reason, roam_ev.vdev_id);
> +			    roam_reason, vdev_id);
>  		break;
>  	}
> =20
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless=
/ath/ath12k/wmi.h
> index 78afc94a815d..ebf73ddcadc6 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -4182,6 +4182,9 @@ struct wmi_peer_sta_kickout_event {
>  	struct ath12k_wmi_mac_addr_params peer_macaddr;
>  } __packed;
> =20
> +#define WMI_ROAM_REASON_MASK		GENMASK(3, 0)
> +#define WMI_ROAM_SUBNET_STATUS_MASK	GENMASK(5, 4)
> +
>  enum wmi_roam_reason {
>  	WMI_ROAM_REASON_BETTER_AP =3D 1,
>  	WMI_ROAM_REASON_BEACON_MISS =3D 2,
>
> base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9

LGTM, you can have my reviewed by if needed.

Reviewed-by: Nicolas Escande <nico.escande@gmail.com>

