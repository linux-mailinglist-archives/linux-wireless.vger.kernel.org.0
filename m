Return-Path: <linux-wireless+bounces-3941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EEA8606CD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 00:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B681C20C5C
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 23:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D632232D;
	Thu, 22 Feb 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G865VKLR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B420DDB;
	Thu, 22 Feb 2024 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643864; cv=none; b=MImsTjeUgSAR4RrJ67en/UQBs2Km4UxxZ4SqIRrgfW/kS0tS0AFJSTZRfEXSELPcQPEUpLU3druyCwtLtvWC5qPnPPPVts1LRY7EXXFyCyveZXPpxAVBYM3yQC3gGmvDw1UNVcK1et4Tw83Ke7yKIRFtGZ5yG3K/iBPIpctDSVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643864; c=relaxed/simple;
	bh=vMu6Og5kisyi6T/CxqeSkHyMDgfWC0eoG8WmTIHxmbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnzJ/2lWs4oR31p7Y48ksRZAh9MXZSRHT1ULEvXa7kasTO1q265i9UCB5nw2+YXuW7eON1/C86Wglb1XySoWQz3CJKlG3FKIo2E7XFLubMPkYNGKbr1RdM+SHQ7elhjIWQfS4Rm/1yPbQC+1JE++Y4M+Pfds67pnMLateQvpb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G865VKLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40865C43390;
	Thu, 22 Feb 2024 23:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708643863;
	bh=vMu6Og5kisyi6T/CxqeSkHyMDgfWC0eoG8WmTIHxmbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G865VKLR6nTBQJu/TFvQKaaji8W5bYqjV2oAj/fKF++Mmehvfsk7XrK9CTVT6SnAO
	 JdIGndPL43Ka40hUwT2+7tOoiFncVkbs7GoF65E/GjIfrIiDpChGtjy9xqabHeMSTU
	 J04BwlDwBCK/tsD0QFbsw6ydPbs375Yn4cU/FRiOK838QAWcAZ3j775fATOFhRBOyO
	 Q2S1+Ix4r6obQoCz/LlOr0b4CT3fGDEy/w/RMWTRvVCFKSbjDakyBcJ4z8q9+me+/K
	 wfH0YlVABx8ZKH3gN9wmvxMOLbnFbgjsI4lg0oS2v6eGC0O52iya5OBi9YcmXJT3EJ
	 Kif2nsEomOMEg==
Date: Thu, 22 Feb 2024 15:17:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Karthikeyan Periyasamy
 <quic_periyasa@quicinc.com>, <netdev@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>
Subject: Re: pull-request: wireless-next-2024-02-20
Message-ID: <20240222151742.2b41bf3d@kernel.org>
In-Reply-To: <87wmqwahoj.fsf@kernel.org>
References: <20240220165842.917CDC433F1@smtp.kernel.org>
	<20240221143531.56942c6e@kernel.org>
	<2dbb3ca4-78fd-4125-b13f-4ad440923291@quicinc.com>
	<b25a5783-a9ca-4356-ae17-bbda1340b522@quicinc.com>
	<20240221172521.4dcb382c@kernel.org>
	<875xyhaxs2.fsf@kernel.org>
	<87wmqwahoj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 12:59:08 +0200 Kalle Valo wrote:
> The pull request is sent:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240222105205.CEC54C433F1@smtp.kernel.org/

Thank you, much appreciated.

