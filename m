Return-Path: <linux-wireless+bounces-2274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D816832E74
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 18:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F40B20F46
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4038954BE2;
	Fri, 19 Jan 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maCrIHqR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132AE4C3D4
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705687057; cv=none; b=fjEDK8YcJyEKSU7oD6cMDSkDBPCC5FPLlWfICsjMppAwzLygW7RzCbhoo5ZbCCQ45wJXyVbv80fHY0bzamrySflxGuyq0igWtjf7jbWuZQiA0aLuwwgDJcMdao1seesGQh/pFApIw5wYdBEes6afxELSyUF3cqG+5ea6jK3jrvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705687057; c=relaxed/simple;
	bh=glpfq4hbtmxDnxhNCbJl2gUxB9QM02op/pILNZ0Ylu4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pO062g2vfucyyrpoIwsCUeVa7U4+4GtTLKenQYj76F3V2sUlv/UaUXWlJIHw6H+7kiqp0kPeRNkwCEtX9Mqv9UCqAZ+tExZU6qttTErAkAZ6XKXi8th8hBLifQy+aDyWswHaW8A6e7C8jrjbHFcQXPcGNYZYpkqvDJHovlKX0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maCrIHqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712C0C433C7;
	Fri, 19 Jan 2024 17:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705687056;
	bh=glpfq4hbtmxDnxhNCbJl2gUxB9QM02op/pILNZ0Ylu4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=maCrIHqR24O988odrnn7jwbVzCa6G8tnsFuwBgPWbHbCfyGh6C7Wu5dId0x46WT7B
	 geMVEnqref7lKhJfZIkSNhC3zFS/Jxa1c3QI73JIF2ofh0/nNNpmG4nA+6qCdw/x2b
	 TiNAIk2Pa89/BDF/CUBs9Ph1Nsq8eJohS1YdPcsTppqtYUZ91v2UcLhdjzY6tZNNYV
	 L0e5ZOYXJlM7SZ6TFQYkeUSGY2hl5j2u56GIbNhaVoX9AojLuF29FF2K/yTE+gc6y5
	 Mrwg6jlreWcu8Cogq41JV+zVCwQmVzfdHbjvAjzg48xVN1FQ4lvq+NLUNaDrcyfg2a
	 HzbkVWTEPZdFg==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
  linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org
Subject: Re: ath11k and vfio-pci support
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<8734v5zhol.fsf@kernel.org>
	<87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
	<87r0ipcn7j.fsf@kernel.org>
	<356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
	<26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
	<87mstccmk6.fsf@kernel.org>
	<df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
	<8734v4auc4.fsf@kernel.org>
	<e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
	<285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
	<4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
	<3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
	<ee0280fd-032c-4f45-a3f9-50d96d8bed6d@gmail.com>
	<16cfd010-b62d-4385-92d1-002820a8db38@quicinc.com>
	<cdec259a-b779-4856-8585-f285179e3671@gmail.com>
	<21e925bc-ee3e-4421-949b-b3839d2abdef@quicinc.com>
	<08457e37-49f4-4c51-998b-e577731c8022@gmail.com>
Date: Fri, 19 Jan 2024 19:57:33 +0200
In-Reply-To: <08457e37-49f4-4c51-998b-e577731c8022@gmail.com> (James
	Prestwood's message of "Fri, 19 Jan 2024 09:52:19 -0800")
Message-ID: <87o7dh2oky.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Prestwood <prestwoj@gmail.com> writes:

>> Sorry I should have made it clear:
>> step1: start qemu and load ath11k without changing anything, then
>> you get those errors;
>> step2: keep qemu running and ath11k there, don't unload it. Then
>> check lspci output in host to get the MSI vector.
>> step3: Back in qemu, hard code MSI vector to the one you get in
>> step2, then rebuild and reload ath11k.
>
> Thank you for the clarification, this worked like a charm!

Very nice, huge thanks to Baochen for finding the workaround! James, let
us know how it works for you in the long run. This would definitely help
automating ath11k testing so I'm very interested about this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

