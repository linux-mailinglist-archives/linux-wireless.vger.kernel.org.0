Return-Path: <linux-wireless+bounces-36274-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBBqBTOEAmrVtwEAu9opvQ
	(envelope-from <linux-wireless+bounces-36274-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:36:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 674405184D2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 03:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9AFD3040230
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2026 01:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5815229ACF7;
	Tue, 12 May 2026 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="H0iG6UFt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5424E4A8;
	Tue, 12 May 2026 01:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778549746; cv=none; b=DSVG1zvLldO05ribG8r5+JeuPAswK/REXsNhtnfsHlY13t/a7dGDi9X0FDIKcRypaBeI9F3luMRs6gs6PAjEFmjUTNTplq0SG6Xk/OxHVGOwgXSMq1H/76b37fpcRqm07EpwF04ZVMiRIVdn4+DkNO6Hfsshz/vYpCnE/jzrT7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778549746; c=relaxed/simple;
	bh=aIKeZ4lfmJ+L80uoVSis3x5iPCdOH/pYYKYof06EcSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vEza3PLPXe3cKX6JDuy7R1AkBw1eaPpQSxCr8S2ntWrzhtnP5aU0E+CNDJ5LYkZ2q84Uw2eoxaZsQE5x7xhcM7gEi5v5pIqfmjBAD6BXqjiMHPaZirhKZ4zNUwvtPtNQVLb6BUjmo6YxFN7W/svGio/vLrlQV+RBNh4T8j2uM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=H0iG6UFt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64C1ZTwS43456193, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778549729; bh=ug96r92nQ4oezhtS4bp22d+nLEQF9UV3G9FEB8XOuiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=H0iG6UFtiGThmgECVMdHBP5tLdPKVY85Kx9nuI+B9qdHFRy0rDnJx9o8gkJW4O81s
	 sYn/sPru30Mvj9rZWRFHIlGyVPfxuEUhhmUj0TAm49I5HbzM6N78i6WA4o+d8ytaP/
	 fPfEtyZlg1ApknzpFLtQd+AjN8hD21KVluT9pvPGMlH/tVTqJmGebt2HQEMR2za6Q3
	 l6qZjoc2KE4tbO9iVyz/yUr6aNZZdGZ6/AFKD2C0cUONV08H5llJoD8HQQ0gBoFmG+
	 VoThAyjGEvztm0x9sX7VcQQ6zkvJ/0D/8P/xrcdXHIzXkym3wptkEdwLpXM2GtU2zT
	 mle0l7J2X+zig==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64C1ZTwS43456193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 09:35:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 09:35:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 09:35:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 12 May 2026 09:35:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Devin Wittmayer <lucid_duck@justthetip.ca>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to
 USB 3 mode
Thread-Topic: [PATCH rtw-next v2 1/1] wifi: rtw89: usb: Support switching to
 USB 3 mode
Thread-Index: AQHc4WBnvzkVdckSH0mw5MmxdTZUKbYJmcnA
Date: Tue, 12 May 2026 01:35:30 +0000
Message-ID: <e3ae58133549411e9eeb88c7c6ffbfaa@realtek.com>
References: <20260508054421.128938-1-lucid_duck@justthetip.ca>
 <20260511160811.17647-1-lucid_duck@justthetip.ca>
 <20260511160811.17647-2-lucid_duck@justthetip.ca>
In-Reply-To: <20260511160811.17647-2-lucid_duck@justthetip.ca>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 674405184D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36274-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,justthetip.ca:email];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Devin Wittmayer <lucid_duck@justthetip.ca> wrote:
> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>

[...]

> @@ -1027,6 +1032,35 @@ static void rtw89_usb_intf_deinit(struct rtw89_dev=
 *rtwdev,
>         usb_set_intfdata(intf, NULL);
>  }
>=20
> +static int rtw89_usb_switch_mode(struct rtw89_dev *rtwdev)
> +{
> +       struct rtw89_usb *rtwusb =3D rtw89_usb_priv(rtwdev);
> +
> +       if (!rtw89_switch_usb_mode)
> +               return 0;
> +
> +       /* No known USB 3 devices with this chip. */
> +       if (rtwdev->chip->chip_id =3D=3D RTL8851B)
> +               return 0;

As commit message, only RTL8832BU and RTL8832CU were tested, and WiFi 7
was not neither. I'd give positive list instead.

> +
> +       if (rtwusb->udev->speed =3D=3D USB_SPEED_SUPER)
> +               return 0;
> +
> +       rtw89_debug(rtwdev, RTW89_DBG_HCI, "%s: pad_ctrl2: %#x %#x\n",
> +                   __func__,
> +                   rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 1),
> +                   rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 2));
> +
> +       /* Already tried to switch but it's a USB 2 port. */
> +       if (rtw89_read8(rtwdev, R_AX_PAD_CTRL2 + 1) =3D=3D USB_SWITCH_DEL=
AY)
> +               return 0;
> +
> +       rtw89_write8(rtwdev, R_AX_PAD_CTRL2 + 1, USB_SWITCH_DELAY);
> +       rtw89_write8(rtwdev, R_AX_PAD_CTRL2 + 2, U2SWITCHU3);
> +
> +       return 1;
> +}
> +
>  int rtw89_usb_probe(struct usb_interface *intf,
>                     const struct usb_device_id *id)
>  {



