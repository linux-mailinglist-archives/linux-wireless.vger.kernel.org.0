Return-Path: <linux-wireless+bounces-32144-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPCFNLfSnWk0SQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32144-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 17:32:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A902189D1E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 17:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F77F3035008
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 16:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DBE1C01;
	Tue, 24 Feb 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uDNF1S/g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5D3EBF36
	for <linux-wireless@vger.kernel.org>; Tue, 24 Feb 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771950771; cv=none; b=LwW4VDRkQpjc2Fjh/QTSRQdpFXiISIi775dFFmo6ipLKfslQoyxrXvwD5f08rDp85O7TlVu3XA6zjgxWYwmYXQoevSWBSMoo3bJh7223TN7R8rYdzhuv13JluWxbiWBT5cl1UwHPAEwXmgI23n2N5HSJtKfHEQlvy043M7XtIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771950771; c=relaxed/simple;
	bh=btJrIctmAeaqLJgr0KDJAy4Ei1EICttVTcBVBuIb/Jg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jOaFmTZdVmAExX3vc9BBOzNApp3doEKoeW/TdLRahDkfDPV8z+1BFZ56DIjYj7o/me1SycmRnirSaubXIyLesOV/81BTT9+HLbNETDVU13BV37PbbZH/fXRJp2GMNcggzZplscbDD9omG+L4NcOsGUqenPVd2VtIP1P7aGnDUZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uDNF1S/g; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=I7s68uXsBpn07ISulnoxeZXviiuIzaCDqnb/9BfZd+0=;
	t=1771950770; x=1773160370; b=uDNF1S/gUIiPvnyesgzpl/ytFctklwOFtyOb5lIlfNIoM3L
	ctnsXDwuRbvRD+gpi4SIRc9XyMMzbSe1uDP9YC17Bhwz/eIeXkcDJo8nlWaFQwrJS+lhy4iC5I05h
	ghu+br5d4q5VFhNqQCnVvdtN5YGIoDXSfjwPN9WqNfJuJgqCz/ChS7aSfwx09rHr6FIvCQRu/WgCr
	JLShOHLCDKE5dFFLhbbCwJ39H6iXS0n+hSzcQKGlzhez7fwAweBJcKhh9dZvXAPyM1UFzz+2NbRec
	V1znJNl3zRfsiGxSlCixGjK9bcibS9WRppb7B8BVgx4dwMu7K8jdaUjcqbbmpMOg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vuvL4-00000000a0T-1BiD;
	Tue, 24 Feb 2026 17:32:46 +0100
Message-ID: <6cec588857a8fa5866b3aff323c367b0096e613a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 1/2] wifi: UHR: define DPS/DBE/P-EDCA
 elements and fix size parsing
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Date: Tue, 24 Feb 2026 17:32:45 +0100
In-Reply-To: <20260217054731.3667600-2-karthikeyan.kathirvel@oss.qualcomm.com>
References: 
	<20260217054731.3667600-1-karthikeyan.kathirvel@oss.qualcomm.com>
	 <20260217054731.3667600-2-karthikeyan.kathirvel@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32144-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 6A902189D1E
X-Rspamd-Action: no action

On Tue, 2026-02-17 at 11:17 +0530, Karthikeyan Kathirvel wrote:
>=20
> + * Refer to IEEE80211_UHR_P_EDCA*
> + * @p_edca_ec: The P-EDCA ECWmin, P-EDCA and ECWmax

that seems unclear?


> + * @p_edca_params: The AIFSN field indicate the AIFSN value that are

"indicates", "value that is used"? I think it's one? Or "values that are
used"

> + *	used by a P-EDCA STA during P-EDCA contention.
> + *	The CW DS field indicate the value used

indicates

> + *	for the randomization of the transmission slot of the DS-CTS
> + *	frame. The value 3 is reserved. The value 0 indicate that

indicates

