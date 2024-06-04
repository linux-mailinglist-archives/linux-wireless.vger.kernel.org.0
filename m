Return-Path: <linux-wireless+bounces-8470-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B138FAC8D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 09:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A355A2830F0
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D94142E93;
	Tue,  4 Jun 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFPpeap3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74911142E8E
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487560; cv=none; b=lWTzfWeE81sERAxdjeK63Y+YTxYvaHFTO+u8WPdbBQrWxTTDksXAZ2E52sZ8DSSGYNGk59TtIsCQKb9VozcPj7QIJJQys2zJTXxi/Qi7vvsb9xJoet5xTkCngDQ+e5Ou7P9qntjsoSs+NZ5laGqcpZ6r0NqB/CeNbFPT0Mi/wDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487560; c=relaxed/simple;
	bh=2lGmMm8DSovfPgFh9pmoXTxiS0kIvkJg7OEmsPbxWm8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Igb8ekS0KaQFVA7j1Ji2fnRPVyaOVZSv2N4I4EX9Zdl89T0demNEcD0T0Ol73jgm51GMWmJTOKlG8CfahjTnl3rcVzJxXCscSONbVKK7MWw1FXFN/Tepu4sVGa97vB0R2TIDErU0rKCnp5Qgo14C2wFDrlcdWZ7SIf8zd71tHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFPpeap3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ABCC2BBFC;
	Tue,  4 Jun 2024 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487560;
	bh=2lGmMm8DSovfPgFh9pmoXTxiS0kIvkJg7OEmsPbxWm8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gFPpeap3y2u6Pa3EELDASSiLnlXXCgEx5IwB4fS4sOu8I5nRL4ghVJrPbmliogtD3
	 yJzxnZiNMSLT1PiEgHnpP03ChVxyJX8Doqn6UaIix9dX0TyT08ryEqybv6D8yJhjer
	 o94dHGgmBrCJEFhz6GQtY+LYlgJxRQ7pl5N9aafEQSTPs4UL+llKfkNzKL5fIZuk9/
	 E9ZvdxCV7+ItcBDOXLEJg1gptb48a2If+C6gujxemlCjTiujoY5QQYW5NftOFX2vT6
	 +WFL5axyNFwJZ4X7SvBXmWi/KU3s8sF2xUvMxSBbuSEaMYa5C6QHuOT1zgor0j7140
	 f/2hYfdgvaFCw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: Add firmware coredump collection support
References: <20240531064019.3687581-1-quic_miaoqing@quicinc.com>
	<75f1a3ae-c1ca-46a6-b38f-b0eb1fa3bdb2@quicinc.com>
Date: Tue, 04 Jun 2024 10:52:37 +0300
In-Reply-To: <75f1a3ae-c1ca-46a6-b38f-b0eb1fa3bdb2@quicinc.com> (Jeff
	Johnson's message of "Mon, 3 Jun 2024 15:59:38 -0700")
Message-ID: <87sextta9m.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/30/2024 11:40 PM, Miaoqing Pan wrote:
>> In case of firmware assert snapshot of firmware memory is essential for
>> debugging. Add firmware coredump collection support for PCI bus.
>> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
>> format and also pack various memory shared during QMI phase in separate
>> TLVs.  Add necessary header and share the dumps to user space using dev
>> coredump framework. Coredump collection is disabled by default and can
>> be enabled using menuconfig. Dump collected for a radio is 55 MB
>> approximately.
>> 
>> The changeset is mostly copied from:
>> https://lore.kernel.org/all/20240325183414.4016663-1-quic_ssreeela@quicinc.com/.
>> 
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04358-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> 
>> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>
> Kalle, I don't have hardware to validate this, so hope you can do so.

Yeah, I have a WCN6855 test box so I can run some tests. Thanks for letting me know.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

