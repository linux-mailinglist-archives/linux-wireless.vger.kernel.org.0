Return-Path: <linux-wireless+bounces-14692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB269B59AD
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE071C226CB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 01:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABD114D717;
	Wed, 30 Oct 2024 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUgV+S/0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D598F1799F;
	Wed, 30 Oct 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253393; cv=none; b=kpBGOV5jv0Tdy0ibi0/b0faMcC7T0WiQH413VfXTJBQtvlk+efdxYcoee2C/BeFaJ9+2JGSsOxhglE8UHHGxXGcHHr6JOA8Iaxk1gZ5rC57BPeBXteJoCaG/MsVyrsHgTmaxrmvyTDZxaSW24ct82IFIlgz4A+dZm/yHGuBzyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253393; c=relaxed/simple;
	bh=s6c40MMuxqK9dXwt7S+Tw4zsQwTxe6gWBD7osnAaVWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmGYV9dYCJWA8RWm6OwCH/EVdJ12nVe/P8ubakFhkzKblK9LfvhonKhbw83bMCnSKP0dOVfo5PqTDXFDydLkFAIF962MhlnofUA2+RX5LRB2Z8b5hDePUFnHIUwtGfcS7ZHCNRBMUUIo7CRhuEC8w+MiPrLekZFH/T332ape/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUgV+S/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476B7C4CECD;
	Wed, 30 Oct 2024 01:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730253393;
	bh=s6c40MMuxqK9dXwt7S+Tw4zsQwTxe6gWBD7osnAaVWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jUgV+S/0+uw4IBMYvDC98DhxlaTSaxPy7wAkxNUImsxUYbyOh1y0aUD2HNHM9xIXU
	 7GJ8pRqNU0ph5Cep/heCJoTPQWEEmFL1LifCJBFalQuG1SEZisqr/3TBYQPswHF/6e
	 UdHokK8UGM0VS0GH9KC8dSoCCHPrQ3U5ibNEULMhSe6yO3CY8ekvUb2nXCJagWby30
	 qzh13N1Ap1ocjjH66MOwRDuZyuW4Aow5Jg48Epe+NcWz9Iz/dxQRwLJ+xriEHSZr1i
	 xBooA9H8HCN7BxFUT4MII164XKfyD7M6cpjpqlW6DBUvTSTYh0tHFAoYan13G8jVCH
	 qHTY+Nk/dhaWw==
Date: Tue, 29 Oct 2024 18:56:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-10-25
Message-ID: <20241029185632.30af9592@kernel.org>
In-Reply-To: <20241025170705.5F6B2C4CEC3@smtp.kernel.org>
References: <20241025170705.5F6B2C4CEC3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 17:07:05 +0000 (UTC) Kalle Valo wrote:
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.

Only problems on our end like vacations and broken CIs, delaying things
:)

