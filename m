Return-Path: <linux-wireless+bounces-5626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950F48926DE
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 23:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A32284250
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 22:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC854BF6;
	Fri, 29 Mar 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="WLHI84jq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD428DCA
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752030; cv=pass; b=oEKzSndGkTuyKgHpEXEf2AuJNWlohPfNSyUXAwG2EBsis7BF06ZVI2hiQonm1WcRIKeNteUsZYAx3pdG/+MbTKzgf2k2XZI/g446EImWDcIt7jNUpKLLr0noIbJYYfxK7TaXanCMsyAzajyZlZXf7VLo/+IYlwAq/SC45bV+m2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752030; c=relaxed/simple;
	bh=+NVxXRpcb5Eu5Xuis5cdwzL/CLDSHHEsOUJ6slCa1ZY=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=RBPzSLWiwd6FkcH/abXzdMCzP21CgnSFpjg/80Odi6LgtpIkTzTwQAX0A2xlM9O7NWW8XuQOzsKRudVQpH4EaOdC2IBPbOzNP8NftcrTfcWZVskr1gsrapgCCZqqBcN5OEkr27BG6+ZCcs3wGo5TFobcYeiCQJ2fkea9eO2WlME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=WLHI84jq; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4V5wN50f0Pz4WYr;
	Fri, 29 Mar 2024 22:40:21 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4V5wN46tbxz4S8H;
	Fri, 29 Mar 2024 22:40:20 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1711752021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0KWbc82XY20N6N4WAODbgFtVAzry/IwFpFWBfsmE4uU=;
	b=WLHI84jqi4rw6ZkSqLva7LEgcgjMDY0CuYLfmB469+0UEDtctCUlt3+mzg6VJP1zqpFdmq
	hCRVuuyyrM3Rg2a9XJeiyl3fJfQuEqMgR+9dHhwaiqbPOTcLhZSH5y2t5bygPVflabnfCd
	1FMXpGXYypiGBs2G2GTOrgiGw7FSpR76EF5RAnZP9/dzmhsqBJffB72GbuRvesFj2qNumt
	cCiAl7KlM6qWkHbuZm1zZj9/UaCvu8qpRbJb8SGJY3HIDKHdKXTtTRpwig35LmRonId2qF
	6FYdzL2entjgXbIAc+nlH41ovzKVSEHWSv7q70j2Fo+g4gsAV4Lx3PrxUreVJw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1711752021; a=rsa-sha256; cv=none;
	b=Z174SQvQR3nn/P4qswFJgahqkv5fsL/P4S6IXrxsObqa8mhUGeMEFn6txcLTUVEcCa58wa
	JvLSSFYnHyxuUSo0eNRIjS8QhRuVrvLoLuZZUDFa5afXixCzKYA/XtA1dhHIApvOYiUePy
	zJFcd1razys0FP6Mptp8BYPzJgn80HOXz2BgNFnTvlyynNz+u9sv6e7Hr3B9iU9iaYPrty
	GCPq0zS5+jIyosxVROpWxM3BtOuam3QFNHGmuXGlQWkX3/m9z4d/yTg2LYF5qLaEEyUSOx
	+ndbFdIfPjEvDZBu72wLlTW2NccI3PY7LCvjEnKXLGr4gQ6mFU/GjTpEJCImfw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1711752021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=0KWbc82XY20N6N4WAODbgFtVAzry/IwFpFWBfsmE4uU=;
	b=mbEYFPMr302fUNkaUwIs75J4vIqOTsQFZjKyIDPjJKGqgPBZ/fjTKMIK586wtIYvNXnc6R
	hFfahOYL9+52H1kQvqDAGL7jGOKz9mC7LdE1ZiyTg5EgWEEvs6sC3gNqsu21zRaPJerBL/
	s5WUTJgbJdkyKZ3yNuwVAiScjsnK2HSZplH1T8c1mgqWpPaOOFnrXuQlmr8OmZEQOvqHnQ
	eIfcBwMCNyPjOjBHIvz8w8P6QJ0ZW7VfBJd/Ky3CErlLoLQ9wqzVejVfPdc2g/jC2reVoU
	V7vDg/AC0bQybNHtPp7FL+IYPq8rd+uGoqPerFjfZGKyHxBgR42cl0AFKYae0w==
Received: from mx1.sbone.de (cross.sbone.de [195.201.62.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mx1.sbone.de", Issuer "SBone.DE Root Certificate Authority" (not verified))
	(Authenticated sender: bz/mail)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4V5wN45cyYzf25;
	Fri, 29 Mar 2024 22:40:20 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sbone.de (Postfix) with ESMTPS id 593738D4A162;
	Fri, 29 Mar 2024 22:40:19 +0000 (UTC)
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id B3FB12D029D8;
	Fri, 29 Mar 2024 22:40:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id t2VatLSMXWGQ; Fri, 29 Mar 2024 22:40:17 +0000 (UTC)
Received: from strong-iwl0.sbone.de (strong-iwl0.sbone.de [IPv6:fde9:577b:c1a9:4902:b66b:fcff:fef3:e3d2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id 9525E2D029D2;
	Fri, 29 Mar 2024 22:40:17 +0000 (UTC)
Date: Fri, 29 Mar 2024 22:40:17 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: miriam.rachel.korenblit@intel.com
Subject: [PATCH 0/3] iwlwifi cleanups
Message-ID: <431o2997-oqn8-p0ro-sq6r-pnr543164r85@SerrOFQ.bet>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Starting to reduce some local changes in FreeBSD against the
upstream Linux version of the dual-licensed bits of the driver.

These are three changes removing dead code or hiding code
behind the appropriate preprocessor check.

Please check the MEI changes accordingly with the multiple
compile-time options under Linux (hope your build bot will
do that).

Bjoern A. Zeeb (3):
   wifi: iwlwifi: mvm: remove dead code
   wifi: iwlwifi: remove function declaration without function
   wifi: iwlwifi: mvm: check for CONFIG_IWLMEI to be enabled for more
     code

  .../intel/iwlwifi/mvm/ftm-responder.c         | 80 -------------------
  drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 --
  drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  4 +
  drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 65 ---------------
  drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 -
  .../wireless/intel/iwlwifi/pcie/internal.h    |  1 -
  6 files changed, 4 insertions(+), 155 deletions(-)

-- 
2.40.0

