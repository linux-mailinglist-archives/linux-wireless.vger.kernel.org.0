Return-Path: <linux-wireless+bounces-21004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B49A7679F
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 16:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848113AB257
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B55210F65;
	Mon, 31 Mar 2025 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="DG5k4RHO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FF211484
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743430661; cv=none; b=g2bl/HxKYuAzug3v0Jz5WRNgAf/JZFsNo/+j0Y/j7fPc+zZhJunt92uFZ6buivp7AedlssRfCfXT5G3fKu/ZH5qVy9as/B6BEWlthMjyQ+odZai1E661mpWDf4ZRjNe4asIRwAlkuPawlVV6DQHx6tdV8VFzLCWT4bpPnz8myy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743430661; c=relaxed/simple;
	bh=+HdtyRX86xFqfopPQ4+tgzczG5qidCXU6N/ucJSKV+4=;
	h=To:cc:From:Subject:In-reply-to:Date:Message-ID; b=Q1Pv2plWA6XIwnD+0Y2qVkmGszJwyuPbuPgVcopyN58dSSBZOOUzoWxCMhyL8u4BP7ClvVGKNj8XiCyL/clEsaK4OiDBM+QA2AekFvLdD0zlNpyWLm7LpPfWn46bCfAO4u9cIC2ldCcrKHGL7dEPdfTocMoG5492PmcSvurxwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=DG5k4RHO; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:In-reply-to:
	Subject:Reply-To:From:cc:To:Sender:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=FZHpTrWItph2xlICSUGFfu2WoC/CAS5Ls6NIa06L4Bw=; t=1743430659;
	x=1744294659; b=DG5k4RHO9OP/F6sMwh3O7rchQ8uJdefG0iITz5Om6Af/VFdeD6pEKbl/SgdGu
	ICmXPJN4nwi5/C5Q4jwI2bW/6i/bjQEKX44e5hEg9iijSStI8BzA3v8lqwxXyCrqgm/QHxoGDKlsR
	swJb3Uy9fWI29YPkQm5TiAl+aOBoPz72jmUrZWi5vccJUrempYThd6+xLPhmj643NjBQ705WiKlSL
	LiYVj4DcqN8OrodYmfqUAID4ZAA+41vzEnzT4q6UlpQwKMQjZ2j2dGT7fK2nxzZ4hWMlrEQIz8ryw
	GxKjS9XzftvkGtShhG4GLmfc3ZfH8Qgjz4KgP7XX4V37xgu6Zg==;
Received: from c-73-186-183-159.hsd1.nh.comcast.net ([73.186.183.159] helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1tzFxE-00GIAd-9V;
	Mon, 31 Mar 2025 10:17:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id 4E0441CF62D9;
	Mon, 31 Mar 2025 10:17:31 -0400 (EDT)
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
cc: linux-wireless@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: Re: divide by zero in ath9k_htc_choose_bslot()
In-reply-to: Your message of "Mon, 31 Mar 2025 14:26:02 +0200."
             <87semtgzdx.fsf@toke.dk>
Date: Mon, 31 Mar 2025 10:17:31 -0400
Message-ID: <87261.1743430651@localhost>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Toke,

Yes, your fix makes the problem go away for me, and does seem
like the better approach.

Robert

> diff --git i/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c w/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
> index 547634f82183..81fa7cbad892 100644
> --- i/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
> +++ w/drivers/net/wireless/ath/ath9k/htc_drv_beacon.c
> @@ -290,6 +290,9 @@ void ath9k_htc_swba(struct ath9k_htc_priv *priv,
>         struct ath_common *common = ath9k_hw_common(priv->ah);
>         int slot;
>  
> +       if (!priv->cur_beacon_conf.enable_beacon)
> +               return;
> +
>         if (swba->beacon_pending != 0) {
>                 priv->beacon.bmisscnt++;
>                 if (priv->beacon.bmisscnt > BSTUCK_THRESHOLD) {

