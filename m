Return-Path: <linux-wireless+bounces-17426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CD6A0BA8F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F82160C06
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878A322CA18;
	Mon, 13 Jan 2025 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qdkRAcbt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7922C9F2
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779973; cv=none; b=m51jMuzKHop0Nr2cgPhbH3aX4h3FyBg1tLX3g9FgO4F7fHwk6M3VWefQBByOp2osjqD+DKEGmzVpMlB0tP9Xw+ZBQRptwDa3hGfIv0//8jmBvm0Hqze9L6TruGEW/B8PLj/tC286oKsZ2MEYa01f2haiER6xY4PnjuK3pyeJqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779973; c=relaxed/simple;
	bh=zWzoS3SH0lHhhnLmAkKbap6GgS3GElT949gEXQ6BA9Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Va19K3SiHACiwWlxmVNQXbqoFkh+mf8X+/j7/3zi3JtKC79vv4aiqc1eC0sW+5c5xzaTjiOfqlH76pz3Vut+03ECsLpkznUz5RXFNfyZYZLaBiEVypGsyOHskUfZCDB0NOjraQ9zFWui5HTXCRG+EmFc+ExI13kkCuwP6SG/rek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qdkRAcbt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zWzoS3SH0lHhhnLmAkKbap6GgS3GElT949gEXQ6BA9Y=;
	t=1736779972; x=1737989572; b=qdkRAcbtPAj92zEZXcYPeyoP2GhTdAOzbh/EaMJnDWKhJwL
	7wKnDwya10lW/owuw+0wLThnNtAwzY8Tr4LF9xeFmqoWqc1DyB618dEY9jlyZ4YHSUR9viyYUt/rI
	nbE26TL3p7mPO6+FBjaF7+ZetdPQGZpnQGTj1asS7CkpEGJCfYHvLjqQs7rZfZOk3W970cqD4EUbv
	mC1BQn/oZhaMi7V/4oMV7YzNmR2ub5P8a5i1u8ngKlRewjXViwuUPaseSHX3+fAtPBTQJPF/Vmuzp
	T6qbaYaFk9fkSg+EogozR2TQJg5VV5VEuQneqwotUuyU6bcArG+LZtbqrMtg3xAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tXLo8-0000000De3O-3CuG;
	Mon, 13 Jan 2025 15:52:48 +0100
Message-ID: <2fbb6683ecbef875d5946a71b5a3295ae8cb6f7b.camel@sipsolutions.net>
Subject: Re: [PATCH 05/17] wifi: iwlwifi: s/iwl_mvm_ctdp_cmd/iwl_ctdp_cmd/
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, Emmanuel Grumbach
	 <emmanuel.grumbach@intel.com>
Date: Mon, 13 Jan 2025 15:52:48 +0100
In-Reply-To: <20241227095718.2d2cc9910535.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
	 <20241227095718.2d2cc9910535.Ic2b6f265d0b4aea25ccc7114d6f48afa621871be@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-12-27 at 10:01 +0200, Miri Korenblit wrote:
> From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>=20
> This command is not related to iwlmvm.

The subjects like that are just being lazy, I've dropped 3 patches like
it, please resend.

johannes

