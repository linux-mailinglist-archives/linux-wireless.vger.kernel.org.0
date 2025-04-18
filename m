Return-Path: <linux-wireless+bounces-21720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE999A93762
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 14:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E0F8E284A
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D7274FCA;
	Fri, 18 Apr 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="n/5UW3+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AF3111AD
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744980410; cv=none; b=HptfYbKFG7RQNeAuFGeZpjxWLwp9KKLYZCXW8pVqazlfGGtD6f01//2Xlj+KWqmz6MFC9yUGZlsmjDOEYCCa3iR54YqriUb8jtZzYC5VNcxnrvoL8/xNFpkcOG5kl8I1Bo3htspUKPZh25KRxpp756TteYSBKGsxK+nFAAVKfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744980410; c=relaxed/simple;
	bh=1itHU4r3LxHdx/w1JNoBuO7uh2uZNMAgRX9+sxgReD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvXfeNiWCtnyDcAMmgEcOfYESKVdGUlUQ1Ly9Sa5q8sEWvZdS09XkOnPQGwFoNiz55rf4GRAF8/WSoQpuOLmzAxdpAdCi+DTxz3yLDzEa6TnBvRtCN+tfn0YdbvY1Fv3Ji+BSwwI7V16h9lHgc2QDcpeOgr8bem9zUJPF5mH+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=n/5UW3+T; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e34f4e89so3638800a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 05:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1744980406; x=1745585206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YrQ9lopYcuG5JjgtSIveyN/9pp3q3md4UqdRB9irMM=;
        b=n/5UW3+TCpnK64ht9prJbO3XuEz7MPfWiyODs9rc47nkWd4BMAhx+G23Kqzk8+jem3
         Pdo2/DdNzuHRZAdTbqV0dUpt4330v+hYXefWSS8a1AfZJrW1/urvGdtkhC8J0n1UPXbi
         a/ju6sj/LXm8MThL2ZvETR4AzvCxbxsTQ190n4l7TCoqnUW/V3sNSEFopti9rWHVU/By
         CQjCs/1X+//fOMIvFdLS1fzaYlls+crAEyMrAuqLdvyQ5+kyJUR9cQqTiHccJy+TeGBr
         r1mgOyrR/ApZQD2PfZHSm0XjnrAKQiv+iyWDGxpJe4QR0X8Jz3qV4ZdNWUKGKZQnFKFm
         r8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744980406; x=1745585206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6YrQ9lopYcuG5JjgtSIveyN/9pp3q3md4UqdRB9irMM=;
        b=TDlnG4wqY6O4sDjpqLC0+Ng4zHoKApsgqQF6qN4zDiVk/2AmAWHKitwETOhw3mTc6C
         8hSFXK6ulHUsKjl4WLHN0AffgCOFC8gjEJfq1nhqVMvrjH4E37QVKX06IUnXAJTCpdmx
         4nGFbCJ6oxZjTC6qCcxqQMifiiezetkC4mTwluIt8PtNdW5nxTZy6Xho0sd3+MGlq5VA
         ejzMVn5V0O8ducKG2ep3vntrIwoDOAw/BAeBqnhNIcBovaRJ3SAlKJ4gq6chOA/TlHS9
         G2TnaUaLHRTCcea3WjDY+7RP5WNPFHcQSu0g+bdc9VDFRIW2tacqVx6oQIFOICbsbu59
         UywA==
X-Forwarded-Encrypted: i=1; AJvYcCUpBbDvdOl35zZhWjMMEWZp7M0CWlcOmYNtUtu5aAt5jtD7hUuEJt5YJcelW1rZ4+3e8/l4RtBAs+5azyIUjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxovgCjbWxFfAg5K105c+7vP67cBHfSfhvqcTLJbM1xRfi2oca1
	UBAHWbNiQu5oBP8HewRFszARohRnAJD6r5uKAjweKLd+T/h8UlOatnQmm8vfTJv/LdVOFr4EGGO
	DXy2mKkrsAZngwjxDp90c/abMnafRnyBDgpmxug==
X-Gm-Gg: ASbGnctemdP1ncEeZfFag11ggrNzQ0j1UOYOHuqO+VYHcFsEvtVo62hlhSwKcCWvlqB
	3UT1idBOPzbnvrNMpij0LN2e79AWjys8yVyZLj5JfHuOJlcQfXfvvnfT/zRBo/Uf2GrpvzSzQlh
	l8nVtNshB1KyGleQb9h2zAbK8=
