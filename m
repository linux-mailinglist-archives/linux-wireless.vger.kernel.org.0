Return-Path: <linux-wireless+bounces-15095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9149C08B5
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 15:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8B1B22B08
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDEC1F8EFF;
	Thu,  7 Nov 2024 14:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OsK1WFiV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4471212655
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730989047; cv=none; b=s/ZdJEbZUzXZEMjqzjXeYXd7H/euYgH/Z1ERMAnPW2Lui/NIdCzMa8BipehyOEbHHqynucAcIeVH6L9Xk/ewXF7J69VsfqOvW0tmnQIUKjolPFRrHI4hjPWUr1GXiVqHKOZoC4bu9qBh7UZKRBOqiQ33b6cdNHlYLXi+bHk5dlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730989047; c=relaxed/simple;
	bh=OZGPO32kI4865pt9I2kZ4rTZQzyBfAgCiby/sD0A+gg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YJHuX5U5tw4yGhzA/5fVgNwCiIZeVyJu5k8yn94p97vTEW02wdSS1jGWv1oYvjyoRdSolvkXAk24YkbQXGdKAgTHvTs/zIpoqrxx0Grzgim8GLryPmghoy98Ntwbc8C7eEaLwQn5OkFyQIDTC8B4cRbdVwU18Z25p2xxz+5VDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OsK1WFiV; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OZGPO32kI4865pt9I2kZ4rTZQzyBfAgCiby/sD0A+gg=;
	t=1730989045; x=1732198645; b=OsK1WFiVn9MYWJvLFU++p+o9zgdn3nJwqHgQm2x5Ny7wszt
	swI9RGYM6jPqduj8GFNfr4Lo0cj6WkpTZVJN0BRNVK5svHC7MwiYxX8gRhSMqUGy/iH2KC7btIrCC
	791UvRZy2yCR8FfsgKUvTNBl3v1CAAkpA6B8IfGRdT6Hxnqc/aHaIpT7VEksZyLmiq/fmRRX9QISJ
	rTVAJjD/DIBkTnxTMp9gim3y8XhLj23U5As35WO3dIg4pZAxpcw8Ggkg8oSo7/mBQy7XwwG4enhBe
	wRAfReEOXWbJItcj4q5G4Z3HJYZgrukrcgASH0a1VMCkHsyvQUL5qSpmngmW3qIg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t93K7-0000000GRrw-1tqe;
	Thu, 07 Nov 2024 15:17:23 +0100
Message-ID: <7417f6f79f979ab75ab252287d1955152e44c0ab.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] iw: scan: change parsing from in-place to cached
From: Johannes Berg <johannes@sipsolutions.net>
To: Dylan Eskew <dylan.eskew@candelatech.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 07 Nov 2024 15:17:22 +0100
In-Reply-To: <20240930181145.1043048-3-dylan.eskew@candelatech.com>
References: <20240930181145.1043048-1-dylan.eskew@candelatech.com>
	 <20240930181145.1043048-3-dylan.eskew@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-09-30 at 11:11 -0700, Dylan Eskew wrote:
> Since some ies require references to other ies, this
> introduces the infrastructure to prevent double parsing
> the ie buffer by caching the ie data rather than reading
> it in-place.

This is generally incorrect. Many elements exist that can occur multiple
times in the same frame, and with this change you'll only print one (the
first?) instance.

johannes

