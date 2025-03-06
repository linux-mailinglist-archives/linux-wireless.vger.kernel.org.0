Return-Path: <linux-wireless+bounces-19854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD95BA5478D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704B23A85F1
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D974019DF49;
	Thu,  6 Mar 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="nZYvL3bG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F36184E
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256252; cv=none; b=M574QIIKnQmQx+GOUHyQpJwI+WJAlQbjqY3HFLdzuNuB+WMCxWO1dX5cGEu+EWAIx50MJRGTnM2spB2hjlhsL4VZmvisGoa6M8W/EHYPxD92psRNYn/GqhlPz2r0Cs5Vt+qrTwSne9cvb4aXtYEqV6eHbBq7EHqp5Rac1hrLifo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256252; c=relaxed/simple;
	bh=ZS6Pr1AVrqLmFpOQ83qNyAbM/TCTrkJV3giyqU/gV5A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lny4SZWShJt6SHVRNgxO2W190k2xaDNmok17wZX3ko7MijuDSQ0OIaMFbG3JmdTVkSBouUQKvxTz+wMa1ReoB3182FNawLi8CIzoxwRvlHO5wM0u2pe1pVb5p2HNluSGWBcq54rsmFeUC6OY8dx0HCRS+mvdThQOi9hOx8XlCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=nZYvL3bG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8E6601FDBE;
	Thu,  6 Mar 2025 11:17:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741256239;
	bh=l2Gm09oeFr4iyTyhoZ+kiQ0OOeK2JKYqEkXZKhoE5Y8=; h=From:To:Subject;
	b=nZYvL3bGT47nbdbcg+JxFZgLPGGd/u51U9m2XQyz+QMvg0mX2MXmiM3MQuP2Bidou
	 RWynKF+SmIbGSl7ZunaotR7QwKY0riu3dNNnPxkR9Bx2uO60amCpjH7RabPeLMMs11
	 sIs4I5OfvB3mr34CE2onVDrZV4w34FI6gGKPQNDPAR73Wff2pVOhvoUSp7+R5LiWnP
	 NQU/G5Qd3i360ivtJoFlzreM8ZK3D51gdHjTavjNWO4gHjA6ghOp6g/umc4yjpGJun
	 2HBs74PRPFbKxpVQUEG2249bhZcyB+YwCOdj51LDT7NhbvfKbn8gs9Gy2OSp0NL0g5
	 GbvSmU5k+XN/w==
Date: Thu, 6 Mar 2025 11:17:15 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-wireless@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>, kernel@pengutronix.de,
	Jeff Chen <jeff.chen_1@nxp.com>, tsung-hsien.hsieh@nxp.com,
	Stefan Roese <sr@denx.de>
Subject: Re: Future of mwifiex driver
Message-ID: <20250306101715.GA19853@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8WM9jn1QFscWZBQ@pengutronix.de>

+ Jeff Chen <jeff.chen_1@nxp.com>, tsung-hsien.hsieh@nxp.com
+ Stefan Roese <sr@denx.de>

Hello Sascha,

On Mon, Mar 03, 2025 at 12:05:26PM +0100, Sascha Hauer wrote:
> I am worried about the future of the mwifiex driver. NXP has an ongoing
> effort of forking the driver to support their new chips, but the forked
> driver lacks support for the old chips supported by the current mwifiex
> driver.
> 
> Overall this leaves us and our customers using the mwifiex driver in a
> very bad situation.  Johannes made clear that he is not going to merge a
> driver that is 70% identical to the existing driver and on the other
> hand the existing driver doesn't get forward due to its odd-fixes state
> and the potential rise of a new driver which would render work on the
> existing driver useless.

While I agree on the challenging situation, I would not call it "very
bad" ... as you know there are multiple people with stake on this driver
(I added SR in Cc here, that I just discovered has some interested on
this).

In the short term I think that improving mwifiex driver is going to be
beneficial for everybody, currently this is not going as smooth as we'd
like, as you wrote and as already commented by Brian.

And the next step would be to figure out how to enable newer Wi-Fi chip
solution from NXP in mainline, we all have our ideas and we are not
moving forward. NXP keeps pushing for a solution that was already
rejected multiple times and so far it was not successful on explaining
why this is the correct way forward. Here I would agree that the
situation is "very bad" at the moment.


> I think part of the solution should be that we start cleaning up the
> mwifiex driver

Ack. I would suggest that we focus on this. I can help with some
review/test (as partially done in the past), but I cannot commit to
actively work on much more than that as of now.

Francesco


