Return-Path: <linux-wireless+bounces-29533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C910ACA6EC1
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 10:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39D0B38554B0
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 08:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B8D33B94B;
	Fri,  5 Dec 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaqgXVMj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EE0625;
	Fri,  5 Dec 2025 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764921078; cv=none; b=E9m782YDUbt+WApeAkpx+Urg+tS5P9/9ZX5Ike+PGAknXKebDygOJGG7LePP1AwUFYfI2AxpfWp1UxA44eYuLaoSbWhbDuOHnsRaQB+y2fnY5+ez8fEQq/5tg+rVhNhN8sGeexSSdMgsm8gMdHjd4XS+pSKBf+RAFiknqhcigiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764921078; c=relaxed/simple;
	bh=CTSofv76r4jELqFk3u2+hZKnZtJcVlyf263aVxEg7io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bej/GtkW+OLu6z1TFmvuhN/0swVKoQXQ6vRGNrMRiE/Clwe0s1dsiHyv3SUPLYZKfuPq2ulvW27mQ3TWY1RK3KehtvOjcuEQ3473j/+U4tO4dOCcjw9DPrA2DPOZkw5orcPFF088AIcHvKgrd5854LlfhkSl4imqNwlKEZjOQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaqgXVMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDE2C4CEF1;
	Fri,  5 Dec 2025 07:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764921077;
	bh=CTSofv76r4jELqFk3u2+hZKnZtJcVlyf263aVxEg7io=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RaqgXVMjZd9LPrf6pVlBeuOauBGteRN8bEoYlnh7PqD56+EyFytbxRKOI+fCyoOpB
	 Z6RXe/wmGb9hn+7lGmT+0qHRUXaRES/zzK5ymdWRS4a1i/Szj4GPqs2S/l5laGe4gm
	 eUD5qOLTqyxd/7VVNWJk3jz2lAXSPSLafSRSV+BlnF5fWAjVOssOwlQfYtseeysgb2
	 ykoQch2BjGaxNSPkPrsMba3OWd580ZtN4AHEH6uAvoUAbHGN01vmCihDzCeoY96qcN
	 aMPj2H0TmQczb0L+zQByT+2o1GHFQ8gpfrLyuO9owDW4Ebkh6irDq1i2DuEDC2Bz1c
	 GR+J/0m08jR4Q==
Message-ID: <3fc73b5d-1de7-41bb-b9ca-2878f311c6fc@kernel.org>
Date: Fri, 5 Dec 2025 08:51:12 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 19/22] wifi: nxpwifi: add initial SDIO bus driver
 support
To: Jeff Chen <jeff.chen_1@nxp.com>, linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, briannorris@chromium.org,
 johannes@sipsolutions.net, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
 s.hauer@pengutronix.de
References: <20251205065545.3325032-1-jeff.chen_1@nxp.com>
 <20251205065545.3325032-20-jeff.chen_1@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251205065545.3325032-20-jeff.chen_1@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/12/2025 07:55, Jeff Chen wrote:
