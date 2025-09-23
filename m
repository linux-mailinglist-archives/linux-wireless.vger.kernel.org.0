Return-Path: <linux-wireless+bounces-27603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D856BB94D2D
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E158219006FB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B22E9721;
	Tue, 23 Sep 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Ap49LlMj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82349154BF5
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613362; cv=none; b=QoZ08M9Ia7a33cecz/Ryget4H9qZPuRUFP9uzomM0/eGqelhFbc1ZuBepk9J7MOIF49nAt4QlVG1QCfVmTI3UqrJ/NssrhFTtjR32EyIC4fvvxmLgjdNHrbRTJmFBdiZnZFtmAiUWr67mZ+uOFeGrfb/SawcMy4TlN6L5vPSJQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613362; c=relaxed/simple;
	bh=ziwR5Jk8EsUky9Q+c7d+doQqEm6W1ePfzgD/rQ5mWGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQmJxDBcuNTFdh9/+/I9qNiu3ns8Ur5wCRoM9nVmp9ZPnebUiczF4RWn0232KsFbOiYkhZKr0n9R5ZwzT6YlVLcVcqvZKdxSJuE+SZTkfRA/l1S4Cw30VYpTMwna1cpsqMT32xNZ2/dqkdFBGxyoEk0PFEniO38hgTCD+Gr+kq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Ap49LlMj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=s0kPMVvE6H7E4KpPVU4AUkCERoqX7PdeWfbOoOy9ius=;
	t=1758613361; x=1759822961; b=Ap49LlMjr5NkpITJz+3PTPp8/zjT8+hw5dzH9IMm4J9qWSL
	nfvH7EsRi/rnygAdFducwMj/+Sq4DXzSxvqbjeWVMcRSGCCsQCbeyibuJrlABh/4LmGH0tSJ5LGKG
	YA8Ow7ZYabW2cm/lCFbqS8BEzsXpx+4oQXDYd16sdtdhPigdhEr0NdjKzkss5Uzi+ccPy9QJnuTdy
	MsI6YBfdsIOv7EhTN/plsUONHiVtAuGkdwtTIpP5+ijJuwTJRRHulvRJcKI1Lz9mD0f2V50nrg+N/
	s9sc6CYXVReTG7HdfmFJaaNtnYjBhNxFLkyXSacp3bj529NEpznA3BGfeO+8xLag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1v0xfZ-000000069p3-2UVX;
	Tue, 23 Sep 2025 09:42:37 +0200
Message-ID: <f1d05c2f9db0fd0c9960707eb2577cd0bec4b85b.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v3 3/3] wifi: mac80211_hwsim: add
 incumbent signal interference detection support
From: Johannes Berg <johannes@sipsolutions.net>
To: Amith A <quic_amitajit@quicinc.com>
Cc: linux-wireless@vger.kernel.org, Aditya Kumar Singh
	 <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 09:42:36 +0200
In-Reply-To: <20250923073554.3438429-4-quic_amitajit@quicinc.com>
References: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
	 <20250923073554.3438429-4-quic_amitajit@quicinc.com>
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

On Tue, 2025-09-23 at 13:05 +0530, Amith A wrote:
> From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
>=20
> Add a debugfs 'simulate_incumbent_signal_interference' which calls the
> function ieee80211_incumbent_signal_detected() and starts the incumbent
> signal detection.

"starts" seems like the wrong description - you assume the detection is
always "running" and this actually reports it _found_ something...

> +struct hwsim_get_any_chanctx_conf_arg {
> +	struct ieee80211_chanctx_conf *chanctx_conf;
> +};

I don't think that should be in the header file, and with a single
pointer maybe it doesn't even need to exist.

johannes

