Return-Path: <linux-wireless+bounces-31929-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBbdG35SlGl3CgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31929-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:35:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D07DC14B6FC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05DC30117B6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665E314A8B;
	Tue, 17 Feb 2026 11:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="P9v5xWFw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE79332EB2
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328122; cv=none; b=OemaOuDOsp4RGIhBZLSuF4qoaPcV88p39f6YpNlZaTu9045fjF5DNUJiEdPNuI6FAdatvrPemRTdZRfraybbLNDfT6RzqtdPmKWUKkqM61n3tahpzwf991B1pMYpBubLSrzXUiTIzcw9VuRUxLAlYyW/GIxsOiYtyK9KMOPvCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328122; c=relaxed/simple;
	bh=PoapMP4COwGoFID61t45vY1LuXY7pJvvwr04zVlx4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvBljVMfOMpaBbZMhX66MqFZsv9Z96SM9hYaZtqw2UIr7vH4rk3h9n4U3nRLySzFlB6/P49Bnx5Wgr3DYcnFeMEjh3rtoMXJHv1Y7dRZfKiaD8WqQtZso4i/eqC/J5mYoMsRQuXVb/Daw0EXb7vOQpNRvCKgLWW2lWw5V7DblSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=P9v5xWFw; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 31336 invoked from network); 17 Feb 2026 12:35:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1771328110; bh=sxgF2V3nlw6uBiaZJzqx5C7V/ot6RGXS96gFNYSxWiA=;
          h=From:To:Cc:Subject;
          b=P9v5xWFwhwup4ogMwb+oBZlwV8B2UVO/GjrbTM9Ob7ZKozcBaPVfJC9H7MHseZQ2y
           pIVAOKw6EKZ1sE72BNaRQ/UEG2VV3c82/TTswAkJPudOfEsN/UgR+xNn8nYTgyspTW
           uMbqSTgrovDW/QfdQzL/O0lEM3gctV6SCtgzB2kIsHi6nvCVXXTROKdGL9ZgcxBuJ0
           HUlvSAPibK/2WxXmXHp0ObUo8wGmQ/VjjKiwPqmWRhTElHw4KkIiFNTcyR7Ma+u6nO
           4XbEAyGq4g+4nE7fXO9bHt0ZbYllrSaHxH3oRqU+r/TIF3TG0Q8/b0Gn2a5kL33f0b
           LkD7WVhd3jd6w==
