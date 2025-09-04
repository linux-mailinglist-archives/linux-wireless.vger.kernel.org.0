Return-Path: <linux-wireless+bounces-27006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60479B439F4
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 13:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D79F5A39D9
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718B32C21D3;
	Thu,  4 Sep 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FC7ObpRL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75052F39CB;
	Thu,  4 Sep 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984952; cv=none; b=Yc0MV+ObYL6b+1a9trTFXi+DY5ui3xVX2IJWYU97mPqGay/9PdsqfSHF3yhsx9WAFPHPAXfQ8efolEF+6o9TKO6xbwCaapALOswfKf7dXgKKVXp6izTSSG2KsPgp4LRuoOFOqNBeIDFysCIW9kdByytkhGE+lLhJtfYgVwnu4v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984952; c=relaxed/simple;
	bh=nb2w5PO/UakpEL4PsZ67h0/YfPhTc/JuAdrospcVW8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ja7NqyYRJj1kEGZgQoTsJQJAnIXfEW0jyrEgacgTeN9D6GXaz3fJsnzw1udgelR2+yFKz8fwxvJL4iihmkihLe5P5v2VyetirjwjFMsILmrTfRXyaqoKXwKZQUTz7qgo/8nLjEilrhnIUCHGA3/kBbG8hF8fOBi3IEUMmXIN3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FC7ObpRL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JNhPkhYLjZGM2xHwZlcrLuFikmcX09zLHGx0YNWKfO0=;
	t=1756984950; x=1758194550; b=FC7ObpRLnGlhKnxr4MTjzANNt3focQqBM3V3qOvrxuCHtiU
	RbA+cwwzIP+IYoQfsGigKTh0hdzvKAB/J9NVms5/CtUG+KWFKHRnCYnuIsNZVF/M09MbGV/jYse2j
	rSjAks1oGkkxA9KTsjkNl03pbgLDkxyri3Z35O6SIAjQJlgamr4BCc5EMTp6eJqR3/I4DKcJGX2Yp
	C+PJj9Au7QBesAdnMwp8ZZXwDg3DQWWO6fJltQl/yN6ym2KbnY+ALvvBSP5POSmkzn5I1qn4JLNHi
	IedezwWVn5YZ779KGTxq914YIk4k3t21O11ezOSsh91tvgg1utD6cSGKgE6Bcs+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uu82n-0000000E5mY-453d;
	Thu, 04 Sep 2025 13:22:22 +0200
Message-ID: <88809ae495005b8295d0c46261041c73a225359f.camel@sipsolutions.net>
Subject: Re: [PATCH v5 01/22] wifi: nxpwifi: add 802.11n files
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org, 
	francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, s.hauer@pengutronix.de, 
	brian.hsu@nxp.com
Date: Thu, 04 Sep 2025 13:22:21 +0200
In-Reply-To: <20250804154018.3563834-2-jeff.chen_1@nxp.com>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
	 <20250804154018.3563834-2-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-08-04 at 23:39 +0800, Jeff Chen wrote:
