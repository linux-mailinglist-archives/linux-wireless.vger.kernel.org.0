Return-Path: <linux-wireless+bounces-21029-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3623AA77D67
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 16:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C08188E29B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 14:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDA81FAC55;
	Tue,  1 Apr 2025 14:11:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DEC204C14
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743516708; cv=none; b=OpX1Vi/XNnlepaQ4o+5zszETyWbu1C7mRKXHsQSrjDADPbddDPbaSb34MYll3Z3YuALrA01Uo8jJkJ8YVNEJFJWD56fETHKxhO8fuOLz9CussFXjq8iu3MQG5qBABj5SirvQydnMskGBhXR0Ji8Oly+vWfzacj4LT+ga6VS0vXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743516708; c=relaxed/simple;
	bh=F1W0xEPqXQqycTguxmL8KdIBjj6Td8eOcphQVS/tn+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPuK0b+ejmMwLNqjHKyPV/8uJwSoYqWPzE8iG4Cc94yust8TYmGa7TaiinPsS8FUIALY9WI8I+taMqy/FllnfCPzlRrHWPtnL6C80LIdZ3yHJ7Nu16MsP+Et+EwHyhkjnVJNdSKBUZ7hoEO0CSvkEb03NNIg8rk3WhZPTqTezus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1tzcL0-0002aw-Qk; Tue, 01 Apr 2025 16:11:34 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tzcL0-002mKt-0P;
	Tue, 01 Apr 2025 16:11:34 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1tzcL0-00DgTO-05;
	Tue, 01 Apr 2025 16:11:34 +0200
Date: Tue, 1 Apr 2025 16:11:34 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Artur Rojek <artur@conclusive.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Subject: Re: [RFC PATCH 1/2] net: wireless: Add Nordic nRF70 series Wi-Fi
 driver
Message-ID: <Z-v0Ftp-oIJ0zIPR@pengutronix.de>
References: <20250324211045.3508952-1-artur@conclusive.pl>
 <20250324211045.3508952-2-artur@conclusive.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324211045.3508952-2-artur@conclusive.pl>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi Artur,

Some review feedback inside.

As a general remark there are several functions returning 1 or -1 in
case of errors. Although they seem to be used only internally in the
driver it's far too easy to forward these errors to other kernel code
with future changes, so better return error codes instead.


On Mon, Mar 24, 2025 at 10:10:44PM +0100, Artur Rojek wrote:
> +
> +static struct nrf70_mem_op {
> +	int op;
> +	int width;
> +	int dummy;
> +	enum spi_mem_data_dir dir;
> +} nrf70_read_ops[] = {
> +	{ NRF70_OP_RD4, 4, 3, SPI_MEM_DATA_OUT },
> +	{ NRF70_OP_FASTRD, 1, 1, SPI_MEM_DATA_OUT },
> +}, nrf70_write_ops[] = {
> +	{ NRF70_OP_PP4, 4, 0, SPI_MEM_DATA_IN },
> +	{ NRF70_OP_PP, 1, 0, SPI_MEM_DATA_IN },
> +};

Should be const.

