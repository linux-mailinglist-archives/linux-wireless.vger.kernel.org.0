Return-Path: <linux-wireless+bounces-31705-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEqsGzNZi2ljUAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31705-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 17:13:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4737711CF99
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C79B301D4CE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA5C30B529;
	Tue, 10 Feb 2026 16:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="X+6bLMwR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e3i677.smtp2go.com (e3i677.smtp2go.com [158.120.86.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132A83876D3
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739937; cv=none; b=dxhOR4zyGA75V7ZFc0vmbL7ChkzyiKGORqdYTWfxGMrekH2Nb+AHvBER+KLhg3WCfnM6ybZMGqkHPrOjmchssOH9rQpupXhsb5xUb/pK4WDUP3iWf9H3NFERt1bj9JMX4qf+lJOzykXWYn4SEfFWNzShv9/p6Lt8nftdPUY9AI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739937; c=relaxed/simple;
	bh=QIm5OqDwy5Y7+CAzuFp+kAjesl8PQwh4U9eIvJlWOfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoBkXd6WnBxQekokKKUlay1NpRgbjryTRf5dqgqRSqPPpbv+reI29NY3R7uJSGg3L5cey0g6/KE5iV18Cy8BI/DInmVd5k1Qw3Dosx9w8x2qhC43sB4qU6ZBCgsAiNPGDOphhNGGnhUdojWoDUQ4n+zUKYRfzfQgZyRbx+5Ggsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=X+6bLMwR; arc=none smtp.client-ip=158.120.86.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1770739027; h=from : subject
 : to : message-id : date;
 bh=ack/R3gOu6ylG0aLM8s2A97tY4Z9UXlkYyFIfsgcpuE=;
 b=X+6bLMwRmq0oOY98lyzERvIguv1dtzY5Z132cZSrpHh+tG4S8WX8ttF7KjZZ/0ApufvZh
 WwZi4Esa4tobKfftdVhfQ/tKwK09MLF19DOMMOUjoBs4HzGzCI3j2pOd5NdWtL8m2BtFYQi
 bZl5M3aAz/FKkxWOjwq7vK/M3DnPZlelwdnXClhcyplLqCXEtrDqEyLV6iYCXBjYuzSfU7S
 BY3QxsgyUeQ26rkOH9C64BVP/ZDADCG5Ib294o3KJoOUJMzn4jhFCcoOEEzuxlLwgrC0bjE
 kUnNQQ6CMa1O7YhKje9K2tjBzFrGyqmic/d9lTFaUU/EK6KUgnj/ysoSl19A==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vpq6q-FnQW0hPvYoT-lYQA;
	Tue, 10 Feb 2026 15:57:04 +0000
Date: Tue, 10 Feb 2026 16:38:46 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Yingying Tang <yingying.tang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	yintang@qti.qualcomm.com
Subject: Re: [PATCH ath-current] wifi: ath12k: fix incorrect channel survey
 index
Message-ID: <aYtRBg498h_aLPBK@pilgrim>
References: <20260210024440.3422264-1-yingying.tang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210024440.3422264-1-yingying.tang@oss.qualcomm.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616s297POVH8C
X-smtpcorp-track: KVnWI5wpzw0e.VHisKOgzjKJf.22R7FQFpvnP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31705-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,triplefau.lt:dkim]
X-Rspamd-Queue-Id: 4737711CF99
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:44:40AM +0800, Yingying Tang wrote:
> A wrong channel survey index was introduced in
> ath12k_mac_op_get_survey by [1], which can cause ACS to fail.
> 
> The index is decremented before being used, resulting in an
> incorrect value when accessing the channel survey data.
> 
> Fix the index handling to ensure the correct survey entry is
> used and avoid ACS failures.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3
> 
> Fixes: 4f242b1d6996 ("wifi: ath12k: support get_survey mac op for single wiphy") # [1]
> Signed-off-by: Yingying Tang <yingying.tang@oss.qualcomm.com>
> 
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index e0e49f782bf8..86ce7d87b5a5 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -13086,6 +13086,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  	struct ath12k *ar;
>  	struct ieee80211_supported_band *sband;
>  	struct survey_info *ar_survey;
> +	int orig_idx = idx;
>  
>  	lockdep_assert_wiphy(hw->wiphy);
>  
> @@ -13120,7 +13121,7 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
>  		return -ENOENT;
>  	}
>  
> -	ar_survey = &ar->survey[idx];
> +	ar_survey = &ar->survey[orig_idx];
>  
>  	ath12k_mac_update_bss_chan_survey(ar, &sband->channels[idx]);
>  

This change appears to break channel survey data on the QCN9274 (a
dual-band device), because each radio has its own ar (ath12k_radio)
instance.

A proper fix, for both single and dual band, could need to fetch the
survey index info from the frequency. Maybe reusing the freq_to_idx()
from wmi.c that already does the conversion as below ?

  ar_survey = &ar->survey[freq_to_idx(ar, sband->channels[idx].center_freq)];

Another solution could be to keep your patch and just remove the
following bits from freq_to_idx() as below.

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 3ce5fcb0e460..d05b837f7d47 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6568,9 +6568,6 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 	int band, ch, idx = 0;
 
 	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
-		if (!ar->mac.sbands[band].channels)
-			continue;
-
 		sband = hw->wiphy->bands[band];
 		if (!sband)
 			continue;


With that being said, there might be cleaner ways to do that though
(e.g. keeping survey result in ath12k_hw instead of per radio, ...).

Thanks,

-- 
Remi

