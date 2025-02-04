Return-Path: <linux-wireless+bounces-18421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB63A27443
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 15:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C800F1883327
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6720F082;
	Tue,  4 Feb 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ql6z45ZH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDF20A5E0
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678941; cv=none; b=Sffpxm346tPg4NBM9Hbo/Ifhi1gT1g09rrNAIKUDVhcdiPlGyxYryY1Fyzigh2sbOBlERdCKKljgiktBmecv7ZO+jrZ0IJQR8CvzjAW+Az76tEWO6msz+RnZhP31i191FdmvQj6B0SqDLecMG6rh42M07zRnN2lqzI3nmH5ijD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678941; c=relaxed/simple;
	bh=SfhiX3bd15S+C0Ps4amhR+XTEHDRYfb1zfhYs8Yns/s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6rTtt/p66H1p/sSFUJOka5JwVBkT54xPuAs3nR7ZxUvVaMR2nf3zqJQOdtMtX0/uP7I5EskluvDsPvDFRbBdAWxlP6ejwN/wQX9NTHvnenUnFCaJ3a77UWIWzpgokljG7rzye21cHHDNX0f0jpjCRuru9dbxBWnlxr9JwDu3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ql6z45ZH; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SfhiX3bd15S+C0Ps4amhR+XTEHDRYfb1zfhYs8Yns/s=;
	t=1738678940; x=1739888540; b=ql6z45ZH3065p4HNKb8Der/xzjvVvxrFivrIrrxYmxb3MBx
	TWNclw+ctpYLCXaDqOHPlvrYkOlw5PAIhsqnNEBdaCUNPw7A9GVtgUHWFmHtIUopZQIDhf2KlSNnO
	pcoEZjtQ3i06lfHVsRpGtBZ78QHJAJ2dqq5TJMT6aBO2I1zZGym6WlXZ/qNja70EgN3TvGNrYdka+
	J8ZznMxPWGHHwOx6F0hjseYj72yAclynws9hX4T0p2QwxKa4Y10LgU+QPq7HdD5FxUEc7iuFIAuNf
	ZDYzyPs+8SiSWn1QhHAMZcjErISLDy6lQp9p1agBoFQEyYLz6tc6dCWBUWzF42gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfJof-00000002jD3-0ytQ;
	Tue, 04 Feb 2025 15:22:17 +0100
Message-ID: <e226c0b952cfee6390ccfcc4b65aa241c173c25e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 06/13] wifi: mac80211: Add new TX queues to replace
 legacy TX
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Tue, 04 Feb 2025 15:22:16 +0100
In-Reply-To: <7771dd96-b388-4331-b7f0-2d8257f4b3fe@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
	 <20250127162625.20747-7-Alexander@wetzel-home.de>
	 <03d0cf2612d6bb5e4a6d5e50650be12c81702ffb.camel@sipsolutions.net>
	 <7771dd96-b388-4331-b7f0-2d8257f4b3fe@wetzel-home.de>
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

On Fri, 2025-01-31 at 19:04 +0100, Alexander Wetzel wrote:
>=20
> Since txqi size depends on local->hw.txq_data_size (for driver private=
=20
> data) I don't see how that can be squeezed in a static struct or type.

Right, I missed this part... so never mind.

johannes

