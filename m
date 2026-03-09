Return-Path: <linux-wireless+bounces-32732-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM5hNGFirmlbCwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32732-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:02:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3488F234100
	for <lists+linux-wireless@lfdr.de>; Mon, 09 Mar 2026 07:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C926830038FF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2026 06:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F7928BA95;
	Mon,  9 Mar 2026 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO3laPOp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580B2222AC
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036094; cv=none; b=i3iNaLB7dczgrU97h+ndJuIN61iwRwEW51KPu3EYjxnw8tExspnNKw/Ig7sGzdkAs7JQL7F6dhyRsqacPFcCgs1iiepPpHkxQByBVHbpyoqD00Y/Qp5J1k7Ry15Ryr1fSCi7jj7rS1nrL9j8eU+w5nxuwSFrsAxFPG3QGfY/lAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036094; c=relaxed/simple;
	bh=KXcTs6U6Oyy4Mzw5G5nY+hEIG0IC6g/zn8nwIXRrghI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSgvH204yqEG74dW+GPy6riD2DnPnRX/mPCfxUnv5gjZDr3c2sy0Gq7mr5NgNHrl6h3qEgAp3eaWu/5MA2KDH2Xh+NMbLTMc9n4Idu2hSILY2REoDMsZvBCpcCHHOOnqXn48mhaZr9zA7JZlBerMG3AAo+0IxdX1lPyTv170Wi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO3laPOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6017C2BCB0
	for <linux-wireless@vger.kernel.org>; Mon,  9 Mar 2026 06:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773036093;
	bh=KXcTs6U6Oyy4Mzw5G5nY+hEIG0IC6g/zn8nwIXRrghI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CO3laPOpHfeW/X1LWS/bCZEHgQDQ4fT6myVVz6nJ10zN1filAvxhnvKhNXfoiJ1I1
	 4N18CoCBw5Uw+DePHB4j1npsocUKr4bXUCmfEnZhTaWtWCDuc17R7qzqFAhxmUSI4r
	 x+bfo9IZYyXFF1kEq0TZB6S0KBY/1xO2HO8V9FQgC8eXf9Inuep89gXPHwTQJkffSG
	 xcbZLMozjyzmQ+Bo4tfgXvg7kDpCKl/E9dAO2W+S/7nMuMw0l0d5hCipQy1jtadykJ
	 srnraxAjzv2TUVsa79r9zIDIvufOauj2+YsVNp04LsHadPzq9HQjUny3H1bFKzkSoj
	 GpmYzgQ/5qY2w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a1362c9a3cso3462876e87.2
        for <linux-wireless@vger.kernel.org>; Sun, 08 Mar 2026 23:01:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YxSjNSoqGW1GhZsT3+P7BZhhsAJALjUOAk0DYMBWznHRS0QAmCB
	rT3vuDLNdD7hOiERfvIpDtL9jHL69MP7yZJ/gs4LMqOlYrsmDLCmn2DcMlxOVS0nl7MLedJe/2F
	ilQQ/zhMrVynbaxgmy6e69sORfQOfOBA=
X-Received: by 2002:a05:6512:39ce:b0:5a1:25cb:6d61 with SMTP id
 2adb3069b0e04-5a13ccaf984mr3443568e87.14.1773036091908; Sun, 08 Mar 2026
 23:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANAPQzi3BkfnRS4CEXAA560O5cO8e6MEYxeVVx1u+xUeXS-gmA@mail.gmail.com>
 <CANAPQzi_eC2n_mfxrcZ46tpCDB1_RkkbpnVd2Y=P=Ua4iPU2gQ@mail.gmail.com>