> +static bool
> +nxpwifi_is_tx_ba_stream_ptr_valid(struct nxpwifi_private *priv,
> +				  struct nxpwifi_tx_ba_stream_tbl *tx_tbl_ptr)
> +{
> +	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl;
> +	bool ret =3D false;
> +	int tid;
> +
> +	tid =3D tx_tbl_ptr->tid;
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr[tid]=
, list) {
> +		if (tx_ba_tsr_tbl =3D=3D tx_tbl_ptr) {
> +			ret =3D true;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return ret;

that might be nicer with guard(rcu)() :)


> +/* This function returns the pointer to an entry in BA Stream
> + * table which matches the given RA/TID pair.
> + */
> +struct nxpwifi_tx_ba_stream_tbl *
> +nxpwifi_get_ba_tbl(struct nxpwifi_private *priv, int tid, u8 *ra)
> +{
> +	struct nxpwifi_tx_ba_stream_tbl *tx_ba_tsr_tbl, *found =3D NULL;
> +
> +	list_for_each_entry_rcu(tx_ba_tsr_tbl, &priv->tx_ba_stream_tbl_ptr[tid]=
, list) {
> +		if (ether_addr_equal_unaligned(tx_ba_tsr_tbl->ra, ra) &&
> +		    tx_ba_tsr_tbl->tid =3D=3D tid) {
> +			found =3D tx_ba_tsr_tbl;
> +			break;
> +		}
> +	}
> +	return found;
> +}

and this could just return directly out of the loop, and not need the
'found' variable?

> +	/* We don't wait for the response of this command */
> +	ret =3D nxpwifi_send_cmd(priv, HOST_CMD_11N_ADDBA_REQ,
> +			       0, 0, &add_ba_req, false);
> +
> +	return ret;

doesn't need 'ret' either


> +int nxpwifi_send_delba(struct nxpwifi_private *priv, int tid, u8 *peer_m=
ac,
> +		       int initiator)
> +{
> +	struct host_cmd_ds_11n_delba delba;
> +	int ret;
> +	u16 del_ba_param_set;
> +
> +	memset(&delba, 0, sizeof(delba));
> +
> +	del_ba_param_set =3D tid << DELBA_TID_POS;
> +
> +	if (initiator)
> +		del_ba_param_set |=3D IEEE80211_DELBA_PARAM_INITIATOR_MASK;
> +	else
> +		del_ba_param_set &=3D ~IEEE80211_DELBA_PARAM_INITIATOR_MASK;
> +
> +	delba.del_ba_param_set =3D cpu_to_le16(del_ba_param_set);
> +	memcpy(&delba.peer_mac_addr, peer_mac, ETH_ALEN);
> +
> +	/* We don't wait for the response of this command */
> +	ret =3D nxpwifi_send_cmd(priv, HOST_CMD_11N_DELBA,
> +			       HOST_ACT_GEN_SET, 0, &delba, false);
> +
> +	return ret;

same here

> +/* This function sends delba to specific tid
> + */
> +void nxpwifi_11n_delba(struct nxpwifi_private *priv, int tid)
> +{
> +	struct nxpwifi_rx_reorder_tbl *rx_reor_tbl_ptr;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(rx_reor_tbl_ptr, &priv->rx_reorder_tbl_ptr[tid]=
, list) {
> +		if (rx_reor_tbl_ptr->tid =3D=3D tid) {
> +			dev_dbg(priv->adapter->dev,
> +				"Send delba to tid=3D%d, %pM\n",
> +				tid, rx_reor_tbl_ptr->ta);
> +			nxpwifi_send_delba(priv, tid, rx_reor_tbl_ptr->ta, 0);
> +			goto exit;
> +		}
> +	}
> +exit:
> +	rcu_read_unlock();

guard() is nice to not have such patterns

> +static inline u8
> +nxpwifi_is_station_ampdu_allowed(struct nxpwifi_private *priv,
> +				 struct nxpwifi_ra_list_tbl *ptr, int tid)
> +{
> +	struct nxpwifi_sta_node *node;
> +	u8 ret;
> +
> +	rcu_read_lock();
> +	node =3D nxpwifi_get_sta_entry(priv, ptr->ra);
> +	if (unlikely(!node))
> +		ret =3D false;
> +	else
> +		ret =3D (node->ampdu_sta[tid] !=3D BA_STREAM_NOT_ALLOWED) ? true : fal=
se;
> +	rcu_read_unlock();
> +	return ret;


also here with guard() you don't need the variable and it's probably
easier to read/understand since it could just be

guard(rcu)();
node =3D ...;
if (!node) return false;
if (node->... =3D=3D NOT_ALLOWED) return false;
return true;

(modulo whitespace, obviously)

> +}
> +
> +/* This function checks whether AMPDU is allowed or not for a particular=
 TID. */
> +static inline u8
> +nxpwifi_is_ampdu_allowed(struct nxpwifi_private *priv,
> +			 struct nxpwifi_ra_list_tbl *ptr, int tid)

"is allowed" sounds boolean, the function returns boolean, but is
declared as returning u8.

> +/* This function checks whether AMSDU is allowed or not for a particular=
 TID.
> + */
> +static inline u8
> +nxpwifi_is_amsdu_allowed(struct nxpwifi_private *priv, int tid)


same

> +{
> +	return (((priv->aggr_prio_tbl[tid].amsdu !=3D BA_STREAM_NOT_ALLOWED) &&
> +		 (priv->is_data_rate_auto || !(priv->bitmap_rates[2] & 0x03)))
> +		? true : false);

might be nice to write that with multiple if statements perhaps, less
obfuscated ;-)

> +}
> +
> +/* This function checks whether a space is available for new BA stream o=
r not.
> + */
> +static inline u8
> +nxpwifi_space_avail_for_new_ba_stream(struct nxpwifi_adapter *adapter)

same, since it doesn't return how much space is available, just bool

> +/* This function checks whether associated station is 11n enabled
> + */
> +static inline int nxpwifi_is_sta_11n_enabled(struct nxpwifi_private *pri=
v,
> +					     struct nxpwifi_sta_node *node)


and here it's int, which is probably not much better than u8 for what
should be bool

(I'd almost think you could even instruct an LLM to find these so I'm
going to stop looking for them.)


Side note on the comment style: we removed quite a while ago the special
networking requirement for

 /* long ...
  * comment
  */

so feel free to

 /*
  * long ...
  * comment
  */

as everywhere else in the kernel.


But again I'm just briefly scanning through this (and will continue),
I'm not going to really review it in depth.

(One thing I also noticed is some misspellings of "MHz" as "Mhz", not
sure where though.)

johannes

