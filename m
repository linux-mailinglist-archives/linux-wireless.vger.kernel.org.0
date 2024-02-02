Return-Path: <linux-wireless+bounces-3027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BAE847028
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0BB2969F2
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC95114078A;
	Fri,  2 Feb 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxHw0ool"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913813D50F
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876460; cv=none; b=DUdAkSX4FlUwSMqmif6jSLnlgrqH7n6DppQQNn5bTEEZ+mMr1Sv1yY5pivMMzLkL0BV1Tha3X8nWBX7x4GAxbZm2EM6+DE/STAvRhkMPBi55nFbwUySaL+4upb44ILeMVwxmhp0E05+DzZSab5+GcdeBBGhfvwxNt+GjxG6Vn+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876460; c=relaxed/simple;
	bh=OaamQbuXmp+aUnngrzGO74ZKOK+42U6K3zZz1020izA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gggWU19WMymfps5/YyUGoEvK3FxMkEtylKWgdu2OUMeV5ox+TYC1oP02iKkM6a4scXNF9Wp35tPcD4vePM1qR+6kBYDsWAF8vBRAzcDIZuzYerhjKrabeax3WzisQjAu864MJCHJf6U8Ee2GWeR2tpqDBaT8ZqbV5Ssdhi+myoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxHw0ool; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E476FC43390;
	Fri,  2 Feb 2024 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876458;
	bh=OaamQbuXmp+aUnngrzGO74ZKOK+42U6K3zZz1020izA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VxHw0oolisN9YC6A9fNC6A1oGfYmbnjyAfYk8qGNA3gVAxj8DLzRGL/nnXSDDjXsm
	 ea9H1J+sGgTh/Hma6p3SvCZR0mmJH7lUJ7N1KQ+8SQ1aLwaiQ2hw6sp0BwDOe9Hm4b
	 rgMdEAhUH4AgHvFqhJQoMjymgRBrvI9/gheHvQF2KTQaI/bP13rgmZw6CWycUyOeLP
	 1w8wk2gP+FaXqalH+lE42LzT1yRo1rzwRl1nxD4euKp386CnA9xaSVY5rHH8dZIVb5
	 7ajD1PwcdybzyLG0kJibiL+ktXHYzh+V3uYfAi88ISOe1OHavZe8e5QymDEegjEF42
	 h2u/F4zmlpXjw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  P
 Praneesh <quic_ppranees@quicinc.com>
Subject: Re: [PATCH v3 05/13] wifi: ath12k: Add logic to write QRTR node id
 to scratch
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
	<20240129065724.2310207-6-quic_rajkbhag@quicinc.com>
	<b7a6ad2c-7f28-4758-921e-f77b56b5190e@quicinc.com>
Date: Fri, 02 Feb 2024 14:20:54 +0200
In-Reply-To: <b7a6ad2c-7f28-4758-921e-f77b56b5190e@quicinc.com> (Jeff
	Johnson's message of "Wed, 31 Jan 2024 13:06:28 -0800")
Message-ID: <87il37t5uh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/28/2024 10:57 PM, Raj Kumar Bhagat wrote:
>> From: P Praneesh <quic_ppranees@quicinc.com>
>> 
>> Currently only one MHI device is registered successfully on platform
>> having two or more identical MHI devices. This is beacuse QMI service
>> runs with identical QRTR node ID. And, qrtr-lookup cannot register
>> more than one QMI service with identical node ID.
>> 
>> Hence, generate a unique QRTR instance ID from PCIe domain number and
>> bus number. QMI allows node id to be written on scratch register.
>> Add logic to write QRTR node id to the register. It is available for
>> firmware to uniquely identify an instance.
>> 
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> 
>> Depends-On: wifi: ath12k: add firmware-2.bin support
>
> I would not expect this information to be part of the final commit text,
> but I suspect Kalle can remove it when it goes into the pending branch

Yes, I removed Depends-On. In the future, please add it to the cover
letter or, if there's no cover letter, after "---" line.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

