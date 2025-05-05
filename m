Return-Path: <linux-wireless+bounces-22442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63589AA8D13
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8FD171141
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CB61C84B3;
	Mon,  5 May 2025 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XSwnb6jG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648019995E;
	Mon,  5 May 2025 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430394; cv=none; b=ZZJIKsau3Kx2zUqvUEBN+AZlc/8qcI/4iSZdmo1AL2/A/jU4NPMTrnO69Cv+F3O3O9kp2StQjZVlnmdSY6CLp5sF7Ce+K6IDz8oiEuypur1SfznnN/G3UtJYtPD24C0/v8ITWgN39/mPYxEmROXkmNpbDi+k7Y3WpdNo722u0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430394; c=relaxed/simple;
	bh=o9Ua9es+nDQSCTMlF2S5n70GzvrIm3GZj9ppMhDTiO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWu3mur00NrRfbx5l3ejOjVnIi0rEucBSBEZj58qkDwtRX8FO3yjv9MBextWEODpq2t/gO3bTpHg1THiDG8zzM224PTT5Pu1/WjINtWNo7/OoOejzZuYpAsBEKYLZu7I13n38dt7FQ6wApdT3I4mul/5qF+W4DpYflQWQq+4980=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XSwnb6jG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id 98E3E1F842;
	Mon,  5 May 2025 09:33:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1746430381;
	bh=/zksZ8p8UU1t+kGoN2N2Kk+JAb77n7Fw4YIg48JHLvo=; h=From:To:Subject;
	b=XSwnb6jGDpr1y0ta615f3VPtth08iehvZCxcn5LdnaodpKe+HSAJ3/US6VskIKZMY
	 1XYDDlYzIhgEUl9KthaarKKGUCgX+22Dnd0z07Py9D7cxW1Pg56W/QooSmwN7UldfL
	 gu06tdtucnyd/hHvLKe8NbVBucRuLuJHNrE9r5+LaoA8Ficm9rLENY/f3yBLlahn/q
	 0Utt/4sdkeexqCy1qnAbqkwMaDHcAPqsUhXSJ+g/Otgm6qCdZd3mdCVsYRxaT9btKu
	 PyAbzMAg9Q+v09LgNmb5v+Nlnq6Y0beou9IC6xmEhQuzimXRTRgDOi9esSaK+qYkQN
	 aPcBFyz2fSPvw==
Date: Mon, 5 May 2025 09:32:55 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: "Ivan T. Ivanov" <iivanov@suse.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Jeff Chen <jeff.chen_1@nxp.com>,
	Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH do not merge 0/4] wifi: mwifiex: add iw61x support
Message-ID: <20250505073255.GA12817@francesco-nb>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
 <20250331065026.GA12444@francesco-nb>
 <20250429125928.pw7k4raw52jyvyaj@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429125928.pw7k4raw52jyvyaj@localhost.localdomain>

On Tue, Apr 29, 2025 at 03:59:28PM +0300, Ivan T. Ivanov wrote:
> On 03-31 08:50, Francesco Dolcini wrote:
> > Message-ID: <20250331065026.GA12444@francesco-nb>
> > On Wed, Mar 26, 2025 at 01:18:30PM +0100, Sascha Hauer wrote:
> > > This series adds iw61x support to the mwifiex driver. It works for me,
> > > but is not yet ready to be merged. Some people showed interest in it, so
> > > I am sending it here.

...

> > > Not sure what these are about, I can't see these handled in the
> > > downstream mwifiex driver as well. Could also be there is some parsing
> > > error. Nevertheless the driver seems to work.
> 
> Yep, it is working. Thank you! I am testing this on FRDM-iMX93, which has
> IW612 revision 1.0.
> 
> I have to use nxp/sd_w61x_v1.bin.se on this board and NULL firmware_sdiouart
> because it seems that firmware return 1 as "strap" value, even if WiFi
> is definitely connected over SDIO.

Wi-Fi is always connected over SDIO (for IW61x), the strapping is
related to the interface used for BT. In the past it was common to have
options for having BT over SDIO or UART or USB, but for IW61x it seems
that UART is the only available option.

Francesco


