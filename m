Return-Path: <linux-wireless+bounces-3817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10B85C1F1
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 18:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10981C23AAB
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD87768EC;
	Tue, 20 Feb 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoWZm1T+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB2776419;
	Tue, 20 Feb 2024 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708448633; cv=none; b=EKp5gdXn7mm0ZRC17WuFDlSMGoSxLEcyg2VGMLz6ZbNTfFsN/QXAp0nPjOdOMWTAwWUnUnYhxvXwJwmDg3cYFhzr6EYiIJ9WTwx/EKCH2EjTz06jaFGdv6/ygmpa/imaVyMnQiFWLmCkYsAjTqmwjjELQ5AKP4abxDzmnnTDazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708448633; c=relaxed/simple;
	bh=aKPgxeY/o89mmFuGicQBQ6dN8Gd+rRdWgyeKFotbNII=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XV1GZhpYQ0RvH27+z/M250ERDbAlGZ44S4jhACx4ydY1IfnNc2AB1ozdVOTGJPo2zYEigidok82A0AhJ6cddvd5v3p1d6DX9lWjCiutTfxfcK9P6y0I9lRDNSqxEU6oIL9tbGgWOYWqtpm67GRId/8N5Ng0Qzapg8HZmiMePa+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoWZm1T+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDC4C433C7;
	Tue, 20 Feb 2024 17:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708448633;
	bh=aKPgxeY/o89mmFuGicQBQ6dN8Gd+rRdWgyeKFotbNII=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VoWZm1T+3qVdwyVEkokBJIj4x+MUZQK2mp0WZGy/81xucyahC92qe8sDVC1Jr1nps
	 ONSwOx2oKA00q424zNlBr+IMK8gUP/HXasYH0B6Eu2bKxZqEvr8m/7Qw94RAyS74ac
	 wjoXDCTq80u8ZNAbHJ8LsjdjFMBILRNSB1tYFVHZaPvAOr2/kkX12w0KgzX/4fRZ/l
	 oPyx/Ej4Yov1wDfeyBRdPp92aNbUxEze8L/vAB8J4qXutRxXV1KRccsOAr2IIFwRSW
	 4/b2Hz0EP+HtWcfSZB3ip8fxVYV+EP5BH/5n3QQvr1YMM/1j0Tbg3wl/XXKDLMyWND
	 HUG4s15u7WUow==
From: Kalle Valo <kvalo@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2024-02-20
References: <20240220165842.917CDC433F1@smtp.kernel.org>
Date: Tue, 20 Feb 2024 19:03:49 +0200
In-Reply-To: <20240220165842.917CDC433F1@smtp.kernel.org> (Kalle Valo's
	message of "Tue, 20 Feb 2024 16:58:42 +0000 (UTC)")
Message-ID: <87r0h7awzu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Hi,
>
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
>
> Kalle
>
> The following changes since commit b7198383ef2debe748118996f627452281cf27d7:
>
>   wifi: iwlwifi: mvm: fix a crash when we run out of stations (2024-02-08 14:55:39 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-02-20
>
> for you to fetch changes up to dd66185c23f71af36397bebfc99ede608dca07b6:
>
>   wifi: wilc1000: add missing read critical sections around vif list traversal (2024-02-19 18:21:36 +0200)
>
> ----------------------------------------------------------------
> wireless-next patches for v6.9
>
> The second "new features" pull request for v6.9.  Lots of iwlwifi and
> stack changes this time. And naturally smaller changes to other drivers.
>
> We also twice merged wireless into wireless-next to avoid conflicts
> between the trees.
>

[...]

>  drivers/net/dsa/mt7530.c                           |   34 +-
>  drivers/net/ethernet/engleder/tsnep_main.c         |    4 +-
>  drivers/net/ethernet/google/gve/gve.h              |  144 +-
>  drivers/net/ethernet/google/gve/gve_dqo.h          |   18 +-
>  drivers/net/ethernet/google/gve/gve_main.c         |  862 +++---
>  drivers/net/ethernet/google/gve/gve_rx.c           |  135 +-
>  drivers/net/ethernet/google/gve/gve_rx_dqo.c       |   91 +-
>  drivers/net/ethernet/google/gve/gve_tx.c           |  128 +-
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c       |  108 +-
>  drivers/net/ethernet/google/gve/gve_utils.c        |   31 +
>  drivers/net/ethernet/google/gve/gve_utils.h        |    5 +

This diffstat shows extra (non-wireless) changes like the ones above but
then actually pulling the these are not shown. I assume 'git
pull-request' got again confused due to merging wireless into
wireless-next.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