X-Google-Smtp-Source: AGHT+IHCH775mlSslDa0nft/zHSXVJbjP99skamXbwGLkiLOa4tD1Y64np3g2DxM13L7kq14VQtYUi9aLqzasYx1EIw=
X-Received: by 2002:a05:6402:27cb:b0:5e8:bf2a:7e8c with SMTP id
 4fb4d7f45d1cf-5f628521086mr1831484a12.11.1744980406281; Fri, 18 Apr 2025
 05:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324211045.3508952-1-artur@conclusive.pl> <20250324211045.3508952-2-artur@conclusive.pl>
 <Z-v0Ftp-oIJ0zIPR@pengutronix.de>
In-Reply-To: <Z-v0Ftp-oIJ0zIPR@pengutronix.de>
From: Artur Rojek <artur@conclusive.pl>
Date: Fri, 18 Apr 2025 14:46:34 +0200
X-Gm-Features: ATxdqUF6Qe7TDjnM2BEvvx_pFsxNc8qtJvPHoBZ5qxOq2MbFjJjdxTMD3djm0Hw
Message-ID: <CAGhaMFNENkcwvz1yxTLVZAXuWes5OKT6HqfWAHh+=SCLc=foeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] net: wireless: Add Nordic nRF70 series Wi-Fi driver
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jakub Klama <jakub@conclusive.pl>, Wojciech Kloska <wojciech@conclusive.pl>, 
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sascha,

thanks for the review, reply inline.