> +static const struct of_device_id nxpwifi_sdio_of_match_table[] __maybe_unused = {
> +	{ .compatible = "nxp,iw61x" },
> +	{ }
> +};
> +
> +/*
> + * This function parse device tree node using mmc subnode devicetree API.
> + * The device node is saved in card->plt_of_node.
> + * if the device tree node exist and include interrupts attributes, this
> + * function will also request platform specific wakeup interrupt.
> + */
> +static int nxpwifi_sdio_probe_of(struct device *dev)
> +{
> +	if (!of_match_node(nxpwifi_sdio_of_match_table, dev->of_node)) {
> +		dev_err(dev, "required compatible string missing\n");

What? How did you probe otherwise?

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * SDIO probe.
> + *
> + * This function probes an nxpwifi device and registers it. It allocates
> + * the card structure, enables SDIO function number and initiates the
> + * device registration and initialization procedure by adding a logical
> + * interface.
> + */
> +static int
> +nxpwifi_sdio_probe(struct sdio_func *func, const struct sdio_device_id *id)
> +{
> +	int ret;
> +	struct sdio_mmc_card *card = NULL;
> +
> +	pr_debug("info: vendor=0x%4.04X device=0x%4.04X class=%d function=%d\n",
> +		 func->vendor, func->device, func->class, func->num);

NAK. Don't post such code. Look how drivers are supposed to use debug
functions.

And entrance to probe IS NEVER, NEVER debugged.

> +
> +	card = devm_kzalloc(&func->dev, sizeof(*card), GFP_KERNEL);
> +	if (!card)
> +		return -ENOMEM;
> +
> +	init_completion(&card->fw_done);
> +
> +	card->func = func;
> +
> +	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
> +
> +	if (id->driver_data) {
> +		struct nxpwifi_sdio_device *data = (void *)id->driver_data;
> +
> +		card->firmware = data->firmware;
> +		card->firmware_sdiouart = data->firmware_sdiouart;
> +		card->reg = data->reg;
> +		card->max_ports = data->max_ports;
> +		card->mp_agg_pkt_limit = data->mp_agg_pkt_limit;
> +		card->tx_buf_size = data->tx_buf_size;
> +		card->mp_tx_agg_buf_size = data->mp_tx_agg_buf_size;
> +		card->mp_rx_agg_buf_size = data->mp_rx_agg_buf_size;
> +		card->can_dump_fw = data->can_dump_fw;
> +		card->fw_dump_enh = data->fw_dump_enh;
> +		card->can_ext_scan = data->can_ext_scan;
> +		INIT_WORK(&card->work, nxpwifi_sdio_work);
> +	}
> +
> +	sdio_claim_host(func);
> +	ret = sdio_enable_func(func);
> +	sdio_release_host(func);
> +
> +	if (ret) {
> +		dev_err(&func->dev, "failed to enable function\n");
> +		return ret;
> +	}
> +
> +	/* device tree node parsing and platform specific configuration*/
> +	if (func->dev.of_node) {
> +		ret = nxpwifi_sdio_probe_of(&func->dev);
> +		if (ret)
> +			goto err_disable;
> +	}
> +
> +	ret = nxpwifi_add_card(card, &card->fw_done, &sdio_ops,
> +			       NXPWIFI_SDIO, &func->dev);
> +	if (ret) {
> +		dev_err(&func->dev, "add card failed\n");
> +		goto err_disable;
> +	}
> +
> +	return 0;
> +
> +err_disable:
> +	sdio_claim_host(func);
> +	sdio_disable_func(func);
> +	sdio_release_host(func);
> +
> +	return ret;
> +}
> +
> +/*
> + * SDIO resume.
> + *
> + * Kernel needs to suspend all functions separately. Therefore all
> + * registered functions must have drivers with suspend and resume
> + * methods. Failing that the kernel simply removes the whole card.
> + *
> + * If already not resumed, this function turns on the traffic and
> + * sends a host sleep cancel request to the firmware.
> + */
> +static int nxpwifi_sdio_resume(struct device *dev)
> +{
> +	struct sdio_func *func = dev_to_sdio_func(dev);
> +	struct sdio_mmc_card *card;
> +	struct nxpwifi_adapter *adapter;
> +
> +	card = sdio_get_drvdata(func);
> +	if (!card || !card->adapter) {
> +		nxpwifi_dbg(adapter, ERROR, "resume: invalid card or adapter\n");
> +		return 0;
> +	}
> +
> +	adapter = card->adapter;
> +
> +	if (!test_bit(NXPWIFI_IS_SUSPENDED, &adapter->work_flags)) {
> +		nxpwifi_dbg(adapter, WARN,
> +			    "device already resumed\n");
> +		return 0;
> +	}
> +
> +	clear_bit(NXPWIFI_IS_SUSPENDED, &adapter->work_flags);
> +
> +	/* Disable Host Sleep */
> +	nxpwifi_cancel_hs(nxpwifi_get_priv(adapter, NXPWIFI_BSS_ROLE_STA),
> +			  NXPWIFI_SYNC_CMD);
> +
> +	nxpwifi_disable_wake(adapter);
> +
> +	return 0;
> +}
> +
> +/* Write data into SDIO card register. Caller claims SDIO device. */
> +static int
> +nxpwifi_write_reg_locked(struct sdio_func *func, u32 reg, u8 data)
> +{
> +	int ret;
> +
> +	sdio_writeb(func, data, reg, &ret);
> +	return ret;
> +}
> +
> +/* This function writes data into SDIO card register.
> + */
> +static int
> +nxpwifi_write_reg(struct nxpwifi_adapter *adapter, u32 reg, u8 data)
> +{
> +	struct sdio_mmc_card *card = adapter->card;
> +	int ret;
> +
> +	sdio_claim_host(card->func);
> +	ret = nxpwifi_write_reg_locked(card->func, reg, data);
> +	sdio_release_host(card->func);
> +
> +	return ret;
> +}
> +
> +/* This function reads data from SDIO card register.
> + */
> +static int
> +nxpwifi_read_reg(struct nxpwifi_adapter *adapter, u32 reg, u8 *data)
> +{
> +	struct sdio_mmc_card *card = adapter->card;
> +	int ret;
> +	u8 val;
> +
> +	sdio_claim_host(card->func);
> +	val = sdio_readb(card->func, reg, &ret);
> +	sdio_release_host(card->func);
> +
> +	*data = val;
> +
> +	return ret;
> +}
> +
> +/*
> + * This function writes multiple data into SDIO card memory.
> + *
> + * This does not work in suspended mode.
> + */
> +static int
> +nxpwifi_write_data_sync(struct nxpwifi_adapter *adapter,
> +			u8 *buffer, u32 pkt_len, u32 port)
> +{
> +	struct sdio_mmc_card *card = adapter->card;
> +	int ret;
> +	u8 blk_mode =
> +		(port & NXPWIFI_SDIO_BYTE_MODE_MASK) ? BYTE_MODE : BLOCK_MODE;
> +	u32 blk_size = (blk_mode == BLOCK_MODE) ? NXPWIFI_SDIO_BLOCK_SIZE : 1;
> +	u32 blk_cnt =
> +		(blk_mode ==
> +		 BLOCK_MODE) ? (pkt_len /
> +				NXPWIFI_SDIO_BLOCK_SIZE) : pkt_len;
> +	u32 ioport = (port & NXPWIFI_SDIO_IO_PORT_MASK);
> +
> +	if (test_bit(NXPWIFI_IS_SUSPENDED, &adapter->work_flags)) {
> +		nxpwifi_dbg(adapter, ERROR,
> +			    "%s: not allowed while suspended\n", __func__);
> +		return -EPERM;
> +	}
> +
> +	sdio_claim_host(card->func);
> +
> +	ret = sdio_writesb(card->func, ioport, buffer, blk_cnt * blk_size);
> +
> +	sdio_release_host(card->func);
> +
> +	return ret;
> +}
> +
> +/* This function reads multiple data from SDIO card memory.
> + */
> +static int nxpwifi_read_data_sync(struct nxpwifi_adapter *adapter, u8 *buffer,
> +				  u32 len, u32 port, u8 claim)
> +{
> +	struct sdio_mmc_card *card = adapter->card;
> +	int ret;
> +	u8 blk_mode = (port & NXPWIFI_SDIO_BYTE_MODE_MASK) ? BYTE_MODE
> +		       : BLOCK_MODE;
> +	u32 blk_size = (blk_mode == BLOCK_MODE) ? NXPWIFI_SDIO_BLOCK_SIZE : 1;
> +	u32 blk_cnt = (blk_mode == BLOCK_MODE) ? (len / NXPWIFI_SDIO_BLOCK_SIZE)
> +			: len;
> +	u32 ioport = (port & NXPWIFI_SDIO_IO_PORT_MASK);
> +
> +	if (claim)
> +		sdio_claim_host(card->func);
> +
> +	ret = sdio_readsb(card->func, buffer, ioport, blk_cnt * blk_size);
> +
> +	if (claim)
> +		sdio_release_host(card->func);
> +
> +	return ret;
> +}
> +
> +/* This function reads the firmware status.
> + */
> +static int
> +nxpwifi_sdio_read_fw_status(struct nxpwifi_adapter *adapter, u16 *dat)
> +{
> +	struct sdio_mmc_card *card = adapter->card;
> +	const struct nxpwifi_sdio_card_reg *reg = card->reg;
> +	u8 fws0, fws1;
> +	int ret;
> +
> +	ret = nxpwifi_read_reg(adapter, reg->status_reg_0, &fws0);
> +	if (ret)
> +		return ret;
> +
> +	ret = nxpwifi_read_reg(adapter, reg->status_reg_1, &fws1);
> +	if (ret)
> +		return ret;
> +
> +	*dat = (u16)((fws1 << 8) | fws0);
> +	return ret;
> +}
> +
> +/* This function checks the firmware status in card.
> + */
> +static int nxpwifi_check_fw_status(struct nxpwifi_adapter *adapter,
> +				   u32 poll_num)
> +{
> +	int ret = 0;
> +	u16 firmware_stat = 0;
> +	u32 tries;
> +
> +	for (tries = 0; tries < poll_num; tries++) {
> +		ret = nxpwifi_sdio_read_fw_status(adapter, &firmware_stat);
> +		if (ret)
> +			continue;
> +		if (firmware_stat == FIRMWARE_READY_SDIO) {
> +			ret = 0;
> +			break;
> +		}
> +
> +		msleep(100);
> +		ret = -EPERM;
> +	}
> +
> +	if (firmware_stat == FIRMWARE_READY_SDIO)
> +		/*
> +		 * firmware might pretend to be ready, when it's not.
> +		 * Wait a little bit more as a workaround.
> +		 */
> +		msleep(100);
> +
> +	return ret;
> +}
> +
> +/* This function checks if WLAN is the winner.
> + */
> +static int nxpwifi_check_winner_status(struct nxpwifi_adapter *adapter)
> +{
> +	int ret;
> +	u8 winner = 0;
> +	struct sdio_mmc_card *card = adapter->card;
> +
> +	ret = nxpwifi_read_reg(adapter, card->reg->status_reg_0, &winner);
> +	if (ret)
> +		return ret;
> +
> +	if (winner)
> +		adapter->winner = 0;
> +	else
> +		adapter->winner = 1;
> +
> +	return ret;
> +}
> +
> +/*
> + * SDIO remove.
> + *
> + * This function removes the interface and frees up the card structure.
> + */
> +static void
> +nxpwifi_sdio_remove(struct sdio_func *func)
> +{
> +	struct sdio_mmc_card *card;
> +	struct nxpwifi_adapter *adapter;
> +	struct nxpwifi_private *priv;
> +	int ret = 0;
> +	u16 firmware_stat;
> +
> +	card = sdio_get_drvdata(func);
> +	if (!card)
> +		return;
> +
> +	wait_for_completion(&card->fw_done);
> +
> +	adapter = card->adapter;
> +	if (!adapter || !adapter->priv_num)
> +		return;
> +
> +	nxpwifi_dbg(adapter, INFO, "info: SDIO func num=%d\n", func->num);

This does not look like useful printk message. Drivers should be silent
on success:
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79

Debug messages for entry/exit are really useless.

> +



> +
> +static struct sdio_driver nxpwifi_sdio = {
> +	.name = "nxpwifi_sdio",
> +	.id_table = nxpwifi_ids,
> +	.probe = nxpwifi_sdio_probe,
> +	.remove = nxpwifi_sdio_remove,
> +	.drv = {
> +		.owner = THIS_MODULE,

Why are you upstreaming 12-13 years old code?

No, drop all this old stuff and create your code from the scratch, based
on latest reviewed driver. Otherwise you just duplicated all issues we
fixed past 12 years!

> +		.coredump = nxpwifi_sdio_coredump,
> +		.pm = &nxpwifi_sdio_pm_ops,
> +	}
> +};
> +
> +/*
> + * This function wakes up the card.

Really usesless way of commenting code. Can you look at existing source
code to learn how comments are supposed to be written?


Best regards,
Krzysztof

