Return-Path: <linux-wireless+bounces-26580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B77B3389A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 249CB4E2623
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Aug 2025 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F47E2877E5;
	Mon, 25 Aug 2025 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N7RZjF+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF787225A59;
	Mon, 25 Aug 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110016; cv=none; b=OCUZMoF8mfQ1Czwtiq1OR1c7IqLxmPtEJmAl2vaZAr778/nGeFVGclfoFdZnQXVkzAyn+8wxPQ81uutphEca2Y/4LfC3dmRCcGwfIuTOCCzJd41eVAUoG3LI7GSBNcLTr6uP2cfxS3hJFR0i7YRZCJYaV4uUzuIDBOiyAPBYcFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110016; c=relaxed/simple;
	bh=EbzhpPOjLi3kH55G5+vHCGUnZrR8M1xHYP6BhMDkE2w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIsQJdnqDFrZ3FgABBgY+VGmzltX1BpZzzy9pPGavu04KvcBNv6Eca7RskH5cH+uhprWhB8YXagCwAmANMw9do9kEq7Of18ZXlkPFjHaoelT51+t6k8fwBKme/q0GHCj6/9XEVdUvzWKROHMI58ZIs1qARCy6itVJg1dLxK0DH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=N7RZjF+9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JjdTDWtQIxrGilIZgCVBGVSdcEmwWIR6irdMFSFg1uA=;
	t=1756110014; x=1757319614; b=N7RZjF+921Doygr3G4eYSHhs3U7/Yg+dVZSqvIHNrPnrhIj
	OFHDkTIx2v1tD7BPSlhbaJTBq+haH+OipyArxV8pLgNuC0KzlyO4AiyJgtyzVo1nsQ1M21Axzudgg
	kYY1rbUmIqcMINaO5yWzcvxi9vg3/A4TW+edqBUR1C9ErG5NHS8QYen3oaeCClXY2oJV83qWzL7iR
	uA052HvoMIpJEwCoQVYLPN3/Y0PUT6vOOWPAPI30/p0K8E8nuikL/C75dkSYlS29gBZh9/MvoqODi
	mRSZeKwtvtX4YE6kkSpUH5fPDO9F6yucifFVv9a0BNopvN8WiDPName3sUGt+1Mg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uqSR0-00000001bsE-26fm;
	Mon, 25 Aug 2025 10:20:10 +0200
Message-ID: <4f8037dc97958e06dfb08d75fce982c1e4e36068.camel@sipsolutions.net>
Subject: Re: [RFC] wifi: iwlwifi: mei: Remove unused flexible-array member
 in struct iwl_sap_hdr?
From: Johannes Berg <johannes@sipsolutions.net>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 25 Aug 2025 10:20:09 +0200
In-Reply-To: <fbc03dee-273a-4c75-a8bb-fbc6ae48d26d@embeddedor.com>
References: <fbc03dee-273a-4c75-a8bb-fbc6ae48d26d@embeddedor.com>
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

On Mon, 2025-08-11 at 17:23 +0900, Gustavo A. R. Silva wrote:
> Hi all,
>=20
> At first sight, it seems that the flexible-array member `payload`
> in the struct below it's not being used:
>=20
> drivers/net/wireless/intel/iwlwifi/mei/sap.h:
> 298 /**
> 299  * struct iwl_sap_hdr - prefixes any SAP message
> 300  * @type: See &enum iwl_sap_msg.
> 301  * @len: The length of the message (header not included).
> 302  * @seq_num: For debug.
> 303  * @payload: The payload of the message.
> 304  */
> 305 struct iwl_sap_hdr {
> 306         __le16 type;
> 307         __le16 len;
> 308         __le32 seq_num;
> 309         u8 payload[];
> 310 };
>=20
> If we remove it, we'd get rid of 14 of the following type of warnings:
>=20
> drivers/net/wireless/intel/iwlwifi/mei/sap.h:318:28: warning: structure c=
ontaining a flexible array member is not at the end of another structure=
=20
> [-Wflex-array-member-not-at-end]
>=20
> Is there any case where this array is actually used that I might
> be missing?

Check if it builds? But I don't see it used in our internal (and
possibly more recent) version of this either.

johannes

