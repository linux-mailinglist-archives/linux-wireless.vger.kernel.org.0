Return-Path: <linux-wireless+bounces-24288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C1AE1A82
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 14:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888ED4A54B1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 12:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEBA28A1F5;
	Fri, 20 Jun 2025 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ifPTQ/Rh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE9F17E
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421233; cv=none; b=NS6yCyDbOSydEqO+istunol37t8xaha2C9LLqgXYr1xUhCNiMqKhSJ19nN3PfMlxMkfuebGXmZsP+VK2riNezCzkg9p2y2GCLzlMXa3BVWQT18IBawDd6VqSua5lP/TlC7izefmQQz3S061GjrHc4iKUdVK2lJmYZ5/wxaoNaVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421233; c=relaxed/simple;
	bh=9jpHB3P4u3CdVzwOgdTOW9WzvTenRp2tCBkclncsTrM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwX8QglRpuZSotCPAQ+MhqCMVJoH22SCNXPO72CsZMxes9MjQYTI6xXT4NIa1Rpac13nwEUrrg+W2jnkJK6+8SsqX398IGEf5Au1HGsp/MgqgycKoQhBJDF3dSEYKUWrRN4q6gevrCYodJkDJWgCYFz6oWtORyNUTj/ur/i+M/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ifPTQ/Rh; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9jpHB3P4u3CdVzwOgdTOW9WzvTenRp2tCBkclncsTrM=;
	t=1750421231; x=1751630831; b=ifPTQ/RhCVEtJhVXXZVcdYVzd9E6NDNAHCzG9nM8u3QnhZs
	V616Qj2fMo2y0Vt9//PpjwBuS4gqfXCPUF0oKESmqMawqpBb4Yp2Xj88krM8Kf1xZtjFnYSgtukls
	SNU6ZUscl0TWyEYUlYrPJIX9lSh3rczrsZxRKW89RZALdU6xyt7qWTctGQFCkSb3TezDE55G98sxp
	UJz3i3RE8nfmlFPqvjUN83UwMY1WOWiwXmbZSyQUne51Lk3h3bMK1OtBGVQ3qSx6lSmLo3F/4WTrV
	rIiJerJan266Ve4D9avEt4Hc5kw3MHepnPM2Qtfk6Ov4jBLgQZBwFo9lZJ7hOLLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uSaWS-00000002iXL-0R7Y;
	Fri, 20 Jun 2025 14:07:08 +0200
Message-ID: <bcf4480e054a29ebd4eae6927aa303f712f2f272.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band
 capabilities element advertisement in lower bands
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Cc: j@w1.fi, linux-wireless@vger.kernel.org, 
	rameshkumar.sundaram@oss.qualcomm.com, ramya.gnanasekar@oss.qualcomm.com
Date: Fri, 20 Jun 2025 14:07:07 +0200
In-Reply-To: <4d9d30d3-a011-46a3-b970-3ab0d647df39@freebox.fr> (sfid-20250620_140607_008396_D7C98A2C)
References: 
	<4a1c89a13b299588bf9c94dd545eda3e30fb5491.camel@sipsolutions.net>
	 <4d9d30d3-a011-46a3-b970-3ab0d647df39@freebox.fr>
	 (sfid-20250620_140607_008396_D7C98A2C)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2025-06-20 at 14:06 +0200, Pablo MARTIN-GOMEZ wrote:
>=20
> I'm not sure there is any actual STA that does this, but in theory, a HE=
=20
> 6GHz-capable STA could do an extended channel switching procedure=20
> towards a 6GHz channel, and include an Extended Channel Switch=20
> Announcement in its beacon. Having also the HE 6 GHz Band Capabilities=
=20
> element in that same beacon makes sense.

Only with the new _really_ extended channel switch, which has ways of
updating capabilities while doing the switching, so it wouldn't be
necessary to include it in the beacon beforehand.

johannes

