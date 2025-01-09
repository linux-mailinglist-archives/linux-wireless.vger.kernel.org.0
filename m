Return-Path: <linux-wireless+bounces-17235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79116A07550
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 13:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27293A78B9
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E892163B7;
	Thu,  9 Jan 2025 12:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="qqBTodTB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A0C18D
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 12:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736424595; cv=none; b=Oa/wfjJX/DT5Au6Wr6HKMSZHHm9Whv2/yokFOvg527u2OelXGmfjq0buHrLYlmXne5xME3QXh5Vtl0M4sVSyjfnyzMwYU1jKZ6J2U5WLZ2YCcb3PUQN0CcuWEDHNhITEIwS1ckZ90QrlcZQw/maClJL7W5Qt+5nO4TrDiHlRvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736424595; c=relaxed/simple;
	bh=7mwOqo829x+o2yDEHa8TN8o6zC36RFChBP1+dyYT19c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GlJnp0G4PSMz/GvYsZSlutxG6kfTB60NvPib59WzxMm2Ua4twYiMgHCDnUBsjs1pj7RYg/aRM18GZmfVVKxiGNWQWM77tHlCVLtZagFnerp5L9uThckVk3bSU3r9/cpYIaVzYHWd14OSCOr536FY6VWK53SiCRInJSDqjTaxfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=qqBTodTB; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1736424583; bh=7mwOqo829x+o2yDEHa8TN8o6zC36RFChBP1+dyYT19c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qqBTodTB63rhQUtXFNNDQ6lYZwTZdsi7SA6bk0/Rg+ZdIX+KF9mokH1aGZtmlvx3N
	 bJEk18qCbac+1f0t5YiESnTr8Th8ohfDlYz+zbkUv+3L03CyOlMn5CIsyBbEPMooad
	 nxyUnBf1nvR6++WmuQO415CEpLT5TT93OLkVWRrD2tVvXQWK/Asjyqsxp2xoH6iyfN
	 UA3NJdmfADe9lqHeSurc0b8klpT+ZzQMyozBijQHZiujb41/88JVY8w062cGfTj673
	 i1JCE9NfTqk/vOjIY7FUwl+EwLIDDd/BuF6EsvdYlQBbSIYk9+vtF3NxihjdZHNZU9
	 VEgjDZFbc2nUw==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH v2] wifi: ath9k: cleanup ath9k_hw_get_nf_hist_mid()
In-Reply-To: <20250109080703.106692-1-dmantipov@yandex.ru>
References: <87bjwp8ax0.fsf@toke.dk>
 <20250109080703.106692-1-dmantipov@yandex.ru>
Date: Thu, 09 Jan 2025 13:09:43 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sepsi3y0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dmitry Antipov <dmantipov@yandex.ru> writes:

> In 'ath9k_hw_get_nf_hist_mid()', prefer 'memcpy()' and 'sort()'
> over an ad-hoc things. Briefly tested as a separate module.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

