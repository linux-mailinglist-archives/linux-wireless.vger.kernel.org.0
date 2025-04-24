Return-Path: <linux-wireless+bounces-22007-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E40A9B1AA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 17:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67C61B808F4
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41CF19C554;
	Thu, 24 Apr 2025 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ftx1BgOa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4892701C1;
	Thu, 24 Apr 2025 15:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507263; cv=none; b=DEP5A10pcKuJkOzQYC+LPdRaHe1C9CP8SV7RY2aV2rxmaQQwouJxYpW9XKtpaj7G4krmeZksFY+Nan5HAoMPKIxm4YT+WR4rbSs4rEodvDVp5wvs9Ei8fmcbqr03QSheBwPmqzFgj0P7KDJHT2JPKPFSjvpf5z0kIZxpNb/uiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507263; c=relaxed/simple;
	bh=xk2GRBY750TwszttNFyXLeYPgO0ZG5/i9N1Bc2Z1fGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BnadKRi9dsaD8N3cMFaaR5gjvH0bBGu4BJ9z1EzUKyE/4vLL3hu90C4huNk5mMj5xYb1ZFpXVy6Ehky4pkFX6Ue0jt/e1TtVPYyTfiI/SPhZA2tTqyPODKNKbvaiYMaA2lpPDA/VsFirXOs6V8U0Cq7gJMPc8LCkMITW3fNxpuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ftx1BgOa; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A5e4j/jtYATU7avKCEo1DM3FNXJct3asQ+rGyfJl/tU=;
	t=1745507262; x=1746716862; b=Ftx1BgOah57YvQ7mgk/YaZqPTiZXqXDGhm79Ei/RFAW87px
	sMGikKE6ZyW2sKVDYTaTeqsl/WWE59OWXUrzpA+L5Le+rrlXUYjflaYF08h01utjlNAfTQa3G1KZl
	tqXFqCDQPhutp8ZWk9aLVphHSliBKkZ2TK+1veA15K8JpbROru4Ve3KH8YJVu3/U1ry7fERvcGlZb
	+JWrqZI6lHxYel/6W9WOt0razm3E4crPaeA+sve0Z+ONC52O2658O73lB25VsOoY7WYzzAreEo5e7
	QPDTyGbf1PQqcNiSr/5PAGwgr4ZzMJZcOoviBlhgJ6lOBi+i766zUp6vK8mRxH6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7yAt-0000000HPbn-0WT1;
	Thu, 24 Apr 2025 17:07:39 +0200
Message-ID: <45b74f9f0831294e783a019cd6a1437fdad4eb6a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 2/2] wifi: Add Nordic nRF70 series Wi-Fi driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Artur Rojek <artur@conclusive.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood
	 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sascha Hauer
	 <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Klama <jakub@conclusive.pl>, Wojciech
 Kloska	 <wojciech@conclusive.pl>, Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Date: Thu, 24 Apr 2025 17:07:38 +0200
In-Reply-To: <20250422175918.585022-3-artur@conclusive.pl>
References: <20250422175918.585022-1-artur@conclusive.pl>
	 <20250422175918.585022-3-artur@conclusive.pl>
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

On Tue, 2025-04-22 at 19:59 +0200, Artur Rojek wrote:
> Introduce support for Nordic Semiconductor nRF70 series wireless
> companion IC.

Seems simple enough ... but I notice you're not even adding a
MAINTAINERS file entry. Does that mean you're not going to stick around
to maintain it at all? I'm definitely _not_ going to. Please don't
expect the community to.

Are you doing this for your customers? Or are you just doing this a
contract for someone who needs it? I don't really care all that much but
contracts have a tendency to go away and then we're left with nothing
upstream ...

Also, related, what are your plans to help out with wireless in general,
particularly reviews? You're building on the shoulders of everyone who
did work before ... I'll do a _very_ cursory review, but if you want to
get this merged I would expect you to also become a part of the
community and help review other people's code:

https://lore.kernel.org/linux-wireless/21896d2788b8bc6c7fcb534cd43e75671a57=
f494.camel@sipsolutions.net/

> +config NRF70
> +	tristate "Nordic Semiconductor nRF70 series wireless companion IC"
> +	depends on CFG80211 && INET && SPI_MEM && CPU_LITTLE_ENDIAN

