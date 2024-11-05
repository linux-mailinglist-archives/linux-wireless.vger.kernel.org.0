Return-Path: <linux-wireless+bounces-14928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A199BD0F7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 16:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615642840D0
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 15:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055213E04B;
	Tue,  5 Nov 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="eaz2V37O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F681547CF
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821663; cv=none; b=uzwK9gC2ok3zWEwlt147F2J6hq6G26Dc9KqwSEEte/57VP0mBvLPkiCDuFBlVLhkyUP2Lxd2HhVbJkwIsH7fJhQF3nP6/9lNH1Wi7hefTE1LrG8Oo/x1h3QTEV/poA7z7SUd2zWxwMhAU1Xu7WjTm3VNQiZGaynfCFEMt2J0Uv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821663; c=relaxed/simple;
	bh=enMgjjDFYaU9UGvY8ljm8G6GsfXrvLamg91lwJRpbhY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=iW2EVUEsiO1hzLgndyTsIrnCQBRKgXg66OBN7iXD5lLV3KfAHkIdvIgEKWQ4DxiJsumptFBMqNvgl/Yin+mrj7HBwpmk8ByMfrcZz8JJkRsaHA9bny7rxNPLkgEuMeoU7XjGqbUavtGRF4e+quMNpgm+/YRbGj9AF2HoJkICkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=eaz2V37O; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30253C005F;
	Tue,  5 Nov 2024 10:39:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1730821172; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nm3D/IBxdUByznHhid/dQYj2ZtQ9e8hAUGuJz9TxpmQ=;
	b=eaz2V37OE6V7f+Sd9bpiQtcF79y/h/qfeUki/7lJxM7XjmWSSiUp/O2NGZAMuV/ON8XM7N
	HBVoA2VN/F52xHZOgqSXfTpYIEaJhgMbgB8kJMXKJ5VwPzXrRsabDZbKTex5GoRghrFDT8
	h1ZjvjoAG6y6eAJ5Nf9ecmKuRs6wDzU=
Message-ID: <c1385aa1-0d41-4ed7-a00c-e40c69bafeaa@kaechele.ca>
Date: Tue, 5 Nov 2024 10:39:27 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] wifi: ath10k: add support for QCA9379 hw1.0 SDIO
From: Felix Kaechele <felix@kaechele.ca>
To: ath10k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20240908013244.496382-1-felix@kaechele.ca>
 <20240908013244.496382-3-felix@kaechele.ca>
Content-Language: en-US
In-Reply-To: <20240908013244.496382-3-felix@kaechele.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Gentle ping on this one.

It still applies cleanly against the ath/master branch as of today.

If there's no chance of this going in please let me know and I'll stop 
re-sending this patch.

I understand that bandwidth for ath10k related requests is minimal these 
days and there may not be an interest in fixing what are possibly 
firmware related issues for this rather obscure IoT/Automotive (SDIO, no 
less!) chipset.
I unfortunately don't have the information, documentation and latest 
firmware images available on my side to help with this either.
I am, however, always willing to work with someone on fixing any of the 
outstanding issues.

Thanks!
Felix

