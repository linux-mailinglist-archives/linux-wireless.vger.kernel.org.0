Return-Path: <linux-wireless+bounces-1044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BFE819357
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B9F1F26409
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 22:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA573D0BC;
	Tue, 19 Dec 2023 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XSP25rpi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09483D0B1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=KvqbJmEecayc4q9h0P5KQCSdNriwdR3kO53xk7xMmvM=;
	t=1703023544; x=1704233144; b=XSP25rpiJU1mD3RZY9ldwSmPJyXN30pfXZ1dZuPutFMDMf0
	1CVq5n370TQvbZ9T7flNpYgZQTmxjXSuAD9udPlOQzN/0ZC3IOpOWRAdRsWdPyhZfvEcGPNNZc6/T
	ut/gVZRqUNsbWCfcM4+1kAqCWU6N7DsD3HcEbdL8JJZ5iBZer6PqgvFVDYp3M1VAeyugko9da1odd
	UCIw68joBNouWp8rFtDjuDoITwKwWQVm3Cq+C7GJGNIEa1I6q/302jQBKyDDGn83zhmpXiM9pcrSg
	1WrrbE3ydhNZAyhzO/8mdDB+xJPeJYehfGK6BJjHKL/dRle+GXnAiu6/jAMEBdbw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rFiDW-00000000Lyo-27wX;
	Tue, 19 Dec 2023 23:05:34 +0100
Message-ID: <abf0d4355bd0dab86119984067f42394a70f35c0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 01/13] wifi: cfg80211: reg: Support P2P operation on
 DFS channels
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Andrei Otcheretianski
 <andrei.otcheretianski@intel.com>, Gregory Greenman
 <gregory.greenman@intel.com>
Date: Tue, 19 Dec 2023 23:05:33 +0100
In-Reply-To: <45a96faa-013f-4c2c-95ba-191709324607@quicinc.com>
References: 
	<20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
	 <45a96faa-013f-4c2c-95ba-191709324607@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-12-19 at 14:03 -0800, Jeff Johnson wrote:
> On 12/20/2023 3:41 AM, Miri Korenblit wrote:
> > From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> >=20
> > FCC-594280 D01 Section B.3 allows peer-to-peer and ad hoc devices to
> > operate on DFS channels while they operate under the control of a
> > concurrent DFS master. For example, it is possible to have a P2P GO on =
a
> > DFS channel as long as BSS connection is active on the same channel.
> > Allow such operation by adding additional regulatory flags to indicate
> > DFS concurrent channels and capable devices. Add the required
> > relaxations in DFS regulatory checks.
> >=20
> > Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> > Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
> > Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
>=20
> Curious if there will be a companion change to wireless-regdb.git to
> allow this flag to be set in db.txt?
>=20
> Looks like we haven't been very good about adding support for new
> nl80211_reg_rule_flags to dbparse.py.
>=20
Yeah, we really haven't, and it seems that nobody really cares any more,
since all the new devices have self-managed regulatory? Certainly that's
true for our device, so even if we were to add a flag and all to
everything related to the regdb, it'd have no effect for Intel NICs. So
the interest is pretty low ...

johannes