Received: from 89-64-3-178.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.178])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <gustavoars@kernel.org>; 17 Feb 2026 12:35:10 +0100
Date: Tue, 17 Feb 2026 12:35:09 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4][next] wifi: iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <20260217113509.GA12624@wp.pl>
References: <aZLienEatf9KC6Rx@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZLienEatf9KC6Rx@kspp>
X-WP-MailID: 0b6bcf5218986e2ab4df55dba7fb2fc7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [MfN0]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31929-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: D07DC14B6FC
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 06:25:14PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declarations (which in a couple of cases happen
> to be in a union, so the entire unions are moved) to the end of the
> corresponding structures, struct il_frame, and struct il3945_frame.
> 
> Notice that `struct il_tx_beacon_cmd`, `struct il4965_tx_resp`, and
> `struct il3945_tx_beacon_cmd` are flexible structures, this is
> structures that contain a flexible-array member.
> 
> The case for struct il4965_beacon_notif is different. Since this
> structure is defined by hardware, we create the new `struct
> il4965_tx_resp_hdr` type. We then use this newly created type to
> replace the object type causing trouble in struct il4965_beacon_notif,
> namely `struct il4965_tx_resp`.
> 
> Also, once -fms-extensions is enabled, we can use transparent struct
> members in struct il4965_tx_resp.
> 
> Notice that the newly created type does not contain the flex-array
> member `agg_status`, which is the object causing the -Wfamnae warnings.
> This object is currently in a union along with `__le32 status`, so
> anything using struct il4965_beacon_notif needs to have its own view
> of `status`. To preserve the memory layout, we therefore add member
> `__le32 beacon_tx_status` to struct il4965_beacon_notif.
> 
> After these changes, the size of struct il4965_beacon_notif along
> with its member's offsets remain the same, hence the memory layout
> doesn't change:
> 
> Before changes:
> struct il4965_beacon_notif {
> 	struct il4965_tx_resp      beacon_notify_hdr;    /*     0    24 */
> 	__le32                     low_tsf;              /*    24     4 */
> 	__le32                     high_tsf;             /*    28     4 */
> 	__le32                     ibss_mgr_status;      /*    32     4 */
> 
> 	/* size: 36, cachelines: 1, members: 4 */
> 	/* last cacheline: 36 bytes */
> };
> 
> After changes:
> struct il4965_beacon_notif {
> 	struct il4965_tx_resp_hdr  beacon_notify_hdr;    /*     0    20 */
> 	__le32                     beacon_tx_status;     /*    20     4 */
> 	__le32                     low_tsf;              /*    24     4 */
> 	__le32                     high_tsf;             /*    28     4 */
> 	__le32                     ibss_mgr_status;      /*    32     4 */
> 
> 	/* size: 36, cachelines: 1, members: 5 */
> 	/* last cacheline: 36 bytes */
> };
> 
> Lastly, adjust the rest of the code, accordingly.
> 
> With these changes fix the following warnings:
> 
> 11 drivers/net/wireless/intel/iwlegacy/common.h:526:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 11 drivers/net/wireless/intel/iwlegacy/commands.h:2667:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 4 drivers/net/wireless/intel/iwlegacy/3945.h:131:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Regards
Stanislaw
> ---
> Changes in v4:
>  - (Aggh...) Fix a couple of typos in changelog text:
>    		s/stryct/struct
>    		s/il4965_beacon_notif/il4965_tx_resp.
> 
> Changes in v3:
>  - Create new separate struct il4965_tx_resp_hdr, and use
>    transparent struct members instead of __struct_group(). (Kees)
>  - Update subject line - Add 'wifi:' prefix. (Stanislaw)
>  - Link: https://lore.kernel.org/linux-hardening/aZLgfO6z1Gt8aiyc@kspp/
> 
> Changes in v2:
>  - Use the struct_group() helper, and update the conflicting type
>    (struct il4965_tx_resp -> struct il4965_tx_resp_hdr) in
>    struct il4965_beacon_notif.
>  - Link: https://lore.kernel.org/linux-hardening/aYlkt2WP2oQ1TgeH@kspp/
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/aR2CtqZI3atH0HmE@kspp/
> 
>  drivers/net/wireless/intel/iwlegacy/3945.h     | 4 +++-
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 2 +-
>  drivers/net/wireless/intel/iwlegacy/commands.h | 9 +++++++--
>  drivers/net/wireless/intel/iwlegacy/common.h   | 4 +++-
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945.h b/drivers/net/wireless/intel/iwlegacy/3945.h
> index fb1e33c89d0e..ed63b31fee9a 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945.h
> +++ b/drivers/net/wireless/intel/iwlegacy/3945.h
> @@ -123,13 +123,15 @@ enum il3945_antenna {
>  #define IEEE80211_FRAME_LEN             (IEEE80211_DATA_LEN + IEEE80211_HLEN)
>  
>  struct il3945_frame {
> +	struct list_head list;
> +
> +	/* Must be last as it ends in a flexible-array member. */
>  	union {
>  		struct ieee80211_hdr frame;
>  		struct il3945_tx_beacon_cmd beacon;
>  		u8 raw[IEEE80211_FRAME_LEN];
>  		u8 cmd[360];
>  	} u;
> -	struct list_head list;
>  };
>  
>  #define SUP_RATE_11A_MAX_NUM_CHANNELS  8
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index 57fa866efd9f..f5a99a2ee95a 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -4076,7 +4076,7 @@ il4965_hdl_beacon(struct il_priv *il, struct il_rx_buf *rxb)
>  	u8 rate = il4965_hw_get_rate(beacon->beacon_notify_hdr.rate_n_flags);
>  
>  	D_RX("beacon status %x retries %d iss %d tsf:0x%.8x%.8x rate %d\n",
> -	     le32_to_cpu(beacon->beacon_notify_hdr.u.status) & TX_STATUS_MSK,
> +	     le32_to_cpu(beacon->beacon_tx_status) & TX_STATUS_MSK,
>  	     beacon->beacon_notify_hdr.failure_frame,
>  	     le32_to_cpu(beacon->ibss_mgr_status),
>  	     le32_to_cpu(beacon->high_tsf), le32_to_cpu(beacon->low_tsf), rate);
> diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
> index b61b8f377702..7aba84ac88a1 100644
> --- a/drivers/net/wireless/intel/iwlegacy/commands.h
> +++ b/drivers/net/wireless/intel/iwlegacy/commands.h
> @@ -1690,7 +1690,7 @@ struct agg_tx_status {
>  	__le16 sequence;
>  } __packed;
>  
> -struct il4965_tx_resp {
> +struct il4965_tx_resp_hdr {
>  	u8 frame_count;		/* 1 no aggregation, >1 aggregation */
>  	u8 bt_kill_count;	/* # blocked by bluetooth (unused for agg) */
>  	u8 failure_rts;		/* # failures due to unsuccessful RTS */
> @@ -1707,6 +1707,10 @@ struct il4965_tx_resp {
>  	__le16 reserved;
>  	__le32 pa_power1;	/* RF power amplifier measurement (not used) */
>  	__le32 pa_power2;
> +} __packed;
> +
> +struct il4965_tx_resp {
> +	struct il4965_tx_resp_hdr;
>  
>  	/*
>  	 * For non-agg:  frame status TX_STATUS_*
> @@ -2664,7 +2668,8 @@ struct il3945_beacon_notif {
>  } __packed;
>  
>  struct il4965_beacon_notif {
> -	struct il4965_tx_resp beacon_notify_hdr;
> +	struct il4965_tx_resp_hdr beacon_notify_hdr;
> +	__le32 beacon_tx_status;
>  	__le32 low_tsf;
>  	__le32 high_tsf;
>  	__le32 ibss_mgr_status;
> diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
> index 4c9836ab11dd..21f1c7702add 100644
> --- a/drivers/net/wireless/intel/iwlegacy/common.h
> +++ b/drivers/net/wireless/intel/iwlegacy/common.h
> @@ -518,13 +518,15 @@ struct il_channel_info {
>  #define IEEE80211_FRAME_LEN             (IEEE80211_DATA_LEN + IEEE80211_HLEN)
>  
>  struct il_frame {
> +	struct list_head list;
> +
> +	/* Must be last as it ends in a flexible-array member. */
>  	union {
>  		struct ieee80211_hdr frame;
>  		struct il_tx_beacon_cmd beacon;
>  		u8 raw[IEEE80211_FRAME_LEN];
>  		u8 cmd[360];
>  	} u;
> -	struct list_head list;
>  };
>  
>  enum {
> -- 
> 2.43.0
> 

