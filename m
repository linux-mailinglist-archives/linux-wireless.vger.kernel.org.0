Return-Path: <linux-wireless+bounces-31670-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EI3JL6dHimmXJAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31670-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 21:46:31 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 239CA114839
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Feb 2026 21:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9E5A301A3AF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Feb 2026 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE6B3033FE;
	Mon,  9 Feb 2026 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUWl94zo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91C82DB781;
	Mon,  9 Feb 2026 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770669984; cv=none; b=cl1mrkujQOQ+PzqJKoRYszSbjZA8qoz9efARwlMbdh2oeRT+BiF4gloMX63FtRtcdO5o3e0a2enwprM2BzJsv2aCOKiP2hcObb/UeBHsboRKOeUAxz9nV34DtxsJZap2tVUOgv4+wa4j2Ts71bEdu3BSL6LeTWD4kwP9sX2t07A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770669984; c=relaxed/simple;
	bh=51paxc0TlIJdei936raFOTeWuiwyl59zObAJz9h89AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4XLaCK8QBjPDv9L/mUtQLDi/MmoUpbYH8iDTIbHmDZ/5UQz1Ew0CFCnhqfAnGn1X+97PSx5Ig1iW9SqXJVyfZHe4JeZxrTu+iTKTT8Oh2j4y5voTGn0VvD48SY2USEz0sadFot3brr1MlLz2it6Qci9Mh+VHG146ks0s0KMX1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUWl94zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BD3C116C6;
	Mon,  9 Feb 2026 20:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770669984;
	bh=51paxc0TlIJdei936raFOTeWuiwyl59zObAJz9h89AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUWl94zo9IIGYgFvjJIRitdXgBb7vGTXe59Y2A+ySXpJhaUMpinPYF9/DkSAwS28I
	 MuLa9Zru6xodciW/7RozlXRtid6F6iv3uwaVErfFykWOI086BBM6G2+/Z9r2wrctae
	 jh90lKhhY5NAxi+Ti1W9K043z1agrMSPiFel5px0vDnO10cUIXlYttCk+e+PJu8vW/
	 bBmD6x7qdJMkgRVLEtKF1vy1NyU5rhbVby8D4GRF3gi0zUjLh6ouGpW5mMC/rPlUVH
	 WC9EHPliwg195TBi16rlYMo5tFV/diBWuEU+BW9Am0EkEqf41EJzMFhYYOVALJwp4T
	 lIWJmDtc0Rf7A==
Date: Mon, 9 Feb 2026 12:46:23 -0800
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202602091212.743C6B9B7C@keescook>
References: <aYlkt2WP2oQ1TgeH@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYlkt2WP2oQ1TgeH@kspp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31670-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[wp.pl,sipsolutions.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 239CA114839
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 01:38:15PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declarations (which in a couple of cases happen
> to be in a union, so the entire unions are moved) to the end of the
> corresponding structures. Notice that `struct il_tx_beacon_cmd`,
> `struct il4965_tx_resp`, and `struct il3945_tx_beacon_cmd` are flexible
> structures, this is structures that contain a flexible-array member.

I think explicit mention of il3945_frame and il_frame should be included
in the commit log (probably after the above), as they are the ones that
contain the mentioned il*_tx_beacon_cmd structs that have a trailing
flex array.

> The case for struct il4965_beacon_notif is different. Since this
> structure is defined by hardware, we use the struct_group() helper
> to create the new `struct il4965_tx_resp_hdr` type. We then use this newly
> created type to replace the obhect type of  causing trouble in
> struct il4965_beacon_notif, namely `stryct il4965_tx_resp`.

Above two lines have typos and maybe a missing name (between "of" and
"causing")?

> In order to preserve the memory layout in struct il4965_beacon_notif,
> add member `__le32 beacon_tx_status`, which was previously included
> by `struct il4965_tx_resp` (as `__le32 status`), but it's not present
> in the newly created type `struct il4965_tx_resp_hdr`.

It may help to explicitly mention how the union exists to provide the
"status" member to anything using struct il4965_tx_resp, but there's no
sane way to do the overlap across structs, so anything using
il4965_beacon_notif needs have its own view of "status".

It does feel like accessing il4965_tx_resp's agg_status should be using
a different struct (like happens for other things that want bytes beyond
"status"), but okay.

Anyway, it's another situation of a header with a trailing flex array
that needs to overlap with differing deserializations of the trailing
bytes. The complication here is the kind of "layering violation" of
agg_status and status.

> Notice that after this changes, the size of struct il4965_beacon_notif
> along with its member's offsets remain the same, hence the memory
> layout doesn't change:
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
> We also want to ensure that when new members are added to the flexible
> structure `struct il4965_tx_resp` (if any), they are always included
> within the newly created struct type. To enforce this, we use
> `static_assert()` (which is intentionally placed right after the struct,
> this is, no blank line in between). This ensures that the memory layout
> of both the flexible structure and the new `struct il4965_tx_resp_hdr`
> type remains consistent after any changes.
> 
> Lastly, refactor the rest of the code, accordingly.

I think the changes look consistent with other similar logical changes
that have been made for -Wfamnae.

Since enabling -fms-extensions I'm on the look-out for cases where
we can use transparent struct members (i.e. define the header struct
separately and then use it transparently) instead of using the struct
group when we don't need to make the interior explicitly addressable
(as we have in this case), as it makes the diff way smaller:

diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
index b61b8f377702..440dff2a4ad9 100644
--- a/drivers/net/wireless/intel/iwlegacy/commands.h
+++ b/drivers/net/wireless/intel/iwlegacy/commands.h
@@ -1690,7 +1690,7 @@ struct agg_tx_status {
 	__le16 sequence;
 } __packed;
 
-struct il4965_tx_resp {
+struct il4965_tx_resp_hdr {
 	u8 frame_count;		/* 1 no aggregation, >1 aggregation */
 	u8 bt_kill_count;	/* # blocked by bluetooth (unused for agg) */
 	u8 failure_rts;		/* # failures due to unsuccessful RTS */
@@ -1707,6 +1707,10 @@ struct il4965_tx_resp {
 	__le16 reserved;
 	__le32 pa_power1;	/* RF power amplifier measurement (not used) */
 	__le32 pa_power2;
+} __packed;
+
+struct il4965_tx_resp {
+	struct il4965_tx_resp_hdr;
 
 	/*
 	 * For non-agg:  frame status TX_STATUS_*
@@ -2664,7 +2668,8 @@ struct il3945_beacon_notif {
 } __packed;
 
 struct il4965_beacon_notif {
-	struct il4965_tx_resp beacon_notify_hdr;
+	struct il4965_tx_resp_hdr beacon_notify_hdr;
+	__le32 status;
 	__le32 low_tsf;
 	__le32 high_tsf;
 	__le32 ibss_mgr_status;


What do folks think?

> With these changes fix the following warnings:
> 
> 11 drivers/net/wireless/intel/iwlegacy/common.h:526:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 11 drivers/net/wireless/intel/iwlegacy/commands.h:2667:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 4 drivers/net/wireless/intel/iwlegacy/3945.h:131:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Yay for getting these gone! :)

-- 
Kees Cook

