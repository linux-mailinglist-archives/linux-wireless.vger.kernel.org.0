Return-Path: <linux-wireless+bounces-19576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4FCA4995D
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 13:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6559A1899FA1
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2025 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE123E35A;
	Fri, 28 Feb 2025 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="In0yZ0JD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434A1C3BE3
	for <linux-wireless@vger.kernel.org>; Fri, 28 Feb 2025 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745971; cv=none; b=oVpkgxjvKamtRBWIMKQLUe3BJ6RN7DPpV7AYchiIKT34jqXO+h0MdjIRYD5GoZqOZN0774aXKhx7aoV24rR4rAjhpDH49MWEy88C7D6sN6FxnVKwNKG+cGdpGdH2g6MfeDEispVTcZpcWIVzwZ4/p8YAUR+BoeHuT5mK89DcQHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745971; c=relaxed/simple;
	bh=2ZDPnR/QmHCBvqaMksu8w0EWtg2+5MM1GLtDQWbwmOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ijXkqxXRofNwUpmBhe0hKSzPEtE7Md+ULiD9ia+Q2EwbIjmNkbgFZB+nta3T7iOeu60+cquzJCmzXKOyY71TxYxnI2xBiKor5P9F10YkdjqV66HdPWo2qyb0G/iQYE95Mwt/nCoT87c37MI7fBIiV8vt6jm9dFnah6w6cGj6h8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=In0yZ0JD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oUy9M5HV9p9S6goYWBEtQkOjb1wmn3X9SwMBmIALgzs=;
	t=1740745969; x=1741955569; b=In0yZ0JDZBRcY3ThjnXMsOpCc0KkrT/2SErPqyZce6i9rLE
	sJjEwQq/ePCe2Zp4BN3yfeZb7fZ+G26AqMbCRL20sbP4lXBGzg1LkJxieJPyKkxgpMgsoEgy0Bl/m
	TbXIhhTj1Ho5WzCdlkHWq1Y8H/oQFg6riw5nmw1/HenblOeStIdRsD+YXJYxvbCrpMk7RBHIKNBBY
	pVdmis1wHnYIzbXocNXta5QbxPcA/x1EYSCdg6lsGGTSOuePSESKZWf8XLx0m/vnEvkJG0ZbcJhzI
	1qefxfBBL8utBgLMhc2nGamFhINEcEhN2E/6tMfzjSiRG5iN/qKYXNy2qc1TdmPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnzXp-0000000Dj2c-2rQD;
	Fri, 28 Feb 2025 13:32:45 +0100
Message-ID: <66e4ec1984c816bd8e0a95a8bced753d780e30fe.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/3] wifi: cfg80211: Add support to get EMLSR
 capabilities of non-AP MLD
From: Johannes Berg <johannes@sipsolutions.net>
To: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, Ramasamy
 Kaliappan <quic_rkaliapp@quicinc.com>
Date: Fri, 28 Feb 2025 13:32:44 +0100
In-Reply-To: <20250117170416.2907530-2-quic_ramess@quicinc.com>
References: <20250117170416.2907530-1-quic_ramess@quicinc.com>
	 <20250117170416.2907530-2-quic_ramess@quicinc.com>
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
>  include/net/cfg80211.h |  5 +++++
>  net/wireless/nl80211.c | 12 ++++++++++++
>  2 files changed, 17 insertions(+)
>=20
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 363d7dd2255a..7a80dbf37881 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1756,6 +1756,9 @@ struct cfg80211_ttlm_params {
>   * @supported_oper_classes_len: number of supported operating classes
>   * @support_p2p_ps: information if station supports P2P PS mechanism
>   * @airtime_weight: airtime scheduler weight for this station
> + * @eml_cap_present: Specifies if EML capabilities field (@eml_cap) is
> + *	present/updated
> + * @eml_cap: EML capabilities of this station
>   * @link_sta_params: link related params.
>   */
>  struct station_parameters {
> @@ -1780,6 +1783,8 @@ struct station_parameters {
>  	u8 supported_oper_classes_len;
>  	int support_p2p_ps;
>  	u16 airtime_weight;
> +	bool eml_cap_present;
> +	u16 eml_cap;
>  	struct link_station_parameters link_sta_params;
>  };

OK, I get that this is the minimal change that actually makes this work,
but it seems a bit lazy to me. Allow me to explain: You don't actually
_want_ - nor even implement in patch 3 - this changing at any point in
runtime. OTOH, you _do_ need it to change after the station is
allocated, because in auth frame exchange you don't have the information
yet, and that's when the MLD is added.

So I really think this ought to be accompanied with a change to
cfg80211_check_station_change() that disallows changing this while the
station is already associated?

johannes

