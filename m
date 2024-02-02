Return-Path: <linux-wireless+bounces-3037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A9884716E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 14:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4141F2416D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0404654F;
	Fri,  2 Feb 2024 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sk2G8Bhv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE3546452
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881996; cv=none; b=XYa9IsA1oH4Kk+WOavGvZ6SmIYaG6qSIVN0GHA4uIYZkGBufid8VIHf8dTJ9naKvUSVog72Q8ImdFmcR5JIg+3OmkuebxRBhd5pU5GUei0BgHm8Ny2G2/3kdTzHev+MEJ7mtG62P4Fj4xXnQv8my9KhszqxGdE9uggkJ2ZONUiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881996; c=relaxed/simple;
	bh=ffgf4Mx5xFtwuyyn3Ymye60l8jdlFrne+PEhj/bjap0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Nv6ZqiojTtQuDmHbzF1UD0m4DEWSK9PGiAWb9wqk3brQ8vu3zUY8pkRsCH9SFWZ0VBEiWKpoL9BOGcKL1QAXV4ztlaIcnhKX/ZUw6DIyCN3pOPMKN6ogbjw36ZmOFS+VyQ8H/1vBlaDlVqyBUYYxDrI7Q36/rShF36xs7rwaSM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sk2G8Bhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B685C433F1;
	Fri,  2 Feb 2024 13:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706881995;
	bh=ffgf4Mx5xFtwuyyn3Ymye60l8jdlFrne+PEhj/bjap0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=sk2G8BhvELvB4IpzTMDTBmJBlujNFQEKUjuuCYnIIomRGq+YPd+EbqCkxMvbTAGLr
	 y+wxDQou/5LMGELzJ/cg6mBfBz36GE0vStuGkREHhQ+npqaau1PlxUtz0ZDePKmrNC
	 070T0SvaJa2nMwjcnarMaOk3I8bfPDAx2ihOKCTwsPoZxC8ljJr7eTBNyqJ3/bqAOE
	 yhCj5MC/grACmLhE2y0R7Fmbd/odQN9XNoSA+I2Vhs5ltenWIMNCgJJLuTb1RU4qF6
	 omkG87PetLXEBPKYhpVzabGRrMslKlu9avGw/ashUVeU7C8o85S5wpT6gGscbYQKKM
	 ezb4wMa2imuDA==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 05/11] wifi: ath12k: implement handling of P2P NoA event
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
	<20240130040303.370590-6-quic_kangyang@quicinc.com>
Date: Fri, 02 Feb 2024 15:53:13 +0200
In-Reply-To: <20240130040303.370590-6-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Tue, 30 Jan 2024 12:02:57 +0800")
Message-ID: <871q9vt1km.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
> signal its absence due to power save timing, concurrent operation, or
> off-channel scanning. It is also used in the P2P Presence Request-Response
> mechanism.
>
> The NoA attribute shall be present in the P2P IE in the beacon frames
> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
> or when the CTWindow is non-zero.
>
> So add support to update P2P information after P2P GO is up through
> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
>
> Create p2p.c and p2p.h for P2P related functions and definitions.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

This patch 5 had simple conflicts in wmi.c, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cbcb45c458a93d32a48b9280c13294e0853fa5dd

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