> + *	randomization not enabled.
> + *	The P-EDCA PSRC threshold field indicates the maximum number
> + *	of allowed consecutive DS-CTS transmissions. The value 0 and
> + *	values greater than 4 are reserved
> + *	The P-EDCA QSRC threshold field indicates the value of the
> + *	QSRC[AC_VO] counter to be allowed to start P-EDCA contention.
> + *	The value 0 is reserved.
> + */
> +struct ieee80211_uhr_p_edca_info {
> +	u8 p_edca_ec;
> +	__le16 p_edca_params;
> +} __packed;
> +
>  static inline bool ieee80211_uhr_oper_size_ok(const u8 *data, u8 len,
>  					      bool beacon)
>  {
> @@ -47,19 +232,52 @@ static inline bool ieee80211_uhr_oper_size_ok(const =
u8 *data, u8 len,
>  	if (beacon)
>  		return true;
> =20
> -	/* FIXME: DPS, DBE, P-EDCA (consider order, also relative to NPCA) */
> +	/* DPS Operation Parameters (fixed 4 bytes) */
> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DPS_ENA)) {
> +		needed +=3D sizeof(struct ieee80211_uhr_dps_info);
> +		if (len < needed)
> +			return false;
> +	}
> =20
> +	/* NPCA Operation Parameters (fixed 4 bytes + optional 2 bytes) */
>  	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)) {
>  		const struct ieee80211_uhr_npca_info *npca =3D
> -			(const void *)oper->variable;
> +			(const void *)(data + needed);
> =20
>  		needed +=3D sizeof(*npca);
> -
>  		if (len < needed)
>  			return false;
> =20
> -		if (npca->params & cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMA=
P_PRES))
> +		if (npca->params &
> +		    cpu_to_le32(IEEE80211_UHR_NPCA_PARAMS_DIS_SUBCH_BMAP_PRES)) {
>  			needed +=3D sizeof(npca->dis_subch_bmap[0]);
> +			if (len < needed)
> +				return false;
> +		}
> +	}
> +
> +	/* P-EDCA Operation Parameters (fixed 3 bytes) */
> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_PEDCA_ENA)) {
> +		needed +=3D sizeof(struct ieee80211_uhr_p_edca_info);
> +		if (len < needed)
> +			return false;
> +	}
> +
> +	/* DBE Operation Parameters (fixed 1 byte + optional 2 bytes) */
> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DBE_ENA)) {
> +		const struct ieee80211_uhr_dbe_info *dbe =3D
> +			(const void *)(data + needed);
> +
> +		needed +=3D sizeof(*dbe);
> +		if (len < needed)
> +			return false;
> +
> +		if (dbe->dbe_params &
> +		    IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP_PRES) {
> +			needed +=3D sizeof(dbe->dis_subch_bmap[0]);
> +			if (len < needed)
> +				return false;
> +		}
>  	}
> =20
>  	return len >=3D needed;
> @@ -72,12 +290,15 @@ static inline bool ieee80211_uhr_oper_size_ok(const =
u8 *data, u8 len,
>  static inline const struct ieee80211_uhr_npca_info *
>  ieee80211_uhr_npca_info(const struct ieee80211_uhr_operation *oper)
>  {
> +	const u8 *pos =3D oper->variable;
> +
>  	if (!(oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_NPCA_ENA)))
>  		return NULL;
> =20
> -	/* FIXME: DPS */
> +	if (oper->params & cpu_to_le16(IEEE80211_UHR_OPER_PARAMS_DPS_ENA))
> +		pos +=3D sizeof(struct ieee80211_uhr_dps_info);
> =20
> -	return (const void *)oper->variable;
> +	return (const void *)pos;
>  }
> =20
>  static inline const __le16 *
> @@ -131,6 +352,25 @@ ieee80211_uhr_npca_dis_subch_bitmap(const struct iee=
e80211_uhr_operation *oper)
>  #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_160_PRES	0x08
>  #define IEEE80211_UHR_MAC_CAP_DBE_EHT_MCS_MAP_320_PRES	0x10
> =20
> +/**
> + * enum ieee80211_dbe_bandwidth - DBE Bandwidth
> + *
> + * As per spec P802.11bn_D1.3 "Table 9-bb5=E2=80=94Encoding of the DBE M=
aximum
> + * Supported Bandwidth field"
> + *
> + * @IEEE80211_DBE_BANDWIDTH_40MHZ: Indicate 40 MHz DBE bandwidth
> + * @IEEE80211_DBE_BANDWIDTH_80MHZ: Indicate 80 MHz DBE bandwidth
> + * @IEEE80211_DBE_BANDWIDTH_160MHZ: Indicate 160 MHz DBE bandwidth
> + * @IEEE80211_DBE_BANDWIDTH_320MHZ: Indicate 320 MHz DBE bandwidth
> + *
> + */
> +enum ieee80211_dbe_bandwidth {
> +	IEEE80211_DBE_BANDWIDTH_40MHZ =3D 1,
> +	IEEE80211_DBE_BANDWIDTH_80MHZ =3D 2,
> +	IEEE80211_DBE_BANDWIDTH_160MHZ =3D 3,
> +	IEEE80211_DBE_BANDWIDTH_320MHZ =3D 4,
> +};
> +
>  struct ieee80211_uhr_cap_mac {
>  	u8 mac_cap[5];
>  } __packed;

