Return-Path: <linux-wireless+bounces-21830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02C7A95F8F
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 09:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D649816386A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 07:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425631E5716;
	Tue, 22 Apr 2025 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h/8EwQLs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A238B;
	Tue, 22 Apr 2025 07:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307283; cv=none; b=TKaunXAdCSCah9lUtvLvfDW+HwqD6wpjtUmDr00SibsR8My0sBiOvqOQR5buI0v4YCRRWOFnpdj3lCzC2U0eEGh9e/QG7YXsnRnOe1LR6g8TNPE2lq2Ccllx5x2TgKjiJh4/TM0HJWX/r+erRmAkrl6gEDqoCJj8EEPQD9Fii2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307283; c=relaxed/simple;
	bh=EcrMJXlfEzXYZ/K+nb8RjfTzZzqNZBhBSfjgZylcs2U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RvTC2GFG9VJqMaS+BpKSF46QcdkdLlUcJ+ImUnyEUDfyL6+oZXkui1jwQu7uBL+fbWBMslekPDEKvjd/VEX4yHZ9miGrCqWSeHHOyy+i/dDmjRDws/3fI8BvvBET4g3fS7st2wX0ZneJd7HvdVQfZyHGm3TZa7sSUWI8zhIz3zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h/8EwQLs; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EcrMJXlfEzXYZ/K+nb8RjfTzZzqNZBhBSfjgZylcs2U=;
	t=1745307281; x=1746516881; b=h/8EwQLsEcwpeu0enTufXByTnSW7FWrPBCWay97uLHZA39Y
	UBHygEMidrBDU7CFrgFGBKV8ethRtPePbyBxd1BsZhjT0HzXnIlczJ0E4Sx60OewYR3CZiSfI4Rq2
	YCnw2sYbXI38Z6SkW9vw8kdVjSk3inwnKeUxtrLk5Y07p5YDZ6vAUqBhA+FiPSfg39Zdiziiw+6Xl
	JPvLGF6CfpFcJmQOOvGIDfGDaEyz8LOkh3ssxxl+Z9nYpBFKy84r8mLxpjLmWX683VCiiul2Y3AGB
	IjKG5F/shykfg0HULe/0RJnwSLhEpQmPART4Pu0ldFaTVKlJX8ztObtfKYVuqkWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u789I-0000000BZl4-0mcl;
	Tue, 22 Apr 2025 09:34:32 +0200
Message-ID: <c254c3df09fd2c3318f614e76187781be88c6030.camel@sipsolutions.net>
Subject: Re: [PATCH v2 RESEND] wifi: iwlwifi: mvm: Add error logging for
 iwl_finish_nic_init()
From: Johannes Berg <johannes@sipsolutions.net>
To: Wentao Liang <vulab@iscas.ac.cn>, miriam.rachel.korenblit@intel.com, 
	kvalo@kernel.org
Cc: emmanuel.grumbach@intel.com, golan.ben.ami@intel.com, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Apr 2025 09:34:31 +0200
In-Reply-To: <20250422023234.1992-1-vulab@iscas.ac.cn>
References: <20250422023234.1992-1-vulab@iscas.ac.cn>
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

On Tue, 2025-04-22 at 10:32 +0800, Wentao Liang wrote:
> The function iwl_pci_resume() calls the function iwl_finish_nic_init(),
> but does not check their return values.
>=20
> Log a detailed error message with the error code to aid in diagnosing
> root causes if encountering irreparable errors. While this does not fix
> the underlying problem, it assist debugging by making the failure
> visible in logs.
>=20
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
> v2: Fix improper code.
>=20

Did you though? Especially before _resending_ (whilst a lot of the world
has holidays/vacations too...) you could check patchwork maybe?

Actually, just don't resend unless you see that it's no longer handled
in patchwork?

johannes

