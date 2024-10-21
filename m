Return-Path: <linux-wireless+bounces-14241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE089A5BB6
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 08:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AB11F2131D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552851957E7;
	Mon, 21 Oct 2024 06:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FRAjB0n8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DCB1EEE0
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 06:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493651; cv=none; b=ie7ILU2VrsZzfgaNRTB+/rnsfY0BJ1rAYo52dWMrtLHAAsqvPIBIlhA4UZgKFNbZKgNYcN0nr5WLM/xOmmo1rKRVMdITdXlh4eEXO+n8Gg8JngOZc9NUyxzImS3fn7CM38apftjX5iJh9nETgBrKBhaw4ojjEi+87vkOjD+8IcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493651; c=relaxed/simple;
	bh=Rv6UeUMhtdDpy9UNFqtWuKjaeQe8ZoU+lClBXLAXwgg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euXHWREehx9arJGAZLeXXGJO8WZh2HnE7rdZcnL9E3/Tz9VOvX4L9hFbRbd8hdTsYsq5h9jtPRTRFPnuokksJncVjGVNDEJwk6YELrwoWawhTTetvSRRnqKidk3p/o3MWRNMk9ETu3Fb22P6GgavZJtqhCV3+kpHzKwS4r4ORtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FRAjB0n8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=gQRc2WtWHVN0QxW36xNnnOxr7ynaE6MLBSkUxe7B/EA=;
	t=1729493649; x=1730703249; b=FRAjB0n8Wmd645i4ZSHBXlXGkHCEErRWwn0oEpZHYZnDoDk
	F1QhpCE1Wj+i1JF4dkvVAOhaiivxjqejQxA8XaF1RaQTNTtx9b2xkFTAV5aqYHyKzg2roPac1Etgj
	ofSknOZ2TGaG0Lqt/87hQMVt7Zo54ktGSxFiOAeRMOpDTUKy/UIzdEaIuP6OcBOPZs7VvEdctquCG
	zo86MB3deoonETX7ravcsAr/e6r33r7DM+23cEizynQTXenn2dtyhWZSVW+1iXZYOZvRJ6tQR7k7/
	6rkIHJ7CmBDqsYcvO+a1e5r0Z3Cv0JSEcrTJShRTlyGyrGHsRJgDpPduTCjtzkgA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t2mIh-00000000fbq-3eEl;
	Mon, 21 Oct 2024 08:54:00 +0200
Message-ID: <ee5e7f5020bc874f477def3b1ea79339f0812b40.camel@sipsolutions.net>
Subject: Re: iwlwifi GTK rekey is not working with WPA3 SAE encryption
From: Johannes Berg <johannes@sipsolutions.net>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>
Date: Mon, 21 Oct 2024 08:53:58 +0200
In-Reply-To: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
References: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
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

>=20
> HW in use:
>=20
> 00:14.3 Network controller: Intel Corporation Ice Lake-LP PCH CNVi WiFi (=
rev 30)
>         Subsystem: Rivet Networks Ice Lake-LP PCH CNVi WiFi
>=20

I guess with the issue you're describing, the interesting part would be
the precise _firmware_ version. There should be a line printed on driver
load (or firmware crash) with the exact git revision (and hardware type,
which would be easier than trying to map from the platform above.)

johannes

