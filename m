Return-Path: <linux-wireless+bounces-31893-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MmrA69kk2k44QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31893-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 19:40:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E425147044
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 19:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B74E1301E7E7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5842DF156;
	Mon, 16 Feb 2026 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="JYrOPMqB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BFE27F00A
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267239; cv=none; b=fO52WRgUt2Kmjmeg5srE9ff3KDl8cS2o5N4fDGiKNuN6A6l7ly//W0VJ06NhDomByadbz+qx9JQWghLCi5Q1I1DzBXp4mKMyvEfK1IpgBDH9YEEk/z02RBn2zadCz1tosTTfw4UwXe7HWBDyBV68o/5r3ibLNnKEfj/V2W9ga4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267239; c=relaxed/simple;
	bh=2byi3hC475KVRuKj/j8RLZA3EFKqKcS1jcnJ40oG+eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQMgoulV9+Bk5R6kq1wynjwiXV8rRHemV2ipsG1nnZIKHkPJ497b/Qy4V9XxVs3kdIXkAr+bHX2hkocyUCejqVAM8JwxCGD5XFvNJdo94otzoJ+N1U5h/wHr0VpfPSiPXv6AN3D20DzSups4eEDLRnZHO28CW0OemE7oMks54b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=JYrOPMqB; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 39911 invoked from network); 16 Feb 2026 19:40:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1771267233; bh=g9kWFH+gZGPCGKBvPU1bB5S5nt1G0K9yP8u4EZ6iNtE=;
          h=From:To:Cc:Subject;
          b=JYrOPMqBPVdfnTgAgTAPV4V70oG8GNjQx4Q2jTp0gPpD8mqrh5TW77Y+hsOGSNiWH
           tfra8loZfHZsh4MetPHPzaHjeICn+8Pkl8RC058ob0F7AagNMCZrnqdnuZQ3GMSC+d
           aZBC7GtFDXkrff/NlcgabuL0ljndYXaFBy5TFQ0O+mHlLWmvd1Pswn0fPqwqRSREDW
           GDTJ3tDmQ3pgQkYDZe/d+n6BN1yiM1PKfuigcdKwvkPaxrG1TS+hlHDQyynie3lgqP
           yeHCEjmk+BipKaybD5IuWziks/2jm/KumJbgyzbwmo0FEP3uQd9/OEhm2mB26iNrKn
           7ouWfrRNAU/7A==
Received: from 89-64-3-178.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.178])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <gustavo@embeddedor.com>; 16 Feb 2026 19:40:33 +0100
Date: Mon, 16 Feb 2026 19:40:33 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <20260216184033.GB10063@wp.pl>
References: <aYlkt2WP2oQ1TgeH@kspp>
 <202602091212.743C6B9B7C@keescook>
 <4bf43164-b130-4643-9f4f-761f49bd0dc9@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf43164-b130-4643-9f4f-761f49bd0dc9@embeddedor.com>