That CPU_LITTLE_ENDIAN seems like a cop-out. Do we really want that?
Asking not specifically you I guess...


> +#define	NRF70_RADIOTAP_PRESENT_FIELDS				\
> +	cpu_to_le32((1 << IEEE80211_RADIOTAP_RATE) |		\
> +		    (1 << IEEE80211_RADIOTAP_CHANNEL) |		\
> +		    (1 << IEEE80211_RADIOTAP_DBM_ANTSIGNAL))

You did some work on making it little endian properly ..


> +
> +#define	NRF70_FW_FEATURE_RAW_MODE	BIT(3)
> +struct __packed nrf70_fw_header {
> +	u32 signature;
> +	u32 num_images;
> +	u32 version;
> +	u32 feature_flags;
> +	u32 length;
> +	u8 hash[NRF70_FW_HASH_LEN];
> +	u8 data[];
> +};
> +
> +struct __packed nrf70_fw_img {
> +	u32 type;
> +	u32 length;
> +	u8 data[];
> +};

making the u32's here __le32's (and fixing sparse) would probably go a
long way of making it endian clean. The __packed is also placed oddly.

> +static int nrf70_verify_firmware(struct device *dev,
> +				 const struct nrf70_fw_header *fw)


What's the point in doing this? The hash is trivially adjusted if
someone wants to play with the file, if hw doesn't check anything, and
... not sure we really need such a thing for "file is corrupt by
accident"? *shrug*

> +	ret =3D request_firmware(&firmware, "nrf70.bin", dev);


You might want to make that async so that the driver can be built-in
without requiring the firmware to also be built-in.

> +	if (ret < 0) {
> +		dev_err(dev, "Failed to request firmware: %d\n", ret);
> +		return ret;
> +	}
> +
> +	header =3D (const struct nrf70_fw_header *)firmware->data;

(const void *) cast would probably be sufficient


> +	return ret ? ret : (wait_for_completion_timeout(&priv->init_done, HZ) ?
> +			    0 : -ETIMEDOUT);

that construct seems a bit questionable :)


> +static void nrf70_handle_rx_mgmt(struct spi_mem *mem,
> +				 struct nrf70_event_mlme *ev)
> +{
> +	struct nrf70_priv *priv =3D spi_mem_get_drvdata(mem);
> +	struct nrf70_vif *vif =3D nrf70_get_vif(priv, ev->header.idx.wdev_id);
> +
> +	if (IS_ERR(vif))
> +		return;
> +
> +	(void)cfg80211_rx_mgmt(&vif->wdev, ev->frequency, ev->rx_signal_dbm,
> +			       ev->frame.data, ev->frame.len, ev->wifi_flags);


shouldn't need the (void) cast?


> +static int nrf70_change_bss(struct wiphy *wiphy, struct net_device *ndev=
,
> +			    struct bss_parameters *params)


See also this discussion:
https://lore.kernel.org/linux-wireless/29fa5ea7f4cc177bed823ec3489d610e1d69=
a08f.camel@sipsolutions.net/

> +static int nrf70_dequeue_umac_event(struct spi_mem *mem, void *data)
> +{
> +	struct nrf70_priv *priv =3D spi_mem_get_drvdata(mem);
> +	struct device *dev =3D &mem->spi->dev;
> +	struct nrf70_umac_header *header =3D data;
> +	struct nrf70_vif *vif =3D nrf70_get_vif(priv, header->idx.wdev_id);
> +	struct cfg80211_scan_info scan_info =3D { .aborted =3D true };
> +
> +	if (IS_ERR(vif))
> +		return PTR_ERR(vif);
> +
> +	switch (header->id) {
> +	case NRF70_UMAC_EVENT_TRIGGER_SCAN_START:
> +		break;


This sounds like you pretty much built the firmware for cfg80211 ;-)


> +#define	NRF70_MSG_SYSTEM		0
> +#define	NRF70_MSG_DATA			2
> +#define	NRF70_MSG_UMAC			3
> +
> +struct __packed nrf70_msg {
> +	u32 len;
> +	u32 resubmit;
> +	u32 type;
> +	u8 data[];


similar comments here throughout this entire file wrt __packed and
__le32, obviously

> +/* Undocumented PHY configuration parameters. */
>=20

haha :)


Oh and before I forget, how about firmware availability?

johannes

