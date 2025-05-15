Return-Path: <linux-wireless+bounces-23001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DA1AB84BA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 13:26:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C1937AA7AE
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 11:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E98297A73;
	Thu, 15 May 2025 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="x0Bv9D6m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682ED297B92
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308376; cv=none; b=bOXHkTyazUyZ6dnJKlyqN2GBMGyrnZ+vonoB4xVcJrWbtJFD4fk82ItNCyxVJaG3a2B95L6ytBlr+t1w83J3CG71QJHKqPZTmSd3YrIaGzXIuxmQzugQ5xSO9GkBCgV/o0nqhUlghO7omFuE2LUNCp/6QHt+xcZCEDHRhfuT5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308376; c=relaxed/simple;
	bh=u0diE0kS+jUcrHpC+qLA/3MGg/AN3fKNGOx3YUvHie4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcwsWuBfQzhk2QwWHbE6rFgB0PP8f65+UtN9k/WeRqV9LgoFH5QVMN3BOQr0zZKzni3Y/xUBo9fuWNoKFM2JpxDlHtj79UWgotth8XIpTgLG29wIXvzjI2Z9AmddTIviEJ21FO9+zKV/G3ZTZOEZyd5t9GYVAXxlwlyBa2btAe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=x0Bv9D6m; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GAefFZIC0d/1HabheW0mKQ+DEOp9M6D5E1OaEccs1Ww=;
	t=1747308375; x=1748517975; b=x0Bv9D6mQW4NN/fS6KIMC8Jo+vB79zGGmsPb+L8uDAmkQwr
	YhkpJLu0WoUL2eY/SNvCwPQu+4sqtgSBv+mn4h1Jbe2n5SSGFubF3XYsaUyS+V+Aankd9KPrVTO+K
	y8bUNvXgw4fJVIyPhJS/ME2fYyGV+v4wBgGXZ94GBG9hyzRa7/be77c2TuYP2LwCL9gNSuNfgiSXI
	hZSDQnhKHVuSm0s/9GcxQli5WFKiNUSEO80NFKDVFx4VnurAXWl1W/Uxs+XM7/XH243XS4jAqHGo2
	iqfWFIZDFjfm6K7zRqOgu8c0QMpoJioH20JXHFo/uiSzZv8d7tzpYTZO1ASJYKqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uFWj5-0000000B6HQ-33Qd;
	Thu, 15 May 2025 13:26:11 +0200
Message-ID: <d8631594b48d7a60d92e2e07e71d312bc49072a2.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v8 02/10] wifi: cfg80211: add
 link_station_info structure to support MLO statistics
From: Johannes Berg <johannes@sipsolutions.net>
To: Sarika Sharma <quic_sarishar@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Thu, 15 May 2025 13:26:11 +0200
In-Reply-To: <20250515054904.1214096-3-quic_sarishar@quicinc.com>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
	 <20250515054904.1214096-3-quic_sarishar@quicinc.com>
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

On Thu, 2025-05-15 at 11:18 +0530, Sarika Sharma wrote:
>=20
> +/**
> + * struct link_station_info - link station information
> + *
> + * Link station information filled by driver for get_station() and
> + *	dump_station().
> + * @link_id: Link ID uniquely identifying the link STA. This is -1 for n=
on-ML

Oh also, the link_id shouldn't be in here, the documentation is wrong (-
1 is never used that way), and it's already indexed by link ID so it's
just a source of errors to have two values that should be the same...

And yes this implies changes to patch 9, but those are _good_, having
the link ID implicit in the output structure seems awkward.

johannes

