Return-Path: <linux-wireless+bounces-8993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A74B9083A9
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 08:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DD91C22FD7
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 06:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A0148306;
	Fri, 14 Jun 2024 06:31:39 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B58144D38
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718346699; cv=none; b=NhZCIIjBNkqs+3YpTW/VojurAq8Z8t81ZIR3TzDbhktIDVH2nYBCdLAQxphCsrDQ2gcZsVr7FN73dCqTP9MQIVuNl7glx9fVVGaBM7Dxqfro1o/8uYGgfPNm8xD+xMC6QkbvHGuFdDkGuSkorrJKlfmaH01aIt/a/p+zAzbE4Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718346699; c=relaxed/simple;
	bh=3fhzZCVnsTXZswTdw/fAHddow893rrKkDXJvC1Nqm2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxtMUNrfYbzXEss0M3O2JOURhqpCVI8KAdV3k/eIl6cz7zJ6wKiQCyKh8u37hQqIcL6MAGC2obAMilMy1CD+MbRKe+3CDJQb+1mHOYKUTgFHeW8OLWLLmq8mFdWdun4FK+2Mb7FN8x8RNwGThLya5+hrNbVwjT5McNUDpXVKGok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sI0TE-0002FF-OT; Fri, 14 Jun 2024 08:31:32 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sI0TD-002Ci9-SA; Fri, 14 Jun 2024 08:31:31 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sI0TD-00ALUF-2V;
	Fri, 14 Jun 2024 08:31:31 +0200
Date: Fri, 14 Jun 2024 08:31:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: David Lin <yu-hao.lin@nxp.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"briannorris@chromium.org" <briannorris@chromium.org>,
	"kvalo@kernel.org" <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP
 mode
Message-ID: <Zmvjw3aG9j8kW0Ld@pengutronix.de>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <20240418060626.431202-3-yu-hao.lin@nxp.com>
 <Zmmeg15YQtiChZ70@pengutronix.de>
 <PA4PR04MB9638C0A141C53CC2F5898DA1D1C22@PA4PR04MB9638.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9638C0A141C53CC2F5898DA1D1C22@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Fri, Jun 14, 2024 at 02:06:45AM +0000, David Lin wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > Sent: Wednesday, June 12, 2024 9:12 PM
> > To: David Lin <yu-hao.lin@nxp.com>
> > Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
> > briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it; Pete
> > Hsieh <tsung-hsien.hsieh@nxp.com>; Francesco Dolcini
> > <francesco.dolcini@toradex.com>
> > Subject: [EXT] Re: [PATCH v10 2/2] wifi: mwifiex: add host mlme for AP mode
> > 
> > Caution: This is an external email. Please take care when clicking links or
> > opening attachments. When in doubt, report the message using the 'Report
> > this email' button
> > 
> > 
> > Hi David,
> > 
> > On Thu, Apr 18, 2024 at 02:06:26PM +0800, David Lin wrote:
> > > Add host based MLME to enable WPA3 functionalities in AP mode.
> > > This feature required a firmware with the corresponding V2 Key API
> > > support. The feature (WPA3) is currently enabled and verified only on
> > > IW416. Also, verified no regression with change when host MLME is
> > > disabled.
> > >
> > > Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> > > Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > >
> > 
> > > diff --git a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > index 491e36611909..073c665183b3 100644
> > > --- a/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > +++ b/drivers/net/wireless/marvell/mwifiex/uap_cmd.c
> > > @@ -72,6 +72,10 @@ int mwifiex_set_secure_params(struct
> > mwifiex_private *priv,
> > >                               bss_config->key_mgmt =
> > KEY_MGMT_PSK;
> > >                       }
> > >                       break;
> > > +             case WLAN_AKM_SUITE_SAE:
> > > +                     bss_config->protocol = PROTOCOL_WPA2;
> > > +                     bss_config->key_mgmt = KEY_MGMT_SAE;
> > > +                     break;
> > 
> > Shouldn't this be |= PROTOCOL_WPA2 and |= KEY_MGMT_SAE?
> > Clearing the other flags when SAE is enabled looks wrong to me.
> > 
> > Sascha
> > 
> 
> These fields are used for the configuration of FW, this is the correct setting.

This is done in a loop iterating over the different AKM suites, with your
patch this looks like this:

	for (i = 0; i < params->crypto.n_akm_suites; i++) {
		switch (params->crypto.akm_suites[i]) {
		case WLAN_AKM_SUITE_8021X:
			if (params->crypto.wpa_versions &
			    NL80211_WPA_VERSION_1) {
				bss_config->protocol = PROTOCOL_WPA;
				bss_config->key_mgmt = KEY_MGMT_EAP;
			}
			if (params->crypto.wpa_versions &
			    NL80211_WPA_VERSION_2) {
				bss_config->protocol |= PROTOCOL_WPA2;
				bss_config->key_mgmt = KEY_MGMT_EAP;
			}
			break;
		case WLAN_AKM_SUITE_PSK:
			if (params->crypto.wpa_versions &
			    NL80211_WPA_VERSION_1) {
				bss_config->protocol = PROTOCOL_WPA;
				bss_config->key_mgmt = KEY_MGMT_PSK;
			}
			if (params->crypto.wpa_versions &
			    NL80211_WPA_VERSION_2) {
				bss_config->protocol |= PROTOCOL_WPA2;
				bss_config->key_mgmt = KEY_MGMT_PSK;
			}
			break;
		case WLAN_AKM_SUITE_SAE:
			bss_config->protocol = PROTOCOL_WPA2;
			bss_config->key_mgmt = KEY_MGMT_SAE;
			break;

		default:
			break;
		}
	}

It looks wrong to overwrite bss_config->protocol and
bss_config->key_mgmt in each iteration of this loop. If that would be
correct, you wouldn't need a loop at all, but could instead configure
based on the last AKM suite entry.

In my understanding the bits in bss_config->key_mgmt should be ored
together depending on the possible AKM suites which is also what the
downstream driver does.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