In-Reply-To: <CANAPQzi_eC2n_mfxrcZ46tpCDB1_RkkbpnVd2Y=P=Ua4iPU2gQ@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 9 Mar 2026 01:01:20 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzq0-SuKksxOJ9+phScF4ecZpk+TUtppR7agTXi9DpoNzw@mail.gmail.com>
X-Gm-Features: AaiRm51ycX53Mb_ypP1Vf-IfdSZo7wUGRFHpASNYbdEa-ZrgFY8BPtQhY3AdTGU
Message-ID: <CAGp9Lzq0-SuKksxOJ9+phScF4ecZpk+TUtppR7agTXi9DpoNzw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mt76: connac: fix txpower_cur not updated in mt76_connac_mcu_set_rate_txpower()
To: bryam vargas <bryamestebanvargas@gmail.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3488F234100
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32732-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 3:58=E2=80=AFAM bryam vargas
<bryamestebanvargas@gmail.com> wrote:
>
> [PATCH 2/2] mt76: mt7921u: add USB reset on SEFI chip recovery
> From 86976b5908219204f7719d947fd6c5f1c5e11c7f Mon Sep 17 00:00:00 2001
> From: bryam <bryamestebanvargas@gmail.com>
> Date: Fri, 27 Feb 2026 04:30:01 -0500
> Subject: [PATCH 2/2] mt76: mt7921u: add USB reset on SEFI chip recovery
>
> The MT7921U chip is susceptible to Single Event Functional Interrupts
> (SEFIs) caused by cosmic radiation, particularly at high altitudes.
> When a SEFI occurs, the chip becomes unresponsive and requires a USB
> reset to recover.
>
> Add usb_queue_reset_device() calls in the SEFI detection path to
> trigger automatic recovery instead of leaving the interface hung.
>
> Tested-on: Minisforum NAB9 (MT7921U USB adapter) at 2400m altitude,
>            Bogot=C3=A1, Colombia. Cosmic radiation causes periodic SEFI
>            events; USB reset restores connectivity without intervention.
>
> Signed-off-by: Bryam Vargas <bryamestebanvargas@gmail.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/usb.c | 12 ++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt792x_usb.c | 10 ++++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> index 100bdba..8c8c78f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> @@ -86,6 +86,7 @@ static int mt7921u_mcu_init(struct mt792x_dev *dev)
>
>  static int mt7921u_mac_reset(struct mt792x_dev *dev)
>  {
> +    struct usb_interface *intf =3D to_usb_interface(dev->mt76.dev);
>      int err;
>
>      mt76_txq_schedule_all(&dev->mphy);
> @@ -100,6 +101,17 @@ static int mt7921u_mac_reset(struct mt792x_dev *dev)
>      mt76u_stop_rx(&dev->mt76);
>      mt76u_stop_tx(&dev->mt76);
>
> +    /* When the chip enters a latched state (SEFI - Single Event
> +     * Functional Interrupt, e.g. from cosmic radiation at altitude),
> +     * all register writes over USB become silent no-ops.
> +     * usb_queue_reset_device() electrically resets the chip via the
> +     * USB hub regardless of internal state -- identical to probe().
> +     * Async variant required to avoid deadlock in workqueue context.
> +     */
> +    dev_warn(dev->mt76.dev,
> +         "mt7921u: scheduling USB reset for chip recovery\n");
> +    usb_queue_reset_device(intf);

Hi,

usb_queue_reset_device() is asynchronous. After scheduling the reset,
the driver continues the normal reset flow and still performs reset
operations on the same device, which creates  race conditions.

Also, mt792xu_init_reset() also assumes the USB bus is still
functioning, since it relies on normal USB transactions to reset
WFSYS.

A USB reset should be triggered only after detecting USB transaction
errors or after repeated mt792xu_init_reset() failures.
In this case then we could try triggering a USB reset in software to
see if the USB bus can recover.

Thanks.

> +
>      mt792xu_wfsys_reset(dev);
>
>      clear_bit(MT76_MCU_RESET, &dev->mphy.state);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> index 76272a0..cfd385e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_usb.c
> @@ -269,6 +269,8 @@ EXPORT_SYMBOL_GPL(mt792xu_wfsys_reset);
>
>  int mt792xu_init_reset(struct mt792x_dev *dev)
>  {
> +    struct usb_interface *intf =3D to_usb_interface(dev->mt76.dev);
> +
>      set_bit(MT76_RESET, &dev->mphy.state);
>
>      wake_up(&dev->mt76.mcu.wait);
> @@ -277,6 +279,14 @@ int mt792xu_init_reset(struct mt792x_dev *dev)
>      mt76u_stop_rx(&dev->mt76);
>      mt76u_stop_tx(&dev->mt76);
>
> +    /* Same rationale as mt7921u_mac_reset(): if the chip is in a
> +     * latched state (SEFI), register writes over USB are no-ops.
> +     * Schedule a USB port reset before software reset sequence.
> +     */
> +    dev_warn(dev->mt76.dev,
> +         "mt7921u: scheduling USB device reset (init_reset path)\n");
> +    usb_queue_reset_device(intf);
> +
>      mt792xu_wfsys_reset(dev);
>
>      clear_bit(MT76_RESET, &dev->mphy.state);
> --
> 2.43.0
>