> +static int nrf70_load_firmware(struct spi_mem *mem)
> +{
> +	struct device *dev = &mem->spi->dev;
> +	struct nrf70_priv *priv = spi_mem_get_drvdata(mem);
> +	const struct nrf70_fw_header *header;
> +	const struct nrf70_fw_img *image;
> +	const struct firmware *firmware;
> +	int val, i, ret;
> +	u32 type, len;
> +
> +	/* Perform RPU MCU reset. */
> +	nrf70_writel(mem, NRF70_SBUS_MIPS_MCU_CONTROL, 0x1);
> +
> +	if (read_poll_timeout(nrf70_readl, val, !(val & 0x1),
> +			      10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +			      mem, NRF70_SBUS_MIPS_MCU_CONTROL)) {
> +		dev_err(dev, "Unable to reset LMAC\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (read_poll_timeout(nrf70_readl, val, val & 0x1,
> +			      10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +			      mem, NRF70_SBUS_CP0_SLEEP_STATUS)) {
> +		dev_err(dev, "Unable to reset LMAC2\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	nrf70_writel(mem, NRF70_SBUS_MIPS_MCU2_CONTROL, 0x1);
> +
> +	if (read_poll_timeout(nrf70_readl, val, !(val & 0x1),
> +			      10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +			      mem, NRF70_SBUS_MIPS_MCU2_CONTROL)) {
> +		dev_err(dev, "Unable to reset UMAC\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (read_poll_timeout(nrf70_readl, val, val & 0x1,
> +			      10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, false,
> +			      mem, NRF70_SBUS_CP1_SLEEP_STATUS)) {
> +		dev_err(dev, "Unable to reset UMAC2\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	ret = request_firmware(&firmware, "nrf70.bin", dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to request firmware: %d\n", ret);
> +		return ret;
> +	}
> +
> +	header = (const struct nrf70_fw_header *)firmware->data;
> +	if (header->signature != NRF70_FW_SIGNATURE) {
> +		dev_err(dev, "Invalid firmware signature\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = nrf70_verify_firmware(dev, header);
> +	if (ret)
> +		goto out;
> +
> +	priv->has_raw_mode = header->feature_flags & NRF70_FW_FEATURE_RAW_MODE;
> +
> +	image = (const struct nrf70_fw_img *)header->data;
> +
> +	for (i = 0; i < header->num_images; i++) {
> +		type = image->type;
> +		if (type > 3) {

type >= ARRAY_SIZE(nrf_rpu_addr_lut)

> +static int nrf70_init_rx_command(struct spi_mem *mem)
> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; ret || i < NRF70_NUM_RX_BUFS; i++)
> +		ret = nrf70_init_rx(mem, i);

I think the loop break condition should be

	!ret && i < NRF70_NUM_RX_BUFS

This is rather hard to read though, so I suggest a plain

	for () {
		ret = nrf70_init_rx();
		if (ret)
			return ret;
	}

> +
> +	return ret;
> +}
> +
> +static struct nrf70_msg *nrf70_create_msg(u32 type, u32 id, size_t data_len,
> +					  int iface)
> +{
> +	struct nrf70_msg *msg;
> +	union cmd_header {
> +		struct __packed nrf70_header sys;
> +		struct __packed nrf70_umac_header umac;
> +	} *hdr;
> +	size_t len = sizeof(*msg) + data_len;
> +
> +	msg = kzalloc(len, GFP_KERNEL);
> +	if (!msg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	msg->type = type;
> +	msg->len = len;
> +
> +	hdr = (union cmd_header *)msg->data;
> +	switch (type) {
> +	case NRF70_MSG_SYSTEM:
> +		fallthrough;
> +	case NRF70_MSG_DATA:
> +		hdr->sys.id = id;
> +		hdr->sys.len = data_len;
> +	break;

This break is misaligned.

> +	case NRF70_MSG_UMAC:
> +		hdr->umac.id = id;
> +		if (iface >= 0) {
> +			hdr->umac.idx.wdev_id = iface;
> +			hdr->umac.idx.valid_fields = NRF70_UMAC_ID_WDEV;
> +		}
> +	break;

ditto

> +	default:
> +		kfree(msg);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return msg;
> +}
> +
> +static const u8 nrf7002_qfn_rf_params[NRF70_RF_PARAMS_SZ] = {
> +	NRF70_RESERVED,
> +	NRF70_RESERVED,
> +	NRF70_RESERVED,
> +	NRF70_RESERVED,
> +	NRF70_RESERVED,
> +	NRF70_RESERVED,
> +	/* XO */
> +	NRF70_QFN_XO_VAL,

You could create defines for the array offsets instead of the values and use
C99 initializers here. For example

#define NRF70_QFN_XO_VAL_OFFSET	6

and then:

	[NRF70_QFN_XO_VAL_OFFSET] = 0x2a,

That way the offsets are immediately clear without counting the array
members.

With this having defines for the values is IMO rather unnecessary then
as these are magic values anyway and usage of C99 initializers already
makes their meaning clear.

> +	/* PD adjust values for MCS7. Currently unused. */
> +	NRF70_PD_ADJUST_VAL,
> +	NRF70_PD_ADJUST_VAL,
> +	NRF70_PD_ADJUST_VAL,
> +	NRF70_PD_ADJUST_VAL,
> +	/* TX power systematic offset. */
> +	NRF70_SYSTEM_OFFSET_LB,
> +	NRF70_SYSTEM_OFFSET_HB_CHAN_LOW,
> +	NRF70_SYSTEM_OFFSET_HB_CHAN_MID,
> +	NRF70_SYSTEM_OFFSET_HB_CHAN_HIGH,
> +	/* Max TX power value for which both EVM and SEM pass. */
> +	NRF70_QFN_MAX_TX_PWR_DSSS,
> +	NRF70_QFN_MAX_TX_PWR_LB_MCS7,
> +	NRF70_QFN_MAX_TX_PWR_LB_MCS0,
> +	NRF70_QFN_MAX_TX_PWR_HB_LOW_CHAN_MCS7,
> +	NRF70_QFN_MAX_TX_PWR_HB_MID_CHAN_MCS7,
> +	NRF70_QFN_MAX_TX_PWR_HB_HIGH_CHAN_MCS7,
> +	NRF70_QFN_MAX_TX_PWR_HB_LOW_CHAN_MCS0,
> +	NRF70_QFN_MAX_TX_PWR_HB_MID_CHAN_MCS0,
> +	NRF70_QFN_MAX_TX_PWR_HB_HIGH_CHAN_MCS0,
> +	/* RX gain adjustment offsets. */
> +	NRF70_RX_GAIN_OFFSET_LB_CHAN,
> +	NRF70_RX_GAIN_OFFSET_HB_LOW_CHAN,
> +	NRF70_RX_GAIN_OFFSET_HB_MID_CHAN,
> +	NRF70_RX_GAIN_OFFSET_HB_HIGH_CHAN,
> +	/* Voltage and temperature dependent backoffs. */
> +	NRF70_QFN_MAX_CHIP_TEMP,
> +	NRF70_QFN_MIN_CHIP_TEMP,
> +	NRF70_QFN_LB_MAX_PWR_BKF_HI_TEMP,
> +	NRF70_QFN_LB_MAX_PWR_BKF_LOW_TEMP,
> +	NRF70_QFN_HB_MAX_PWR_BKF_HI_TEMP,
> +	NRF70_QFN_HB_MAX_PWR_BKF_LOW_TEMP,
> +	NRF70_QFN_LB_VBT_LT_VLOW,
> +	NRF70_QFN_HB_VBT_LT_VLOW,
> +	NRF70_QFN_LB_VBT_LT_LOW,
> +	NRF70_QFN_HB_VBT_LT_LOW,
> +	NRF70_RESERVED,
> +	NRF70_RESERVED,
> +	NRF70_RESERVED,
> +	NRF70_RESERVED,
> +	/* PHY parameters blob. */
> +	NRF70_PHY_PARAMS,
> +};
> +


> +static struct ieee80211_rate nrf70_dsss_rates[] = {

Should be const.

> +	{ .bitrate = 10, .hw_value = 2 },
> +	{ .bitrate = 20, .hw_value = 4,
> +	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
> +	{ .bitrate = 55,
> +	  .hw_value = 11,
> +	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
> +	{ .bitrate = 110,
> +	  .hw_value = 22,
> +	  .flags = IEEE80211_RATE_SHORT_PREAMBLE },
> +	{ .bitrate = 60, .hw_value = 12 },
> +	{ .bitrate = 90, .hw_value = 18 },
> +	{ .bitrate = 120, .hw_value = 24 },
> +	{ .bitrate = 180, .hw_value = 36 },
> +	{ .bitrate = 240, .hw_value = 48 },
> +	{ .bitrate = 360, .hw_value = 72 },
> +	{ .bitrate = 480, .hw_value = 96 },
> +	{ .bitrate = 540, .hw_value = 108 },
> +};
> +
> +static struct ieee80211_supported_band nrf70_band_2ghz = {

Should be const.

> +	.channels = nrf70_dsss_chans,
> +	.n_channels = ARRAY_SIZE(nrf70_dsss_chans),
> +	.band = NL80211_BAND_2GHZ,
> +	.bitrates = nrf70_dsss_rates,
> +	.n_bitrates = ARRAY_SIZE(nrf70_dsss_rates),
> +	.ht_cap = {
> +		.ht_supported = 1,
> +		.cap = IEEE80211_HT_CAP_MAX_AMSDU |
> +		       IEEE80211_HT_CAP_SGI_20 |
> +		       IEEE80211_HT_CAP_SGI_40 |
> +		       IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
> +		       BIT(IEEE80211_HT_CAP_RX_STBC_SHIFT) |
> +		       IEEE80211_HT_CAP_LSIG_TXOP_PROT,
> +		.ampdu_factor = IEEE80211_HT_MAX_AMPDU_32K,
> +		.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
> +		.mcs = {
> +			.tx_params = IEEE80211_HT_MCS_TX_DEFINED,
> +			.rx_mask[0] = 0xff,
> +			.rx_mask[4] = 0x1,
> +		},
> +	},
> +	.iftype_data = &(const struct ieee80211_sband_iftype_data){
> +		.types_mask = BIT(NL80211_IFTYPE_STATION) |
> +			      BIT(NL80211_IFTYPE_AP),
> +		.he_cap = {
> +			.has_he = true,
> +			.he_cap_elem = {
> +				.mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE,
> +			},
> +			.he_mcs_nss_supp = {
> +				.rx_mcs_80 = 0xfffc,
> +				.tx_mcs_80 = 0xfffc,
> +				.rx_mcs_160 = 0xffff,
> +				.tx_mcs_160 = 0xffff,
> +				.rx_mcs_80p80 = 0xffff,
> +				.tx_mcs_80p80 = 0xffff,
> +			},
> +		},
> +	},
> +	.n_iftype_data = 1,
> +};
> +
> +#define	NRF70_CHAN5G(freq, idx, flgs)					\
> +{									\
> +	.band = NL80211_BAND_5GHZ,					\
> +	.center_freq = (freq),						\
> +	.hw_value = (idx),						\
> +	.max_power = 20,						\
> +	.flags = (flgs)							\
> +}
> +
> +static struct ieee80211_channel nrf70_ofdm_chans[] = {

const

> +	NRF70_CHAN5G(5180, 14, 0),
> +	NRF70_CHAN5G(5200, 15, 0),
> +	NRF70_CHAN5G(5220, 16, 0),
> +	NRF70_CHAN5G(5240, 17, 0),
> +	NRF70_CHAN5G(5260, 18, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5280, 19, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5300, 20, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5320, 21, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5500, 22, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5520, 23, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5540, 24, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5560, 25, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5580, 26, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5600, 27, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5620, 28, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5640, 29, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5660, 30, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5680, 31, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5700, 32, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5720, 33, IEEE80211_CHAN_RADAR),
> +	NRF70_CHAN5G(5745, 34, 0),
> +	NRF70_CHAN5G(5765, 35, 0),
> +	NRF70_CHAN5G(5785, 36, 0),
> +	NRF70_CHAN5G(5805, 37, 0),
> +	NRF70_CHAN5G(5825, 38, 0),
> +	NRF70_CHAN5G(5845, 39, 0),
> +	NRF70_CHAN5G(5865, 40, 0),
> +	NRF70_CHAN5G(5885, 41, 0),
> +};
> +
> +static struct ieee80211_rate nrf70_ofdm_rates[] = {

const

> +	{ .bitrate = 60, .hw_value = 12 },
> +	{ .bitrate = 90, .hw_value = 18 },
> +	{ .bitrate = 120, .hw_value = 24 },
> +	{ .bitrate = 180, .hw_value = 36 },
> +	{ .bitrate = 240, .hw_value = 48 },
> +	{ .bitrate = 360, .hw_value = 72 },
> +	{ .bitrate = 480, .hw_value = 96 },
> +	{ .bitrate = 540, .hw_value = 108 },
> +};
> +
> +#define	NRF70_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT	\
> +	(3 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT)
> +
> +#define	NRF70_VHT_MCS_MAP					\
> +	((IEEE80211_VHT_MCS_SUPPORT_0_7 << 2 * 0) |		\
> +	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 1) |		\
> +	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 2) |		\
> +	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 3) |		\
> +	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 4) |		\
> +	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 5) |		\
> +	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 6) |		\
> +	(IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 7))
> +
> +static struct ieee80211_supported_band nrf70_band_5ghz = {

const

> +	.channels = nrf70_ofdm_chans,
> +	.n_channels = ARRAY_SIZE(nrf70_ofdm_chans),
> +	.band = NL80211_BAND_5GHZ,
> +	.bitrates = nrf70_ofdm_rates,
> +	.n_bitrates = ARRAY_SIZE(nrf70_ofdm_rates),
> +	.ht_cap = {
> +		.ht_supported = 1,
> +		.cap = IEEE80211_HT_CAP_MAX_AMSDU |
> +		       IEEE80211_HT_CAP_SGI_20 |
> +		       IEEE80211_HT_CAP_SGI_40 |
> +		       IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
> +		       BIT(IEEE80211_HT_CAP_RX_STBC_SHIFT) |
> +		       IEEE80211_HT_CAP_LSIG_TXOP_PROT,
> +		.ampdu_factor = IEEE80211_HT_MAX_AMPDU_32K,
> +		.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
> +		.mcs = {
> +			.tx_params = IEEE80211_HT_MCS_TX_DEFINED,
> +			.rx_mask[0] = 0xff,
> +			.rx_mask[4] = 0x1,
> +		},
> +	},
> +	.vht_cap = {
> +		.vht_supported = true,
> +		.cap = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
> +		       IEEE80211_VHT_CAP_SHORT_GI_80 |
> +		       IEEE80211_VHT_CAP_RXLDPC |
> +		       IEEE80211_VHT_CAP_TXSTBC |
> +		       IEEE80211_VHT_CAP_RXSTBC_1 |
> +		       IEEE80211_VHT_CAP_HTC_VHT |
> +		       NRF70_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT,
> +		.vht_mcs = {
> +			.rx_mcs_map = NRF70_VHT_MCS_MAP,
> +			.tx_mcs_map = NRF70_VHT_MCS_MAP,
> +		},
> +	},
> +	.iftype_data = &(const struct ieee80211_sband_iftype_data){
> +		.types_mask = BIT(NL80211_IFTYPE_STATION) |
> +			      BIT(NL80211_IFTYPE_AP),
> +		.he_cap = {
> +			.has_he = true,
> +			.he_cap_elem = {
> +				.mac_cap_info[0] = IEEE80211_HE_MAC_CAP0_HTC_HE,
> +			},
> +			.he_mcs_nss_supp = {
> +				.rx_mcs_80 = 0xfffc,
> +				.tx_mcs_80 = 0xfffc,
> +				.rx_mcs_160 = 0xffff,
> +				.tx_mcs_160 = 0xffff,
> +				.rx_mcs_80p80 = 0xffff,
> +				.tx_mcs_80p80 = 0xffff,
> +			},
> +		},
> +	},
> +	.n_iftype_data = 1,
> +};
> +



> +static int nrf70_probe(struct spi_mem *mem)
> +{
> +	struct nrf70_priv *priv;
> +	struct nrf70_wiphy_priv *wpriv;
> +	struct device *dev = &mem->spi->dev;
> +	struct nrf70_vif *vif;
> +	int irq_num, ret, val;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	spi_mem_set_drvdata(mem, priv);
> +	priv->mem = mem;
> +
> +	mutex_init(&priv->write_lock);
> +	mutex_init(&priv->read_lock);
> +	mutex_init(&priv->enqueue_lock);
> +	mutex_init(&priv->desc_lock);
> +
> +	priv->buck_en = devm_gpiod_get(dev, "bucken", 0);
> +	if (!priv->buck_en) {

devm_gpiod_get() returns an error pointer in case of failure. You have
to check the return value with IS_ERR().

> +		dev_err(dev, "Unable to find bucken-gpios property\n");
> +		return -EINVAL;
> +	}

You could use dev_err_probe() for returning an error from the probe
function.

> +
> +	ret = gpiod_direction_output(priv->buck_en, 0);
> +	if (ret) {
> +		dev_err(dev, "Unable to set buck_en direction\n");
> +		return -EIO;
> +	}

Should this "bucken" GPIO rather be a regulator?

Is this really mandatory? It sounds like it could be hardwired to some
fixed voltage.

> +
> +	priv->iovdd_en = devm_gpiod_get_optional(dev, "iovdd", 0);

Same here. Should this rather be a regulator?

> +	if (IS_ERR(priv->iovdd_en)) {
> +		dev_err(dev, "Invalid iovdd-gpios property\n");
> +		return PTR_ERR(priv->iovdd_en);
> +	}
> +
> +	if (priv->iovdd_en) {
> +		ret = gpiod_direction_output(priv->iovdd_en, 0);
> +		if (ret) {
> +			dev_err(dev, "Unable to set iovdd_en direction\n");
> +			return -EIO;
> +		}
> +	}
> +
> +	priv->irq = devm_gpiod_get(dev, "irq", 0);
> +	if (!priv->irq) {
> +		dev_err(dev, "Unable to find irq-gpios property\n");
> +		return -EINVAL;
> +	}

Any particular reason you describe the interrupt as GPIO?

I would just use the interrupts / interrupt-parent binding.

> +
> +	ret = gpiod_direction_input(priv->irq);
> +	if (ret) {
> +		dev_err(dev, "Unable to set irq direction\n");
> +		return -EIO;
> +	}
> +
> +	irq_num = gpiod_to_irq(priv->irq);
> +	if (irq_num < 0) {
> +		dev_err(dev, "Unable to get gpio irq number: %d\n", ret);
> +		return irq_num;
> +	}
> +
> +	/* Test support of opcodes. */
> +	priv->read_op = nrf70_select_op_variant(mem, nrf70_read_ops,
> +						ARRAY_SIZE(nrf70_read_ops));
> +	if (!priv->read_op)
> +		return -EOPNOTSUPP;
> +	priv->write_op = nrf70_select_op_variant(mem, nrf70_write_ops,
> +						 ARRAY_SIZE(nrf70_write_ops));
> +	if (!priv->write_op)
> +		return -EOPNOTSUPP;
> +
> +	/* Wake up RPU. */
> +	gpiod_set_value(priv->buck_en, 0);
> +	if (priv->iovdd_en)
> +		gpiod_set_value(priv->iovdd_en, 0);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value(priv->buck_en, 1);
> +	usleep_range(1000, 2000);
> +	if (priv->iovdd_en) {
> +		gpiod_set_value(priv->iovdd_en, 1);
> +		usleep_range(1000, 2000);
> +	}
> +
> +	nrf70_wrsr2(mem, NRF70_SR2_WAKEUP_REQ);
> +
> +	if (read_poll_timeout(nrf70_rdsr2, val, val & NRF70_SR2_WAKEUP_REQ,
> +			      5 * USEC_PER_MSEC, 2 * USEC_PER_SEC, false,
> +			      mem)) {
> +		dev_err(dev, "Unable to wake up RPU: request failed\n");
> +		ret = -ETIMEDOUT;
> +		goto err_disable_rpu;
> +	}
> +
> +	if (read_poll_timeout(nrf70_rdsr1, val, val & NRF70_SR1_AWAKE,
> +			      5 * USEC_PER_MSEC, 2 * USEC_PER_SEC, false,
> +			      mem)) {
> +		dev_err(dev, "Unable to wake up RPU: bus not active\n");
> +		ret = -ETIMEDOUT;
> +		goto err_disable_rpu;
> +	}
> +
> +	/* Ungate RPU clocks. */
> +	nrf70_writel(mem, NRF70_PBUS_CLK, NRF70_PBUS_CLK_UNGATE);
> +
> +	ret = nrf70_tune_read_op(mem);
> +	if (ret) {
> +		dev_err(dev, "Unable to tune-in read op timing\n");
> +		goto err_disable_rpu;
> +	}
> +
> +	ret = nrf70_load_firmware(mem);
> +	if (ret)
> +		goto err_disable_rpu;
> +
> +	init_completion(&priv->init_done);
> +	init_completion(&priv->station_info_available);
> +	init_completion(&priv->regdom_updated);
> +	INIT_WORK(&priv->event_work, nrf70_event_worker);
> +
> +	ret = devm_request_threaded_irq(dev, irq_num, NULL, nrf70_irq,
> +					IRQF_ONESHOT | IRQF_TRIGGER_RISING,
> +					dev_name(dev), mem);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to request threaded irq: %d\n", ret);
> +		goto err_disable_rpu;
> +	}
> +
> +	priv->tx_desc_bitmap[0] = NRF70_DESC_MASK;
> +	priv->tx_desc_bitmap[1] = NRF70_DESC_MASK;
> +	INIT_LIST_HEAD(&priv->cookies);
> +	INIT_LIST_HEAD(&priv->vifs);
> +
> +	ret = nrf70_mac_init(mem);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to initialize UMAC: %d\n", ret);
> +		goto err_disable_rpu;
> +	}
> +
> +	priv->wiphy = wiphy_new(&nrf70_cfg80211_ops, sizeof(*wpriv));
> +	if (!priv->wiphy) {
> +		dev_err(dev, "Unable to allocate wiphy\n");
> +		ret = -ENOMEM;
> +		goto err_deinit_rpu;
> +	}
> +
> +	set_wiphy_dev(priv->wiphy, dev);
> +	wpriv = wiphy_priv(priv->wiphy);
> +	wpriv->priv = priv;
> +
> +	priv->wiphy->mgmt_stypes = nrf70_default_mgmt_stypes;
> +	priv->wiphy->iface_combinations = nrf70_if_comb;
> +	priv->wiphy->flags |= WIPHY_FLAG_NETNS_OK | WIPHY_FLAG_4ADDR_AP |
> +			      WIPHY_FLAG_4ADDR_STATION |
> +			      WIPHY_FLAG_REPORTS_OBSS | WIPHY_FLAG_OFFCHAN_TX |
> +			      WIPHY_FLAG_CONTROL_PORT_PROTOCOL |
> +			      WIPHY_FLAG_AP_UAPSD;
> +
> +	priv->wiphy->features |= NL80211_FEATURE_SK_TX_STATUS |
> +				 NL80211_FEATURE_SAE |
> +				 NL80211_FEATURE_HT_IBSS |
> +				 NL80211_FEATURE_MAC_ON_CREATE;
> +
> +	wiphy_ext_feature_set(priv->wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
> +
> +	priv->wiphy->bands[NL80211_BAND_2GHZ] = &nrf70_band_2ghz;
> +	priv->wiphy->bands[NL80211_BAND_5GHZ] = &nrf70_band_5ghz;
> +	priv->wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
> +	priv->wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
> +				       BIT(NL80211_IFTYPE_AP);
> +	if (priv->has_raw_mode)
> +		priv->wiphy->interface_modes |= BIT(NL80211_IFTYPE_MONITOR);
> +	priv->wiphy->max_scan_ssids = NRF70_SCAN_SSIDS_MAX;
> +	priv->wiphy->max_scan_ie_len = IEEE80211_MAX_DATA_LEN;
> +	priv->wiphy->cipher_suites = nrf70_cipher_suites;
> +	priv->wiphy->n_cipher_suites = ARRAY_SIZE(nrf70_cipher_suites);
> +
> +	priv->wiphy->reg_notifier = nrf70_reg_notifier;
> +
> +	ret = wiphy_register(priv->wiphy);
> +	if (ret < 0) {
> +		dev_err(dev, "Unable to register wiphy: %d\n", ret);
> +		goto err_wiphy;
> +	}
> +
> +	priv->vif_bitmap = NRF70_VIFS_MASK;
> +
> +	/* Add primary net interface. */
> +	vif = nrf70_add_if(priv, "nrf%d", NET_NAME_UNKNOWN,
> +			   NL80211_IFTYPE_STATION, NULL, false);
> +	if (!IS_ERR(vif))
> +		return 0;
> +
> +	ret = PTR_ERR(vif);
> +	wiphy_unregister(priv->wiphy);
> +err_wiphy:
> +	wiphy_free(priv->wiphy);
> +err_deinit_rpu:
> +	nrf70_deinit_command(mem);
> +err_disable_rpu:
> +	nrf70_writel(mem, NRF70_PBUS_CLK, 0x0);
> +	if (priv->iovdd_en)
> +		gpiod_set_value(priv->iovdd_en, 0);
> +	gpiod_set_value(priv->buck_en, 0);
> +
> +	return ret;
> +}
> +

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