On 2024-09-07 21:32, Felix Kaechele wrote:
> This adds support for the QCA9379-3 SDIO SoC. It is part of the
> QCA6174 SDIO family.
> 
> While the device is generally working, there are some remaining issues:
> - the card will perform a full reconnect upon expiry of the Group Key
>    renewal interval
> - rx rates are not reported correctly (i.e. always show as 6.0 MBit/s)
> 
> More debugging would need to be done on these, preferably by people with
> access to proper documentation.
> 
> This change was tested on a device that uses a LITEON WCBN3510A module.
> The module was tested in WPA2 and WPA3 Personal scenarios using iperf3.
> Performance was comparable to the same device using the vendor driver in
> the same environment.
> 
> Tested-on: QCA9379 hw1.0 SDIO WLAN.NPL.1.6-00163-QCANPLSWPZ-1
> 
> Signed-off-by: Felix Kaechele <felix@kaechele.ca>
> ---
>   drivers/net/wireless/ath/ath10k/core.c      | 37 +++++++++++++++++++++
>   drivers/net/wireless/ath/ath10k/hw.h        | 10 ++++++
>   drivers/net/wireless/ath/ath10k/pci.c       |  2 ++
>   drivers/net/wireless/ath/ath10k/sdio.c      |  5 ++-
>   drivers/net/wireless/ath/ath10k/targaddrs.h |  3 ++
>   5 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
> index b3294287bce1..32d5d4be8830 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -661,6 +661,42 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
>   		.delay_unmap_buffer = false,
>   		.mcast_frame_registration = false,
>   	},
> +	{
> +		.id = QCA9379_HW_1_0_DEV_VERSION,
> +		.dev_id = QCA9379_1_0_DEVICE_ID,
> +		.bus = ATH10K_BUS_SDIO,
> +		.name = "qca9379 hw1.0 sdio",
> +		.patch_load_addr = QCA9379_HW_1_0_PATCH_LOAD_ADDR,
> +		.uart_pin = 19,
> +		.otp_exe_param = 0,
> +		.channel_counters_freq_hz = 88000,
> +		.max_probe_resp_desc_thres = 0,
> +		.cal_data_len = 0,
> +		.fw = {
> +			.dir = QCA9379_HW_1_0_FW_DIR,
> +			.board_size = QCA9379_BOARD_DATA_SZ,
> +			.board_ext_size = QCA9379_BOARD_EXT_DATA_SZ,
> +		},
> +		.rx_desc_ops = &qca988x_rx_desc_ops,
> +		.hw_ops = &qca6174_sdio_ops,
> +		.hw_clk = qca6174_clk,
> +		.target_cpu_freq = 176000000,
> +		.decap_align_bytes = 4,
> +		.n_cipher_suites = 8,
> +		.num_peers = 10,
> +		.ast_skid_limit = 0x10,
> +		.num_wds_entries = 0x20,
> +		.uart_pin_workaround = true,
> +		.tx_stats_over_pktlog = false,
> +		.credit_size_workaround = true,
> +		.bmi_large_size_download = true,
> +		.supports_peer_stats_info = false,
> +		.dynamic_sar_support = false,
> +		.hw_restart_disconnect = false,
> +		.use_fw_tx_credits = true,
> +		.delay_unmap_buffer = false,
> +		.mcast_frame_registration = false,
> +	},
>   	{
>   		.id = QCA4019_HW_1_0_DEV_VERSION,
>   		.dev_id = 0,
> @@ -3602,6 +3638,7 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
>   		break;
>   	case ATH10K_HW_QCA6174:
>   	case ATH10K_HW_QCA9377:
> +	case ATH10K_HW_QCA9379:
>   		ar->regs = &qca6174_regs;
>   		ar->hw_ce_regs = &qcax_ce_regs;
>   		ar->hw_values = &qca6174_values;
> diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
> index 442091c6dfd2..419fa1888e75 100644
> --- a/drivers/net/wireless/ath/ath10k/hw.h
> +++ b/drivers/net/wireless/ath/ath10k/hw.h
> @@ -30,6 +30,7 @@ enum ath10k_bus {
>   #define QCA9888_2_0_DEVICE_ID	(0x0056)
>   #define QCA9984_1_0_DEVICE_ID	(0x0046)
>   #define QCA9377_1_0_DEVICE_ID   (0x0042)
> +#define QCA9379_1_0_DEVICE_ID   (0x0042)
>   #define QCA9887_1_0_DEVICE_ID   (0x0050)
>   
>   /* QCA988X 1.0 definitions (unsupported) */
> @@ -59,6 +60,9 @@ enum ath10k_bus {
>   #define QCA9377_HW_1_0_DEV_VERSION	0x05020000
>   #define QCA9377_HW_1_1_DEV_VERSION	0x05020001
>   
> +/* QCA9379 target BMI version signatures */
> +#define QCA9379_HW_1_0_DEV_VERSION	0x05040000
> +
>   enum qca6174_pci_rev {
>   	QCA6174_PCI_REV_1_1 = 0x11,
>   	QCA6174_PCI_REV_1_3 = 0x13,
> @@ -115,6 +119,10 @@ enum qca9377_chip_id_rev {
>   #define QCA9377_HW_1_0_FW_DIR          ATH10K_FW_DIR "/QCA9377/hw1.0"
>   #define QCA9377_HW_1_0_PATCH_LOAD_ADDR	0x1234
>   
> +/* QCA9379 1.0 definitions */
> +#define QCA9379_HW_1_0_FW_DIR		ATH10K_FW_DIR "/QCA9379/hw1.0"
> +#define QCA9379_HW_1_0_PATCH_LOAD_ADDR	0x1234
> +
>   /* QCA4019 1.0 definitions */
>   #define QCA4019_HW_1_0_DEV_VERSION     0x01000000
>   #define QCA4019_HW_1_0_FW_DIR          ATH10K_FW_DIR "/QCA4019/hw1.0"
> @@ -230,6 +238,7 @@ enum ath10k_hw_rev {
>   	ATH10K_HW_QCA9888,
>   	ATH10K_HW_QCA9984,
>   	ATH10K_HW_QCA9377,
> +	ATH10K_HW_QCA9379,
>   	ATH10K_HW_QCA4019,
>   	ATH10K_HW_QCA9887,
>   	ATH10K_HW_WCN3990,
> @@ -401,6 +410,7 @@ int ath10k_hw_diag_fast_download(struct ath10k *ar,
>   #define QCA_REV_9888(ar) ((ar)->hw_rev == ATH10K_HW_QCA9888)
>   #define QCA_REV_9984(ar) ((ar)->hw_rev == ATH10K_HW_QCA9984)
>   #define QCA_REV_9377(ar) ((ar)->hw_rev == ATH10K_HW_QCA9377)
> +#define QCA_REV_9379(ar) ((ar)->hw_rev == ATH10K_HW_QCA9379)
>   #define QCA_REV_40XX(ar) ((ar)->hw_rev == ATH10K_HW_QCA4019)
>   #define QCA_REV_WCN3990(ar) ((ar)->hw_rev == ATH10K_HW_WCN3990)
>   
> diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
> index c52a16f8078f..6fee3d52d808 100644
> --- a/drivers/net/wireless/ath/ath10k/pci.c
> +++ b/drivers/net/wireless/ath/ath10k/pci.c
> @@ -1899,6 +1899,7 @@ void ath10k_pci_irq_msi_fw_mask(struct ath10k *ar)
>   		 *  to mask irq/MSI.
>   		 */
>   		break;
> +	case ATH10K_HW_QCA9379:
>   	case ATH10K_HW_WCN3990:
>   		break;
>   	}
> @@ -1927,6 +1928,7 @@ static void ath10k_pci_irq_msi_fw_unmask(struct ath10k *ar)
>   		 *  to unmask irq/MSI.
>   		 */
>   		break;
> +	case ATH10K_HW_QCA9379:
>   	case ATH10K_HW_WCN3990:
>   		break;
>   	}
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 08a6f36a6be9..24123d23ad5a 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -1105,6 +1105,7 @@ static void ath10k_sdio_set_mbox_info(struct ath10k *ar)
>   				ATH10K_HIF_MBOX0_EXT_WIDTH_ROME_2_0;
>   		break;
>   	case (SDIO_DEVICE_ID_ATHEROS_QCA9377 & 0x0F00):
> +	case (SDIO_DEVICE_ID_ATHEROS_QCA9379 & 0x0F00):
>   		mbox_info->ext_info[0].htc_ext_sz =
>   			ATH10K_HIF_MBOX0_EXT_WIDTH_ROME_2_0;
>   		break;
> @@ -2597,7 +2598,8 @@ static int ath10k_sdio_probe(struct sdio_func *func,
>   
>   	dev_id_base = (id->device & 0x0F00);
>   	if (dev_id_base != (SDIO_DEVICE_ID_ATHEROS_AR6005 & 0x0F00) &&
> -	    dev_id_base != (SDIO_DEVICE_ID_ATHEROS_QCA9377 & 0x0F00)) {
> +	    dev_id_base != (SDIO_DEVICE_ID_ATHEROS_QCA9377 & 0x0F00) &&
> +	    dev_id_base != (SDIO_DEVICE_ID_ATHEROS_QCA9379 & 0x0F00)) {
>   		ret = -ENODEV;
>   		ath10k_err(ar, "unsupported device id %u (0x%x)\n",
>   			   dev_id_base, id->device);
> @@ -2656,6 +2658,7 @@ static void ath10k_sdio_remove(struct sdio_func *func)
>   static const struct sdio_device_id ath10k_sdio_devices[] = {
>   	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_AR6005)},
>   	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_QCA9377)},
> +	{SDIO_DEVICE(SDIO_VENDOR_ID_ATHEROS, SDIO_DEVICE_ID_ATHEROS_QCA9379)},
>   	{},
>   };
>   
> diff --git a/drivers/net/wireless/ath/ath10k/targaddrs.h b/drivers/net/wireless/ath/ath10k/targaddrs.h
> index ba37e6c7ced0..1a0f71126683 100644
> --- a/drivers/net/wireless/ath/ath10k/targaddrs.h
> +++ b/drivers/net/wireless/ath/ath10k/targaddrs.h
> @@ -481,6 +481,9 @@ struct host_interest {
>   #define QCA9377_BOARD_DATA_SZ     QCA6174_BOARD_DATA_SZ
>   #define QCA9377_BOARD_EXT_DATA_SZ 0
>   
> +#define QCA9379_BOARD_DATA_SZ     QCA6174_BOARD_DATA_SZ
> +#define QCA9379_BOARD_EXT_DATA_SZ 0
> +
>   #define QCA99X0_BOARD_DATA_SZ	  12288
>   #define QCA99X0_BOARD_EXT_DATA_SZ 0
>   


