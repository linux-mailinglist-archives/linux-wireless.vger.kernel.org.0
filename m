Return-Path: <linux-wireless+bounces-2866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6EC84389D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1390BB260E2
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B705813A;
	Wed, 31 Jan 2024 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpVlxGdi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD058137
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689025; cv=none; b=EZSynpQ15UN44w61oVK7lu3h7UDnNge6mwVL2m63pjcmMdioz+enL+ARoEbJJMXxwJRsyV9vcAaFPbl/51m/C7ER6Bm8msciONtRzG/7uJdRaFB6NJD/aG4Loh/mnK7WJ3YXX8f1DbLEotBnVwfcYDy1AbHXkq7KCd0RiYHTfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689025; c=relaxed/simple;
	bh=OzitZ4w5MRiDU+CtZ6xvojyOdJEIVvovbM+ND+ZDIzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t07U/B/RiJPTcEf0hobi9jwWNG1fYaAhhgn365gFTa/YbfnBB0xZxvGW+eFvNpiWMEsMYtvdcRCklGrlMwPrjwlNtsD4MNR5LpRKvpMPd/ZeUA2rp8JX3PaUIY6l+39jdEJZJenoxjeEGL6vpYaiD3U+lTnEofk5kM52ArKtyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpVlxGdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDB8C43390;
	Wed, 31 Jan 2024 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706689024;
	bh=OzitZ4w5MRiDU+CtZ6xvojyOdJEIVvovbM+ND+ZDIzM=;
	h=Date:From:To:Cc:Subject:From;
	b=dpVlxGdiQEXSYuEiI0omUaTNEru5V8OpK8JwOM6BHqlYxZAIzoiO2U+i4WdYaaUZU
	 2zrhzW0sbeFEoBh5HwQaiORBKP9C75ehYv9P3o+vkWnIlv7my8oX/CRkiJbCOkoNAx
	 whoXUHiIDGDc0QHzSJE34xZVof35alqesbe5eGTMq3O7ET7IKzkppB1G3Ty1ssMZqj
	 saz8xu79dKqbGfUyNa16tNMZvuCu19wn+wwANYYR/swpJ7K8Ci02azhFZJtYLPwQra
	 6LzeAw4vP0cgVppp3kYL5LcK5GtI3Bj8eOrX0Ud7OJfV9r/A3PzVAFzlP4X3i6bL+M
	 DSxInrfC28G4g==
Received: by wens.tw (Postfix, from userid 1000)
	id 6D7175FA78; Wed, 31 Jan 2024 16:17:02 +0800 (CST)
Date: Wed, 31 Jan 2024 16:17:02 +0800
From: Chen-Yu Tsai <wens@kernel.org>
To: wireless-regdb@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2024-01-23
Message-ID: <ZboB_mw_abHH2sJj@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A new release of wireless-regdb (master-2024-01-23) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2024.01.23.tar.xz

The short log of changes since the master-2023-09-01 release is below.

Appologies for the late announcement. There were some permission issues
preventing the tarball from being uploaded.

--

Andrew Yong (2):
      wireless-regdb: Update regulatory rules for Singapore (SG) for September 2023
      wireless-regdb: Update and disable 5470-5730MHz band according to TPC requirement for Singapore (SG)

Brian Norris (1):
      wireless-regdb: Makefile: Reproducible signatures

CaffeeLake (1):
      wireless-regdb: Update regulatory rules for Japan (JP) for December 2023

Chen-Yu Tsai (2):
      wireless-regdb: Update keys and maintainer information
      wireless-regdb: update regulatory database based on preceding changes

Jiaxun Yang (1):
      wireless-regdb: Update regulatory rules for China (CN)


