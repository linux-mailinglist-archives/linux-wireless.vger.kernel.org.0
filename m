Return-Path: <linux-wireless+bounces-28174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC4BBFB5D7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 12:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8717D3BC203
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA5F2FB0AA;
	Wed, 22 Oct 2025 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jxUQ+iCE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52992DF59
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761128223; cv=none; b=KX7QmHuo4BGfCG93VqXpm2cLD697+2mM/puUOfWb+VM5BrPjGDgiBWAELNwLKk2fGvuJcyYoSRzunEkXNQNqCtYHlQO8y23Fi8TzmTGvwDc3d3BoEnhUeyAPz5IXJh7HHAC1x93vx7mV593oncd+VLvY5yS8XEy4dHjgGRI1CV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761128223; c=relaxed/simple;
	bh=vrERtPjGAQGu+gvlP6A8SWvmn+Bx1Fj7ZUahLunzCRo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UeLiWKKHy/P5Y5rw1T9iWVA8E/XJIv/1cNRh5AqKgDD0Xcckc+PWOc+oPajjysB+ZCyiTy7SUduw+nlI98WzxlS4bmW6OjvzZW5eFbQTnkT6zETN+DXhIkwqd9SU17i+TcP7hfGXZBpv1SlOCujt+eO+yMnDVwBN6LH6HbPSgrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jxUQ+iCE; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vrERtPjGAQGu+gvlP6A8SWvmn+Bx1Fj7ZUahLunzCRo=;
	t=1761128221; x=1762337821; b=jxUQ+iCEGYE5FUdk9TQvWx5lJBvrEX0CbXG96Bj428Zw47e
	PN92vIYUnJE5usl468spd+yThRseI/heKROlNudhMjQ7Ji7V9vp0oQwJSy5eQlU1FPq4jjfMjGOje
	dGCbvMQquWcYqQR/hzW4ZCIxV63FVVyTiJB+tngQ0o90d2qFG3OoBmnvpAr9KZCBqFZu+kzgejQFu
	ofGaxwzxqlv/4a3NIZc7LDz+EYL5bKRVtB5xXlkINpC/H5T9j5C1ikCmMX5wLsn+7uemyge11Di9n
	vhKRYZf2CeIKZoiFdrVrrqEbZRigkxTR0C7esvnPaOoZsseDTIe8TlZtKLd/4WgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vBVtk-0000000EPDq-3yuO;
	Wed, 22 Oct 2025 12:16:53 +0200
Message-ID: <e0783988ec1399f610fae15064b3d62fd22cc03e.camel@sipsolutions.net>
Subject: Re: iwlwifi: bad HE/EHT 6 GHz operation
From: Johannes Berg <johannes@sipsolutions.net>
To: Avamander <avamander@gmail.com>, linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Date: Wed, 22 Oct 2025 12:16:51 +0200
In-Reply-To: <CAPLrxsEkpeCLLJtSd1BqVdtYWBrCndVwTJRZzqcCtEefzg=NOQ@mail.gmail.com>
References: <32dce695-4b41-46fe-a31e-33d86fefc107@gmail.com>
	 <CAPLrxsEkpeCLLJtSd1BqVdtYWBrCndVwTJRZzqcCtEefzg=NOQ@mail.gmail.com>
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

On Wed, 2025-10-22 at 13:14 +0300, Avamander wrote:
> I have a strong suspicion that "[PATCH] wifi: mac80211: Try to
> overcome bad HE operation in association response" might be the patch
> that tries to work around this issue.
>=20
> > [...] they advertise invalid 6 GHz Operation Information in their HE op=
eration element in the association response. Since the information is inval=
id, mac80211 cannot connect.
>=20
> I would really appreciate it if it could be clarified what exactly is
> incorrect in the HE operation element in the association response (and
> why everything else seems to ignore that error). This would make it
> possible to actually inform HP/Aruba of the issue and maybe get them
> to fix it.

There are different things that could be wrong, it'd be very complex to
really have the message explain all of them precisely. Even 'iw event'
can capture the association response frame, so it's pretty simple to
figure out after the fact what's wrong.

Also, Aruba already fixed the issue, though I'm not sure when/how the
fix will roll out.

johannes

