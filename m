Return-Path: <linux-wireless+bounces-10376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FFF9373E3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 08:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D7F1C238A0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 06:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4774C3F8C7;
	Fri, 19 Jul 2024 06:05:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690E3C6AC
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721369115; cv=none; b=SCS7qJqrsysj0ory8I3AZM17wwR80y9ck/z6Dh3e4F60jomQbS+CjcteTti77p/XCvPLxVMhwx44xXulNGTLj61wmaDBfVakJc2LU65whl7bvtu9eORCJarhlHAlkUFn0sOS+8tL07mdEDhpE10qmIZne4wVIosBa4v1DG1CbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721369115; c=relaxed/simple;
	bh=ybK4WiHeRrPgRlhiRBN0yKW8AYVzYoZMH2BWTeOihLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxdz94so85XdBRDl23nXHkStU2WwXCRE1NM1TQWzjDqisCyo9RQT8BqXFCMJKdWn7F/SxaHElVrOObTENGDmoQG28d0lqgMFVG93LTBXbqtHA/cSHtoUFtyhqQNi3WTgk4SNXy5xy8UFCkEr7/F90FVl15UXcSd1DPTQasGm+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sUgjl-0005Ez-4x; Fri, 19 Jul 2024 08:05:01 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sUgjk-000cSF-0m; Fri, 19 Jul 2024 08:05:00 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sUgjj-005qk2-2x;
	Fri, 19 Jul 2024 08:04:59 +0200
Date: Fri, 19 Jul 2024 08:04:59 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <ZpoCC042qMcOQ83N@pengutronix.de>
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpmdVq2CkxRcLxvO@google.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Thu, Jul 18, 2024 at 03:55:18PM -0700, Brian Norris wrote:
> Hi Sascha,
> 
> On Wed, Jul 17, 2024 at 10:30:08AM +0200, Sascha Hauer wrote:
> > This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> > method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> > using key_mgmt=WPA-PSK-SHA256.
> > 
> > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/fw.h      | 1 +
> >  drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 3 +++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
> > index 3adc447b715f6..1c76754b616ff 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> > +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> > @@ -415,6 +415,7 @@ enum MWIFIEX_802_11_PRIVACY_FILTER {
> >  #define KEY_MGMT_NONE               0x04
> >  #define KEY_MGMT_PSK                0x02
> >  #define KEY_MGMT_EAP                0x01
> > +#define KEY_MGMT_PSK_SHA256         0x100
> >  #define CIPHER_TKIP                 0x04
> >  #define CIPHER_AES_CCMP             0x08
> >  #define VALID_CIPHER_BITMAP         0x0c
> > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > index 7f822660fd955..c055fdc7114ba 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > @@ -60,6 +60,9 @@ int mwifiex_set_secure_params(struct mwifiex_private *priv,
> >  		case WLAN_AKM_SUITE_PSK:
> >  			bss_config->key_mgmt = KEY_MGMT_PSK;
> >  			break;
> > +		case WLAN_AKM_SUITE_PSK_SHA256:
> > +			bss_config->key_mgmt = KEY_MGMT_PSK_SHA256;
> > +			break;
> 
> I feel like this relates to previous questions you've had [1], and while
> I think the answer at the time made sense to me (basically, EAP and PSK
> are mutually exclusive), it makes less sense to me here that PSK-SHA256
> is mutually exclusive with PSK. And in particular, IIUC, this means that
> the ordering in a wpa_supplicant.conf line like
> 
>   key_mgmt=WPA-PSK WPA-PSK-SHA256
> 
> matters -- only the latter will actually be in use.
> 
> Is that intended? Is this really a single-value field, and not a
> multiple-option bitfield?

It seems that when only the KEY_MGMT_PSK_SHA256 is set, then
KEY_MGMT_PSK also works. Likewise, when only KEY_MGMT_SAE is set, then
also KEY_MGMT_PSK_SHA256 and KEY_MGMT_PSK work.
I gave it a test and also was surprised to see that we only have to set
the "most advanced" bit which then includes the "less advanced" features
automatically.

I could change setting the key_mgmt bits to |= as it feels more natural
and raises less eyebrows, but in my testing it didn't make a difference.

BTW wpa_supplicant parses the key_mgmt options into a bitfield which is
then evaluated elsewhere, so the order the AKM suites are passed to the
kernel is always the same, regardless of the order they appear in the
config.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

