Return-Path: <linux-wireless+bounces-27765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34546BAFFAD
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Oct 2025 12:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB51E1942C3B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Oct 2025 10:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A187239E61;
	Wed,  1 Oct 2025 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="S4utW/4l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B481A3165;
	Wed,  1 Oct 2025 10:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313967; cv=none; b=NY9MzeUPvwt+35Mei8Di1v0hOjrVbrwrUrJtZ3+gupilFsqhuw/6jGcByKp5aPJTbs6iMoFjbDcJKYtEQHq5rpUuaQXWTldI7XzjiV0phJO7pC3nnckXPXDew3Q29gmG3KT+aGifE28bOhc0tTgXHdc7jm3lg5WG5FJj5xXXXtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313967; c=relaxed/simple;
	bh=iWVWJBqDSD2sztDLsnOLt3+d27IJlKsCPSHArC2zydg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdUeDxkZzROqo++8FFs+Ara2LC2XtDzSF4UJ7sJkPwaPXbV2wyo/8W9s0QAcPq1+Eq84aqYQO/OjtPLSacHsxGWg9JaTAlr5eE20clvwuvTC317hIIEkvsio7opdIQSmTObrvtVovXHyqqnulOiROlmluE+VZysoTdfqhVG50jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=S4utW/4l; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cF/jWprwt28c4Hq83t+C5Fw83V3DhLNWIJ4LDAW3d8A=;
	t=1759313966; x=1760523566; b=S4utW/4lAMBObhH+AZVKTidJHkgjb8oN9bnqo3d7tyGS4wk
	8yWrK5Vw155VJhybfiODj8h4KuMhVEzY8H20Cfo5KaTLWUaeyJaONc5evxNf0bA+XBJrfdycWNspK
	0bWU2+dicrpu0YvpE+0Sh4JWYWnu7fj+Gx0KI3p0vGobpFpTOy96x+q+Zq55MhpC3c512X0ZOF0Zw
	c3grJ638ZpvH16U/yA8k5DzEkH1i41ldI1A98BFMP/OZ+pe0t3snjmZGleXXvXRaDpBbaVXG8In9L
	suWWvXAQLeQZszQc4OxGixAY1u5HMhDuPvr/48ywlpFYQX/BxCjFaTsoXVTGqsiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v3tvf-00000005gBP-0orB;
	Wed, 01 Oct 2025 12:19:23 +0200
Message-ID: <fa3283276fcc9e9795989b49bab21a9a4217582c.camel@sipsolutions.net>
Subject: Re: [PATCH v5 18/22] wifi: nxpwifi: add core files
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Chen <jeff.chen_1@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	briannorris@chromium.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com, 
	s.hauer@pengutronix.de, brian.hsu@nxp.com
Date: Wed, 01 Oct 2025 12:19:22 +0200
In-Reply-To: <aNz/vOlApzVzMLZy@nxpwireless-Inspiron-14-Plus-7440>
References: <20250804154018.3563834-1-jeff.chen_1@nxp.com>
	 <20250804154018.3563834-19-jeff.chen_1@nxp.com>
	 <6b8ff5139bb9c361468840046b757dfa5ebe1aba.camel@sipsolutions.net>
	 <aM2bmc49cJXDmcf3@nxpwireless-Inspiron-14-Plus-7440>
	 <aNz/vOlApzVzMLZy@nxpwireless-Inspiron-14-Plus-7440>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-10-01 at 18:17 +0800, Jeff Chen wrote:
> On Sat, Sep 20, 2025 at 02:06:17 AM +0800, Jeff Chen wrote:
> > On Thu, Sep 04, 2025 at 01:37:20 PM +0200, Johannes Berg wrote:
> > > On Mon, 2025-08-04 at 23:40 +0800, Jeff Chen wrote:
> > > >=20
> > > > +/* The main process.
> > > > + *
> > > > + * This function is the main procedure of the driver and handles v=
arious driver
> > > > + * operations. It runs in a loop and provides the core functionali=
ties.
> > > > + *
> > > > + * The main responsibilities of this function are -
> > > > + *      - Ensure concurrency control
> > > > + *      - Handle pending interrupts and call interrupt handlers
> > > > + *      - Wake up the card if required
> > > > + *      - Handle command responses and call response handlers
> > > > + *      - Handle events and call event handlers
> > > > + *      - Execute pending commands
> > > > + *      - Transmit pending data packets
> > > > + */
> > > > +void nxpwifi_main_process(struct nxpwifi_adapter *adapter)
> > > > +{
> > > > +	unsigned long flags;
> > > > +
> > > > +	spin_lock_irqsave(&adapter->main_proc_lock, flags);
> > > > +
> > > > +	/* Check if already processing */
> > > > +	if (adapter->nxpwifi_processing || adapter->main_locked) {
> > > > +		adapter->more_task_flag =3D true;
> > > > +		spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
> > > > +		return;
> > > > +	}
> > > > +
> > > > +	adapter->nxpwifi_processing =3D true;
> > > > +	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
> > >=20
> > >=20
> > > This makes me very nervous, it at least means it's super hard to
> > > understand when this may or may not be running ... It's also the sort=
 of
> > > custom locking that's kind of frowned upon.
>=20
> Hi Johannes, may I have your thoughts on the proposed plan to remove
> custom locking and rely on workqueue.

Oh sorry, I didn't realize you were expecting a response.

FWIW, that all sounds good to me.

johannes

