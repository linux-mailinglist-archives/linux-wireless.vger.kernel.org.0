Return-Path: <linux-wireless+bounces-12849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE49784B7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 17:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0192B28C7F
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2024 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94446136E30;
	Fri, 13 Sep 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="OPVSIUWv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8518512E1EE
	for <linux-wireless@vger.kernel.org>; Fri, 13 Sep 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726240796; cv=none; b=TNS8RstWTQLAeT+vzldCZAJCholIhreJYWGzjNfBUws6Et7sEoKQTMrNYNS6pZCgFN4iRgVIezMXUqSuwjNFkJgiSEh7l5Y2ap7OlZasRAG3tmmQex35EOUCVN8oeUssoljiGfem2TgWrsnXCah+rzJZ7mnzaz6zkk8+L+LXHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726240796; c=relaxed/simple;
	bh=KvURk45ai1sHwVd9rBkoQlFp/8NpDL9GpgstHyspZ94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+WDjdbuK8/Py6cHBhhhQT3aDEzWPvy+hq3qObMPzkvoCDkyNNrct3vIxTx7jI7kBNBHg7A7YFtk+rvqvgkTE4wXQBK0AwdnEKXF5K64u4PUhI5AfvoseiWaICpReAz6I3iNMDe8jLlIwzem6wAOvsvdDclbCAUlOgnThRJ7NK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=OPVSIUWv; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1726240785; bh=KvURk45ai1sHwVd9rBkoQlFp/8NpDL9GpgstHyspZ94=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OPVSIUWv4EfLPNn5i0u4+HDcTOIWI/Q4s+AqcOnFy3JfFkWPt1XrcsL/pnakmPI47
	 DkelP4wY4UUcSRXLlOPk7uyFXNhoz5/hAgvLNBcmk0cRXq3voFofhFtQN1vIAvczHY
	 mZH+tYtZRTNVHvyncLSCQnSnAAJ5QGHyzG7XDeu7kl/OynHNb2RpDvbi3K/vpwRje8
	 oxzIiVHq/4Z9tUYMjX6Z7A012GN3K9g/8qyI70p+fVliQpHqcO3AEY5Z9Su5XgDu+H
	 ikyzGN6aZ/48YxjprYIZ+P6nVE9pSkIrLFWx23451hem6coAUBsqjTZrHCfhkdIn7y
	 MzkETEVALThbg==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, nbd@nbd.name, yangshiji66@outlook.com, hauke@hauke-m.de
Subject: Re: [PATCHv2 2/3] wifi: ath9k: btcoex: remove platform_data
In-Reply-To: <20240906195359.6982-3-rosenp@gmail.com>
References: <20240906195359.6982-1-rosenp@gmail.com>
 <20240906195359.6982-3-rosenp@gmail.com>
Date: Fri, 13 Sep 2024 17:19:45 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tteja8dq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:

> This is completely unused as platform files are no longer used anywhere.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

