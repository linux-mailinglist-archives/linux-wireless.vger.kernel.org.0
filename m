Return-Path: <linux-wireless+bounces-18835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9A6A321CD
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 10:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F56160E53
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C674205AD1;
	Wed, 12 Feb 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZbAF63R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C11D63C0
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351458; cv=none; b=Ie8VprSr6y0+4hOvBdkM7gfMZyGoR7BHNA91O8NcpzoUFllS9AAGVgzoOmzmSuqL2QmA8oT2eiJmN9u755wzF2zUpbl0mwqohCwzVDGPVUJIpfAM4apkHxPSP1n210vnZWoLswW+yAyw74Yz3DRF4K6oKk0cBa2r+Db5VwB/lJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351458; c=relaxed/simple;
	bh=mx9RIlCZgzJ7uz/BeSuOXWrUXbBpNI8HQtY+HIUHhMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T6E2dhw+j/XKP84ST5ZENg5LXmK7YuRGGVodJaCoi+xSFvn4zX0Au1NRUGCpW77gmM5uMpJbeKzh0g+du9snUgKydB8kPETowN3IOUckD7XI8/IdE4MrIZghTB9WfmrD1CvSPJ7VKoNangxtUSHgNdhMxcufLru73pFz9uMUgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZbAF63R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635CBC4CEDF;
	Wed, 12 Feb 2025 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739351457;
	bh=mx9RIlCZgzJ7uz/BeSuOXWrUXbBpNI8HQtY+HIUHhMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BZbAF63RFxKRcZlS6kP5HcuiOvJ8Qk15ohuX8qcbGiR3jAu4FgACIGs54VY3035LS
	 lz7a8UaWuyquoglU5YhzPVIAs4jI44nIIgpSNWxHxQ1oziEQ8QYaHxeionQHTHYDxD
	 wyRepqr5crJqeDZjsbiwiTlmzA1Cjyln5ixCzqr8QJ2vaxzwADOwIVzcbLKKUct44o
	 L5mHCHti1ANtUreS42qmmo0KB5fdaO+7h5eEw4RO6nahtTEwtrHVuxHCMX9eaooRuV
	 h15zZpCkVnkFUEXl6DWSRyuSfz3BogoaNN/EM7mPAX/Y0hCNcMxkcLruu9KrCm2qMV
	 Wb+ohUVhGVkKQ==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 78CA35FA14;
	Wed, 12 Feb 2025 17:10:54 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, 
 Jakob Riepler <jakob.riepler@paranoidlabs.org>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20250129112554.27296-2-jakob.riepler@paranoidlabs.org>
References: <20250129112554.27296-2-jakob.riepler@paranoidlabs.org>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Austria
 (AT)
Message-Id: <173935145447.2475945.11593216402469454481.b4-ty@kernel.org>
Date: Wed, 12 Feb 2025 17:10:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 29 Jan 2025 12:25:55 +0100, Jakob Riepler wrote:
> According to the Austrian "Frequenznutzungsverordnung" Attachement 2
> page 404
> (https://www.ris.bka.gv.at/Dokumente/Bundesnormen/NOR40251378/II_61_2023_Anlage_2.pdf),
> Austria extended the usable range according to the EU SRD Band 75a (Implementing
> decision 2019/1345, current consolidated version:
> https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A02006D0771%2801%29-20220210&qid=1738145465756)
> 
> [...]

Applied to master in wens/wireless-regdb.git, thanks!

[1/1] wireless-regdb: Update regulatory rules for Austria (AT)
      https://git.kernel.org/wens/wireless-regdb/c/f9f6b306a830

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


