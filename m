Return-Path: <linux-wireless+bounces-3140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA28484A022
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 18:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1371F22245
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEEC40BF4;
	Mon,  5 Feb 2024 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofx72Ccr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAB40BEF
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152398; cv=none; b=hxp6Shg7JqOifE9RBNOPqC1zcVfPEOuiSDj54k9NvZ1YR0WSrSGTg1cYzVQgzmLx8SICNVpCVe1x3Me1SOhyiVbh11M2i1AMn3iNmkAjQ6jqafx/vA5KGXBOD7uVcrrlY2ednFP7FClYPwQTRLKSIPG50yZnKkRtDUdPVzokenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152398; c=relaxed/simple;
	bh=vpH0pYsANN4c00OrUfWi+PZOVMKfI4W7qX0aL1xDh7A=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=rSzYkSl+0VDiOHce9ox67vFERIxHyEU6lWfr5nJZ93kkysX6qfA0+oV4k+FSBdR3RP7AXBLjjTBHoZhPLvqRuzRND9xTr3tLHT0k4LhE09GsXJvAPk4m1hQOhgPTXhrnZpPtKCJ4Su4QzjHgQnu9OgJ1eN86snhermXX236hQ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofx72Ccr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66F6C433C7;
	Mon,  5 Feb 2024 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707152397;
	bh=vpH0pYsANN4c00OrUfWi+PZOVMKfI4W7qX0aL1xDh7A=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Ofx72CcrlNo+iL/kZxDjqIEm8GBLpHfZSms8L6d9cGihyjcKDUlbi+7bnSXb6BeMj
	 KaL3eQaA5hf2mcmZgQyMsxQKpfJGbaKIX0s8ACN12RtaDcE8Ouu8eSuMy3rm8PiiB9
	 kE191GC4pYU7b+te4lYWIhtCtU5C04qNB93LWZVYTQjyfEbZpejG7lpVV7tUjwMjmV
	 /Q9V/SlsTo6730JrBKPo+PZoGxBfaY5/Ypm97qCOVpIhHo5v/40YrqV8wP1EfxsTnx
	 I3f1xqbR4to3u4wPiF2T48AfT0c9cKPgpui2G4SbQsac60egnIcsYhm3RxDA/YjsWy
	 XLeRUoV7FdXQQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: enable 802.11 power save mode in station
 mode
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240201035830.2534-1-quic_bqiang@quicinc.com>
References: <20240201035830.2534-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170715239486.1233901.2285678954428449426.kvalo@kernel.org>
Date: Mon,  5 Feb 2024 16:59:56 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> To reduce power consumption enable 802.11 power save mode in
> station mode. This allows both radio and CPU to sleep more.
> 
> Only enable the mode on WCN7850, other chips don't support it
> for now.
> 
> To test that power save mode is running, run below command and
> check there is no NULL Data frame seen by a sniffer:
>         iw dev <inf> set power_save off
> 
> And run below command, then check there is a NULL Data frame
> in sniffer:
>         iw dev <inf> set power_save on
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

54ca3308a23c wifi: ath12k: enable 802.11 power save mode in station mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240201035830.2534-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


