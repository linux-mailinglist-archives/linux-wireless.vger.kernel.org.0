Return-Path: <linux-wireless+bounces-29282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 337ADC8059B
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 13:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8EF2D4E7605
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0D92FFDEB;
	Mon, 24 Nov 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LBN+0rS3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAAA23E320
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763985534; cv=none; b=RpKQZzQS4lp2H3R886adUR/iykUFpjAoenRcoCGwtmUcaEJL9xlDGtctOjhDYlWCsVr8ELaJzBphrB6u6TOFAnRe+xI6mX58Mx19sElhpJ2jE2HnXdEe1YgeyQVD1kv8yutbRcousnumUEz5ezKT67mBYbV4DX0jQ95YuBpylew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763985534; c=relaxed/simple;
	bh=qrSTwufp4I0Xy2wTE1xuGeYY43pbXlIBsypshHXrB6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwwE20QIOMn57UctR2ZQ/XdCIVHtJTwSqcdWKhDr+QWEjoan6gm36hTGPBGjnPmnVNZ+7I/Mx2hQ9MXO+BCyv/kCp8uN5l1dBEkKQedTHeqZXrSsaDFieQ6ulCKWiMSkxgzPRX1ruE9teZJ08r+10BaFqzJl5VmuPdgTNmsCb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LBN+0rS3; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qrSTwufp4I0Xy2wTE1xuGeYY43pbXlIBsypshHXrB6Y=;
	t=1763985532; x=1765195132; b=LBN+0rS3oAEmFsWv10gQ/0eGEg33x9ZgkpYC5vLgQ4E5R/l
	koO6CRvVAI8lj+qNexRYG5yH65xEx3gBU6PewOdtPRTluOvUD6jNDiLV2PPzUlM8WHXVmgM7Omou/
	cYIP2MAPsBWCgatrEGFWMsR1O+XPFExr1f+18Hkc4+8ZEeWgdU6zbhOabtCnC9Vp8Ehz9KC8xRfMp
	/8PALUDW24KZmEFMA3Vg+7vQTByV29LBGbWIqmWKIyn9AXoHG8mAhV59PlTEQxuhBQhf9szF7M79F
	4zqL9nFN3m6X0o8yEg3J9hR1ZO8xkM5osFA+pk7waBHI0E82xnGy+F9LEDc4AnAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vNVDW-00000008pz0-0xoy;
	Mon, 24 Nov 2025 12:58:50 +0100
Message-ID: <8600724587814a992d649ce8feb72c4a3d20c8c0.camel@sipsolutions.net>
Subject: Re: [PATCH wireless] wifi: mac80211: correct FILS status codes
From: Johannes Berg <johannes@sipsolutions.net>
To: Ria Thomas <ria.thomas@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com, 
	pradeep.reddy@morsemicro.com, simon@morsemicro.com
Date: Mon, 24 Nov 2025 12:58:49 +0100
In-Reply-To: <20251124061111.3627341-1-ria.thomas@morsemicro.com> (sfid-20251124_071140_139641_21ADD152)
References: <20251124061111.3627341-1-ria.thomas@morsemicro.com>
	 (sfid-20251124_071140_139641_21ADD152)
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

On Mon, 2025-11-24 at 11:41 +0530, Ria Thomas wrote:
> The FILS status codes are set to 108/109, but the IEEE 802.11-2020
> spec defines them as 112/113. Update the enum so it matches the
> specification and keeps mac80211 consistent with standard values.
>=20
> Fixes: a3caf7440ded ("wifi: mac80211: add corrected FILS status codes")

What?

johannes

