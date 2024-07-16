Return-Path: <linux-wireless+bounces-10247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1F5931F06
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 04:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0672E2816E6
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 02:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516863AE;
	Tue, 16 Jul 2024 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b="TBDbV1Jh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A7C15B
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jul 2024 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.84.6.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098384; cv=none; b=VmNzs2WabJ+BFxlNm/U9ViyjDKCimOl+7/vO2Cmx8o7F7U0/V8Rooz5wT729qexP7uv7eH0hg2XChDYwgb3oOaod3NW1KQmkZj9/O2bkfti09iI1C1NUhJNbbSj7Itf94+J4cizrfibRZApEjEhzQ5exS7xGcv8vKmYiCb1JC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098384; c=relaxed/simple;
	bh=PHKMrU0Eaz+K9NuTAECI1leDDzs5eT/ysnhCvHBl4f4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nbr5+YKXtJbbgxcF5Uwj0lyrIJtj42WHtbU1UCwVTgPUnZj5p6RPoSmOTTi/WNJ14SvC0OI5pC5LkfJbX+9dwwfdPyORHfa9Az8TcS2PRwMsysim0oTzknp5kdXICIycabWy+WQU9pgs4gSRKPDCOSll/pk8iT9+iLZ7HQWxyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com; spf=pass smtp.mailfrom=dd-wrt.com; dkim=pass (1024-bit key) header.d=dd-wrt.com header.i=@dd-wrt.com header.b=TBDbV1Jh; arc=none smtp.client-ip=185.84.6.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dd-wrt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dd-wrt.com
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:42954 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.97.1)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1sTYGK-000000006ZN-0feA;
	Tue, 16 Jul 2024 04:49:56 +0200
X-SASI-Hits: BODY_SIZE_6000_6999 0.000000, BODY_SIZE_7000_LESS 0.000000,
	CTE_7BIT 0.000000, DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000,
	HTML_00_01 0.050000, HTML_00_10 0.050000, INFO_TLD 0.000000,
	IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
	MSGID_SAMEAS_FROM_HEX_844412 0.100000, MSG_THREAD 0.000000,
	MULTIPLE_REAL_RCPTS 0.000000, NO_FUR_HEADER 0.000000, OUTBOUND 0.000000,
	OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000, SENDER_NO_AUTH 0.000000,
	SINGLE_URI_IN_BODY 0.000000, SUSP_DH_NEG 0.000000,
	URI_WITH_PATH_ONLY 0.000000, USER_AGENT 0.000000, __ANY_URI 0.000000,
	__BODY_NO_MAILTO 0.000000, __BOUNCE_CHALLENGE_SUBJ 0.000000,
	__BOUNCE_NDR_SUBJ_EXEMPT 0.000000, __BULK_NEGATE 0.000000,
	__CP_URI_IN_BODY 0.000000, __CT 0.000000, __CTE 0.000000,
	__CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000, __DKIM_ALIGNS_2 0.000000,
	__DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000, __DQ_NEG_IP 0.000000,
	__FORWARDED_MSG 0.000000, __FRAUD_BODY_WEBMAIL 0.000000,
	__FRAUD_WEBMAIL 0.000000, __FROM_DOMAIN_NOT_IN_BODY 0.000000,
	__FROM_NAME_NOT_IN_BODY 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
	__HAS_REFERENCES 0.000000, __HEADER_ORDER_FROM 0.000000,
	__HTTPS_URI 0.000000, __INVOICE_MULTILINGUAL 0.000000, __IN_REP_TO 0.000000,
	__MAIL_CHAIN 0.000000, __MAIL_CHAIN_OLD 0.000000,
	__MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
	__MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MOZILLA_USER_AGENT 0.000000, __MSGID_HEX_844412 0.000000,
	__MULTIPLE_RCPTS_TO_X2 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PASSWORD_IN_BODY 0.000000,
	__PHISH_SPEAR_REASONS 0.000000, __PHISH_SPEAR_REASONS1 0.000000,
	__PHISH_SPEAR_SUBJECT 0.000000, __PHISH_SPEAR_SUBJ_ALERT 0.000000,
	__PHISH_SPEAR_SUBJ_PREDICATE 0.000000, __RCVD_PASS 0.000000,
	__REFERENCES 0.000000, __SANE_MSGID 0.000000, __SCAN_D_NEG 0.000000,
	__SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SINGLE_URI_TEXT 0.000000,
	__SUBJ_ALPHA_END 0.000000, __SUBJ_ALPHA_NEGATE 0.000000,
	__SUBJ_REPLY 0.000000, __TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_IN_BODY 0.000000, __URI_MAILTO 0.000000, __URI_NOT_IMG 0.000000,
	__URI_NO_WWW 0.000000, __URI_NS 0.000000, __URI_WITH_PATH 0.000000,
	__USER_AGENT 0.000000, __X_MAILSCANNER 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2024.7.16.21520
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID; bh=P/mNpNZGpIAFzV8lcrI5lpAvdsHULBdYqcZbPE1xBIo=;
	b=TBDbV1JhZJZ6JUWvmR9y3T1huWPPYu3S2zabZDAZk7eTy3CzPd/CfP5VCrTf/fKKbsn0jWIg8iKC6Bmo4YQ81DdKZPSa1JMWf9gSdTTsO8rcvIKcpQwYn9/+KV8tsk7A1U5k9lW3OcxPIhMLGl5kwe7/KNegjApVKKWH5PcPey4=;
