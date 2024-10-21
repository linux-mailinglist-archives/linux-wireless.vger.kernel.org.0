Return-Path: <linux-wireless+bounces-14259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE99A626B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 12:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84416280FD4
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FC1E885;
	Mon, 21 Oct 2024 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="cZfrc41Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04AED2FF
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505885; cv=none; b=Rpu0oV4wQi3yAw3OZw3MCQTrkwyu/cKaLNSDUgv5aBNrAbdH0Nu6y7hF3VOQp/GtTXDvec0m2Dq8Jxq7y/kZ/hIAVQU25/CqTq6dNPZgy0PExIhd4BDIBWSOijnc75pWVlOXOzugRYUhR2DB/o3/QGJTM4/QWXXS41nLpfRRQCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505885; c=relaxed/simple;
	bh=ZvIlVlJYwZOL/Vfra5ViRW4fIsB1yw9CgQbhkAwuMoo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qQgpMvVr2RQ2l10XcMhkiNDfXrnvUCRiscI29ypdfAw3LkYmtdnnIhlXXHsB8Bae+XdLmnKkO5GbRsAh/jVV4R08ianMiTIO00t3MQZoigsgYBW5mv41KqZcVCLPkg6R/9R8hrYkECPO0NQmo33KMN4nQZ5/K7/QzaEESX10VLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=cZfrc41Y; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pSuP9f5j0f5/zmMYhQKWkjQ6GUjeRU23pfHIEMWgPC4=;
	t=1729505883; x=1730715483; b=cZfrc41Y3uhSjeQMJXhGl3abS5N0RjBZO/rVUzJfQOqiy/N
	2HSlnJ281q+f1CWFrZvPc9yr9Gzw2cATU8lMhyCxB0S3O9hX4re/nBkm5EEgQyr5WDSXBJuDnIdEC
	NK9GX9AX2ZcLgbjMnspAqJwkhsNSJToub3IeJ2CgPHHfLiK0Qqdz1laDpLgF9RswpiyAx4Ok16SFD
	CU/2pkmM/rzpI7odOhgn7SGemATyAvx1O3d6mamIiYbNDTf+1jiqmWVO2KB+Kxzdjk70ZBW02DPEW
	MZ4+RN6TXdKuDE8XwzGd0Ttt6YBSPAPkw/ZPZQmEIeiRASyENR9MpJabrywdRPJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2pU7-00000000jq7-3a1y;
	Mon, 21 Oct 2024 12:18:00 +0200
Message-ID: <e96a1d4b63388e8d7e8a9fadfce31f408ae83ab2.camel@sipsolutions.net>
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Mon, 21 Oct 2024 12:17:59 +0200
In-Reply-To: <a45e6c7a-7348-45a1-9ce6-7a5425b21a36@quicinc.com>
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
	 <ee5e7f5020bc874f477def3b1ea79339f0812b40.camel@sipsolutions.net>
	 <a45e6c7a-7348-45a1-9ce6-7a5425b21a36@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-10-21 at 18:05 +0800, Baochen Qiang wrote:
>=20
> Oct 21 17:50:17 xps13 kernel: [  153.758773] iwlwifi 0000:00:14.3: loaded=
 firmware version 77.0b4c06ad.0 Qu-c0-hr-b0-77.ucode op_mode iwlmvm

Huh, I'm surprised you have that version :)

Hm. Support for SAE AKMs should've been backported, so that's a bit odd.
What's the AKM in use, ciphers, etc.?

johannes

