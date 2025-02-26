Return-Path: <linux-wireless+bounces-19491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B698CA466DB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 17:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77FA3A496A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809C2218823;
	Wed, 26 Feb 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="edVlc3rM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501014EC62
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588267; cv=none; b=Afx7pRzfJ0rB0k1C84oottoTkQPLGajqR7PlFXXaXXuSwLFhrzDrvI12EDGs8O7FmbaiJo8aGbPQ0DHDrBB7kTc7oYdIpU9uw30l9X6uFOzaKK3bH+x4BeMMtRb3o0fzfnAXJjkE5SEQZsFUzPiX9UFVhmlvbqUoKNZziTSwcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588267; c=relaxed/simple;
	bh=bo9T8ojXtui1TXdtJPKM3TpchjaapRwHEqTXns48zrI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNRFV69b5G05ftna5BISPopQmUbu+Dt22baar1S9jhsxH4Px85YQNmhgXGB6b2x940DcEok9PT4CZgQevhv5rZCyZZNvExCRLyCOptnNfz3O3ytrimr9bNkFsdcaEV8ZdSedMm0QKKqPIoUdZc/kpdK94UQWggDrWr7V17L7w4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=edVlc3rM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bo9T8ojXtui1TXdtJPKM3TpchjaapRwHEqTXns48zrI=;
	t=1740588265; x=1741797865; b=edVlc3rMDEawXNMx8ildINCvZLKLWJDy6GlxQ+37qeQoQBU
	xmNlis+S9w9dFnN8Za9F6V/jYqOvrZG7ptbNxIoqoItj1H8/SEddH8O0seKvzxsNonE+zVT+xgXfK
	MHEuqVCspFn/NM07JFnPXzeHLggptWEqmyifn+r9itcM2bhFn9YZ0ZVhNO8gWFcK8atuQC3C0BY1f
	IY6K/2zbxD3CRfPj9jBpF7I1og0ooAy3JYzEK81cNRQq5LpdPB4rYg73JzTlXsizVmPcP4hcVmXSy
	01tlM8QkkceaFoA0jbjpmSBStrVS/C8bbt0bIRRs8TZaJbPmnyjh6Nulo4I7NMwg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnKWE-0000000BcUG-2J7l;
	Wed, 26 Feb 2025 17:44:22 +0100
Message-ID: <cced003772c7174f4b2c9bf59d1b556c25b23bce.camel@sipsolutions.net>
Subject: Re: [PATCH v3 00/10] Convert mac80211 to TXQs only
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 26 Feb 2025 17:44:21 +0100
In-Reply-To: <8fa3ffd9-ebaa-4db1-8d1d-ed0cb6802872@wetzel-home.de>
References: <20250220104426.82011-1-Alexander@wetzel-home.de>
	 <1fa2f33a67ee1c6e537095888df44c7adeae64d2.camel@sipsolutions.net>
	 <8fa3ffd9-ebaa-4db1-8d1d-ed0cb6802872@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-02-26 at 17:42 +0100, Alexander Wetzel wrote:
>=20
> I'll try to reproduce that. Are there some instructions somewhere to get=
=20
> a comparable testsetup to the one you are using?
>=20

I'm just using the UML based tests:

https://w1.fi/cgit/hostap/tree/tests/hwsim/vm/README

my current kernel .config is here:
https://p.sipsolutions.net/4d1a905718fa54e3.txt

johannes

