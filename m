Return-Path: <linux-wireless+bounces-10991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9D94893B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 08:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A271F247DA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 06:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528D21BC089;
	Tue,  6 Aug 2024 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJUA2BHz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC01BA87B
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 06:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722924637; cv=none; b=oq4IRpztmfYUh3WDyyGiMtOzi2JOymesmTNPDkvYcjU5ADFf+IQyUgFC/q8N12E5oh5kx4TiR29hmKBNko0b4kDtNpPZxco4DAFJ0g/TQTVAssJqx1fsenACRTqYx2SuW+C+DEGNh8oIo0x4qGfcS2J+bi82DBqVTxcgmnWAUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722924637; c=relaxed/simple;
	bh=xe4TyJsYfcn1tWGldXgzTjCuFxSyYQ+iMyXl13WsQII=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ECsV1dnCDIHoXGe9voQ+JrDQS2ZN1z/lmviMQ9x8Cvx5MWUPgGcZgncQnJ2i1VjpwDrJnrguxEGxWua2/+PbBkNN/GUJgwMCKWWRk5CfV9kPgNXODca8mJMubb/wpe3nw44zh0MLW+SmOlCuxxWAvmk46vNicoDf9s3A4ErlkoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJUA2BHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4497C32786;
	Tue,  6 Aug 2024 06:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722924636;
	bh=xe4TyJsYfcn1tWGldXgzTjCuFxSyYQ+iMyXl13WsQII=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VJUA2BHze/EtcjsA+Rc690T+VBSWMXMr2eUWHDh6F+EzxVu7CTWelnLO9Dep7Jjc1
	 r4K059Kz0G+UowJxVXKsDJhEfswndC2XQVP5nb3ayvH8BXghkqYOdDoas8Yw3oO04e
	 6oIb8L6u1SsB5R5wRtFQxs3xZ8Hbywa5wcTL3gByU1Zl6jnuTXys//LmRRxUAiAxfF
	 OetZTLHhILwNyYH5gP5+0SB8GCEzBpx8t1ih7KZsPZ1fykwQ+3qNllQjUyDWNHHW3U
	 o3Pqm0l6vzug6CZHoIlpMxqOIe5Al072j/sfRi6aP6idFiTNmm51ihPIQ1ERnjNWS5
	 X2aNHap9peQrg==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 0/8] wifi: ath12k: Introduce device group abstraction
References: <20240628095139.292952-1-quic_hprem@quicinc.com>
Date: Tue, 06 Aug 2024 09:10:33 +0300
In-Reply-To: <20240628095139.292952-1-quic_hprem@quicinc.com> (Harshitha
	Prem's message of "Fri, 28 Jun 2024 15:21:31 +0530")
Message-ID: <87y15a5gh2.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshitha Prem <quic_hprem@quicinc.com> writes:

> To support multi-link operation, multiple devices with different bands say
> 2 GHz or 5 GHz or 6 GHz can be combined together as a group and provide
> an abstraction to mac80211.
>
> Device group abstraction - when there are multiple devices that are
> connected by any means of communication interface between them, then these
> devices can be combined together as a single group using a group id to form
> a group abstraction. In ath12k driver, this abstraction would be named as
> ath12k_hw_group (ag).

The design discussion is still ongoing in v8 so I'm going to just drop
v9. We need to conclude the discussion first.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

