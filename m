Return-Path: <linux-wireless+bounces-13362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5C598B703
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 10:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F11C21052
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2024 08:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4BB199248;
	Tue,  1 Oct 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="hwjHPtZ/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C21531E9;
	Tue,  1 Oct 2024 08:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771572; cv=none; b=bBzAq7vDApfTgYmac2czs7wgZS9v8s9HHw+Gu2v1JHVJRdx49MQU8c+LEAAW8mGY0efZKGQSE8W9wmxIV+hnEjPz0BeT76z6D+r3e/+zPSnNBIWAigQ8dxPU6PgV1ASWJcW1dcR1GgqVpwmlYgvgUvnaAZ0nTmEFlyVe+Bri02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771572; c=relaxed/simple;
	bh=XLPsa0FrF/FeoVzXEji8NRBLxMX78CFGq2xmTBLQBQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKTcwSvIwtXWoo+x7N6Wam8CenDLTWpq1Fx3zI9IKH6bxPAIfvHsLXF2jAoXwXoZ3lvvqDzja6WZZ4DpCu2s2/56zI9nHrerfa03pkRFssOQp76HPIhP7DVC45N8h9ohc4SYSzaPMs3OfHWvyWYqdnxIxTkXZDLKC/WQfWwkzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=hwjHPtZ/; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1727771245; bh=XLPsa0FrF/FeoVzXEji8NRBLxMX78CFGq2xmTBLQBQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hwjHPtZ/dQLe2TwmASYRTMVkqHsPwmEVTkyU+Yp1Ybz9o6oKVaO1HfEcTaxaYqKVS
	 zzId2lga76gcKyB4vw4eIyibfkrNBeeO9IYDi6kOA1n+864jcG2xz1n5QzfBujCEPv
	 tcsT1pX9GJMCqNJ+i1iixgUY5HSssvW5GUEInfvJrQSL0gGOIjlWsiZUm0FmYPphp3
	 v6rC+MppoxsAY1voJzIsz0C5OmiVsk/g5fKPwGSeGCCgNiOE75ltUk5kVFSt+qnR90
	 GAx6oblLH9s2HyS4inHMmH8g28Zahfz9K9w9PoLjBUJI+hPDlUqcfSG7NLVaxXEXNd
	 PKP+ptUtUbuFQ==
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org, nbd@nbd.name, yangshiji66@outlook.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: return by of_get_mac_address
In-Reply-To: <20240930230425.369534-1-rosenp@gmail.com>
References: <20240930230425.369534-1-rosenp@gmail.com>
Date: Tue, 01 Oct 2024 10:27:25 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ttdwqlci.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rosen Penev <rosenp@gmail.com> writes:

> It can return -EPROBE_DEFER when using NVMEM. return it so that it gets
> forwarded to _init.

What bug, if any, does this fix?

-Toke

