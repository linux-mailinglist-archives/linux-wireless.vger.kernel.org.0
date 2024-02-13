Return-Path: <linux-wireless+bounces-3518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44539852C71
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 10:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0001F283B17
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642921755C;
	Tue, 13 Feb 2024 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="PK9x2VmW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D72208B
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817040; cv=none; b=kQUMi/tjNEFtdKvNg27+eM2WNuk03mQ43Pm1XxwdRXLnhyoJdXU2CDiy7sNeLH3J+H0EDL25q7WHCxkn3FdxU1pQMza1vkGXbNT0b+imEl7tlUuTS+S5mjU/HwG2u4jy9sbkhRBPxDW5SNBKWa/PZup/+9R0tLQa8Z0SVUGkBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817040; c=relaxed/simple;
	bh=n/bn1sazhQRK3SbnjKlUTbtjI4vU6RLByGDb5HLMTCc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lpZF92cBXOIkiomSliyiG0Aje1EPXwy4bx7YE4ZUGBTau7HWGbBEj9kZsyHiUzsJrKlM3VJukU8/SYbyiyKeDfmhD9JoLjHzDdOVgzSN/j6kU6vMePJ2691V+xG6KU0g2rFydNqUcL6BZ4LOVoreLACDn0umAgWCTJJ+o2sjk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=PK9x2VmW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rUziAM1PIpXU5SZJEejToH9QDEg5PfB2VkqveEI5BXw=;
	t=1707817038; x=1709026638; b=PK9x2VmWQq6pv1cVnIiXHJBnGFIPaEsjXvfY9IGl0gsHSoE
	RfiV7kY9EZEhmKuVp5PPqo1flH9n6Jugcd2s/nJ/316V4O6kfj89smo1jHm5I59PHJVVqE5pP/1ZV
	Fc143UPdMdU0I8Lrnggxa5+bEY+LynW78w6ULL5FXJ/ONxCOHFjeKqfEwLxfJVBo+ENGqgrvRe5cd
	U9z1D5ehaIf67tqOaNN8SXva3z5NVhTsOUPLrSBv80eMFxDnl8Twewwi9mxsNZVJ4tnas/tMUiR5I
	qmI05P/0rjpf0IoHTT+W2nm43E3pht68cdiWYWezySr1jTIlvfGVBMs6S00hZ2WA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZpE3-00000007a9n-0JUm;
	Tue, 13 Feb 2024 10:37:15 +0100
Message-ID: <9779efb62cec04926e3bb2575a8aecc8bbf0e7ff.camel@sipsolutions.net>
Subject: Re: iwlwifi RFC related to iwl_mvm_tx_reclaim
From: Johannes Berg <johannes@sipsolutions.net>
To: Ben Greear <greearb@candelatech.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Date: Tue, 13 Feb 2024 10:37:14 +0100
In-Reply-To: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
References: <c9b0c01e-acac-9f15-730f-a0ba991a68dc@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-02-12 at 15:22 -0800, Ben Greear wrote:
> I'm seeing a crash due to accessing an 'sta' object in this method that i=
s '-2' as integer.
>=20
> It fails the initial check for null STA, but I'm thinking it might should=
 check for IS_ERR(sta)
> as well.
>=20
> (I have my own patch that references sta before the IS_ERR check later in=
 the code, and this
> causes the crash I'm seeing.  I guess upstream will not crash in this sit=
uation.).

Indeed.

> My question:  Is the patch below a preferred approach, or should I add sp=
ecial checks to where I
> access sta and only exit the method lower where it already has the IS_ERR=
(sta) check?

You can do whatever you want in your tree, but I guess generally I'd
advocate you assume that the code does what it should ;-)

In this case, ERR_PTR(-ENOENT) is used to indicate the station is being
deleted, but has not yet been fully removed, and so indeed we still want
to reclaim the frames here correctly, which the code does.

The comment below even kind of explains that?

johannes

