Return-Path: <linux-wireless+bounces-19577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62CEA49977
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4C31899268
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 12:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD01C24169E;
	Fri, 28 Feb 2025 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ud8xjHvs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585726AABF
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746200; cv=none; b=NLneoexkSGqAga31rQgukaVsqLzIzNd+El+ciyxIDMxLhunni2hmJq8VivQ4C2vNsI4I4psEhJargI4fMmjMXbxk3stZKhQ/vC+JZa7M0MSDfhc1rfU7Ci2Exri8CjciJQBiz8SvhfF2+OPg7OCwt185mYOUPlq9TmhFPbKfIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746200; c=relaxed/simple;
	bh=BlJkAPi7TtSThY++9j4bwryPcT/1pEspX86BgHiQUaQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FSP+oRJPfO5c6u8inac2oEgAE4PN5sCg2ZGEqsaOly4pUN8N0zd8RS6zuAJyi8fuq064C2+APs1pThQ1qjF+pGiIYWZmvDyzhf/GtdBhUrcBOE24lDId/IvwoozGNAn10iaTxDbvFe8nQAmLeBUfjtHk2XryuTC5uW05I/uJ/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ud8xjHvs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=a3QrVW6TwH9xFwBZFv/DZmk93f0848KDMZG173d60qw=;
	t=1740746199; x=1741955799; b=ud8xjHvsRo4jvKd4eBURkM8dQxPiSawDRsl5xfR5ZczcyAX
	PKNXN+8yVaYUs+ICpgXRo9e9YPWNZxesUR7dU8H6wBMXlyxKrB0/wOZ6UtOzXVv7NHges3RNby6y+
	M//OaUGplx1jLVLtFf1lPIThFbf19IvJrGOqdKH5cd7s3U5QDKVl2deNU7j+pfjYxmH2lU/b4cmAT
	Fz+9h9H3rvKReIekNX6e2vUfAISqlWf7NvbGXm2aJBCAZjs4HfsdUU+IQva0FrE2EbI+w2y1+IopF
	2xvRfkZl1qJqMZdVOg60Eer6F+aUSIEWNUTYsZOcW9+Lwar41yb6zzsLd9E66xpw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnzbX-0000000DjCM-1oji;
	Fri, 28 Feb 2025 13:36:35 +0100
Message-ID: <cb41175353348bbc56791c3bb0c38a42ac4fc6d8.camel@sipsolutions.net>
Subject: Re: [PATCH v2 3/3] wifi: ath12k: update EMLSR capabilities of ML
 Station
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, Ramasamy
 Kaliappan <quic_rkaliapp@quicinc.com>
Date: Fri, 28 Feb 2025 13:36:34 +0100
In-Reply-To: <20250117170416.2907530-4-quic_ramess@quicinc.com>
References: <20250117170416.2907530-1-quic_ramess@quicinc.com>
	 <20250117170416.2907530-4-quic_ramess@quicinc.com>
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

On Fri, 2025-01-17 at 22:34 +0530, Rameshkumar Sundaram wrote:
>=20
> +static u32 ath12k_wmi_get_emlsr_pad_delay_us(u16 eml_cap)
> +{
> +	/* IEEE Std 802.11be-2024 Table 9-417i=E2=80=94Encoding of the EMLSR
> +	 * Padding Delay subfield.
> +	 */
> +	u32 pad_delay =3D u16_get_bits(eml_cap, IEEE80211_EML_CAP_EMLSR_PADDING=
_DELAY);
> +	static const u32 pad_delay_us[EMLSR_PAD_DELAY_MAX] =3D {0, 32, 64, 128,=
 256};
> +
> +	if (pad_delay >=3D EMLSR_PAD_DELAY_MAX)
> +		return 0;
> +
> +	return pad_delay_us[pad_delay];
> +}
> +
> +static u32 ath12k_wmi_get_emlsr_trans_delay_us(u16 eml_cap)
> +{
> +	/* IEEE Std 802.11be-2024 Table 9-417j=E2=80=94Encoding of the EMLSR
> +	 * Transition Delay subfield.
> +	 */
> +	u32 trans_delay =3D u16_get_bits(eml_cap,
> +				       IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);
> +	static const u32 trans_delay_us[EMLSR_TRANS_DELAY_MAX] =3D {
> +		0, 16, 32, 64, 128, 256
> +	};
> +
> +	if (trans_delay >=3D EMLSR_TRANS_DELAY_MAX)
> +		return 0;
> +
> +	return trans_delay_us[trans_delay];
> +}
> +
> +static u32 ath12k_wmi_get_emlsr_trans_timeout_us(u16 eml_cap)
> +{
> +	/* IEEE Std 802.11be-2024 Table 9-417m=E2=80=94Encoding of the
> +	 * Transition Timeout subfield.
> +	 */
> +	u8 timeout =3D u16_get_bits(eml_cap, IEEE80211_EML_CAP_TRANSITION_TIMEO=
UT);
> +	static const u32 trans_timeout_us[EML_TRANS_TIMEOUT_MAX] =3D {
> +		0, 128, 256, 512,
> +		TU_TO_USEC(1),
> +		TU_TO_USEC((1U << 1)),
> +		TU_TO_USEC((1U << 2)),
> +		TU_TO_USEC((1U << 3)),
> +		TU_TO_USEC((1U << 4)),
> +		TU_TO_USEC((1U << 5)),
> +		TU_TO_USEC((1U << 6)),
> +	};
> +
> +	if (timeout >=3D EML_TRANS_TIMEOUT_MAX)
> +		return 0;
> +
> +	return trans_timeout_us[timeout];
> +}
>=20

Some of these should probably be in ieee80211.h, and also - making a
table of shifted values? That seems ... awkward at best?

static inline u32 ieee80211_emlsr_delay_in_us(u16 eml_cap)
{
	/* IEEE Std 802.11be-2024 Table 9-417j=E2=80=94Encoding of the EMLSR
	 * Transition Delay subfield.
	 */
	u32 trans_delay =3D u16_get_bits(eml_cap,
				       IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY);


	/* invalid values also just use 0 */
	if (!trans_delay ||
	    trans_delay > IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US)
		return 0;

	return 16 * (1 << (trans_delay - 1));
}

seems a lot more effective?

johannes