X-WP-MailID: 6cbdb478c833d6401de726d55360c29e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000003 [cYAA]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31893-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[wp.pl:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[wp.pl]
X-Rspamd-Queue-Id: 6E425147044
X-Rspamd-Action: no action

Hi

On Mon, Feb 09, 2026 at 03:23:59PM +0900, Gustavo A. R. Silva wrote:

When you will repost, please use 'wifi: iwlegacy:' prefix in the title.

Regards
Stanislaw

> On 2/10/26 05:46, Kees Cook wrote:
> > On Mon, Feb 09, 2026 at 01:38:15PM +0900, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > Move the conflicting declarations (which in a couple of cases happen
> > > to be in a union, so the entire unions are moved) to the end of the
> > > corresponding structures. Notice that `struct il_tx_beacon_cmd`,
> > > `struct il4965_tx_resp`, and `struct il3945_tx_beacon_cmd` are flexible
> > > structures, this is structures that contain a flexible-array member.
> > 
> > I think explicit mention of il3945_frame and il_frame should be included
> > in the commit log (probably after the above), as they are the ones that
> > contain the mentioned il*_tx_beacon_cmd structs that have a trailing
> > flex array.
> 
> Okay.
> 
> > 
> > > The case for struct il4965_beacon_notif is different. Since this
> > > structure is defined by hardware, we use the struct_group() helper
> > > to create the new `struct il4965_tx_resp_hdr` type. We then use this newly
> > > created type to replace the obhect type of  causing trouble in
> > > struct il4965_beacon_notif, namely `stryct il4965_tx_resp`.
> > 
> > Above two lines have typos and maybe a missing name (between "of" and
> > "causing")?
> 
> Aggh.. yes, I had fixed this before, but somehow I ended up using the
> wrong changelog text. Thanks for the catch!
> 
> > 
> > > In order to preserve the memory layout in struct il4965_beacon_notif,
> > > add member `__le32 beacon_tx_status`, which was previously included
> > > by `struct il4965_tx_resp` (as `__le32 status`), but it's not present
> > > in the newly created type `struct il4965_tx_resp_hdr`.
> > 
> > It may help to explicitly mention how the union exists to provide the
> > "status" member to anything using struct il4965_tx_resp, but there's no
> > sane way to do the overlap across structs, so anything using
> > il4965_beacon_notif needs have its own view of "status".
> 
> Okay.
> 
> > 
> > It does feel like accessing il4965_tx_resp's agg_status should be using
> > a different struct (like happens for other things that want bytes beyond
> > "status"), but okay.
> > 
> > Anyway, it's another situation of a header with a trailing flex array
> > that needs to overlap with differing deserializations of the trailing
> > bytes. The complication here is the kind of "layering violation" of
> > agg_status and status.
> > 
> > > Notice that after this changes, the size of struct il4965_beacon_notif
> > > along with its member's offsets remain the same, hence the memory
> > > layout doesn't change:
> > > 
> > > Before changes:
> > > struct il4965_beacon_notif {
> > > 	struct il4965_tx_resp      beacon_notify_hdr;    /*     0    24 */
> > > 	__le32                     low_tsf;              /*    24     4 */
> > > 	__le32                     high_tsf;             /*    28     4 */
> > > 	__le32                     ibss_mgr_status;      /*    32     4 */
> > > 
> > > 	/* size: 36, cachelines: 1, members: 4 */
> > > 	/* last cacheline: 36 bytes */
> > > };
> > > 
> > > After changes:
> > > struct il4965_beacon_notif {
> > > 	struct il4965_tx_resp_hdr  beacon_notify_hdr;    /*     0    20 */
> > > 	__le32                     beacon_tx_status;     /*    20     4 */
> > > 	__le32                     low_tsf;              /*    24     4 */
> > > 	__le32                     high_tsf;             /*    28     4 */
> > > 	__le32                     ibss_mgr_status;      /*    32     4 */
> > > 
> > > 	/* size: 36, cachelines: 1, members: 5 */
> > > 	/* last cacheline: 36 bytes */
> > > };
> > > 
> > > We also want to ensure that when new members are added to the flexible
> > > structure `struct il4965_tx_resp` (if any), they are always included
> > > within the newly created struct type. To enforce this, we use
> > > `static_assert()` (which is intentionally placed right after the struct,
> > > this is, no blank line in between). This ensures that the memory layout
> > > of both the flexible structure and the new `struct il4965_tx_resp_hdr`
> > > type remains consistent after any changes.
> > > 
> > > Lastly, refactor the rest of the code, accordingly.
> > 
> > I think the changes look consistent with other similar logical changes
> > that have been made for -Wfamnae.
> > 
> > Since enabling -fms-extensions I'm on the look-out for cases where
> > we can use transparent struct members (i.e. define the header struct
> > separately and then use it transparently) instead of using the struct
> > group when we don't need to make the interior explicitly addressable
> > (as we have in this case), as it makes the diff way smaller:
> 
> Ah yes, I can do this. The only thing is that I'd have to change every
> place where members in struct il4965_tx_resp are used, e.g.
> 
> s/frame_count/hdr.frame_count
> 
> and so on...
> 
> Another thing to take into account (fortunately, not in this case) is
> when the FAM needs to be annotated with __counted_by(). If we use a
> separate struct for the header portion of the flexible structure, GCC
> currently cannot _see_ the _counter_ if it's included in a non-anonymous
> structure. However, this will be possible in the near future, correct?
> 
> > 
> > diff --git a/drivers/net/wireless/intel/iwlegacy/commands.h b/drivers/net/wireless/intel/iwlegacy/commands.h
> > index b61b8f377702..440dff2a4ad9 100644
> > --- a/drivers/net/wireless/intel/iwlegacy/commands.h
> > +++ b/drivers/net/wireless/intel/iwlegacy/commands.h
> > @@ -1690,7 +1690,7 @@ struct agg_tx_status {
> >   	__le16 sequence;
> >   } __packed;
> > -struct il4965_tx_resp {
> > +struct il4965_tx_resp_hdr {
> >   	u8 frame_count;		/* 1 no aggregation, >1 aggregation */
> >   	u8 bt_kill_count;	/* # blocked by bluetooth (unused for agg) */
> >   	u8 failure_rts;		/* # failures due to unsuccessful RTS */
> > @@ -1707,6 +1707,10 @@ struct il4965_tx_resp {
> >   	__le16 reserved;
> >   	__le32 pa_power1;	/* RF power amplifier measurement (not used) */
> >   	__le32 pa_power2;
> > +} __packed;
> > +
> > +struct il4965_tx_resp {
> > +	struct il4965_tx_resp_hdr;
> >   	/*
> >   	 * For non-agg:  frame status TX_STATUS_*
> > @@ -2664,7 +2668,8 @@ struct il3945_beacon_notif {
> >   } __packed;
> >   struct il4965_beacon_notif {
> > -	struct il4965_tx_resp beacon_notify_hdr;
> > +	struct il4965_tx_resp_hdr beacon_notify_hdr;
> > +	__le32 status;
> >   	__le32 low_tsf;
> >   	__le32 high_tsf;
> >   	__le32 ibss_mgr_status;
> > 
> > 
> > What do folks think?
> 
> I'll wait for maintainers to chime in.
> 
> > 
> > > With these changes fix the following warnings:
> > > 
> > > 11 drivers/net/wireless/intel/iwlegacy/common.h:526:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 11 drivers/net/wireless/intel/iwlegacy/commands.h:2667:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 4 drivers/net/wireless/intel/iwlegacy/3945.h:131:11: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > 
> > Yay for getting these gone! :)
> > 
> 
> We're getting there! \o/
> 
> Thanks
> -Gustavo
> 

