Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0211759B3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 12:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCBLpg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 06:45:36 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34166 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgCBLpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 06:45:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id w27so7810618lfc.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Mar 2020 03:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=As6I8NQkwcIIjEVCUd38alfcGjH4F3Vry7ogRscZBNk=;
        b=kG5Ee2YejnrYjBcAcREC1HHsjtDyH6DRgNbkPz1qrsybmZWYqcMbxqC7A8yc6qkv/L
         kaVRI+RYETuQ2aEDHvcC6nwzlpvDuLQDVCo5t0zjcohEs3xlJSpnI7dFwagc69V/ei86
         Ttu3ifyFeoP8bzqS1gwggO0/+0EF8f/JCs9zya0d7BK/+Q+m+pJfcX3d0lw0fic+wlhU
         qj04zojl0Jgv/DFsnu0OKScYzc6txXT7LqCKNDCJsM3YFlcKc4/ec7vrPQKvx1YzjfMB
         OlDW6YeAjWrYp6ZqLPVkUSzn1KDM+ud0ZTLeiUIK6i6DJ81GSICUvU02EShhtu/PdUrr
         c1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=As6I8NQkwcIIjEVCUd38alfcGjH4F3Vry7ogRscZBNk=;
        b=sLbAsxkzQ7P3yvwIb7xjRXfbgr8uDP4Ng2p7g5KNKj1b8k/5NfFJa78huiXsS2JJ4B
         7BA71tvV3Gr8xJA91N1wA7U0Acuaa0OWRYJD2hz8IIXBXzNvlMvdb22XkhGaTSO/RroG
         YHt2NF66BWwT39N7I85Pfh978Z8B5l20XQdv9bjex3BR2KdVc9svaa5h8PHOaFW+BhpN
         4eV743o0nptRhDG72vX7cEXJf41xr/7D1aTNVbT4TVnmbehPQNAg67XkpcgjyqgporrJ
         mOZaTQTa7NLnqhHO6QBgtMQKgkgOzu/c8xT7NDEggMtsuYbFeHvuHPxPM7bQRbilppF1
         pnbw==
X-Gm-Message-State: ANhLgQ0wZ5+GZulRyEL005KoqaoVFU0MIz+98hZBMClgpr5L5RgiUz7o
        8Ws3wWK+ew6JSi/lVhwxWjI=