Message-ID: <420ae7cf-7b7a-4350-9dbb-00f00485acb8@dd-wrt.com>
Date: Tue, 16 Jul 2024 04:49:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH] ath11k: fix peer addition/deletion error on sta band
 migration
To: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
 ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20220603164559.27769-1-ansuelsmth@gmail.com>
From: Sebastian Gottschall <s.gottschall@dd-wrt.com>
In-Reply-To: <20220603164559.27769-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=s.gottschall@dd-wrt.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: s.gottschall@dd-wrt.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1sTYFx-000EWf-B3
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: s.gottschall@dd-wrt.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <s.gottschall@dd-wrt.com>)
	id 1sTYFx-000EWf-B3; Tue, 16 Jul 2024 04:49:33 +0200


Am 03.06.2022 um 18:45 schrieb Christian 'Ansuel' Marangi:
> This patch try to fix the following error.
>
> Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.561227] ath11k c000000.wifi: peer already added vdev id 0 req, vdev id 1 present
> Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.561282] ath11k c000000.wifi: Failed to add peer: 28:c2:1f:xx:xx:xx for VDEV: 0
> Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.568053] ath11k c000000.wifi: Failed to add station: 28:c2:1f:xx:xx:xx for VDEV: 0
> Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan2: STA 28:c2:1f:xx:xx:xx IEEE 802.11: Could not add STA to kernel driver
> Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan2: STA 28:c2:1f:xx:xx:xx IEEE 802.11: did not acknowledge authentication response
> Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan1: AP-STA-DISCONNECTED 28:c2:1f:xx:xx:xx
> Wed Jun  1 22:19:31 2022 daemon.info hostapd: wlan1: STA 28:c2:1f:xx:xx:xx IEEE 802.11: disassociated due to inactivity
> Wed Jun  1 22:19:32 2022 daemon.info hostapd: wlan1: STA 28:c2:1f:xx:xx:xx IEEE 802.11: deauthenticated due to inactivity (timer DEAUTH/REMOVE)
>
> To repro this:
> - Have 2 Wifi with the same bssid and pass on different band (2.4 and
> 5GHz)
> - Enable 802.11r Fast Transaction with same mobility domain
> - FT Protocol: FT over the Air
>  From a openwrt system issue the command (with the correct mac)
> ubus call hostapd.wlan1 wnm_disassoc_imminent '{"addr":"28:C2:1F:xx:xx:xx"}'
> Notice the log printing the errors.
>
> The cause of this error has been investigated and we found that this is
> related to the WiFi Fast Transaction feature. We observed that this is
> triggered when the router tells the device to change band. In this case
> the device first auth to the other band and then the disconnect path
> from the prev band is triggered.
> This is problematic with the current rhash implementation since the
> addrs is used as key and the logic of "adding first, delete later"
> conflicts with the rhash logic.
> In fact peer addition will fail since the peer is already added and with
> that fixed a peer deletion will cause unitended effect by removing the
> peer just added.
>
> Current solution to this is to add additional logic to the peer delete,
> make sure we are deleting the correct peer taken from the rhash
> table (and fallback to the peer list) and for the peer add logic delete
> the peer entry for the rhash list before adding the new one (counting as
> an error only when a peer with the same vlan_id is asked to be added).
>
> With this change, a sta can correctly transition from 2.4GHz and 5GHZ
> with no drop and no error are printed.
>
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
>
> Fixes: 7b0c70d92a43 ("ath11k: Add peer rhash table support")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> ---
>
> Some additional comments external to this patch.
> I tried to find different way to fix this...
> One of them would be mod the logic of the rhash and using as a key both
> the vlan_id and the addr but this is problematic for the function
> where ath11k_peer_find_by_addr is used as vlan_id is not always available.
>
> I honestly think a correct solution would be have a rhash list per vdev_id
> or per mac_id but again this is problematic for some function that just handles
> data and have only the addr as a way to identify the peer.
>
> So unless some change are done to the firmware to provide the vlan_id in the
> msdu data this to me seems to be the only solution to correctly handle this case.
>
> Another solution I tried was to add to the peer some additional info and put
> the rhash addition in the peer delete logic by passing the "to-be-added peer" to
> the peer to delete but I notice that it's unreliable since it can happent that
> the new peer hasn't been mapped at the time the peer delete is called.
>
> So this is really how to handle the rhash table in this corner case.
> Considering how peer are handled in theory it should never happen to have
> dangling peer that are not deleted.
>
> Hoping this is not too much of an hack and we find a good solution for this
> problem.
>
>   drivers/net/wireless/ath/ath11k/peer.c | 30 ++++++++++++++++++++++----
>   1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
> index 9e22aaf34b88..1ae7af02c364 100644
> --- a/drivers/net/wireless/ath/ath11k/peer.c
> +++ b/drivers/net/wireless/ath/ath11k/peer.c
> @@ -302,6 +302,21 @@ static int __ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
>   	spin_lock_bh(&ab->base_lock);
>   
>   	peer = ath11k_peer_find_by_addr(ab, addr);
> +	/* Check if the found peer is what we want to remove.
> +	 * While the sta is transitioning to another band we may
> +	 * have 2 peer with the same addr assigned to different
> +	 * vdev_id. Make sure we are deleting the correct peer.
> +	 */
> +	if (peer && peer->vdev_id == vdev_id)
> +		ath11k_peer_rhash_delete(ab, peer);
> +
> +	/* Fallback to peer list search if the correct peer can't be found.
> +	 * Skip the deletion of the peer from the rhash since it has already
> +	 * been deleted in peer add.
> +	 */
> +	if (!peer)
> +		peer = ath11k_peer_find(ab, vdev_id, addr);
> +
>   	if (!peer) {
>   		spin_unlock_bh(&ab->base_lock);
>   		mutex_unlock(&ab->tbl_mtx_lock);
> @@ -312,8 +327,6 @@ static int __ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
>   		return -EINVAL;
>   	}
>   
> -	ath11k_peer_rhash_delete(ab, peer);
> -
>   	spin_unlock_bh(&ab->base_lock);
>   	mutex_unlock(&ab->tbl_mtx_lock);
>   
> @@ -372,8 +385,17 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
>   	spin_lock_bh(&ar->ab->base_lock);
>   	peer = ath11k_peer_find_by_addr(ar->ab, param->peer_addr);
>   	if (peer) {
> -		spin_unlock_bh(&ar->ab->base_lock);
> -		return -EINVAL;
> +		if (peer->vdev_id == param->vdev_id) {
> +			spin_unlock_bh(&ar->ab->base_lock);
> +			return -EINVAL;
> +		}
> +
> +		/* Assume sta is transitioning to another band.
> +		 * Remove here the peer from rhash.
> +		 */
> +		mutex_lock(&ar->ab->tbl_mtx_lock);
> +		ath11k_peer_rhash_delete(ar->ab, peer);
> +		mutex_unlock(&ar->ab->tbl_mtx_lock);
>   	}
>   	spin_unlock_bh(&ar->ab->base_lock);
>   

after doing some research for finding a weired ath11k firmware crash i 
found out that this patch is the source for the problem
it seems that in case that multiple bssid's are in use (not for roaming 
purpose) the wifi crashes on peer delete under some circumstances
originally this issue was discovered by another party. so please check 
the following link for more details and logs 
https://github.com/openwrt/openwrt/issues/14693

Sebastian


