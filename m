Return-Path: <linux-wireless+bounces-24545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62323AE9DD2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 14:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C547AC047
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 12:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913E2E0B72;
	Thu, 26 Jun 2025 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="scJ6KuU+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1241EB2F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942274; cv=none; b=DksvaEIQmjHKx7Xl47wrSkmWGFDQHARZ2fO+cxFXUgveYhzapTUQXS7+oL/YEjdGs+tLH59Oq1ag2dDBJuSjNe/d/N+EhRwuGNtmGX8ViaFSJ+J+LlweUpT4WIlCpYQrEruAmyCcKaKvdyf91Z3yhHJim6Yg5tz1h80xLbZWO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942274; c=relaxed/simple;
	bh=6RyCZAVHE8tO2dd+1cgIIG6QdA1XUM82v2LhoFio33w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QLH4+V5eT8gEqP7AfruatHxdVDW2O2RP+93m632TWL3jvCU7mOkxud2lkZIbNbKcyUNU6GlM4w9cQemwWiueLAHBiI1Cx645FOaz9eriZ0z3q1BbUm73i9Q/IV8Y/vkOyYNYce/iYIe+AjkGGlvRK5sWet1lerVu6te1jEXDYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=scJ6KuU+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s5Em1+2Dl/8Na3maupvgcxRVVzKcJD1iBgXt9epwcy8=;
	t=1750942272; x=1752151872; b=scJ6KuU+bdiUGB8lFra0vXynqHHI8S6dFcBmOhBsYa308hp
	6rxoYvJ+zgtGdcKj3HSicTCnZlXby+JP2HwYV0C5ZuaIvvpPyqrO3cYVx+i2/KT2swNfD5stuN0+0
	SDLFul8/7vCvonEqz56o3ikoRZ7lQ0MAAw2jInRb1Iwr+bR97z33gGDT83IcqfbhR9nQquKwVFADZ
	QqXWISRuIYLS7wTTSvBHvzO2kMwCU/Ct8Co1aGn9iqcaxeWrETSps2ExtS1jXJMlWBcyk3x/rmyjb
	ilxy9YajFgd4T7Kp3ZiAnT8keYEyUbKy4Y5R7/Rk3LyK8DXNpoMI7bjBuw8wCjgw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUm4L-0000000BXm7-0lB6;
	Thu, 26 Jun 2025 14:51:09 +0200
Message-ID: <7e465c62d96c872e1f75a35d4f3d1f058d237cfc.camel@sipsolutions.net>
Subject: Re: [RFC 2/5] wifi: nl80211: Add more NAN capabilities
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 26 Jun 2025 14:51:08 +0200
In-Reply-To: <20250622222444.356435-3-andrei.otcheretianski@intel.com> (sfid-20250623_002842_027258_89DFA3E1)
References: <20250622222444.356435-1-andrei.otcheretianski@intel.com>
	 <20250622222444.356435-3-andrei.otcheretianski@intel.com>
	 (sfid-20250623_002842_027258_89DFA3E1)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-06-23 at 01:24 +0300, Andrei Otcheretianski wrote:
> Add better break down for NAN capabilities, as NAN has multiple optional
> features. This allows to better indicate which features are supported or
> or offloaded to the device.
>=20
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> ---
>  include/uapi/linux/nl80211.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index a68c486e2083..f2d4a2007463 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -2915,6 +2915,10 @@ enum nl80211_commands {
>   *	%NL80211_CMD_START_NAN and %NL80211_CMD_CHANGE_NAN_CONFIG.
>   *	See &enum nl80211_nan_conf_attributes for details.
>   *	This attribute is optional.
> + * @NL80211_ATTR_NAN_CAPABILITIES: Nested attribute for NAN capabilities=
.
> + *	This is used with %NL80211_CMD_GET_WIPHY to indicate the NAN
> + *	capabilities supported by the driver. See &enum nl80211_nan_capabilit=
ies
> + *	for details.
>   *
>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>   * @NL80211_ATTR_MAX: highest attribute number currently defined
> @@ -3474,6 +3478,7 @@ enum nl80211_attrs {
>  	NL80211_ATTR_ASSOC_MLD_EXT_CAPA_OPS,
> =20
>  	NL80211_ATTR_NAN_CONFIG,
> +	NL80211_ATTR_NAN_CAPABILITIES,
>  	/* add attributes here, update the policy in nl80211.c */
> =20
>  	__NL80211_ATTR_AFTER_LAST,
> @@ -8226,4 +8231,35 @@ enum nl80211_wiphy_radio_freq_range {
>  	NL80211_WIPHY_RADIO_FREQ_ATTR_MAX =3D __NL80211_WIPHY_RADIO_FREQ_ATTR_L=
AST - 1,
>  };
> =20
> +/**
> + * enum nl80211_nan_capabilities - NAN (Neighbor Aware Networking)
> + *	capabilities.
> + *
> + * @__NL80211_NAN_CAPABILITIES_INVALID: Invalid.
> + * @NL80211_NAN_CAPA_SYNC_OFFLOAD: Flag attribute indicating that
> + *	NAN synchronization offload is supported. If this capability is set,
> + *	the driver must be able to handle %NL80211_ATTR_NAN_CONFIG
> + *	attribute in the %NL80211_CMD_START_NAN (and change) command.
> + * @NL80211_NAN_CAPA_DE_OFFLOAD: Flag attribute indicating that
> + *	NAN Discovery Engine (DE) offload is supported. Drivers/devices that =
set
> + *	this capability must be able to handle %NL80211_CMD_ADD_NAN_FUNCTION,
> + *	%NL80211_CMD_DEL_NAN_FUNCTION and %NL80211_CMD_NAN_MATCH commands.
> + * @NL80211_NAN_CAPA_DW_NOTIF_SUPPORT: Flag attribute indicating that
> + *	the device supports notifying user space about the upcoming
> + *	discovery window (DW) using %NL80211_CMD_NAN_NEXT_DW_NOTIFICATION.
> + *
> + * @__NL80211_NAN_CAPABILITIES_LAST: Internal
> + * @NL80211_NAN_CAPABILITES_MAX: Highest NAN capability attribute.
> + */
> +enum nl80211_nan_capabilities {
> +	__NL80211_NAN_CAPABILITIES_INVALID,
> +
> +	NL80211_NAN_CAPA_SYNC_OFFLOAD,
> +	NL80211_NAN_CAPA_DE_OFFLOAD,
> +	NL80211_NAN_CAPA_DW_NOTIF_SUPPORT,

This seems complex, why not just add three new extended flags?

johannes

