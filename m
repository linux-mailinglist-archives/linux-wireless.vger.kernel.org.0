Return-Path: <linux-wireless+bounces-23530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B1ACAB1B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 11:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13752189D894
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 09:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD7B1DEFDB;
	Mon,  2 Jun 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdErUVNV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287571DFE20
	for <linux-wireless@vger.kernel.org>; Mon,  2 Jun 2025 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854983; cv=none; b=q6PhlfZpIBr6AXrLlJ8ms4OM8sJv3gafH3Ier8mfmSO1Lo+TqBC/QdeHyhI4LGYSf+tmwNQJp/R1ecvUJRTcbsdPo88Lr8t4BZLumgRma2eKlcxRugbIZytMg+g8vRcHTYrSIhUHTOjPbheRwMSkXGkYjzT+OAVpMSOVJRcKtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854983; c=relaxed/simple;
	bh=iWytv7aQ2oOYWssxX8SnBlm36Z4La+YKjdJDNJW/t14=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ssrSZ0Gm4OxOwmV7bjYlvXaQO9pAexq38xhYosoILhxFLoK2msSVjjSVRCwtSGz13MMxNlKdvCO0eO0f1GPQZDbOkOOrNPvEv6CUIBxVXL6smM8KG/DWCkc9A3Mh4HDYIQrlYsgfcpO+GP5BGFfoKsjiqoawXgGeTs4j2+9HE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdErUVNV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so18500195e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Jun 2025 02:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748854980; x=1749459780; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eel78/sXHR42/56QTeiD/S/vWi3/2pfLC+FExWF9Juc=;
        b=CdErUVNVDydkKBktdHSJmHfmjkCys/R85aQzD2jZY2Z9v1sP0xx6ZAENY6My5/oDCw
         QbftIos1ALWhbYEU50JMvmtAIwnyvM2hLpG4O/z9sih7BEejbzoMWwt4hMQuKXtxXSOx
         ZteNFEbikt8Jci/z+TNxjEoFwyPmOZnijD7dqb6A9QZ3uiCmPd0Dt261LkOi/sQ/lvpx
         OWVI7Jw7zSe5kGHzKS99xWIEquPZeIbpPjcgZc6yI4R344kOEDK2H+A3LMlRUnhTNviW
         Sg7nw48HkYYNKpkzpmZSdza9Gt9UwC7aXBSMJkaijhuYmmEbhdcbbUT/ixV0Uzi3c1X8
         wdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748854980; x=1749459780;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eel78/sXHR42/56QTeiD/S/vWi3/2pfLC+FExWF9Juc=;
        b=hH1NcFhHIxUdjapxGHg2TbwcQO31H0t1c+VvdOQyjOjq0RX3SI0cwMWkdGKOquf6H/
         u7c97D+drObl0aKz/m49FgXDwAky5g49gJQpLEcASyLoBSHIWrEHccAEe6S9IxAV8zRg
         1owgY4J4TyZ8PlgHoHfM3G9wSH2PnChWC+hJ33qP3ApfKDK74t9moGUoybZSH9h7NYHi
         tDYkbGWaEcCvtFeB5xEx8lBN8F8FLd4dqqzp0Au/6pxGpwwjGZW9AugLuMa7QJnLLYLv
         870LkNqhu8a8ahfA3cDBpcUOOps+qQNpeRfnlvZyUFeZbfKNVfFRwmRQSFjqrC/LC/7x
         GGQw==
X-Gm-Message-State: AOJu0YykYUeEMpNtC1daGdaPzuExQr+JUslzFcoKz2zY/1Y13nHneu14
	qBSs/14oJeSMj8IEKv1JqcoH7u2byFbGOsT+k2BeBYMdBzN2I72rcc0f
X-Gm-Gg: ASbGnctJ3LVeErNTvIH6DJs4+J5uw1rt4UHsHRDeiGVVbL2ZL3givqReaa48+viBQSb
	OdXoKNwy231cXHtiwkAlWM4BhTb1OZushpRm7oEYRuYREQY1mhnMTo/Dn3SQ5I+fwdvTUdRk6IM
	KR4rqkRSshdeVRuUYsISWe3rEeaQQwdHT/wU7TWeiqx9OYQ3RFsPN+mzcIiykwA3evKEzaNma04
	gafm7bJ2qUSdJEPNbq463OZXE/w6rDjeRDcLfEwYMXWCaVzoiEdgjIYKBc0W9T4Z997oh9oDocg
	cidTh2kksFsXxu4zEsr8iir/ViURDLYfc5VDaJgpnuOYVMyJOhF9zNYDGpJdsi5HsSEGlg==
X-Google-Smtp-Source: AGHT+IGo5JVOeG91mY3AryEUeLOLUb+PaA8X/GIYrgPUS4uo3mn6vLO3rs1WLNv5gz1ImKJndpv6ng==
X-Received: by 2002:a05:600c:6009:b0:440:69f5:f179 with SMTP id 5b1f17b1804b1-450ce837614mr108908125e9.7.1748854980177;
        Mon, 02 Jun 2025 02:03:00 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451df39deeesm7330185e9.3.2025.06.02.02.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 02:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Jun 2025 11:02:59 +0200
Message-Id: <DABXCM595HBP.3PHKPBRK8C3MD@gmail.com>
Cc: <linux-wireless@vger.kernel.org>, "P Praneesh"
 <quic_ppranees@quicinc.com>, "Jeff Johnson" <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH ath-next V14 8/9] wifi: ath12k: add support for 160 MHz
 bandwidth
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Pradeep Kumar Chitrapu" <quic_pradeepc@quicinc.com>,
 <ath12k@lists.infradead.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250521224539.355985-1-quic_pradeepc@quicinc.com>
 <20250521224539.355985-9-quic_pradeepc@quicinc.com>
In-Reply-To: <20250521224539.355985-9-quic_pradeepc@quicinc.com>

On Thu May 22, 2025 at 12:45 AM CEST, Pradeep Kumar Chitrapu wrote:
> Add support to configure maximum NSS in 160 MHz bandwidth.
> Firmware advertises support for handling NSS ratio information
> as a part of service ready ext event using nss_ratio_enabled
> flag. Save this information in ath12k_pdev_cap to calculate
> NSS ratio.
>
> Additionally, reorder the code by moving
> ath12k_peer_assoc_h_phymode() before ath12k_peer_assoc_h_vht()
> to ensure that arg->peer_phymode correctly reflects the bandwidth
> in the max NSS calculation.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Co-developed-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h |  2 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 89 ++++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/mac.h  |  2 +
>  drivers/net/wireless/ath/ath12k/wmi.c  |  7 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  | 28 ++++++++
>  5 files changed, 115 insertions(+), 13 deletions(-)
[...]
> @@ -2842,10 +2902,13 @@ static enum wmi_phy_mode ath12k_mac_get_phymode_v=
ht(struct ath12k *ar,
>  						    struct ieee80211_link_sta *link_sta)
>  {
>  	if (link_sta->bandwidth =3D=3D IEEE80211_STA_RX_BW_160) {
> -		if (link_sta->vht_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
> +		if (link_sta->vht_cap.cap & (IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ =
|
> +		    IEEE80211_VHT_CAP_EXT_NSS_BW_MASK))
>  			return MODE_11AC_VHT160;
> =20
> -		/* not sure if this is a valid case? */
> +		/* Allow STA to connect even if it does not explicitly advertise 160 M=
Hz
> +		 * support
> +		 */
>  		return MODE_11AC_VHT160;
>  	}
> =20
As this will fix the problem encountered before:
Reviewed-by: Nicolas Escande <nico.escande@gmail.com>

