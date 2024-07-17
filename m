Return-Path: <linux-wireless+bounces-10283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0FF9336BA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9572B216A1
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 06:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A72B125C9;
	Wed, 17 Jul 2024 06:12:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BA4125AC
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196746; cv=none; b=Jwffnla9lTxA50q1kFj+J4Pd3e4nPSjYzx3endQ6GR0WLor7L73/6d7xpU07wqlPf8XSZl+ov1BOU5bUbROaY7lLOItyq3FUrWrSBV/WCZ2JInoaL0A9V1x+lxyL0anKc6TPm2iiM82ln6y0VvCy16bok3GhdME4b4wNoA486RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196746; c=relaxed/simple;
	bh=4f3fcVvU4gRFuVFMBNoTOgdn8pYdktibC9FrBSuVlg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcdYYY9mkJXMJvs61iaa7D8S6tD/JPeK7/SGr1XO8j4BQbINN0O3Ge64cE7mxqSaYc1HBoKY5FIaHXMabtdA6T7MeVEfvK4Yu85pMF8db+65aa1PZ/vRC2hAVzX93L9/L15MYT6S+zEu7YY/w3GR/3r0DkrpRjUAO4iixeyu+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sTxth-0003EI-Rs; Wed, 17 Jul 2024 08:12:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sTxtg-0009Jr-Vl; Wed, 17 Jul 2024 08:12:17 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sTxtg-001s4c-2l;
	Wed, 17 Jul 2024 08:12:16 +0200
Date: Wed, 17 Jul 2024 08:12:16 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <ZpdgwCyoYPAFLBJI@pengutronix.de>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
 <20240716-mwifiex-wpa-psk-sha256-v1-2-05ae70f37bb3@pengutronix.de>
 <20240716195731.GB85916@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716195731.GB85916@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Hi Francesco,

On Tue, Jul 16, 2024 at 09:57:31PM +0200, Francesco Dolcini wrote:
> Hello Sascha,
> 
> On Tue, Jul 16, 2024 at 01:33:28PM +0200, Sascha Hauer wrote:
> > This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> > method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> > using key_mgmt=WPA-PSK-SHA256.
> 
> Do you have any more details on which chip/firmware you tested?
> The change looks good, I am just wondering if there are reasons this
> might create issue on some specific chip/firmware combination.

I have a IW416 with firmware 16.92.21.p119. The change itself is derived
from the downstream driver. The downstream driver also sets the
KEY_MGMT_PSK_SHA256 bit unconditionally for all chip/firmware
combinations so I think this change should be ok.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

