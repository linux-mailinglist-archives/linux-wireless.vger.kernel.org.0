Return-Path: <linux-wireless+bounces-8311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69D8D4B3B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 14:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B40202857C7
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 12:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE517D371;
	Thu, 30 May 2024 12:01:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC317C7B8
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070488; cv=none; b=QZ3JHBnMpPAIHw7xG6N1sDJyaJe04Qi/PDlxEmCsCwPQTqaW0t15ZfwY+lWL5hKURVDwOsXgNv/o+LBfb940Id948CRmT1kHfiLWYyv4QJQrjlIdZjCSpJRBFovcDWZolp5klna19HATbOQOBG8Co8MdRkn1PDZakz94PK5nnnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070488; c=relaxed/simple;
	bh=6agvjoYknHYxKRL+NaQ2AzP9Mpqe70cIuvhtkCdwR8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/q5f9dOyU3nx7fFWes54VC6PrsyLXinnxw726JAg0amca1+IjHGg7GQ8OF/jut6Qjl55OUryIm10C2CCxjp54cp2N3TWVpGwv2jxmbqrnHHnqdnWtnmJ9syQJvrS9XcguxUrIok/eyzKbt5E6VlcY2Xck2062QhA9fi8VgHDcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sCeTC-0001jR-Ok; Thu, 30 May 2024 14:01:22 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sCeTB-003adJ-PO; Thu, 30 May 2024 14:01:21 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sCeTB-0005pq-2F;
	Thu, 30 May 2024 14:01:21 +0200
Date: Thu, 30 May 2024 14:01:21 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: fix parsing of more than two AKM suites
Message-ID: <ZlhqkXIhK7ynrl65@pengutronix.de>
References: <20240523081428.2852276-1-s.hauer@pengutronix.de>
 <878qzyntg5.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qzyntg5.fsf@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Sat, May 25, 2024 at 12:15:22PM +0300, Kalle Valo wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > params->crypto.n_akm_suites seems to be limited to two AKM suites. Once
> > there are more they will be passed as extra elements of type WLAN_EID_RSN
> > or WLAN_EID_VENDOR_SPECIFIC.
> >
> > This takes some snippets from the downstream vendor driver to parse
> > these elements and to set the correct protocol and key_mgmt bits to
> > enable the desired key managements algorithms in the hardware.
> >
> > This patch is not a request for inclusion, more a heads up that there's
> > something missing and the question if the approach taken is the right
> > one or if there are other preferred ways to fix this issue.
> 
> Please mark patches like this as "[PATCH RFC]", that way we maintainers
> know to drop them automatically.

Yes, will do. I should have known that.

The question I had with this patch is more like whether the approach is
fine.

I wonder why I have to parse the WLAN_EID_RSN element in driver specific
code and why I do not find similar code in other drivers which should
suffer from the same problem.

Looking deeper at it the Kernel by default only supports two AKM suites.
wiphy->max_num_akm_suites is initialized to NL80211_MAX_NR_AKM_SUITES
(which is 2). Whenever wpa_supplicant/hostapd specify more AKM suites
the suites exceeding 2 are encoded in the WLAN_EID_RSN element and I
would expect other drivers to handle this as well.

I realized that the Kernel can handle up to 10 AKM suites by setting
wiphy->max_num_akm_suites to CFG80211_MAX_NUM_AKM_SUITES and that
seems to do the trick as well, at least when I patch wpa_supplicant
to actually use this increased number.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

