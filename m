Return-Path: <linux-wireless+bounces-1903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969A82D33E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403FF281578
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1A23B7;
	Mon, 15 Jan 2024 03:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbreavbS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA07323A7
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E6EC433C7;
	Mon, 15 Jan 2024 03:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705288474;
	bh=2ig79RDAIR350Gcr2/dh8FnclyFbe2ixCqAqgiVLLSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NbreavbSsQwiQp84Vcwa58rtFmIRNdHhEB95CP2hcMQ1UPwDnFhE0hXDYil9qYPpG
	 tHSiqUQ6+hw47mPNCAL+/wit3eZZNxUcrJRCPMNV6LouBF+EQzqh2HG2Os+KLUeDwj
	 HytMrK4+JQJv1i58LgzdhYaFutm/mPd3mNFSvJIsb4rp+CUseMNtqXUHX0EEMlRKZ9
	 84enJ8o+9MtRBNGv46CuMV4Rmt47cW6X4FMwSUeOWzlPHraqt7b7A6L2N8jLqovOtf
	 i8diUQhJpDrVspXelWzRzZ6rOlujt9dS+nQWB+xf4JylAf4DWH83/DoQ/1ccpnunRM
	 tIoeUbdDXhTQA==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 02AE75F7BF;
	Mon, 15 Jan 2024 11:14:32 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: linux-wireless@vger.kernel.org, Andrew Yong <me@ndoo.sg>
Cc: wireless-regdb@lists.infradead.org
In-Reply-To: <20240112034311.23677-3-me@ndoo.sg>
References: <20240112034311.23677-2-me@ndoo.sg>
 <20240112034311.23677-3-me@ndoo.sg>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for
 Singapore (SG) for September 2023
Message-Id: <170528847198.770636.10523925169343032062.b4-ty@kernel.org>
Date: Mon, 15 Jan 2024 11:14:31 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 12 Jan 2024 11:40:44 +0800, Andrew Yong wrote:
>  - Update regulatory rules for September 2023 IMDA TS SRD [1]:
>    - Enable 5945 - 6425 MHz (Wi-Fi 6E) band per legislation
>  - Switch units from dBm to mW to match values listed in legislation
>  - Extend (5470 - 5725 @ 160) band to adjacent 5730 MHz to enable Ch 144 similar to US & TW regdomain
> 
> [1] https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-consultations/ict-standards/telecommunication-standards/radio-comms/imdatssrd.pdf
> 
> [...]

Applied, thanks!

[1/1] wireless-regdb: Update regulatory rules for Singapore (SG) for September 2023
      commit: bd69898e6f400bee1bf7863f2c65341eb7c746a6

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