X-Google-Smtp-Source: ADFU+vvIwR0b5gwam3UzfTX3QU4R63OGV4NHnE4Jx3YB9z1gduNmDJdvCxtnx+aJwVtxJydDIYbshg==
X-Received: by 2002:a05:6512:6c7:: with SMTP id u7mr10825067lff.176.1583149533601;
        Mon, 02 Mar 2020 03:45:33 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h9sm10989952ljg.3.2020.03.02.03.45.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 03:45:33 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH RFT] ath10k: add QCA9377 sdio hw_param item
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <1569507867-19547-1-git-send-email-kvalo@codeaurora.org>
Date:   Mon, 2 Mar 2020 15:45:30 +0400
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Erik Stromdahl <erik.stromdahl@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7BB79E29-0ACF-45FB-B802-E4B2F5CA0DFE@gmail.com>
References: <1569507867-19547-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 26 Sep 2019, at 6:24 pm, Kalle Valo <kvalo@codeaurora.org> wrote:
>=20
> From: Erik Stromdahl <erik.stromdahl@gmail.com>
>=20
> Add hardware parameters for QCA9377 sdio devices, it's now properly =
supported.
>=20
> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> ---
>=20
> I don't have any working QCA9377 SDIO hardware so I would appreciate =
any
> test reports. This should apply cleanly to ath.git master branch (at =
least to
> tag ath-201909230832):
>=20
> =
https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=3Dmas=
ter
>=20
> drivers/net/wireless/ath/ath10k/core.c | 27 =
+++++++++++++++++++++++++++
> drivers/net/wireless/ath/ath10k/hw.h   |  3 +++
> 2 files changed, 30 insertions(+)
>=20
> diff --git a/drivers/net/wireless/ath/ath10k/core.c =
b/drivers/net/wireless/ath/ath10k/core.c
> index 36c62d66c19e..e5572d4b6ae9 100644
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -539,6 +539,33 @@ static const struct ath10k_hw_params =
ath10k_hw_params_list[] =3D {
> 		.tx_stats_over_pktlog =3D false,
> 	},
> 	{
> +		.id =3D QCA9377_HW_1_1_DEV_VERSION,
> +		.dev_id =3D QCA9377_1_0_DEVICE_ID,
> +		.bus =3D ATH10K_BUS_SDIO,
> +		.name =3D "qca9377 hw1.1 sdio",
> +		.patch_load_addr =3D QCA9377_HW_1_0_PATCH_LOAD_ADDR,
> +		.uart_pin =3D 19,
> +		.otp_exe_param =3D 0,
> +		.channel_counters_freq_hz =3D 88000,
> +		.max_probe_resp_desc_thres =3D 0,
> +		.cal_data_len =3D 8124,
> +		.fw =3D {
> +			.dir =3D QCA9377_HW_1_0_FW_DIR,
> +			.board =3D QCA9377_HW_1_0_BOARD_DATA_FILE,
> +			.board_size =3D QCA9377_BOARD_DATA_SZ,
> +			.board_ext_size =3D QCA9377_BOARD_EXT_DATA_SZ,
> +		},
> +		.hw_ops =3D &qca6174_ops,
> +		.hw_clk =3D qca6174_clk,
> +		.target_cpu_freq =3D 176000000,
> +		.decap_align_bytes =3D 4,
> +		.n_cipher_suites =3D 8,
> +		.num_peers =3D TARGET_QCA9377_HL_NUM_PEERS,
> +		.ast_skid_limit =3D 0x10,
> +		.num_wds_entries =3D 0x20,
> +		.uart_pin_workaround =3D true,
> +	},
> +	{
> 		.id =3D QCA4019_HW_1_0_DEV_VERSION,
> 		.dev_id =3D 0,
> 		.bus =3D ATH10K_BUS_AHB,
> diff --git a/drivers/net/wireless/ath/ath10k/hw.h =
b/drivers/net/wireless/ath/ath10k/hw.h
> index 2ae57c1de7b5..ddb1d23ec6de 100644
> --- a/drivers/net/wireless/ath/ath10k/hw.h
> +++ b/drivers/net/wireless/ath/ath10k/hw.h
> @@ -768,6 +768,9 @@ ath10k_is_rssi_enable(struct ath10k_hw_params *hw,
> #define TARGET_HL_TLV_AST_SKID_LIMIT		16
> #define TARGET_HL_TLV_NUM_WDS_ENTRIES		2
>=20
> +/* Target specific defines for QCA9377 high latency firmware */
> +#define TARGET_QCA9377_HL_NUM_PEERS		15
> +
> /* Diagnostic Window */
> #define CE_DIAG_PIPE	7
>=20

Tested and working fine using Linux 5.6-rc3 and SDIO firmware from [1].

[    5.391369] ath10k_sdio mmc2:0001:1: qca9377 hw1.1 sdio target =
0x05020001 chip_id 0x00000000 sub 0000:0000
[    5.391379] ath10k_sdio mmc2:0001:1: kconfig debug 0 debugfs 0 =
tracing 0 dfs 0 testmode 0
[    5.391632] ath10k_sdio mmc2:0001:1: firmware ver =
WLAN.TF.1.1.1-00061-QCATFSWPZ-1 api 5 features ignore-otp crc32 7746e551
[    5.624198] ath10k_sdio mmc2:0001:1: failed to fetch board data for =
bus=3Dsdio,vendor=3D0271,device=3D0701,subsystem-vendor=3D0000,subsystem-d=
evice=3D0000 from ath10k/QCA9377/hw1.0/board-2.bin
[    5.624473] ath10k_sdio mmc2:0001:1: board_file api 1 bmi_id N/A =
crc32 544289f7
[    6.775882] ath10k_sdio mmc2:0001:1: htt-ver 3.32 wmi-op 4 htt-op 3 =
cal otp max-sta 32 raw 0 hwcrypto 1
[    6.854066] ath: EEPROM regdomain sanitized
[    6.854073] ath: EEPROM regdomain: 0x64
[    6.854075] ath: EEPROM indicates we should expect a direct regpair =
map
[    6.854082] ath: Country alpha2 being used: 00
[    6.854083] ath: Regpair used: 0x64
[    8.444189] ath: EEPROM regdomain: 0x8114
[    8.444194] ath: EEPROM indicates we should expect a country code
[    8.444196] ath: doing EEPROM country->regdmn map search
[    8.444198] ath: country maps to regdmn code: 0x37
[    8.444201] ath: Country alpha2 being used: DE
[    8.444203] ath: Regpair used: 0x37
[    8.444206] ath: regdomain 0x8114 dynamically updated by country =
element

The test device is an Amlogic S905D STB device from O2.cz that I have =
just submitted a working device-tree for [2].

If you need a QCA9377 test device, I have a duplicate/spare of the box =
and would be happy to post it.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

[1] https://github.com/chewitt/qca-firmware
[2] =
https://patchwork.kernel.org/project/linux-amlogic/list/?series=3D249525