On Tue, Apr 1, 2025 at 4:11=E2=80=AFPM Sascha Hauer <s.hauer@pengutronix.de=
> wrote:
>
> Hi Artur,
>
> Some review feedback inside.
>
> As a general remark there are several functions returning 1 or -1 in
> case of errors. Although they seem to be used only internally in the
> driver it's far too easy to forward these errors to other kernel code
> with future changes, so better return error codes instead.
>
>
> On Mon, Mar 24, 2025 at 10:10:44PM +0100, Artur Rojek wrote:
> > +
> > +static struct nrf70_mem_op {
> > +     int op;
> > +     int width;
> > +     int dummy;
> > +     enum spi_mem_data_dir dir;
> > +} nrf70_read_ops[] =3D {
> > +     { NRF70_OP_RD4, 4, 3, SPI_MEM_DATA_OUT },
> > +     { NRF70_OP_FASTRD, 1, 1, SPI_MEM_DATA_OUT },
> > +}, nrf70_write_ops[] =3D {
> > +     { NRF70_OP_PP4, 4, 0, SPI_MEM_DATA_IN },
> > +     { NRF70_OP_PP, 1, 0, SPI_MEM_DATA_IN },
> > +};
>
> Should be const.
>
> > +static int nrf70_load_firmware(struct spi_mem *mem)
> > +{
> > +     struct device *dev =3D &mem->spi->dev;
> > +     struct nrf70_priv *priv =3D spi_mem_get_drvdata(mem);
> > +     const struct nrf70_fw_header *header;
> > +     const struct nrf70_fw_img *image;
> > +     const struct firmware *firmware;
> > +     int val, i, ret;
> > +     u32 type, len;
> > +
> > +     /* Perform RPU MCU reset. */
> > +     nrf70_writel(mem, NRF70_SBUS_MIPS_MCU_CONTROL, 0x1);
> > +
> > +     if (read_poll_timeout(nrf70_readl, val, !(val & 0x1),
> > +                           10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, fal=
se,
> > +                           mem, NRF70_SBUS_MIPS_MCU_CONTROL)) {
> > +             dev_err(dev, "Unable to reset LMAC\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     if (read_poll_timeout(nrf70_readl, val, val & 0x1,
> > +                           10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, fal=
se,
> > +                           mem, NRF70_SBUS_CP0_SLEEP_STATUS)) {
> > +             dev_err(dev, "Unable to reset LMAC2\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     nrf70_writel(mem, NRF70_SBUS_MIPS_MCU2_CONTROL, 0x1);
> > +
> > +     if (read_poll_timeout(nrf70_readl, val, !(val & 0x1),
> > +                           10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, fal=
se,
> > +                           mem, NRF70_SBUS_MIPS_MCU2_CONTROL)) {
> > +             dev_err(dev, "Unable to reset UMAC\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     if (read_poll_timeout(nrf70_readl, val, val & 0x1,
> > +                           10 * USEC_PER_MSEC, 50 * USEC_PER_MSEC, fal=
se,
> > +                           mem, NRF70_SBUS_CP1_SLEEP_STATUS)) {
> > +             dev_err(dev, "Unable to reset UMAC2\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     ret =3D request_firmware(&firmware, "nrf70.bin", dev);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Failed to request firmware: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     header =3D (const struct nrf70_fw_header *)firmware->data;
> > +     if (header->signature !=3D NRF70_FW_SIGNATURE) {
> > +             dev_err(dev, "Invalid firmware signature\n");
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D nrf70_verify_firmware(dev, header);
> > +     if (ret)
> > +             goto out;
> > +
> > +     priv->has_raw_mode =3D header->feature_flags & NRF70_FW_FEATURE_R=
AW_MODE;
> > +
> > +     image =3D (const struct nrf70_fw_img *)header->data;
> > +
> > +     for (i =3D 0; i < header->num_images; i++) {
> > +             type =3D image->type;
> > +             if (type > 3) {
>
> type >=3D ARRAY_SIZE(nrf_rpu_addr_lut)
>
> > +static int nrf70_init_rx_command(struct spi_mem *mem)
> > +{
> > +     int i, ret =3D 0;
> > +
> > +     for (i =3D 0; ret || i < NRF70_NUM_RX_BUFS; i++)
> > +             ret =3D nrf70_init_rx(mem, i);
>
> I think the loop break condition should be
>
>         !ret && i < NRF70_NUM_RX_BUFS
>
> This is rather hard to read though, so I suggest a plain
>
>         for () {
>                 ret =3D nrf70_init_rx();
>                 if (ret)
>                         return ret;
>         }
>
> > +
> > +     return ret;
> > +}
> > +
> > +static struct nrf70_msg *nrf70_create_msg(u32 type, u32 id, size_t dat=
a_len,
> > +                                       int iface)
> > +{
> > +     struct nrf70_msg *msg;
> > +     union cmd_header {
> > +             struct __packed nrf70_header sys;
> > +             struct __packed nrf70_umac_header umac;
> > +     } *hdr;
> > +     size_t len =3D sizeof(*msg) + data_len;
> > +
> > +     msg =3D kzalloc(len, GFP_KERNEL);
> > +     if (!msg)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     msg->type =3D type;
> > +     msg->len =3D len;
> > +
> > +     hdr =3D (union cmd_header *)msg->data;
> > +     switch (type) {
> > +     case NRF70_MSG_SYSTEM:
> > +             fallthrough;
> > +     case NRF70_MSG_DATA:
> > +             hdr->sys.id =3D id;
> > +             hdr->sys.len =3D data_len;
> > +     break;
>
> This break is misaligned.
>
> > +     case NRF70_MSG_UMAC:
> > +             hdr->umac.id =3D id;
> > +             if (iface >=3D 0) {
> > +                     hdr->umac.idx.wdev_id =3D iface;
> > +                     hdr->umac.idx.valid_fields =3D NRF70_UMAC_ID_WDEV=
;
> > +             }
> > +     break;
>
> ditto
>
> > +     default:
> > +             kfree(msg);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> > +     return msg;
> > +}
> > +
> > +static const u8 nrf7002_qfn_rf_params[NRF70_RF_PARAMS_SZ] =3D {
> > +     NRF70_RESERVED,
> > +     NRF70_RESERVED,
> > +     NRF70_RESERVED,
> > +     NRF70_RESERVED,
> > +     NRF70_RESERVED,
> > +     NRF70_RESERVED,
> > +     /* XO */
> > +     NRF70_QFN_XO_VAL,
>
> You could create defines for the array offsets instead of the values and =
use
> C99 initializers here. For example
>
> #define NRF70_QFN_XO_VAL_OFFSET 6
>
> and then:
>
>         [NRF70_QFN_XO_VAL_OFFSET] =3D 0x2a,
>
> That way the offsets are immediately clear without counting the array
> members.
>
> With this having defines for the values is IMO rather unnecessary then
> as these are magic values anyway and usage of C99 initializers already
> makes their meaning clear.
>
> > +     /* PD adjust values for MCS7. Currently unused. */
> > +     NRF70_PD_ADJUST_VAL,
> > +     NRF70_PD_ADJUST_VAL,
> > +     NRF70_PD_ADJUST_VAL,
> > +     NRF70_PD_ADJUST_VAL,
> > +     /* TX power systematic offset. */
> > +     NRF70_SYSTEM_OFFSET_LB,
> > +     NRF70_SYSTEM_OFFSET_HB_CHAN_LOW,
> > +     NRF70_SYSTEM_OFFSET_HB_CHAN_MID,
> > +     NRF70_SYSTEM_OFFSET_HB_CHAN_HIGH,
> > +     /* Max TX power value for which both EVM and SEM pass. */
> > +     NRF70_QFN_MAX_TX_PWR_DSSS,
> > +     NRF70_QFN_MAX_TX_PWR_LB_MCS7,
> > +     NRF70_QFN_MAX_TX_PWR_LB_MCS0,
> > +     NRF70_QFN_MAX_TX_PWR_HB_LOW_CHAN_MCS7,
> > +     NRF70_QFN_MAX_TX_PWR_HB_MID_CHAN_MCS7,
> > +     NRF70_QFN_MAX_TX_PWR_HB_HIGH_CHAN_MCS7,
> > +     NRF70_QFN_MAX_TX_PWR_HB_LOW_CHAN_MCS0,
> > +     NRF70_QFN_MAX_TX_PWR_HB_MID_CHAN_MCS0,
> > +     NRF70_QFN_MAX_TX_PWR_HB_HIGH_CHAN_MCS0,
> > +     /* RX gain adjustment offsets. */
> > +     NRF70_RX_GAIN_OFFSET_LB_CHAN,
> > +     NRF70_RX_GAIN_OFFSET_HB_LOW_CHAN,
> > +     NRF70_RX_GAIN_OFFSET_HB_MID_CHAN,
> > +     NRF70_RX_GAIN_OFFSET_HB_HIGH_CHAN,
> > +     /* Voltage and temperature dependent backoffs. */
> > +     NRF70_QFN_MAX_CHIP_TEMP,
> > +     NRF70_QFN_MIN_CHIP_TEMP,
> > +     NRF70_QFN_LB_MAX_PWR_BKF_HI_TEMP,
> > +     NRF70_QFN_LB_MAX_PWR_BKF_LOW_TEMP,
> > +     NRF70_QFN_HB_MAX_PWR_BKF_HI_TEMP,
> > +     NRF70_QFN_HB_MAX_PWR_BKF_LOW_TEMP,
> > +     NRF70_QFN_LB_VBT_LT_VLOW,
> > +     NRF70_QFN_HB_VBT_LT_VLOW,
> > +     NRF70_QFN_LB_VBT_LT_LOW,
> > +     NRF70_QFN_HB_VBT_LT_LOW,
> > +     NRF70_RESERVED,
> > +     NRF70_RESERVED,
> > +     NRF70_RESERVED,
> > +     NRF70_RESERVED,
> > +     /* PHY parameters blob. */
> > +     NRF70_PHY_PARAMS,
> > +};
> > +
>
>
> > +static struct ieee80211_rate nrf70_dsss_rates[] =3D {
>
> Should be const.
>
> > +     { .bitrate =3D 10, .hw_value =3D 2 },
> > +     { .bitrate =3D 20, .hw_value =3D 4,
> > +       .flags =3D IEEE80211_RATE_SHORT_PREAMBLE },
> > +     { .bitrate =3D 55,
> > +       .hw_value =3D 11,
> > +       .flags =3D IEEE80211_RATE_SHORT_PREAMBLE },
> > +     { .bitrate =3D 110,
> > +       .hw_value =3D 22,
> > +       .flags =3D IEEE80211_RATE_SHORT_PREAMBLE },
> > +     { .bitrate =3D 60, .hw_value =3D 12 },
> > +     { .bitrate =3D 90, .hw_value =3D 18 },
> > +     { .bitrate =3D 120, .hw_value =3D 24 },
> > +     { .bitrate =3D 180, .hw_value =3D 36 },
> > +     { .bitrate =3D 240, .hw_value =3D 48 },
> > +     { .bitrate =3D 360, .hw_value =3D 72 },
> > +     { .bitrate =3D 480, .hw_value =3D 96 },
> > +     { .bitrate =3D 540, .hw_value =3D 108 },
> > +};
> > +
> > +static struct ieee80211_supported_band nrf70_band_2ghz =3D {
>
> Should be const.
>
> > +     .channels =3D nrf70_dsss_chans,
> > +     .n_channels =3D ARRAY_SIZE(nrf70_dsss_chans),
> > +     .band =3D NL80211_BAND_2GHZ,
> > +     .bitrates =3D nrf70_dsss_rates,
> > +     .n_bitrates =3D ARRAY_SIZE(nrf70_dsss_rates),
> > +     .ht_cap =3D {
> > +             .ht_supported =3D 1,
> > +             .cap =3D IEEE80211_HT_CAP_MAX_AMSDU |
> > +                    IEEE80211_HT_CAP_SGI_20 |
> > +                    IEEE80211_HT_CAP_SGI_40 |
> > +                    IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
> > +                    BIT(IEEE80211_HT_CAP_RX_STBC_SHIFT) |
> > +                    IEEE80211_HT_CAP_LSIG_TXOP_PROT,
> > +             .ampdu_factor =3D IEEE80211_HT_MAX_AMPDU_32K,
> > +             .ampdu_density =3D IEEE80211_HT_MPDU_DENSITY_16,
> > +             .mcs =3D {
> > +                     .tx_params =3D IEEE80211_HT_MCS_TX_DEFINED,
> > +                     .rx_mask[0] =3D 0xff,
> > +                     .rx_mask[4] =3D 0x1,
> > +             },
> > +     },
> > +     .iftype_data =3D &(const struct ieee80211_sband_iftype_data){
> > +             .types_mask =3D BIT(NL80211_IFTYPE_STATION) |
> > +                           BIT(NL80211_IFTYPE_AP),
> > +             .he_cap =3D {
> > +                     .has_he =3D true,
> > +                     .he_cap_elem =3D {
> > +                             .mac_cap_info[0] =3D IEEE80211_HE_MAC_CAP=
0_HTC_HE,
> > +                     },
> > +                     .he_mcs_nss_supp =3D {
> > +                             .rx_mcs_80 =3D 0xfffc,
> > +                             .tx_mcs_80 =3D 0xfffc,
> > +                             .rx_mcs_160 =3D 0xffff,
> > +                             .tx_mcs_160 =3D 0xffff,
> > +                             .rx_mcs_80p80 =3D 0xffff,
> > +                             .tx_mcs_80p80 =3D 0xffff,
> > +                     },
> > +             },
> > +     },
> > +     .n_iftype_data =3D 1,
> > +};
> > +
> > +#define      NRF70_CHAN5G(freq, idx, flgs)                            =
       \
> > +{                                                                    \
> > +     .band =3D NL80211_BAND_5GHZ,                                     =
 \
> > +     .center_freq =3D (freq),                                         =
 \
> > +     .hw_value =3D (idx),                                             =
 \
> > +     .max_power =3D 20,                                               =
 \
> > +     .flags =3D (flgs)                                                =
 \
> > +}
> > +
> > +static struct ieee80211_channel nrf70_ofdm_chans[] =3D {
>
> const
>
> > +     NRF70_CHAN5G(5180, 14, 0),
> > +     NRF70_CHAN5G(5200, 15, 0),
> > +     NRF70_CHAN5G(5220, 16, 0),
> > +     NRF70_CHAN5G(5240, 17, 0),
> > +     NRF70_CHAN5G(5260, 18, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5280, 19, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5300, 20, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5320, 21, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5500, 22, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5520, 23, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5540, 24, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5560, 25, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5580, 26, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5600, 27, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5620, 28, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5640, 29, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5660, 30, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5680, 31, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5700, 32, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5720, 33, IEEE80211_CHAN_RADAR),
> > +     NRF70_CHAN5G(5745, 34, 0),
> > +     NRF70_CHAN5G(5765, 35, 0),
> > +     NRF70_CHAN5G(5785, 36, 0),
> > +     NRF70_CHAN5G(5805, 37, 0),
> > +     NRF70_CHAN5G(5825, 38, 0),
> > +     NRF70_CHAN5G(5845, 39, 0),
> > +     NRF70_CHAN5G(5865, 40, 0),
> > +     NRF70_CHAN5G(5885, 41, 0),
> > +};
> > +
> > +static struct ieee80211_rate nrf70_ofdm_rates[] =3D {
>
> const
>
> > +     { .bitrate =3D 60, .hw_value =3D 12 },
> > +     { .bitrate =3D 90, .hw_value =3D 18 },
> > +     { .bitrate =3D 120, .hw_value =3D 24 },
> > +     { .bitrate =3D 180, .hw_value =3D 36 },
> > +     { .bitrate =3D 240, .hw_value =3D 48 },
> > +     { .bitrate =3D 360, .hw_value =3D 72 },
> > +     { .bitrate =3D 480, .hw_value =3D 96 },
> > +     { .bitrate =3D 540, .hw_value =3D 108 },
> > +};
> > +
> > +#define      NRF70_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT  \
> > +     (3 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT)
> > +
> > +#define      NRF70_VHT_MCS_MAP                                       \
> > +     ((IEEE80211_VHT_MCS_SUPPORT_0_7 << 2 * 0) |             \
> > +     (IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 1) |            \
> > +     (IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 2) |            \
> > +     (IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 3) |            \
> > +     (IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 4) |            \
> > +     (IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 5) |            \
> > +     (IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 6) |            \
> > +     (IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 * 7))
> > +
> > +static struct ieee80211_supported_band nrf70_band_5ghz =3D {
>
> const
>
> > +     .channels =3D nrf70_ofdm_chans,
> > +     .n_channels =3D ARRAY_SIZE(nrf70_ofdm_chans),
> > +     .band =3D NL80211_BAND_5GHZ,
> > +     .bitrates =3D nrf70_ofdm_rates,
> > +     .n_bitrates =3D ARRAY_SIZE(nrf70_ofdm_rates),
> > +     .ht_cap =3D {
> > +             .ht_supported =3D 1,
> > +             .cap =3D IEEE80211_HT_CAP_MAX_AMSDU |
> > +                    IEEE80211_HT_CAP_SGI_20 |
> > +                    IEEE80211_HT_CAP_SGI_40 |
> > +                    IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
> > +                    BIT(IEEE80211_HT_CAP_RX_STBC_SHIFT) |
> > +                    IEEE80211_HT_CAP_LSIG_TXOP_PROT,
> > +             .ampdu_factor =3D IEEE80211_HT_MAX_AMPDU_32K,
> > +             .ampdu_density =3D IEEE80211_HT_MPDU_DENSITY_16,
> > +             .mcs =3D {
> > +                     .tx_params =3D IEEE80211_HT_MCS_TX_DEFINED,
> > +                     .rx_mask[0] =3D 0xff,
> > +                     .rx_mask[4] =3D 0x1,
> > +             },
> > +     },
> > +     .vht_cap =3D {
> > +             .vht_supported =3D true,
> > +             .cap =3D IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
> > +                    IEEE80211_VHT_CAP_SHORT_GI_80 |
> > +                    IEEE80211_VHT_CAP_RXLDPC |
> > +                    IEEE80211_VHT_CAP_TXSTBC |
> > +                    IEEE80211_VHT_CAP_RXSTBC_1 |
> > +                    IEEE80211_VHT_CAP_HTC_VHT |
> > +                    NRF70_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT,
> > +             .vht_mcs =3D {
> > +                     .rx_mcs_map =3D NRF70_VHT_MCS_MAP,
> > +                     .tx_mcs_map =3D NRF70_VHT_MCS_MAP,
> > +             },
> > +     },
> > +     .iftype_data =3D &(const struct ieee80211_sband_iftype_data){
> > +             .types_mask =3D BIT(NL80211_IFTYPE_STATION) |
> > +                           BIT(NL80211_IFTYPE_AP),
> > +             .he_cap =3D {
> > +                     .has_he =3D true,
> > +                     .he_cap_elem =3D {
> > +                             .mac_cap_info[0] =3D IEEE80211_HE_MAC_CAP=
0_HTC_HE,
> > +                     },
> > +                     .he_mcs_nss_supp =3D {
> > +                             .rx_mcs_80 =3D 0xfffc,
> > +                             .tx_mcs_80 =3D 0xfffc,
> > +                             .rx_mcs_160 =3D 0xffff,
> > +                             .tx_mcs_160 =3D 0xffff,
> > +                             .rx_mcs_80p80 =3D 0xffff,
> > +                             .tx_mcs_80p80 =3D 0xffff,
> > +                     },
> > +             },
> > +     },
> > +     .n_iftype_data =3D 1,
> > +};
> > +
>
>
>
> > +static int nrf70_probe(struct spi_mem *mem)
> > +{
> > +     struct nrf70_priv *priv;
> > +     struct nrf70_wiphy_priv *wpriv;
> > +     struct device *dev =3D &mem->spi->dev;
> > +     struct nrf70_vif *vif;
> > +     int irq_num, ret, val;
> > +
> > +     priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +     spi_mem_set_drvdata(mem, priv);
> > +     priv->mem =3D mem;
> > +
> > +     mutex_init(&priv->write_lock);
> > +     mutex_init(&priv->read_lock);
> > +     mutex_init(&priv->enqueue_lock);
> > +     mutex_init(&priv->desc_lock);
> > +
> > +     priv->buck_en =3D devm_gpiod_get(dev, "bucken", 0);
> > +     if (!priv->buck_en) {
>
> devm_gpiod_get() returns an error pointer in case of failure. You have
> to check the return value with IS_ERR().
>
> > +             dev_err(dev, "Unable to find bucken-gpios property\n");
> > +             return -EINVAL;
> > +     }
>
> You could use dev_err_probe() for returning an error from the probe
> function.
>
> > +
> > +     ret =3D gpiod_direction_output(priv->buck_en, 0);
> > +     if (ret) {
> > +             dev_err(dev, "Unable to set buck_en direction\n");
> > +             return -EIO;
> > +     }
>
> Should this "bucken" GPIO rather be a regulator?
>
> Is this really mandatory? It sounds like it could be hardwired to some
> fixed voltage.

Take this with a grain of salt, as I am not a hardware designer.
Nordic's Product Specification document [1] stipulates that BUCKEN line
controls the PWR IP core. In order to start the IC, a power up sequence
is required: first the various power supply lines, then BUCKEN, then
IOVDD signal. Similar with a power down sequence.
To me, this reads that BUCKEN cannot be simply wired to some fixed
voltage and needs some sort of state control. Additionally, it is
the (only?) way for the software to reset the IC and put it into a known
state during probe, or after a hang.
At least for the second case, the driver needs some sort of power
control, whether it's directly the BUCKEN line, or some other circuit
that in turn flicks the BUCKEN. I could rename it to 'vpwr-supply' if
that makes things more transparent. I would risk saying that it makes
it mandatory.

PS. The annoying part about the regulator API is that it reference
counts its usage, and as such regulator_disable() cannot be called
without a prior call to regulator_enable(). So to power-cycle the IC via
the BUCKEN line, I will need to do the following sequence:
regulator_enable() -> regulator_disable() -> regulator_enable()
But I can live with that ;)

[1] https://docs-be.nordicsemi.com/bundle/ps_nrf7002/attach/nRF7002_PS_v1.2=
.pdf?_LANG=3Denus
(p. 51)

Cheers,
Artur

>
> > +
> > +     priv->iovdd_en =3D devm_gpiod_get_optional(dev, "iovdd", 0);
>
> Same here. Should this rather be a regulator?
>
> > +     if (IS_ERR(priv->iovdd_en)) {
> > +             dev_err(dev, "Invalid iovdd-gpios property\n");
> > +             return PTR_ERR(priv->iovdd_en);
> > +     }
> > +
> > +     if (priv->iovdd_en) {
> > +             ret =3D gpiod_direction_output(priv->iovdd_en, 0);
> > +             if (ret) {
> > +                     dev_err(dev, "Unable to set iovdd_en direction\n"=
);
> > +                     return -EIO;
> > +             }
> > +     }
> > +
> > +     priv->irq =3D devm_gpiod_get(dev, "irq", 0);
> > +     if (!priv->irq) {
> > +             dev_err(dev, "Unable to find irq-gpios property\n");
> > +             return -EINVAL;
> > +     }
>
> Any particular reason you describe the interrupt as GPIO?
>
> I would just use the interrupts / interrupt-parent binding.
>
> > +
> > +     ret =3D gpiod_direction_input(priv->irq);
> > +     if (ret) {
> > +             dev_err(dev, "Unable to set irq direction\n");
> > +             return -EIO;
> > +     }
> > +
> > +     irq_num =3D gpiod_to_irq(priv->irq);
> > +     if (irq_num < 0) {
> > +             dev_err(dev, "Unable to get gpio irq number: %d\n", ret);
> > +             return irq_num;
> > +     }
> > +
> > +     /* Test support of opcodes. */
> > +     priv->read_op =3D nrf70_select_op_variant(mem, nrf70_read_ops,
> > +                                             ARRAY_SIZE(nrf70_read_ops=
));
> > +     if (!priv->read_op)
> > +             return -EOPNOTSUPP;
> > +     priv->write_op =3D nrf70_select_op_variant(mem, nrf70_write_ops,
> > +                                              ARRAY_SIZE(nrf70_write_o=
ps));
> > +     if (!priv->write_op)
> > +             return -EOPNOTSUPP;
> > +
> > +     /* Wake up RPU. */
> > +     gpiod_set_value(priv->buck_en, 0);
> > +     if (priv->iovdd_en)
> > +             gpiod_set_value(priv->iovdd_en, 0);
> > +     usleep_range(1000, 2000);
> > +     gpiod_set_value(priv->buck_en, 1);
> > +     usleep_range(1000, 2000);
> > +     if (priv->iovdd_en) {
> > +             gpiod_set_value(priv->iovdd_en, 1);
> > +             usleep_range(1000, 2000);
> > +     }
> > +
> > +     nrf70_wrsr2(mem, NRF70_SR2_WAKEUP_REQ);
> > +
> > +     if (read_poll_timeout(nrf70_rdsr2, val, val & NRF70_SR2_WAKEUP_RE=
Q,
> > +                           5 * USEC_PER_MSEC, 2 * USEC_PER_SEC, false,
> > +                           mem)) {
> > +             dev_err(dev, "Unable to wake up RPU: request failed\n");
> > +             ret =3D -ETIMEDOUT;
> > +             goto err_disable_rpu;
> > +     }
> > +
> > +     if (read_poll_timeout(nrf70_rdsr1, val, val & NRF70_SR1_AWAKE,
> > +                           5 * USEC_PER_MSEC, 2 * USEC_PER_SEC, false,
> > +                           mem)) {
> > +             dev_err(dev, "Unable to wake up RPU: bus not active\n");
> > +             ret =3D -ETIMEDOUT;
> > +             goto err_disable_rpu;
> > +     }
> > +
> > +     /* Ungate RPU clocks. */
> > +     nrf70_writel(mem, NRF70_PBUS_CLK, NRF70_PBUS_CLK_UNGATE);
> > +
> > +     ret =3D nrf70_tune_read_op(mem);
> > +     if (ret) {
> > +             dev_err(dev, "Unable to tune-in read op timing\n");
> > +             goto err_disable_rpu;
> > +     }
> > +
> > +     ret =3D nrf70_load_firmware(mem);
> > +     if (ret)
> > +             goto err_disable_rpu;
> > +
> > +     init_completion(&priv->init_done);
> > +     init_completion(&priv->station_info_available);
> > +     init_completion(&priv->regdom_updated);
> > +     INIT_WORK(&priv->event_work, nrf70_event_worker);
> > +
> > +     ret =3D devm_request_threaded_irq(dev, irq_num, NULL, nrf70_irq,
> > +                                     IRQF_ONESHOT | IRQF_TRIGGER_RISIN=
G,
> > +                                     dev_name(dev), mem);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Unable to request threaded irq: %d\n", ret)=
;
> > +             goto err_disable_rpu;
> > +     }
> > +
> > +     priv->tx_desc_bitmap[0] =3D NRF70_DESC_MASK;
> > +     priv->tx_desc_bitmap[1] =3D NRF70_DESC_MASK;
> > +     INIT_LIST_HEAD(&priv->cookies);
> > +     INIT_LIST_HEAD(&priv->vifs);
> > +
> > +     ret =3D nrf70_mac_init(mem);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Unable to initialize UMAC: %d\n", ret);
> > +             goto err_disable_rpu;
> > +     }
> > +
> > +     priv->wiphy =3D wiphy_new(&nrf70_cfg80211_ops, sizeof(*wpriv));
> > +     if (!priv->wiphy) {
> > +             dev_err(dev, "Unable to allocate wiphy\n");
> > +             ret =3D -ENOMEM;
> > +             goto err_deinit_rpu;
> > +     }
> > +
> > +     set_wiphy_dev(priv->wiphy, dev);
> > +     wpriv =3D wiphy_priv(priv->wiphy);
> > +     wpriv->priv =3D priv;
> > +
> > +     priv->wiphy->mgmt_stypes =3D nrf70_default_mgmt_stypes;
> > +     priv->wiphy->iface_combinations =3D nrf70_if_comb;
> > +     priv->wiphy->flags |=3D WIPHY_FLAG_NETNS_OK | WIPHY_FLAG_4ADDR_AP=
 |
> > +                           WIPHY_FLAG_4ADDR_STATION |
> > +                           WIPHY_FLAG_REPORTS_OBSS | WIPHY_FLAG_OFFCHA=
N_TX |
> > +                           WIPHY_FLAG_CONTROL_PORT_PROTOCOL |
> > +                           WIPHY_FLAG_AP_UAPSD;
> > +
> > +     priv->wiphy->features |=3D NL80211_FEATURE_SK_TX_STATUS |
> > +                              NL80211_FEATURE_SAE |
> > +                              NL80211_FEATURE_HT_IBSS |
> > +                              NL80211_FEATURE_MAC_ON_CREATE;
> > +
> > +     wiphy_ext_feature_set(priv->wiphy, NL80211_EXT_FEATURE_SET_SCAN_D=
WELL);
> > +
> > +     priv->wiphy->bands[NL80211_BAND_2GHZ] =3D &nrf70_band_2ghz;
> > +     priv->wiphy->bands[NL80211_BAND_5GHZ] =3D &nrf70_band_5ghz;
> > +     priv->wiphy->signal_type =3D CFG80211_SIGNAL_TYPE_MBM;
> > +     priv->wiphy->interface_modes =3D BIT(NL80211_IFTYPE_STATION) |
> > +                                    BIT(NL80211_IFTYPE_AP);
> > +     if (priv->has_raw_mode)
> > +             priv->wiphy->interface_modes |=3D BIT(NL80211_IFTYPE_MONI=
TOR);
> > +     priv->wiphy->max_scan_ssids =3D NRF70_SCAN_SSIDS_MAX;
> > +     priv->wiphy->max_scan_ie_len =3D IEEE80211_MAX_DATA_LEN;
> > +     priv->wiphy->cipher_suites =3D nrf70_cipher_suites;
> > +     priv->wiphy->n_cipher_suites =3D ARRAY_SIZE(nrf70_cipher_suites);
> > +
> > +     priv->wiphy->reg_notifier =3D nrf70_reg_notifier;
> > +
> > +     ret =3D wiphy_register(priv->wiphy);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Unable to register wiphy: %d\n", ret);
> > +             goto err_wiphy;
> > +     }
> > +
> > +     priv->vif_bitmap =3D NRF70_VIFS_MASK;
> > +
> > +     /* Add primary net interface. */
> > +     vif =3D nrf70_add_if(priv, "nrf%d", NET_NAME_UNKNOWN,
> > +                        NL80211_IFTYPE_STATION, NULL, false);
> > +     if (!IS_ERR(vif))
> > +             return 0;
> > +
> > +     ret =3D PTR_ERR(vif);
> > +     wiphy_unregister(priv->wiphy);
> > +err_wiphy:
> > +     wiphy_free(priv->wiphy);
> > +err_deinit_rpu:
> > +     nrf70_deinit_command(mem);
> > +err_disable_rpu:
> > +     nrf70_writel(mem, NRF70_PBUS_CLK, 0x0);
> > +     if (priv->iovdd_en)
> > +             gpiod_set_value(priv->iovdd_en, 0);
> > +     gpiod_set_value(priv->buck_en, 0);
> > +
> > +     return ret;
> > +}
> > +
>
> Sascha
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

