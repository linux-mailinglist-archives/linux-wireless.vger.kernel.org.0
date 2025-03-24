Return-Path: <linux-wireless+bounces-20748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580B7A6D9F0
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 13:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861403A5F14
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 12:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C26025DCFA;
	Mon, 24 Mar 2025 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NJ6iQPl5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA98418A6C1;
	Mon, 24 Mar 2025 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818633; cv=none; b=PGaYVb3TzINPUfsLJDk+DQ7jtsvzr24DxJuOvMl7G0BTHOsl+VovtC3PTGUlwMjvGWjb/ZET/BgLqTDzzo60be6dg++QIereF8VLBzh64oGpSLdNUa2qGzwoK/plgFMfcqiTCeUuL+vJZ4sQPnnlYbC3SpWsWpijm1rn34x+jI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818633; c=relaxed/simple;
	bh=OyJjb52U6SPYBHglOWIXqWpN8UNu0dZeWIIh91MnVXE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOutc7R1QyJRyQ7tTgSEGhlHPgpG45bONQtrd6xMrCSCUeHD1xP8Op14AXhDKeSXkb/dAoV06RiUNZjxgryadYpoApyZ3MsFGYk6sDiy8kHwqGep/uvo6Ml+O54VCJlEZdG9+xezJEQcPeit0df+t/preXbg7OB0J2fy2Bsuang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NJ6iQPl5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W6RQz0Iak2RKskEFG9tsWaSiFWE6qmsHQP5eJ4e7afM=;
	t=1742818631; x=1744028231; b=NJ6iQPl5L7XWlR6HnxcEdxWRaiLDMWvu8LwIx5051qLI3IV
	dxOFDT6AX6mXqSpcQuqham0u1I/8bixnwBAcH2Mo756UlboppBFehYEY+lKj9r3nShRUIHbpKIk5m
	auKrVZ7EGABHTPV2/QG2VyznN+n6tzE2KWOTyviZS6OI2SkuHN3GtXy2ml19GCgxR+q4nsml0V2Rc
	tuDir54fWKYJwKr8aofqyV3mBOSn6E8uYpIkFXNRrCiuZOoChABXXsyWtNP/mWsvZBOZ98nf+/BBZ
	fBoKYY0ahW2g3pTEmyVyf/nxEZbe3lOqSIwbm9dOEnB0dlgA69b6bo6GkvtAk0pg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1twgjt-00000003zJA-0m97;
	Mon, 24 Mar 2025 13:17:09 +0100
Message-ID: <754c24f1b1f7d37cb616478c57a85af18d119c21.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: mac80211: Update skb's NULL key in
 ieee80211_tx_h_select_key()
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 24 Mar 2025 13:17:08 +0100
In-Reply-To: <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
References: <cover.1741950009.git.repk@triplefau.lt>
	 <95269f93724a94ee0b22f8107fe5b5e8f2fbea76.1741950009.git.repk@triplefau.lt>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-03-14 at 12:04 +0100, Remi Pommarel wrote:
> The ieee80211 skb control block key (set when skb was queued) could have
> been removed before ieee80211_tx_dequeue() call. ieee80211_tx_dequeue()
> already called ieee80211_tx_h_select_key() to get the current key, but
> the latter do not update the key in skb control block in case it is
> NULL. Because some drivers actually use this key in their TX callbacks
> (e.g. ath1{1,2}k_mac_op_tx()) this could lead to the use after free
> below:
>=20
>   BUG: KASAN: slab-use-after-free in ath11k_mac_op_tx+0x590/0x61c
>   Read of size 4 at addr ffffff803083c248 by task kworker/u16:4/1440


Maybe should have a Fixes: tag?

And please also tag the subject "[PATCH wireless NN/MM]".

> +++ b/net/mac80211/tx.c
> @@ -668,6 +668,12 @@ ieee80211_tx_h_select_key(struct ieee80211_tx_data *=
tx)
>  	} else if (ieee80211_is_data_present(hdr->frame_control) && tx->sta &&
>  		   test_sta_flag(tx->sta, WLAN_STA_USES_ENCRYPTION)) {
>  		return TX_DROP;
> +	} else {
> +		/* Clear SKB CB key reference, ieee80211_tx_h_select_key()
> +		 * could have been called to update key info after its removal
> +		 * (e.g. by ieee80211_tx_dequeue()).
> +		 */
> +		info->control.hw_key =3D NULL;
>  	}

I'm not sure this looks like the right place - should probably be done
around line 3897 before the call:

        /*
         * The key can be removed while the packet was queued, so need to c=
all
         * this here to get the current key.
         */
        r =3D ieee80211_tx_h_select_key(&tx);


I'd think?

johannes

