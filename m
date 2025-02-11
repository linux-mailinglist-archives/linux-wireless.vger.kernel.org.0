Return-Path: <linux-wireless+bounces-18785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544DCA314E3
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 20:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DD71607D4
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2CD1DDC14;
	Tue, 11 Feb 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="bX5qbcsR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF01260A38
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301608; cv=none; b=HnM6M5dKVVzS24EtwC56rsykWfnOlWh6wTmOoDPOTGkFae+GTTOdcAWdvy8tV+9R4jcvePkbQgeIHZSGlBYFz2Zn0Yevvko3dXGjxxUTDUX0OVhmic/otq4Y9OPawalJzenlaXFj0+MjOaEihGxerGZ38v/zclGIgbNGetoaRGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301608; c=relaxed/simple;
	bh=EE+yQbl5Ke4mLQFpG396YSrcPFiCdV/YSH73c0REjKM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=kr5MFYtXuvhBB/wen7fkDkKx+tPI4+n0s84iQEvis/SW6/8byblt2CxfXFDLIOsjpN4UcQvXGYecLfaE6/FkqRg6AOruIMHELR89Y4TdAzhFq3MnUUmeIhFQWvmAaFM2VCXV9k2tgbd37GigeBhrAdHtl3JQMrblaAibj/6F5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=bX5qbcsR; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5781EC005F;
	Tue, 11 Feb 2025 14:19:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1739301596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EE+yQbl5Ke4mLQFpG396YSrcPFiCdV/YSH73c0REjKM=;
	b=bX5qbcsR19xAof89llQ7c3ZqM3nDLPHc9zZWMR9qAUrguW73tvt0OTqWdtsRsW8DLbiBl6
	2XN95rRCAwX58VoRv8cvLwNFPDOjF8lzEiX4T+r6qUtogNroJ3JnEpmbt1w/M0orbstS80
	6HjoH3eUM2qVhHseCdE6dDv4LbVT7hc=
Date: Tue, 11 Feb 2025 20:19:48 +0100
From: Felix Kaechele <felix@kaechele.ca>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k@lists.infradead.org,
 Kalle Valo <kvalo@kernel.org>
CC: linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] wifi: ath10k: add support for QCA9379 hw1.0 SDIO
User-Agent: Thunderbird for Android
In-Reply-To: <4ac25dfb-ab59-4909-a717-41a6e752295d@quicinc.com>
References: <20240908013244.496382-1-felix@kaechele.ca> <20240908013244.496382-3-felix@kaechele.ca> <c1385aa1-0d41-4ed7-a00c-e40c69bafeaa@kaechele.ca> <06bf90a5-db29-46b4-b983-439c2b32b143@quicinc.com> <4ac25dfb-ab59-4909-a717-41a6e752295d@quicinc.com>
Message-ID: <ADED7904-C9B4-4E03-95C1-E74359638BB7@kaechele.ca>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3



On February 11, 2025 7:57:25=E2=80=AFp=2Em=2E GMT+01:00, Jeff Johnson <qui=
c_jjohnson@quicinc=2Ecom> wrote:
>
>Now that Kalle has stepped down, I've inherited this series=2E
>

Thanks for picking this up!

>I have one question: what firmware & board file does this use?
>

It uses a firmware and board file that I extracted from the original Andro=
id image=2E It did not come with licensing information, so I am not sure if=
 it can be redistributed=2E But it works fine with ath10k using this patch=
=2E

>It seems strange to enable the driver unless there is also firmware and a
>board file in linux-firmware=2E

I tend to agree which is why I inquired about it here: https://lore=2Ekern=
el=2Eorg/ath10k/96597f1d-5072-4915-be5a-e685dc85614a@kaechele=2Eca/

I don't know who to reach out to at Qualcomm to get clarification on this=
=2E

>/jeff

Thanks!=20
Felix

